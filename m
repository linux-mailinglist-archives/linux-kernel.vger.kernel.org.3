Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553545AFCC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIGGrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIGGqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:46:50 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5C82D3A;
        Tue,  6 Sep 2022 23:46:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u22so13513669plq.12;
        Tue, 06 Sep 2022 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=0Od+VaN8FUmESvL1wFykrP2D7y9RzKIvl/fV42CNueI=;
        b=PgpFZhNxIo7ULYaIKIdY0EBpoSUfwWk1WKPTuEHi1d8LICpzEKRS6mcxfSRII1Cj6a
         tCeTMu0TdIczW6fg0Su5JQ4MK0mDj38wp5VhbREOo+3pJAdIgN/6bzyRlwA0M9TqaT3k
         02B6HMcEec+v3Ll75Ffyv2lFJznVCp3Ii/wvascXP5KPllK11PKaBGhpKPWiM/aePRV7
         piYzlUvH1YIImV1XFGV22BfqpFmzDwwqgagPX0MXN0QdFIDeFPimnzTC8xFnHnB5tYuo
         ZCqaRAwFf6w2+h8RELV7tDyaTBSV6NTIQ2HfW7NJZWuzZdTyZvUeUUEtcSXHPZ0tSP3v
         ufQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=0Od+VaN8FUmESvL1wFykrP2D7y9RzKIvl/fV42CNueI=;
        b=EGd4Mtjn8WnWRu8aK+PMwgEo5v7yPMeXf5wDwUsSer56nhfP4Xq+hvmFaFvJImYhUf
         /RhabRuwtFoOb/O5DWqUaKBfN+NEdb/rYVUT7o7bG1IQ2t2ds+aebXYNjnyAwaR9mAph
         4HuSVcUeIx0enSkCrWy7Zcw4ld6oSkQeIcgJhyWWUzpLDKZV77MFALL7oqi/yVtSG6sk
         WYKqIlymzrYbjTs2RIiD46PWElghdYsEdDCARJb02WeyjVDJ4iQz2U+zn+9wa7zXTNy7
         1904LCmQ60B3gO9RqvQ0iUKuoBEzbabeu0dgTJtjD9Dwe4sBW0NZYpFEMpzbRMS3I+s8
         XoSw==
X-Gm-Message-State: ACgBeo0HvApbGY49Ux1dlCEjsaHLS7eSRwIpGjJeiMk2KKJamFJi8XsI
        mxz2ZxiH9H/DdpuqTsoTh6o=
X-Google-Smtp-Source: AA6agR7U0W/TbyeRxQFgP7uDvFJpfAjNaThe/r2FhAgPFbNXqR5GBlTzsLv7fQt2In0Fl6eRHDo1/A==
X-Received: by 2002:a17:90b:3e84:b0:1fd:ce48:979 with SMTP id rj4-20020a17090b3e8400b001fdce480979mr2335987pjb.54.1662533209356;
        Tue, 06 Sep 2022 23:46:49 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:f249:9066:7da7:4a37])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm11192192ple.48.2022.09.06.23.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:46:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/6] perf test: Do not use instructions:u explicitly
Date:   Tue,  6 Sep 2022 23:46:40 -0700
Message-Id: <20220907064645.1197894-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220907064645.1197894-1-namhyung@kernel.org>
References: <20220907064645.1197894-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it's to support non-root user tests.  But perf record can handle
the case and fall back to a software event (cpu-clock).  Practically this
would affect when it's run on a VM, but it seems no reason to prevent running
the test in the guest.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 00c7285ce1ac..40b087bfdb76 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -21,18 +21,18 @@ trap trap_cleanup exit term int
 
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  if ! perf record -e instructions:u -o ${perfdata} --quiet true 2> /dev/null
+  if ! perf record -o /dev/null --quiet true 2> /dev/null
   then
-    echo "Per-thread record [Skipped instructions:u not supported]"
+    echo "Per-thread record [Skipped event not supported]"
     if [ $err -ne 1 ]
     then
       err=2
     fi
     return
   fi
-  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
+  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
   then
-    echo "Per-thread record of instructions:u [Failed]"
+    echo "Per-thread record [Failed record]"
     err=1
     return
   fi
@@ -49,7 +49,7 @@ test_register_capture() {
   echo "Register capture test"
   if ! perf list | egrep -q 'br_inst_retired.near_call'
   then
-    echo "Register capture test [Skipped missing instruction]"
+    echo "Register capture test [Skipped missing event]"
     if [ $err -ne 1 ]
     then
       err=2
-- 
2.37.2.789.g6183377224-goog

