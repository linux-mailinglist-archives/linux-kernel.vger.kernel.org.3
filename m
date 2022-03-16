Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88A34DAC38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354401AbiCPIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiCPIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:07:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D3D5E773;
        Wed, 16 Mar 2022 01:05:54 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJN8B3WltzfZ6l;
        Wed, 16 Mar 2022 16:03:54 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 16:05:22 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 16:05:21 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <ming.qian@nxp.com>, <shijie.qin@nxp.com>, <eagle.zhou@nxp.com>,
        <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH -next] media: amphion: Add missing of_node_put() in vpu_core_parse_dt()
Date:   Wed, 16 Mar 2022 16:19:38 +0800
Message-ID: <20220316081938.80819-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() will increment the refcount of the returned
device_node. Calling of_node_put() to avoid the refcount leak.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/media/platform/amphion/vpu_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 016554387f3f..1da20335bc45 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -529,11 +529,14 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
 	}
 	if (of_address_to_resource(node, 0, &res)) {
 		dev_err(core->dev, "boot-region of_address_to_resource error\n");
+		of_node_put(node);
 		return -EINVAL;
 	}
 	core->fw.phys = res.start;
 	core->fw.length = resource_size(&res);
 
+	of_node_put(node);
+
 	node = of_parse_phandle(np, "memory-region", 1);
 	if (!node) {
 		dev_err(core->dev, "rpc-region of_parse_phandle error\n");
@@ -541,6 +544,7 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
 	}
 	if (of_address_to_resource(node, 0, &res)) {
 		dev_err(core->dev, "rpc-region of_address_to_resource error\n");
+		of_node_put(node);
 		return -EINVAL;
 	}
 	core->rpc.phys = res.start;
@@ -549,6 +553,7 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
 	if (core->rpc.length < core->res->rpc_size + core->res->fwlog_size) {
 		dev_err(core->dev, "the rpc-region <%pad, 0x%x> is not enough\n",
 			&core->rpc.phys, core->rpc.length);
+		of_node_put(node);
 		return -EINVAL;
 	}
 
@@ -560,6 +565,7 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
 	if (ret != VPU_CORE_MEMORY_UNCACHED) {
 		dev_err(core->dev, "rpc region<%pad, 0x%x> isn't uncached\n",
 			&core->rpc.phys, core->rpc.length);
+		of_node_put(node);
 		return -EINVAL;
 	}
 
@@ -571,6 +577,8 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
 	core->act.length = core->rpc.length - core->res->rpc_size - core->log.length;
 	core->rpc.length = core->res->rpc_size;
 
+	of_node_put(node);
+
 	return 0;
 }
 
-- 
2.20.1

