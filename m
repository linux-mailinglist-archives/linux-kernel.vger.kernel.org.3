Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17944570721
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiGKPa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiGKPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:30:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D29E32BBD;
        Mon, 11 Jul 2022 08:30:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mf4so8266804ejc.3;
        Mon, 11 Jul 2022 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NbtZW5iYffYk9vJVjFHUiX8xjAYGNvMtQ0Q/nx4lmE=;
        b=RXgXOcZj6YH+t3Aq/vb7Vvy1y3qynU35QEgQvsk2xM8MzwSpdHV1CeVrk9yu89X1mQ
         DCN7Umzu+MkC8OTHHi6gwQIPu1mgzzz4M8RQ5RnPMEGLP35ZSYvIQJdOnSrIX5cOyJqL
         J5n9qN15WTysFcf65IkJ3fDCIfublrwG/IE/LxE+WWq0h4V0APn5fAk8XfaOlyVcQ6aW
         Hw4B248mr7TH4zDKONitE6y9eoXGuKbkjYHSMrqScvKmVOLwQ5Z3YY1Dye4zMw7lxqy5
         1hqr1zFnDfBr61akis4PnNsELCJPfeObv9f8tDhcTrU4g9pkHBj0moknGcFSt1a27Eys
         EtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NbtZW5iYffYk9vJVjFHUiX8xjAYGNvMtQ0Q/nx4lmE=;
        b=zw0+q2l3QuKHwBB2n4iFbhdQUaYh8QVmEZhIFxa/qTsBNCE2dgySVxmimoNX3Mvynd
         Xx8ovrHbe8T7xy3KFnLqrjAfeBS+XzSjLnmfP4cDDB3wzUhqJ8gLZyot+0pDGIfIDXXc
         jBfnzlzACbKRKlUutd/hVO+MueXuvydP3J2E/dqZsSVVMne56Pjp6ZDnfDO9WoNyxzMC
         PM0440fWITvKGeuKbaUj/5tgM0WMIKZKe5DTuFcvEwW/EbERg4mXVsHpMwJgaCxhpD7x
         CRsqyfTtAuUWeKTm8rdFLhQvGPLfrkjEMa7Q76jV7+HPVHPj2rId4zeY0p27+zi6rKrk
         vBXA==
X-Gm-Message-State: AJIora8AR9xqO8vjbKbFrfyZX/X9ncJY4NLLYQDTs8gQgUHOHlNBcKB8
        f+9cQhwEXbuPhvgop3xktI834R+V6LM=
X-Google-Smtp-Source: AGRyM1vePmwXs3CspYk34kycX3cgB1muGtC9YvDxmfao/cwBZGMXY5COqHZKiUeyv+CRgpv66yd7vg==
X-Received: by 2002:a17:907:7e85:b0:726:9fc5:cc2d with SMTP id qb5-20020a1709077e8500b007269fc5cc2dmr18462100ejc.376.1657553449101;
        Mon, 11 Jul 2022 08:30:49 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906725700b00722e603c39asm2773917ejk.31.2022.07.11.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 08:30:48 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] mtd: parsers: add Broadcom's U-Boot parser
Date:   Mon, 11 Jul 2022 17:30:41 +0200
Message-Id: <20220711153041.6036-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711153041.6036-1-zajec5@gmail.com>
References: <20220711153041.6036-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom stores environment variables blocks inside U-Boot partition
itself. This driver finds & registers them.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/parsers/Kconfig       | 10 ++++
 drivers/mtd/parsers/Makefile      |  1 +
 drivers/mtd/parsers/brcm_u-boot.c | 84 +++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/mtd/parsers/brcm_u-boot.c

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index b43df73927a0..81f2d0a795a6 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -20,6 +20,16 @@ config MTD_BCM63XX_PARTS
 	  This provides partition parsing for BCM63xx devices with CFE
 	  bootloaders.
 
+config MTD_BRCM_U_BOOT
+	tristate "Broadcom's U-Boot partition parser"
+	depends on ARCH_BCM4908 || COMPILE_TEST
+	help
+	  Broadcom uses a custom way of storing U-Boot environment variables.
+	  They are placed inside U-Boot partition itself at unspecified offset.
+	  It's possible to locate them by looking for a custom header with a
+	  magic value. This driver does that and creates subpartitions for
+	  each found environment variables block.
+
 config MTD_CMDLINE_PARTS
 	tristate "Command line partition table parsing"
 	depends on MTD
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 2fcf0ab9e7da..23fa4de4016f 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_MTD_AR7_PARTS)		+= ar7part.o
 obj-$(CONFIG_MTD_BCM47XX_PARTS)		+= bcm47xxpart.o
 obj-$(CONFIG_MTD_BCM63XX_PARTS)		+= bcm63xxpart.o
+obj-$(CONFIG_MTD_BRCM_U_BOOT)		+= brcm_u-boot.o
 obj-$(CONFIG_MTD_CMDLINE_PARTS)		+= cmdlinepart.o
 obj-$(CONFIG_MTD_OF_PARTS)		+= ofpart.o
 ofpart-y				+= ofpart_core.o
diff --git a/drivers/mtd/parsers/brcm_u-boot.c b/drivers/mtd/parsers/brcm_u-boot.c
new file mode 100644
index 000000000000..7c338dc7b8f3
--- /dev/null
+++ b/drivers/mtd/parsers/brcm_u-boot.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2022 Rafał Miłecki <rafal@milecki.pl>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#define BRCM_U_BOOT_MAX_OFFSET		0x200000
+#define BRCM_U_BOOT_STEP		0x1000
+
+#define BRCM_U_BOOT_MAX_PARTS		2
+
+#define BRCM_U_BOOT_MAGIC		0x75456e76	/* uEnv */
+
+struct brcm_u_boot_header {
+	__le32 magic;
+	__le32 length;
+} __packed;
+
+static const char *names[BRCM_U_BOOT_MAX_PARTS] = {
+	"u-boot-env",
+	"u-boot-env-backup",
+};
+
+static int brcm_u_boot_parse(struct mtd_info *mtd,
+			     const struct mtd_partition **pparts,
+			     struct mtd_part_parser_data *data)
+{
+	struct brcm_u_boot_header header;
+	struct mtd_partition *parts;
+	size_t bytes_read;
+	size_t offset;
+	int err;
+	int i = 0;
+
+	parts = kcalloc(BRCM_U_BOOT_MAX_PARTS, sizeof(*parts), GFP_KERNEL);
+	if (!parts)
+		return -ENOMEM;
+
+	for (offset = 0;
+	     offset < min_t(size_t, mtd->size, BRCM_U_BOOT_MAX_OFFSET);
+	     offset += BRCM_U_BOOT_STEP) {
+		err = mtd_read(mtd, offset, sizeof(header), &bytes_read, (uint8_t *)&header);
+		if (err && !mtd_is_bitflip(err)) {
+			pr_err("Failed to read from %s at 0x%zx: %d\n", mtd->name, offset, err);
+			continue;
+		}
+
+		if (le32_to_cpu(header.magic) != BRCM_U_BOOT_MAGIC)
+			continue;
+
+		parts[i].name = names[i];
+		parts[i].offset = offset;
+		parts[i].size = sizeof(header) + le32_to_cpu(header.length);
+		i++;
+		pr_info("offset:0x%zx magic:0x%08x BINGO\n", offset, header.magic);
+
+		if (i == BRCM_U_BOOT_MAX_PARTS)
+			break;
+	}
+
+	*pparts = parts;
+
+	return i;
+};
+
+static const struct of_device_id brcm_u_boot_of_match_table[] = {
+	{ .compatible = "brcm,u-boot" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, brcm_u_boot_of_match_table);
+
+static struct mtd_part_parser brcm_u_boot_mtd_parser = {
+	.parse_fn = brcm_u_boot_parse,
+	.name = "brcm_u-boot",
+	.of_match_table = brcm_u_boot_of_match_table,
+};
+module_mtd_part_parser(brcm_u_boot_mtd_parser);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1

