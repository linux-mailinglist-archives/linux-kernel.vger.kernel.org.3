Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028758C1CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbiHHCoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbiHHClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD8225E3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O10e4f89X47Ind7IOvarTPJ2k5gxmqsKR8G7YqYX1Cg=; b=N7edtCxvgsKuafmwDdeWT0yPZ2
        FB3MJMFhR12jcCZEHcTZcus9815lmWGogVyh8sutkUHiE0kE4vbmkm5R7nG8Xuu+aXml0uVTPcFtx
        6mZXoP0+8H17Szl7f8trEwkAfnR4viPXlkZG9LqRSJIZPahVAkzKHT4AKMKBh64nc/3+QRWXIc9vU
        /yC2B3mbwSyyiYsZDKNQu/BiAggV1x0aHDnMEsNLObEf+ayUJGRNKMcYcw1yI4m5aTWb5td/NZYID
        uM3vCfk3ZZxbqa8+bULyt6g8e50Sc1lb1o7U1TdogvlEXSL6CizBYaKVCgIiq2DFoGGiieusYqp0X
        LmjsFJ9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVSl-Sz; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v5 28/32] tracing: trace_events_synth: Convert to printbuf
Date:   Mon,  8 Aug 2022 03:41:24 +0100
Message-Id: <20220808024128.3219082-29-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
index 5e8c07aef071..720c75429c8f 100644
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
2.35.1

