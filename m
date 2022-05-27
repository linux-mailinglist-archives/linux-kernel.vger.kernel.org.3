Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A65359A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbiE0GwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiE0GwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:52:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F608C5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:52:12 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8b6P4TgKz1JCT8;
        Fri, 27 May 2022 14:50:37 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:52:10 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 14:52:10 +0800
From:   keliu <liuke94@huawei.com>
To:     <sboyd@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: spmi: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 07:13:38 +0000
Message-ID: <20220527071338.2359733-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/spmi/spmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index b37ead9e2fad..8a2a33876944 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -35,7 +35,7 @@ static void spmi_ctrl_release(struct device *dev)
 {
 	struct spmi_controller *ctrl = to_spmi_controller(dev);
 
-	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	ida_free(&ctrl_ida, ctrl->nr);
 	kfree(ctrl);
 }
 
@@ -440,7 +440,7 @@ struct spmi_controller *spmi_controller_alloc(struct device *parent,
 	ctrl->dev.of_node = parent->of_node;
 	spmi_controller_set_drvdata(ctrl, &ctrl[1]);
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(parent,
 			"unable to allocate SPMI controller identifier.\n");
-- 
2.25.1

