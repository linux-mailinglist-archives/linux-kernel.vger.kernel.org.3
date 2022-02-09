Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7614AF20C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiBIMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiBIMqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:46:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AAAC0613CA;
        Wed,  9 Feb 2022 04:46:23 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i14so3802448wrc.10;
        Wed, 09 Feb 2022 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCDxWA565CQFly4+74NENwOqKnurUlmfhXdVUzF+sO4=;
        b=VTFkovW5a8OEiIlc9btuqGmq8kGo+xfSALHnxCVWJB6P6vRNzFWl+H+6+klzL08uTo
         r/+JNZhioFXmGpcXYJ4MGxMbxwks0mBZxAOHPy4JmjaucpBqvFKI4jdXHS37Du80xUAU
         p2g+WFu+cPYgKYW7eAOThvveeEJwoZ+WYi2U5I4ladD89bpL6IfeEJEDE1xF0T4qUUPk
         lKmZYf4GDWZyKZgLEyCwFb2xU9PeW/lP6HKo4CLvyyzdRfr5rh0lWAUOQ20BxK7PQ2w9
         mhZaGbUPK8zt0uNgx2W+/yVPWIrqUqIw24r4Cmfzla0pPBHe4yyanFOCtj4zUwLUvcrn
         hC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCDxWA565CQFly4+74NENwOqKnurUlmfhXdVUzF+sO4=;
        b=JRCpb0yoJ3tJfXYh9mqzMbrwgp5lwranRn32V/klMrP34QXOwyurAaDg/MdFkYyQM/
         gi0J/FemFYkAuWFGOa1Xgt+Pt5Dfyt1OAxbKoFIR5pF2VZx3ToDfX4y9WORBpDjXIoF+
         uY4GK6ttn4+tX5aMeP3LulOg5FcjLUxghi4xKRfoEWh7q/+uPYZoRXujebp48J7QpF6P
         OTo2f3ZLWk839ZnyDamzUZosIhvnlKTL40EMmZCk80Xi7SRadxnST9yXwgXK605G0wyD
         4b40Xb7LcNDLqdnePv+K2eXMz7im36AGl3IHuS5FEYRYmcXWHfzrX5G/7BqTKZAVtzF2
         6T0Q==
X-Gm-Message-State: AOAM530LUL2O34PE4gQPJXGFIZ37SoWs6BYJmhdajrpExDI02+XYfOgb
        w9MTu9GKtzGjisxKnjTPDocclfkQSNFfClUvklw=
X-Google-Smtp-Source: ABdhPJwCyVj6cw1rlWifdu4VubBw11SlOQMJK/UYfYNXFmOlesMzlUqA6kj5ZaMnWTfz9PDIMnhCh51tRlHg6dbl4nc=
X-Received: by 2002:a05:6000:2c5:: with SMTP id o5mr1961877wry.130.1644410782312;
 Wed, 09 Feb 2022 04:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com> <20220208063046.2265537-5-peng.fan@oss.nxp.com>
In-Reply-To: <20220208063046.2265537-5-peng.fan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 9 Feb 2022 14:46:09 +0200
Message-ID: <CAEnQRZA15UabGMSd_GjAdLXhidbVupz68Jh8CqVSYw-n+_4+=Q@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] mailbox: imx: support i.MX93 S401 MU
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        krzysztof.kozlowski@canonical.com, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng,

This patch is doing 3 things in one patch.

Please split this with one patch per functional change.

On Wed, Feb 9, 2022 at 1:20 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX93 S401 MU support two interrupts: tx empty and rx full.
>
>  - Introduce a new flag IMX_MU_V2_IRQ for the dual interrupt case
>  - Add i.MX93 S401 MU cfg
>  - Update author and Copyright
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 49 ++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 03699843a6fd..094dc84291fc 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
> + * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
>   */
>
>  #include <linux/clk.h>
> @@ -28,6 +29,7 @@
>  #define IMX_MU_SECO_TX_TOUT (msecs_to_jiffies(3000))
>  #define IMX_MU_SECO_RX_TOUT (msecs_to_jiffies(3000))
>
> +/* Please not change TX & RX */
>  enum imx_mu_chan_type {
>         IMX_MU_TYPE_TX,         /* Tx */
>         IMX_MU_TYPE_RX,         /* Rx */
> @@ -92,6 +94,7 @@ enum imx_mu_type {
>         IMX_MU_V1,
>         IMX_MU_V2 = BIT(1),
>         IMX_MU_V2_S4 = BIT(15),
> +       IMX_MU_V2_IRQ = BIT(16),
>  };
>
>  struct imx_mu_dcfg {
> @@ -536,7 +539,8 @@ static int imx_mu_startup(struct mbox_chan *chan)
>  {
>         struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
>         struct imx_mu_con_priv *cp = chan->con_priv;
> -       unsigned long irq_flag = IRQF_SHARED;
> +       unsigned long irq_flag = 0;
> +       int irq;
>         int ret;
>
>         pm_runtime_get_sync(priv->dev);
> @@ -551,11 +555,16 @@ static int imx_mu_startup(struct mbox_chan *chan)
>         if (!priv->dev->pm_domain)
>                 irq_flag |= IRQF_NO_SUSPEND;
>
> -       ret = request_irq(priv->irq[0], imx_mu_isr, irq_flag,
> -                         cp->irq_desc, chan);
> +       if (priv->dcfg->type & IMX_MU_V2_IRQ) {
> +               irq = priv->irq[cp->type];
> +       } else {
> +               irq = priv->irq[0];
> +               irq_flag |= IRQF_SHARED;
> +       }
> +
> +       ret = request_irq(irq, imx_mu_isr, irq_flag, cp->irq_desc, chan);
>         if (ret) {
> -               dev_err(priv->dev,
> -                       "Unable to acquire IRQ %d\n", priv->irq[0]);
> +               dev_err(priv->dev, "Unable to acquire IRQ %d\n", irq);
>                 return ret;
>         }
>
> @@ -762,14 +771,23 @@ static int imx_mu_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
>
> -       priv->irq[0] = platform_get_irq(pdev, 0);
> -       if (priv->irq[0] < 0)
> -               return priv->irq[0];
> -
>         dcfg = of_device_get_match_data(dev);
>         if (!dcfg)
>                 return -EINVAL;
>         priv->dcfg = dcfg;
> +       if (priv->dcfg->type & IMX_MU_V2_IRQ) {
> +               priv->irq[IMX_MU_TYPE_TX] = platform_get_irq_byname(pdev, "txirq");
> +               if (priv->irq[IMX_MU_TYPE_TX] < 0)
> +                       return priv->irq[IMX_MU_TYPE_TX];
> +               priv->irq[IMX_MU_TYPE_RX] = platform_get_irq_byname(pdev, "rxirq");
> +               if (priv->irq[IMX_MU_TYPE_RX] < 0)
> +                       return priv->irq[IMX_MU_TYPE_RX];
> +       } else {
> +               priv->irq[0] = platform_get_irq(pdev, 0);
> +               if (priv->irq[0] < 0)
> +                       return priv->irq[0];
> +
> +       }
>
>         if (priv->dcfg->type & IMX_MU_V2_S4)
>                 size = sizeof(struct imx_s4_rpc_msg_max);
> @@ -890,6 +908,17 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
>         .xCR    = {0x110, 0x114, 0x120, 0x128},
>  };
>
> +static const struct imx_mu_dcfg imx_mu_cfg_imx93_s4 = {
> +       .tx     = imx_mu_specific_tx,
> +       .rx     = imx_mu_specific_rx,
> +       .init   = imx_mu_init_specific,
> +       .type   = IMX_MU_V2 | IMX_MU_V2_S4 | IMX_MU_V2_IRQ,
> +       .xTR    = 0x200,
> +       .xRR    = 0x280,
> +       .xSR    = {0xC, 0x118, 0x124, 0x12C},
> +       .xCR    = {0x110, 0x114, 0x120, 0x128},
> +};
> +
>  static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
>         .tx     = imx_mu_specific_tx,
>         .rx     = imx_mu_specific_rx,
> @@ -917,6 +946,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
>         { .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
>         { .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
>         { .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
> +       { .compatible = "fsl,imx93-mu-s4", .data = &imx_mu_cfg_imx93_s4 },
>         { .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
>         { .compatible = "fsl,imx8-mu-seco", .data = &imx_mu_cfg_imx8_seco },
>         { },
> @@ -1001,5 +1031,6 @@ static struct platform_driver imx_mu_driver = {
>  module_platform_driver(imx_mu_driver);
>
>  MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
>  MODULE_DESCRIPTION("Message Unit driver for i.MX");
>  MODULE_LICENSE("GPL v2");
> --
> 2.25.1
>
