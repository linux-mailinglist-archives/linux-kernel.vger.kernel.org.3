Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3749554998D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiFMRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241479AbiFMRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:07:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5612D51584;
        Mon, 13 Jun 2022 05:08:50 -0700 (PDT)
X-UUID: 5d53052143be4ea7bc129160d017d1d5-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:2e088a7d-9406-4732-962a-9b020583c614,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:3fc38c37-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 5d53052143be4ea7bc129160d017d1d5-20220613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 342569661; Mon, 13 Jun 2022 20:08:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Jun 2022 20:08:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 13 Jun 2022 20:08:06 +0800
From:   <peter.wang@mediatek.com>
To:     <matthias.bgg@gmail.com>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <stanley.chu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC:     <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <powen.kao@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <tun-yu.yu@mediatek.com>
Subject: [PATCH v1] PM-runtime: Check supplier_preactivated before release supplier
Date:   Mon, 13 Jun 2022 20:07:55 +0800
Message-ID: <20220613120755.14306-1-peter.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Wang <peter.wang@mediatek.com>

With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
to prevent supplier enter suspend, pm_runtime_release_supplier should
check supplier_preactivated before let supplier enter suspend.

If the link is drop or release, bypass check supplier_preactivated.

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
---
 drivers/base/core.c          |  2 +-
 drivers/base/power/runtime.c | 15 ++++++++++++---
 include/linux/pm_runtime.h   |  5 +++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7cd789c4985d..3b9cc559928f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -486,7 +486,7 @@ static void device_link_release_fn(struct work_struct *work)
 	/* Ensure that all references to the link object have been dropped. */
 	device_link_synchronize_removal();
 
-	pm_runtime_release_supplier(link, true);
+	pm_runtime_release_supplier(link, true, true);
 
 	put_device(link->consumer);
 	put_device(link->supplier);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 676dc72d912d..3c4f425937a1 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -314,10 +314,19 @@ static int rpm_get_suppliers(struct device *dev)
  * and if @check_idle is set, check if that device is idle (and so it can be
  * suspended).
  */
-void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
+void pm_runtime_release_supplier(struct device_link *link, bool check_idle,
+	bool drop)
 {
 	struct device *supplier = link->supplier;
 
+	/*
+	 * When consumer hold supplier, supplier cannot enter suspend.
+	 * Driect release supplier and let supplier enter suspend is not allow.
+	 * Unless the link is drop, direct relsease supplier should be okay.
+	 */
+	if (link->supplier_preactivated && !drop)
+		return;
+
 	/*
 	 * The additional power.usage_count check is a safety net in case
 	 * the rpm_active refcount becomes saturated, in which case
@@ -338,7 +347,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held())
-		pm_runtime_release_supplier(link, try_to_suspend);
+		pm_runtime_release_supplier(link, try_to_suspend, false);
 }
 
 static void rpm_put_suppliers(struct device *dev)
@@ -1838,7 +1847,7 @@ void pm_runtime_drop_link(struct device_link *link)
 		return;
 
 	pm_runtime_drop_link_count(link->consumer);
-	pm_runtime_release_supplier(link, true);
+	pm_runtime_release_supplier(link, true, true);
 }
 
 static bool pm_runtime_need_not_resume(struct device *dev)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 9e4d056967c6..354ffb1eaec0 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -88,7 +88,8 @@ extern void pm_runtime_get_suppliers(struct device *dev);
 extern void pm_runtime_put_suppliers(struct device *dev);
 extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
-extern void pm_runtime_release_supplier(struct device_link *link, bool check_idle);
+extern void pm_runtime_release_supplier(struct device_link *link,
+	bool check_idle, bool drop);
 
 extern int devm_pm_runtime_enable(struct device *dev);
 
@@ -315,7 +316,7 @@ static inline void pm_runtime_put_suppliers(struct device *dev) {}
 static inline void pm_runtime_new_link(struct device *dev) {}
 static inline void pm_runtime_drop_link(struct device_link *link) {}
 static inline void pm_runtime_release_supplier(struct device_link *link,
-					       bool check_idle) {}
+					       bool check_idle, bool drop) {}
 
 #endif /* !CONFIG_PM */
 
-- 
2.18.0

