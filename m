Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF454EDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379267AbiFPXFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379122AbiFPXFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:05:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782305F248;
        Thu, 16 Jun 2022 16:05:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i15so2443473plr.1;
        Thu, 16 Jun 2022 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHgod+Kwm8xVpSdotXQQvx7e6tmha0GKj/Bf2zOifHk=;
        b=OXWRYmk3bowxbdyaVslq9VNcPeawn20YbaR1OPvyh0O7ygcQjUnHi5Qg61SiPX0GiD
         00kM6ArXf8CqTpduim9SzIvSIBZca8RVcSQ4m7rFl9SEJL+3DW3oChYVuto32I+tfuFM
         rPBpeQAXOPKzRk2RVhHs4VW2Ku4w8yfbvtIXnmHG+fak80AA9glfnvAnNGMa7BpQ7H8D
         vwJnjbH0/tm/LaRdEIG+EE+7vrGCHG68A4gIXlRaINU8FaXyB/pCvIO4i2qK3csYJm/W
         rLeXyiQVUJFDUHGh0WXdbXFyOFooWXsM3Wl3U+26BsH3+UBYtGIhgEMNISZerXdasd80
         NaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mHgod+Kwm8xVpSdotXQQvx7e6tmha0GKj/Bf2zOifHk=;
        b=KlSbriLHBS0UY1b2A+vUlmXjiPPvEoUYsX0+hV8/w0y0I8estSsj38OgcF9M5LxMjb
         mT+QXsIYX7lWEyT72nf6m/DquhJNe4l1caQ2SKrZeIG2AwqfcyA+bJxVF+aw0x3CyB7c
         qmuqew33je78icN1T/TagtgS+XMwyxppcPA+f/M7D1fZl3SXFUEfbcGptP69ONPPfTaa
         cuZpAARRL/dPPABMzCY22h3P//Y3hvCIJktS0AV/b48Rzk9h+OQBD52q0Yvn14HnjAFp
         MUpPAyh90t1Y5szZPqH3Wy1OqiyscyyMCg8tHjG78XKubxQ5ElN7KBlW139bMRSBOvxX
         oIsw==
X-Gm-Message-State: AJIora+NBHE2ZXdouENWayCFgfUtwWiPinbeSKyiIwHZYbTaiX5Ce4/L
        eQZ/tZoBj49VYBjyLsAo0TI=
X-Google-Smtp-Source: AGRyM1uV6/odU4A50BOArugcTBNxGR1W4NDH3lx5sugfaP1Topmwxuko/J/qzy6expDqJmVv/wCQXw==
X-Received: by 2002:a17:90b:1611:b0:1ec:6ce7:5e11 with SMTP id la17-20020a17090b161100b001ec6ce75e11mr2613639pjb.146.1655420748778;
        Thu, 16 Jun 2022 16:05:48 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:1253:816e:a3a1:fc8b])
        by smtp.gmail.com with ESMTPSA id p48-20020a056a0026f000b0050dc7628184sm2321457pfw.94.2022.06.16.16.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 16:05:48 -0700 (PDT)
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
Subject: [PATCH v2] perf test: Add ARM SPE system wide test
Date:   Thu, 16 Jun 2022 16:05:46 -0700
Message-Id: <20220616230546.1390813-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

 tools/perf/tests/shell/test_arm_spe.sh | 28 +++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index e59044edc406..962841a51f27 100755
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
 
@@ -85,5 +88,24 @@ arm_spe_snapshot_test() {
 	arm_spe_report "SPE snapshot testing" $err
 }
 
+arm_spe_system_wide_test() {
+	echo "Recording trace with system-wide mode $perfdata"
+	perf record -o ${perfdata} -e arm_spe// -a \
+		-- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
+
+	if [ $? != 0 ]; then
+		arm_spe_report "SPE system-wide testing" 2
+		return
+	fi
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
2.36.1.476.g0c4daa206d-goog

