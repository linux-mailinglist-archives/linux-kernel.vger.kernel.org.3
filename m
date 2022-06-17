Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D854FCB4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383467AbiFQSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiFQSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:05:19 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166281EED9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:05:18 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3176d94c236so49717367b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRsx6tWtUrc/LMBt7Ro9eEmVGTkFZYjS5XSEwg6Xnss=;
        b=NTI+iENTQ+9qMzOmscnJ3KfytjLOIBhhaBWsnw/nCqXq4E8jZ2ks0EFakxHa39xXXg
         U1ikIAeMJEROxnuiuqgknA3OV03OK1vjvLQxEzZQcUcrydhF9wAqqjaTmQQLYXs0F9H/
         RntnDYerf5rHm47iQSF4QaDVuyGG33CtoCkEktY1wB9drJ28SMTP59RfUMniKjvTDMk9
         c6xcPktzOoRWKP0vDNVoaj5L6vcz/Qs1i+rtgyF1vEIb8sWyynwCzxPuKn+tPBhjiN3P
         RCW88MI8P5qRu5YlSimU/XVb05wpgk46Mej0petSxgV/Bj9MxlEDliXMUtY/QNUV93gt
         sG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRsx6tWtUrc/LMBt7Ro9eEmVGTkFZYjS5XSEwg6Xnss=;
        b=GMj+aR9qw43rX7WsBTBH/ZHBvgWUEG60m7UyjcYXfB+yu1TZaRFDpv9TyErgH+2STW
         KHa5gF3IQ+kCJeyFrtQ84rc0mQyivQI00zK2lwxFpRjiIW0WB8yyuSCKmfOJDE1CYVPs
         u6vEHLVOc9MPh1Ff0WJyIO1WajXpCZY/bUBwnECd00OQu2lLHRVbTFgkKuHPQ+wh6LD/
         W14QLkPArPOr7jTOUNmeu+WP+Txyb+zRG1il82xonO8dS8Pt8Yit45cJE/RIwMy0U/+c
         Tdf/xaY5LTLiA1pN9kXCGY1EhSBM1F4HNYpHQshr6BTnrh5VhaxH0SEz9Dl8a+NYttJ3
         o0nQ==
X-Gm-Message-State: AJIora/Wv+N0iYXrsGAxUtaVFh9uRBCMQ/WTXrF5vfro09uKZBg5GO4/
        SOXrQbVQHzhiQZc1H+P/YWJ7dD0kwuWt0VS2UpI03g==
X-Google-Smtp-Source: AGRyM1u5dVg4T9eRcDMxAEjXoHXgFcevDHx3/P3kw55dqlJxJFEeFBu2WX8GMN6N3FHDRnUltH1clJ2IyuCKdMiWlYw=
X-Received: by 2002:a0d:d241:0:b0:317:8fee:4290 with SMTP id
 u62-20020a0dd241000000b003178fee4290mr1997890ywd.518.1655489116967; Fri, 17
 Jun 2022 11:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220616032522eucas1p19a6c8718f01fa61c2fee795fb8945a92@eucas1p1.samsung.com>
 <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com> <d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com>
In-Reply-To: <d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Jun 2022 11:04:41 -0700
Message-ID: <CAGETcx8e0QDbaqHGm1O8y6zwrBCwRitsRFXeUPt0w6uFx9k6+g@mail.gmail.com>
Subject: Re: Default async probing for DT based systems
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 2:04 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 16.06.2022 05:24, Saravana Kannan wrote:
> > Hi,
> >
> > TL;DR: I want to improve boot times by enabling async probing by
> > default for DT based systems. Can you give it a shot please?
>
> Yes, I've gave it a try on my test systems. It looks that there are a
> few issues. The first one, the most obvious to notice, is related to
> __request_module() calls from various drivers and frameworks. Here are
> some examples:
>
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 73 at kernel/kmod.c:136 __request_module+0x230/0x600
> Modules linked in:
> CPU: 3 PID: 73 Comm: kworker/u12:5 Not tainted 5.19.0-rc2-next-20220615+
> #5203
> Hardware name: ARM Juno development board (r1) (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> UDC core: g_ether: couldn't find an available UDC
> pc : __request_module+0x230/0x600
> lr : __request_module+0x228/0x600

Ah, I think I know what these might be. Going by memory,
__request_module() from asyc thread context has some issues for module
loading. So I think a check was added like this. And I think the check
is triggering when it shouldn't (this isn't module context here).

> ...
> Call trace:
>   __request_module+0x230/0x600
>   phy_request_driver_module+0x118/0x164
>   phy_device_create+0x210/0x23c
>   get_phy_device+0x8c/0x160
>   mdiobus_scan+0x40/0x1cc
>   __mdiobus_register+0x184/0x36c
>   smsc911x_drv_probe+0x648/0xa84
>   platform_probe+0x68/0xe0
>   really_probe+0xbc/0x2e0
>   __driver_probe_device+0x78/0xe0
>   driver_probe_device+0xa8/0x140
>   __driver_attach_async_helper+0x50/0xbc
>   async_run_entry_fn+0x34/0xd0
>   process_one_work+0x288/0x6bc
>   worker_thread+0x74/0x450
>   kthread+0x118/0x11c
>   ret_from_fork+0x10/0x20
> irq event stamp: 2032
> hardirqs last  enabled at (2031): [<ffff8000091b91dc>]
> _raw_spin_unlock_irqrestore+0x98/0x9c
> hardirqs last disabled at (2032): [<ffff8000091ac844>] el1_dbg+0x24/0x90
> softirqs last  enabled at (2018): [<ffff800008010470>] _stext+0x470/0x5e8
> softirqs last disabled at (2007): [<ffff8000080a5214>]
> __irq_exit_rcu+0x180/0x1ac
> ---[ end trace 0000000000000000 ]---
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 54 at kernel/kmod.c:136 __request_module+0x230/0x600
> Modules linked in: rng_core(+) rtc_meson_vrtc(+) mdio_mux_meson_g12a(+)
> meson_ir pcs_xpcs meson_canvas(+) meson_dw_hdmi dw_hdmi
> snd_soc_meson_axg_tdm_interface di
> xg_tdm_formatter nvmem_meson_efuse
> CPU: 0 PID: 54 Comm: kworker/u8:3 Not tainted 5.19.0-rc2-next-20220615+
> #5203
> Hardware name: Hardkernel ODROID-C4 (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __request_module+0x230/0x600
> lr : __request_module+0x228/0x600
> ...
> Call trace:
>   __request_module+0x230/0x600
>   rc_map_get+0xa8/0x134
>   rc_register_device+0x10c/0x600
>   devm_rc_register_device+0x4c/0x170
>   meson_ir_probe+0x160/0x2bc [meson_ir]
>   platform_probe+0x68/0xe0
>   really_probe+0xbc/0x2e0
>   __driver_probe_device+0x78/0xe0
>   driver_probe_device+0x3c/0x140
>   __driver_attach_async_helper+0x50/0xbc
>   async_run_entry_fn+0x34/0xd0
>   process_one_work+0x288/0x6bc
>   worker_thread+0x74/0x450
>   kthread+0x118/0x11c
>   ret_from_fork+0x10/0x20
> irq event stamp: 62052
> hardirqs last  enabled at (62051): [<ffff800008329c08>]
> ___slab_alloc+0x734/0x82c
> hardirqs last disabled at (62052): [<ffff8000091ac844>] el1_dbg+0x24/0x90
> softirqs last  enabled at (61920): [<ffff800008010470>] _stext+0x470/0x5e8
> softirqs last disabled at (61859): [<ffff8000080a5214>]
> __irq_exit_rcu+0x180/0x1ac
> ---[ end trace 0000000000000000 ]---
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 46 at kernel/kmod.c:136 __request_module+0x230/0x600
> Modules linked in:
> CPU: 0 PID: 46 Comm: kworker/u4:4 Not tainted 5.19.0-rc2-next-20220615+
> #5203
> Hardware name: linux,dummy-virt (DT)
> Workqueue: events_unbound async_run_entry_fn
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __request_module+0x230/0x600
> lr : __request_module+0x228/0x600
> ...
> Call trace:
>   __request_module+0x230/0x600
>   parse_mtd_partitions+0x2b4/0x490
>   mtd_device_parse_register+0x90/0x2bc
>   physmap_flash_probe+0x4c8/0x7b0
>   platform_probe+0x68/0xe0
>   really_probe+0xbc/0x2e0
>   __driver_probe_device+0x78/0xe0
>   driver_probe_device+0xa8/0x140
>   __driver_attach_async_helper+0x50/0xbc
>   async_run_entry_fn+0x34/0xd0
>   process_one_work+0x288/0x6bc
>   worker_thread+0x74/0x450
>   kthread+0x118/0x11c
>   ret_from_fork+0x10/0x20
> irq event stamp: 674
> hardirqs last  enabled at (673): [<ffffddb219125380>]
> vprintk_store+0x440/0x4a0
> hardirqs last disabled at (674): [<ffffddb21a1ac844>] el1_dbg+0x24/0x90
> softirqs last  enabled at (618): [<ffffddb219010470>] _stext+0x470/0x5e8
> softirqs last disabled at (613): [<ffffddb2190a5214>]
> __irq_exit_rcu+0x180/0x1ac
> ---[ end trace 0000000000000000 ]---
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 63 at kernel/kmod.c:136 __request_module+0x23c/0x42c
> Modules linked in: exynos_bus soundcore s5p_mfc lima brcmutil
> drm_shmem_helper exynos_adc gpu_sched sha256_generic libsha256
> sha256_arm cfg80211 phy_exynos_usb2 s
> dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videodev
> exynosdrm analogix_dp mc exynos_ppmu rtc_s3c i2c_gpio
> CPU: 0 PID: 63 Comm: kworker/u4:5 Not tainted
> 5.19.0-rc2-next-20220615-00040-g868471ca3680-dirty #5205
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound async_run_entry_fn
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from __warn+0xcc/0x144
>   __warn from warn_slowpath_fmt+0x5c/0xb4
>   warn_slowpath_fmt from __request_module+0x23c/0x42c
>   __request_module from try_then_request_governor+0x60/0xb0
>   try_then_request_governor from devfreq_add_device+0x498/0x5c8
>   devfreq_add_device from devm_devfreq_add_device+0x58/0x94
>   devm_devfreq_add_device from exynos_bus_probe+0x1b4/0x6bc [exynos_bus]
>   exynos_bus_probe [exynos_bus] from platform_probe+0x5c/0xb8
>   platform_probe from really_probe+0xc8/0x2f0
>   really_probe from __driver_probe_device+0x84/0xe4
>   __driver_probe_device from driver_probe_device+0x30/0x104
>   driver_probe_device from __driver_attach_async_helper+0x48/0x98
>   __driver_attach_async_helper from async_run_entry_fn+0x24/0xb0
>   async_run_entry_fn from process_one_work+0x1ec/0x4d0
>   process_one_work from worker_thread+0x58/0x54c
>   worker_thread from kthread+0xd0/0xec
>   kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xe0349fb0 to 0xe0349ff8)
> ...
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 63 at kernel/kmod.c:136 __request_module+0x23c/0x42c
> Modules linked in: exynos_bus soundcore s5p_mfc lima brcmutil
> drm_shmem_helper exynos_adc gpu_sched sha256_generic libsha256
> sha256_arm cfg80211 phy_exynos_usb2 s
> dma_contig videobuf2_memops videobuf2_v4l2 videobuf2_common videodev
> exynosdrm analogix_dp mc exynos_ppmu rtc_s3c i2c_gpio
> CPU: 0 PID: 63 Comm: kworker/u4:5 Not tainted
> 5.19.0-rc2-next-20220615-00040-g868471ca3680-dirty #5205
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound async_run_entry_fn
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from __warn+0xcc/0x144
>   __warn from warn_slowpath_fmt+0x5c/0xb4
>   warn_slowpath_fmt from __request_module+0x23c/0x42c
>   __request_module from try_then_request_governor+0x60/0xb0
>   try_then_request_governor from devfreq_add_device+0x498/0x5c8
>   devfreq_add_device from devm_devfreq_add_device+0x58/0x94
>   devm_devfreq_add_device from exynos_bus_probe+0x1b4/0x6bc [exynos_bus]
>   exynos_bus_probe [exynos_bus] from platform_probe+0x5c/0xb8
>   platform_probe from really_probe+0xc8/0x2f0
>   really_probe from __driver_probe_device+0x84/0xe4
>   __driver_probe_device from driver_probe_device+0x30/0x104
>   driver_probe_device from __driver_attach_async_helper+0x48/0x98
>   __driver_attach_async_helper from async_run_entry_fn+0x24/0xb0
>   async_run_entry_fn from process_one_work+0x1ec/0x4d0
>   process_one_work from worker_thread+0x58/0x54c
>   worker_thread from kthread+0xd0/0xec
>   kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xe0349fb0 to 0xe0349ff8)
> ...
> ---[ end trace 0000000000000000 ]---
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 23 at kernel/kmod.c:136 __request_module+0x23c/0x42c
> Modules linked in: g_ether usb_f_rndis u_ether libcomposite brcmfmac
> brcmutil sha256_generic libsha256 snd_soc_hdmi_codec snd_soc_core
> sha256_arm ac97_bus snd_pcm
> _timer snd soundcore panel_samsung_ld9040 hci_uart btbcm bluetooth
> s5p_csis s5p_fimc exynos4_is_common v4l2_fwnode ecdh_generic ecc
> v4l2_async spi_gpio phy_exynos
> x8998 pwm_samsung max8952 drm_shmem_helper libaes s5p_mfc gpu_sched
> s5p_jpeg v4l2_mem2mem videobuf2_dma_contig videobuf2_memops
> videobuf2_v4l2 phy_exynos_usb2 vid
> m ohci_exynos ehci_exynos analogix_dp mc s5p_sss exynos_rng rtc_s3c
> s3c2410_wdt i2c_gpio
> CPU: 0 PID: 23 Comm: kworker/u4:7 Not tainted
> 5.19.0-rc2-next-20220615-00040-g868471ca3680-dirty #5205
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: events_unbound async_run_entry_fn
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from __warn+0xcc/0x144
>   __warn from warn_slowpath_fmt+0x5c/0xb4
>   warn_slowpath_fmt from __request_module+0x23c/0x42c
>   __request_module from usb_get_function_instance+0x3c/0x58 [libcomposite]
>   usb_get_function_instance [libcomposite] from eth_bind+0x3c/0x334
> [g_ether]
>   eth_bind [g_ether] from composite_bind+0x78/0x18c [libcomposite]
>   composite_bind [libcomposite] from gadget_bind_driver+0x8c/0x1d0
>   gadget_bind_driver from really_probe+0xc8/0x2f0
>   really_probe from __driver_probe_device+0x84/0xe4
>   __driver_probe_device from driver_probe_device+0x30/0x104
>   driver_probe_device from __driver_attach_async_helper+0x48/0x98
>   __driver_attach_async_helper from async_run_entry_fn+0x24/0xb0
>   async_run_entry_fn from process_one_work+0x1ec/0x4d0
>   process_one_work from worker_thread+0x58/0x54c
>   worker_thread from kthread+0xd0/0xec
>   kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xe08ddfb0 to 0xe08ddff8)
> ...
> ---[ end trace 0000000000000000 ]---
>
>
> Some Exynos-based boards also freeze quite early, after the 'EXYNOS5420
> PMU initialized' message. I will investigate this later once I find some
> spare time.

Thanks!

-Saravana

>
>  > ...
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
