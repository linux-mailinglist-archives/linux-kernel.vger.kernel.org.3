Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69926550E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiFTApK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiFTAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:50 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FBAC3C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:44 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 88so10493708qva.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhCWzyYhHQUfgLaJoA4/luR9p1DQeXQQcw2AdhNu860=;
        b=LNOtI32q4WsSf62+lp4sxFsq0bvgPEpDH7tubWopigkHyJasJcMXtxp6uhe/k056YK
         mHTCf4zl7jPsNE7ZDlNYCWbiEDRe7d2d6hBWTTvbyfN8QNhTuGyfoiOgpVBh5jbwxYNb
         wN4IEHaZ5JKnXGFqcxJcgQ356aOF+2/EiAu4mYPbQ0G9LRzp2dF14oqFlIfb+GgMCboF
         /svbE10GemkPJ/8PCTtYi25sf4XvEi7xd2lfrcq3Sikn1ZC55Ns7T+T4SJUvkWF/Xl6a
         pBoPIuzg4YVajlJR0+oHaAKlw9vN0nVxPk56KJucHUH+c7dt8C7G5JCpd/2Psqi2xQZ3
         7pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhCWzyYhHQUfgLaJoA4/luR9p1DQeXQQcw2AdhNu860=;
        b=z96r/GoEqttVBg+D2vPEmJNY2HAKK7gvszh9TtNcksD3b3rGedcnUprBDdt7rePmHt
         pEB52qvzKvCt2OeanmObN9B7/AeIzZ1IwHL8oCudNCFeH5iFmM/KrqVeCPUerUMI8R0S
         kHpK+kgGHBvLg0tDuz/NmedaO6mX3Pz0FjRg13fIfxTH4yeIFaqwskNStqrHTkFTKr9J
         qxSwXWy+UYZBZ/WHEwgh8SwKuQ7MXmS5f0jYoXPIlFqgcknT+1FFP0gyb+3Zy/BoyNNN
         m9Fqkro0zRHpG63Lil8B/qxZeGfRKWZHbcfo6yF/Je9nm/U2rgM+CxFHP/kLTP+lT00c
         e6Nw==
X-Gm-Message-State: AJIora+oujuytRowK/3NeG+bkRnVS2DJa5HAFjde09O9L3T75BC4QZtH
        4faD/d5fEfvtHt7vG/Ir2CTzLpGXEaEKW0I=
X-Google-Smtp-Source: AGRyM1uK4SE0R2rC8ICXr/1qyDRW063L27/c5mYvQJDhXdbWpPTz/vsIaae7XwlBInXy3JqUohNKFQ==
X-Received: by 2002:a05:6214:23c8:b0:45f:b582:346e with SMTP id hr8-20020a05621423c800b0045fb582346emr17516453qvb.109.1655685823664;
        Sun, 19 Jun 2022 17:43:43 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b198-20020a3767cf000000b0069fc13ce1f3sm10580202qkc.36.2022.06.19.17.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:42 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v4 30/34] tracing: trace_events_synth: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:29 -0400
Message-Id: <20220620004233.3805-31-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts from seq_buf to printbuf

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/trace/trace_events_synth.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 5e8c07aef0..627e0e45f0 100644
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
+	struct printbuf s;
 	ssize_t size;
 
 	if (!strcmp(field_type, "unsigned")) {
@@ -666,17 +667,15 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 	if (!field->type)
 		goto free;
 
-	seq_buf_init(&s, field->type, len);
+	s = PRINTBUF_EXTERN(field->type, len);
 	if (prefix)
-		seq_buf_puts(&s, prefix);
-	seq_buf_puts(&s, field_type);
+		prt_str(&s, prefix);
+	prt_str(&s, field_type);
 	if (array)
-		seq_buf_puts(&s, array);
-	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+		prt_str(&s, array);
+	if (WARN_ON_ONCE(!printbuf_remaining(&s)))
 		goto free;
 
-	s.buffer[s.len] = '\0';
-
 	size = synth_field_size(field->type);
 	if (size < 0) {
 		if (array)
@@ -694,13 +693,12 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 			if (!type)
 				goto free;
 
-			seq_buf_init(&s, type, len);
-			seq_buf_puts(&s, "__data_loc ");
-			seq_buf_puts(&s, field->type);
+			s = PRINTBUF_EXTERN(type, len);
+			prt_str(&s, "__data_loc ");
+			prt_str(&s, field->type);
 
-			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+			if (WARN_ON_ONCE(!printbuf_remaining(&s)))
 				goto free;
-			s.buffer[s.len] = '\0';
 
 			kfree(field->type);
 			field->type = type;
-- 
2.36.1

