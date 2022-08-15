Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C6593403
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiHOR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiHOR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:30 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCFE0C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xApyLVCro7eU20RcMo1NJ1THL9oCFUnIETFY11BB7ns=;
        b=NtClv4zVDcljnFhmHnTJjbHu6El1Cc9k0c0i0MLGp901m/6MyJBWgQSJC7MAJyKMSFv69u
        N/dfTVPwE2LNwOALAr7yAtw2JYL3122agOa2HzWjfekM2c15h7cONySx/tp9kh3evkVB+r
        2jOaPq8XrctzVq8qNXU0NHWlwyNAsNk=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 07/11] tracing: trace_events_synth: Convert to printbuf
Date:   Mon, 15 Aug 2022 13:26:09 -0400
Message-Id: <20220815172613.621627-8-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This converts from seq_buf to printbuf.

This code was using seq_buf for building up dynamically allocated
strings; the conversion uses printbuf's heap allocation functionality to
simplify things (no longer need to calculate size of the output string).

Also, alphabetize the #includes.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/trace/trace_events_synth.c | 51 ++++++++++---------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 5e8c07aef0..720c75429c 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -5,13 +5,14 @@
  * Copyright (C) 2015, 2020 Tom Zanussi <tom.zanussi@linux.intel.com>
  */
 
-#include <linux/module.h>
 #include <linux/kallsyms.h>
-#include <linux/security.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/printbuf.h>
+#include <linux/rculist.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
-#include <linux/rculist.h>
 #include <linux/tracefs.h>
 
 /* for gfp flag names */
@@ -611,7 +612,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
 	struct synth_field *field;
 	int len, ret = -ENOMEM;
-	struct seq_buf s;
+	struct printbuf buf;
 	ssize_t size;
 
 	if (!strcmp(field_type, "unsigned")) {
@@ -654,28 +655,16 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 		goto free;
 	}
 
-	len = strlen(field_type) + 1;
-
-	if (array)
-		len += strlen(array);
-
-	if (prefix)
-		len += strlen(prefix);
-
-	field->type = kzalloc(len, GFP_KERNEL);
-	if (!field->type)
-		goto free;
-
-	seq_buf_init(&s, field->type, len);
+	buf = PRINTBUF;
 	if (prefix)
-		seq_buf_puts(&s, prefix);
-	seq_buf_puts(&s, field_type);
+		prt_str(&buf, prefix);
+	prt_str(&buf, field_type);
 	if (array)
-		seq_buf_puts(&s, array);
-	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+		prt_str(&buf, array);
+	if (buf.allocation_failure)
 		goto free;
 
-	s.buffer[s.len] = '\0';
+	field->type = buf.buf;
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
@@ -687,23 +676,15 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 		goto free;
 	} else if (size == 0) {
 		if (synth_field_is_string(field->type)) {
-			char *type;
-
-			len = sizeof("__data_loc ") + strlen(field->type) + 1;
-			type = kzalloc(len, GFP_KERNEL);
-			if (!type)
-				goto free;
-
-			seq_buf_init(&s, type, len);
-			seq_buf_puts(&s, "__data_loc ");
-			seq_buf_puts(&s, field->type);
+			buf = PRINTBUF;
+			prt_str(&buf, "__data_loc ");
+			prt_str(&buf, field->type);
 
-			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+			if (buf.allocation_failure)
 				goto free;
-			s.buffer[s.len] = '\0';
 
 			kfree(field->type);
-			field->type = type;
+			field->type = buf.buf;
 
 			field->is_dynamic = true;
 			size = sizeof(u64);
-- 
2.36.1

