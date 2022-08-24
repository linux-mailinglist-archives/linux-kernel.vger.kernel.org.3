Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA259F216
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiHXDgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiHXDgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:36:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E678BE0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:36:05 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCBTq4c87zXf0y;
        Wed, 24 Aug 2022 11:31:43 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 11:36:00 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <bristot@kernel.org>, <mingo@redhat.com>, <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>
Subject: [PATCH -next 2/2] rv/dot2K: add 'static' qualifier for local variable
Date:   Wed, 24 Aug 2022 11:43:57 +0800
Message-ID: <20220824034357.2014202-3-zengheng4@huawei.com>
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

Following Daniel's suggestion, fix similar warning
in template files, which would prevent new monitors
from such warning.

Fixes:	24bce201d798 ("tools/rv: Add dot2k")
Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 tools/verification/dot2/dot2k_templates/main_global.c   | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_cpu.c  | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_task.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/verification/dot2/dot2k_templates/main_global.c b/tools/verification/dot2/dot2k_templates/main_global.c
index f4b712dbc92e..dcd1162dced8 100644
--- a/tools/verification/dot2/dot2k_templates/main_global.c
+++ b/tools/verification/dot2/dot2k_templates/main_global.c
@@ -27,7 +27,7 @@
  *
  * The rv monitor reference is needed for the monitor declaration.
  */
-struct rv_monitor rv_MODEL_NAME;
+static struct rv_monitor rv_MODEL_NAME;
 DECLARE_DA_MON_GLOBAL(MODEL_NAME, MIN_TYPE);
 
 /*
@@ -63,7 +63,7 @@ TRACEPOINT_DETACH
 /*
  * This is the monitor register section.
  */
-struct rv_monitor rv_MODEL_NAME = {
+static struct rv_monitor rv_MODEL_NAME = {
 	.name = "MODEL_NAME",
 	.description = "auto-generated MODEL_NAME",
 	.enable = enable_MODEL_NAME,
diff --git a/tools/verification/dot2/dot2k_templates/main_per_cpu.c b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
index 4080d1ca3354..8f877e86a22f 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_cpu.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_cpu.c
@@ -27,7 +27,7 @@
  *
  * The rv monitor reference is needed for the monitor declaration.
  */
-struct rv_monitor rv_MODEL_NAME;
+static struct rv_monitor rv_MODEL_NAME;
 DECLARE_DA_MON_PER_CPU(MODEL_NAME, MIN_TYPE);
 
 /*
@@ -63,7 +63,7 @@ TRACEPOINT_DETACH
 /*
  * This is the monitor register section.
  */
-struct rv_monitor rv_MODEL_NAME = {
+static struct rv_monitor rv_MODEL_NAME = {
 	.name = "MODEL_NAME",
 	.description = "auto-generated MODEL_NAME",
 	.enable = enable_MODEL_NAME,
diff --git a/tools/verification/dot2/dot2k_templates/main_per_task.c b/tools/verification/dot2/dot2k_templates/main_per_task.c
index 89197175384f..8c2fdb824634 100644
--- a/tools/verification/dot2/dot2k_templates/main_per_task.c
+++ b/tools/verification/dot2/dot2k_templates/main_per_task.c
@@ -27,7 +27,7 @@
  *
  * The rv monitor reference is needed for the monitor declaration.
  */
-struct rv_monitor rv_MODEL_NAME;
+static struct rv_monitor rv_MODEL_NAME;
 DECLARE_DA_MON_PER_TASK(MODEL_NAME, MIN_TYPE);
 
 /*
@@ -63,7 +63,7 @@ TRACEPOINT_DETACH
 /*
  * This is the monitor register section.
  */
-struct rv_monitor rv_MODEL_NAME = {
+static struct rv_monitor rv_MODEL_NAME = {
 	.name = "MODEL_NAME",
 	.description = "auto-generated MODEL_NAME",
 	.enable = enable_MODEL_NAME,
-- 
2.25.1

