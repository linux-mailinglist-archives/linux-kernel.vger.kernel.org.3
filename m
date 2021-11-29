Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761524624D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhK2WbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhK2W3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:29:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C53C0048F3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:26:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id k4so7447673pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AV6AyLtV6+B+PQXfrHfipcjFSD3Gvf5bjWSa9SiKB0=;
        b=jlpxmigLd0jQtZFZPdr2laNq83gnRdwoIXEgWfc2SfGv+aa9nAgB53NXLHkNFtYitz
         1tq1cZjSBQ4PaiGIB6Kk9xr+qWxGiuCfB0UFiKEYPbqgJNSBlmrZJEqKoXizpbHBAIp8
         BOaJexldrIOz1gdn7z7ObDROSyrM2siZRg65tsG3iusU649Z8qow9Ap32EGsiuXQCT/H
         ur+98e51ugYqFlCSyZAI/IbWvxEGQtP8SoLfcbeEmWxZPiXgbAyn3/Sgtc3TTB6E59AP
         QUgZP0BvzUXlDxjP84PS/pabnMgpUt7UizbvA/ttJ0xiLTlN5RkyzDygQ3AU9r96l1Gd
         2udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AV6AyLtV6+B+PQXfrHfipcjFSD3Gvf5bjWSa9SiKB0=;
        b=7T2IZ+2fGh6bz3SH4M/8SEI4gq7sT/WhJMjQPKofhdUH9VPkkV7WBwn3txaxuntGAj
         pEeRQGFBMUWQv0RbTK9EFqpQGQXEgZKwVinj76Bt016UpA9IOEipOnzd2oSrSFwo8kSV
         pHp6+EXiZqdooF8+2Or90gbTE3OxWbtmIiuEWesH/D36GJU5AhBb2HTdZ1K5K5xNGdSV
         M4pJJpPdOoHK/QEBZ6QblGQhm2FDVY3r4L7rEXyz7M681AFDd0VEuJSl9ZaNn5iSAMGP
         aAhLdYUgPh9AAjLsavSjG+tvwdEcMwcnEUCg/DxnXKXqWvBcfZINUlTLmnOmlbk96z52
         0sZA==
X-Gm-Message-State: AOAM531TcnPB6rKV3PCoUYAnMaVMUIdLM4HWClq6IDfm/MjWcZzTcKEM
        QS8b9uiQywJkuj1j/xcWtvJaIoVbLB5Zx3Hf/XdscA==
X-Google-Smtp-Source: ABdhPJxmIVqDVd2ueYUBshdrTHHWMA5CdKXSLGpFAP+cONd8fUMBDIMzmtDG0weM1Bfd88BWilM88gG4Z9OvooJGiE0=
X-Received: by 2002:a63:4244:: with SMTP id p65mr37573466pga.440.1638224772352;
 Mon, 29 Nov 2021 14:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20211128125011.12817-1-aford173@gmail.com>
In-Reply-To: <20211128125011.12817-1-aford173@gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 29 Nov 2021 14:26:01 -0800
Message-ID: <CAJ+vNU11JzuREzY8-0V0GTXTqL3Yb-6vQCTvu08Sx63aQPc-gg@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] soc: imx: imx8m-blk-ctrl: Fix imx8mm mipi reset
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 4:50 AM Adam Ford <aford173@gmail.com> wrote:
>
> Most of the blk-ctrl reset bits are found in one register, however
> there are two bits in offset 8 for pulling the MIPI DPHY out of reset
> and one of them needs to be set when IMX8MM_DISPBLK_PD_MIPI_CSI is brought
> out of reset or the MIPI_CSI hangs.
>
> Since MIPI_DSI is impacted, add the additional one for MIPI_DSI too.
>
> Fixes: 926e57c065df ("soc: imx: imx8m-blk-ctrl: add DISP blk-ctrl")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> V3:  Split the  mipi_phy_rst_mask for CSI and DSI into their respective domains.
>
> V2:  Make a note that the extra register is only for Mini/Nano DISPLAY_BLK_CTRL
>      Rename the new register to mipi_phy_rst_mask
>      Encapsulate the edits to this register with an if-statement
>
>  drivers/soc/imx/imx8m-blk-ctrl.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index 519b3651d1d9..c2f076b56e24 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -17,6 +17,7 @@
>
>  #define BLK_SFT_RSTN   0x0
>  #define BLK_CLK_EN     0x4
> +#define BLK_MIPI_RESET_DIV     0x8 /* Mini/Nano DISPLAY_BLK_CTRL only */
>
>  struct imx8m_blk_ctrl_domain;
>
> @@ -36,6 +37,15 @@ struct imx8m_blk_ctrl_domain_data {
>         const char *gpc_name;
>         u32 rst_mask;
>         u32 clk_mask;
> +
> +       /*
> +        * i.MX8M Mini and Nano have a third DISPLAY_BLK_CTRL register
> +        * which is used to control the reset for the MIPI Phy.
> +        * Since it's only present in certain circumstances,
> +        * an if-statement should be used before setting and clearing this
> +        * register.
> +        */
> +       u32 mipi_phy_rst_mask;
>  };
>
>  #define DOMAIN_MAX_CLKS 3
> @@ -78,6 +88,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>
>         /* put devices into reset */
>         regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +       if (data->mipi_phy_rst_mask)
> +               regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>
>         /* enable upstream and blk-ctrl clocks to allow reset to propagate */
>         ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
> @@ -99,6 +111,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>
>         /* release reset */
>         regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
> +       if (data->mipi_phy_rst_mask)
> +               regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
>
>         /* disable upstream clocks */
>         clk_bulk_disable_unprepare(data->num_clks, domain->clks);
> @@ -120,6 +134,9 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>         struct imx8m_blk_ctrl *bc = domain->bc;
>
>         /* put devices into reset and disable clocks */
> +       if (data->mipi_phy_rst_mask)
> +               regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
> +
>         regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
>         regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>
> @@ -480,6 +497,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
>                 .gpc_name = "mipi-dsi",
>                 .rst_mask = BIT(5),
>                 .clk_mask = BIT(8) | BIT(9),
> +               .mipi_phy_rst_mask = BIT(17),
>         },
>         [IMX8MM_DISPBLK_PD_MIPI_CSI] = {
>                 .name = "dispblk-mipi-csi",
> @@ -488,6 +506,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[]
>                 .gpc_name = "mipi-csi",
>                 .rst_mask = BIT(3) | BIT(4),
>                 .clk_mask = BIT(10) | BIT(11),
> +               .mipi_phy_rst_mask = BIT(16),
>         },
>  };
>
> --
> 2.32.0
>

Adam,

Thanks - this is working on my hardware as well and I can display what
is captured on an imx219 to a dsi display.

Tested by: Tim Harvey <tharvey@gateworks.com> (tested on
imx8mm-venice-gw73xx-0x with imx219 support added)

Tim
