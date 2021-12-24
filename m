Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6247EF08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352830AbhLXNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:36 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:63126 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352783AbhLXNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:24 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="105104970"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:23 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2A94A43A180F;
        Fri, 24 Dec 2021 22:13:21 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 08/10] ata: pata_platform: Drop validating num_resources count
Date:   Fri, 24 Dec 2021 13:12:57 +0000
Message-Id: <20211224131300.18198-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop validating num_resources count as pata_platform_get_resources()
already does this check for us.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2-->v3
* New patch
---
 drivers/ata/pata_platform.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 4273f1a9abd2..88a9bdc81e68 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -265,14 +265,6 @@ static int pata_platform_get_pdata(struct platform_device *pdev,
 	struct pata_platform_info *pp_info = dev_get_platdata(&pdev->dev);
 	int ret;
 
-	/*
-	 * Simple resource validation ..
-	 */
-	if ((pdev->num_resources != 3) && (pdev->num_resources != 2)) {
-		dev_err(&pdev->dev, "invalid number of resources\n");
-		return -EINVAL;
-	}
-
 	ret = pata_platform_get_resources(pdev, priv);
 	if (ret)
 		return ret;
-- 
2.17.1

