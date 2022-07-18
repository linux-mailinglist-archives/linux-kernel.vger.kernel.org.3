Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66C1578281
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiGRMj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiGRMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:39:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91E7DF5A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:39:52 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LmhN91ppjzFq8d;
        Mon, 18 Jul 2022 20:38:49 +0800 (CST)
Received: from dggphis33418.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 20:39:49 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <cuigaosheng1@huawei.com>, <srinivas.kandagatla@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <gongruiqi1@huawei.com>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next,v5] nvmem: core: Fix memleak in nvmem_register()
Date:   Mon, 18 Jul 2022 20:39:49 +0800
Message-ID: <20220718123949.3111223-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_set_name will alloc memory for nvmem->dev.kobj.name in
nvmem_register, when nvmem_validate_keepouts failed, nvmem's
memory will be freed and return, but nobody will free memory
for nvmem->dev.kobj.name, there will be memleak, so moving
nvmem_validate_keepouts() after device_register() and let
the device core deal with cleaning name in error cases.

Fixes: de0534df9347 ("nvmem: core: fix error handling while validating keepout regions")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/nvmem/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1e3c754efd0d..2164efd12ba9 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -829,21 +829,18 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->dev.groups = nvmem_dev_groups;
 #endif
 
-	if (nvmem->nkeepout) {
-		rval = nvmem_validate_keepouts(nvmem);
-		if (rval) {
-			ida_free(&nvmem_ida, nvmem->id);
-			kfree(nvmem);
-			return ERR_PTR(rval);
-		}
-	}
-
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_register(&nvmem->dev);
 	if (rval)
 		goto err_put_device;
 
+	if (nvmem->nkeepout) {
+		rval = nvmem_validate_keepouts(nvmem);
+		if (rval)
+			goto err_device_del;
+	}
+
 	if (config->compat) {
 		rval = nvmem_sysfs_setup_compat(nvmem, config);
 		if (rval)
-- 
2.25.1

