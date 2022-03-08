Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B84D25C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiCIBCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCIBCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:36 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF73E12D209;
        Tue,  8 Mar 2022 16:40:17 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so573895otq.13;
        Tue, 08 Mar 2022 16:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OiDtpHj0kLmrgL9mIblnYKZv43jpFOukaPdQEqPT+5Y=;
        b=qL7bv0KrNjilJu9PRCfYLJeNJnS1nZhV9Z/KX1ckM+h2i4BzDkWk0RjBWTKsz2Bqbm
         f2jsIZUMrgB1OfrhQDHw5roe5iOwq+ZAwMs/2r7sc5xQTERUefqYVeahEVDkDDTfNVFn
         AKd+PrUQHF5MbPEwalNIzLzy7Ybbt2S7NMpApzTSn1Tx7Qu7zEWYUvo1gqX1fRf08x6L
         pu8SzW5CuSTqIwxy7MBzgF/piXU8iiFK7WE4N0q/vLr8iEo+A40MWjToal3S69yGAaW+
         CJ5+T7atTcQIUOVlnhnDrAkqTgSqAGthRuV42FydHH758ppOnIQaZpVvCFCL2Z/eWV4d
         Lcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiDtpHj0kLmrgL9mIblnYKZv43jpFOukaPdQEqPT+5Y=;
        b=UmM1N9BqjeIYgHc8JtF8gmGYhG16jLjChHmwSuo/7w4XyEVchs0qMGipmb7DRgp1ar
         6S8bMU5OSxFOiHILDW5KEouOLpo3req5pDMy9wEDtLG5nHW9+E7kU5V3gsmmVR0vteF/
         d/jOhbcn3kzL8tXwFzG5zA6E9g6OK7DAiL3Tz34MQ2FEwO698N6zFZRjBHsok5C4/lyd
         LUvN/jmOMvATbj30WG+TvndkR9dgo7JiDe6k3jSw4ND0U7qQu8C8u1BrMQJqxieiGYIl
         GzIfs9wov/RNN9QxL410LN5oqtPxzapaIB2W9NnkoSiVTIbhgg3I9kspVGrRY3ZjIEmE
         BgsQ==
X-Gm-Message-State: AOAM5335lwrx5IkDbvc2zHoMqLzmQO57IzBINHR/ecu8IGIRNoAq4qrA
        alnx+/Hek01U2N/AYZ1O8Iv/wo7l6rRrsYLVhhV6HT3QHvKT+A==
X-Google-Smtp-Source: ABdhPJzCistFgkg33wnaroodJ3xp0sw2F2DGERIEzTWtqMYtdIIvZ/VNegjo7IiaOIUBEoCfUbcplAaOVoQJuWOrIHU=
X-Received: by 2002:a81:998c:0:b0:2d7:7e7d:877d with SMTP id
 q134-20020a81998c000000b002d77e7d877dmr15120688ywg.78.1646782871514; Tue, 08
 Mar 2022 15:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20220308064228.2078109-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220308064228.2078109-1-chi.minghao@zte.com.cn>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 8 Mar 2022 23:40:45 +0000
Message-ID: <CA+V-a8uVzmeeqer_bdqQyCpTNgVwJUDuoLgYmVugZYZevyTnyQ@mail.gmail.com>
Subject: Re: [PATCH] media: davinci: Use platform_get_irq() to get the interrupt
To:     cgel.zte@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 6:42 AM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/media/platform/davinci/vpfe_capture.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
NAK!

vpfe_capture driver doesn't support DT.

Cheers,
Prabhakar

> diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
> index 0a2226b321d7..b3cafa16a1ad 100644
> --- a/drivers/media/platform/davinci/vpfe_capture.c
> +++ b/drivers/media/platform/davinci/vpfe_capture.c
> @@ -1674,11 +1674,10 @@ static int vpfe_probe(struct platform_device *pdev)
>  {
>         struct vpfe_subdev_info *sdinfo;
>         struct vpfe_config *vpfe_cfg;
> -       struct resource *res1;
>         struct vpfe_device *vpfe_dev;
>         struct i2c_adapter *i2c_adap;
>         struct video_device *vfd;
> -       int ret, i, j;
> +       int ret, i, j, irq;
>         int num_subdevs = 0;
>
>         /* Get the pointer to the device object */
> @@ -1717,24 +1716,24 @@ static int vpfe_probe(struct platform_device *pdev)
>
>         strscpy(ccdc_cfg->name, vpfe_cfg->ccdc, sizeof(ccdc_cfg->name));
>         /* Get VINT0 irq resource */
> -       res1 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -       if (!res1) {
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
>                 v4l2_err(pdev->dev.driver,
>                          "Unable to get interrupt for VINT0\n");
>                 ret = -ENODEV;
>                 goto probe_free_ccdc_cfg_mem;
>         }
> -       vpfe_dev->ccdc_irq0 = res1->start;
> +       vpfe_dev->ccdc_irq0 = irq;
>
>         /* Get VINT1 irq resource */
> -       res1 = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
> -       if (!res1) {
> +       irq = platform_get_irq(pdev, 1);
> +       if (irq < 0) {
>                 v4l2_err(pdev->dev.driver,
>                          "Unable to get interrupt for VINT1\n");
>                 ret = -ENODEV;
>                 goto probe_free_ccdc_cfg_mem;
>         }
> -       vpfe_dev->ccdc_irq1 = res1->start;
> +       vpfe_dev->ccdc_irq1 = irq;
>
>         ret = request_irq(vpfe_dev->ccdc_irq0, vpfe_isr, 0,
>                           "vpfe_capture0", vpfe_dev);
> --
> 2.25.1
>
