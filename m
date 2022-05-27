Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68453598A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbiE0GoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbiE0GoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:44:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE547ED7AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:44:15 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8ZxF2QNbz1JCRb;
        Fri, 27 May 2022 14:42:41 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:44:14 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:44:13 +0800
From:   keliu <liuke94@huawei.com>
To:     <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: mfd: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:05:43 +0000
Message-ID: <20220527070543.2359316-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
 drivers/mfd/intel-lpss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index cfbee2cfba6b..f6628874d7f1 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -405,7 +405,7 @@ int intel_lpss_probe(struct device *dev,
 
 	intel_lpss_init_dev(lpss);
 
-	lpss->devid = ida_simple_get(&intel_lpss_devid_ida, 0, 0, GFP_KERNEL);
+	lpss->devid = ida_alloc(&intel_lpss_devid_ida, GFP_KERNEL);
 	if (lpss->devid < 0)
 		return lpss->devid;
 
@@ -442,7 +442,7 @@ int intel_lpss_probe(struct device *dev,
 	intel_lpss_unregister_clock(lpss);
 
 err_clk_register:
-	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
+	ida_free(&intel_lpss_devid_ida, lpss->devid);
 
 	return ret;
 }
@@ -456,7 +456,7 @@ void intel_lpss_remove(struct device *dev)
 	intel_lpss_debugfs_remove(lpss);
 	intel_lpss_ltr_hide(lpss);
 	intel_lpss_unregister_clock(lpss);
-	ida_simple_remove(&intel_lpss_devid_ida, lpss->devid);
+	ida_free(&intel_lpss_devid_ida, lpss->devid);
 }
 EXPORT_SYMBOL_GPL(intel_lpss_remove);
 
-- 
2.25.1

