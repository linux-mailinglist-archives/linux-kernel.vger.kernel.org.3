Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C64E3A98
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiCVIb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiCVIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:31:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC0713F8D;
        Tue, 22 Mar 2022 01:30:24 -0700 (PDT)
X-UUID: 2c5a5ae2a33341f9803f4fa11f802fd3-20220322
X-UUID: 2c5a5ae2a33341f9803f4fa11f802fd3-20220322
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1934978458; Tue, 22 Mar 2022 16:30:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 22 Mar 2022 16:30:17 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Mar 2022 16:30:17 +0800
Message-ID: <51750d230b38aa3d2e9d370247bcb4be93a35877.camel@mediatek.com>
Subject: Re: [PATCH v2 02/15] clk: mediatek: Add MT8186 mcusys clock support
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 22 Mar 2022 16:30:17 +0800
In-Reply-To: <CAGXv+5Fq4_dZBWJvKZ8ADUSQF4bTu-QWZ+7KG1dsJoWDrT2nXg@mail.gmail.com>
References: <20220221015258.913-1-chun-jie.chen@mediatek.com>
         <20220221015258.913-3-chun-jie.chen@mediatek.com>
         <CAGXv+5Fq4_dZBWJvKZ8ADUSQF4bTu-QWZ+7KG1dsJoWDrT2nXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-09 at 18:13 +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Feb 21, 2022 at 9:59 AM Chun-Jie Chen
> <chun-jie.chen@mediatek.com> wrote:
> > 
> > Add MT8186 mcusys clock controller which provides muxes
> > to select the clock source of APMCU.
> > 
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > Acked-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/clk/mediatek/Kconfig          |   8 ++
> >  drivers/clk/mediatek/Makefile         |   1 +
> >  drivers/clk/mediatek/clk-mt8186-mcu.c | 106
> > ++++++++++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >  create mode 100644 drivers/clk/mediatek/clk-mt8186-mcu.c
> > 
> > diff --git a/drivers/clk/mediatek/Kconfig
> > b/drivers/clk/mediatek/Kconfig
> > index 01ef02c54725..d5936cfb3bee 100644
> > --- a/drivers/clk/mediatek/Kconfig
> > +++ b/drivers/clk/mediatek/Kconfig
> > @@ -512,6 +512,14 @@ config COMMON_CLK_MT8183_VENCSYS
> >         help
> >           This driver supports MediaTek MT8183 vencsys clocks.
> > 
> > +config COMMON_CLK_MT8186
> > +       bool "Clock driver for MediaTek MT8186"
> > +       depends on ARM64 || COMPILE_TEST
> > +       select COMMON_CLK_MEDIATEK
> > +       default ARCH_MEDIATEK
> > +       help
> > +         This driver supports MediaTek MT8186 clocks.
> > +
> >  config COMMON_CLK_MT8192
> >         bool "Clock driver for MediaTek MT8192"
> >         depends on ARM64 || COMPILE_TEST
> > diff --git a/drivers/clk/mediatek/Makefile
> > b/drivers/clk/mediatek/Makefile
> > index 7b0c2646ce4a..677fa4f0eea2 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -71,6 +71,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_MFGCFG) += clk-
> > mt8183-mfgcfg.o
> >  obj-$(CONFIG_COMMON_CLK_MT8183_MMSYS) += clk-mt8183-mm.o
> >  obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
> >  obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
> > +obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o
> >  obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
> >  obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
> >  obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> > diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c
> > b/drivers/clk/mediatek/clk-mt8186-mcu.c
> > new file mode 100644
> > index 000000000000..6d82c5de16c1
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
> > @@ -0,0 +1,106 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Copyright (c) 2022 MediaTek Inc.
> > +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > +
> > +#include "clk-mtk.h"
> 
> Please move local headers after global ones. And please do this for
> all
> patches.
> 
> > +
> > +#include <dt-bindings/clock/mt8186-clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/platform_device.h>
> > +
> > +static DEFINE_SPINLOCK(mt8186_clk_lock);
> > +
> > +static const char * const mcu_armpll_ll_parents[] = {
> > +       "clk26m",
> > +       "armpll_ll",
> > +       "mainpll",
> > +       "univpll_d2"
> > +};
> > +
> > +static const char * const mcu_armpll_bl_parents[] = {
> > +       "clk26m",
> > +       "armpll_bl",
> > +       "mainpll",
> > +       "univpll_d2"
> > +};
> > +
> > +static const char * const mcu_armpll_bus_parents[] = {
> > +       "clk26m",
> > +       "ccipll",
> > +       "mainpll",
> > +       "univpll_d2"
> > +};
> > +
> > +static struct mtk_composite mcu_muxes[] = {
> > +       /* CPU_PLLDIV_CFG0 */
> > +       MUX(CLK_MCU_ARMPLL_LL_SEL, "mcu_armpll_ll_sel",
> > mcu_armpll_ll_parents, 0x2A0, 9, 2),
> 
> Can you add a comment stating that these registers have other bits
> that
> should not be touched? Otherwise anyone reading the datasheet might
> consider this to be incomplete.
> 
> I assume the other bits (such as one field that looks like a divider)
> are
> configured in the bootloader, or the POR defaults are correct.
> 

Yes, We only control mux in linux side and keep same value in divider.
I will add more description in v4. Sorry I missed this comment before.

> > +       /* CPU_PLLDIV_CFG1 */
> > +       MUX(CLK_MCU_ARMPLL_BL_SEL, "mcu_armpll_bl_sel",
> > mcu_armpll_bl_parents, 0x2A4, 9, 2),
> > +       /* BUS_PLLDIV_CFG */
> > +       MUX(CLK_MCU_ARMPLL_BUS_SEL, "mcu_armpll_bus_sel",
> > mcu_armpll_bus_parents, 0x2E0, 9, 2),
> > +};
> 
> Note: I've checked the register bits against the datasheet.
> 
> > +
> > +static const struct of_device_id of_match_clk_mt8186_mcu[] = {
> > +       { .compatible = "mediatek,mt8186-mcusys", },
> > +       {}
> > +};
> > +
> > +static int clk_mt8186_mcu_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       struct device_node *node = pdev->dev.of_node;
> > +       int r;
> > +       void __iomem *base;
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
> > +       if (!clk_data)
> > +               return -ENOMEM;
> > +
> > +       base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(base)) {
> > +               r = PTR_ERR(base);
> > +               goto free_mcu_data;
> > +       }
> > +
> > +       r = mtk_clk_register_composites(mcu_muxes,
> > ARRAY_SIZE(mcu_muxes), base,
> > +                                       &mt8186_clk_lock,
> > clk_data);
> 
> I don't think you need the lock. None of the bit fields you have
> defined
> in this driver have overlapping registers.
> 
> 
> Regards
> ChenYu
> 

Yes, the muxes register of big and little CPU are not overlapping,
I will remove the lock in next patch.

Thanks!

> > +       if (r)
> > +               goto free_mcu_data;
> > +
> > +       r = of_clk_add_provider(node, of_clk_src_onecell_get,
> > clk_data);
> > +       if (r)
> > +               goto unregister_composite_muxes;
> > +
> > +       platform_set_drvdata(pdev, clk_data);
> > +
> > +       return r;
> > +
> > +unregister_composite_muxes:
> > +       mtk_clk_unregister_composites(mcu_muxes,
> > ARRAY_SIZE(mcu_muxes), clk_data);
> > +free_mcu_data:
> > +       mtk_free_clk_data(clk_data);
> > +       return r;
> > +}
> > +
> > +static int clk_mt8186_mcu_remove(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data =
> > platform_get_drvdata(pdev);
> > +       struct device_node *node = pdev->dev.of_node;
> > +
> > +       of_clk_del_provider(node);
> > +       mtk_clk_unregister_composites(mcu_muxes,
> > ARRAY_SIZE(mcu_muxes), clk_data);
> > +       mtk_free_clk_data(clk_data);
> > +
> > +       return 0;
> > +}
> > +
> > +static struct platform_driver clk_mt8186_mcu_drv = {
> > +       .probe = clk_mt8186_mcu_probe,
> > +       .remove = clk_mt8186_mcu_remove,
> > +       .driver = {
> > +               .name = "clk-mt8186-mcu",
> > +               .of_match_table = of_match_clk_mt8186_mcu,
> > +       },
> > +};
> > +builtin_platform_driver(clk_mt8186_mcu_drv);
> > --
> > 2.18.0
> > 

