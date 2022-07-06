Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663F756800F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiGFHhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiGFHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:37:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4832522BC4;
        Wed,  6 Jul 2022 00:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G14bq91rAmEKzbTyYrEH3etwEqGvi9trpBFIgrDRTAQdxzqpuVXrw7hhS9Un0KsxXXmlQe417oRwjGJ0S603g7O2gh2U3VRe3VHZTh8g/NEr7B3jCkTU3a03HXncR90pKVlmZevdvZmg3PuHqbH1uNzV9AoMFrBzVZaGliWzMWNzEjzZ3nDIlvzQaQarJU8oPGvxssHruu7kHf8AJQLHDd3I7o+2b8DfJ4YKmjDDZ5FevqG2vy8gea1tD8x7D1VvS+TfhJqkZj4QgcWjisgFs/cfguPjueegfj+Sc8nI5W7eS9TXETwv8DSwAGX+7iIBLnlr8icdqgqx6vwjkA/V0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrC1TjL9RzVlD/Xt8AGIlrt+M1iz9DAQ7dSjduadBeU=;
 b=Xs3+aeED4tVVQq4So6bzfjMVph3ISrLejb4BNx5C8s5o3nIjgJW/9jiEhEZuOefDD08pbiRJI8LHo/jfe71oO6vBYDwEfS4E/U92+IMEXHBnlkyOT2WR26gv50fa8b8G1WE4bHnWTTtjGVu3BJEUftiBa2V0GyR0IP2QbyZ/Gx2vbsGZnMZjiAdec61JVC7Xrimp0CHTCbJvHgKLAdF6RPF98OLu81WGLw2MHFw+kwjvCAP9N0QoZczaqpaGHP8elmo5HsubazEQerPtu5WvjMqgSm2qaHIDd67AtwjJy46NoBQMfw/iz89Mr/mNd2GmI3jpRVLkSP8Ly1F8ChuRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrC1TjL9RzVlD/Xt8AGIlrt+M1iz9DAQ7dSjduadBeU=;
 b=nNKsbxUIkMSJ2e2iAIRVTxoZ/njl5aHm5DZuLxY/NJEjUI8nJICCPShGIE2dreHtKqMiArHca8+iV6U2FJM8nFuuVH42RHWZBfbwkiYga2Ni2dxPat6Tqwb4xFFcDocSqC2bsWQnQiSfxmLD9xSpZ8TmbneHIhlneNPzOCJAqgQ=
Received: from MW4PR04CA0364.namprd04.prod.outlook.com (2603:10b6:303:81::9)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 07:37:08 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::f2) by MW4PR04CA0364.outlook.office365.com
 (2603:10b6:303:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 07:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 07:37:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 02:37:02 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V1 3/4] selftests: amd-pstate: Trigger gitsource benchmark and test cpus
Date:   Wed, 6 Jul 2022 15:36:21 +0800
Message-ID: <20220706073622.672135-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706073622.672135-1-li.meng@amd.com>
References: <20220706073622.672135-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a2de39-d10c-4d60-c006-08da5f2254d1
X-MS-TrafficTypeDiagnostic: LV2PR12MB5750:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+BTluKCYANNHVdFdXS4qNzdZMGUnaLvGGRrX3bsV9SgfDK6WKGof8uuwqG0Wcio0kyzdCjOs2WhZSkQ2c3SfNjDVeTULC8gbHL2anJjoLeYJJQkLnI+ziUTmc+YmuWWWK+qvAkHsJyL7+m0AQmfZP5emEP6pFw/wkHu5lIUIiN1jrktkBjtylA4vmi5i68xlRyFMKYfMmbMsIf13EagzNkeBmb65CI5ZmiziZ6xHcQg20BAeimrOJOm4TMH33nDb4BMTDYd08kqHd1nnnOjA0mwMNpSBGi5QtV9tbQ9n5oVKB+HXsM2T+aJWrWb9y7ozOPXNR6SJ07gRlKohn1HSUwYv22a6hDykfQ3zKiOIR9M/n3SOOBIz6ND1bDWzI2NmnRuF07yb00cftv4EmUB4slrw6JqRetx4jVJyxtwnBEvFZVtKE+xBYC4aRe0LGolAgBEez5ShE6MunTuTRpPlzEj/S71pnI0YxQMyo06E9+7g0nV7MOU02aGtxVo+gaN0xRZrDfBxusCLEnRIyqAHvgLJKeY494aitWrkhh1ZgClXo73Cm0kFYRiz+suuWkN5EZuOMSQYYEzPjsnmRBMCVxEPYFWcHLZROsMOUh941w96+rSwRmyBgh5T4lckVKY1D17vp7GmSNSD3haigbHJBLa4myUaftpZ0uSGGzo1U8IV3MfrHQlaeAS/ZEizwiIlERSyKdFcI3kcUMuAwgzMFS6kd2ZNhBL+SW3xQBh09yW9wyN9/A3mX+yXCbKnUdj5DUpeh7NNvyWufG7WEGnAufSNt05i/HsMWg4nSa7bMHpHj70WruT+BQPEE3xCQ+pUMH0T1hFH3V98Mb9DyFVyojDNu9O6ROSZjZvIw90N1/ZgQ5m1zACVqgGgvxOwesdT2qR4Rs8BKqngn2L+INF3WjoBHC0Mnw9b4tGeC5tIak=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(40470700004)(40460700003)(8936002)(36756003)(47076005)(426003)(336012)(2616005)(5660300002)(186003)(16526019)(86362001)(1076003)(83380400001)(26005)(110136005)(54906003)(316002)(2906002)(40480700001)(478600001)(41300700001)(8676002)(6666004)(34020700004)(70586007)(70206006)(81166007)(82740400003)(36860700001)(4326008)(356005)(82310400005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 07:37:08.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a2de39-d10c-4d60-c006-08da5f2254d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gitsource.sh trigger the gitsource testing and monitor the cpu desire
performance, frequency, load, power consumption and throughput etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/amd-pstate/Makefile   |   2 +-
 .../testing/selftests/amd-pstate/gitsource.sh | 176 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/main.sh    |  21 ++-
 3 files changed, 195 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index e2fb03381a32..c536b9303858 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -13,6 +13,6 @@ TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
 endif
 
 TEST_PROGS := run.sh
-TEST_FILES := main.sh basic.sh tbench.sh
+TEST_FILES := main.sh basic.sh tbench.sh gitsource.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
new file mode 100755
index 000000000000..0631a4839f5d
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -0,0 +1,176 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Testing and monitor the cpu frequency and performance when
+# this script trigger gitsource test.
+
+# protect against multiple inclusion
+if [ $FILE_GITSOURCE ]; then
+	return 0
+else
+	FILE_GITSOURCE=DONE
+fi
+
+git_name="git-2.15.1"
+git_tar="$git_name.tar.gz"
+gitsource_url="https://github.com/git/git/archive/refs/tags/v2.15.1.tar.gz"
+gitsource_governors=("ondemand" "schedutil")
+
+# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: time $7: energy, $8: PPW
+store_csv_gitsource()
+{
+	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_GIT.csv > /dev/null 2>&1
+}
+
+empty_line_csv_gitsource()
+{
+	echo "" | tee -a $OUTFILE_GIT.csv > /dev/null 2>&1
+}
+
+pre_clear_gitsource()
+{
+	rm -rf results/tracer-gitsource*
+}
+
+post_clear_gitsource()
+{
+	rm -rf results/tracer-gitsource*
+	rm -rf $OUTFILE_GIT*.log
+}
+
+install_gitsource()
+{
+	if [ ! -d $git_name ]; then
+		printf "Download gitsource, please wait a moment ...\n\n"
+		wget -O $git_tar $gitsource_url > /dev/null 2>&1
+
+		printf "Tar gitsource ...\n\n"
+		tar -xzf $git_tar
+	fi
+}
+
+# $1: governor, $2: loop
+run_gitsource()
+{
+	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
+	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1
+
+	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
+	cd $git_name
+	./../perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
+	cd ..
+
+	for job in `jobs -p`
+	do
+		echo "Waiting for job id $job"
+		wait $job
+	done
+}
+
+# $1: governor, $2: loop
+parse_gitsource()
+{
+	awk '{print $5}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-des-perf-$1-$2.log
+	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-des-perf-$1-$2.log)
+	printf "Gitsource-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
+
+	awk '{print $7}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-freq-$1-$2.log
+	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-freq-$1-$2.log)
+	printf "Gitsource-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
+
+	awk '{print $11}' results/tracer-gitsource-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_GIT-load-$1-$2.log
+	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_GIT-load-$1-$2.log)
+	printf "Gitsource-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
+
+	grep user $OUTFILE_GIT.time-gitsource-$1-$2.log | awk '{print $1}' | sed -e 's/user//' > $OUTFILE_GIT-time-$1-$2.log
+	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1-$2.log)
+	printf "Gitsource-$1-#$2 user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
+
+	grep Joules $OUTFILE_GIT-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_GIT-energy-$1-$2.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1-$2.log)
+	printf "Gitsource-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
+
+	ppw=`echo "scale=4;$time_sum/$en_sum" | bc | awk '{printf "%.4f", $0}'`
+	printf "Gitsource-$1-#$2 PPW(s/J): $ppw\n" | tee -a $OUTFILE_GIT.result
+	printf "\n" | tee -a $OUTFILE_GIT.result
+
+	store_csv_gitsource $1 $2 $avg_des_perf $avg_freq $avg_load $time_sum $en_sum $ppw
+}
+
+# $1: governor:w
+
+loop_gitsource()
+{
+	printf "\nGitsource total test times is $LOOP_TIMES for $1\n\n"
+	for i in `seq 1 $LOOP_TIMES`
+	do
+		run_gitsource $1 $i
+		parse_gitsource $1 $i
+	done
+}
+
+# $1: governor
+gather_gitsource()
+{
+	printf "Gitsource test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_GIT.result
+	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_GIT-des-perf-$1.log
+	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-des-perf-$1.log)
+	printf "Gitsource-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_GIT-freq-$1.log
+	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-freq-$1.log)
+	printf "Gitsource-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_GIT-load-$1.log
+	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-load-$1.log)
+	printf "Gitsource-$1 avg load: $avg_load\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "user time(s):" | awk '{print $NF}' > $OUTFILE_GIT-time-$1.log
+	time_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-time-$1.log)
+	printf "Gitsource-$1 total user time(s): $time_sum\n" | tee -a $OUTFILE_GIT.result
+
+	avg_time=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-time-$1.log)
+	printf "Gitsource-$1 avg user times(s): $avg_time\n" | tee -a $OUTFILE_GIT.result
+
+	grep "Gitsource-$1-#" $OUTFILE_GIT.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_GIT-energy-$1.log
+	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_GIT-energy-$1.log)
+	printf "Gitsource-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_GIT.result
+
+	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_GIT-energy-$1.log)
+	printf "Gitsource-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_GIT.result
+
+	ppw=`echo "scale=4;$avg_time/$avg_en" | bc | awk '{printf "%.4f", $0}'`
+	printf "Gitsource-$1 PPW(s/J): $ppw\n" | tee -a $OUTFILE_GIT.result
+	printf "\n" | tee -a $OUTFILE_GIT.result
+
+	store_csv_gitsource $1 "Average" $avg_des_perf $avg_freq $avg_load $avg_time $avg_en $ppw
+	empty_line_csv_gitsource
+}
+
+amd_pstate_gitsource()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running AMD P-state gitsource         ***"
+	printf "\n---------------------------------------------\n"
+
+	pre_clear_gitsource
+
+	install_gitsource
+
+	store_csv_gitsource "Governor" "Round" "Des-perf" "Freq" "Load" "Time(s)" "Energy(Joules)" "PPW(s/J)"
+
+	for_each_policy backup_governor
+
+	for governor in ${gitsource_governors[*]} ; do
+		printf "\nSpecified governor is $governor\n\n"
+		for_each_policy switch_governor $governor
+		loop_gitsource $governor
+		gather_gitsource $governor
+	done
+
+	restore_governor
+
+	post_clear_gitsource
+}
diff --git a/tools/testing/selftests/amd-pstate/main.sh b/tools/testing/selftests/amd-pstate/main.sh
index ae71fe62e3b0..69bf8ea371a5 100755
--- a/tools/testing/selftests/amd-pstate/main.sh
+++ b/tools/testing/selftests/amd-pstate/main.sh
@@ -10,6 +10,7 @@ fi
 
 source basic.sh
 source tbench.sh
+source gitsource.sh
 
 # amd-pstate-ut only run on x86/x86_64 AMD systems.
 ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
@@ -18,6 +19,7 @@ VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
 FUNC=all
 OUTFILE=selftest
 OUTFILE_TBENCH="$OUTFILE.tbench"
+OUTFILE_GIT="$OUTFILE.gitsource"
 
 SYSFS=
 CPUROOT=
@@ -126,6 +128,9 @@ amd_pstate_all()
 
 	# tbench
 	amd_pstate_tbench
+
+	# gitsource
+	amd_pstate_gitsource
 }
 
 helpme()
@@ -135,7 +140,8 @@ helpme()
 	[-o <output-file-for-dump>]
 	[-c <all: All testing,
 	     basic: Basic testing,
-	     tbench: Tbench testing.>]
+	     tbench: Tbench testing,
+	     gitsource: Gitsource testing.>]
 	[-t <tbench time limit>]
 	[-p <tbench process number>]
 	[-l <loop times for tbench]
@@ -153,7 +159,7 @@ parse_arguments()
 				helpme
 				;;
 
-			c) # --func_type (Function to perform: basic, tbench (default: all))
+			c) # --func_type (Function to perform: basic, tbench, gitsource (default: all))
 				FUNC=$OPTARG
 				;;
 
@@ -169,7 +175,7 @@ parse_arguments()
 				PROCESS_NUM=$OPTARG
 				;;
 
-			l) # --tbench-loop-times
+			l) # --tbench/gitsource-loop-times
 				LOOP_TIMES=$OPTARG
 				;;
 
@@ -259,6 +265,10 @@ do_test()
 		amd_pstate_tbench
 		;;
 
+		"gitsource")
+		amd_pstate_gitsource
+		;;
+
 		*)
 		echo "Invalid [-f] function type"
 		helpme
@@ -283,6 +293,11 @@ pre_clear_dumps()
 		rm -rf $OUTFILE_TBENCH*
 		;;
 
+		"gitsource")
+		rm -rf $OUTFILE.log
+		rm -rf $OUTFILE.backup_governor.log
+		rm -rf $OUTFILE_GIT*
+		;;
 	esac
 }
 
-- 
2.25.1

