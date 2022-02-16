Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A454A4B80EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiBPHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:07:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiBPHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:07:19 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216271F68D9;
        Tue, 15 Feb 2022 23:06:30 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id e16so1265402qtq.6;
        Tue, 15 Feb 2022 23:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tQsez3rBBuWL5P/PS1iF/3TVpjfzLMW/EONt+f9CiMQ=;
        b=DEQtO8Rec0/pciyxC16dz5iaxsu3WmlWt3NyB5nPzDtrs1WiDLQmd6+hlVBLEnqVpu
         1mebox8SJRxbZTV/O6jAS12dOueg+4F90FldQTblOj89+hrNeAHr+LIeLNdAliI56beR
         pJC3N2/CeNgNv8Gka5T210xTzD/ClYHwqrGc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQsez3rBBuWL5P/PS1iF/3TVpjfzLMW/EONt+f9CiMQ=;
        b=TDjSbFRzILxTprlpKNOF0zeCQTtwkkp2mcRz1EH6RUbjk1toFcTL8A5dbtHg+2q/y4
         wDY4okQhEFkOAfs4xuH5nKMDHJHmRUIUTt1Bf681Rt1GE5EQERGTJTWKfn6+6iPpWioU
         441t1gVhlLAG6suFC8FcN7PAvJcKXnVUQRe70HvWykQ0yMerTmP5NYRaaICAC878t3Jz
         gADgJHw7X6IE9UWlxmz//MzzpMCFvAmngrTgCo9hlu7eR9jsnP9di8w1/EceH/E3Qvpo
         mEdmPRRHpjXUuD+ESAI2PoHQQq98kxuNoUK4jksHv8EKW6WyLdAbA/oy9GdkrA2ee6vq
         WJ5Q==
X-Gm-Message-State: AOAM532ucIQzNqt89KY4OQhtnmkEdcclFMud4oW9hV3jiMLczuKzgDt5
        UEDOVqfsAxI1KZkxAKU1M7CUeh8Gek1UhBUNPlw=
X-Google-Smtp-Source: ABdhPJxUrxTCwzi7Yj2+ExwwwoGmToAHQYb+adCONcmAx/DnApNmNJjP3jevLGycqiKtwihstXuDC7FCB3cmNTkPoqU=
X-Received: by 2002:a05:622a:116:b0:2cd:5be1:3838 with SMTP id
 u22-20020a05622a011600b002cd5be13838mr1054529qtw.494.1644994936320; Tue, 15
 Feb 2022 23:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20220214094231.3753686-1-clg@kaod.org> <20220214094231.3753686-11-clg@kaod.org>
In-Reply-To: <20220214094231.3753686-11-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 16 Feb 2022 07:02:04 +0000
Message-ID: <CACPK8XdvczyZ1QHtFm7JJAC7AY+QmWSx0MarUwLjUyOtC9DnSQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] spi: aspeed: Activate new spi-mem driver
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 at 09:43, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The previous driver using the MTD SPI NOR interface is kept in case we
> find some issues but we should remove it quickly once the new driver
> using the spi-mem interface has been sufficiently exposed.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

I suggest we drop the defconfig changes from both this patch and the
first. This way we'll always have the new driver being built, with
less churn.

If you strongly prefer the way you've done it then that's fine too.

> ---
>  arch/arm/configs/aspeed_g4_defconfig | 2 +-
>  arch/arm/configs/aspeed_g5_defconfig | 2 +-
>  arch/arm/configs/multi_v5_defconfig  | 2 +-
>  arch/arm/configs/multi_v7_defconfig  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspe=
ed_g4_defconfig
> index 964536444cd7..b4a1b2ed1a17 100644
> --- a/arch/arm/configs/aspeed_g4_defconfig
> +++ b/arch/arm/configs/aspeed_g4_defconfig
> @@ -64,7 +64,7 @@ CONFIG_MTD_BLOCK=3Dy
>  CONFIG_MTD_PARTITIONED_MASTER=3Dy
>  CONFIG_MTD_SPI_NOR=3Dy
>  # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=3Dy
> +CONFIG_SPI_ASPEED_SMC=3Dy
>  CONFIG_MTD_UBI=3Dy
>  CONFIG_MTD_UBI_FASTMAP=3Dy
>  CONFIG_MTD_UBI_BLOCK=3Dy
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspe=
ed_g5_defconfig
> index e809236ca88b..ccc4240ee4b5 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -103,7 +103,7 @@ CONFIG_MTD_BLOCK=3Dy
>  CONFIG_MTD_PARTITIONED_MASTER=3Dy
>  CONFIG_MTD_SPI_NOR=3Dy
>  # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=3Dy
> +CONFIG_SPI_ASPEED_SMC=3Dy
>  CONFIG_MTD_UBI=3Dy
>  CONFIG_MTD_UBI_FASTMAP=3Dy
>  CONFIG_MTD_UBI_BLOCK=3Dy
> diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi=
_v5_defconfig
> index 49083ef05fb0..80a3ae02d759 100644
> --- a/arch/arm/configs/multi_v5_defconfig
> +++ b/arch/arm/configs/multi_v5_defconfig
> @@ -103,7 +103,7 @@ CONFIG_MTD_RAW_NAND=3Dy
>  CONFIG_MTD_NAND_ATMEL=3Dy
>  CONFIG_MTD_NAND_ORION=3Dy
>  CONFIG_MTD_SPI_NOR=3Dy
> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=3Dy
> +CONFIG_SPI_ASPEED_SMC=3Dy
>  CONFIG_MTD_UBI=3Dy
>  CONFIG_BLK_DEV_LOOP=3Dy
>  CONFIG_ATMEL_SSC=3Dm
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
> index fc1b69256b64..33572998dbbe 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -217,7 +217,7 @@ CONFIG_MTD_NAND_DAVINCI=3Dy
>  CONFIG_MTD_NAND_STM32_FMC2=3Dy
>  CONFIG_MTD_NAND_PL35X=3Dy
>  CONFIG_MTD_SPI_NOR=3Dy
> -CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=3Dm
> +CONFIG_SPI_ASPEED_SMC=3Dm
>  CONFIG_MTD_UBI=3Dy
>  CONFIG_BLK_DEV_LOOP=3Dy
>  CONFIG_BLK_DEV_RAM=3Dy
> --
> 2.34.1
>
