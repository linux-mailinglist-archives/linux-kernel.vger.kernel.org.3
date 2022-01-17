Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4471490018
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiAQCCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:02:07 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:59352 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236739AbiAQCCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:02:06 -0500
X-IronPort-AV: E=Sophos;i="5.88,294,1635174000"; 
   d="scan'208";a="107257767"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Jan 2022 11:02:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2CEB8400855F;
        Mon, 17 Jan 2022 11:02:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] ata: pata_platform: Make use of platform_get_mem_or_io()
Date:   Mon, 17 Jan 2022 02:01:34 +0000
Message-Id: <20220117020134.3279-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of platform_get_mem_or_io() to simplify the code.

While at it, drop use of unlikely() from pata_platform_probe()
as it isn't a hotpath.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
Hi All,

This patch is part of series [1]. Just sending this lone patch
for now.

[1] http://patchwork.ozlabs.org/project/linux-ide/list/?series=278349

Cheers,
Prabhakar
---
 drivers/ata/pata_platform.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 028329428b75..29902001e223 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -198,22 +198,16 @@ static int pata_platform_probe(struct platform_device *pdev)
 	/*
 	 * Get the I/O base first
 	 */
-	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (io_res == NULL) {
-		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (unlikely(io_res == NULL))
-			return -EINVAL;
-	}
+	io_res = platform_get_mem_or_io(pdev, 0);
+	if (!io_res)
+		return -EINVAL;
 
 	/*
 	 * Then the CTL base
 	 */
-	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
-	if (ctl_res == NULL) {
-		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (unlikely(ctl_res == NULL))
-			return -EINVAL;
-	}
+	ctl_res = platform_get_mem_or_io(pdev, 1);
+	if (!ctl_res)
+		return -EINVAL;
 
 	/*
 	 * And the IRQ
-- 
2.17.1

