Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5BD47BA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhLUHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhLUHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:14:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EC0C061574;
        Mon, 20 Dec 2021 23:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E76C261425;
        Tue, 21 Dec 2021 07:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A83CC36AF2;
        Tue, 21 Dec 2021 07:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640070850;
        bh=pet+5nZ3YsUrDM1y7wikuZyIOVOtlV32Cw3uB4H2DJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QECFQRg8p4dF101b9fLTnPawure50NdA3GSGhhh8rQFXce+UA0k0bXATHrH8auUn+
         p2EkI3AD7KFkWYpaNhGk9ZrBcwRfktaz9sdWPh099Q6vNHBEjp3u1X4p6yR0kthAS7
         Ab5Y+1LoM/eQp7koF9sKTTGYTP+7DgwQuNnEa/XSIdJc4lROI4LSSZfX6X+JBxIHik
         PDspj6GN3WRCim7PXIwsARRmDA02vbQSwJpg0+/i/ZR7QtebGZDf7mx/E9nG5GCLmZ
         Tnn/peqEKPZ5jPWnYdMyexmBALTDcn2GS1pwDAODb1SpJxtzqNL9R4DGkarMAsx6q3
         ReYor0FwpW1nw==
Received: by mail-yb1-f178.google.com with SMTP id v203so36075666ybe.6;
        Mon, 20 Dec 2021 23:14:10 -0800 (PST)
X-Gm-Message-State: AOAM533jwlIT4/ns5m6JArszOA61JLTrx7eoZev1tDuCD9AamoYPug1g
        IzFedU7+p/6+atHY6n+GHLM1u1fBujRlGOofF/U=
X-Google-Smtp-Source: ABdhPJyUasToffdH7VWWeNxwmyz5bus2vfFAFNluy7LbTivfhNNqdSU3wM8D5SAfFuWo+p74gHbwadZY7sSbWB+1n2Q=
X-Received: by 2002:a25:68c9:: with SMTP id d192mr2538214ybc.645.1640070849302;
 Mon, 20 Dec 2021 23:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20211217121148.6753-1-sam.shih@mediatek.com> <20211217121148.6753-4-sam.shih@mediatek.com>
 <4b3cbf50198c5f57101135ffc44fa95bfda55139.camel@mediatek.com>
In-Reply-To: <4b3cbf50198c5f57101135ffc44fa95bfda55139.camel@mediatek.com>
From:   Ryder Lee <ryder.lee@kernel.org>
Date:   Mon, 20 Dec 2021 23:13:58 -0800
X-Gmail-Original-Message-ID: <CA+SzRW4smu8bX_iky-yeU3viC6SyNthiWR=APJL17FHeVVzTAQ@mail.gmail.com>
Message-ID: <CA+SzRW4smu8bX_iky-yeU3viC6SyNthiWR=APJL17FHeVVzTAQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] clk: mediatek: add mt7986 clock support
To:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        YH Chen <yh.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2021-12-17 at 20:11 +0800, Sam Shih wrote:
> > Add MT7986 clock support, include topckgen, apmixedsys,
> > infracfg, and ethernet subsystem clocks.
> >
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > ---
> > v7: exclude DTS changes in the patch series
> > v5: used builtin_platform_driver instead of CLK_OF_DECLARE
> >     follow recent clk-mt8195 clock patch series:
> >
> > https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-1-chun-jie.chen@mediatek.com/
> >
> > v4: separate clock part into a single patch series
> >
> > Original thread:
> >
> https://lore.kernel.org/lkml/20210914085137.31761-4-sam.shih@mediatek.com/
> >
> > v2: applied the comment suggested by reviewers:
> >     - splited basic clock driver to apmixed, topckgen, and infracfg
> >     - removed 1:1 factor clock
> >     - renamed factor clock for easier to understand
> > ---
> >  drivers/clk/mediatek/Kconfig               |  17 +
> >  drivers/clk/mediatek/Makefile              |   4 +
> >  drivers/clk/mediatek/clk-mt7986-apmixed.c  | 100 ++++++
> >  drivers/clk/mediatek/clk-mt7986-eth.c      | 132 ++++++++
> >  drivers/clk/mediatek/clk-mt7986-infracfg.c | 224 ++++++++++++++
> >  drivers/clk/mediatek/clk-mt7986-topckgen.c | 342
> > +++++++++++++++++++++
> >  6 files changed, 819 insertions(+)
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-apmixed.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-eth.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-infracfg.c
> >  create mode 100644 drivers/clk/mediatek/clk-mt7986-topckgen.c
> >
> > diff --git a/drivers/clk/mediatek/Kconfig
> > b/drivers/clk/mediatek/Kconfig
> > index 3ce6fb04d8ff..dd546d34d5e8 100644
> > --- a/drivers/clk/mediatek/Kconfig
> > +++ b/drivers/clk/mediatek/Kconfig
> > @@ -344,6 +344,23 @@ config COMMON_CLK_MT7629_HIFSYS
> >         This driver supports MediaTek MT7629 HIFSYS clocks providing
> >         to PCI-E and USB.
> >
> > +config COMMON_CLK_MT7986
> > +     bool "Clock driver for MediaTek MT7986"
> > +     depends on ARCH_MEDIATEK || COMPILE_TEST
> > +     select COMMON_CLK_MEDIATEK
> > +     default ARCH_MEDIATEK
> > +     help
> > +       This driver supports MediaTek MT7986 basic clocks and clocks
> > +       required for various periperals found on MediaTek.

s/periperals/peripherals/

> > +config COMMON_CLK_MT7986_ETHSYS
> > +     bool "Clock driver for MediaTek MT7986 ETHSYS"
> > +     depends on COMMON_CLK_MT7986
> > +     default COMMON_CLK_MT7986
> > +     help
> > +       This driver add support for clocks for Ethernet and SGMII
> > +       required on MediaTek MT7986 SoC.

s/add/adds/

With that said, you can add my tag:
Reviewed-by: Ryder Lee <ryder.lee@kernel.org>
