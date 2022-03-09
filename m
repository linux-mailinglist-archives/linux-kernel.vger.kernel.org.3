Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63174D2CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiCIKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiCIKPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:15:12 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BAE142359
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:14:11 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id h126so3327059ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCZhZco+0KFMyvuCDhItj2e0NHWXHNetfjkFnAqoWkA=;
        b=S3cgBjeFwa4noJjQAcXN/JsibairXFtbUXo1zZduqt6MBg4NTVWQlXy7CyORsMtfCJ
         Yb79zDE3TZGRo+HW0IYQLkcA4VssO3t3ZLZoE/IcyyvJeDhjJb+gnDLXoP4eKepJ1mMp
         sCiw8DlUD8HAf1zQRugIGTRzk/SD/ww4tm4hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCZhZco+0KFMyvuCDhItj2e0NHWXHNetfjkFnAqoWkA=;
        b=ILX0x6x0i7MWp20exagAI2/S53N45TETNVyzFq+S8pX/oiloKP7x/z4QCQmxjZ/264
         eSxoQKjlJEAXui3RVZiQALNY//090U4EzZGgzRhsjPpI8jxGJiw77V9ztncKphRg6cYH
         G8gSsMx1z3G217vLiv9E4v+CDYmBTWv8kxDBHx1i2KCQNvBC4hkExk2IWlwOj1v9ov1W
         zKN8IoPyifegNaXVdKWFtRbSmzEqQLel8WhmdEQQWQJuaMR5zzmlMLZvFzo3mSSDZOtl
         Ixkkrh7DVMTLdlx9SoBXGBMDu+Uam+yO0WbJs06lJaNIhLOvHOxrsS/pFGS3iUuBFkR5
         EoVg==
X-Gm-Message-State: AOAM531w24jGUrOgxpNFNSZrhngfLa/ULTGI+cE6IDJfJnjBSNR2H0io
        bU/bG+TvACXqNf7/uxQBPhlP/UvnKkbx/GmW4UQ62g==
X-Google-Smtp-Source: ABdhPJx2cW0ywz0SegJTQ+R92hI1gP1aKA2eosKmS45iuxzgvK62ipaxN+q/w5JWJ9Th9IBnbmcaCuX8B0vy11f6CL4=
X-Received: by 2002:a25:d449:0:b0:628:945d:713c with SMTP id
 m70-20020a25d449000000b00628945d713cmr16379825ybf.164.1646820850490; Wed, 09
 Mar 2022 02:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20220221015258.913-1-chun-jie.chen@mediatek.com> <20220221015258.913-3-chun-jie.chen@mediatek.com>
In-Reply-To: <20220221015258.913-3-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 9 Mar 2022 18:13:59 +0800
Message-ID: <CAGXv+5Fq4_dZBWJvKZ8ADUSQF4bTu-QWZ+7KG1dsJoWDrT2nXg@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] clk: mediatek: Add MT8186 mcusys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 21, 2022 at 9:59 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8186 mcusys clock controller which provides muxes
> to select the clock source of APMCU.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig          |   8 ++
>  drivers/clk/mediatek/Makefile         |   1 +
>  drivers/clk/mediatek/clk-mt8186-mcu.c | 106 ++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt8186-mcu.c
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 01ef02c54725..d5936cfb3bee 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -512,6 +512,14 @@ config COMMON_CLK_MT8183_VENCSYS
>         help
>           This driver supports MediaTek MT8183 vencsys clocks.
>
> +config COMMON_CLK_MT8186
> +       bool "Clock driver for MediaTek MT8186"
> +       depends on ARM64 || COMPILE_TEST
> +       select COMMON_CLK_MEDIATEK
> +       default ARCH_MEDIATEK
> +       help
> +         This driver supports MediaTek MT8186 clocks.
> +
>  config COMMON_CLK_MT8192
>         bool "Clock driver for MediaTek MT8192"
>         depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 7b0c2646ce4a..677fa4f0eea2 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_MFGCFG) += clk-mt8183-mfgcfg.o
>  obj-$(CONFIG_COMMON_CLK_MT8183_MMSYS) += clk-mt8183-mm.o
>  obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
> +obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o
>  obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
> diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
> new file mode 100644
> index 000000000000..6d82c5de16c1
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2022 MediaTek Inc.
> +// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +#include "clk-mtk.h"

Please move local headers after global ones. And please do this for all
patches.

> +
> +#include <dt-bindings/clock/mt8186-clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +static DEFINE_SPINLOCK(mt8186_clk_lock);
> +
> +static const char * const mcu_armpll_ll_parents[] = {
> +       "clk26m",
> +       "armpll_ll",
> +       "mainpll",
> +       "univpll_d2"
> +};
> +
> +static const char * const mcu_armpll_bl_parents[] = {
> +       "clk26m",
> +       "armpll_bl",
> +       "mainpll",
> +       "univpll_d2"
> +};
> +
> +static const char * const mcu_armpll_bus_parents[] = {
> +       "clk26m",
> +       "ccipll",
> +       "mainpll",
> +       "univpll_d2"
> +};
> +
> +static struct mtk_composite mcu_muxes[] = {
> +       /* CPU_PLLDIV_CFG0 */
> +       MUX(CLK_MCU_ARMPLL_LL_SEL, "mcu_armpll_ll_sel", mcu_armpll_ll_parents, 0x2A0, 9, 2),

Can you add a comment stating that these registers have other bits that
should not be touched? Otherwise anyone reading the datasheet might
consider this to be incomplete.

I assume the other bits (such as one field that looks like a divider) are
configured in the bootloader, or the POR defaults are correct.

> +       /* CPU_PLLDIV_CFG1 */
> +       MUX(CLK_MCU_ARMPLL_BL_SEL, "mcu_armpll_bl_sel", mcu_armpll_bl_parents, 0x2A4, 9, 2),
> +       /* BUS_PLLDIV_CFG */
> +       MUX(CLK_MCU_ARMPLL_BUS_SEL, "mcu_armpll_bus_sel", mcu_armpll_bus_parents, 0x2E0, 9, 2),
> +};

Note: I've checked the register bits against the datasheet.

> +
> +static const struct of_device_id of_match_clk_mt8186_mcu[] = {
> +       { .compatible = "mediatek,mt8186-mcusys", },
> +       {}
> +};
> +
> +static int clk_mt8186_mcu_probe(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data;
> +       struct device_node *node = pdev->dev.of_node;
> +       int r;
> +       void __iomem *base;
> +
> +       clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base)) {
> +               r = PTR_ERR(base);
> +               goto free_mcu_data;
> +       }
> +
> +       r = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
> +                                       &mt8186_clk_lock, clk_data);

I don't think you need the lock. None of the bit fields you have defined
in this driver have overlapping registers.


Regards
ChenYu

> +       if (r)
> +               goto free_mcu_data;
> +
> +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +       if (r)
> +               goto unregister_composite_muxes;
> +
> +       platform_set_drvdata(pdev, clk_data);
> +
> +       return r;
> +
> +unregister_composite_muxes:
> +       mtk_clk_unregister_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), clk_data);
> +free_mcu_data:
> +       mtk_free_clk_data(clk_data);
> +       return r;
> +}
> +
> +static int clk_mt8186_mcu_remove(struct platform_device *pdev)
> +{
> +       struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +       struct device_node *node = pdev->dev.of_node;
> +
> +       of_clk_del_provider(node);
> +       mtk_clk_unregister_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), clk_data);
> +       mtk_free_clk_data(clk_data);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver clk_mt8186_mcu_drv = {
> +       .probe = clk_mt8186_mcu_probe,
> +       .remove = clk_mt8186_mcu_remove,
> +       .driver = {
> +               .name = "clk-mt8186-mcu",
> +               .of_match_table = of_match_clk_mt8186_mcu,
> +       },
> +};
> +builtin_platform_driver(clk_mt8186_mcu_drv);
> --
> 2.18.0
>
