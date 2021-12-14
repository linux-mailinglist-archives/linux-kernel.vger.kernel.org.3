Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF1473D56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhLNGrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:47:22 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54379 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhLNGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:47:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jkchen@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V-bU6w5_1639464436;
Received: from localhost(mailfrom:jkchen@linux.alibaba.com fp:SMTPD_---0V-bU6w5_1639464436)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Dec 2021 14:47:17 +0800
From:   Jay Chen <jkchen@linux.alibaba.com>
To:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangliguang@linux.alibaba.com
Subject: [RFC PATCH] irqchip/gic-v4.1:fix the kdump GIC ITS RAS error for ITS BASER2
Date:   Tue, 14 Dec 2021 14:47:16 +0800
Message-Id: <20211214064716.21407-1-jkchen@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encounter a GIC RAS Error in below flow:
(1) Configure ITS related register (including
	GITS_BASER2, GITS_BASER2.valid = 1'b1)
(2) Configure GICR related register (including
	GICR_VPROPBASER, GICR_VPROPBASER.valid = 1'b1)
The common settings in above 2 register are the same
and currently everything is OK
(3) Kernel panic and os start the kdump flow.And then os
reconfigure ITS related register (including GITS_BASER2,
GITS_BASER2.valid = 1'b1). But at this time, gicr_vpropbaser
is not initialized, so it is still an old value. At this point,
the new value of its_baser2 and the old value of gicr_vpropbaser is
different, resulting in its RAS error.

https://bugzilla.kernel.org/show_bug.cgi?id=215327

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index eb0882d15366..c340bbf4427b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2623,6 +2623,12 @@ static int its_alloc_tables(struct its_node *its)
 			return err;
 		}
 
+		if ((i == 2) && is_kdump_kernel() && is_v4_1(its)) {
+			val = its_read_baser(its, baser);
+			val &= ~GITS_BASER_VALID;
+			its_write_baser(its, baser, val);
+		}
+
 		/* Update settings which will be used for next BASERn */
 		cache = baser->val & GITS_BASER_CACHEABILITY_MASK;
 		shr = baser->val & GITS_BASER_SHAREABILITY_MASK;
-- 
2.27.0

