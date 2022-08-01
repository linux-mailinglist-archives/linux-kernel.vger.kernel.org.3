Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFC586CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiHAOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiHAOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:34:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEDA26AD7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:34:16 -0700 (PDT)
Date:   Mon, 1 Aug 2022 16:34:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659364454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFOMAExeeQUZnj03kTpLl/utTFCYl4+l+62DC6Nz1fg=;
        b=2XcFbEM9SxMo9YWU1tlF+IqljY/rD/e4EoHFmNBa2HLfCfgS2Azc4js7wUjO6FqotTmFjY
        qTZHEDMiT7xAqcnOk4OcsQC/3G/QX3zMO/rjtdnz2yAQkPVlaWhBIHBDFcAKATI0YlsdNh
        X/0HMH2KFUlKI3W7Z+2RVoOQaz/E9mOgrvm94s4xldR4/fTWfruuyhqFZ43OozU3Ll/G5x
        erbxjIUyoJJeJBH9xRAY5a4+Nv36iDvZmjSEjBtvogSrb4qiT6Sv+LoLH1It7g5vUsCvRs
        /1wfdpXPcCQbKddKLbCOhdLIH/mg60kHAhchqBNL9+ewNJ2ah9fs1dmtDG/q0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659364454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SFOMAExeeQUZnj03kTpLl/utTFCYl4+l+62DC6Nz1fg=;
        b=sQ7RKYZKBlpMQIZ/jZNMnb91eTHm9Nv4/Xbpo3omZ2lNWHw3qAGKaWxrcg2uEPKt8/XQaN
        PHU6W9+z9kC7HhCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <YufkZU9kGkHHUhAK@linutronix.de>
References: <20220801142530.133007-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220801142530.133007-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 16:25:31 [+0200], Jason A. Donenfeld wrote:
> After handling several bug reports using various creative solutions,
> it's becoming clear that random bytes are actually a useful thing to
> happen from any ordinary context, including when interruptsare off.
> Actually, that's been long recognized, which is why the RNG uses
> spinlocks rather than mutexes. But on RT, those spinlocks are getting
> converted back into sleeping locks.
>=20
> This clearly is causing more problems than it might hypothetically
> solve. Additionally, the locks in random.c are generally for fixed
> durations doing CPU-bound operations -- no waiting for hardware or I/O
> or the like. So this shouldn't result in a real harm to latency.
>=20
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Sebastian - I won't move forward with this without your Ack, obviously.
> What do you think of this general approach? -Jason

I would need to do worst-case measurements and I've been looking at this
just before writting the other email and there was a local_lock_t
somewhere which needs also change=E2=80=A6

So I have everything ready for 5.20 (6.0) ready without the RT patch and
then this vsprintf issues comes along=E2=80=A6
=46rom that point of view I would prefer to either init it upfront in a
way that works for everyone/ loose the first %p since it is probably a
minor inconvenience if nobody complains - instead swapping all locks.
We managed without this for kasan and lockdep which are both not used in
a production environment.

Sebastian
