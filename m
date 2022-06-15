Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB354C002
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345906AbiFODLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiFODLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:11:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7164C414
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:11:41 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LN9H90T2wzRjYq;
        Wed, 15 Jun 2022 11:08:21 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 11:11:23 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 11:11:22 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>
Subject: [PATCH -next] powerpc/fsl_rio: add missing of_node_put() in fsl_rio_setup()
Date:   Wed, 15 Jun 2022 11:21:37 +0800
Message-ID: <20220615032137.1878219-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_compatible_node() and for_each_child_of_node() will increase
the refcount of 'np', so add of_node_put() after using it to avoid
refcount leak.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/powerpc/sysdev/fsl_rio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 1bfc9afa8a1a..97bbecb259dc 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -542,9 +542,11 @@ int fsl_rio_setup(struct platform_device *dev)
 	if (!dt_range) {
 		pr_err("%pOF: unable to find 'reg' property\n",
 			np);
+		of_node_put(np);
 		rc = -ENOMEM;
 		goto err_pw;
 	}
+	of_node_put(np);
 	range_start = of_read_number(dt_range, aw);
 	dbell->dbell_regs = (struct rio_dbell_regs *)(rmu_regs_win +
 				(u32)range_start);
@@ -570,9 +572,11 @@ int fsl_rio_setup(struct platform_device *dev)
 	if (!dt_range) {
 		pr_err("%pOF: unable to find 'reg' property\n",
 			np);
+		of_node_put(np);
 		rc = -ENOMEM;
 		goto err;
 	}
+	of_node_put(np);
 	range_start = of_read_number(dt_range, aw);
 	pw->pw_regs = (struct rio_pw_regs *)(rmu_regs_win + (u32)range_start);
 
@@ -582,6 +586,7 @@ int fsl_rio_setup(struct platform_device *dev)
 		if (!port_index) {
 			dev_err(&dev->dev, "Can't get %pOF property 'cell-index'\n",
 					np);
+			of_node_put(np);
 			continue;
 		}
 
@@ -589,6 +594,7 @@ int fsl_rio_setup(struct platform_device *dev)
 		if (!dt_range) {
 			dev_err(&dev->dev, "Can't get %pOF property 'ranges'\n",
 					np);
+			of_node_put(np);
 			continue;
 		}
 
@@ -611,6 +617,7 @@ int fsl_rio_setup(struct platform_device *dev)
 
 		dev_info(&dev->dev, "%pOF: LAW start 0x%016llx, size 0x%016llx.\n",
 				np, range_start, range_size);
+		of_node_put(np);
 
 		port = kzalloc(sizeof(struct rio_mport), GFP_KERNEL);
 		if (!port)
-- 
2.25.1

