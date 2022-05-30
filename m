Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49536537981
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiE3K5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiE3K5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:57:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B96958A;
        Mon, 30 May 2022 03:57:14 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U9jtd4010864;
        Mon, 30 May 2022 10:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=9oWQu1XE6sQcMDnlyn74e52H/lDkK6trltFDMtRDOsI=;
 b=kDxkFjhEJn9PNmq11gGKPosKPJoumw1NWMbLTVTHAYRLd5oaKBWJZzuuq4Hry+KhBlQi
 8U+plELKDTnuVhz4n4j8cjehKZ3WSYfX0Ky1nv5pHSKmO0Wv2L9CRjhZuPQZ9Un7KX1w
 F6WCmlUJjpENnBvEN6WrLSsqIuicHF+g6BYi6LuKrJVw0DrnYc8MMDq53wTNzRebR8hI
 cu1Rf78aXnZixf8aTxQjGZZqKPaCwZOJwPLW67FXQIcw8JO60gRDKq9uF/nwZ4biHGhY
 hVEY8tVTx06Pfrmg9La4XjYlOOqiq5Wnm2osIMhpNlV2Z+8bvF7FG0gNbrkG5DljmtGf OA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gcuk1181m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 10:57:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24UAoq9Y020016;
        Mon, 30 May 2022 10:57:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3gbc7h2kg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 10:57:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24UAv3du17760760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 10:57:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDC9BA4040;
        Mon, 30 May 2022 10:57:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D4F5A4051;
        Mon, 30 May 2022 10:57:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 May 2022 10:57:02 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 1/2] perf list: Add IBM z16 event description for s390
Date:   Mon, 30 May 2022 12:56:56 +0200
Message-Id: <20220530105657.2700635-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PbXdOO1rzhFSVXAay5tlj7v4YmQ68S8F
X-Proofpoint-GUID: PbXdOO1rzhFSVXAay5tlj7v4YmQ68S8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_03,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update IBM z16 counter description using document SA23-2260-07:
"The Load-Program-Parameter and the CPU-Measurement Facilities"
released in May, 2022, to include counter definitions for IBM z16
counter sets:
  * Basic counter set
  * Problem/user counter set
  * Crypto counter set

Use document SA23-2261-07:
"The CPU-Measurement Facility Extended Counters Definition
 for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15 and z16"
released on April 29, 2022 to include counter definitions for IBM z16
  * Extended counter set
  * MT-Diagnostic counter set

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z16/basic.json    |  58 +++
 .../pmu-events/arch/s390/cf_z16/crypto6.json  | 142 +++++
 .../pmu-events/arch/s390/cf_z16/extended.json | 492 ++++++++++++++++++
 .../arch/s390/cf_z16/transaction.json         |   7 +
 tools/perf/pmu-events/arch/s390/mapfile.csv   |   1 +
 5 files changed, 700 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/crypto6.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/transaction.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/basic.json b/tools/perf/pmu-events/arch/s390/cf_z16/basic.json
new file mode 100644
index 000000000000..1023d47028ce
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/basic.json
@@ -0,0 +1,58 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "0",
+		"EventName": "CPU_CYCLES",
+		"BriefDescription": "Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles, excluding the number of cycles while the CPU is in the wait state."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "1",
+		"EventName": "INSTRUCTIONS",
+		"BriefDescription": "Instruction Count",
+		"PublicDescription": "This counter counts the total number of instructions executed by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "2",
+		"EventName": "L1I_DIR_WRITES",
+		"BriefDescription": "Level-1 I-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 instruction-cache or unified-cache directory writes."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "3",
+		"EventName": "L1I_PENALTY_CYCLES",
+		"BriefDescription": "Level-1 I-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of cache penalty cycles for level-1 instruction cache or unified cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "4",
+		"EventName": "L1D_DIR_WRITES",
+		"BriefDescription": "Level-1 D-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 data-cache directory writes."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "5",
+		"EventName": "L1D_PENALTY_CYCLES",
+		"BriefDescription": "Level-1 D-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of cache penalty cycles for level-1 data cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "32",
+		"EventName": "PROBLEM_STATE_CPU_CYCLES",
+		"BriefDescription": "Problem-State Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the CPU is in the problem state, excluding the number of cycles while the CPU is in the wait state."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "33",
+		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
+		"BriefDescription": "Problem-State Instruction Count",
+		"PublicDescription": "This counter counts the total number of instructions executed by the CPU while in the problem state."
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z16/crypto6.json
new file mode 100644
index 000000000000..8b4380b8e489
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/crypto6.json
@@ -0,0 +1,142 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "64",
+		"EventName": "PRNG_FUNCTIONS",
+		"BriefDescription": "PRNG Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "65",
+		"EventName": "PRNG_CYCLES",
+		"BriefDescription": "PRNG Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES/SHA coprocessor is busy performing the pseudorandom- number-generation functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "66",
+		"EventName": "PRNG_BLOCKED_FUNCTIONS",
+		"BriefDescription": "PRNG Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions that are issued by the CPU and are blocked because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "67",
+		"EventName": "PRNG_BLOCKED_CYCLES",
+		"BriefDescription": "PRNG Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the pseudorandom-number-generation functions issued by the CPU because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "68",
+		"EventName": "SHA_FUNCTIONS",
+		"BriefDescription": "SHA Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "69",
+		"EventName": "SHA_CYCLES",
+		"BriefDescription": "SHA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "70",
+		"EventName": "SHA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "SHA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "71",
+		"EventName": "SHA_BLOCKED_CYCLES",
+		"BriefDescription": "SHA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "72",
+		"EventName": "DEA_FUNCTIONS",
+		"BriefDescription": "DEA Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "73",
+		"EventName": "DEA_CYCLES",
+		"BriefDescription": "DEA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "74",
+		"EventName": "DEA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "DEA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "75",
+		"EventName": "DEA_BLOCKED_CYCLES",
+		"BriefDescription": "DEA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "76",
+		"EventName": "AES_FUNCTIONS",
+		"BriefDescription": "AES Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "77",
+		"EventName": "AES_CYCLES",
+		"BriefDescription": "AES Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "78",
+		"EventName": "AES_BLOCKED_FUNCTIONS",
+		"BriefDescription": "AES Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "79",
+		"EventName": "AES_BLOCKED_CYCLES",
+		"BriefDescription": "AES Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "80",
+		"EventName": "ECC_FUNCTION_COUNT",
+		"BriefDescription": "ECC Function Count",
+		"PublicDescription": "This counter counts the total number of the elliptic-curve cryptography (ECC) functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "81",
+		"EventName": "ECC_CYCLES_COUNT",
+		"BriefDescription": "ECC Cycles Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the ECC coprocessor is busy performing the elliptic-curve cryptography (ECC) functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "82",
+		"EventName": "ECC_BLOCKED_FUNCTION_COUNT",
+		"BriefDescription": "Ecc Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the elliptic-curve cryptography (ECC) functions that are issued by the CPU and are blocked because the ECC coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "83",
+		"EventName": "ECC_BLOCKED_CYCLES_COUNT",
+		"BriefDescription": "ECC Blocked Cycles Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the elliptic-curve cryptography (ECC) functions issued by the CPU because the ECC coprocessor is busy performing a function issued by another CPU."
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
new file mode 100644
index 000000000000..c306190fc06f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
@@ -0,0 +1,492 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "128",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "129",
+		"EventName": "DTLB2_WRITES",
+		"BriefDescription": "DTLB2 Writes",
+		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the Level-1 Data cache. This is a replacement for what was provided for the DTLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "130",
+		"EventName": "DTLB2_MISSES",
+		"BriefDescription": "DTLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the Level-1 Data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle. This is a replacement for what was provided for the DTLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "131",
+		"EventName": "CRSTE_1MB_WRITES",
+		"BriefDescription": "One Megabyte CRSTE writes",
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "132",
+		"EventName": "DTLB2_GPAGE_WRITES",
+		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
+		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "134",
+		"EventName": "ITLB2_WRITES",
+		"BriefDescription": "ITLB2 Writes",
+		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache. This is a replacement for what was provided for the ITLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "135",
+		"EventName": "ITLB2_MISSES",
+		"BriefDescription": "ITLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the Level-1 Instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle. This is a replacement for what was provided for the ITLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "137",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 Page Table Entry Writes",
+		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "138",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 Combined Region and Segment Entry Writes",
+		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "139",
+		"EventName": "TLB2_ENGINES_BUSY",
+		"BriefDescription": "TLB2 Engines Busy",
+		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "140",
+		"EventName": "TX_C_TEND",
+		"BriefDescription": "Completed TEND instructions in constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "141",
+		"EventName": "TX_NC_TEND",
+		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "143",
+		"EventName": "L1C_TLB2_MISSES",
+		"BriefDescription": "L1C TLB2 Misses",
+		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "145",
+		"EventName": "DCW_REQ",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "146",
+		"EventName": "DCW_REQ_IV",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "147",
+		"EventName": "DCW_REQ_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "148",
+		"EventName": "DCW_REQ_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "149",
+		"EventName": "DCW_ON_CHIP",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "150",
+		"EventName": "DCW_ON_CHIP_IV",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "151",
+		"EventName": "DCW_ON_CHIP_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "152",
+		"EventName": "DCW_ON_CHIP_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "153",
+		"EventName": "DCW_ON_MODULE",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Module Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Module Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "154",
+		"EventName": "DCW_ON_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Drawer Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "155",
+		"EventName": "DCW_OFF_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Off-Drawer Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "156",
+		"EventName": "DCW_ON_CHIP_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip Memory",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "157",
+		"EventName": "DCW_ON_MODULE_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Module Memory",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Module memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "158",
+		"EventName": "DCW_ON_DRAWER_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Drawer Memory",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "159",
+		"EventName": "DCW_OFF_DRAWER_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Off-Drawer Memory",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "160",
+		"EventName": "IDCW_ON_MODULE_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "161",
+		"EventName": "IDCW_ON_MODULE_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory Cache with Chip Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache using chip horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "162",
+		"EventName": "IDCW_ON_MODULE_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory Cache with Drawer Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "163",
+		"EventName": "IDCW_ON_DRAWER_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "164",
+		"EventName": "IDCW_ON_DRAWER_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer Cache with Chip Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "165",
+		"EventName": "IDCW_ON_DRAWER_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer Cache with Drawer Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "166",
+		"EventName": "IDCW_OFF_DRAWER_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "167",
+		"EventName": "IDCW_OFF_DRAWER_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer Cache with Chip Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "168",
+		"EventName": "IDCW_OFF_DRAWER_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer Cache with Drawer Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "169",
+		"EventName": "ICW_REQ",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced the requestors Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "170",
+		"EventName": "ICW_REQ_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "171",
+		"EventName": "ICW_REQ_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "172",
+		"EventName": "ICW_REQ_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestor’s Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "173",
+		"EventName": "ICW_ON_CHIP",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "174",
+		"EventName": "ICW_ON_CHIP_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced an On-Chip Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "175",
+		"EventName": "ICW_ON_CHIP_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-2 cache using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "176",
+		"EventName": "ICW_ON_CHIP_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip level 2 cache using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "177",
+		"EventName": "ICW_ON_MODULE",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Module Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "178",
+		"EventName": "ICW_ON_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Drawer Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced an On-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "179",
+		"EventName": "ICW_OFF_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Off-Drawer Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced an Off-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "180",
+		"EventName": "ICW_ON_CHIP_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip Memory",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Chip memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "181",
+		"EventName": "ICW_ON_MODULE_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Module Memory",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Module memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "182",
+		"EventName": "ICW_ON_DRAWER_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Drawer Memory",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "183",
+		"EventName": "ICW_OFF_DRAWER_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Off-Drawer Memory",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "224",
+		"EventName": "BCD_DFP_EXECUTION_SLOTS",
+		"BriefDescription": "Binary Coded Decimal to Decimal Floating Point conversions",
+		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "225",
+		"EventName": "VX_BCD_EXECUTION_SLOTS",
+		"BriefDescription": "Count finished vector arithmetic Binary Coded Decimal instructions",
+		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMP, VMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOP, VCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVD, VCVDG."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "226",
+		"EventName": "DECIMAL_INSTRUCTIONS",
+		"BriefDescription": "Decimal instruction dispatched",
+		"PublicDescription": "Decimal instruction dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "232",
+		"EventName": "LAST_HOST_TRANSLATIONS",
+		"BriefDescription": "Last host translation done",
+		"PublicDescription": "Last Host Translation done"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "244",
+		"EventName": "TX_NC_TABORT",
+		"BriefDescription": "Aborted transactions in unconstrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "245",
+		"EventName": "TX_C_TABORT_NO_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "246",
+		"EventName": "TX_C_TABORT_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "248",
+		"EventName": "DFLT_ACCESS",
+		"BriefDescription": "Cycles CPU spent obtaining access to Deflate unit",
+		"PublicDescription": "Cycles CPU spent obtaining access to Deflate unit"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "253",
+		"EventName": "DFLT_CYCLES",
+		"BriefDescription": "Cycles CPU is using Deflate unit",
+		"PublicDescription": "Cycles CPU is using Deflate unit"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "256",
+		"EventName": "SORTL",
+		"BriefDescription": "Count SORTL instructions",
+		"PublicDescription": "Increments by one for every SORT LISTS instruction executed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "265",
+		"EventName": "DFLT_CC",
+		"BriefDescription": "Increments DEFLATE CONVERSION CALL",
+		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "266",
+		"EventName": "DFLT_CCFINISH",
+		"BriefDescription": "Increments completed DEFLATE CONVERSION CALL",
+		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "267",
+		"EventName": "NNPA_INVOCATIONS",
+		"BriefDescription": "NNPA Total invocations",
+		"PublicDescription": "Increments by one for every Neural Network Processing Assist instruction executed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "268",
+		"EventName": "NNPA_COMPLETIONS",
+		"BriefDescription": "NNPA Total completions",
+		"PublicDescription": "Increments by one for every Neural Network Processing Assist instruction executed that ended in Condition Codes 0, 1 or 2."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "269",
+		"EventName": "NNPA_WAIT_LOCK",
+		"BriefDescription": "Cycles spent obtaining NNPA lock",
+		"PublicDescription": "Cycles CPU spent obtaining access to IBM Z Integrated Accelerator for AI."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "270",
+		"EventName": "NNPA_HOLD_LOCK",
+		"BriefDescription": "Cycles spent holding NNPA lock",
+		"PublicDescription": "Cycles CPU is using IBM Z Integrated Accelerator for AI."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "448",
+		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
+		"BriefDescription": "Cycle count with one thread active",
+		"PublicDescription": "Cycle count with one thread active"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "449",
+		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
+		"BriefDescription": "Cycle count with two threads active",
+		"PublicDescription": "Cycle count with two threads active"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index 61641a3480e0..a918e1af77a5 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -5,3 +5,4 @@ Family-model,Version,Filename,EventType
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
 ^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
+^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core
-- 
2.36.1

