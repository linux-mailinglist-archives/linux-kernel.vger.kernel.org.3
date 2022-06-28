Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CC55D763
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbiF1CNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243489AbiF1CMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:12:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90520BF5;
        Mon, 27 Jun 2022 19:12:51 -0700 (PDT)
X-UUID: d477a8a8031d42e0affb3f744de6740e-20220628
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:4300e45c-23cf-415b-b936-bf23a4128f10,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:49e2fed5-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: d477a8a8031d42e0affb3f744de6740e-20220628
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <peter.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 871487344; Tue, 28 Jun 2022 10:12:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 28 Jun 2022 10:12:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 28 Jun 2022 10:12:46 +0800
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
Subject: [PATCH v2] PM-runtime: Check supplier_preactivated before release supplier
Date:   Tue, 28 Jun 2022 10:12:44 +0800
Message-ID: <20220628021244.17281-1-peter.wang@mediatek.com>
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

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
---
 drivers/base/power/runtime.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 676dc72d912d..08bbc4561e60 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -337,8 +337,10 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
 	struct device_link *link;
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
-		pm_runtime_release_supplier(link, try_to_suspend);
+				device_links_read_lock_held()) {
+		if (!link->supplier_preactivated)
+			pm_runtime_release_supplier(link, try_to_suspend);
+	}
 }
 
 static void rpm_put_suppliers(struct device *dev)
-- 
2.18.0

