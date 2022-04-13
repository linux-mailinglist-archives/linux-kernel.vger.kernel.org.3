Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62E4FEC03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiDMBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiDMBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:05:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA2B220F6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:02:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ks6so916266ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHgRgX3+0ilVJ9YEz+Ro35NSCV1c4ZJEIy9ObWgb1b8=;
        b=NUCfHE9xdZ9NzydGuze+K4FGrkTRWikvoUjVdKKEmj+51xkJonHOUtFyTKNZ8fE3k8
         n2mvmJWCsJv2SuD0lN1+Ao+lt9oMDLmPksYpizz9qGjWMmSZjRdT014Qvq/AazOMe+lz
         EWc3XnI6Ff08/IESsrCyfoQKheL6BpyxJrDZT3skcTlAm87BPKgTLJcu96KLQyBKwJe3
         GvvglTGHlqgekGZWihpodT1+zUyXqRmDA5a6IGWeis9Ak8Y9aGxTXnCL/8TwIWwMMCjt
         PZq1jN1OH0Q1TQfDXDPZVt1+pkwDFbksdGcMTMsJRNP6BTsIN9JtrwNWtYChVUbAd1RZ
         2s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iHgRgX3+0ilVJ9YEz+Ro35NSCV1c4ZJEIy9ObWgb1b8=;
        b=KuaZXgCQxiROUk4CIxI+o+sKycdvQMoxv5NunyA0bXGB2Siecij7n4pumHVgAwzmd/
         IzXPjh7900fo/+MJ4A0QDhxcn6/m9uIhCgSCHlArQkWDzVtUwwBWPgPeaijCajGS5CRK
         wgBtk8xxjGfy3Hx/PtMTksK7HbuOJD01aMjaCmspe+BZ/jUWCvxVmeTjQc+VMfb2AotW
         I2aJfiINR0j1L4RrxtutzHk6m0OHBX6jhaZOigDAVTlLZPbbKEYDIpicCwqF7M0I7kK+
         0y9I9c5qhG6G1Wq6e+nKbUN9PHUxAxWtHYwlz3v/pk25t1dPrpK6TbtZzdbhk3lETatp
         pAPA==
X-Gm-Message-State: AOAM533Vt97eU+Bp9rzShYgBRPLSepPfc/ts59Qw6Vi9dlPFeassu7mB
        SSIFb2GV9MqMpoY1xkF+ARsLGQ==
X-Google-Smtp-Source: ABdhPJz6nR5gS7smVj1tOoFEo1ZKYCvXsj50KSC95aQgmU9VFWO11RjMevciiQIBq2XNa9yaSNR2HA==
X-Received: by 2002:a17:907:97d4:b0:6e8:6b69:7120 with SMTP id js20-20020a17090797d400b006e86b697120mr17895555ejc.531.1649811759886;
        Tue, 12 Apr 2022 18:02:39 -0700 (PDT)
Received: from localhost.localdomain (111-250-44-108.dynamic-ip.hinet.net. [111.250.44.108])
        by smtp.gmail.com with ESMTPSA id e11-20020a50becb000000b0041b64129200sm475834edk.50.2022.04.12.18.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 18:02:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf arm-spe: Test memory samples
Date:   Wed, 13 Apr 2022 09:02:21 +0800
Message-Id: <20220413010221.81332-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new test to verify the Arm SPE synthesized memory samples with
'perf mem report' command.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_arm_spe.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index e59044edc406..b36125e127eb 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -62,6 +62,18 @@ perf_report_samples() {
 		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 " > /dev/null 2>&1
 }
 
+perf_mem_report_samples() {
+	echo "Looking at perf.data file for reporting memory samples:"
+
+	# Below is an example of the memory samples reporting:
+	#   20.71%    1696    27    L1 hit     [k] el0t_64_sync_handler    [kernel.kallsyms]    ...
+	#   17.21%    1903    20    L1 hit     [k] el0t_64_sync            [kernel.kallsyms]    ...
+	#    8.52%     897    21    L1 hit     [k] ksys_read               [kernel.kallsyms]    ...
+	#    0.12%      16    17    L1 hit     [.] 0x0000000000004ce8      dd                   ...
+	perf mem report --stdio -i ${perfdata} 2>&1 | \
+		egrep " +[0-9]+\.[0-9]+% +[0-9]+ +[0-9]+ .* +$1 " > /dev/null 2>&1
+}
+
 arm_spe_snapshot_test() {
 	echo "Recording trace with snapshot mode $perfdata"
 	perf record -o ${perfdata} -e arm_spe// -S \
@@ -79,7 +91,8 @@ arm_spe_snapshot_test() {
 	wait $PERFPID
 
 	perf_script_samples dd &&
-	perf_report_samples dd
+	perf_report_samples dd &&
+	perf_mem_report_samples dd
 
 	err=$?
 	arm_spe_report "SPE snapshot testing" $err
-- 
2.25.1

