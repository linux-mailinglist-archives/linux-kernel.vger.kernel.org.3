Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3B589782
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbiHDFsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiHDFrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:47:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5CB61132;
        Wed,  3 Aug 2022 22:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELegaB4/zGtQ1jBcYUE9i5E+JemnJeaWY+2j4gZOzHbUe1j3fgvluh9aIY+4epQkkOda5Ql+17+2GMcK8v3HmNOkxIFFrVOzdtBiv/7Agw3tkUnMdIEQIDKUwFSaT3RkwtJXLAcokD5UfrqpLClusqy6AIvbe5iQpIso9LNzZ36FdbuwLnmjMm+2efBRwXZXdsoH8VFK4TYduxcfzhJKQ22YrS4sJjsnjPB5DT7d/2JdCrKGYSIX9hXeeWmB47Cg/fxi+jiKK6iMpnv5fgnlalaNvknx2n+BT4PmaAmQRWuzoyzvPavBhfMiG5iPg+1txy96LbXXb00HJ1mRIzpJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/kFjcpOSMeIWVCCzoMChAjpEKgFHcU50mKz4PTCuF0=;
 b=lE6gzV8PNV5Xlr9IkK6ldkJMhKR29TpZejXpqum0NbggF7YvMmnTDmTa7kp73DMtaX4BXNk0gnQK4lyKdWyMsMNRieR/hAC1KtRrucfFC5lnRYtBIo4gAdNGp/feFa3nx7ixlvvhAkJbIBk4c9/2odvhVbpwtBYNsMiBqIKhoEQ4wNuulM/oFjmc36zXMnWuxVIa75mM3yKduSHHNOtGGbLVPEfpO2M7hE3iYIXz9k63EetKCKvTBEPiVvyoojtLVEMftHKiqJJ/okCIcWaWClJR76NpL2YWwDP6VqVJMyIqPI3pPK0oFtPdd0rJ1eRxb4Xc7efgijFw0Pcqw/hD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/kFjcpOSMeIWVCCzoMChAjpEKgFHcU50mKz4PTCuF0=;
 b=fbXg/XYB3a5/twsg4KswM8ra36L8ujd/WvVkVa2GRPTWT10/qydrkM84z5KkM5xycWVXECZpqjuRityKI/FzzwfWp165BfOEeEx0Sve6YRSOkC3HyjRvqrxgHDuBn/CliFM/fHgEPc8y7WCJ471LPcSxVbMDLqTq4EKvkIfakVY=
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by BN8PR12MB3251.namprd12.prod.outlook.com (2603:10b6:408:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 05:47:24 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::b3) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 4 Aug 2022 05:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 05:47:23 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 00:47:14 -0500
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
Subject: [PATCH V2 3/4] selftests: amd-pstate: Trigger gitsource benchmark and test cpus
Date:   Thu, 4 Aug 2022 13:44:13 +0800
Message-ID: <20220804054414.1510764-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804054414.1510764-1-li.meng@amd.com>
References: <20220804054414.1510764-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 148e770c-6416-4262-b491-08da75dcce43
X-MS-TrafficTypeDiagnostic: BN8PR12MB3251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTzmS8hB1r+Yq2R1yCKQQzVGpFqzmPQVKzNdrMzg1HHGl4PSG66y+kqrjJCbI8kV7EIECGl8CLXPkasDJpXPRWpnQASXrv+9g3uCkKUqMwpsXjTevvGoAIDJr43ZvD1zyr4+1J9+LBluGbK0jhm9QmIX+5BMP62b/6Ei2HrAsvId1zSWHfM3W4mvhl2OK/lGrKn1P69WEjGutB9gYHSTofpMdbpsJ+ct2iJ2Hg4SsasHetvDUNK5j8VjOSwGXbt5CdbsyUm0Y0ZyoXeSJd1jTVHzCqZ/te4KcRhq4DRubGUo6huWDC0vhZdtcEPKqjeAI/WiD2uH+9QwzafRi23avviL1aUeU0fQxyOEbKVVtWGhF45GrUO7LUUutpGgLWFIRwBuP8B45J3W533v3irfBhfURnfzpjrzMTkIfFZGCm8j75KnKVWd2H/MK9U0UfvXA7hB7HkJCITlJfwb030fVxIFm8IVuBpAkj+2Xojg6QocrAIRfGKokT7Hper5dMAx5O5aM6LpVHrfJ106B8PbiOqGs3s0OtcK4qYuH+8Bwx1SXzEQcxHkVlVMJF4OrODuYzyCNsg61HxBPv3j1sQksUflsqrW4wv0QGmHczVVV7cJ2alzrTRhWLueVtYvZFN/XNsgoucQ597WPBppNWCBKqmAg75uU5MwalDGJ/DVyTxr5CL5qQtr5zqtDyw9lqCRxXjVEXNmRTZLp9muKAXmokw46LMGKTm2DDW3biPRVvSHLl6qmFazpa55tITjY+pak1MBK5kPRm2CJVb1p/8GPnPhOupIbYVxHiXH0akjnAfk2RNwaT9J3EZ3LPxqB7mYptfkmQ3DQlI96UNtmhEPxrR5/aS163xa6i4BCZpFPkk9UVv1Sh/iJZ+scqwRNov9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(41300700001)(5660300002)(2906002)(36756003)(356005)(81166007)(82310400005)(40460700003)(83380400001)(30864003)(478600001)(110136005)(2616005)(54906003)(7696005)(8936002)(82740400003)(70206006)(36860700001)(1076003)(4326008)(186003)(8676002)(16526019)(316002)(47076005)(426003)(336012)(26005)(40480700001)(70586007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 05:47:23.9207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 148e770c-6416-4262-b491-08da75dcce43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3251
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../testing/selftests/amd-pstate/gitsource.sh | 345 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/run.sh     |  26 +-
 3 files changed, 367 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/amd-pstate/gitsource.sh

diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
index cac8dedb7226..5f195ee756d6 100644
--- a/tools/testing/selftests/amd-pstate/Makefile
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -13,6 +13,6 @@ TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
 endif
 
 TEST_PROGS := run.sh
-TEST_FILES := basic.sh tbench.sh
+TEST_FILES := basic.sh tbench.sh gitsource.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
new file mode 100755
index 000000000000..3d5cd465ad43
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/gitsource.sh
@@ -0,0 +1,345 @@
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
+# clear some special lines
+clear_csv_gitsource()
+{
+	if [ -f $OUTFILE_GIT.csv ]; then
+		sed -i '/Comprison(%)/d' $OUTFILE_GIT.csv
+		sed -i "/$(scaling_name)/d" $OUTFILE_GIT.csv
+	fi
+}
+
+# find string $1 in file csv and get the number of lines
+get_lines_csv_gitsource()
+{
+	if [ -f $OUTFILE_GIT.csv ]; then
+		return `grep -c "$1" $OUTFILE_GIT.csv`
+	else
+		return 0
+	fi
+}
+
+pre_clear_gitsource()
+{
+	post_clear_gitsource
+	rm -rf gitsource_*.png
+	clear_csv_gitsource
+}
+
+post_clear_gitsource()
+{
+	rm -rf results/tracer-gitsource*
+	rm -rf $OUTFILE_GIT*.log
+	rm -rf $OUTFILE_GIT*.result
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
+	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
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
+	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
+	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#        1/t     1/t     1
+	#       ----- = ----- = ---
+	#         P      E/t     E
+	# with unit given by 1 per joule.
+	ppw=`echo "scale=9;1/$en_sum" | bc | awk '{printf "%.9f", $0}'`
+	printf "Gitsource-$1-#$2 performance per watt(1/J): $ppw\n" | tee -a $OUTFILE_GIT.result
+	printf "\n" | tee -a $OUTFILE_GIT.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_gitsource "$driver_name-$1" $2 $avg_des_perf $avg_freq $avg_load $time_sum $en_sum $ppw
+}
+
+# $1: governor
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
+	# Permance is the number of run gitsource per second, denoted 1/t, where 1 is the number of run gitsource in t
+	# senconds. It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
+	# and t is time measured in seconds(s). This means that performance per watt becomes
+	#        1/t     1/t     1
+	#       ----- = ----- = ---
+	#         P      E/t     E
+	# with unit given by 1 per joule.
+	ppw=`echo "scale=9;1/$avg_en" | bc | awk '{printf "%.9f", $0}'`
+	printf "Gitsource-$1 performance per watt(1/J): $ppw\n" | tee -a $OUTFILE_GIT.result
+	printf "\n" | tee -a $OUTFILE_GIT.result
+
+	driver_name=`echo $(scaling_name)`
+	store_csv_gitsource "$driver_name-$1" "Average" $avg_des_perf $avg_freq $avg_load $avg_time $avg_en $ppw
+}
+
+# $1: base scaling_driver $2: base governor $3: comparison scaling_driver $4: comparison governor
+__calc_comp_gitsource()
+{
+	base=`grep "$1-$2" $OUTFILE_GIT.csv | grep "Average"`
+	comp=`grep "$3-$4" $OUTFILE_GIT.csv | grep "Average"`
+
+	if [ -n "$base" -a -n "$comp" ]; then
+		printf "\n==================================================\n" | tee -a $OUTFILE_GIT.result
+		printf "Gitsource comparison $1-$2 VS $3-$4" | tee -a $OUTFILE_GIT.result
+		printf "\n==================================================\n" | tee -a $OUTFILE_GIT.result
+
+		# get the base values
+		des_perf_base=`echo "$base" | awk '{print $3}' | sed s/,//`
+		freq_base=`echo "$base" | awk '{print $4}' | sed s/,//`
+		load_base=`echo "$base" | awk '{print $5}' | sed s/,//`
+		time_base=`echo "$base" | awk '{print $6}' | sed s/,//`
+		energy_base=`echo "$base" | awk '{print $7}' | sed s/,//`
+		ppw_base=`echo "$base" | awk '{print $8}' | sed s/,//`
+
+		# get the comparison values
+		des_perf_comp=`echo "$comp" | awk '{print $3}' | sed s/,//`
+		freq_comp=`echo "$comp" | awk '{print $4}' | sed s/,//`
+		load_comp=`echo "$comp" | awk '{print $5}' | sed s/,//`
+		time_comp=`echo "$comp" | awk '{print $6}' | sed s/,//`
+		energy_comp=`echo "$comp" | awk '{print $7}' | sed s/,//`
+		ppw_comp=`echo "$comp" | awk '{print $8}' | sed s/,//`
+
+		# compare the base and comp values
+		des_perf_drop=`echo "scale=4;($des_perf_comp-$des_perf_base)*100/$des_perf_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 des perf base: $des_perf_base comprison: $des_perf_comp percent: $des_perf_drop\n" | tee -a $OUTFILE_GIT.result
+
+		freq_drop=`echo "scale=4;($freq_comp-$freq_base)*100/$freq_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 freq base: $freq_base comprison: $freq_comp percent: $freq_drop\n" | tee -a $OUTFILE_GIT.result
+
+		load_drop=`echo "scale=4;($load_comp-$load_base)*100/$load_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 load base: $load_base comprison: $load_comp percent: $load_drop\n" | tee -a $OUTFILE_GIT.result
+
+		time_drop=`echo "scale=4;($time_comp-$time_base)*100/$time_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 perf base: $time_base comprison: $time_comp percent: $time_drop\n" | tee -a $OUTFILE_GIT.result
+
+		energy_drop=`echo "scale=4;($energy_comp-$energy_base)*100/$energy_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 energy base: $energy_base comprison: $energy_comp percent: $energy_drop\n" | tee -a $OUTFILE_GIT.result
+
+		ppw_drop=`echo "scale=4;($ppw_comp-$ppw_base)*100/$ppw_base" | bc | awk '{printf "%.4f", $0}'`
+		printf "Gitsource-$1 performance per watt base: $ppw_base comprison: $ppw_comp percent: $ppw_drop\n" | tee -a $OUTFILE_GIT.result
+		printf "\n" | tee -a $OUTFILE_GIT.result
+
+		store_csv_gitsource "$1-$2 VS $3-$4" "Comprison(%)" "$des_perf_drop" "$freq_drop" "$load_drop" "$time_drop" "$energy_drop" "$ppw_drop"
+	fi
+}
+
+# calculate the comparison(%)
+calc_comp_gitsource()
+{
+	# acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil
+	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[0]} ${all_scaling_names[0]} ${gitsource_governors[1]}
+
+	# amd-pstate-ondemand VS amd-pstate-schedutil
+	__calc_comp_gitsource ${all_scaling_names[1]} ${gitsource_governors[0]} ${all_scaling_names[1]} ${gitsource_governors[1]}
+
+	# acpi-cpufreq-ondemand VS amd-pstate-ondemand
+	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[0]} ${all_scaling_names[1]} ${gitsource_governors[0]}
+
+	# acpi-cpufreq-schedutil VS amd-pstate-schedutil
+	__calc_comp_gitsource ${all_scaling_names[0]} ${gitsource_governors[1]} ${all_scaling_names[1]} ${gitsource_governors[1]}
+}
+
+# $1: file_name, $2: title, $3: ylable, $4: column
+plot_png_gitsource()
+{
+	# all_scaling_names[1] all_scaling_names[0] flag
+	#    amd-pstate           acpi-cpufreq
+	#         N                   N             0
+	#         N                   Y             1
+	#         Y                   N             2
+	#         Y                   Y             3
+	ret=`grep -c "${all_scaling_names[1]}" $OUTFILE_GIT.csv`
+	if [ $ret -eq 0 ]; then
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_GIT.csv`
+		if [ $ret -eq 0 ]; then
+			flag=0
+		else
+			flag=1
+		fi
+	else
+		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_GIT.csv`
+		if [ $ret -eq 0 ]; then
+			flag=2
+		else
+			flag=3
+		fi
+	fi
+
+	gnuplot << EOF
+		set term png
+		set output "$1"
+
+		set title "$2"
+		set xlabel "Test Cycles (round)"
+		set ylabel "$3"
+
+		set grid
+		set style data histogram
+		set style fill solid 0.5 border
+		set boxwidth 0.8
+
+		if ($flag == 1) {
+			plot \
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[0]}", \
+			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[1]}"
+		} else {
+			if ($flag == 2) {
+				plot \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[0]}", \
+				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[1]}"
+			} else {
+				if ($flag == 3 ) {
+					plot \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${gitsource_governors[1]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[0]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[0]}", \
+					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${gitsource_governors[1]}/p' $OUTFILE_GIT.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${gitsource_governors[1]}"
+				}
+			}
+		}
+		quit
+EOF
+}
+
+amd_pstate_gitsource()
+{
+	printf "\n---------------------------------------------\n"
+	printf "*** Running gitsource                     ***"
+	printf "\n---------------------------------------------\n"
+
+	pre_clear_gitsource
+
+	install_gitsource
+
+	get_lines_csv_gitsource "Governor"
+	if [ $? -eq 0 ]; then
+		# add titles and unit for csv file
+		store_csv_gitsource "Governor" "Round" "Des-perf" "Freq" "Load" "Time" "Energy" "Performance Per Watt"
+		store_csv_gitsource "Unit" "" "" "GHz" "" "s" "J" "1/J"
+	fi
+
+	for_each_policy backup_governor
+	for governor in ${gitsource_governors[*]} ; do
+		printf "\nSpecified governor is $governor\n\n"
+		for_each_policy switch_governor $governor
+		loop_gitsource $governor
+		gather_gitsource $governor
+	done
+	restore_governor
+
+	plot_png_gitsource "gitsouce_time.png" "Gitsource Benchmark Time" "Time (s)" 6
+	plot_png_gitsource "gitsource_energy.png" "Gitsource Benchmark Energy" "Energy (J)" 7
+	plot_png_gitsource "gitsource_ppw.png" "Gitsource Benchmark Performance Per Watt" "Performance Per Watt (1/J)" 8
+
+	calc_comp_gitsource
+
+	post_clear_gitsource
+}
diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
index aa264e96a6e6..ccfceee8b13f 100755
--- a/tools/testing/selftests/amd-pstate/run.sh
+++ b/tools/testing/selftests/amd-pstate/run.sh
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
@@ -139,6 +141,9 @@ amd_pstate_all()
 
 	# tbench
 	amd_pstate_tbench
+
+	# gitsource
+	amd_pstate_gitsource
 }
 
 helpme()
@@ -148,7 +153,8 @@ helpme()
 	[-o <output-file-for-dump>]
 	[-c <all: All testing,
 	     basic: Basic testing,
-	     tbench: Tbench testing.>]
+	     tbench: Tbench testing,
+	     gitsource: Gitsource testing.>]
 	[-t <tbench time limit>]
 	[-p <tbench process number>]
 	[-l <loop times for tbench>]
@@ -167,7 +173,7 @@ parse_arguments()
 				helpme
 				;;
 
-			c) # --func_type (Function to perform: basic, tbench (default: all))
+			c) # --func_type (Function to perform: basic, tbench, gitsource (default: all))
 				FUNC=$OPTARG
 				;;
 
@@ -183,7 +189,7 @@ parse_arguments()
 				PROCESS_NUM=$OPTARG
 				;;
 
-			l) # --tbench-loop-times
+			l) # --tbench/gitsource-loop-times
 				LOOP_TIMES=$OPTARG
 				;;
 
@@ -224,9 +230,9 @@ prerequisite()
 		fi
 	else
 		case "$FUNC" in
-			"tbench")
+			"tbench" | "gitsource")
 				if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
-					echo "$0 # Skipped: Comparison test can only run on $COMPARATIVE_TEST driver."
+					echo "$0 # Skipped: Comparison test can only run on $COMPARISON_TEST driver."
 					echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
 					exit $ksft_skip
 				fi
@@ -296,6 +302,10 @@ do_test()
 			amd_pstate_tbench
 			;;
 
+		"gitsource")
+			amd_pstate_gitsource
+			;;
+
 		*)
 			echo "Invalid [-f] function type"
 			helpme
@@ -319,6 +329,12 @@ pre_clear_dumps()
 			rm -rf tbench_*.png
 			;;
 
+		"gitsource")
+			rm -rf $OUTFILE.log
+			rm -rf $OUTFILE.backup_governor.log
+			rm -rf gitsource_*.png
+			;;
+
 		*)
 			;;
 	esac
-- 
2.25.1

