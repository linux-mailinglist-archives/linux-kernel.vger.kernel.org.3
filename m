Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CE559F217
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiHXDgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHXDgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:36:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891BD786D1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:36:05 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MCBVl2Pmmz1N7HZ;
        Wed, 24 Aug 2022 11:32:31 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 11:36:00 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <bristot@kernel.org>, <mingo@redhat.com>, <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>
Subject: [PATCH -next 1/2] rv/monitors: add 'static' qualifier for local symbols
Date:   Wed, 24 Aug 2022 11:43:56 +0800
Message-ID: <20220824034357.2014202-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824034357.2014202-1-zengheng4@huawei.com>
References: <20220824034357.2014202-1-zengheng4@huawei.com>
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

So does wip module.

Fixes:	ccc319dcb450 ("rv/monitor: Add the wwnr monitor")
Fixes:	8812d21219b9 ("rv/monitor: Add the wip monitor skeleton created by dot2k")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 kernel/trace/rv/monitors/wip/wip.c   | 4 ++--
 kernel/trace/rv/monitors/wwnr/wwnr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 83cace53b9fa..1a989bc142f3 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -16,7 +16,7 @@
 
 #include "wip.h"
 
-struct rv_monitor rv_wip;
+static struct rv_monitor rv_wip;
 DECLARE_DA_MON_PER_CPU(wip, unsigned char);
 
 static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
@@ -60,7 +60,7 @@ static void disable_wip(void)
 	da_monitor_destroy_wip();
 }
 
-struct rv_monitor rv_wip = {
+static struct rv_monitor rv_wip = {
 	.name = "wip",
 	.description = "wakeup in preemptive per-cpu testing monitor.",
 	.enable = enable_wip,
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

