Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94869527C44
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbiEPDRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiEPDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:17:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D82A11C15;
        Sun, 15 May 2022 20:17:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L1ksd2HH8z1JCFs;
        Mon, 16 May 2022 11:15:49 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 11:17:07 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 11:17:07 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <hannes@cmpxchg.org>,
        <surenb@google.com>, <alexs@kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 2/2] psi: add description about multi level pressure trigger
Date:   Mon, 16 May 2022 11:35:24 +0800
Message-ID: <20220516033524.3130816-2-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516033524.3130816-1-chenwandun@huawei.com>
References: <20220516033524.3130816-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add description about multi level pressure tirgger in documentation
about psi.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 Documentation/accounting/psi.rst                    | 12 ++++++------
 Documentation/translations/zh_CN/accounting/psi.rst | 11 ++++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index 860fe651d645..7abfe4fff201 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -81,12 +81,12 @@ desired threshold and time window. The open file descriptor should be
 used to wait for trigger events using select(), poll() or epoll().
 The following format is used::
 
-	<some|full> <stall amount in us> <time window in us>
+<some|full> <min stall amount in us> <max stall amount in us> <time window in us>
 
-For example writing "some 150000 1000000" into /proc/pressure/memory
-would add 150ms threshold for partial memory stall measured within
-1sec time window. Writing "full 50000 1000000" into /proc/pressure/io
-would add 50ms threshold for full io stall measured within 1sec time window.
+For example writing "some 150000 350000 1000000" into /proc/pressure/memory
+would add 150ms ~ 350ms threshold for partial memory stall measured within
+1sec time window. Writing "full 50000 70000 1000000" into /proc/pressure/io
+would add 50ms ~ 70ms threshold for full io stall measured within 1sec time window.
 
 Triggers can be set on more than one psi metric and more than one trigger
 for the same psi metric can be specified. However for each trigger a separate
@@ -132,7 +132,7 @@ Userspace monitor usage example
    * and 150ms threshold.
    */
   int main() {
-	const char trig[] = "some 150000 1000000";
+	const char trig[] = "some 150000 350000 1000000";
 	struct pollfd fds;
 	int n;
 
diff --git a/Documentation/translations/zh_CN/accounting/psi.rst b/Documentation/translations/zh_CN/accounting/psi.rst
index a0ddb7bd257c..9e8f6467e034 100644
--- a/Documentation/translations/zh_CN/accounting/psi.rst
+++ b/Documentation/translations/zh_CN/accounting/psi.rst
@@ -69,11 +69,12 @@ avg代表阻塞时间占比（百分比），为最近10秒、60秒、300秒内
 所打开的文件描述符用于等待事件，可使用select()、poll()、epoll()。
 写入信息的格式如下：
 
-        <some|full> <stall amount in us> <time window in us>
+        <some|full> <min stall amount in us> <max stall amount in us> <time window in us>
 
-示例：向/proc/pressure/memory写入"some 150000 1000000"将新增触发器，将在
-1秒内至少一个任务阻塞于内存的总时间超过150ms时触发。向/proc/pressure/io写入
-"full 50000 1000000"将新增触发器，将在1秒内所有任务都阻塞于io的总时间超过50ms时触发。
+示例：向/proc/pressure/memory写入"some 150000 350000, 1000000"将新增触发器，将在
+1秒内至少一个任务阻塞于内存的总时间在150ms ~ 350ms时触发。向/proc/pressure/io写入
+"full 50000 70000 1000000"将新增触发器，将在1秒内所有任务都阻塞于io的总时间在50ms ~ 70ms
+时触发。
 
 触发器可针对多个psi度量值设置，同一个psi度量值可设置多个触发器。每个触发器需要
 单独的文件描述符用于轮询，以区分于其他触发器。所以即使对于同一个psi接口文件，
@@ -105,7 +106,7 @@ psi接口提供的均值即可。
 
   /* 监控内存部分阻塞，监控时间窗口为1秒、阻塞门限为150毫秒。*/
   int main() {
-        const char trig[] = "some 150000 1000000";
+        const char trig[] = "some 150000 350000 1000000";
         struct pollfd fds;
         int n;
 
-- 
2.25.1

