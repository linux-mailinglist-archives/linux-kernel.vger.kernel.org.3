Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8617511611
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiD0LXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiD0LXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:23:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80E2FFD2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 04:19:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R9VQS3101909;
        Wed, 27 Apr 2022 04:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651051886;
        bh=Q41u8TDrDC1yLEFN/TIxA0jpFdoBJn+r1/gn1QKCFK4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zPFY1wPUevqBJ2CUe4AzbuKbvSebm3utdT5kpWXAndvOk2UED1UmMOyQwm/1FKFZ+
         i+sooC9ihsIN8saV4BFioj3ww/OR2fqWkZ/JQTM8zK9axTIeMbK0V1uI2brVSwSYJM
         e7xeaCvq5XaDNYVMvKf/TSv4/JUzyBOQ/o6GgqQM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R9VQAb096923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 04:31:26 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 04:31:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 04:31:26 -0500
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R9VKtR033801;
        Wed, 27 Apr 2022 04:31:23 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <michael@walle.cc>, Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <Takahiro.Kuwano@infineon.com>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 00/11] mtd: spi-nor: Rework Octal DTR methods
Date:   Wed, 27 Apr 2022 15:01:19 +0530
Message-ID: <165105175023.2301505.5047546691256262839.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420103427.47867-1-tudor.ambarus@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 13:34:16 +0300, Tudor Ambarus wrote:
> v4:
> - s/spi_nor_read_reg/spi_nor_read_any_reg and
> s/spi_nor_write_reg/spi_nor_write_any_volatile_reg to comply with Micron
> and Cypress's naming scheme. Update documentation description on
> spi_nor_write_any_volatile_reg.
> - 2 new patches, the last ones, where I remove status polling on write
> volatile registers
> - collect R-bs
> v3:
> - queue patch: "mtd: spi-nor: Introduce templates for SPI NOR operations"
> from
> https://lore.kernel.org/lkml/20220304093011.198173-1-tudor.ambarus@microchip.com/
> The dependency chain between patches was too long and hard to follow.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[01/11] mtd: spi-nor: Rename method, s/spi_nor_match_id/spi_nor_match_name
        https://git.kernel.org/mtd/c/b1145d6f1e
[02/11] mtd: spi-nor: Introduce spi_nor_match_id()
        https://git.kernel.org/mtd/c/d0ddd88438
[03/11] mtd: spi-nor: core: Use auto-detection only once
        https://git.kernel.org/mtd/c/bffabd1c72
[04/11] mtd: spi-nor: core: Introduce method for RDID op
        https://git.kernel.org/mtd/c/86b6b55ffb
[05/11] mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method
        https://git.kernel.org/mtd/c/a007d81aa5
[06/11] mtd: spi-nor: core: Add helpers to read/write any register
        https://git.kernel.org/mtd/c/a604ab33cb
[07/11] mtd: spi-nor: micron-st: Rework spi_nor_micron_octal_dtr_enable()
        https://git.kernel.org/mtd/c/4629adaff7
[08/11] mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()
        https://git.kernel.org/mtd/c/27ff0d34fb
[09/11] mtd: spi-nor: Introduce templates for SPI NOR operations
        https://git.kernel.org/mtd/c/c0abb861c5
[10/11] mtd: spi-nor: spansion: Remove status polling on volatile registers write
        https://git.kernel.org/mtd/c/467f0e8381
[11/11] mtd: spi-nor: micron-st: Remove status polling on volatile registers write
        https://git.kernel.org/mtd/c/37841975b3

--
Regards,
Pratyush Yadav
Texas Instruments Inc.

