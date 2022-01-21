Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1494957D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348303AbiAUBl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:41:27 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:44805 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233355AbiAUBl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:41:26 -0500
X-IronPort-AV: E=Sophos;i="5.88,303,1635174000"; 
   d="scan'208";a="107148210"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jan 2022 10:41:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DE52440134FE;
        Fri, 21 Jan 2022 10:41:23 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] soc: renesas: Add support for reading product revision for RZ/G2L family
Date:   Fri, 21 Jan 2022 01:41:17 +0000
Message-Id: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

As per RZ/G2L HW manual (Rev.1.00 Sep, 2021) DEV_ID [31:28] indicates
product revision. Use this information to populate the revision info
for RZ/G2L family.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Fixed freeing up soc_dev_attr in error path.

Output from SMARC RZ/G2L:
root@smarc-rzg2l:~# for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/soc0/$i; done
machine: Renesas SMARC EVK based on r9a07g044l2
family: RZ/G2L
soc_id: r9a07g044
revision: Rev 1
root@smarc-rzg2l:~#
root@smarc-rzg2l:~#
---
 drivers/soc/renesas/renesas-soc.c | 49 ++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 7da0ea3587c4..44e365b36b26 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -371,6 +371,7 @@ static int __init renesas_soc_init(void)
 	struct soc_device *soc_dev;
 	struct device_node *np;
 	const char *soc_id;
+	int ret;
 
 	match = of_match_node(renesas_socs, of_root);
 	if (!match)
@@ -391,6 +392,17 @@ static int __init renesas_soc_init(void)
 		chipid = ioremap(family->reg, 4);
 	}
 
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &soc_dev_attr->machine);
+	of_node_put(np);
+
+	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
+	soc_dev_attr->soc_id = kstrdup_const(soc_id, GFP_KERNEL);
+
 	if (chipid) {
 		product = readl(chipid + id->offset);
 		iounmap(chipid);
@@ -405,41 +417,38 @@ static int __init renesas_soc_init(void)
 
 			eshi = ((product >> 4) & 0x0f) + 1;
 			eslo = product & 0xf;
+			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
+							   eshi, eslo);
+		}  else if (id == &id_rzg2l) {
+			eshi =  ((product >> 28) & 0x0f);
+			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "Rev %u",
+							   eshi);
 		}
 
 		if (soc->id &&
 		    ((product & id->mask) >> __ffs(id->mask)) != soc->id) {
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto free_soc_dev_attr;
 		}
 	}
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return -ENOMEM;
-
-	np = of_find_node_by_path("/");
-	of_property_read_string(np, "model", &soc_dev_attr->machine);
-	of_node_put(np);
-
-	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
-	soc_dev_attr->soc_id = kstrdup_const(soc_id, GFP_KERNEL);
-	if (eshi)
-		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u", eshi,
-						   eslo);
-
 	pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
 		soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr->revision);
-		kfree_const(soc_dev_attr->soc_id);
-		kfree_const(soc_dev_attr->family);
-		kfree(soc_dev_attr);
-		return PTR_ERR(soc_dev);
+		ret = PTR_ERR(soc_dev);
+		goto free_soc_dev_attr;
 	}
 
 	return 0;
+
+free_soc_dev_attr:
+	kfree(soc_dev_attr->revision);
+	kfree_const(soc_dev_attr->soc_id);
+	kfree_const(soc_dev_attr->family);
+	kfree(soc_dev_attr);
+	return ret;
 }
 early_initcall(renesas_soc_init);
-- 
2.17.1

