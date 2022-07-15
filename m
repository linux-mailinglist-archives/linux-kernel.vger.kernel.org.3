Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5F5760E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiGOLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGOLva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:51:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CBF89EA6;
        Fri, 15 Jul 2022 04:51:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t1so7411588lft.8;
        Fri, 15 Jul 2022 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nq5biTcYU0sP0Qw3BPqHawRXCZS98d4s9Brinnk8GgI=;
        b=iWeawgYVaHiYI6ypcIojWNdNAYNjac9kqCaGb9jAZBzoJXLnV2U47dKqhWzA07OUe/
         kuUEIx9lLgXXMbvcwpBnsfIVAzzvsw4mgDsl+SyuQyIkt0w5m3+7AQQviwz4t85ABGHG
         6coLlGTQMbPtgv+c7b3V3/P7/lrsOmv2ygCtTbAPOqbi+TTRiqkxGdRMe4NoDSmZ8aGU
         SZB9kSy1ebhfiLMa4Wqy0GJ2Qo4r5jzbx6RpZBHC2JTLE2wKreM+iZONVTiUl9A0+18Y
         KQ89LjLm5z2+D+cAv6ZxwNVk8Yx+CrsRJwiEaD75PfcmpzyMQuCCvQVYFnFo1eEDgNDR
         CNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nq5biTcYU0sP0Qw3BPqHawRXCZS98d4s9Brinnk8GgI=;
        b=MeJOixY8U8ubfrp52W5WHzzWMcH6mxytI3xIL7mf15SiPRvarvSw2hM7SIs7RAkp2T
         oilalUItKK1O/Qo958m3DyZ/INAPIjnHxpaLoGk5uy+vpEj5DC6iVguR9umIE06zuA4v
         AXcSudlG/uEavNprj/tHsK/DlAJwfuoP+3krFy5BNIQxJ8pgOLN+x+pSYujaDE0icD4M
         dN2w2fQI0ItLNWCB+59aIPgL1S1Jf7Jj7lMIIIgBzJ1ZCz+VToZMvudXQmeywY+DHXb1
         YIILHMIB6rNeWXnY72pv4SPrzaV+UBRaU6cRW3aOnPk9o0XuQS6pEloXKSDeDmE7R9Pk
         Zgew==
X-Gm-Message-State: AJIora9nf9rNZj7fkelmgdXfiR81u/VE32TSAiaVO48b95PuyJVXodMu
        H0M1TU7+x1lCuyo8J5UtaME=
X-Google-Smtp-Source: AGRyM1u4k9x5ieDhOv0BKdrv3SbEJ+Ffy/LH7cq4/TK7YmKkwhxRbX1BlE8RHwikcRgwYjdwxl69Cw==
X-Received: by 2002:ac2:5469:0:b0:489:f9d3:4285 with SMTP id e9-20020ac25469000000b00489f9d34285mr7673440lfn.308.1657885887299;
        Fri, 15 Jul 2022 04:51:27 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v1-20020ac258e1000000b0047da6e495b1sm874365lfo.4.2022.07.15.04.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:51:26 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:51:24 +0300
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
Message-ID: <20220715115124.g5d33oarvbojnlnh@mobilestation>
References: <20220712121505.5671-1-Sergey.Semin@baikalelectronics.ru>
 <20220712121613.rvb2s4i3ls6nlkbu@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712121613.rvb2s4i3ls6nlkbu@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

On Tue, Jul 12, 2022 at 03:16:16PM +0300, Serge Semin wrote:
> Hi @Stephen.
> 
> Philipp has completed the reset-related patches review. Could you
> please merge the series in so it would make it into the kernel v5.20?
> 
> -Sergey
> 
> On Tue, Jul 12, 2022 at 03:14:58PM +0300, Serge Semin wrote:
> > Folks! It has been over four months since the first series submission for
> > review. Please merge it in.
> > 
> > Short summary regarding this patchset. The series starts from fixing of
> > the clocks glitching cause by the Renesas 5P49V6901 chip in some
> > circumstances. Afterwards a few more modifications are introduced to
> > finally finish the Baikal-T1 CCU unit support up and prepare the code
> > before adding the Baikal-T1 PCIe/xGMAC support. First of all it turned out
> > I specified wrong DW xGMAC PTP reference clock divider in my initial
> > patches. It must be 8, not 10. Secondly I was wrong to add a joint xGMAC
> > Ref and PTP clock instead of having them separately defined.  The SoC
> > manual describes these clocks as separate fixed clock wrappers. Finally
> > in order to close the SoC clock/reset support up we need to add the DDR
> > and PCIe interfaces reset controls support. It's done in two steps. First
> > I've moved the reset-controls-related code into a dedicated module. Then
> > the DDR/PCIe reset-control functionality is added. As the series
> > finalization we've decided to convert the Baikal-T1 clock/reset source
> > drivers to mainly being the platform device driver and pre-initialize the
> > basic clocks only at the early kernel boot stages.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220324010905.15589-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Resubmit the series with adding @Philipp to the list of the recipients.
> > 
> > Link: https://lore.kernel.org/linux-pci/20220330144320.27039-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v3:
> > - No comments. Just resend the series.
> > - Rebased from v5.17 onto v5.18-rc3.
> > 
> > Link: https://lore.kernel.org/linux-clk/20220503205722.24755-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v4:
> > - Completely split the CCU Dividers and Resets functionality up. (@Stephen)
> > - Add a new fixes patch: "clk: baikal-t1: Actually enable SATA internal
> >   ref clock".
> > - Add a new fixes patch: "reset: Fix devm bulk optional exclusive control
> >   getter".
> > - Add a new fixes patch: "clk: vc5: Fix 5P49V6901 outputs disabling when
> >   enabling FOD".
> > - Add a new feagure patch: "clk: baikal-t1: Convert to platform device
> >   driver".
> > - Change the internal clock ID to the XGMAC-referred name.
> > - Rebase onto the kernel v5.18.
> > 
> > Link: https://lore.kernel.org/lkml/20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v5:
> > - Just resend.
> > - Rebase onto the kernel v5.19-rcX.
> > 
> > Link: https://lore.kernel.org/linux-clk/20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v6:
> > - Drop the patch
> >   [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive control getter
> >   since it has already been accepted by @Philipp.
> > - Refactor the reset-control code to support the linear reset IDs only.
> >   (@Philipp)
> > - Combine the reset-related code into a single file. (@Philipp)
> > - Drop CCU_DIV_RST_MAP() macro. It's no longer used.
> > 
> > Link: https://lore.kernel.org/linux-clk/20220708192725.9501-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v7:
> > - Fix "Alignment should match open parenthesis" warning for the
> >   pr_err() method invocations. (@Philipp)
> > - Drop empty line from the sys_rst_info structure initialization block.
> >   (@Philipp)
> > 
> > Link: https://lore.kernel.org/linux-clk/20220711154433.15415-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v8:
> > - Fix "sef-deasserted" spelling in the CLK_BT1_CCU_RST config help
> >   text. (@Randy)
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (7):
> >   clk: vc5: Fix 5P49V6901 outputs disabling when enabling FOD
> >   clk: baikal-t1: Fix invalid xGMAC PTP clock divider
> >   clk: baikal-t1: Add shared xGMAC ref/ptp clocks internal parent
> >   clk: baikal-t1: Add SATA internal ref clock buffer
> >   clk: baikal-t1: Move reset-controls code into a dedicated module
> >   clk: baikal-t1: Add DDR/PCIe directly controlled resets support
> >   clk: baikal-t1: Convert to platform device driver
> > 
> >  drivers/clk/baikal-t1/Kconfig       |  12 +-
> >  drivers/clk/baikal-t1/Makefile      |   1 +
> >  drivers/clk/baikal-t1/ccu-div.c     |  84 +++++++--
> >  drivers/clk/baikal-t1/ccu-div.h     |  17 +-
> >  drivers/clk/baikal-t1/ccu-pll.h     |   8 +
> >  drivers/clk/baikal-t1/ccu-rst.c     | 217 +++++++++++++++++++++++
> >  drivers/clk/baikal-t1/ccu-rst.h     |  67 +++++++
> >  drivers/clk/baikal-t1/clk-ccu-div.c | 263 ++++++++++++++++------------
> >  drivers/clk/baikal-t1/clk-ccu-pll.c | 128 +++++++++++---
> >  drivers/clk/clk-versaclock5.c       |   2 +-
> >  include/dt-bindings/reset/bt1-ccu.h |   9 +
> >  11 files changed, 647 insertions(+), 161 deletions(-)
> >  create mode 100644 drivers/clk/baikal-t1/ccu-rst.c
> >  create mode 100644 drivers/clk/baikal-t1/ccu-rst.h
> > 
> > -- 
> > 2.35.1
> > 
