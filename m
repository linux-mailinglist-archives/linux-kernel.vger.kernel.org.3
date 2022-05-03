Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735D2518B95
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiECR6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbiECR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:58:39 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4AD3B29F;
        Tue,  3 May 2022 10:55:06 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so6326194otk.2;
        Tue, 03 May 2022 10:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZZo2FBQdHNqH/5Ul07nNend7TJWI/BleYJWuwRpwI2E=;
        b=g57sxiLYIcwv8taAMGFQnzhlyluZeFsgK8DSRNAv+3rW/G38elIghDej4iWLPu6huo
         +9K9qSPtfkrePjahJbuQ4mqgPZwkhKB/jfzj2afdAUUTO/Bm+IUSSHjBFzKx69JSQGeR
         hzNIqAKeMbPb8VvL6M2a9JI6qhhoAHUz9180eTh3kxpfpfLBuFUAvqJvVHEYl7oF+QgQ
         Ad8aQSFdSN/fZEEtUYXcVp4F4Bb3L9pqdxbxhuYV6QJMAaxsxuT6mhE+tbn1/TjuCoMj
         B654KbaWcPqCJWq/anYmW8FXSMKnWCoZqANnsVSwFjaTooMYf1HzOVyW5PGV+mVFE1O1
         hHvA==
X-Gm-Message-State: AOAM533Vp/GdsdXRMrmpooEnQWjBsqsVufkFAw2Og6oI1EvQX57foEnS
        yUVDVOm2eoKmlicJ11crtA==
X-Google-Smtp-Source: ABdhPJwdaRnHFUgHPlJemaTsR7uzxfoyu0Qkat2ke0I3c1OwbntDBxhxcWdOIlhaLbPBYWN8g4E+xg==
X-Received: by 2002:a9d:6c93:0:b0:605:d7a8:7930 with SMTP id c19-20020a9d6c93000000b00605d7a87930mr6294448otr.254.1651600505622;
        Tue, 03 May 2022 10:55:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000e686d13884sm130797oag.30.2022.05.03.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:55:05 -0700 (PDT)
Received: (nullmailer pid 3955241 invoked by uid 1000);
        Tue, 03 May 2022 17:55:04 -0000
Date:   Tue, 3 May 2022 12:55:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tao Ren <rentao.bupt@gmail.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: Re: [PATCH v6 03/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
Message-ID: <YnFseFBfe5eaIqg0@robh.at.kernel.org>
References: <20220503060634.122722-1-clg@kaod.org>
 <20220503060634.122722-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503060634.122722-4-clg@kaod.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 08:06:26AM +0200, Cédric Le Goater wrote:
> This SPI driver adds support for the Aspeed static memory controllers
> of the AST2600, AST2500 and AST2400 SoCs using the spi-mem interface.
> 
>  * AST2600 Firmware SPI Memory Controller (FMC)
>    . BMC firmware
>    . 3 chip select pins (CE0 ~ CE2)
>    . Only supports SPI type flash memory
>    . different segment register interface
>    . single, dual and quad mode.
> 
>  * AST2600 SPI Flash Controller (SPI1 and SPI2)
>    . host firmware
>    . 2 chip select pins (CE0 ~ CE1)
>    . different segment register interface
>    . single, dual and quad mode.
> 
>  * AST2500 Firmware SPI Memory Controller (FMC)
>    . BMC firmware
>    . 3 chip select pins (CE0 ~ CE2)
>    . supports SPI type flash memory (CE0-CE1)
>    . CE2 can be of NOR type flash but this is not supported by the driver
>    . single, dual mode.
> 
>  * AST2500 SPI Flash Controller (SPI1 and SPI2)
>    . host firmware
>    . 2 chip select pins (CE0 ~ CE1)
>    . single, dual mode.
> 
>  * AST2400 New Static Memory Controller (also referred as FMC)
>    . BMC firmware
>    . New register set
>    . 5 chip select pins (CE0 ∼ CE4)
>    . supports NOR flash, NAND flash and SPI flash memory.
>    . single, dual and quad mode.
> 
> Each controller has a memory range on which flash devices contents are
> mapped. Each device is assigned a window that can be changed at bootime
> with the Segment Address Registers.
> 
> Each SPI flash device can then be accessed in two modes: Command and
> User. When in User mode, SPI transfers are initiated with accesses to
> the memory segment of a device. When in Command mode, memory
> operations on the memory segment of a device generate SPI commands
> automatically using a Control Register for the settings.
> 
> This initial patch adds support for User mode. Command mode needs a little
> more work to check that the memory window on the AHB bus fits the device
> size. It will come later when support for direct mapping is added.
> 
> Single and dual mode RX transfers are supported. Other types than SPI
> are not supported.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>
> Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  drivers/mtd/spi-nor/controllers/aspeed-smc.c  | 921 ------------------
>  drivers/spi/spi-aspeed-smc.c                  | 717 ++++++++++++++
>  .../devicetree/bindings/mtd/aspeed-smc.txt    |  51 -

This belongs with the binding patch. But then it is converting rather 
than adding a binding. You should be converting the binding and then 
adding to it (like adding 2600 support).

>  MAINTAINERS                                   |   1 +
>  drivers/mtd/spi-nor/controllers/Kconfig       |  10 -
>  drivers/mtd/spi-nor/controllers/Makefile      |   1 -
>  drivers/spi/Kconfig                           |  11 +
>  drivers/spi/Makefile                          |   1 +
>  8 files changed, 730 insertions(+), 983 deletions(-)
>  delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
>  create mode 100644 drivers/spi/spi-aspeed-smc.c
>  delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt
