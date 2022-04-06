Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B834F6ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiDFUEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiDFUDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:03:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4F60DBA;
        Wed,  6 Apr 2022 10:52:05 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236GESm1030105;
        Wed, 6 Apr 2022 17:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=hWy5I10SyMCKmhD0+kEodm/y+gl5qzddelF/Lh2wtH0=;
 b=gpCaxE2L4xXcID7HaSzkpTPuYGz8qFLUrwDxZg5+5F0pcGcIWZJaKndpwofexWytg+XR
 OCfsHHmyh6S+9NRP8dJKBQ8DR/bUU2HAF68vPoWSE95rJNqjq+6KnoWzSKqurm17PiLw
 VCTZmocNtP0TJn40CdQslYfJSWL1gTzaBDxHj87l514TBUeTWvNtMvBJIoTySaLP0u4o
 1Tc+qxMpacYBnIPJHRZkqMXPLYCOkCNoq2l3n5H7eP0nz3GQGNkNoHFuOQavbwxm8/wY
 TxslO25B3idxtkwMfGy4Qmj211X7M20UC4aghIuv6P6Ra6fi4U+XlYlWT9/wfdxXa5Wv 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f95epwyq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:51:53 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 236Hgf9d011564;
        Wed, 6 Apr 2022 17:51:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f95epwypm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:51:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236Hhi6M019355;
        Wed, 6 Apr 2022 17:51:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhr7k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:51:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236HpllX43057440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 17:51:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAE814C04A;
        Wed,  6 Apr 2022 17:51:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C8F54C040;
        Wed,  6 Apr 2022 17:51:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.90.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Apr 2022 17:51:40 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        irogers@google.com
Subject: [PATCH v2 4/4] tools/perf: Fix perf bench numa testcase to check if CPU used to bind task is online
Date:   Wed,  6 Apr 2022 23:21:13 +0530
Message-Id: <20220406175113.87881-5-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
References: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z94Fa6rh7GGPCk_QPb0VIRZWRQ5zXAZw
X-Proofpoint-ORIG-GUID: 5zuHFViFxtoaVLPnUmFfj3zwISZojtkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_09,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf numa bench test fails with error:

Testcase:
./perf bench numa mem -p 2 -t 1 -P 1024 -C 0,8 -M 1,0 -s 20 -zZq
--thp  1 --no-data_rand_walk

Failure snippet:
<<>>
 Running 'numa/mem' benchmark:

 # Running main, "perf bench numa numa-mem -p 2 -t 1 -P 1024 -C 0,8
-M 1,0 -s 20 -zZq --thp 1 --no-data_rand_walk"

perf: bench/numa.c:333: bind_to_cpumask: Assertion `!(ret)' failed.
<<>>

The Testcases uses CPU’s 0 and 8. In function "parse_setup_cpu_list",
There is check to see if cpu number is greater than max cpu’s possible
in the system ie via "if (bind_cpu_0 >= g->p.nr_cpus ||
bind_cpu_1 >= g->p.nr_cpus) {". But it could happen that system has
say 48 CPU’s, but only number of online CPU’s is 0-7. Other CPU’s
are offlined. Since "g->p.nr_cpus" is 48, so function will go ahead
and set bit for CPU 8 also in cpumask ( td->bind_cpumask).

bind_to_cpumask function is called to set affinity using
sched_setaffinity and the cpumask. Since the CPU8 is not present,
set affinity will fail here with EINVAL. Fix this issue by adding a
check to make sure that, CPU’s provided in the input argument values
are online before proceeding further and skip the test. For this,
include new helper function "is_cpu_online" in
"tools/perf/util/header.c".

Since "BIT(x)" definition will get included from header.h, remove
that from bench/numa.c

Tested-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
---
 tools/perf/bench/numa.c  |  8 ++++++--
 tools/perf/util/header.c | 43 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h |  1 +
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 29e41e32bd88..7992d79b3e41 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -34,6 +34,7 @@
 #include <linux/numa.h>
 #include <linux/zalloc.h>
 
+#include "../util/header.h"
 #include <numa.h>
 #include <numaif.h>
 
@@ -616,6 +617,11 @@ static int parse_setup_cpu_list(void)
 			return -1;
 		}
 
+		if (is_cpu_online(bind_cpu_0) != 1 || is_cpu_online(bind_cpu_1) != 1) {
+			printf("\nTest not applicable, bind_cpu_0 or bind_cpu_1 is offline\n");
+			return -1;
+		}
+
 		BUG_ON(bind_cpu_0 < 0 || bind_cpu_1 < 0);
 		BUG_ON(bind_cpu_0 > bind_cpu_1);
 
@@ -786,8 +792,6 @@ static int parse_nodes_opt(const struct option *opt __maybe_unused,
 	return parse_node_list(arg);
 }
 
-#define BIT(x) (1ul << x)
-
 static inline uint32_t lfsr_32(uint32_t lfsr)
 {
 	const uint32_t taps = BIT(1) | BIT(5) | BIT(6) | BIT(31);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 6da12e522edc..3f5fcf5d4b3f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -983,6 +983,49 @@ static int write_dir_format(struct feat_fd *ff,
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
+#define SYSFS "/sys/devices/system/cpu/"
+
+/*
+ * Check whether a CPU is online
+ *
+ * Returns:
+ *     1 -> if CPU is online
+ *     0 -> if CPU is offline
+ *    -1 -> error case
+ */
+int is_cpu_online(unsigned int cpu)
+{
+	char sysfs_cpu[255];
+	char buf[255];
+	struct stat statbuf;
+	size_t len;
+	int fd;
+
+	snprintf(sysfs_cpu, sizeof(sysfs_cpu), SYSFS "cpu%u", cpu);
+
+	if (stat(sysfs_cpu, &statbuf) != 0)
+		return 0;
+
+	/*
+	 * Check if /sys/devices/system/cpu/cpux/online file
+	 * exists. In kernels without CONFIG_HOTPLUG_CPU, this
+	 * file won't exist.
+	 */
+	snprintf(sysfs_cpu, sizeof(sysfs_cpu), SYSFS "cpu%u/online", cpu);
+	if (stat(sysfs_cpu, &statbuf) != 0)
+		return 1;
+
+	fd = open(sysfs_cpu, O_RDONLY);
+	if (fd == -1)
+		return -1;
+
+	len = read(fd, buf, sizeof(buf) - 1);
+	buf[len] = '\0';
+	close(fd);
+
+	return strtoul(buf, NULL, 16);
+}
+
 #ifdef HAVE_LIBBPF_SUPPORT
 static int write_bpf_prog_info(struct feat_fd *ff,
 			       struct evlist *evlist __maybe_unused)
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index c9e3265832d9..0eb4bc29a5a4 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -158,6 +158,7 @@ int do_write(struct feat_fd *fd, const void *buf, size_t size);
 int write_padded(struct feat_fd *fd, const void *bf,
 		 size_t count, size_t count_aligned);
 
+int is_cpu_online(unsigned int cpu);
 /*
  * arch specific callback
  */
-- 
2.35.1

