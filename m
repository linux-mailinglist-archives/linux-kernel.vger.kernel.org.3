Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A5A5359D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiE0HGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbiE0HGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:06:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBE242
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:06:17 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L8bSK47sXzDqJk;
        Fri, 27 May 2022 15:06:09 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:06:15 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 15:06:15 +0800
From:   keliu <liuke94@huawei.com>
To:     <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] intel_th: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:27:43 +0000
Message-ID: <20220527072743.2383355-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/hwtracing/intel_th/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 7e753a75d23b..7393cc0c64ac 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -871,7 +871,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 	if (!th)
 		return ERR_PTR(-ENOMEM);
 
-	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
+	th->id = ida_alloc(&intel_th_ida, GFP_KERNEL);
 	if (th->id < 0) {
 		err = th->id;
 		goto err_alloc;
@@ -931,7 +931,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 			    "intel_th/output");
 
 err_ida:
-	ida_simple_remove(&intel_th_ida, th->id);
+	ida_free(&intel_th_ida, th->id);
 
 err_alloc:
 	kfree(th);
@@ -964,7 +964,7 @@ void intel_th_free(struct intel_th *th)
 	__unregister_chrdev(th->major, 0, TH_POSSIBLE_OUTPUTS,
 			    "intel_th/output");
 
-	ida_simple_remove(&intel_th_ida, th->id);
+	ida_free(&intel_th_ida, th->id);
 
 	kfree(th);
 }
-- 
2.25.1

