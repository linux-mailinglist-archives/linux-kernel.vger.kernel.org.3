Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9C58F425
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiHJWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiHJWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:07:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2713A81B2F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:07:11 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C32482224D;
        Thu, 11 Aug 2022 00:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660169228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5Gy8fj7/+fRJ03Ev0pNp8xZJdQLteKJDf4fVJZWgbk=;
        b=Y/BFcaE082PrrjtwKehAHz/WA1soCrpkV2LWVjJUJFgWge2TjIcu28AjrXeEVbKQ/KWRvk
        pwdT64rgi6AdNGsBmU50ESNQsufmiQdiJV14WLNR2F0SgU9/cb3Sfh+O2ZcJzgdbUldo6W
        YJVhrbLai/M9vGn4bWwdh8Q9UDEtcz0=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <michael@walle.cc>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 2/7] mtd: spi-nor: sysfs: hide manufacturer if it is not set
Date:   Thu, 11 Aug 2022 00:06:49 +0200
Message-Id: <20220810220654.1297699-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810220654.1297699-1-michael@walle.cc>
References: <20220810220654.1297699-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manufacturer may be optional when pure SFDP flashes are supported.
Hide the sysfs property if no manufacturer is set.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor | 3 +++
 drivers/mtd/spi-nor/sysfs.c                             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
index e9ef69aef20b..c800621eff95 100644
--- a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
+++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
@@ -15,6 +15,9 @@ KernelVersion:	5.14
 Contact:	linux-mtd@lists.infradead.org
 Description:	(RO) Manufacturer of the SPI NOR flash.
 
+		The attribute is not present if the flash device isn't
+		known to the kernel and is only probed by its SFDP
+		tables.
 
 What:		/sys/bus/spi/devices/.../spi-nor/partname
 Date:		April 2021
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 4c3b351aef24..20563c1926f4 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -74,6 +74,8 @@ static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
 	struct spi_mem *spimem = spi_get_drvdata(spi);
 	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
 
+	if (attr == &dev_attr_manufacturer.attr && !nor->manufacturer)
+		return 0;
 	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len)
 		return 0;
 
-- 
2.30.2

