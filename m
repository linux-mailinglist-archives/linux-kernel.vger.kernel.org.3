Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3A47C3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbhLUQ0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:26:44 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:31790 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239720AbhLUQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:26:43 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104252144"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 01:26:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2222440A64B7;
        Wed, 22 Dec 2021 01:26:39 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/4] ata: pata_platform: make use of platform_get_mem_or_io()
Date:   Tue, 21 Dec 2021 16:26:11 +0000
Message-Id: <20211221162614.25308-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of platform_get_mem_or_io() to simplify the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1-->v2
* No change
---
 drivers/ata/pata_platform.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 028329428b75..cb3134bf88eb 100644
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
+	if (unlikely(!io_res))
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
+	if (unlikely(!ctl_res))
+		return -EINVAL;
 
 	/*
 	 * And the IRQ
-- 
2.17.1

