Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25B563CAD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 01:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiGAXJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 19:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiGAXJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 19:09:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843071BF1;
        Fri,  1 Jul 2022 16:09:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l2so3994717pjf.1;
        Fri, 01 Jul 2022 16:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IRIEmaeAGecPLER6MT79dRjRZdauydgJASqqrU4/Kg=;
        b=SdbwE9SB09/WGXPxj0WG5eSh+z5Y9MRmCDAT55nPg50HMKd2kqr5U77bO3B+FQPjDT
         0y2fPFQz950SK8ds5T7IJKuBeaFXDSx3NecPebmNi1f6c5Txg39/RvUlI1yFaijgy3Cy
         HITwlFjfux+07H1F/EahDqMXKTMECveugjAh56h+Gu4L4gFxA7baaVgMn936WRv3+v2i
         e3aTV7QHMoeMfASi2RGDdqZKfbbK5y3nu+5cz7KTbq73hut60piK8LltrrLxVVVgrgYN
         ZNOG7DFGzVSPCwc4AJ6WSm9nJMxC1d+fT4VUtle0YG22jyDG2oHbef4VbqfZLViZIARF
         0wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6IRIEmaeAGecPLER6MT79dRjRZdauydgJASqqrU4/Kg=;
        b=ljliAGrAdmbHtqDe8abQsorlnNTNnBraBA+Ftaf6iv3WF8UHe0+S6ZPqXJeA96lOzp
         PSKz/gZs60ffyoSqHIKvYB3cj6IPWkhXoTMVvRO84xfCjbF3D6RNseMfszjj44+0O4LJ
         m6a/GFoUddn++OrRlQqxa8vCDRVn2zak5esinaG7tQKNfxrNVm0kyJjXvWrtpsSVjN9y
         hUnUCvWrPsRJzOpbopyGJCJlWflOZiDLt2mO3U7rRcchKuNC9SUj1AE9qK8Mu3eChmI7
         +bRy7KVthzooXpxwhAwUUR2fRzs+5ynWm7NGfc2USFYKY1421VoBK1VFd1gaTBOsMUTK
         k7Sw==
X-Gm-Message-State: AJIora9Kfh8ERGe9tr3uhxjbh70nMildHZhJUgcrTUAGZrXiDPEFixBH
        woETdcPBOMPrhimTb0Z8oTU3CeyFrAE=
X-Google-Smtp-Source: AGRyM1vA/AjwaFm81NLiY27aIloLyadvzu2yIpcAegr60+50oyy5p7qGjtvZXKOeLyozLXgud1CatQ==
X-Received: by 2002:a17:902:f68f:b0:16a:7a95:4689 with SMTP id l15-20020a170902f68f00b0016a7a954689mr22440565plg.112.1656716974276;
        Fri, 01 Jul 2022 16:09:34 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:3b24:1e12:a30a:e9e9])
        by smtp.gmail.com with ESMTPSA id c3-20020a624e03000000b005183cf12184sm6256981pfb.133.2022.07.01.16.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 16:09:33 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3] perf test: Add ARM SPE system wide test
Date:   Fri,  1 Jul 2022 16:09:32 -0700
Message-Id: <20220701230932.1000495-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
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

In the past it had a problem not setting the pid/tid on the sample
correctly when system-wide mode is used.  Although it's fixed now it'd
be nice if we have a test case for it.

Cc: German Gomez <german.gomez@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* skip if system-wide record was failed
* use dummy event for testing

 tools/perf/tests/shell/test_arm_spe.sh | 30 +++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index e59044edc406..0d47479adba8 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -23,17 +23,20 @@ glb_err=0
 cleanup_files()
 {
 	rm -f ${perfdata}
+	rm -f ${perfdata}.old
 	exit $glb_err
 }
 
 trap cleanup_files exit term int
 
 arm_spe_report() {
-	if [ $2 != 0 ]; then
+	if [ $2 = 0 ]; then
+		echo "$1: PASS"
+	elif [ $2 = 2 ]; then
+		echo "$1: SKIPPED"
+	else
 		echo "$1: FAIL"
 		glb_err=$2
-	else
-		echo "$1: PASS"
 	fi
 }
 
@@ -85,5 +88,26 @@ arm_spe_snapshot_test() {
 	arm_spe_report "SPE snapshot testing" $err
 }
 
+arm_spe_system_wide_test() {
+	echo "Recording trace with system-wide mode $perfdata"
+
+	perf record -o - -e dummy -a -B true > /dev/null 2>&1
+	if [ $? != 0 ]; then
+		arm_spe_report "SPE system-wide testing" 2
+		return
+	fi
+
+	perf record -o ${perfdata} -e arm_spe// -a --no-bpf-event \
+		-- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
+
+	perf_script_samples dd &&
+	perf_report_samples dd
+
+	err=$?
+	arm_spe_report "SPE system-wide testing" $err
+}
+
 arm_spe_snapshot_test
+arm_spe_system_wide_test
+
 exit $glb_err
-- 
2.37.0.rc0.161.g10f37bed90-goog

