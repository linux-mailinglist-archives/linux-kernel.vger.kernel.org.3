Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6E4FA68D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiDIJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbiDIJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:37:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623D23EC7F;
        Sat,  9 Apr 2022 02:34:45 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb8z95pl0zDq8C;
        Sat,  9 Apr 2022 17:32:21 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 17:34:42 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 17:34:41 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/sgl - align the hardware sgl dma address
Date:   Sat, 9 Apr 2022 17:33:09 +0800
Message-ID: <20220409093309.55715-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware needs aligned sgl dma address. So expend the sgl_size to
align 64 bytes.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index f7efc02b065f..2b6f2281cfd6 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 HiSilicon Limited. */
+#include <linux/align.h>
 #include <linux/dma-mapping.h>
 #include <linux/hisi_acc_qm.h>
 #include <linux/module.h>
@@ -64,8 +65,9 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
 	if (!dev || !count || !sge_nr || sge_nr > HISI_ACC_SGL_SGE_NR_MAX)
 		return ERR_PTR(-EINVAL);
 
-	sgl_size = sizeof(struct acc_hw_sge) * sge_nr +
-		   sizeof(struct hisi_acc_hw_sgl);
+	sgl_size = ALIGN(sizeof(struct acc_hw_sge) * sge_nr +
+			 sizeof(struct hisi_acc_hw_sgl),
+			 HISI_ACC_SGL_ALIGN_SIZE);
 
 	/*
 	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^(MAX_ORDER - 1),
-- 
2.24.0

