Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A6E4BC476
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiBSBNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:13:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiBSBNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:13:42 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF12271E32
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:13:24 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2d646fffcc2so83815387b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KuPVvHcGH6XYHC2N1vXONOOOdChkI1tr3mh5lR/eBf4=;
        b=wgnQ1QfNOWXTz4uyN+xiZtl15SgO0HNRAwhITVZN3qh+opHwJxxylfyJ4agegmEm7q
         ypeXRgg8OIq+yFa6wcZMLvJz/DD3FGv/2VuhSsgy/05eAO0sWhyVgkYbqORqp7UlA6ah
         xaoOSiu3/0lf1CZ7jcGzchRlzJ+Qa13DqeQ8K7Tzb1aKoq6I/DE2W4vmyEn/1CzU2vda
         i4aRw+CcvOhdQt+5WbglFSba8rVwdWFfa8oY2ZRKQGY0PbOPNB1TPp6GvYIChnGNXtm0
         fzBXd3A/fv3aZFc6RFQI8jlqNU3HbKVbkU9YbHKpVgRCzf8ZTyi6fbwn4xAJaoAD8c3B
         iKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KuPVvHcGH6XYHC2N1vXONOOOdChkI1tr3mh5lR/eBf4=;
        b=M0IL2DikLZEacLmoIgAebvzi5NGKuGLQQmoPmTrbAM5QxIUzcUJsL3Psj1uJZYQz6H
         f1hqgxirvD0guK/T/7dUl/3N8acnQoucBnp3veT+8mZjl/tU5TKgpx1J4X8Z0VIcYfzm
         5mDGqFfmLkM5yb//R9PxVl7Bzx2HGUjoaqfw50FmRaBBd0T490g7G09YQ2k7sNfMwhap
         ZGbEJFXtJ1RDcGw4juNZh36wy1TsIF6kl/yxOVOtbCZwxUko2gFUBPLH/NzqA5XDsEr6
         y1gMEEaWvCBUWnPje5KElW2IoWm7bFcK6PNO0HxrM9uaIuEzkaSFc+jST1C8RtOozkd6
         WqBA==
X-Gm-Message-State: AOAM531KeiKgGiqkRJmxm1RP2q624+j+CMHE9ZXY6M5rw+41799cS/+Y
        p903qX4eBIgeZNcrC1YxNkVpjfoW+GIEF8eZ1qULIA==
X-Google-Smtp-Source: ABdhPJzjyhB275ObWFDUHntgtZfPqGSF0Q4EBsTUNbfD6yhytEp18TB8NqastVWOd/xKaerf5ut9BWf7BQISC3fMQyU=
X-Received: by 2002:a81:f92:0:b0:2d0:5383:7ca with SMTP id 140-20020a810f92000000b002d0538307camr10383384ywp.268.1645233203766;
 Fri, 18 Feb 2022 17:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20220216040037.22730-1-samuel@sholland.org>
In-Reply-To: <20220216040037.22730-1-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 02:13:12 +0100
Message-ID: <CACRpkdZ1nFAmzRvsvKvZ08fsP_MgsnsiNpD7LdRRXUDWtO_w=Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Use unique lockdep classes for IRQs
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 5:00 AM Samuel Holland <samuel@sholland.org> wrote:

> This driver, like several others, uses a chained IRQ for each GPIO bank,
> and forwards .irq_set_wake to the GPIO bank's upstream IRQ. As a result,
> a call to irq_set_irq_wake() needs to lock both the upstream and
> downstream irq_desc's. Lockdep considers this to be a possible deadlock
> when the irq_desc's share lockdep classes, which they do by default:
>
>  ============================================
>  WARNING: possible recursive locking detected
>  5.17.0-rc3-00394-gc849047c2473 #1 Not tainted
>  --------------------------------------------
>  init/307 is trying to acquire lock:
>  c2dfe27c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
>
>  but task is already holding lock:
>  c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&irq_desc_lock_class);
>    lock(&irq_desc_lock_class);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  4 locks held by init/307:
>   #0: c1f29f18 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x90/0x23c
>   #1: c20f7760 (&dev->mutex){....}-{3:3}, at: device_shutdown+0xf4/0x224
>   #2: c2e804d8 (&dev->mutex){....}-{3:3}, at: device_shutdown+0x104/0x224
>   #3: c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x58/0xa0
>
>  stack backtrace:
>  CPU: 0 PID: 307 Comm: init Not tainted 5.17.0-rc3-00394-gc849047c2473 #1
>  Hardware name: Allwinner sun8i Family
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x68/0x90
>   dump_stack_lvl from __lock_acquire+0x1680/0x31a0
>   __lock_acquire from lock_acquire+0x148/0x3dc
>   lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
>   _raw_spin_lock_irqsave from __irq_get_desc_lock+0x58/0xa0
>   __irq_get_desc_lock from irq_set_irq_wake+0x2c/0x19c
>   irq_set_irq_wake from irq_set_irq_wake+0x13c/0x19c
>     [tail call from sunxi_pinctrl_irq_set_wake]
>   irq_set_irq_wake from gpio_keys_suspend+0x80/0x1a4
>   gpio_keys_suspend from gpio_keys_shutdown+0x10/0x2c
>   gpio_keys_shutdown from device_shutdown+0x180/0x224
>   device_shutdown from __do_sys_reboot+0x134/0x23c
>   __do_sys_reboot from ret_fast_syscall+0x0/0x1c
>
> However, this can never deadlock because the upstream and downstream
> IRQs are never the same (nor do they even involve the same irqchip).
>
> Silence this erroneous lockdep splat by applying what appears to be the
> usual fix of moving the GPIO IRQs to separate lockdep classes.
>
> Fixes: a59c99d9eaf9 ("pinctrl: sunxi: Forward calls to irq_set_irq_wake")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Patch applied.

Yours,
Linus Walleij
