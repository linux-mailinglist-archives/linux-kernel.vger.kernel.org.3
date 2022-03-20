Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB74E191B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 01:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbiCTAQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 20:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbiCTAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 20:16:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242241AA8EB;
        Sat, 19 Mar 2022 17:15:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so15688172ljr.9;
        Sat, 19 Mar 2022 17:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xg1HAwX6al3B4/kYZjuhrKZfPnLwkpdiAw2iONwgAW8=;
        b=Cb4CUk2daFpfNV5ns0oFdrFWetjl/jc0PsI2rn81+CoNkdmBrQyhC4xXcgUvMEu4Oc
         z0T19wX8m3C7LVHV3xbZbe0CeSPw417pBCCC+f7xv58dy2ZMqu02SZyIBwbiJTeJ+uYD
         WEOgG82g7ouyIHesmtc62aROCx5h3w/5V1w5eQzZVAKN5eaD9aZJ1ChmdmQY3Ko9ZDuD
         DWfKnpW7pUu+b0oCulLY2hXNa9zioL2QaJJv5FJ8eI5TcWoAdb78YTDQbad3Qx/a5Hy0
         ybVocT1nZY2gpckZpvijgQ5iUys0F3/b0LC7sBIp1Y5WvCEP+GKMLriDGmbbNHNpVpH8
         WLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xg1HAwX6al3B4/kYZjuhrKZfPnLwkpdiAw2iONwgAW8=;
        b=ghTD3wZigvJ0Ez7vtuY2Oz8Rzmz6DEtDqvXI4qNRuzU5VU3SIE8JpibGu/LgZsWBz2
         dln5ridWOBji5MbixbL/qOhl33OznnXnFrGRmk9aRu2YslMwNlxg+nn8Ngn8cSBlxjPo
         3JxlVwDqulvUDmACG1Ucjc0bCWCu6ujtLLL6vzHeoGCq88uORiCcdz3DeM10K3JlcVz3
         9O0/lbba+bHHKRvzAV+fiV3IzI9US3ZHPaggIcPp/NBLMuBNxEI2iWt6G2tmLkUGNZY5
         mGukNVzwiMQzXBfnuiz2+XVHltx3DJaNp63mhQxHqjYfKueRGYjcuzM1kxMsFMyCkNqX
         TAQA==
X-Gm-Message-State: AOAM5311rudUD7OuxbPFuqFxvptK1e5waQMmK3V7pQYKMUHZq2W3jzzG
        1nGoUwCI64M7DEfWY/cpalU=
X-Google-Smtp-Source: ABdhPJx+8p7l5v0hEGeTAW8gYg1ItZk1pTj0mqkknJDkzJp/26+4Ikpnko3kjnF4Qt89T28hmYXLYg==
X-Received: by 2002:a05:651c:a08:b0:247:eb2e:fb04 with SMTP id k8-20020a05651c0a0800b00247eb2efb04mr10574613ljq.524.1647735325216;
        Sat, 19 Mar 2022 17:15:25 -0700 (PDT)
Received: from dell.intranet (178235254230.gdansk.vectranet.pl. [178.235.254.230])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e2f15000000b002456e6cdab2sm1666413ljv.93.2022.03.19.17.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 17:15:24 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Paul Walmsley <paul@pwsan.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC RFT PATCH 0/4] ARM: OMAP1: clock: Convert to CCF
Date:   Sun, 20 Mar 2022 01:15:22 +0100
Message-ID: <3093204.5fSG56mABF@dell>
In-Reply-To: <20220319212119.GG1986@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-1-jmkrzyszt@gmail.com> <20220319184952.GF1986@darkstar.musicnaut.iki.fi> <20220319212119.GG1986@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaro,

On Saturday, 19 March 2022 22:21:19 CET Aaro Koskinen wrote:
> Hi,
> 
> On Sat, Mar 19, 2022 at 08:49:55PM +0200, Aaro Koskinen wrote:
> > On Sat, Mar 12, 2022 at 10:14:31AM +0200, Tony Lindgren wrote:
> > > * Janusz Krzysztofik <jmkrzyszt@gmail.com> [220310 23:32]:
> > > > The main motivation behind this series is planned resurection of OMAP1
> > > > camera driver.  Since OMAP1 clock internals have never been visible to
> > > > drivers, that driver used to use v4l2-clk to expose a pixel clock for a
> > > > sensor.  The v4l2-clk code has been recently depreciated and removed from
> > > > the media subtree, hence the need for an alternative solution.
> > > 
> > > Nice :) This will also help Arnd with building multi-v5 kernels.
> > 
> > This will need more testing still... The patch 4 is breaking at least 770
> > (the display/fb doesn't work anymore).
> 
> Patches 1-3 are OK on Nokia 770, OSK and Palm TE.
> 
> Patch 4 breaks 770, but OSK and Palm TE are OK.
> 
> Below is the problem with 770. As a quick hack, I tried replacing
> all clk_enable/disable()s with prepare_enable/disable_unprepare()s in
> drivers/video/fbdev/omap/hwa742.c and drivers/video/fbdev/omap/sossi.c
> and that seems to help...
> 
> [    0.374389] omapfb: lph8923 rev 92 LCD detected, 16 data lines
> [    0.374816] omapfb: configured for panel lph8923
> [    0.383789] omapfb: LCDC initialized
> [    0.384216] ------------[ cut here ]------------
> [    0.384368] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1012 clk_core_enable+0x94/0xb0
> [    0.384613] Enabling unprepared ck_sossi

Yes, I've identified still a few drivers that need to be updated, I'll 
prepare v2 of PATCH 3/4 and resubmit.

Thanks,
Janusz

> [    0.384704] Modules linked in:
> [    0.384796] CPU: 0 PID: 1 Comm: swapper Not tainted 5.17.0-rc8-770-los_381206+-00072-gb2406fc1ddd4 #2
> [    0.385009] Hardware name: Nokia 770
> [    0.385101]  unwind_backtrace from show_stack+0x10/0x14
> [    0.385314]  show_stack from __warn+0xac/0xe4
> [    0.385528]  __warn from warn_slowpath_fmt+0x90/0xc8
> [    0.385711]  warn_slowpath_fmt from clk_core_enable+0x94/0xb0
> [    0.385894]  clk_core_enable from clk_core_enable_lock+0x18/0x2c
> [    0.386077]  clk_core_enable_lock from sossi_init+0xa0/0x258
> [    0.386260]  sossi_init from hwa742_init+0x90/0x538
> [    0.386474]  hwa742_init from omapfb_do_probe+0x200/0x68c
> [    0.386657]  omapfb_do_probe from mipid_spi_probe+0x1b4/0x230
> [    0.386840]  mipid_spi_probe from spi_probe+0x48/0x6c
> [    0.387054]  spi_probe from really_probe+0xac/0x2f0
> [    0.387237]  really_probe from __driver_probe_device+0x80/0xe4
> [    0.387390]  __driver_probe_device from driver_probe_device+0x30/0xd8
> [    0.387573]  driver_probe_device from __driver_attach+0x70/0xf0
> [    0.387756]  __driver_attach from bus_for_each_dev+0x74/0xc0
> [    0.387908]  bus_for_each_dev from bus_add_driver+0x14c/0x1d8
> [    0.388061]  bus_add_driver from driver_register+0x74/0x108
> [    0.388244]  driver_register from do_one_initcall+0x4c/0x1cc
> [    0.388427]  do_one_initcall from kernel_init_freeable+0x170/0x1f4
> [    0.388641]  kernel_init_freeable from kernel_init+0x10/0x108
> [    0.388824]  kernel_init from ret_from_fork+0x14/0x2c
> [    0.388977] Exception stack(0xc0c41fb0 to 0xc0c41ff8)
> [    0.389099] 1fa0:                                     00000000 00000000 00000000 00000000
> [    0.389282] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.389434] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.389556] ---[ end trace 0000000000000000 ]---
> [    0.389709] omapfb omapfb: invalid SoSSI sync pattern: 00000000, 00000000
> [    0.389831] ------------[ cut here ]------------
> [    0.389923] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:953 clk_core_disable+0xb4/0xcc
> [    0.390136] ck_sossi already disabled
> [    0.390228] Modules linked in:
> [    0.390319] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.17.0-rc8-770-los_381206+-00072-gb2406fc1ddd4 #2
> [    0.390502] Hardware name: Nokia 770
> [    0.390594]  unwind_backtrace from show_stack+0x10/0x14
> [    0.390808]  show_stack from __warn+0xac/0xe4
> [    0.391021]  __warn from warn_slowpath_fmt+0x90/0xc8
> [    0.391204]  warn_slowpath_fmt from clk_core_disable+0xb4/0xcc
> [    0.391387]  clk_core_disable from clk_core_disable_lock+0x18/0x24
> [    0.391540]  clk_core_disable_lock from sossi_init+0x1bc/0x258
> [    0.391754]  sossi_init from hwa742_init+0x90/0x538
> [    0.391937]  hwa742_init from omapfb_do_probe+0x200/0x68c
> [    0.392120]  omapfb_do_probe from mipid_spi_probe+0x1b4/0x230
> [    0.392333]  mipid_spi_probe from spi_probe+0x48/0x6c
> [    0.392547]  spi_probe from really_probe+0xac/0x2f0
> [    0.392730]  really_probe from __driver_probe_device+0x80/0xe4
> [    0.392883]  __driver_probe_device from driver_probe_device+0x30/0xd8
> [    0.393066]  driver_probe_device from __driver_attach+0x70/0xf0
> [    0.393249]  __driver_attach from bus_for_each_dev+0x74/0xc0
> [    0.393402]  bus_for_each_dev from bus_add_driver+0x14c/0x1d8
> [    0.393585]  bus_add_driver from driver_register+0x74/0x108
> [    0.393737]  driver_register from do_one_initcall+0x4c/0x1cc
> [    0.393920]  do_one_initcall from kernel_init_freeable+0x170/0x1f4
> [    0.394134]  kernel_init_freeable from kernel_init+0x10/0x108
> [    0.394317]  kernel_init from ret_from_fork+0x14/0x2c
> [    0.394470] Exception stack(0xc0c41fb0 to 0xc0c41ff8)
> [    0.394592] 1fa0:                                     00000000 00000000 00000000 00000000
> [    0.394775] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.394958] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.395080] ---[ end trace 0000000000000000 ]---
> [    0.417907] omapfb omapfb: controller initialization failed (-19)
> 
> A.
> 




