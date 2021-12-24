Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22B447EF01
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352842AbhLXNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:28 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:37061 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352789AbhLXNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:19 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104620434"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:18 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9A07143A180E;
        Fri, 24 Dec 2021 22:13:16 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 06/10] ata: pata_of_platform: Make use of platform_get_mem_or_io()
Date:   Fri, 24 Dec 2021 13:12:55 +0000
Message-Id: <20211224131300.18198-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be consistent with pata_platform driver use
platform_get_mem_or_io() instead of of_address_to_resource().

Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2-->v3
* New patch
---
 drivers/ata/pata_of_platform.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 2e2ec7d77726..b9c9b7311112 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -8,7 +8,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/libata.h>
@@ -21,10 +20,9 @@ static struct scsi_host_template pata_platform_sht = {
 
 static int pata_of_platform_probe(struct platform_device *ofdev)
 {
-	int ret;
 	struct device_node *dn = ofdev->dev.of_node;
-	struct resource io_res;
-	struct resource ctl_res;
+	struct resource *io_res;
+	struct resource *ctl_res;
 	struct resource irq_res;
 	unsigned int reg_shift = 0;
 	int pio_mode = 0;
@@ -32,15 +30,15 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	bool use16bit;
 	int irq;
 
-	ret = of_address_to_resource(dn, 0, &io_res);
-	if (ret) {
+	io_res = platform_get_mem_or_io(ofdev, 0);
+	if (!io_res) {
 		dev_err(&ofdev->dev, "can't get IO address from "
 			"device tree\n");
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(dn, 1, &ctl_res);
-	if (ret) {
+	ctl_res = platform_get_mem_or_io(ofdev, 1);
+	if (!ctl_res) {
 		dev_err(&ofdev->dev, "can't get CTL address from "
 			"device tree\n");
 		return -EINVAL;
@@ -71,7 +69,7 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	pio_mask = 1 << pio_mode;
 	pio_mask |= (1 << pio_mode) - 1;
 
-	return __pata_platform_probe(&ofdev->dev, &io_res, &ctl_res, irq > 0 ? &irq_res : NULL,
+	return __pata_platform_probe(&ofdev->dev, io_res, ctl_res, irq > 0 ? &irq_res : NULL,
 				     reg_shift, pio_mask, &pata_platform_sht,
 				     use16bit);
 }
-- 
2.17.1

