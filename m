Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81CA47FD4C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhL0NUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:20:49 -0500
Received: from mx.socionext.com ([202.248.49.38]:32176 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhL0NUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:20:48 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Dec 2021 22:20:48 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id F097420584CE;
        Mon, 27 Dec 2021 22:20:47 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 27 Dec 2021 22:20:47 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id BFA12B568B;
        Mon, 27 Dec 2021 22:20:47 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] genirq/msi: Fix a duplicate issue for interrupt sysfs
Date:   Mon, 27 Dec 2021 22:20:43 +0900
Message-Id: <1640611243-29116-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function msi_sysfs_populate_desc() has a for-loop with the number of
interrupts, and it is called inside a for-loop with the same interrupts
in __msi_domain_alloc_irqs().

So, msi_sysfs_populate_desc() is called multiple times for the same
descriptor, and a duplicate error for sysfs will occur. It should be
called out of the for-loop.

Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: bf5e758f02fc ("genirq/msi: Simplify sysfs handling")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 kernel/irq/msi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 173bc04f9fe5..2f1c4ff8c683 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -887,12 +887,12 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			ret = msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
+		}
 
-			if (info->flags & MSI_FLAG_DEV_SYSFS) {
-				ret = msi_sysfs_populate_desc(dev, desc);
-				if (ret)
-					return ret;
-			}
+		if (info->flags & MSI_FLAG_DEV_SYSFS) {
+			ret = msi_sysfs_populate_desc(dev, desc);
+			if (ret)
+				return ret;
 		}
 		allocated++;
 	}
-- 
2.7.4

