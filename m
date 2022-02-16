Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F98B4B8DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiBPQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:24:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiBPQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:24:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B722BDE5;
        Wed, 16 Feb 2022 08:24:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q7so4302367wrc.13;
        Wed, 16 Feb 2022 08:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTt4zeXioXEAgxKFKddjzAm61xpJtbPPtey6Dl+FS3k=;
        b=ey0ZisKjo0VUrCt+QgQ5aTTg3uYAEHOkAAyA4ZLtfJrcpAvN4jE/WWE5R+2FjGyTOh
         5WB+dEERzKJ9PP1AB7VnD5GC7LUwmDT6tXCoebohWVYfgR3UrxeJWcX/kn0Ucbx4pr19
         kdB159p78FAC3id+SKA+RsB5WKJAY1VzqiLonURGM0ueXop6+0oR3Z9OVwULTWieRMht
         aKpeB7r43tAVDF0fd9ZupN2rCSy7y+c9lrv42nZqWNOou1cU1FlhRon2OcknfJCiFl3m
         hwf+1m1UeiOibaVpHQzlyWQ9Xl6Sj0tltYg4NROJxTp8yYHo3KxrBNeq8XJyO5K9uQIh
         tKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTt4zeXioXEAgxKFKddjzAm61xpJtbPPtey6Dl+FS3k=;
        b=2kRHVtW/A67ugi+HuJ6HfaV7HYsZcrH4UFAslSzOjliWhsw4nAdzC/eaDPMj1haCzb
         IP7N0BY0hDIHTdneni9yzE2KSP8cgVLo7sKzYwchZ9v/uTbZwPCwsg+Dm/CBlOaYk71v
         +VaHMC7jxzGND/2Gjprk1kz/Gg83eK6k32CxujfW4LfoWvkBF88583fGCyZSpFsnpqpg
         Y07zUHrndlpud+N5/z0KsoPbIvvegLEqUgNy4k+R3OV2oZh4h0YMq6YVzgf1EvRYThk2
         zyZXSbdgcpQMSZkikhUDXWzlrC2BgWhhxeT+bHoN9uRu+p5+sQWD7oIPp+1GizOjchqo
         H5Tw==
X-Gm-Message-State: AOAM531woU6+Ma7ZC+MLDlF/sN7GoU3NQ0R8oXZKXDlCSRqOIg2FHnoD
        bOh9BpI93JLit6TuJE5eGZo=
X-Google-Smtp-Source: ABdhPJybP1sGjhuU7xFxJ/hdGk6c3ciueolCbzgSKOnfdRNTzSTOlyjrNfEHjVEgXBPH9+awuTPhkQ==
X-Received: by 2002:a5d:4d0c:0:b0:1e3:364a:c95f with SMTP id z12-20020a5d4d0c000000b001e3364ac95fmr2979281wrt.115.1645028640578;
        Wed, 16 Feb 2022 08:24:00 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id f25sm18305054wml.16.2022.02.16.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:24:00 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        linux-gpio@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] pinctrl: sunxi: Use unique lockdep classes for IRQs
Date:   Wed, 16 Feb 2022 17:23:59 +0100
Message-ID: <2091402.irdbgypaU6@kista>
In-Reply-To: <20220216040037.22730-1-samuel@sholland.org>
References: <20220216040037.22730-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Dne sreda, 16. februar 2022 ob 05:00:36 CET je Samuel Holland napisal(a):
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
>  c2dfe27c (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x58/0xa0
> 
>  but task is already holding lock:
>  c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x58/0xa0
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
>   #0: c1f29f18 (system_transition_mutex){+.+.}-{3:3}, at: 
__do_sys_reboot+0x90/0x23c
>   #1: c20f7760 (&dev->mutex){....}-{3:3}, at: device_shutdown+0xf4/0x224
>   #2: c2e804d8 (&dev->mutex){....}-{3:3}, at: device_shutdown+0x104/0x224
>   #3: c3c0ac7c (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x58/0xa0
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

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


