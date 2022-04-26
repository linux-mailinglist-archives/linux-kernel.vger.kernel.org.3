Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13114510AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355106AbiDZUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355032AbiDZUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:42:04 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4B9793AC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:53 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q2so4759226vsr.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfJd9A+0QWj9RbTol5Rw0Pj2t6CVgO2Un6yqTZKi1SM=;
        b=qqHQRi4aq2NvDCTC+RiF4zAZv3IsuwZr1Iaa5zU57qyOcygb47zXA8qkTO21xszuU0
         DUyEcSl3HgZsFVc1dLZFm1kLBdjg6kekUw12ZE6YIh/t17+vu6g1JZe0ktZkHO4Rh5M5
         PSe8TMaQyukTdBYuRJ2voBBujTxxWS5utDDRGMzn3W8WgKv6Pyz0nJgn82WLrsNCgATT
         5QRrBsy/aqRYINdJ/40KJiqjR4E7emxXpqnmJ6bgPsVw2I4n47Y7NOUuurA4paMU65oz
         BNfA5DOykIeCvJRIbfU+5/PozOjpomLmkyppl9SUBFcH8fG9lMgN+5Iu2vmJYnQlzRHV
         3KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfJd9A+0QWj9RbTol5Rw0Pj2t6CVgO2Un6yqTZKi1SM=;
        b=rg/zp522oKNtigkTdkSXNL4wenpo3hqgyzuhM2rEFhrtyiN0SP8rAd37qe0hsDDbh5
         yA70of1Mti5ECHQAuvXxLpEtk4P8aRIBbyKvAuaXGDXOS5P8AIsD3GU53iKkR9iCWR9q
         exECIrRsU7YWSNDdBgXYMe09+6L62gVc53Mv9OxrOGRz5Gkx/Efh/C5C33oKT/82t90W
         nFJloKx+XPhjkMoDsDzDTiah7d/wVMqTb7Apq4WzsZE/ENRIF4AtGOpd979l8L3PxZ6u
         9HcKVIEeSXvxJbrm4+myJQnMyJEj/RgYNaztcEjZQis1IayJIMoARy458XGkbdkakm28
         /1nA==
X-Gm-Message-State: AOAM531ci+sqWgkcyWTdGYo9tOhjRx/8fb8ZrXpX+sDCbm5bB8iT1yV9
        glgndRnK+1g7dT4uK3pXwOlhusgDIzTB2taJxKit
X-Google-Smtp-Source: ABdhPJwQkHaUU9ii+vNTdfepYExsOc2JJHBLTd8X+78D6DqxnogbZcYYM3kPozNJ7Yj9xC1ycRgHRnkSP4GdagdGExg=
X-Received: by 2002:a67:eb86:0:b0:32c:2036:17fe with SMTP id
 e6-20020a67eb86000000b0032c203617femr8013131vso.47.1651005532543; Tue, 26 Apr
 2022 13:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2204211556270.9383@angie.orcam.me.uk> <alpine.DEB.2.21.2204240055590.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204240055590.9383@angie.orcam.me.uk>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 26 Apr 2022 13:38:40 -0700
Message-ID: <CANDhNCrQQ5cUYzSr8pTdfbpvRrwJxWtTZxqvkGGdZiPXkfvr1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched_clock: Round the frequency reported to nearest
 rather than down
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 4:47 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> We currently round the frequency reported for clock sources down, which
> gives misleading figures, e.g.:
>
> I/O ASIC clock frequency 24999480Hz
> clocksource: dec-ioasic: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76452008078 ns
> sched_clock: 32 bits at 24MHz, resolution 40ns, wraps every 85901132779ns
> MIPS counter frequency 59998512Hz
> clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 31855130776 ns
> sched_clock: 32 bits at 59MHz, resolution 16ns, wraps every 35792281591ns
>
> Rounding to nearest seems more adequate:
>
> I/O ASIC clock frequency 24999664Hz
> clocksource: dec-ioasic: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76451445358 ns
> sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 85900499947ns
> MIPS counter frequency 59999728Hz
> clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 31854485176 ns
> sched_clock: 32 bits at 60MHz, resolution 16ns, wraps every 35791556599ns
>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 112f38a4a316 ("ARM: sched_clock: provide common infrastructure for sched_clock()")
> ---

This seems sane to me.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
