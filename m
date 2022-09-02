Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C625AABFC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiIBKBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiIBKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:01:43 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68BC7B90
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:01:31 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id w19-20020a05640234d300b004482dd03feeso1113140edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 03:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=hEVwDu/wAWLZN7jGwPsqk/ffr8euR5CaDbdaYqqibfI=;
        b=JIu9bTSkfxJAOBju6JG5WF//6kXI89yIOgwe8A1yOGJPkUiUePf+tIeFCTjldoD1uQ
         77NCP2scOW/X9cmfCHOPCA+7bUucJM8c81yrD0Eo+H88wVXnwNKj5WZkMXisuvKnvyWQ
         gzQxBdIrNfjxOOI/FZVd6DVKDilzI8EMgx72Kh7ztiVfyQZcSxhbE5uJ1ffKDkZRw0vP
         Xw2FG3gbMjtnyM77H4tkep25EwviPWPaV10YVM9rqUJqYNQhpLoOJpmTHXQuVbR2H05r
         6IXNnyXSZJPn7beCjMhSBN4nhJozIkyuQKXTxas7Br1F1rEANP0SngBHMo2BhScFK25h
         wJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=hEVwDu/wAWLZN7jGwPsqk/ffr8euR5CaDbdaYqqibfI=;
        b=QM3F1Qkpz1n+5sE5JY+pCqSXsIY6etZWOUonBNx0+Q0UBa9ke2sJgDAEnhVkGjn/iS
         bb2KwtGslS5GqSXfcJuOru+GBxfPH9j/8D5bHPdtYoiOZyVytziJas/YT3foKS9Ei/Nq
         XljXdVdpJaNIkulVSDQlwrLQrjz4fX67IbQDwRbS0AY7LicXfI5GJjPwcMLAOhgKscaN
         wBsRnSeKynC4a1sfOyUENSuRI3FD/lolljhi0hLQB/0l3fd9aXQkLigRr0ACuq0qtR8z
         5NvH5/kS/fYz8j8x8zMXPA8B9cL+khHPEe001S1t+LClGcIfMoSJXEc95+34Hs73HXAD
         U9Rw==
X-Gm-Message-State: ACgBeo1/zn5gWP8xFJXO6vTLfx0yvu9e8bWTQuHxeFZqXcTYMEsmy0WC
        +sVYgs1RwmWP0DkGLlYWhI/eemvVDw==
X-Google-Smtp-Source: AA6agR6sslFUFrNQQfMzncgbQ1gPeMlxNvonOFUGGsL3d7PWYJCy+X8IPGsB6luBSCI6I5BOx1eJiU61Dw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:8d53:41f1:1226:8e63])
 (user=elver job=sendgmr) by 2002:a05:6402:1909:b0:447:f0d3:a9b1 with SMTP id
 e9-20020a056402190900b00447f0d3a9b1mr27751544edz.100.1662112889512; Fri, 02
 Sep 2022 03:01:29 -0700 (PDT)
Date:   Fri,  2 Sep 2022 12:00:57 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902100057.404817-1-elver@google.com>
Subject: [PATCH] perf: Allow restricted kernel breakpoints on user addresses
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the creation of restricted breakpoint perf events that also fire
in the kernel (!exclude_kernel), if:

  1. No sample information is requested; samples may contain IPs,
     registers, or other information that may disclose kernel addresses.

  2. The breakpoint (viz. data watchpoint) is on a user address.

The rules constrain the allowable perf events such that no sensitive
kernel information can be disclosed.

Despite no explicit kernel information disclosure, the following
questions may need answers:

 1. Is obtaining information that the kernel accessed a particular
    user's known memory location revealing new information?
    Given the kernel's user space ABI, there should be no "surprise
    accesses" to user space memory in the first place.

 2. Does causing breakpoints on user memory accesses by the kernel
    potentially impact timing in a sensitive way?
    Since hardware breakpoints trigger regardless of the state of
    perf_event_attr::exclude_kernel, but are filtered in the perf
    subsystem, this possibility already exists independent of the
    proposed change.

Signed-off-by: Marco Elver <elver@google.com>
---

Changelog
~~~~~~~~~

v1:
* Rebase.

RFC: https://lkml.kernel.org/r/20220601093502.364142-1-elver@google.com
---
 include/linux/perf_event.h |  8 +-------
 kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a784e055002e..907b0e3f1318 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1367,13 +1367,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+extern int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..75f5705b6892 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3176,6 +3176,12 @@ static int perf_event_modify_attr(struct perf_event *event,
 		return -EOPNOTSUPP;
 	}
 
+	if (!event->attr.exclude_kernel) {
+		err = perf_allow_kernel(attr);
+		if (err)
+			return err;
+	}
+
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 
 	mutex_lock(&event->child_mutex);
@@ -12037,6 +12043,38 @@ perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
 	return is_capable || ptrace_may_access(task, ptrace_mode);
 }
 
+/*
+ * Check if unprivileged users are allowed to set up breakpoints on user
+ * addresses that also count when the kernel accesses them.
+ */
+static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
+{
+	if (attr->type != PERF_TYPE_BREAKPOINT)
+		return false;
+
+	/*
+	 * The sample may contain IPs, registers, or other information that may
+	 * disclose kernel addresses or timing information. Disallow any kind of
+	 * additional sample information.
+	 */
+	if (attr->sample_type)
+		return false;
+
+	/*
+	 * Only allow kernel breakpoints on user addresses.
+	 */
+	return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
+}
+
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
+	    !perf_allow_kernel_breakpoint(attr))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
-- 
2.37.2.789.g6183377224-goog

