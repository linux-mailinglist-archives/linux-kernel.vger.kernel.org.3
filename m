Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB494A54D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiBAB7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiBAB7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:59:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E4C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:59:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o131-20020a25d789000000b00614957c60dfso30384269ybg.15
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 17:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AymeHIyeNEkJXID1khfAkGq+Ez00dJt89KKS/zaptAY=;
        b=DVRS25O9T7ak+jVGUIrWiNg+fYE926ffQOiOpgbtGML9OQYJnrSmRmvr3N33NUN+Cn
         AzBl2uAaArbdXooXe1UXgqzKliziBOBJfBgS8cC64p8rGbI5JpjUpVlYMC4iZ3Us4O7K
         jHhWJbyFrAsViecXR7PK0t9EfH/iRUisEY/I1ZP2YiCOqEXe03mFttBe7i/OhhCl+8dR
         SkCLQl9ZECjiGxVSxEWMEqfTdk2XUzRv2hcuP/XxM50MuVl0hBe9/nl0F8DETKRtyZ82
         PnBl5y+IWpxUS103dsmVKr5BpCcxLSPhdTT5fCoeCWEznTkON5cMKPWby8a238SM75/x
         oBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AymeHIyeNEkJXID1khfAkGq+Ez00dJt89KKS/zaptAY=;
        b=ZKpV6AFg3AHyVS777hKcdd+yY5DLOXK/8oPiQuQJle9yZuH6g3Mb1etnjED1/UkeXf
         1WTR4Jn5CEoYWXJopg2KLMpd7/kQS/2vr9tx00k2w3xkkA6YjtUDH80V7RI/Xkjtsm/8
         Ixubv/NravfRTUK6L8l0myH8rGudKm6PMF0o22LjfpKxL6JlirAOGqnif4JAejhTwjDP
         +T5c0Lkp5BQGbAQ8wTV0NoIbVTcKBakOFqy6IIJRI6Qdt1gEoZmfwopru1owoRGYBEiD
         m87qWUKk//porm5HMERVOqwJqfiVKfI7L+BsuaREwdfjqar4ip6TDcyIQ6adYdN1Yh+h
         e/Vw==
X-Gm-Message-State: AOAM533KITV1oz7y3xgjLR3mzjijhTuujbK6qkwJhInUgTOCnUUUltE4
        EUSUW9u9c2Wzhgigvw8YWTh8AOTiiD3e
X-Google-Smtp-Source: ABdhPJxA36g6yvOYrzKcHsfyxS34FLtB7j2Yn8STDG6lcr5qTDMiG4ODtKfuPSxGYbAKK3+wnkvSKIeqT1i4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b14e:bc64:b7f6:5d4b])
 (user=irogers job=sendgmr) by 2002:a25:a89:: with SMTP id 131mr33008461ybk.234.1643680746352;
 Mon, 31 Jan 2022 17:59:06 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:58:33 -0800
In-Reply-To: <20220201015858.1226914-1-irogers@google.com>
Message-Id: <20220201015858.1226914-2-irogers@google.com>
Mime-Version: 1.0
References: <20220201015858.1226914-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 01/26] perf test: Allow skip for all metrics test
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

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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

