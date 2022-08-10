Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE41558F42B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiHJWH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiHJWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:07:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C03792FD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:07:10 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2395922249;
        Thu, 11 Aug 2022 00:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660169228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2De5E540FunuP4dEM9cpbByUgpl79Iu+l9aO+cTF+4=;
        b=immiMyp+oGhwYoqjG6utYL/AWHv0VS/NZ/qjiz8EY79YYYWDgvc0TmBJiQp4STkX0RqEIM
        nPuW8ajC0dGjokKwRmfn5F3Zh4nd/5pjYldprJTJOp53OZ7MVfTURsHjhncMpyxg/gZSlW
        sgrG6J1RTx0FgphB4oW2ZfTpQrJfyf0=
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <michael@walle.cc>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 1/7] mtd: spi-nor: hide jedec_id sysfs attribute if not present
Date:   Thu, 11 Aug 2022 00:06:48 +0200
Message-Id: <20220810220654.1297699-2-michael@walle.cc>
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

Some non-jedec compliant flashes (like the Everspin flashes) don't have
an ID at all. Hide the attribute in this case.

Fixes: 36ac02286265 ("mtd: spi-nor: add initial sysfs support")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 .../ABI/testing/sysfs-bus-spi-devices-spi-nor      |  3 +++
 drivers/mtd/spi-nor/sysfs.c                        | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
index d76cd3946434..e9ef69aef20b 100644
--- a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
+++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
@@ -5,6 +5,9 @@ Contact:	linux-mtd@lists.infradead.org
 Description:	(RO) The JEDEC ID of the SPI NOR flash as reported by the
 		flash device.
 
+		The attribute is not present if the flash doesn't support
+		the "Read JEDEC ID" command (9Fh). This is the case for
+		non-JEDEC compliant flashes.
 
 What:		/sys/bus/spi/devices/.../spi-nor/manufacturer
 Date:		April 2021
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 9aec9d8a98ad..4c3b351aef24 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -67,6 +67,19 @@ static struct bin_attribute *spi_nor_sysfs_bin_entries[] = {
 	NULL
 };
 
+static umode_t spi_nor_sysfs_is_visible(struct kobject *kobj,
+					struct attribute *attr, int n)
+{
+	struct spi_device *spi = to_spi_device(kobj_to_dev(kobj));
+	struct spi_mem *spimem = spi_get_drvdata(spi);
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+
+	if (attr == &dev_attr_jedec_id.attr && !nor->info->id_len)
+		return 0;
+
+	return 0444;
+}
+
 static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
 					    struct bin_attribute *attr, int n)
 {
@@ -82,6 +95,7 @@ static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
 
 static const struct attribute_group spi_nor_sysfs_group = {
 	.name		= "spi-nor",
+	.is_visible	= spi_nor_sysfs_is_visible,
 	.is_bin_visible	= spi_nor_sysfs_is_bin_visible,
 	.attrs		= spi_nor_sysfs_entries,
 	.bin_attrs	= spi_nor_sysfs_bin_entries,
-- 
2.30.2

