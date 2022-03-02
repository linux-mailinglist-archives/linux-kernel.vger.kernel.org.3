Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733E64CB2DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiCBXqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiCBXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:50 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1390A16E7F2;
        Wed,  2 Mar 2022 15:45:44 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a1so3171246qta.13;
        Wed, 02 Mar 2022 15:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0UHeOvGnIMNoM6NqeyF78xFos6+YD8GiFF2O+NX+I08=;
        b=A/8uC4OLZK85x/RsG6wFgeWjAayUjjUSlMWGVzfPxubGvRVyL6+UqPMrijz8hBNBae
         7+Xma0aYf2Wnr1goOeR8vCpaBIDCURIghfyk8+CPkPm8Wjlh4XrVXzXMmlU7y9LZ5llU
         Ra7+w69qG+z5lQmzrnsv6xktbsN0B2rEgy1R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0UHeOvGnIMNoM6NqeyF78xFos6+YD8GiFF2O+NX+I08=;
        b=eTNnHi78Vt+iU6Ij6novjktAoN44QgzszsL7ET+iLVyojI/f68yJcXPYtWi7daVZpA
         o3LEMPTtvt2FgyoYxKwd8zj5GbQsRvD0+7ONQzq0ULIunrZw6vAz0EXdRMpW8XAUs6w0
         /oA5pE0vRbEhfeX5WolzyE4FYnZxCuHfjs7rTEK4SVM3HAkAuGv3jynVfkZ6f/lP+zRD
         kgF2iLMa8z5XdV30JhYHLVnO1vR+YbtEwWDaKOQzVd9snbXxxbzi0EGWUMVHp+2lEg7O
         gq1eR3Q7j+rDGjauX5jjuuFK9ZmAmsSigW04aD9t/WybS9qt6gHVOX/Wm3S9NcEnLvTT
         vi3A==
X-Gm-Message-State: AOAM5330Lwcrva3gcH/t8S6ULw0iAWHlQ2mqELjtkTgvhnJjI8njb2qG
        qSarEF4BTsBKveM/FFgSVG7fjWakKC/rjei4/Nv/FShvD2PzUw==
X-Google-Smtp-Source: ABdhPJwCs5BS/vb/0Gnia8sBd/4fwz2M9pisx/6g/jEojI9HtPhU1m7xtnkyYUd9xlwgdUsE3xPO2rpi1UAXpFZPYeE=
X-Received: by 2002:a05:622a:1b8d:b0:2c6:59a9:360e with SMTP id
 bp13-20020a05622a1b8d00b002c659a9360emr25551831qtb.678.1646264303744; Wed, 02
 Mar 2022 15:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-5-clg@kaod.org>
In-Reply-To: <20220302173114.927476-5-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 23:38:10 +0000
Message-ID: <CACPK8Xc5DMeBnQnVWk4YUsiN7YFsujYh9Qs9okrc8vFvaF28Fw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] spi: spi-mem: Add driver for Aspeed SMC controllers
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

On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
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
>    . 5 chip select pins (CE0 =E2=88=BC CE4)
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
> This initial patch adds support for User mode. Command mode needs a littl=
e
> more work to check that the memory window on the AHB bus fits the device
> size. It will come later when support for direct mapping is added.
>
> Single and dual mode RX transfers are supported. Other types than SPI
> are not supported.
>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
