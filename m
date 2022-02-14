Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D604B5304
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355026AbiBNORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:17:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiBNORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:17:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8424949F9E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:17:34 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:17:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644848252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7th9FPBhTHINqz3uRpqzV8a/eogAXrdqgX5F7Ju6E4=;
        b=ouyZslNgbCuTOkK5kZzEjR79vs+1sbKGDhHknUnUtfolGUAAK5mi3QDYVA0RvkfuLEqzx9
        o4jeEnF1TaLbZ9G/tVdBB1iUlOuDMCzAnNlxbV59/Gpk3oRve/bcCgt7lWiy6O0S91xDnR
        Q1+qqrrI/1FcQbSVKQOvigvmr2epR8EQsjsHmt3phRRMXGzdG7LhqHzeg5xitvXivyfqSG
        95E0i38yjwmGxlK625cMEeDV2XewMi5PU+MOy3Od+5FohK69m6i6+m9TRCUFVuiB+hy8Di
        uhyBNCk5bXEeo8pmb/GUCHgQ8R23+0GyycCo0yYTpIra2/HZzqCyZrTQyuWLGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644848252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7th9FPBhTHINqz3uRpqzV8a/eogAXrdqgX5F7Ju6E4=;
        b=HMbr81cK/bM5Rma33KsSoWPqO5rAZbWP/gdg1G66LvgMfYG+LXnzPcl5lSa27NyB8nU0+c
        TZj/rp7bFIx5A8AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: set fast pool count to zero in cpuhp teardown
Message-ID: <Ygpkej/vnMvUDIlP@linutronix.de>
References: <CAHmME9rAnh6nSRNYo56Ty6VSrY17ej35AoNkSjunFO0AQp1D9Q@mail.gmail.com>
 <20220214133735.966528-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220214133735.966528-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 14:37:35 [+0100], Jason A. Donenfeld wrote:
> Rather than having to use expensive atomics, which were visibly the most
> expensive thing in the entire irq handler, simply take care of the
> extreme edge case of resetting count to 0 in the cpuhp teardown handler,
> after no more interrupts will arrive on that CPU. This simplifies the
> code a bit and lets us use vanilla variables rather than atomics, and
> performance should be improved.
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Sebastian -
>=20
> v2 moves the teardown to CPUHP_OFFLINE=E2=80=A6CPUHP_BRINGUP_CPU, per our
> discussion.

My suggestion was to move it to the startup handler with the code
snippet I had.
As I tried to explain, this may have two problems:
- worker scheduled during CPU-UP before CPUHP_AP_WORKQUEUE_ONLINE are
  probably unbound.

- worker scheduled during CPU-DOWN after CPUHP_AP_WORKQUEUE_ONLINE are
  probably unbound.

The unbound worker may run on any CPU and thus do nothing.
In the CPU-DOWN case before: should we rollback before
CPUHP_RANDOM_PREPARE but after CPUHP_AP_WORKQUEUE_ONLINE then the needed
reset (in case the worker did nothing because it was on the wrong CPU)
will not happen.
Therefore I think, moving it to startup, online, (as suggested in
https://lore.kernel.org/all/Ygo3%2FpuhZFpuX91x@linutronix.de/).

will not have any of this downsides/ corner cases.

Sebastian
