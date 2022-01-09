Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC5488A84
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiAIQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 11:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiAIQWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 11:22:39 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD46C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 08:22:38 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t32so9177002pgm.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 08:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5smF/L+0vVOLfQMCaHB8W8ju291goGonFD5lJTIRYs=;
        b=Aby3IWgBrVrcorEm15/O2tyHjF8xiuIW1tZpkAUZvsZyIg2o0hIaqlVActxNqGIA+h
         OAK5cM8qgo8CQedzSjppBmhpc9pWDDcJ5H7JMvflZBjjyPjCN1S8afi0m840B3iWPqjY
         JMspDDWwCfjd/7x/XXPnRDEIlhZZyHCKmIoOuAvtx4ezgn/Tw+YegDwxhhtM1+gIZGLQ
         hNoUMA+ZUjJHvM8fUkb0yrc4EnBLaawyxsVY+JvrMQVdlcIp2mhLc0Zh5am5mZ/wi3pM
         8RoBzUEIl83h3yZN3gHtY2/RhVv48qnRWwsKNLMYA4h1EK9I+5kZi9lV/8/vMXd3biyX
         0i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5smF/L+0vVOLfQMCaHB8W8ju291goGonFD5lJTIRYs=;
        b=g8u1qA43dahdn7Cy4r9MK2X+SIqhXbaTF09MQKSLNUNvNwgmdU/o3zE8FqDwH0uSby
         4yz+S7dDyzN8x4br/l/d1pBP4chXzjt+cuc0m3UJn3EKIRprt8Dw3VhwW+3I7Rtv3WyX
         fldFXoDR1yrkN5ryaaCoDZD+ocHGsRR/BKdOGRnTtV17Gvtp0JOFJ9HluASKTscnZHe5
         Dh0OoNmLsI1R2FcPXU/cDdFsYV5tTy1gbhw5Alyi0WNgS22zRhfzyl4lFNrRpr6TaXU2
         GiTTD945WfzvcaxW2BAhGC+uCU1nrkgPxGrNTMOh7LHWviLr162waxSeBoLe3jKjl63F
         Kw7Q==
X-Gm-Message-State: AOAM532Bsvd328tB6Sv5kzKDyQhCs9//ixd/IX6wVJPCFsviMFbKUugv
        4dMuA02lzbdaADo4sGV/vAI=
X-Google-Smtp-Source: ABdhPJxFo+q/93JwCrG9pC5sHXxoADXGiYWysLC43Lc7I5Hm6ZHQZVurb47HfaWFu8SBCz7a9jJc/w==
X-Received: by 2002:a63:381d:: with SMTP id f29mr2347843pga.291.1641745358453;
        Sun, 09 Jan 2022 08:22:38 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id k8sm5881302pjj.3.2022.01.09.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 08:22:38 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2] tracing: Remove duplicate warnings
Date:   Mon, 10 Jan 2022 00:22:32 +0800
Message-Id: <20220109162232.361747-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220109101611.73da76d9@rorschach.local.home>
References: <20220109101611.73da76d9@rorschach.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the same warning message is already printed in the
trace_create_file() function, there is no need to print it again.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
Changes since v1:
- remove unnecessary braces

 kernel/trace/trace_events.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 92be9cb1d7d4..3147614c1812 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3461,10 +3461,8 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	entry = trace_create_file("enable", TRACE_MODE_WRITE, d_events,
 				  tr, &ftrace_tr_enable_fops);
-	if (!entry) {
-		pr_warn("Could not create tracefs 'enable' entry\n");
+	if (!entry)
 		return -ENOMEM;
-	}
 
 	/* There are not as crucial, just warn if they are not created */
 
@@ -3480,17 +3478,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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

