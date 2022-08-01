Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59CD5867EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHALJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHALJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:09:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A942BB16;
        Mon,  1 Aug 2022 04:09:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r186so9379923pgr.2;
        Mon, 01 Aug 2022 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ThouaRpzDngDpnhnV/sEkyZDPfhBgGJMe4A3dCp3YvY=;
        b=eOKpwjEgaDcdGHflN0B8jI0iHFaHG/OQUne+x3jM5O0yxMoh827p7s4F3EATCbpyyF
         PgwPuqNlRj8xpAIdRPeEPP6pHbm8okHOe/TvCR+wvewkxRrH25u6JJ2R0YkxE2/L6+qk
         J4CHarOJFMZdYbbj9BUZwtxNpWI2ZCFN5YPg+DenKnM9SQ28RESgy9/0UIrK26qOc35Q
         91t0pbmDZw+8NxQ7YLuPcUpHva+dYromkf7TB87MiAqEtEha42oa02LB7TCgnpzz/jI1
         uFDUk9mvPawtr2nei51/glDDwMQvyhCyDRugcBCz+mWHt36fUG98tCm8vjvIJllNdGF7
         fCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ThouaRpzDngDpnhnV/sEkyZDPfhBgGJMe4A3dCp3YvY=;
        b=AmBUakJ1vLJZMvdcDbGniPP5tl78ffgorQqDYh0gv5iu2G2KV35K26qN0OH4VeI0VS
         qT/W0FP9wKkwnRcQ5kUsjpv2hCLCArL4YAyFyLORgLgQ6gBwWmbDGGIjcqZdG2OF923F
         1PEPHEXiBlW5c87NlUy9KnVdqK7m8a0ucBsH4nPgZB1W/3Pzgfk1yHR9uQeKf/x43LYW
         UwMHNDscqwzGZX/UuttZIf8YirQlTlOsDVnAK0UYL1vP4S1NEMsu/1KPD0J1f8qSefu3
         bxseKNm5bv/gb9T4+rZ3uO3Bi7nxitabAee2UMWWJ9u6AtH015lSSBjVrgMSgY7NqYhz
         YuLA==
X-Gm-Message-State: AJIora9dm7YF+FzNocvk2l5CN38JArquPt6KctOges19hj1mBXT7q41f
        B5A9nZhtRkVeaKilorY75tScp3Oxt4yoTr59XBo=
X-Google-Smtp-Source: AGRyM1sRbtElPKpg/jcbtV5Lq9Rtvp6p8euUedML5vBaf910Z+3NKXmuOARbE5Fje/v3U4F6W2rrnKD+doDAYw4Np/o=
X-Received: by 2002:a63:d90b:0:b0:41a:ff05:4808 with SMTP id
 r11-20020a63d90b000000b0041aff054808mr13046734pgg.159.1659352160760; Mon, 01
 Aug 2022 04:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-3-nagasuresh.relli@microchip.com> <283bdfef-cbd9-5d87-f77d-10f007c37a0c@microchip.com>
In-Reply-To: <283bdfef-cbd9-5d87-f77d-10f007c37a0c@microchip.com>
From:   naga sureshkumar <nagasuresh12@gmail.com>
Date:   Mon, 1 Aug 2022 16:39:09 +0530
Message-ID: <CAH_iE_1Khx=qAKWwWcL56fLQeutP-DvYvC4VMd_zzzxKkMrJLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: microchip-core-qspi: Add support for microchip
 fpga qspi controllers
To:     Conor.Dooley@microchip.com
Cc:     Nagasuresh.Relli@microchip.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Aug 1, 2022 at 4:19 PM <Conor.Dooley@microchip.com> wrote:
>
> On 01/08/2022 10:42, Naga Sureshkumar Relli wrote:
> > Add a driver for Microchip FPGA QSPI controllers. This driver also
> > supports "hard" QSPI controllers on Polarfire SoC.
> >
> > Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> > ---
>
> ---8<---
>
> > +static int mchp_coreqspi_probe(struct platform_device *pdev)
> > +{
> > +     struct spi_controller *ctlr;
> > +     struct mchp_coreqspi *qspi;
> > +     struct device *dev = &pdev->dev;
> > +     struct device_node *np = dev->of_node;
> > +     int ret;
> > +
> > +     ctlr = spi_alloc_master(&pdev->dev, sizeof(*qspi));
> > +     if (!ctlr)
> > +             return -ENOMEM;
>
> Argh... I am sorry for not mentioning this when you asked me if
> I thought the driver was ready to be sent upstream, but I think
> we should try to use the devm_ versions of these functions.
Ok.
>
> > +
> > +     qspi = spi_controller_get_devdata(ctlr);
>
> Is there a reason to use spi_controller_get_devdata() rather than
> spi_master_get_devdata() ?
Both are the same.
https://github.com/torvalds/linux/blob/master/include/linux/spi/spi.h#L1497
Ref: https://github.com/torvalds/linux/commit/8caab75fd2c2a92667cbb1cd315720bede3feaa9
>
> > +     platform_set_drvdata(pdev, qspi);
> > +
> > +     qspi->regs = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(qspi->regs)) {
> > +             ret = PTR_ERR(qspi->regs);
> > +             goto remove_master;
>
> Using devm_spi_alloc_master() above would simplify this
> to just a return of dev_err_probe() & ditto for every
> time we do a "goto remove_master"
Ok. I will update to use devm_ versions.
>
> > +     }
> > +
> > +     qspi->clk = devm_clk_get(&pdev->dev, NULL);
> > +     if (IS_ERR(qspi->clk)) {
> > +             dev_err(&pdev->dev, "clock not found.\n");
> > +             ret = PTR_ERR(qspi->clk);
> > +             goto remove_master;
> > +     }
> > +
> > +     ret = clk_prepare_enable(qspi->clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "failed to enable clock\n");
> > +             goto remove_master;
> > +     }
> > +
> > +     init_completion(&qspi->data_completion);
> > +     mutex_init(&qspi->op_lock);
> > +
> > +     qspi->irq = platform_get_irq(pdev, 0);
> > +     if (qspi->irq <= 0) {
> > +             ret = qspi->irq;
> > +             goto clk_dis_all;
> > +     }
> > +
> > +     ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
> > +                            0, pdev->name, qspi);
> > +     if (ret != 0) {
> > +             dev_err(&pdev->dev, "request_irq failed %d\n", ret);
> > +             goto clk_dis_all;
> > +     }
> > +
> > +     ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
> > +     ctlr->mem_ops = &mchp_coreqspi_mem_ops;
> > +     ctlr->setup = mchp_coreqspi_setup_op;
> > +     ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
> > +                       SPI_TX_DUAL | SPI_TX_QUAD;
> > +     ctlr->dev.of_node = np;
> > +
> > +     ret = devm_spi_register_controller(&pdev->dev, ctlr);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "spi_register_controller failed\n");
> > +             goto clk_dis_all;
> > +     }
> > +
> > +     return 0;
> > +
> > +clk_dis_all:
> > +     clk_disable_unprepare(qspi->clk);
>
> If we move the clk prepare & enable later in probe, ie after
> getting the irq, this goto could be removed too because the
> only place requiring teardown of the clock would be the error
> path of devm_spi_register_controller().
ok.
>
> > +remove_master:
> > +     spi_controller_put(ctlr);
>
> With devm_spi_alloc_master() this put is no longer needed &
> we can return a nice dev_err_probe() for each error :)
ok. I will send the next version with these updates.
>
> > +
> > +     return ret;
> > +}
>
> Thanks Suresh.
> Conor.
