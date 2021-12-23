Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6E47E7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349874AbhLWSkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349866AbhLWSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:39:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:39:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso11370309ybs.14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4EEDTZmDfhZAbqDhiNkD0X+w29KWo6DZt4UFTZYEt94=;
        b=oxili4+eOhdfDfSC+JP6bfRidYbINU+gPPIep1nyhDU/M07MpIXBUEI7cuxyVGWjGg
         WMR8FqgyYYHCnCpK5PHC/YTNtoUqgDqP+cGY02KwD7WeQnSLiSt1veAax7lpPE4xuBSE
         C68MqSyRxLTbeeYx9OsiZaH3cjyfNrtjGSLzPF2NB07SGXHeBpZp+KDSeX3dsL7OD3b2
         XKhXAZh9Nb+1afy4ehkL+4UvlUt11bJ8Ftg+MW09sRI1WUStAydlnDoX1m4/3MTgbeAk
         3FBj5vAfQY85JPKXkPDiXtZ1J74WyBcmtwm1m73yjIGd3MOkCZjSMhvREQuQ2FeWmWwP
         pgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4EEDTZmDfhZAbqDhiNkD0X+w29KWo6DZt4UFTZYEt94=;
        b=KS3rvb8k4qvnD4dUug88YxSbhSQ4h99lGCmdrfdC9k1zDdlx7X6PZPK4wbnYlh/4Tr
         Cja1zw1v9U94lgfSwPz9nSE12dHw2HkmNqNrQ+OwoizXEGWLqXe1E+KztYZvvJz3xF53
         YP2xTcdON2F8tmfCFSaD5jo8yyRjxjRmEyO13z/scTqvFbr4XZeiqyzWGzZP+0lprEn4
         K529XTFO+4ECzu6DoNsFWjxOZcGvW84IYRPWqyqnpZ1A3Gzzw8ubj2PHpxGhSAfZBciF
         vJWrfgggggcphGWz/S38psz9tifq2unJbVz41ayZH+j4HfQfRJlhpt59MmsI4mA87OLl
         ez2Q==
X-Gm-Message-State: AOAM531JWPGh484/VZ6mw1QqMH5cK70MCesYV2/gKqgf231ucZO70HCM
        kJIEatbBZihOKgp/5uSYWQftGFRn4ZQl
X-Google-Smtp-Source: ABdhPJzD/T2ne/P0+Tfvokle5nmv3pghifBobxdpm9J7oq4IdT+Zts20UZJKTrPxj3/sxdHdb4skmHVL7Z+x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1c9d:afe4:ff2f:9382])
 (user=irogers job=sendgmr) by 2002:a05:6902:1144:: with SMTP id
 p4mr5262901ybu.189.1640284796416; Thu, 23 Dec 2021 10:39:56 -0800 (PST)
Date:   Thu, 23 Dec 2021 10:39:48 -0800
In-Reply-To: <20211223183948.3423989-1-irogers@google.com>
Message-Id: <20211223183948.3423989-2-irogers@google.com>
Mime-Version: 1.0
References: <20211223183948.3423989-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 2/2] perf evsel: Improve error message for uncore events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a group has multiple events and the leader fails it can yield
errors like:

$ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
/bin/dmesg | grep -i perf may provide additional information.

However, when not the group leader <not supported> is given:

$ perf stat -e '{instructions,uncore_imc/cas_count_read/}' /bin/true
...
         1,619,057      instructions
   <not supported> MiB  uncore_imc/cas_count_read/

This is necessary because get_group_fd will fail if the leader fails and
is the direct result of the check on line 750 of builtin-stat.c in
stat_handle_error that returns COUNTER_SKIP for the latter case.

This patch improves the error message to:

$ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
Error:
Invalid event (uncore_imc/cas_count_read/) in per-thread mode, enable system wide with '-a'.

v2. Changed the test to use !target__has_cpu as suggested by Namhyung
    Kim.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 656c30b988ce..a0acf53a2510 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2931,6 +2931,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
+		if (!target__has_cpu(target))
+			return scnprintf(msg, size,
+	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
+					evsel__name(evsel));
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.34.1.307.g9b7440fafd-goog

