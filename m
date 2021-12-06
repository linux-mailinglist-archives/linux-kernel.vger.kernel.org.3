Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CED1469235
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbhLFJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:23:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240314AbhLFJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:22:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B68Mcwr018083;
        Mon, 6 Dec 2021 09:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WfeT5DQOxs0al1WEuh7Vb8FC2j7czIvygmqgen7+fI8=;
 b=Q2WQu/aTqwq0nvkDGHO56i+YMNvA1LuJ7RjYxYQvwOjZkZRLqZLHqAdSiss1eQX4xn+R
 j7Cu94TdXjSbRy6Ev07jXDGFdbnKuprp+WbER3vgbTdfYB+smizkWHo3HaMyuS8zcqvg
 BwPgXpM/lVmUEbQNC4BChUqNvyGI7CWe4fU7KZjccYEVKtikqQ5ADhbE9uiqI1533NAk
 +TeNMX6dtOokBMA60siv726JMS3Yj4RnTU+umRkrLdFZ2aFYcpcCrf3m/BCG1liyImYu
 3Hnhq/ZvCoOPCI1z4B1klU9LydLNf2O19rslW8jsGxkZ3bhcFXDhANUfOOj0Tg8Mbs/y 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csey2s0ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 09:18:46 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B68Q0eJ025856;
        Mon, 6 Dec 2021 09:18:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3csey2s0e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 09:18:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B69CaP9024600;
        Mon, 6 Dec 2021 09:18:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3cqykhtju8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 09:18:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B69IfXi19136846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 09:18:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20FEAA4065;
        Mon,  6 Dec 2021 09:18:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54D83A405E;
        Mon,  6 Dec 2021 09:18:34 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.39.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 09:18:34 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org, kjain@linux.ibm.com
Subject: [PATCH 2/4] tools/perf: Add new macros for mem_hops field
Date:   Mon,  6 Dec 2021 14:47:47 +0530
Message-Id: <20211206091749.87585-3-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211206091749.87585-1-kjain@linux.ibm.com>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LODHfGWl7sSLbNIDyUeAoldYZfrKqpiW
X-Proofpoint-GUID: -DKKhDggT6iu9rpCNN6ztHOYtU_-S-3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_03,2021-12-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new macros for mem_hops field which can be used to
represent remote-node, socket and board level details.

Currently the code had macro for HOPS_0 which, corresponds
to data coming from another core but same node.
Add new macros for HOPS_1 to HOPS_3 to represent
remote-node, socket and board level data.

Also add corresponding strings in the mem_hops array to
represent mem_hop field data in perf_mem__lvl_scnprintf function

Incase mem_hops field is used, PERF_MEM_LVLNUM field also need
to be set inorder to represent the data source. Hence printing
data source via PERF_MEM_LVL field can be skip in that scenario.

For ex: Encodings for mem_hops fields with L2 cache:

L2                      - local L2
L2 | REMOTE | HOPS_0    - remote core, same node L2
L2 | REMOTE | HOPS_1    - remote node, same socket L2
L2 | REMOTE | HOPS_2    - remote socket, same board L2
L2 | REMOTE | HOPS_3    - remote board L2

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/include/uapi/linux/perf_event.h |  5 ++++-
 tools/perf/util/mem-events.c          | 29 +++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bd8860eeb291..4cd39aaccbe7 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1332,7 +1332,10 @@ union perf_mem_data_src {
 
 /* hop level */
 #define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
-/* 2-7 available */
+#define PERF_MEM_HOPS_1         0x02 /* remote node, same socket */
+#define PERF_MEM_HOPS_2         0x03 /* remote socket, same board */
+#define PERF_MEM_HOPS_3         0x04 /* remote board */
+/* 5-7 available */
 #define PERF_MEM_HOPS_SHIFT	43
 
 #define PERF_MEM_S(a, s) \
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3167b4628b6d..ed0ab838bcc5 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -309,6 +309,9 @@ static const char * const mem_hops[] = {
 	 * to be set with mem_hops field.
 	 */
 	"core, same node",
+	"node, same socket",
+	"socket, same board",
+	"board",
 };
 
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
@@ -316,7 +319,7 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	size_t i, l = 0;
 	u64 m =  PERF_MEM_LVL_NA;
 	u64 hit, miss;
-	int printed;
+	int printed = 0;
 
 	if (mem_info)
 		m  = mem_info->data_src.mem_lvl;
@@ -335,18 +338,22 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 		l += 7;
 	}
 
-	if (mem_info && mem_info->data_src.mem_hops)
+	/*
+	 * Incase mem_hops field is set, we can skip printing data source via
+	 * PERF_MEM_LVL namespace.
+	 */
+	if (mem_info && mem_info->data_src.mem_hops) {
 		l += scnprintf(out + l, sz - l, "%s ", mem_hops[mem_info->data_src.mem_hops]);
-
-	printed = 0;
-	for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
-		if (!(m & 0x1))
-			continue;
-		if (printed++) {
-			strcat(out, " or ");
-			l += 4;
+	} else {
+		for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
+			if (!(m & 0x1))
+				continue;
+			if (printed++) {
+				strcat(out, " or ");
+				l += 4;
+			}
+			l += scnprintf(out + l, sz - l, mem_lvl[i]);
 		}
-		l += scnprintf(out + l, sz - l, mem_lvl[i]);
 	}
 
 	if (mem_info && mem_info->data_src.mem_lvl_num) {
-- 
2.27.0

