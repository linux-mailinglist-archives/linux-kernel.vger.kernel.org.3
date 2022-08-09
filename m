Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5258D76C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbiHIKbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiHIKa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:30:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE92617
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:30:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pm17so11266348pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=5ovt8/QZAoMmQXQbQfo/yLHAFahxdESaqCii5x6b6pk=;
        b=ibzk/JokCNIE30OAGczumz5A/LqXuQeJhIcJAARbbsuLVmjvD4sdbeARgzLhbzmo9x
         ADUJDYD+qTg5VFiKM+KtWKgDOInoQp13yKe5m5VXauc8UzSryvcuUfBlBVxt3vxsVDpv
         WdRTkwIF9ZuN0O+9GsBWKRt09CIDgpCF9ec+IT8QAmH9CKJznwMvHdBZKYAlcJMLfHGP
         uhiurRv2Alj59aO/ySTv0ocFiKAhb08oiSd3hBjHUyGAO4FuVboIMUfr/Z/4LqqaWc2c
         R+00J7M6iVdn3Bhe7FVKbNoFDKBTEdgk85Ioi/9sOxbGBPb42ZqwQxgbUZL4Yl/gS75/
         q0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=5ovt8/QZAoMmQXQbQfo/yLHAFahxdESaqCii5x6b6pk=;
        b=tiqprsNLpVwrFoKa3arhrklzp8yJO8MUdYcJQrDT6zz8/hrp0zK3hada2zqULowbMq
         8+qUqklilGRRT+hw2gSm8OziKHuXev94FXwH0rkJv2D4feYoF3K4xfWSC56DoLzPFic1
         nQOsaYviHWB2bJ3E5abUZjVcNOcptczKxRgCqTv7M21lnNxDM4yXsCclS3chhRlNcjSq
         AMLuL3QKZVQ0THLUA/zo6Qf4XOc5JqJdfYTLTTUt23ik36HtxOqUJ8d5HAQsUzNWj2fq
         kdbbHTXSN/JoEc+1CDnfOoeYC/GolW9eNm+VccVNbwady9LBCFXUJLi9QLdnNoq5FDfx
         XBVQ==
X-Gm-Message-State: ACgBeo1ME/7soOEWpm13XKpmgoFrpIV/ZEmx3O915wpjqOZlMC+m81U+
        qlcLj2WNjJS5h3Oc7puXVko=
X-Google-Smtp-Source: AA6agR7BhyIwavdorJySXp4BFK6hJL2aUWoO9KAOmENiwOvMNeZD2cOccIrqUAMci2WJM2C0Jled9w==
X-Received: by 2002:a17:902:7c05:b0:16d:2c63:da90 with SMTP id x5-20020a1709027c0500b0016d2c63da90mr22437241pll.27.1660041056287;
        Tue, 09 Aug 2022 03:30:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k132-20020a62848a000000b0052e57ed7d1dsm10189901pfd.209.2022.08.09.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:30:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Aug 2022 03:30:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Message-ID: <20220809103052.GA1778649@roeck-us.net>
References: <20220727181936.3250466-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727181936.3250466-1-saravanak@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 27, 2022 at 11:19:35AM -0700, Saravana Kannan wrote:
> The uevents generated for an amba device need PID and CID information
> that's available only when the amba device is powered on, clocked and
> out of reset. So, if those resources aren't available, the information
> can't be read to generate the uevents. To workaround this requirement,
> if the resources weren't available, the device addition was deferred and
> retried periodically.
> 
...

This patch results in a large number of crashes in various qemu
emulations. Crash and bisect logs below. Reverting this patch
fixes the problem.

Additional information: The decoded stack trace suggests that the
"id" parameter of pl011_probe() may be NULL.

Guenter

---
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000008
[00000008] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0+ #1
Hardware name: ARM-Versatile (Device Tree Support)
PC is at pl011_probe+0x40/0x110
LR is at amba_probe+0x10c/0x19c
pc : [<c059847c>]    lr : [<c055ac9c>]    psr: 60000153
sp : c8811e00  ip : 00000000  fp : c1959ef8
r10: c7ef55f8  r9 : fffffdfb  r8 : c0d77af8
r7 : c1959c00  r6 : c1959c00  r5 : 00000000  r4 : 00000003
r3 : c14191a4  r2 : 00000dc0  r1 : 00000198  r0 : c1959c00
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 00093177  Table: 00004000  DAC: 00000053
Register r0 information: slab kmalloc-1k start c1959c00 pointer offset 0 size 1024
Register r1 information: non-paged memory
Register r2 information: non-paged memory
Register r3 information: non-slab/vmalloc memory
Register r4 information: non-paged memory
Register r5 information: NULL pointer
Register r6 information: slab kmalloc-1k start c1959c00 pointer offset 0 size 1024
Register r7 information: slab kmalloc-1k start c1959c00 pointer offset 0 size 1024
Register r8 information: non-slab/vmalloc memory
Register r9 information: non-paged memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: slab kmalloc-1k start c1959c00 pointer offset 760 size 1024
Register r12 information: NULL pointer
Process swapper (pid: 1, stack limit = 0x(ptrval))
Stack: (0xc8811e00 to 0xc8812000)
1e00: 60000153 00000009 c1959c00 00000000 c0d77af8 c055ac9c c055ab90 c1959c00
1e20: 00000000 c0d77af8 00000000 c1898d40 c180e158 c0cd8848 00000000 c05fbfe4
1e40: c1959c00 c0d77af8 c1959c00 00000000 c1898d40 c05fc250 c14195c4 60000153
1e60: c1959c00 c05fc2f8 c180e158 c0cd8848 00000000 00000000 c1959c00 c0d77af8
1e80: c0d72b98 c05fc704 00000000 c0d77af8 c05fc694 c0d72b98 c1898d40 c05fa0b4
1ea0: 00000000 c19458ac c1957eb4 c0cfb86c c0d77af8 c180e100 00000000 c05fb2ac
1ec0: c0bc2310 c0dad240 c1898d40 c0d77af8 c0dad240 c1898d40 00000000 c1898d40
1ee0: c0dbb000 c05fd258 c0cc55c4 c0dad240 c1898d40 c000a8b0 00000000 00000000
1f00: c18dbe47 c0c6cc00 00000137 c00488a8 c0c6b418 00000000 c0dad240 c0953980
1f20: c1898d40 00000003 c0dad240 c18dbe00 c0cd8864 c0c6b418 c0dbb000 c0cd8848
1f40: 00000000 c0cfb86c c0cf16a4 00000004 c18dbe00 c0cd8868 c0c6b418 c0ca5230
1f60: 00000003 00000003 00000000 c0ca4400 00000000 00000137 00000000 00000000
1f80: c0953c48 00000000 00000000 00000000 00000000 00000000 00000000 c0953c58
1fa0: 00000000 c0953c48 00000000 c00084f8 00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
 pl011_probe from amba_probe+0x10c/0x19c
 amba_probe from really_probe+0xb4/0x2a0
 really_probe from __driver_probe_device+0x80/0xe4
 __driver_probe_device from driver_probe_device+0x44/0x108
 driver_probe_device from __driver_attach+0x70/0x110
 __driver_attach from bus_for_each_dev+0x74/0xc0
 bus_for_each_dev from bus_add_driver+0x154/0x1e8
 bus_add_driver from driver_register+0x74/0x10c
 driver_register from do_one_initcall+0x8c/0x2fc
 do_one_initcall from kernel_init_freeable+0x190/0x220
 kernel_init_freeable from kernel_init+0x10/0x108
 kernel_init from ret_from_fork+0x14/0x3c
Exception stack(0xc8811fb0 to 0xc8811ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e8bd81f0 e3a02d37 e3a01f66 e1a00007 (e59c8008)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
Reboot failed -- System halted
qemu-system-arm: terminating on signal 15 from pid 952897 (/bin/bash)

---
# bad: [c8a684e2e110376c58f0bfa30fb3855d1e319670] Merge tag 'leds-5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds
# good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect start 'HEAD' 'v5.19'
# good: [12b68040a5e468068fd7f4af1150eab8f6e96235] Merge tag 'media/v5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 12b68040a5e468068fd7f4af1150eab8f6e96235
# bad: [5f0848190c6dd0f5b8a2aaf0f1d900a96d96bee0] Merge tag 'platform-drivers-x86-v6.0-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
git bisect bad 5f0848190c6dd0f5b8a2aaf0f1d900a96d96bee0
# good: [798cd57cd5f871452461746032cf6ee50b0fd69a] drm/amd/display: restore code for plane with no modifiers
git bisect good 798cd57cd5f871452461746032cf6ee50b0fd69a
# good: [723c188d5cd42a07344f997b0b7e1d83b4173c8d] Merge tag 'staging-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 723c188d5cd42a07344f997b0b7e1d83b4173c8d
# good: [a4850b5590d01bf3fb19fda3fc5d433f7382a974] Merge tag 'kvm-s390-next-5.20-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
git bisect good a4850b5590d01bf3fb19fda3fc5d433f7382a974
# bad: [8d9420ca9bd9bceddcfab3d0263d6a8e073396fe] Merge tag 'for-linus-2022080201' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
git bisect bad 8d9420ca9bd9bceddcfab3d0263d6a8e073396fe
# good: [31f6e3832a0f1c366e54033335aed2375f6e447a] KVM: x86/mmu: remove unused variable
git bisect good 31f6e3832a0f1c366e54033335aed2375f6e447a
# good: [7df9075e232e09d99cf23b657b6cb04c9506e618] Merge tag 'csky-for-linus-6.0-rc1' of https://github.com/c-sky/csky-linux
git bisect good 7df9075e232e09d99cf23b657b6cb04c9506e618
# good: [c556717541c0c34bff887db92057964f0ff74582] Merge branch 'for-5.20/amd-sfh' into for-linus
git bisect good c556717541c0c34bff887db92057964f0ff74582
# good: [a60885b6a97b5dc9340dd9310a57b5682c2daf2d] Merge branch 'for-5.20/uclogic' into for-linus
git bisect good a60885b6a97b5dc9340dd9310a57b5682c2daf2d
# bad: [995177a4c75ee9b9069d5a313d90c005cf89c1b2] Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
git bisect bad 995177a4c75ee9b9069d5a313d90c005cf89c1b2
# good: [b97abb4d0e23766650619a6a57a52c91deb89b8a] ARM: 9217/1: add definition of arch_irq_work_raise()
git bisect good b97abb4d0e23766650619a6a57a52c91deb89b8a
# good: [fe520635ddc4377e84f78c6cf1c54393f1dfa33b] ARM: 9219/1: fix undeclared soft_restart
git bisect good fe520635ddc4377e84f78c6cf1c54393f1dfa33b
# bad: [f2d3b9a46e0ed4742abaa00506b18bb2ca9179d8] ARM: 9220/1: amba: Remove deferred device addition
git bisect bad f2d3b9a46e0ed4742abaa00506b18bb2ca9179d8
# first bad commit: [f2d3b9a46e0ed4742abaa00506b18bb2ca9179d8] ARM: 9220/1: amba: Remove deferred device addition


