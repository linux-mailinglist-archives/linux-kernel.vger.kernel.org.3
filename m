Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7C4A2CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345116AbiA2IJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbiA2IJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:09:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D4C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:09:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e13-20020a25e70d000000b00615e9bc9a3cso16993634ybh.22
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JgzRDYZ09mD6GL49munQxJ26uuUVwTiB4udKKpCpR3o=;
        b=H83FfJagQJJtT4rrvSmB4HlSdar7/YKMnfABwZPxciBaUk+dWy5rjGGOIFckCumQEf
         bk/wlRDWDf+q202t6Mwhi2eOhobQET/f+4ejlHcJO39s/7KXxWSCT3kEkcSr6NTnY9pI
         ijhv4j3tJ/uTak55L6uE7NaiqyZyxwkNjACJF0hLk+4vg4XsvsgMbzVevw4Cg1pr8Jmz
         SyYdn6cBnOPsz8MCFsIxsfi+xfaB0ZLQpiVTKe3wrF3SaRTm7gOCt3Hxld83YLrn30Ya
         dzPx2rKBkhI+zD2ApKyoRV4PlutDA8Pi+VT/DpPXj2vS6F2cNSDivXK0FAGW2ifUWsvM
         lQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JgzRDYZ09mD6GL49munQxJ26uuUVwTiB4udKKpCpR3o=;
        b=UWeiv1Hw4py9c4cVVJVsRvOIwjKcB5ugcqbl0QeCLT3anupquVdrUYMTp9wMvBTujN
         JNT7EUe75mv0AIvVXzVAKhgecIW2BaeIvbtOt6U9ATVetsRuIwJGDdmtjhuA3/9lk8qC
         iWPaKp7LdstSjMlJB2kNZiEdxf9jRQHxhUWpvOdl90Y6SNAOrHhrf3aBwBvOL/IWifMZ
         0fguOmZvosJyiBZwRE+0ZtAf+3ztFrP4aONY7K9COkkd/d9mbHnvu4NFNx6Yuk2X4FZb
         +Xga9jMdQYOv0gkLhKNV9TyGoWFXCIOXlMJE97S5yy9RSbqrW/AuBfGEGQv9Y0RxLIWa
         6kKQ==
X-Gm-Message-State: AOAM531L6O1CNonFSemoRuDLBmZpY1HqpH63b27inoMexzLWLAAerxFn
        Zx2Malr5kziSh1kPlX15DZBp7JvbSi0F
X-Google-Smtp-Source: ABdhPJxsW6dNuokl2KWD0dMJ+XNNALQYr0Ad1R9k4dzLyQSqKv4xyIqUQ8s4dl3FRdvCaRvFWmT4gO5mRG4K
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:e8ae:7315:2a3d:98f2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1505:: with SMTP id
 q5mr18992415ybu.608.1643443775269; Sat, 29 Jan 2022 00:09:35 -0800 (PST)
Date:   Sat, 29 Jan 2022 00:09:04 -0800
In-Reply-To: <20220129080929.837293-1-irogers@google.com>
Message-Id: <20220129080929.837293-2-irogers@google.com>
Mime-Version: 1.0
References: <20220129080929.837293-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 01/26] perf test: Allow skip for all metrics test
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Intel TMA metrics compute a ratio that may divide by 0, which
causes the metric not to print. This happens for metrics with FP_ARITH
events. If we see these events in the result and would otherwise fail,
then switch to a skip.
Also, don't early exit when processing metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 7f4ba3cad632..e7c59e5a7a98 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -4,6 +4,7 @@
 
 set -e
 
+err=0
 for m in $(perf list --raw-dump metrics); do
   echo "Testing $m"
   result=$(perf stat -M "$m" true 2>&1)
@@ -14,9 +15,14 @@ for m in $(perf list --raw-dump metrics); do
     if [[ ! "$result" =~ "$m" ]]; then
       echo "Metric '$m' not printed in:"
       echo "$result"
-      exit 1
+      if [[ "$result" =~ "FP_ARITH" && "$err" != "1" ]]; then
+        echo "Skip, not fail, for FP issues"
+        err=2
+      else
+        err=1
+      fi
     fi
   fi
 done
 
-exit 0
+exit "$err"
-- 
2.35.0.rc2.247.g8bbb082509-goog

