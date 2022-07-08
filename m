Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8D556BA8D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiGHNUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGHNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:20:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985852A41D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:20:08 -0700 (PDT)
X-UUID: 4dfd1f9a9af34c2b93db8d42b015d21e-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:77e217b6-f735-4215-a17c-ae3ac49991ff,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:77e217b6-f735-4215-a17c-ae3ac49991ff,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:bfc9eb86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:6461a1b93461,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4dfd1f9a9af34c2b93db8d42b015d21e-20220708
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1647103973; Fri, 08 Jul 2022 21:20:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 8 Jul 2022 21:20:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 8 Jul 2022 21:20:00 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <yj.chiang@mediatek.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] lib: devres: use numa aware allocation
Date:   Fri, 8 Jul 2022 21:19:47 +0800
Message-ID: <20220708131952.14500-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate device resource from local node memory
when the numa locality of the device is specified.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 lib/devres.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index 14664bbb4875..55eb07e80cbb 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -29,7 +29,8 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
 {
 	void __iomem **ptr, *addr = NULL;
 
-	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	ptr = devres_alloc_node(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL,
+				dev_to_node(dev));
 	if (!ptr)
 		return NULL;
 
@@ -292,7 +293,8 @@ void __iomem *devm_ioport_map(struct device *dev, unsigned long port,
 {
 	void __iomem **ptr, *addr;
 
-	ptr = devres_alloc(devm_ioport_map_release, sizeof(*ptr), GFP_KERNEL);
+	ptr = devres_alloc_node(devm_ioport_map_release, sizeof(*ptr), GFP_KERNEL,
+				dev_to_node(dev));
 	if (!ptr)
 		return NULL;
 
@@ -366,7 +368,8 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 	if (dr)
 		return dr->table;
 
-	new_dr = devres_alloc(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL);
+	new_dr = devres_alloc_node(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL,
+				   dev_to_node(&pdev->dev));
 	if (!new_dr)
 		return NULL;
 	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
@@ -548,7 +551,8 @@ int devm_arch_phys_wc_add(struct device *dev, unsigned long base, unsigned long
 	int *mtrr;
 	int ret;
 
-	mtrr = devres_alloc(devm_arch_phys_ac_add_release, sizeof(*mtrr), GFP_KERNEL);
+	mtrr = devres_alloc_node(devm_arch_phys_ac_add_release, sizeof(*mtrr), GFP_KERNEL,
+				 dev_to_node(dev));
 	if (!mtrr)
 		return -ENOMEM;
 
@@ -593,7 +597,8 @@ int devm_arch_io_reserve_memtype_wc(struct device *dev, resource_size_t start,
 	struct arch_io_reserve_memtype_wc_devres *dr;
 	int ret;
 
-	dr = devres_alloc(devm_arch_io_free_memtype_wc_release, sizeof(*dr), GFP_KERNEL);
+	dr = devres_alloc_node(devm_arch_io_free_memtype_wc_release, sizeof(*dr), GFP_KERNEL,
+			       dev_to_node(dev));
 	if (!dr)
 		return -ENOMEM;
 
-- 
2.32.0

