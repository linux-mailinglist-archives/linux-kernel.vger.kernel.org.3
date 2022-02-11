Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9576F4B28A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351203AbiBKPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:00:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347642AbiBKPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:00:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83094;
        Fri, 11 Feb 2022 07:00:50 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:00:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644591649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2y+f/PlEGLyXHGYefYjugY5xqXR73+rfTyGRU7HB6M=;
        b=lNiIKvM/Mw+4nkrAyCpS4jaT6Qe0ktX6oKwQVEGTzHzMdYxAd8drEa8PEaLCIMuNhL56Ky
        wWDhi17uOujpsg0bkoZFsHJPHapk80qdVQ8r025td7FGa+zyTOCV1YlycrPIMg/XLYvD0H
        H9o/vp3Ss6firmOLX7o0QorQZClfiZrL1xbSJm89eTpiqzHRMTD7YLsJjFnU3q023riU5K
        Dc6ppV9A+teT04XzqybOlravXhGAzQMEjztLALZLaWowuQjN24JQC5yIQ8KQGrYDWQsT/k
        AEKckE+qsXf2ZPWsSPhFVSSXFVxxlWCvDQvMawB9XIejNS9rIaJHkMQl36I6NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644591649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2y+f/PlEGLyXHGYefYjugY5xqXR73+rfTyGRU7HB6M=;
        b=UXnTfJSuPkh0kVNveU7N+JIcWle/sGh+2P1lEb5tdW/odRa6El2+kz08Ci8v03OcLHLFcy
        ysnSx41nIUWTGQAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v5] random: defer fast pool mixing to worker
Message-ID: <YgZ6IEbiDgz5X1ON@linutronix.de>
References: <20220211130807.491750-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220211130807.491750-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 14:08:07 [+0100], Jason A. Donenfeld wrote:
=E2=80=A6
> +static void mix_interrupt_randomness(struct work_struct *work)
> +{
> +	struct fast_pool *fast_pool =3D container_of(work, struct fast_pool, mi=
x);
> +	unsigned long pool[ARRAY_SIZE(fast_pool->pool)];
> +	unsigned int count_snapshot;
> +	size_t i;
> +
> +	/* Check to see if we're running on the wrong CPU due to hotplug. */
> +	migrate_disable();
> +	if (fast_pool !=3D this_cpu_ptr(&irq_randomness)) {
> +		migrate_enable();
> +		/*
> +		 * If we are unlucky enough to have been moved to another CPU,
> +		 * then we set our count to zero atomically so that when the
> +		 * CPU comes back online, it can enqueue work again. The
> +		 * _release here pairs with the atomic_inc_return_acquire in
> +		 * add_interrupt_randomness().
> +		 */
> +		atomic_set_release(&fast_pool->count, 0);
> +		return;
> +	}
> +
> +	/*
> +	 * Copy the pool to the stack so that the mixer always has a
> +	 * consistent view. It's extremely unlikely but possible that
> +	 * this 2 or 4 word read is interrupted by an irq, but in case
> +	 * it is, we double check that count stays the same.
> +	 */
> +	do {
> +		count_snapshot =3D (unsigned int)atomic_read(&fast_pool->count);
> +		for (i =3D 0; i < ARRAY_SIZE(pool); ++i)
> +			pool[i] =3D READ_ONCE(fast_pool->pool[i]);
> +	} while (count_snapshot !=3D (unsigned int)atomic_read(&fast_pool->coun=
t));

Which what I wrote in the last mail, can't we just have a cmpxchg loop
here?

Sebastian
