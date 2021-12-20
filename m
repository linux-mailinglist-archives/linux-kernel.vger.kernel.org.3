Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDA847B1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbhLTREO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:04:14 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:44553 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233963AbhLTREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:04:13 -0500
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000"; 
   d="scan'208";a="104591848"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Dec 2021 02:04:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id ABBA140AF136;
        Tue, 21 Dec 2021 02:04:10 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] soc: renesas: Add support for reading product revision for RZ/G2L family
Date:   Mon, 20 Dec 2021 17:03:57 +0000
Message-Id: <20211220170357.7899-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Hi,

Below is the log from Renesas RZ/G2L SMARC EVK:

root@smarc-rzg2l:~#
at /sys/devices/soc0/$i; donemachine family soc_id revision; do echo -n "$i: ";ca
machine: Renesas SMARC EVK based on r9a07g044l2
family: RZ/G2L
soc_id: r9a07g044
revision: Rev 1
root@smarc-rzg2l:~#

Cheers,
Prabhakar
---
 drivers/soc/renesas/renesas-soc.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 8f82749f182f..6ecd2763d100 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -416,6 +416,17 @@ static int __init renesas_soc_init(void)
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
@@ -430,6 +441,12 @@ static int __init renesas_soc_init(void)
 
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
@@ -439,20 +456,6 @@ static int __init renesas_soc_init(void)
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
 
-- 
2.17.1

