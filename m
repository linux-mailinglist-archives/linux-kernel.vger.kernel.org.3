Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD74F6B10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiDFUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiDFUNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:13:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BB60040;
        Wed,  6 Apr 2022 10:51:48 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236G8xbb037207;
        Wed, 6 Apr 2022 17:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8ndA8c5xFaZF+V8VsYWe9PAD5wDhHWHh/EbZ2rHZ214=;
 b=J1kXuTffGRvpCogdFAz/cqTHO91bY3YQoyGr+A9+PQ8v6/3zKM1PQtzg4VtTOn/0kPW4
 LMhSxSnOhOj0J23TVSHMzoMXz/xuKlsCvb4zBUIH/5XEYvFUTT+SsVdWP1QciSfWhjnL
 7jwpUjwWbX7toY6ELAY0q5bOJ/tqIzVVMVKaSLjC3ZJlfRN++rqS7zhMhKJOI6xUtjgY
 rG/fel4dhD1gOrlRWgXreGOGPehh3yLHMGzSMvhs942GWdREXN4Uwiihm9J85/JpOQaM
 GTKKglXiDfQDeA3gwDfJdBUiPE7xs3nkUy3x6wkAlBFnoRI32ww7MQxAkZfe1pj9j5ty Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f9a9qft54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:51:40 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 236Hgmsd019947;
        Wed, 6 Apr 2022 17:51:39 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f9a9qft4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:51:39 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236HicXB002932;
        Wed, 6 Apr 2022 17:51:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3f6drhpttb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 17:51:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236HpYHG41026038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 17:51:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 487404C040;
        Wed,  6 Apr 2022 17:51:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9C234C046;
        Wed,  6 Apr 2022 17:51:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.90.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Apr 2022 17:51:28 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        irogers@google.com
Subject: [PATCH v2 2/4] tools/perf: Fix perf bench epoll to correct usage of affinity for machines with #CPUs > 1K
Date:   Wed,  6 Apr 2022 23:21:11 +0530
Message-Id: <20220406175113.87881-3-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
References: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OVMkAlE1clseF4f9BcFFTUoXeUPF5OVm
X-Proofpoint-ORIG-GUID: rvF_PSZj4BgcGV26e9u35LXN93EfB-Vi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_09,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf bench epoll testcase fails on systems with CPU's
more than 1K.

Testcase: perf bench epoll all
Result snippet:
<<>>
Run summary [PID 106497]: 1399 threads monitoring on 64 file-descriptors for 8 secs.

perf: pthread_create: No such file or directory
<<>>

In epoll benchmarks (ctl, wait) pthread_create is invoked in do_threads
from respective bench_epoll_*  function. Though the logs shows direct
failure from pthread_create, the actual failure is from  "sched_setaffinity"
returning EINVAL (invalid argument). This happens because the default
mask size in glibc is 1024. To overcome this 1024 CPUs mask size
limitation of cpu_set_t, change the mask size using the CPU_*_S macros.

Patch addresses this by fixing all the epoll benchmarks to use
CPU_ALLOC to allocate cpumask, CPU_ALLOC_SIZE for size, and
CPU_SET_S to set the mask.

Tested-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
---
 tools/perf/bench/epoll-ctl.c  | 25 +++++++++++++++++++------
 tools/perf/bench/epoll-wait.c | 25 +++++++++++++++++++------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 1a17ec83d3c4..91c53f6c6d87 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -222,13 +222,20 @@ static void init_fdmaps(struct worker *w, int pct)
 static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 {
 	pthread_attr_t thread_attr, *attrp = NULL;
-	cpu_set_t cpuset;
+	cpu_set_t *cpuset;
 	unsigned int i, j;
 	int ret = 0;
+	int nrcpus;
+	size_t size;
 
 	if (!noaffinity)
 		pthread_attr_init(&thread_attr);
 
+	nrcpus = perf_cpu_map__nr(cpu);
+	cpuset = CPU_ALLOC(nrcpus);
+	BUG_ON(!cpuset);
+	size = CPU_ALLOC_SIZE(nrcpus);
+
 	for (i = 0; i < nthreads; i++) {
 		struct worker *w = &worker[i];
 
@@ -252,22 +259,28 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 			init_fdmaps(w, 50);
 
 		if (!noaffinity) {
-			CPU_ZERO(&cpuset);
-			CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
+			CPU_ZERO_S(size, cpuset);
+			CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu,
+					size, cpuset);
 
-			ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
-			if (ret)
+			ret = pthread_attr_setaffinity_np(&thread_attr, size, cpuset);
+			if (ret) {
+				CPU_FREE(cpuset);
 				err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
+			}
 
 			attrp = &thread_attr;
 		}
 
 		ret = pthread_create(&w->thread, attrp, workerfn,
 				     (void *)(struct worker *) w);
-		if (ret)
+		if (ret) {
+			CPU_FREE(cpuset);
 			err(EXIT_FAILURE, "pthread_create");
+		}
 	}
 
+	CPU_FREE(cpuset);
 	if (!noaffinity)
 		pthread_attr_destroy(&thread_attr);
 
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 0d1dd8879197..9469a53ffab9 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -291,9 +291,11 @@ static void print_summary(void)
 static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 {
 	pthread_attr_t thread_attr, *attrp = NULL;
-	cpu_set_t cpuset;
+	cpu_set_t *cpuset;
 	unsigned int i, j;
 	int ret = 0, events = EPOLLIN;
+	int nrcpus;
+	size_t size;
 
 	if (oneshot)
 		events |= EPOLLONESHOT;
@@ -306,6 +308,11 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 	if (!noaffinity)
 		pthread_attr_init(&thread_attr);
 
+	nrcpus = perf_cpu_map__nr(cpu);
+	cpuset = CPU_ALLOC(nrcpus);
+	BUG_ON(!cpuset);
+	size = CPU_ALLOC_SIZE(nrcpus);
+
 	for (i = 0; i < nthreads; i++) {
 		struct worker *w = &worker[i];
 
@@ -341,22 +348,28 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 		}
 
 		if (!noaffinity) {
-			CPU_ZERO(&cpuset);
-			CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
+			CPU_ZERO_S(size, cpuset);
+			CPU_SET_S(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu,
+					size, cpuset);
 
-			ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
-			if (ret)
+			ret = pthread_attr_setaffinity_np(&thread_attr, size, cpuset);
+			if (ret) {
+				CPU_FREE(cpuset);
 				err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
+			}
 
 			attrp = &thread_attr;
 		}
 
 		ret = pthread_create(&w->thread, attrp, workerfn,
 				     (void *)(struct worker *) w);
-		if (ret)
+		if (ret) {
+			CPU_FREE(cpuset);
 			err(EXIT_FAILURE, "pthread_create");
+		}
 	}
 
+	CPU_FREE(cpuset);
 	if (!noaffinity)
 		pthread_attr_destroy(&thread_attr);
 
-- 
2.35.1

