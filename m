Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA53478D36
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhLQOR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:17:28 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:61096 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231770AbhLQOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:17:26 -0500
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; 
   d="scan'208";a="104310489"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Dec 2021 23:17:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 612E14007F26;
        Fri, 17 Dec 2021 23:17:24 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] ata: pata_platform: make use of platform_get_mem_or_io()
Date:   Fri, 17 Dec 2021 14:17:14 +0000
Message-Id: <20211217141715.29747-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211217141715.29747-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of platform_get_mem_or_io() to simplify the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

