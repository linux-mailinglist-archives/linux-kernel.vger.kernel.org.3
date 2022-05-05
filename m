Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39551C17B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380194AbiEENzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349716AbiEENxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:53:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D44583B4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651758596; x=1683294596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9l6WaRb6oGd/EhXo4amB8hePW2EHsrBipNj6o911jRY=;
  b=mcxCgXKK5oaksOWrwHxKClSXQCKvlBFe53f2aMiG09LTrFstfuCmJHCa
   WEOO6Uo3NMjLlx4D3kXRdzFTWs5Z3jXG5XbCkSGkyKp+M3dUTyyaxLU2N
   Y14RWeTMqXzmoCTkNo0XiR8cZD38E7fGM6JsFDktJRv5HqDdQI49Gkkem
   S+QjFRR6v/LfijlIS3yOd+70UE6+/Pb1rsYf2/xQQQo8MiteNIM0dU0db
   3eO+nNbpYvxNuGQtsoaPKW1FPoS0e0M7bnfGP0sbVIsEWvDtFTaBYyQiu
   +qJUr2B0ZlpEQA2JsJlI5SN1m1WrM7zqIB6H8Jp3AdvcfmC3YFQhd+GPG
   A==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="157922937"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:49:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:49:56 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 06:49:54 -0700
Message-ID: <58edb055-5320-f377-8a2f-1252e1bbea84@microchip.com>
Date:   Thu, 5 May 2022 15:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] ARM: configs: at91: Remove MTD_BLOCK and use
 MTD_UBI_BLOCK for read only block FS
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <codrin.ciubotariu@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220420134740.193563-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220420134740.193563-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 at 15:47, Tudor Ambarus wrote:
> Using mtdblock on raw flashes is generally a bad idea as it lacks
> wear-leveling, bad block handling or power-cut management.
> What happens when you use mtdblock and you change any sector of your
> mtdblockX device, is that it reads the whole corresponding eraseblock into
> the memory, erases the eraseblock, changes the sector in RAM, and writes
> the whole eraseblock back. If you have a power failure when the eraseblock
> is being erased, you lose all the block device sectors in it. The flash
> will likely decay soon because the eraseblocks will wear out.
> 
> Remove this archaic tool as its use case should rather be only for debug
> purposes. This means that write-capable block file systems like ext2,
> ext3, FAT, etc. will no longer be addressed with at91 defconfigs. For
> read only block filesystems like SquashFS, use MTD_UBI_BLOCK instead and
> benefit of UBI's bit-flip handling and wear-levelling.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

and queued in at91-defconfig for 5.19.

Best regards,
   Nicolas

> ---
>   arch/arm/configs/at91_dt_defconfig | 2 +-
>   arch/arm/configs/sama5_defconfig   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 549d01be0b47..cf79510631ea 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -50,13 +50,13 @@ CONFIG_DEVTMPFS_MOUNT=y
>   CONFIG_MTD=y
>   CONFIG_MTD_TESTS=m
>   CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_BLOCK=y
>   CONFIG_MTD_DATAFLASH=y
>   CONFIG_MTD_RAW_NAND=y
>   CONFIG_MTD_NAND_ATMEL=y
>   CONFIG_MTD_SPI_NOR=y
>   CONFIG_MTD_UBI=y
>   CONFIG_MTD_UBI_FASTMAP=y
> +CONFIG_MTD_UBI_BLOCK=y
>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_COUNT=4
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 03dd80c2a19e..1c4c5a035518 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -57,13 +57,13 @@ CONFIG_DEVTMPFS_MOUNT=y
>   CONFIG_MTD=y
>   CONFIG_MTD_TESTS=m
>   CONFIG_MTD_CMDLINE_PARTS=y
> -CONFIG_MTD_BLOCK=y
>   CONFIG_MTD_CFI=y
>   CONFIG_MTD_RAW_NAND=y
>   CONFIG_MTD_NAND_ATMEL=y
>   CONFIG_MTD_SPI_NOR=y
>   CONFIG_MTD_UBI=y
>   CONFIG_MTD_UBI_FASTMAP=y
> +CONFIG_MTD_UBI_BLOCK=y
>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_COUNT=4


-- 
Nicolas Ferre
