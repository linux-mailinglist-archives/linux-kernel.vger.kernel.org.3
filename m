Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8E4889AF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiAINty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiAINtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:49:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA75C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 05:49:52 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s1so8993466pga.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 05:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4g60vb+VGhZ0e4oyi1m5eKzSL3IDxZ35dVyKgkwO6jg=;
        b=eR1t8Y6WZ+JA0COYixGK4RVflUxaNKaKiUDoYGUHjL5S6Rj8a3lFIm8Cj2l9688mBP
         PS7JrEyK6fRQJQV5T2Lr9bCk0AB7ArqspfaYV+5SLzkiCXlapRkj5DPsMWQkEFWQDz57
         /t6KgBhH4IRrhH0mth/LHjQU7w623JWWKaGFDuQ4Nw0zMRSLxpEljAW2kKJB+YiiYaYj
         LtZWjnp3B7dP9JHg8IRwfWoiwNIy4/dqKOrIg+tfZuHnEJLIVr2DF1qn6vDIhLLr6CBr
         6NI2oUD8FyXMRN6ZSL3fvt4F1WU/mvce/U6+aeBG3Ou7RWrnlet19Bp6w8bkIaULAv3r
         Jgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4g60vb+VGhZ0e4oyi1m5eKzSL3IDxZ35dVyKgkwO6jg=;
        b=rcGdd86At7TcljobI1JaGN+NPBoZl/JPGgZZKbsXUiFrVFavr4jgqwT0qD+rq23BPN
         ar+nzynJlZD5kwftX40JAyG543jN2bY9Pd7LG7SjwXxfRrAboBbU6+Nb8sMCAkzGMhKb
         JnWypUME05FOESL8WDiR9l47ac09sETbrmjYEbggcql/kqK/GnZsz+MZZ9GiIUQFwAfb
         pbwQBje7stTnZ9tpRj2yZuNyYgXvoGo+e0xxPkP8ZZ0jFEb9pEdFX9Vx9kI8V5HawViB
         UyvyDpwmWizyXz/lT6cZczbUfnyghwhVzFM+I6J0AIigGxTR/El9x+e1BhBkxFqZfwO5
         eJmg==
X-Gm-Message-State: AOAM531yLF4C5gGjPLbSZkbSNUmRSimM38s9Ax9dktvBrLg4VM/q17Ww
        b7Mb/Lbj+j+n6KS+wcpz67luVw4wWMG0ZPDtHRg=
X-Google-Smtp-Source: ABdhPJyNxJMzV6zKSho77f1e+qmhKxLoBVl7JHgBirPGVS3xh6EouYH4unRPQPt/iPGaQaPGhfIegg==
X-Received: by 2002:a63:750b:: with SMTP id q11mr47224509pgc.349.1641736191854;
        Sun, 09 Jan 2022 05:49:51 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id f20sm3957617pfe.166.2022.01.09.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 05:49:51 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] tracing: Remove duplicate warnings
Date:   Sun,  9 Jan 2022 21:48:58 +0800
Message-Id: <20220109134858.306061-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the same warning message is already printed in the
trace_create_file() function, there is no need to print it again.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/trace/trace_events.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 92be9cb1d7d4..d7da46df16c5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3462,7 +3462,6 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
 	if (!entry) {
-		pr_warn("Could not create tracefs 'enable' entry\n");
 		return -ENOMEM;
 	}
 
@@ -3480,17 +3479,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		pr_warn("Could not create tracefs 'set_event_notrace_pid' entry\n");
 
 	/* ring buffer internal formats */
-	entry = trace_create_file("header_page", TRACE_MODE_READ, d_events,
+	trace_create_file("header_page", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_page_header,
 				  &ftrace_show_header_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'header_page' entry\n");
 
-	entry = trace_create_file("header_event", TRACE_MODE_READ, d_events,
+	trace_create_file("header_event", TRACE_MODE_READ, d_events,
 				  ring_buffer_print_entry_header,
 				  &ftrace_show_header_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'header_event' entry\n");
 
 	tr->event_dir = d_events;
 
-- 
2.34.1

