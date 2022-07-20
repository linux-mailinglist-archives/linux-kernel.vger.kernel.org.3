Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7209457AE20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiGTCq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbiGTCq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:46:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F96FA04
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:46:56 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lng3t1TdzzVg4s;
        Wed, 20 Jul 2022 10:43:06 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 10:46:50 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 10:46:49 +0800
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     linfeilong <linfeilong@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] tracing: use free_trace_buffer in allocate_trace_buffers
Message-ID: <65f0702d-07f6-08de-2a07-4c50af56a67b@huawei.com>
Date:   Wed, 20 Jul 2022 10:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In allocate_trace_buffers(), if allocating tr->max_buffer
fails, we can directly call free_trace_buffer to free
tr->array_buffer.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 kernel/trace/trace.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8dd54627075..883c8e9987f6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9101,6 +9101,16 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 	return 0;
 }

+static void free_trace_buffer(struct array_buffer *buf)
+{
+	if (buf->buffer) {
+		ring_buffer_free(buf->buffer);
+		buf->buffer = NULL;
+		free_percpu(buf->data);
+		buf->data = NULL;
+	}
+}
+
 static int allocate_trace_buffers(struct trace_array *tr, int size)
 {
 	int ret;
@@ -9113,10 +9123,7 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	ret = allocate_trace_buffer(tr, &tr->max_buffer,
 				    allocate_snapshot ? size : 1);
 	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
-		ring_buffer_free(tr->array_buffer.buffer);
-		tr->array_buffer.buffer = NULL;
-		free_percpu(tr->array_buffer.data);
-		tr->array_buffer.data = NULL;
+		free_trace_buffer(&tr->array_buffer);
 		return -ENOMEM;
 	}
 	tr->allocated_snapshot = allocate_snapshot;
@@ -9131,16 +9138,6 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	return 0;
 }

-static void free_trace_buffer(struct array_buffer *buf)
-{
-	if (buf->buffer) {
-		ring_buffer_free(buf->buffer);
-		buf->buffer = NULL;
-		free_percpu(buf->data);
-		buf->data = NULL;
-	}
-}
-
 static void free_trace_buffers(struct trace_array *tr)
 {
 	if (!tr)
-- 
2.33.0



