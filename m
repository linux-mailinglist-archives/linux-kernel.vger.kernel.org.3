Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1799588E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbiHCN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiHCNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4D4E030
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4AA6156D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12A1C433D6;
        Wed,  3 Aug 2022 13:55:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oJEqX-007kQ4-2Q;
        Wed, 03 Aug 2022 09:55:37 -0400
Message-ID: <20220803135537.585734993@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Aug 2022 09:55:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [for-next][PATCH 1/5] tracing: Use free_trace_buffer() in allocate_trace_buffers()
References: <20220803135508.240797292@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

In allocate_trace_buffers(), if allocating tr->max_buffer
fails, we can directly call free_trace_buffer to free
tr->array_buffer.

Link: https://lkml.kernel.org/r/65f0702d-07f6-08de-2a07-4c50af56a67b@huawei.com

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 301305ec134b..27febd4ee33e 100644
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
2.35.1
