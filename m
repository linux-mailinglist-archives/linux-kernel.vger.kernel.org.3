Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022EA47EEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352740AbhLXNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:09 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:58378 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352728AbhLXNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:08 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104620424"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:06 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2E68443A180E;
        Fri, 24 Dec 2021 22:13:05 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 01/10] ata: pata_platform: Make use of platform_get_mem_or_io()
Date:   Fri, 24 Dec 2021 13:12:50 +0000
Message-Id: <20211224131300.18198-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of platform_get_mem_or_io() to simplify the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
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

