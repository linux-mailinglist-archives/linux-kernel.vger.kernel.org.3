Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3867E4C4A75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiBYQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiBYQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:19:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83AA6005A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645805956; x=1677341956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y+Ao6ZDvcSXXoQKTG3/aiSYOVpdfvQHBUSUKS2imXG4=;
  b=eXA6MvruNQW1fNxl+i5x+zX2SrardT6qJ/fDe61/HExDeNI9qXqqrTtC
   175Ct/KE2mkvfM6QMSYB2nQCkbs1Y/7t3ETIUspSA1CcBzZRxqjsxzgB8
   1WIK+vPM0Gl4TgE2lwaWR2pAkEthDobd8u9VWe+hwrp79HkJV7nZPBLlC
   KqF4/Njz+BqQ7Ho6l8rAf9obPpPjBoC+O1+qRM88ao8eZjU6cBz7JgHzj
   MJ8APmxMtSLVaWQyy160FdOA+Yy9Zxn6271nB2IxyWo6hkxHJm4eE1z2B
   5lpCbmdG+gNq5PZexk043YlJRuI6e79TqcpedHyzehOuPlXOqmDmoenEr
   g==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="163663043"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 09:19:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 09:19:03 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 25 Feb 2022 09:19:00 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Pratyush Yadav" <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 00/32] mtd: spi-nor: move vendor specific code into vendor modules
Date:   Fri, 25 Feb 2022 18:18:59 +0200
Message-ID: <164580568515.679764.14013316693179143722.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223134358.1914798-1-michael@walle.cc>
References: <20220223134358.1914798-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 14:43:26 +0100, Michael Walle wrote:
> It turns out that most of the special status register handling is
> specific for a particular vendor. I.e. Xilinx has some different
> opcodes for the status register read, Micron has an additional FSR
> register and Spansion has these flags integrated into the SR.
> 
> Create a callback to ready() where a flash chip can register its
> own function. This will let us move all the vendor specific stuff
> out of the core into the vendor modules.
> 
> [...]

Applied to spi-nor/next, thanks!

[01/32] mtd: spi-nor: atmel: unify function names
        https://git.kernel.org/mtd/c/2394770bd6bb
[02/32] mtd: spi-nor: catalyst: unify function names
        https://git.kernel.org/mtd/c/9eb916e2523e
[03/32] mtd: spi-nor: eon: unify function names
        https://git.kernel.org/mtd/c/f5e7bd2768d7
[04/32] mtd: spi-nor: esmt: unify function names
        https://git.kernel.org/mtd/c/a7a3f09024b6
[05/32] mtd: spi-nor: everspin: unify function names
        https://git.kernel.org/mtd/c/09ae8354c31d
[06/32] mtd: spi-nor: fujitsu: unify function names
        https://git.kernel.org/mtd/c/5410151931fa
[07/32] mtd: spi-nor: gigadevice: unify function names
        https://git.kernel.org/mtd/c/0ab828613c5a
[08/32] mtd: spi-nor: intel: unify function names
        https://git.kernel.org/mtd/c/536437aabb7a
[09/32] mtd: spi-nor: issi: unify function names
        https://git.kernel.org/mtd/c/cc5af02f6008
[10/32] mtd: spi-nor: macronix: unify function names
        https://git.kernel.org/mtd/c/0757201a1daa
[11/32] mtd: spi-nor: micron-st: unify function names
        https://git.kernel.org/mtd/c/c9d5cdf4bf9c
[12/32] mtd: spi-nor: spansion: unify function names
        https://git.kernel.org/mtd/c/fedd0cbf3e93
[13/32] mtd: spi-nor: sst: unify function names
        https://git.kernel.org/mtd/c/7e5b38ae4f23
[14/32] mtd: spi-nor: winbond: unify function names
        https://git.kernel.org/mtd/c/a7a0466f582f
[15/32] mtd: spi-nor: xilinx: unify function names
        https://git.kernel.org/mtd/c/45acce2099c5
[16/32] mtd: spi-nor: xmc: unify function names
        https://git.kernel.org/mtd/c/232e2830f525
[17/32] mtd: spi-nor: slightly refactor the spi_nor_setup()
        https://git.kernel.org/mtd/c/b44aa9ac6bb4
[18/32] mtd: spi-nor: allow a flash to define its own ready() function
        https://git.kernel.org/mtd/c/4cf1c7bdc55c
[19/32] mtd: spi-nor: export more function to be used in vendor modules
        https://git.kernel.org/mtd/c/66cf87c60014
[20/32] mtd: spi-nor: guard _page_size parameter in S3AN_INFO()
        https://git.kernel.org/mtd/c/9fb4beb1b051
[21/32] mtd: spi-nor: move all xilinx specifics into xilinx.c
        https://git.kernel.org/mtd/c/8b4195cd6dc3
[22/32] mtd: spi-nor: xilinx: rename vendor specific functions and defines
        https://git.kernel.org/mtd/c/8b7a2e00d117
[23/32] mtd: spi-nor: xilinx: correct the debug message
        https://git.kernel.org/mtd/c/56b852e8635b
[24/32] mtd: spi-nor: move all micron-st specifics into micron-st.c
        https://git.kernel.org/mtd/c/c770abe52d81
[25/32] mtd: spi-nor: micron-st: convert USE_FSR to a manufacturer flag
        https://git.kernel.org/mtd/c/8f938262a6f3
[26/32] mtd: spi-nor: micron-st: rename vendor specific functions and defines
        https://git.kernel.org/mtd/c/2b18a18ea7f8
[27/32] mtd: spi-nor: spansion: slightly rework control flow in late_init()
        https://git.kernel.org/mtd/c/6235ff040c13
[28/32] mtd: spi-nor: move all spansion specifics into spansion.c
        https://git.kernel.org/mtd/c/837d5181beef
[29/32] mtd: spi-nor: spansion: convert USE_CLSR to a manufacturer flag
        https://git.kernel.org/mtd/c/51c55506a7b1
[30/32] mtd: spi-nor: spansion: rename vendor specific functions and defines
        https://git.kernel.org/mtd/c/e8fd3b4b266b
[31/32] mtd: spi-nor: slightly change code style in spi_nor_sr_ready()
        https://git.kernel.org/mtd/c/e9d663a2a019
[32/32] mtd: spi-nor: renumber flags
        https://git.kernel.org/mtd/c/3c552889e431

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
