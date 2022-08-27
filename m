Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4445A365F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiH0Jig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiH0Jid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:38:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C18E9A5;
        Sat, 27 Aug 2022 02:38:32 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MFBPX2FM3zkWV9;
        Sat, 27 Aug 2022 17:34:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 17:38:30 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 17:38:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <tony@atomide.com>, <p.zabel@pengutronix.de>
Subject: [PATCH -next] bus: ti-sysc: Use list_for_each_entry() helper
Date:   Sat, 27 Aug 2022 17:46:04 +0800
Message-ID: <20220827094604.3325887-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Convert list_for_each() to list_for_each_entry() where applicable.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/bus/ti-sysc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 51d772bb8046..8afa0245b31b 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2526,11 +2526,9 @@ static struct dev_pm_domain sysc_child_pm_domain = {
 static void sysc_reinit_modules(struct sysc_soc_info *soc)
 {
 	struct sysc_module *module;
-	struct list_head *pos;
 	struct sysc *ddata;
 
-	list_for_each(pos, &sysc_soc->restored_modules) {
-		module = list_entry(pos, struct sysc_module, node);
+	list_for_each_entry(module, &sysc_soc->restored_modules, node) {
 		ddata = module->ddata;
 		sysc_reinit_module(ddata, ddata->enabled);
 	}
@@ -3211,12 +3209,10 @@ static void sysc_cleanup_static_data(void)
 static int sysc_check_disabled_devices(struct sysc *ddata)
 {
 	struct sysc_address *disabled_module;
-	struct list_head *pos;
 	int error = 0;
 
 	mutex_lock(&sysc_soc->list_lock);
-	list_for_each(pos, &sysc_soc->disabled_modules) {
-		disabled_module = list_entry(pos, struct sysc_address, node);
+	list_for_each_entry(disabled_module, &sysc_soc->disabled_modules, node) {
 		if (ddata->module_pa == disabled_module->base) {
 			dev_dbg(ddata->dev, "module disabled for this SoC\n");
 			error = -ENODEV;
-- 
2.25.1

