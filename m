Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552C547EF00
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 14:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbhLXNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 08:13:21 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:58378 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1352763AbhLXNNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 08:13:16 -0500
X-IronPort-AV: E=Sophos;i="5.88,232,1635174000"; 
   d="scan'208";a="104620431"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 22:13:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5113143A180E;
        Fri, 24 Dec 2021 22:13:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH v3 05/10] ata: pata_platform: Drop checking IRQ number
Date:   Fri, 24 Dec 2021 13:12:54 +0000
Message-Id: <20211224131300.18198-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of __pata_platform_probe() will pass the IRQ resource only for
valid IRQ's, for invalid IRQ's the IRQ resource will always be NULL. So
drop checking the IRQ number.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2-->v3
* New patch
---
 drivers/ata/pata_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 2e439b923762..f500f631f72b 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -114,7 +114,7 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 	/*
 	 * And the IRQ
 	 */
-	if (irq_res && irq_res->start > 0) {
+	if (irq_res) {
 		irq = irq_res->start;
 		irq_flags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
 	}
-- 
2.17.1

