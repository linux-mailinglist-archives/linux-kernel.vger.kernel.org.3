Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0D552697
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbiFTVeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbiFTVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:34:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BD71570A;
        Mon, 20 Jun 2022 14:34:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c2so19273884lfk.0;
        Mon, 20 Jun 2022 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s0R5mmM05lsGfWIfbL6p8eqpR6CxHgnjZf4kJe++K6A=;
        b=XarjFldC0uD5OUmY2R2d+LkYVknWoBbcxLhDnPZZ5rj5CZfCZ89pqO75sRGhNRWJ67
         QV6w6lX46zpW6uSgZp/gfYo9LhcajmzJvclYf48zdADp6EvTttBxURmfVcYEqjDnWeLj
         ZkOkjtzfsONBTWvhTBpch1iXDkHYc3Dyqh+j+XNbL6jWYdrPIixDjopoYknYRaI0R27g
         IoZ6XjQJyZRYCWuI6+O2VcZQ/ZqP0KLaAVGfCNxyD9OjcME7rgD8JS+Sb2T1WlZq+HA1
         LiTv6dlmIG8blmjIjMKee+lIEVu1rwbt2ut7h26zb4Ezu5Oc1qo4o+W96nfBmiLDVzOh
         rCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s0R5mmM05lsGfWIfbL6p8eqpR6CxHgnjZf4kJe++K6A=;
        b=r716l8DpJBuLIxrBCSTNCTN3kVzPp80bKPf14VWkPLG57b6YEapNrLV5OnNtqLFsps
         Uas76h2Wc7k8m1t4BXDRyVYBBnuboQ7cLVoeKJKdlBELp2lX4fCr6ncAg1ivgbjm07ar
         mgiGTjYwsq4y2QbQ+ren0g+3sVhM8fHi5twoklSHPlZRmZQZ7ImJUR3yva84XQGtNfas
         cCCKJ9dCDakjD/him+Ke8doj7qgnz/Ezj2Wdv5jH4/pjJOcvplxvuuEm5+ny9OHW6/k/
         twW2ptmmo5upbW9RURSmlewiAsaWBptGLYVzsPSaTFcviHoUT0Xc6I88+w0GtnSyJqmB
         +85g==
X-Gm-Message-State: AJIora/Yqf6CWP4p+MWZ8HFJ9GoV94HGsc77rsRy/3zYQcq3Y6omTo5s
        1zf34qeY2XZMm6mR7/B0E5I=
X-Google-Smtp-Source: AGRyM1tB6Drp/umy1VSMi2cffqS7UB8ehavkbrFBMG3EU0JZUloawCq0vJ3PgIQDSYEZMZgYjILLkg==
X-Received: by 2002:a05:6512:238a:b0:47f:6a9a:ea39 with SMTP id c10-20020a056512238a00b0047f6a9aea39mr5283214lfv.215.1655760838354;
        Mon, 20 Jun 2022 14:33:58 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id o7-20020a198c07000000b0047255d211e9sm1889833lfd.280.2022.06.20.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 14:33:57 -0700 (PDT)
Date:   Tue, 21 Jun 2022 00:33:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/8] clk/resets: baikal-t1: Add DDR/PCIe resets and
 xGMAC/SATA fixes
Message-ID: <20220620213355.q6qlpiy2orninq3g@mobilestation>
References: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @Philipp,
Could you have a look at the reset-related patches of series? One of
them is a fix and another one concerns the reset-part of the Clock/Reset
controller embedded into our SoC.

Hi @Stephen,
The series has been here for about four months now. Can we speed the
review up somehow?

-Sergey

On Fri, Jun 10, 2022 at 10:21:16AM +0300, Serge Semin wrote:
> Short summary regarding this patchset. The series starts from fixing a
> wrong semantic of the device managed optional exclusive bulk reset control
> getter. Then we suggest a fix of the clocks glitching cause by the Renesas
> 5P49V6901 chip in some circumstances. Afterwards a few more modifications
> are introduced to finally finish the Baikal-T1 CCU unit support up and
> prepare the code before adding the Baikal-T1 PCIe/xGMAC support. First of
> all it turned out I specified wrong DW xGMAC PTP reference clock divider
> in my initial patches. It must be 8, not 10. Secondly I was wrong to add a
> joint xGMAC Ref and PTP clock instead of having them separately defined.
> The SoC manual describes these clocks as separate fixed clock wrappers.
> Finally in order to close the SoC clock/reset support up we need to add
> the DDR and PCIe interfaces reset controls support. It's done in two
> steps. First I've moved the reset-controls-related code into a dedicated
> module. Then the DDR/PCIe reset-control functionality is added. As the
> series finalization we've decided to convert the Baikal-T1 clock/reset
> source drivers to mainly being the platform device driver and
> pre-initialize the basic clocks only at the early kernel boot stages.
> 
> Link: https://lore.kernel.org/linux-pci/20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Resubmit the series with adding @Philipp to the list of the recipients.
> 
> Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v3:
> - No comments. Just resend the series.
> - Rebased from v5.17 onto v5.18-rc3.
> 
> Link: https://lore.kernel.org/linux-clk/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v4:
> - Completely split the CCU Dividers and Resets functionality up. (@Stephen)
> - Add a new fixes patch: "clk: baikal-t1: Actually enable SATA internal
>   ref clock".
> - Add a new fixes patch: "reset: Fix devm bulk optional exclusive control
>   getter".
> - Add a new fixes patch: "clk: vc5: Fix 5P49V6901 outputs disabling when
>   enabling FOD".
> - Add a new feagure patch: "clk: baikal-t1: Convert to platform device
>   driver".
> - Change the internal clock ID to the XGMAC-referred name.
> - Rebase onto the kernel v5.18.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (8):
>   reset: Fix devm bulk optional exclusive control getter
>   clk: vc5: Fix 5P49V6901 outputs disabling when enabling FOD
>   clk: baikal-t1: Fix invalid xGMAC PTP clock divider
>   clk: baikal-t1: Add shared xGMAC ref/ptp clocks internal parent
>   clk: baikal-t1: Add SATA internal ref clock buffer
>   clk: baikal-t1: Move reset-controls code into a dedicated module
>   clk: baikal-t1: Add DDR/PCIe directly controlled resets support
>   clk: baikal-t1: Convert to platform device driver
> 
>  drivers/clk/baikal-t1/Kconfig       |  12 +-
>  drivers/clk/baikal-t1/Makefile      |   1 +
>  drivers/clk/baikal-t1/ccu-div.c     |  84 +++++++--
>  drivers/clk/baikal-t1/ccu-div.h     |  17 +-
>  drivers/clk/baikal-t1/ccu-pll.h     |   8 +
>  drivers/clk/baikal-t1/ccu-rst.c     |  99 ++++++++++
>  drivers/clk/baikal-t1/ccu-rst.h     |  79 ++++++++
>  drivers/clk/baikal-t1/clk-ccu-div.c | 272 +++++++++++++++++-----------
>  drivers/clk/baikal-t1/clk-ccu-pll.c | 128 ++++++++++---
>  drivers/clk/baikal-t1/clk-ccu-rst.c | 257 ++++++++++++++++++++++++++
>  drivers/clk/clk-versaclock5.c       |   2 +-
>  include/dt-bindings/reset/bt1-ccu.h |   9 +
>  include/linux/reset.h               |   2 +-
>  13 files changed, 814 insertions(+), 156 deletions(-)
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
>  create mode 100644 drivers/clk/baikal-t1/clk-ccu-rst.c
> 
> -- 
> 2.35.1
> 
