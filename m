Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB915AFCC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIGGrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIGGrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:47:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C41091096;
        Tue,  6 Sep 2022 23:47:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z187so13647757pfb.12;
        Tue, 06 Sep 2022 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=BUSuJ/7Ci0Mvei01EbqJd2VOB/lHA3wgZ4n5NX58oL8=;
        b=I/HHWjtWubOsRjx1w9Tbou41mtlzBt5rW3Y8O4gTCvJnSpQjgXpKvQJN2Dpy1eubXm
         eme3cpTRcuJb3VkAkz3SQyREtECIp1oBQgyS8NnPOfN4ZXROwWoDZO1MMO3NHa4Gr/Cq
         yMhkgnqnBPPMu2zu95heyTNjojMGNdWWAcr/rt+/+NXmUcaytbxMhsKZdxZ+h0+KnjUm
         dBf/P+OWEdxAZL+VJ7inStOfkH6/NoH5VsxK0/C4ber2o8UvB1ysgvlXh2bue+XzeRpY
         S2053IM8s5zF9MdKw0N5XJnw+eyj+wib5r0a6EVmDXDznFE1dnSzDfZkCOPCS9H6OvC1
         vKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=BUSuJ/7Ci0Mvei01EbqJd2VOB/lHA3wgZ4n5NX58oL8=;
        b=QUokTfLyRTPEprcBPxS0TMxGNg596PdEyLHmJyHITiMzaLSp8sqfNbz5xVy0W2eHdv
         +kyDpRYlm/qEbXmS/K2v96R7QTJ9L90fHDErfeWrBqZRFT5CmfzLERQRaGOepG1984+y
         hjCL2E129i9eNUVtRQg9esN0JnVlfrkBL3/CGHZJvq/stJFrw030Rq7BdOUe+JsAonyK
         f64pvT9zFGvf5cpVJa6Kc1yQTp+US9mraDz4acnClBK7rrvieIGMKBSplqnmn9gIkZiV
         fPUhOiY8oIhmAfxdKfhSjS5LUXmbXzfCioBjRNA/s01eFpdkHCAf0XxnEUrmbGGHQRuG
         zSbw==
X-Gm-Message-State: ACgBeo3d3JI8zA8yLQKk8qiVS6GEfDaq8fA67olpIL1qowl25zN/WScN
        wvceIv7GTr0mHOiRcIjkf0c=
X-Google-Smtp-Source: AA6agR6UXZGAG2rabT+vl7nvyoosoapU0XTcWk8XHuDb80cyFWwqVpKmmHJcK9yCN8rbyfXMEAhueQ==
X-Received: by 2002:a63:4e44:0:b0:42b:1fff:72d1 with SMTP id o4-20020a634e44000000b0042b1fff72d1mr2209761pgl.432.1662533219763;
        Tue, 06 Sep 2022 23:46:59 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:f249:9066:7da7:4a37])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm11192192ple.48.2022.09.06.23.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:46:59 -0700 (PDT)
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
Subject: [PATCH 6/6] perf test: Do not set TEST_SKIP for record subtests
Date:   Tue,  6 Sep 2022 23:46:45 -0700
Message-Id: <20220907064645.1197894-7-namhyung@kernel.org>
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

It now has 4 sub tests and one of them should run at least.
But once TEST_SKIP (= 2) return value is set, it won't be overwritten
unless there's a failure.  I think we should return success when one
or more tested are skipped but the remaining subtests are passed.

So update the test code not to set the err variable when it skips
the test.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index ff66e58f3a26..487981767455 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -72,10 +72,6 @@ test_per_thread() {
   if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
   then
     echo "Per-thread record [Skipped event not supported]"
-    if [ $err -ne 1 ]
-    then
-      err=2
-    fi
     return
   fi
   if ! perf record --per-thread ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
@@ -111,10 +107,6 @@ test_register_capture() {
   if ! perf list | egrep -q 'br_inst_retired.near_call'
   then
     echo "Register capture test [Skipped missing event]"
-    if [ $err -ne 1 ]
-    then
-      err=2
-    fi
     return
   fi
   if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
@@ -139,10 +131,6 @@ test_system_wide() {
   if ! perf record -aB --synth=no ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
   then
     echo "System-wide record [Skipped not supported]"
-    if [ $err -ne 1 ]
-    then
-      err=2
-    fi
     return
   fi
   if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
-- 
2.37.2.789.g6183377224-goog

