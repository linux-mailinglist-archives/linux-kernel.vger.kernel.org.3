Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE547617E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbhLOTSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbhLOTSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:18:00 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639595878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWDBdE640bIMVLi/eK8XstbREIWL1tXm5Jvd5nzdPrI=;
        b=k/EqQ6tP1tn+ErDSzSZ8r95+B2viU6gMYzolsxFfB04rGZZTLnFwlLrxvbhG8twT/kcm3Y
        Ny0vtmWY28dCANCHCKVXLnnN6V1rpQ0ohvRh7jWqIoA8yC9+P66FZXE1CJiIyrteWwUdCh
        YP6JgisuWATSILVXeVJDNNicRkq65Cj3uxlKrkzy1qQ6xBPqo0+wDvulRq2SEqvW7k4j6n
        DsdL/yoA4ejrAmdxsB8VdgXRT5xh6G7gOyKVv8eeerx69yRWlrnfkpzaMLq2Sy2HKfnEqX
        gkNaoHGvQvlIldA9l7ApIH2sEUuUfroNXeneTZx7JzAjDRD0l5wd0FXTrcwD6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639595878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWDBdE640bIMVLi/eK8XstbREIWL1tXm5Jvd5nzdPrI=;
        b=jRuzfBObOtx7I0aCSEqrqlmFgGYiRa1j7krPZbh6eY2cuXemqD5S9tgod16t9rGnuOD9Qv
        81mZpv7Fd5Kl7PCA==
To:     info@engel-internet.de, linux-kernel@vger.kernel.org
Subject: Re: CLOCK_MONOTONIC after suspend
In-Reply-To: <91eaa528-9605-134e-8e38-ecc37a0360e1@engel-internet.de>
References: <91eaa528-9605-134e-8e38-ecc37a0360e1@engel-internet.de>
Date:   Wed, 15 Dec 2021 20:17:58 +0100
Message-ID: <87o85hr82h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk,

On Wed, Dec 15 2021 at 18:30, info@engel-internet.de wrote:
> dT =3D (T_KS_asleep =E2=80=93 T_US_asleep) + (T_US_awake =E2=80=93 T_KS_a=
wake) // T: point
> in time, KS: kernel space, US: user space
>
> With a simple user space program that prints out the monotonic time each
> 100ms along with the day time, I did some measurements on my notebook.
> It reveals the following discrepancies (time gaps) between the last time
> stamp written before suspend and the first time stamp after resume:
>
> dT in [s]     #1      #2      #3      #4      #5      #6      #7
>
> Suspend2RAM   6.409   6.423   7.451   3.444   7.815   5.655   7.178
>
> Suspend2Disk  5.228   2.683   5.072   5.198   4.806   5.763   6.908
>
> Is this effect known and accepted or is there some way to prevent or
> mitigate it?

there is not much the kernel can do about that.

Timekeeping can only stop at the very latest moment and has to resume
immediately when the CPU comes back. That's a matter of internal
correctness.

Yes, user space has to be frozen first in order to make that work and is
obviously unfrozen last. So the timeline looks like this:

T0        suspend is initiated
T1        user space freeze
T2        kernel shuts down    - timekeeping freeze
T3        kernel resumes       - timekeeping resume
T4        user space unfreeze

So the deltas T2 - T1, T4 - T3 are what matter for your user space
program. Those deltas heavily depend on the amount of drivers,
outstanding disk operations etc. So your milage will vary.

Thanks,

        tglx



