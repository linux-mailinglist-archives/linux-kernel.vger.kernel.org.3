Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BA4F6C60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbiDFVQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiDFVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:15:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF63247C24;
        Wed,  6 Apr 2022 13:00:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so5962364lfg.7;
        Wed, 06 Apr 2022 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6E35KyoZj97uqlX2tyinbVgyFyBsaXQS+Q1PQsp+C0=;
        b=mjqarkR2GJlJNxDGI+Mv0cfaTIO53GT34QL66zV5TI8ID02jEzGzLPBeNOebSld4gb
         KBVTcE5PvOAhNcB1gzmEWThBpfEfY3d0QYLVXXx4Piot3M380m/5BxL+ezS/Azs0RDuG
         abtgfz/xVrtgdiJuJCS598w9CqrHB0va6LI/sswk/lutWbVjpa4qhwS9gPJPKd3/i9WC
         xlbAgFkN+04UnJI76hr1wICW0oYqTPgmvCmfu0BupDhKJn87ng77wZPuZutZqltDfg/z
         zCWl8d5vZz2pUJuwjaA1uFgAHoEnSHMu48nL86fL5jsryEXpSQF1ouI43Thw0BDUHQaN
         PuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6E35KyoZj97uqlX2tyinbVgyFyBsaXQS+Q1PQsp+C0=;
        b=bkfggJCZHyxxPqwm5CIDSxnzOHK4o+q0A9jcLeB6JJ33860DEmO8he8iPo2WQw9bsc
         n9CdgWMcBuGs+47v3eGP3DwljgO8iEBEB3w0EJuGe1xbs0AskvxomLH3pzket4b3vl2R
         Iro7z5JaojB5xVIAQDongUiyLdS5swO6fjIxnxc6B7EyCJgGk5uSY4YnQRw4fEJYgpi7
         ny9KpYrVvh3T74WwrLcTNlWPGHsRqvJEcsrGfDWk64DDNq7LcKMs/j4pr010WIFa53Yj
         vJOGSRetO6WOSPZIrsc5l0R4kTX4KSn+KZcY06+DOnfADFTkUoyT0MGuVmkJ7eKCQm3e
         Nm1w==
X-Gm-Message-State: AOAM532y31TJ9YTMZCvbg3JUDO6+iYQuFNc+piForoTAxZu9mFFpPPin
        9N5RRu3X9znvX9t16zGPFCQ=
X-Google-Smtp-Source: ABdhPJzmfV8jLmUGtTVJ6ITWQuMVzcyF5eyUktQWdhdWf2jjK05r5ESSLYih34HLOVXIuVeBxc0vxA==
X-Received: by 2002:a05:6512:3fa6:b0:44a:cc1f:4a52 with SMTP id x38-20020a0565123fa600b0044acc1f4a52mr6952922lfa.456.1649275212747;
        Wed, 06 Apr 2022 13:00:12 -0700 (PDT)
Received: from vmu1804.lan ([2a09:bac0:79::82a:3427])
        by smtp.googlemail.com with ESMTPSA id n1-20020a2e9041000000b0024ad80f0b6asm1684866ljg.69.2022.04.06.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:00:12 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] mtd: parsers: add support for Sercomm partitions
Date:   Wed,  6 Apr 2022 20:00:07 +0000
Message-Id: <20220406200007.2070-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406195557.1956-1-csharper2005@gmail.com>
References: <20220406195557.1956-1-csharper2005@gmail.com>
MIME-Version: 1.0
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

This adds an MTD partition parser for the Sercomm partition table that
is used in some Beeline, Netgear and Sercomm routers.

The Sercomm partition map table contains real partition offsets, which
may differ from device to device depending on the number and location of
bad blocks on NAND.

This is essentially the same code as proposed by NOGUCHI Hiroshi:
Link: https://github.com/openwrt/openwrt/pull/1318#issuecomment-420607394

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 drivers/mtd/parsers/Kconfig  |   9 ++
 drivers/mtd/parsers/Makefile |   1 +
 drivers/mtd/parsers/scpart.c | 240 +++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/mtd/parsers/scpart.c

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index 23763d16e4f9..fea0b9f70e04 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -180,6 +180,15 @@ config MTD_REDBOOT_PARTS_READONLY
 
 endif # MTD_REDBOOT_PARTS
 
+config MTD_SERCOMM_PARTS
+	tristate "Sercomm partition table parser"
+	depends on MTD
+	help
+	  This provides partitions table parser for devices with Sercomm
+	  partition map. This partition table contains real partition
+	  offsets, which may differ from device to device depending on the
+	  number and location of bad blocks on NAND.
+
 config MTD_QCOMSMEM_PARTS
 	tristate "Qualcomm SMEM flash partition parser"
 	depends on QCOM_SMEM
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 2e98aa048278..2fcf0ab9e7da 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -10,6 +10,7 @@ ofpart-$(CONFIG_MTD_OF_PARTS_LINKSYS_NS)+= ofpart_linksys_ns.o
 obj-$(CONFIG_MTD_PARSER_IMAGETAG)	+= parser_imagetag.o
 obj-$(CONFIG_MTD_AFS_PARTS)		+= afs.o
 obj-$(CONFIG_MTD_PARSER_TRX)		+= parser_trx.o
+obj-$(CONFIG_MTD_SERCOMM_PARTS)		+= scpart.o
 obj-$(CONFIG_MTD_SHARPSL_PARTS)		+= sharpslpart.o
 obj-$(CONFIG_MTD_REDBOOT_PARTS)		+= redboot.o
 obj-$(CONFIG_MTD_QCOMSMEM_PARTS)	+= qcomsmempart.o
diff --git a/drivers/mtd/parsers/scpart.c b/drivers/mtd/parsers/scpart.c
new file mode 100644
index 000000000000..620a465cf808
--- /dev/null
+++ b/drivers/mtd/parsers/scpart.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *    drivers/mtd/scpart.c: Sercomm Partition Parser
+ *
+ *    Copyright (C) 2018 NOGUCHI Hiroshi
+ *    Copyright (C) 2022 Mikhail Zhilkin
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/module.h>
+
+#define	MOD_NAME	"scpart"
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) MOD_NAME ": " fmt
+
+static const char sc_part_magic[] = {
+	'S', 'C', 'F', 'L', 'M', 'A', 'P', 'O', 'K', '\0',
+};
+#define	PART_MAGIC_LEN	sizeof(sc_part_magic)
+
+/* assumes that all fields are set by CPU native endian */
+struct sc_part_desc {
+	uint32_t	part_id;
+	uint32_t	part_offs;
+	uint32_t	part_bytes;
+};
+#define	ID_ALREADY_FOUND	0xFFFFFFFFUL
+
+#define	MAP_OFFS_IN_BLK	0x800
+
+#define	MAP_MIRROR_NUM	2
+
+static int scpart_desc_is_valid(struct sc_part_desc *pdesc)
+{
+	return ((pdesc->part_id != 0xFFFFFFFFUL) &&
+		(pdesc->part_offs != 0xFFFFFFFFUL) &&
+		(pdesc->part_bytes != 0xFFFFFFFFUL));
+}
+
+static int scpart_scan_partmap(struct mtd_info *master, loff_t partmap_offs,
+			       struct sc_part_desc **ppdesc)
+{
+	uint8_t *buf;
+	loff_t offs;
+	size_t retlen;
+	struct sc_part_desc *pdesc = NULL;
+	struct sc_part_desc *tmpdesc;
+	int cnt = 0;
+	int res2;
+	int res = 0;
+
+	buf = kzalloc(master->erasesize, GFP_KERNEL);
+	if (!buf) {
+		res = -ENOMEM;
+		goto out;
+	}
+
+	res2 = mtd_read(master, partmap_offs, master->erasesize, &retlen, buf);
+	if (res2 || retlen != master->erasesize) {
+		res = -EIO;
+		goto free;
+	}
+
+	offs = MAP_OFFS_IN_BLK;
+	while (offs < (master->erasesize - sizeof(*tmpdesc))) {
+		tmpdesc = (struct sc_part_desc *)&(buf[offs]);
+		if (!scpart_desc_is_valid(tmpdesc))
+			break;
+		cnt++;
+		offs += sizeof(*tmpdesc);
+	}
+
+	if (cnt > 0) {
+		int bytes = cnt * sizeof(*pdesc);
+
+		pdesc = kcalloc(cnt, sizeof(*pdesc), GFP_KERNEL);
+		if (!pdesc) {
+			res = -ENOMEM;
+			goto free;
+		}
+		memcpy(pdesc, &(buf[MAP_OFFS_IN_BLK]), bytes);
+
+		*ppdesc = pdesc;
+		res = cnt;
+	}
+
+free:
+	kfree(buf);
+
+out:
+	return res;
+}
+
+static int scpart_find_partmap(struct mtd_info *master,
+			       struct sc_part_desc **ppdesc)
+{
+	loff_t offs;
+	uint8_t rdbuf[PART_MAGIC_LEN];
+	size_t retlen;
+	int magic_found = 0;
+	int res2;
+	int res = 0;
+
+	offs = 0;
+	while ((magic_found < MAP_MIRROR_NUM) &&
+			(offs < master->size) && !mtd_block_isbad(master, offs)) {
+		res2 = mtd_read(master, offs, PART_MAGIC_LEN, &retlen, rdbuf);
+		if (res2 || (retlen != PART_MAGIC_LEN)) {
+			res = -EIO;
+			goto out;
+		}
+		if (!memcmp(rdbuf, sc_part_magic, PART_MAGIC_LEN)) {
+			pr_debug("Signature found at 0x%llx\n", offs);
+			magic_found++;
+			res = scpart_scan_partmap(master, offs, ppdesc);
+			if (res > 0)
+				goto out;
+		}
+		offs += master->erasesize;
+	}
+
+out:
+	if (res > 0)
+		pr_info("Valid 'SC PART MAP' (%d partitions) found at 0x%llx\n", res, offs);
+	else
+		pr_info("No valid 'SC PART MAP'\n");
+
+	return res;
+}
+
+static int scpart_parse(struct mtd_info *master,
+			const struct mtd_partition **pparts,
+			struct mtd_part_parser_data *data)
+{
+	struct sc_part_desc *scpart_map = NULL;
+	struct mtd_partition *parts = NULL;
+	struct device_node *mtd_node;
+	struct device_node *ofpart_node;
+	struct device_node *pp;
+	const char *partname;
+	int nr_scparts;
+	int nr_parts = 0;
+	int n;
+	int res = 0;
+
+	mtd_node = mtd_get_of_node(master);
+	if (!mtd_node)
+		goto out;
+
+	ofpart_node = of_get_child_by_name(mtd_node, "partitions");
+	if (!ofpart_node)
+		goto out;
+
+	nr_scparts = scpart_find_partmap(master, &scpart_map);
+	if (nr_scparts <= 0) {
+		res = nr_scparts;
+		goto free;
+	}
+
+	parts = kcalloc(of_get_child_count(ofpart_node), sizeof(*parts),
+		GFP_KERNEL);
+	if (!parts) {
+		res = -ENOMEM;
+		goto out;
+	}
+
+	for_each_child_of_node(ofpart_node, pp) {
+		u32 scpart_id;
+
+		if (of_property_read_u32(pp, "scpart-id", &scpart_id))
+			continue;
+
+		for (n = 0 ; n < nr_scparts ; n++)
+			if ((scpart_map[n].part_id != ID_ALREADY_FOUND) &&
+					(scpart_id == scpart_map[n].part_id))
+				break;
+		if (n >= nr_scparts)
+			/* not match */
+			continue;
+
+		/* add the partition found in OF into MTD partition array */
+		parts[nr_parts].offset = scpart_map[n].part_offs;
+		parts[nr_parts].size = scpart_map[n].part_bytes;
+		parts[nr_parts].of_node = pp;
+
+		if (!of_property_read_string(pp, "label", &partname))
+			parts[nr_parts].name = partname;
+		if (of_property_read_bool(pp, "read-only"))
+			parts[nr_parts].mask_flags |= MTD_WRITEABLE;
+		if (of_property_read_bool(pp, "lock"))
+			parts[nr_parts].mask_flags |= MTD_POWERUP_LOCK;
+
+		/* mark as 'done' */
+		scpart_map[n].part_id = ID_ALREADY_FOUND;
+
+		nr_parts++;
+	}
+
+	if (nr_parts > 0) {
+		*pparts = parts;
+		res = nr_parts;
+	} else
+		pr_info("No partition in OF matches partition ID with 'SC PART MAP'.\n");
+
+	of_node_put(pp);
+
+free:
+	kfree(scpart_map);
+	if (res <= 0)
+		kfree(parts);
+
+out:
+	return res;
+}
+
+static const struct of_device_id scpart_parser_of_match_table[] = {
+	{ .compatible = "sercomm,sc-partitions" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, scpart_parser_of_match_table);
+
+static struct mtd_part_parser scpart_parser = {
+	.parse_fn = scpart_parse,
+	.name = "scpart",
+	.of_match_table = scpart_parser_of_match_table,
+};
+module_mtd_part_parser(scpart_parser);
+
+/* mtd parsers will request the module by parser name */
+MODULE_ALIAS("scpart");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("NOGUCHI Hiroshi <drvlabo@gmail.com>");
+MODULE_DESCRIPTION("Sercomm partition parser");
-- 
2.25.1

