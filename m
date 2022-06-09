Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA72F544A41
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiFILbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbiFILbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:31:21 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C83A5BD9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:31:13 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id t15-20020a1709066bcf00b0070dedeacb2cso7924512ejs.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vEnwLHfz8bnnz/z0hnI1W7+EOk8HMNN4MOfns1570U0=;
        b=FJgcqRt48J5Dot/Fz9Uvm/E4iUfO5qVqzissd4gJ7h4TVLWQ6eMYxF/+mDWmUYehwt
         kaZAdhcbjK6DjQoIPEj2ovbsH7tZR4sidZog2AVEC5Pcbv0/Fd8zdz/xgkaMk7566qWW
         CtXnzZyoZZQCmfhPo2iHeESBHyL1ng2CcLJaeRINF4vimizadO6EST9hw6xvtREsPhiZ
         Au5ALp1erVQNvVDl2CLPDLUo19W9/msQUdrJR4bOwmgKmz89mxUyWVlCwhjQLU5BI3zY
         jeyj/ipnnM6TeFDdk1z2+RfKLNYkSEmH9XO71edFxAxxLc8Q/xUYJwLA992cBFhp+dn3
         3OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vEnwLHfz8bnnz/z0hnI1W7+EOk8HMNN4MOfns1570U0=;
        b=CE8FTvpbS37BTX60iiJCqMHaay0GBd2B76qrDdubI96ub36/GnvNU7TGxEt5y768He
         agr3p3MW5tGnYKR6iEl7OcWj6OPZ23YYoaonfIrN4ZvJjTV24GFU9wUvSCFIGFsARaz3
         RnggsUnYnYwJx/Ww2p459I1AGCcIwMMedBtu6yGciVNXQTcXC/i/JtjP1SPk/CmjDXW9
         2MTOcvRokzg2IQo2E1GTPxS3hV3IML9jC2tgfkNqTDoW5SYwNW3xSYXjPLXmxAx8Fxih
         DO9SLQNXVGBSmZI7/zFCq900w9S9QCY/UpzQsTbCVKHa1a06/Bl4slr1nB8QY9n8/0a1
         ASqw==
X-Gm-Message-State: AOAM531h9jHkXceb8WUQ/m3XvptBz6fqfVF1qrOoGvuXYTkbkTon2crt
        iAge0cXdbHEPvArkXZjRZjmr1dwCUQ==
X-Google-Smtp-Source: ABdhPJy6fxgLEEWOBBqF03SqL1tlVIBlJ9qpMkrzeULfbi/9xejgkRe26FJME5xe2MXNniUvCKkw5WpXAA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
 (user=elver job=sendgmr) by 2002:a17:906:8513:b0:711:c67f:62b6 with SMTP id
 i19-20020a170906851300b00711c67f62b6mr21303657ejx.657.1654774271337; Thu, 09
 Jun 2022 04:31:11 -0700 (PDT)
Date:   Thu,  9 Jun 2022 13:30:43 +0200
In-Reply-To: <20220609113046.780504-1-elver@google.com>
Message-Id: <20220609113046.780504-6-elver@google.com>
Mime-Version: 1.0
References: <20220609113046.780504-1-elver@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 5/8] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

Flexible breakpoints have never been implemented, with
bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
flexible count in fetch_bp_busy_slots().

This again causes suboptimal code generation, when we always know that
`!!slots.flexible` will be 0.

Just get rid of the flexible "placeholder" and remove all real code
related to it. Make a note in the comment related to the constraints
algorithm but don't remove them from the algorithm, so that if in future
flexible breakpoints need supporting, it should be trivial to revive
them (along with reverting this change).

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/hw_breakpoint.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 5f40c8dfa042..afe0a6007e96 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -46,8 +46,6 @@ struct bp_cpuinfo {
 #else
 	unsigned int	*tsk_pinned;
 #endif
-	/* Number of non-pinned cpu/task breakpoints in a cpu */
-	unsigned int	flexible; /* XXX: placeholder, see fetch_this_slot() */
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
@@ -71,7 +69,6 @@ static bool constraints_initialized __ro_after_init;
 /* Gather the number of total pinned and un-pinned bp in a cpuset */
 struct bp_busy_slots {
 	unsigned int pinned;
-	unsigned int flexible;
 };
 
 /* Serialize accesses to the above constraints */
@@ -213,10 +210,6 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
 
 		if (nr > slots->pinned)
 			slots->pinned = nr;
-
-		nr = info->flexible;
-		if (nr > slots->flexible)
-			slots->flexible = nr;
 	}
 }
 
@@ -299,7 +292,8 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
 }
 
 /*
- * Constraints to check before allowing this new breakpoint counter:
+ * Constraints to check before allowing this new breakpoint counter. Note that
+ * flexible breakpoints are currently unsupported -- see fetch_this_slot().
  *
  *  == Non-pinned counter == (Considered as pinned for now)
  *
@@ -366,7 +360,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	fetch_this_slot(&slots, weight);
 
 	/* Flexible counters need to keep at least one slot */
-	if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
+	if (slots.pinned > hw_breakpoint_slots_cached(type))
 		return -ENOSPC;
 
 	ret = arch_reserve_bp_slot(bp);
-- 
2.36.1.255.ge46751e96f-goog

