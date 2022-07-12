Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E465719B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiGLMQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiGLMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:16:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDF6B278;
        Tue, 12 Jul 2022 05:16:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a10so7809602ljj.5;
        Tue, 12 Jul 2022 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mtU+3hpXIQ0RaypIhW03nhtWkWJS41n4eDqTOWyxkpo=;
        b=oUMXXSvfCQY0UPANG698hvuz/3sP7+kr0tIluCnHUMWU/BdOmFACRkQ+I4FAEP1MRN
         oF+xwWrI8ySUTxImqq9hQhxPfYMMnmYUc3hYWQGLjs+UbNW4yRbCb8xHbwb9mt0dMnb7
         dh8sAN2FqCzrPpEPdkyLmd18PS3TYAYHBUVm1Hdpd75KfT09L86qSUNLAwKokruvWB1z
         vLF/fkq7wmr2IMSSh05Ru11P0+V4zRsw7Jhr6rG17L3mEdy/Q9i49LBSk6A5zYOWWgqG
         gJ+PPEkDaeeFo/Fi9y49Kbyqq+MChKLiJL31l1ViHzHB/7AhWiCru5jbu2HUhDRLT4Cd
         gwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mtU+3hpXIQ0RaypIhW03nhtWkWJS41n4eDqTOWyxkpo=;
        b=f9zCX/SYA+7fCkrJXPS3vc0XmpFotbLEIqmQATkUnehE6VIuHvQQwOqp++lxR6TIYH
         W2GTjqfTJyi2WU45P/pDOOqs6GobI11Z6pdhCrs0bAkDpDbawAJ5EerehlQMhSQCsQzy
         ELIq4w9mtQFDeJvbUg19aIJju4yFCFhwxUp5OpCdom448k59LFMlfkQtzx0bREgGu4Bs
         8pTbpvC1OKDLsQZOFrmx1DYma0M4FT9pW3kaO+ymoVJkSs6PUsPJyJEpEDAoeZE+vzLC
         gx+vRul56Y+t7yTt4U40/LCquK81t9/z9qCtnEb8dkvqD3kCIy5lC/Kl1LnyVnTKQIou
         gekA==
X-Gm-Message-State: AJIora8uC+U4MB2ABGuDifOQbN5gnf9RcULvrKlcwnC3Z77/D4GXIRML
        BcAzu9P9s0YbVY7HLBIsY2U=
X-Google-Smtp-Source: AGRyM1tB99ugT+BT75+vH7nbfAb+ZELaZ9ZW+YGAawL45pqg9GR5xnOoJpddKzUWIrHdcohnUoPmcg==
X-Received: by 2002:a05:651c:1a0a:b0:25d:71b6:7154 with SMTP id by10-20020a05651c1a0a00b0025d71b67154mr3956009ljb.340.1657628175897;
        Tue, 12 Jul 2022 05:16:15 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id p23-20020a056512139700b00489ab10f1b1sm2163602lfa.20.2022.07.12.05.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:16:15 -0700 (PDT)
Date:   Tue, 12 Jul 2022 15:16:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/7] clk/resets: baikal-t1: Add DDR/PCIe resets and
 xGMAC/SATA fixes
Message-ID: <20220712121613.rvb2s4i3ls6nlkbu@mobilestation>
References: <20220712121505.5671-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712121505.5671-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi @Stephen.

Philipp has completed the reset-related patches review. Could you
please merge the series in so it would make it into the kernel v5.20?

-Sergey

On Tue, Jul 12, 2022 at 03:14:58PM +0300, Serge Semin wrote:
> Folks! It has been over four months since the first series submission for
> review. Please merge it in.
> 
> Short summary regarding this patchset. The series starts from fixing of
> the clocks glitching cause by the Renesas 5P49V6901 chip in some
> circumstances. Afterwards a few more modifications are introduced to
> finally finish the Baikal-T1 CCU unit support up and prepare the code
> before adding the Baikal-T1 PCIe/xGMAC support. First of all it turned out
> I specified wrong DW xGMAC PTP reference clock divider in my initial
> patches. It must be 8, not 10. Secondly I was wrong to add a joint xGMAC
> Ref and PTP clock instead of having them separately defined.  The SoC
> manual describes these clocks as separate fixed clock wrappers. Finally
> in order to close the SoC clock/reset support up we need to add the DDR
> and PCIe interfaces reset controls support. It's done in two steps. First
> I've moved the reset-controls-related code into a dedicated module. Then
> the DDR/PCIe reset-control functionality is added. As the series
> finalization we've decided to convert the Baikal-T1 clock/reset source
> drivers to mainly being the platform device driver and pre-initialize the
> basic clocks only at the early kernel boot stages.
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
> Link: https://lore.kernel.org/lkml/20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v5:
> - Just resend.
> - Rebase onto the kernel v5.19-rcX.
> 
> Link: https://lore.kernel.org/linux-clk/20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v6:
> - Drop the patch
>   [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive control getter
>   since it has already been accepted by @Philipp.
> - Refactor the reset-control code to support the linear reset IDs only.
>   (@Philipp)
> - Combine the reset-related code into a single file. (@Philipp)
> - Drop CCU_DIV_RST_MAP() macro. It's no longer used.
> 
> Link: https://lore.kernel.org/linux-clk/20220708192725.9501-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v7:
> - Fix "Alignment should match open parenthesis" warning for the
>   pr_err() method invocations. (@Philipp)
> - Drop empty line from the sys_rst_info structure initialization block.
>   (@Philipp)
> 
> Link: https://lore.kernel.org/linux-clk/20220711154433.15415-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v8:
> - Fix "sef-deasserted" spelling in the CLK_BT1_CCU_RST config help
>   text. (@Randy)
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (7):
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
>  drivers/clk/baikal-t1/ccu-rst.c     | 217 +++++++++++++++++++++++
>  drivers/clk/baikal-t1/ccu-rst.h     |  67 +++++++
>  drivers/clk/baikal-t1/clk-ccu-div.c | 263 ++++++++++++++++------------
>  drivers/clk/baikal-t1/clk-ccu-pll.c | 128 +++++++++++---
>  drivers/clk/clk-versaclock5.c       |   2 +-
>  include/dt-bindings/reset/bt1-ccu.h |   9 +
>  11 files changed, 647 insertions(+), 161 deletions(-)
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
>  create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
> 
> -- 
> 2.35.1
> 
