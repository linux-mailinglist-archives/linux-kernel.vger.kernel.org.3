Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CBC595DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiHPNuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiHPNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:49:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708A97513
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:49:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6XVd1v1gzkWNx;
        Tue, 16 Aug 2022 21:46:17 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 21:49:36 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>
Subject: [PATCH -next 2/2] nvmem: core: add error handling for dev_set_name
Date:   Tue, 16 Aug 2022 21:49:35 +0800
Message-ID: <20220816134935.263825-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816134935.263825-1-cuigaosheng1@huawei.com>
References: <20220816134935.263825-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of return value of dev_set_name is int, which may return
wrong result, so we add error handling for it to reclaim memory
of nvmem resource, and return early when an error occurs.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/nvmem/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2164efd12ba9..321d7d63e068 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -810,18 +810,24 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	switch (config->id) {
 	case NVMEM_DEVID_NONE:
-		dev_set_name(&nvmem->dev, "%s", config->name);
+		rval = dev_set_name(&nvmem->dev, "%s", config->name);
 		break;
 	case NVMEM_DEVID_AUTO:
-		dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
+		rval = dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
 		break;
 	default:
-		dev_set_name(&nvmem->dev, "%s%d",
+		rval = dev_set_name(&nvmem->dev, "%s%d",
 			     config->name ? : "nvmem",
 			     config->name ? config->id : nvmem->id);
 		break;
 	}
 
+	if (rval) {
+		ida_free(&nvmem_ida, nvmem->id);
+		kfree(nvmem);
+		return ERR_PTR(rval);
+	}
+
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-- 
2.25.1

