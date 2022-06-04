Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16753D854
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiFDTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiFDTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:50 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965755000D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 15so3180689qki.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fodx0Hm16VmVFm0PyMZVCAbEC8HUDt/O+iPo+rO/H6Q=;
        b=AwntglKrCvTp5pRtKOik5bb3woM0Nk0MJ0Kjn5Vp7MCHg/IlIypJb0KjiMOmwSIHqG
         qhxqF5CKLCvgHcNbUu/S8lpjo2Qs66Y3WAKi1JmkzdtdMjcao08GtJlExfYcDU6M1pm3
         /Ft3mJREzkRm7RK6SgHx5P8SVOEA6rUieXDjBmnSK737USig/wBMc9pRUjcJtr0Y3eFs
         RD4IVuvPhoZyUkK1Lg+bxy+VNEFXYNNyh+BA5BpUPkOslmFxLEtc28HHoLpFlv2BK5B/
         q6Ah6U/A/61zmvte8acSgboXWphCi8t9Q2PHM2gp15Nu89xXCTWH2/76nU2PP5MmYbBh
         bTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fodx0Hm16VmVFm0PyMZVCAbEC8HUDt/O+iPo+rO/H6Q=;
        b=G0KEJka5K6pqRLbo0zaGn8qIyP8DvKsrTb8mHa50OhmaJ/5DU1WLz7LxYM8bpV/6RQ
         TvpLoNYeo2Jc5pOiM2H6laU+l2fVJIXPkDCjxTy6z6PFE157E467zZ6asG+yCMNq0bJz
         sXw1UYg2kkLNezez2JOTDG5vHvD3pM5/qzdDu+AEHng7y2QZ2h0y8qZaqKoAiINbeA5F
         /ASZHEiFyiIkjE0x4THAva9xe1lXgPzRo1c/AqYkRunPu6KwdEG4ItGf6yQMoJUJOq/l
         gQtv6wauZkg+gqQ/HH7uEBnGrs3hOW5hFx1bsotPY5+Oo5AcpY6lK5uZh3eDdF4ZqFjs
         SjLA==
X-Gm-Message-State: AOAM530cUDRMK31Ugd6sk0P7rYJyIJGKA6o8ighqANGQhaJee2DgEj8p
        Kf9NmIr2IDEBmOkD9VkRRkxLZoDC3X4y
X-Google-Smtp-Source: ABdhPJwcXnrXZ4c9txaRW21Tgmh57lB+ZAiPrKlf5hfjnlkde0VEiG4ln96Zywr61OEI9ZXhs05i5A==
X-Received: by 2002:a05:620a:28c6:b0:6a5:7f03:4377 with SMTP id l6-20020a05620a28c600b006a57f034377mr11298646qkp.118.1654371095865;
        Sat, 04 Jun 2022 12:31:35 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:34 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 30/33] tracing: trace_events_synth: Convert to printbuf
Date:   Sat,  4 Jun 2022 15:30:39 -0400
Message-Id: <20220604193042.1674951-31-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
2.36.0

