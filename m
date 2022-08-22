Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50AD59B954
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiHVGXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiHVGXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:23:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23227177
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:23:00 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MB2Kj1t8BznThx;
        Mon, 22 Aug 2022 14:20:41 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 22 Aug
 2022 14:22:57 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <bristot@kernel.org>
CC:     <liwei391@huawei.com>, <zengheng4@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] trace: wwnr: Make local symbol 'rv_wwnr' static
Date:   Mon, 22 Aug 2022 14:30:56 +0800
Message-ID: <20220822063056.3890045-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

kernel/trace/rv/monitors/wwnr/wwnr.c:18:19:
warning: symbol 'rv_wwnr' was not declared. Should it be static?

The `rv_wwnr` symbol is not dereferenced by other extern files,
so add static qualifier for it.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 kernel/trace/rv/monitors/wwnr/wwnr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 599225d9cf38..a063b93c6a1d 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -15,7 +15,7 @@
 
 #include "wwnr.h"
 
-struct rv_monitor rv_wwnr;
+static struct rv_monitor rv_wwnr;
 DECLARE_DA_MON_PER_TASK(wwnr, unsigned char);
 
 static void handle_switch(void *data, bool preempt, struct task_struct *p,
@@ -59,7 +59,7 @@ static void disable_wwnr(void)
 	da_monitor_destroy_wwnr();
 }
 
-struct rv_monitor rv_wwnr = {
+static struct rv_monitor rv_wwnr = {
 	.name = "wwnr",
 	.description = "wakeup while not running per-task testing model.",
 	.enable = enable_wwnr,
-- 
2.25.1

