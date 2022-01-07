Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD90D4871E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbiAGEuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346107AbiAGEuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:50:09 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF251C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:50:08 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n16so4048425plc.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 20:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/9VHStJAOS0mkHmbdKCdZxSf+vxenwHMG2wsz94L4M=;
        b=EoAdNPxtd3we3NI1yswOuvVhFDyhLYQojzTSCoIkjuOEnmLSLuBXxNwPdspcxcGYjV
         ZkZ27oSdGSyWNo31oA88VTH8R0hX+S2fGaXdZgxDfz/RrgF8QMgEjg30M1oRosx5YVU2
         lLG9ton/2d+ZBfjMZlymGTvceW1z2dZhccOWPihGqGH0iCJy0i/oRJDJv0R1nITeclrI
         /5loyiOXHAGi4/w2RO+YIG4oFyFwah/OZxH/H4YshxvJ0v0qfc8uyHj9BeCgAa5ewPYF
         74/FBA7rrochhFp2ONp9VH8mQEXY7sRQInM5DykDKQQ9//Aj9qQxz9uu4cai7MNj4hLU
         0Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/9VHStJAOS0mkHmbdKCdZxSf+vxenwHMG2wsz94L4M=;
        b=TO3He3fgcK5RtaclCzNMBP9kGF3eXPjFYjyts+lcQNbLFIxIpMYOY9BzhOpdOJYf8j
         Bkna0Sk+05k7K+XfWXn9jdrzvgtrifrvJ6P2sj1za2DaMZRnUfN6TWEgUoHWb7AiPpXt
         lA17sQL1mXwkumaXswYXXGOIB4ScDJQsYWUAAzjcL92d+mjno+qFpmzDK+qu74yuruBm
         gzQbmYmVSIKsnV2vOHvFQerwozJ+B1hOepj4fjmO/ExR6vQtWPnB3HvIs6aue5vaJBv1
         NS/PTHlZoM3kdk7Y/QyD3/t4vuTj6VA157ozVRYZfvV1QxPszTTsps7AJqMv2vtADVKP
         PvoA==
X-Gm-Message-State: AOAM531jl4uv8bNIyOXBBdwYYrPWIadb1BpOGgb/i7cqu9bRSN+uRad6
        j/qMYNPwGsSy6IWFTd4EFLltJPLS9g==
X-Google-Smtp-Source: ABdhPJyNMS8EBVFupw+B8UOrNWA6AGLP3wCfdHkJDXSMl6voXbiOsIDAhg8tXVWVA5RZ92M5/JQ17A==
X-Received: by 2002:a17:90b:3b8e:: with SMTP id pc14mr13857864pjb.217.1641531008270;
        Thu, 06 Jan 2022 20:50:08 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id lp6sm8456115pjb.55.2022.01.06.20.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 20:50:08 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 2/3] tracing/filter: harden the prototype of predicate_parse()
Date:   Fri,  7 Jan 2022 12:49:50 +0800
Message-Id: <20220107044951.22080-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107044951.22080-1-kernelfans@gmail.com>
References: <20220107044951.22080-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the next patch badly relies on the struct 'trace_event_call' to
pass in 'event_call_class info', making the involved functions' prototype
stricter.

There is no functional change in this patch.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
To: linux-kernel@vger.kernel.org
---
 kernel/trace/trace_events_filter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 264456e1698f..2a05315127f9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -136,7 +136,8 @@ static void parse_error(struct filter_parse_error *pe, int err, int pos)
 	pe->lasterr_pos = pos;
 }
 
-typedef int (*parse_pred_fn)(const char *str, void *data, int pos,
+typedef int (*parse_pred_fn)(const char *str, struct trace_event_call *data,
+			     int pos,
 			     struct filter_parse_error *pe,
 			     struct filter_pred **pred);
 
@@ -408,7 +409,7 @@ enum {
  */
 static struct prog_entry *
 predicate_parse(const char *str, int nr_parens, int nr_preds,
-		parse_pred_fn parse_pred, void *data,
+		parse_pred_fn parse_pred, struct trace_event_call *data,
 		struct filter_parse_error *pe)
 {
 	struct prog_entry *prog_stack;
@@ -1149,7 +1150,7 @@ static filter_pred_fn_t select_comparison_fn(enum filter_op_ids op,
 }
 
 /* Called when a predicate is encountered by predicate_parse() */
-static int parse_pred(const char *str, void *data,
+static int parse_pred(const char *str, struct trace_event_call *data,
 		      int pos, struct filter_parse_error *pe,
 		      struct filter_pred **pred_ptr)
 {
-- 
2.31.1

