Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4D59CAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiHVVeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiHVVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:34:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C9222BC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:34:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-337ed9110c2so164678477b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=dI1HM2qpD13pHVf8vcdUDtzAR56g72bb/Lagcy2hQJo=;
        b=NW7jcTketQHOa31a5ZOmDT3goDI2B8/cHmva8ClRVt6pOzcdpSI2qKr5ovG9u5Fmn0
         mHlEwL16EzQa2MlP8Oknzi3Mp7ukSkGQgB38UTNNuj7pdPfgHg1fWIJsgXANKkwZHlyd
         fTfqOWZH2tfo/TovUGebIood8ZVgiBpgN85kI3Vky+IJp8b7gIu9zd7rnnRx7wWbA82j
         wDAib8CWzWxNdT1O7EJaYSQVdX5Fhz2mQagBESo7gbOXghye842FSINVuebwXDf9xAx9
         u59eBDQeMV6lYbp2Pjxn8Dhl5wADAoatnaX3K/pGqJBPqnSZ+hcudXYwTx/qu5HTCVpv
         ATVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=dI1HM2qpD13pHVf8vcdUDtzAR56g72bb/Lagcy2hQJo=;
        b=FV5XV85CVo91TXqI8uW96WZqztMeh7fJHbigXRz+4/S9p694CubB2bvpaj2ZjWgtXJ
         +2PgbzqA++DqCidmEAsMS9MMkAFIy+0RG7IY9rlWDL5EUO6yVal5kErnHNt/N0SF5vW/
         GzoB6lqTGMmbW4MdOgCerDKCpqQwBqc67YNoHl0ybvWZd89cH3zGWKkOZW/v9y4kikbR
         SZo1APW6J4x5SdG0RVbT0n673UfSb4vzmq+lzvz0hgWKIH4yCwFCrvVaNMGuiBQQDh2Y
         JE2hIcVhlDxy/27h3+YnpIgEfeonOlOm330GzNgnQU3awTOqWAbFtq5jFpGi/+pTgtHt
         KdPA==
X-Gm-Message-State: ACgBeo0i/a10wZKst6q2lKW6DkuBxQKLaule/AXunr36J+5UaD+3WjdK
        hlG++EC4aqh6Gk7roCpwD31tNn3CFqM+
X-Google-Smtp-Source: AA6agR4nULUg2CVMU5RXXoLFXgyGL8q9ciVi+6GVip8nhfi+e/KN0hQHNcuJH5vW1+5AdSa2kK+7ei0h9mVd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2768:cfe4:142e:cbca])
 (user=irogers job=sendgmr) by 2002:a25:4013:0:b0:695:b3ca:c165 with SMTP id
 n19-20020a254013000000b00695b3cac165mr6439198yba.406.1661204047024; Mon, 22
 Aug 2022 14:34:07 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:33:52 -0700
In-Reply-To: <20220822213352.75721-1-irogers@google.com>
Message-Id: <20220822213352.75721-2-irogers@google.com>
Mime-Version: 1.0
References: <20220822213352.75721-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v1 2/2] perf test: Stat test for repeat with a weak group
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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

Breaking a weak group requires multiple passes of an evlist, with
multiple runs this can introduce bugs ultimately leading to
segfaults. Add a test to cover this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 9313ef2739e0..26a51b48aee4 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -28,6 +28,24 @@ test_stat_record_report() {
   echo "stat record and report test [Success]"
 }
 
+test_stat_repeat_weak_groups() {
+  echo "stat repeat weak groups test"
+  if ! perf stat -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' \
+     true 2>&1 | grep -q 'seconds time elapsed'
+  then
+    echo "stat repeat weak groups test [Skipped event parsing failed]"
+    return
+  fi
+  if ! perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W' \
+    true > /dev/null 2>&1
+  then
+    echo "stat repeat weak groups test [Failed]"
+    err=1
+    return
+  fi
+  echo "stat repeat weak groups test [Success]"
+}
+
 test_topdown_groups() {
   # Topdown events must be grouped with the slots event first. Test that
   # parse-events reorders this.
@@ -75,6 +93,7 @@ test_topdown_weak_groups() {
 
 test_default_stat
 test_stat_record_report
+test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 exit $err
-- 
2.37.2.609.g9ff673ca1a-goog

