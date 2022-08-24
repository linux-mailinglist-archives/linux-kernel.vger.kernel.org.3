Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49859FE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiHXPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239554AbiHXPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2D7167CD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:40:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-337ed9110c2so254864007b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=3BrhFwUG/qTzyva+786rSer4lbcXLx6c2fnZFduSMeE=;
        b=nUqCJ+/IRCQa4bu7dz0dSGIz/D7e0XuB2olt28nTD731WTDPqVr0S6sKDVwQSrWR8J
         fPJjjnLAlM3ZnyhrUxJW8QWkf9ybZcXdr+vofJfqdMVEuCYFbFyR49gKLPi1h3U1OLbj
         f46LVv1unEu3AVYvRY2uBWrWc2ydFujyogOSwB5lRKzlhv9mJFWPFn0i4Umx7sVXersq
         9J0SxHak8/+FaPwrkNQcXsQbO8kzdXinisrv9M14dEWWQj16d85KwvOG0lCbwKOw4aHw
         K7o19LdkgFlHKFo5qpIBCtZYRL1BgeXXY891Sma/BdhvG+nQVI2kAwVaoJVe7ON1U/HN
         D5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=3BrhFwUG/qTzyva+786rSer4lbcXLx6c2fnZFduSMeE=;
        b=eef8hZInNENQCtk3byNDcmPnARq+Rq6QbUZRzn2DOrL0psLwBKSrwm7TJF1zNdo2b4
         YL9nqLV/WnY48Iq1Opg2BsKCv7NVTwhj9Uq6TWKY68t74EcNaMDIyWieFlU9jKIu6FW7
         fEqA/B+U7KgtB3YdTD7ieheR09VT7ZdrzAWns9FlsPWN6PJUzY89jMj/I9r0eVIIW7wK
         6wFfmWSs4CvUuBDv6BV78D4YYj9pOefV3ljM+7CuI++FtuyuZmL0oJ38h/u+RM2wMDa0
         d53cWNgEJrzty236H8EhKhUEjyduwEWKVeYQoOeuYHj5SdCpf2txkCcYQw8By0vIb0H6
         OJ/w==
X-Gm-Message-State: ACgBeo20hhEmdIJgwfSc9Mk5A4GrKT3O90C2r2lNwFDLkKbEol8NLBro
        xYC/NaxRUjd0gSfiTkuw8oOPRe2Wxdvp
X-Google-Smtp-Source: AA6agR5ArNCC0pdLFJhOUHoz7DemaPrAZYB/cQ9BC5Pk+bNHcL2HXo20P9iy91mRbvsJYkFtLpZSGh7nby8s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:5242:0:b0:68f:4012:f131 with SMTP id
 g63-20020a255242000000b0068f4012f131mr28277518ybb.222.1661355608506; Wed, 24
 Aug 2022 08:40:08 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:50 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-8-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 07/18] perf record: Update use of pthread mutex
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
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

Switch to the use of mutex wrappers that provide better error checking
for synth_lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4713f0f3a6cf..a7b7a317d81b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -21,6 +21,7 @@
 #include "util/evsel.h"
 #include "util/debug.h"
 #include "util/mmap.h"
+#include "util/mutex.h"
 #include "util/target.h"
 #include "util/session.h"
 #include "util/tool.h"
@@ -608,17 +609,18 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, NULL, event, event->header.size);
 }
 
+static struct mutex synth_lock;
+
 static int process_locked_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
 				     struct machine *machine __maybe_unused)
 {
-	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
 	int ret;
 
-	pthread_mutex_lock(&synth_lock);
+	mutex_lock(&synth_lock);
 	ret = process_synthesized_event(tool, event, sample, machine);
-	pthread_mutex_unlock(&synth_lock);
+	mutex_unlock(&synth_lock);
 	return ret;
 }
 
@@ -1917,6 +1919,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	}
 
 	if (rec->opts.nr_threads_synthesize > 1) {
+		mutex_init(&synth_lock);
 		perf_set_multithreaded();
 		f = process_locked_synthesized_event;
 	}
@@ -1930,8 +1933,10 @@ static int record__synthesize(struct record *rec, bool tail)
 						    rec->opts.nr_threads_synthesize);
 	}
 
-	if (rec->opts.nr_threads_synthesize > 1)
+	if (rec->opts.nr_threads_synthesize > 1) {
 		perf_set_singlethreaded();
+		mutex_destroy(&synth_lock);
+	}
 
 out:
 	return err;
-- 
2.37.2.609.g9ff673ca1a-goog

