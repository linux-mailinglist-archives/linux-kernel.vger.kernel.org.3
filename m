Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CFA4D7AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiCNGNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiCNGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:13:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E7193E5;
        Sun, 13 Mar 2022 23:12:38 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KH5kP0BGVzBrvc;
        Mon, 14 Mar 2022 14:10:37 +0800 (CST)
Received: from huawei.com (10.175.112.208) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 14:12:35 +0800
From:   Lijun Fang <fanglijun3@huawei.com>
To:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ming.qian@nxp.com>, <shijie.qin@nxp.com>, <eagle.zhou@nxp.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <xuqiang36@huawei.com>
Subject: [PATCH] media: amphion: Add missing of_node_put() in vpu_core_parse_dt
Date:   Mon, 14 Mar 2022 06:09:52 +0000
Message-ID: <20220314060952.66762-1-fanglijun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Lijun Fang <fanglijun3@huawei.com>
---
 drivers/media/platform/amphion/vpu_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 016554387f3f..74edc4abbdaa 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -529,10 +529,12 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
 	}
 	if (of_address_to_resource(node, 0, &res)) {
 		dev_err(core->dev, "boot-region of_address_to_resource error\n");
+		of_node_put(node);
 		return -EINVAL;
 	}
 	core->fw.phys = res.start;
 	core->fw.length = resource_size(&res);
+	of_node_put(node);
 
 	node = of_parse_phandle(np, "memory-region", 1);
 	if (!node) {
@@ -541,10 +543,12 @@ static int vpu_core_parse_dt(struct vpu_core *core, struct device_node *np)
 	}
 	if (of_address_to_resource(node, 0, &res)) {
 		dev_err(core->dev, "rpc-region of_address_to_resource error\n");
+		of_node_put(node);
 		return -EINVAL;
 	}
 	core->rpc.phys = res.start;
 	core->rpc.length = resource_size(&res);
+	of_node_put(node);
 
 	if (core->rpc.length < core->res->rpc_size + core->res->fwlog_size) {
 		dev_err(core->dev, "the rpc-region <%pad, 0x%x> is not enough\n",
-- 
2.17.1

