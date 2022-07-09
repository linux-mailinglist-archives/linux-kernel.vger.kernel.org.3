Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E356C4E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGIAKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGIAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:10:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9157A52C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:10:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s21so359660pjq.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2LVGWnAwFgRc5jhP8FcZl76hymzaguoUc9mEpMyzqk=;
        b=kkOW1+SjtZPxCBn2fz4/jmiOkOnCyX9VUWF7EydqhDfwApPAEJ1e0HoFrJSSEi+srl
         rEnEpC6C2YRQHRllsFcMf+aifrQTAuBM0clcSljbNteeWl3yotxWdY2DNqP9zePwIk9j
         +djYKBSpvjUYQlYH6CUWGEiQ0rGy5OdgHlJps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2LVGWnAwFgRc5jhP8FcZl76hymzaguoUc9mEpMyzqk=;
        b=S1da88PcGzt+3e+fr2tj/x7yD/6mse5y+fjawZXbDyZhRqgD0v54UZ0dYkbMe3olg/
         jocFQ/R+iCraDsO304T7eDCshiqXH752yZJ3BlUBATJrmary8V8NnZDUzBuI6L5zjQQy
         iZEOWn4JqJiEc3S4ePgmYi47RAXtgUGBq+naHAA/qMDCUW1Tm/KgC39jnQ/v9ryxQ3m3
         XGsU3jL8bxbFMUjMwUtjJ/Y8dQuKqDXgkTX6JvvnIVez2t9z4IDD03O7IpKpV2S//0e0
         fr06QZEtyma0Gy9uwX5BsP/jg9zqOZnI8q2MOZ3WS2FQLE5H/Ok7jAbFQA62J1xYGSSw
         dP0g==
X-Gm-Message-State: AJIora/uaeLr209U8TPBcKum+FKmHWmSdUNo00RaHQL7ovbHYkhXjN57
        ggEQYxVEcU5R5B2F4fO8koA5Kw==
X-Google-Smtp-Source: AGRyM1uULmuZRaaRkYAYsmExtrJbPm//wpABlQ5XATc+h5LLDlbZ5cyuD1LMFeHvOA+LFBe5geqHyQ==
X-Received: by 2002:a17:903:2112:b0:16b:de4d:555a with SMTP id o18-20020a170903211200b0016bde4d555amr6242641ple.61.1657325403592;
        Fri, 08 Jul 2022 17:10:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f16f:292f:711d:4603])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b0016bd6635b6csm82695pln.278.2022.07.08.17.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:10:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix sleeping while atomic in kdb ftdump
Date:   Fri,  8 Jul 2022 17:09:52 -0700
Message-Id: <20220708170919.1.I75844e5038d9425add2ad853a608cb44bb39df40@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you drop into kdb and type "ftdump" you'll get a sleeping while
atomic warning from memory allocation in trace_find_next_entry().

This appears to have been caused by commit ff895103a84a ("tracing:
Save off entry when peeking at next entry"), which added the
allocation in that path. The problematic commit was already fixed by
commit 8e99cf91b99b ("tracing: Do not allocate buffer in
trace_find_next_entry() in atomic") but that fix missed the kdb case.

The fix here is easy: just move the assignment of the static buffer to
the place where it should have been to begin with:
trace_init_global_iter(). That function is called in two places, once
is right before the assignment of the static buffer added by the
previous fix and once is in kdb.

Note that it appears that there's a second static buffer that we need
to assign that was added in commit efbbdaa22bb7 ("tracing: Show real
address for trace event arguments"), so we'll move that too.

Fixes: ff895103a84a ("tracing: Save off entry when peeking at next entry")
Fixes: efbbdaa22bb7 ("tracing: Show real address for trace event arguments")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/trace/trace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c95992e2c71..64700ad2866b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9866,6 +9866,12 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	/* Output in nanoseconds only if we are using a clock in nanoseconds. */
 	if (trace_clocks[iter->tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
+
+	/* Can not use kmalloc for iter.temp and iter.fmt */
+	iter->temp = static_temp_buf;
+	iter->temp_size = STATIC_TEMP_BUF_SIZE;
+	iter->fmt = static_fmt_buf;
+	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
 void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
@@ -9898,11 +9904,6 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
-	/* Can not use kmalloc for iter.temp and iter.fmt */
-	iter.temp = static_temp_buf;
-	iter.temp_size = STATIC_TEMP_BUF_SIZE;
-	iter.fmt = static_fmt_buf;
-	iter.fmt_size = STATIC_FMT_BUF_SIZE;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
-- 
2.37.0.rc0.161.g10f37bed90-goog

