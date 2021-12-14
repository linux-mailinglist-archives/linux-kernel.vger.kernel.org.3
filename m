Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8348473B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhLNDkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhLNDka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:40:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD53C061574;
        Mon, 13 Dec 2021 19:40:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so59506649edu.4;
        Mon, 13 Dec 2021 19:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGvjFXTcjcxmedBMr5Eg6ESipNuMk/cS8aRWqu3L/gQ=;
        b=cbp6PXlg5GBnn2jNS4KPj4XdJJe/9dm3sOPF0h8RSD4P9owquu0LrKQCtB3Grgn1zj
         97D/hthrYA8Blx7z+SU2Wkr0hF6WhM0JILrEHECFeqXHyTrbw/QsR5qDt1rQKP86bJKe
         y54+G2q6WfMxATPn1tJKdjts0/NkvPFotnL5hhu7924jA7KJ47kOtOaLUP+8PGfWcSZB
         jD83y96JZTv+Bund/hMYJvyffaMfS6tRy203uFgXMiv4u5B/eKyVfFd8pzOBHI0cght+
         Mse6EigpU+JIMNGYX5PfzHbTDfmI6iiuDKtbb1uawc1zRLksQIG13UAHlcC2eU4VaYMW
         1u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGvjFXTcjcxmedBMr5Eg6ESipNuMk/cS8aRWqu3L/gQ=;
        b=ilffro7FRYYjlf23VvOlohH9E64XX9CZhFu3z71AJiY4NB/+fdEgWyN3EKI5JTaHvm
         P8SR/z0t74NyCc2OMEXlFfpo6l63TSHKZRILsIabB055vPbHJ38kMq3rEUI9sW2jchTx
         UoE11GBva2KZ+sg3IUn2kQIyVuHldTJQr9BGk0K7EbY28p4qi28vvDRtZnUP5c+SNK+D
         ew7QeSaoO85yQ63+W/fObbb3uhlRMyDxOQIXBsPF7T8HP958GE9FS9UJMyRaa0rYSEVc
         SFWvfD+9NtSsRld1clSkBetVO8nyZLZXTjRCMu2B2hW8+aIWluOHd+F72wIChK7D2R4h
         qSRw==
X-Gm-Message-State: AOAM530sSjrpCHUroAaKfe611Ce3xw2CUKBY9jYTOZGR+i8THkruGEmK
        /MJOMvLl9Kg98AYPZ0m5pWBfahL15LSSclHJ1Zs/Vbl6
X-Google-Smtp-Source: ABdhPJzPgfxGI1sJNvqcW5T0ES7dng/oYeWXHRMKJ14v8u60jjA6kpNpkNBo1/Rzo53PsL1ToLFSTUr+sFd1NfOkoMs=
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr4085276edv.333.1639453227988;
 Mon, 13 Dec 2021 19:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20211128131853.15125-1-aford173@gmail.com> <20211128131853.15125-6-aford173@gmail.com>
In-Reply-To: <20211128131853.15125-6-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 13 Dec 2021 21:40:17 -0600
Message-ID: <CAHCN7xJW14D8BVx1op+V9EAxcFFidSDkN1LN1rdHvG2TNHVtNg@mail.gmail.com>
Subject: Re: [PATCH V4 5/9] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 7:19 AM Adam Ford <aford173@gmail.com> wrote:
>
> This adds the description for the i.MX8MN disp blk-ctrl.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Lucas,

Is there any chance you could give this series some feedback?  In
order to get more functionality on the Nano, we need the blk-ctrl on
Nano working.

thanks,

adam

> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 77 +++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index c2f076b56e24..511e74f0db8a 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>
>  #include <dt-bindings/power/imx8mm-power.h>
> +#include <dt-bindings/power/imx8mn-power.h>
>
>  #define BLK_SFT_RSTN   0x0
>  #define BLK_CLK_EN     0x4
> @@ -517,6 +518,77 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
>         .num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
>  };
>
> +
> +static int imx8mn_disp_power_notifier(struct notifier_block *nb,
> +                                     unsigned long action, void *data)
> +{
> +       struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
> +                                                power_nb);
> +
> +       if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
> +               return NOTIFY_OK;
> +
> +       /* Enable bus clock and deassert bus reset */
> +       regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
> +       regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
> +
> +       /*
> +        * On power up we have no software backchannel to the GPC to
> +        * wait for the ADB handshake to happen, so we just delay for a
> +        * bit. On power down the GPC driver waits for the handshake.
> +        */
> +       if (action == GENPD_NOTIFY_ON)
> +               udelay(5);
> +
> +
> +       return NOTIFY_OK;
> +}
> +
> +static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
> +       [IMX8MN_DISPBLK_PD_MIPI_DSI] = {
> +               .name = "dispblk-mipi-dsi",
> +               .clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
> +               .num_clks = 2,
> +               .gpc_name = "mipi-dsi",
> +               .rst_mask = BIT(0) | BIT(1),
> +               .clk_mask = BIT(0) | BIT(1),
> +               .mipi_phy_rst_mask = BIT(17),
> +       },
> +       [IMX8MN_DISPBLK_PD_MIPI_CSI] = {
> +               .name = "dispblk-mipi-csi",
> +               .clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
> +               .num_clks = 2,
> +               .gpc_name = "mipi-csi",
> +               .rst_mask = BIT(2) | BIT(3),
> +               .clk_mask = BIT(2) | BIT(3),
> +               .mipi_phy_rst_mask = BIT(16),
> +       },
> +       [IMX8MN_DISPBLK_PD_LCDIF] = {
> +               .name = "dispblk-lcdif",
> +               .clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
> +               .num_clks = 3,
> +               .gpc_name = "lcdif",
> +               .rst_mask = BIT(4) | BIT(5),
> +               .clk_mask = BIT(4) | BIT(5),
> +       },
> +       [IMX8MN_DISPBLK_PD_ISI] = {
> +               .name = "dispblk-isi",
> +               .clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
> +                                               "disp_apb_root"},
> +               .num_clks = 4,
> +               .gpc_name = "isi",
> +               .rst_mask = BIT(6) | BIT(7),
> +               .clk_mask = BIT(6) | BIT(7),
> +       },
> +};
> +
> +static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
> +       .max_reg = 0x84,
> +       .power_notifier_fn = imx8mn_disp_power_notifier,
> +       .domains = imx8mn_disp_blk_ctl_domain_data,
> +       .num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
> +};
> +
>  static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
>         {
>                 .compatible = "fsl,imx8mm-vpu-blk-ctrl",
> @@ -524,7 +596,10 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
>         }, {
>                 .compatible = "fsl,imx8mm-disp-blk-ctrl",
>                 .data = &imx8mm_disp_blk_ctl_dev_data
> -       } ,{
> +       }, {
> +               .compatible = "fsl,imx8mn-disp-blk-ctrl",
> +               .data = &imx8mn_disp_blk_ctl_dev_data
> +       }, {
>                 /* Sentinel */
>         }
>  };
> --
> 2.32.0
>
