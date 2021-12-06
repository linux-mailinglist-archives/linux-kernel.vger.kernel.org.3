Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9E4469236
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbhLFJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:23:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240335AbhLFJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:23:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B66ia67024611;
        Mon, 6 Dec 2021 09:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j1OqVax9cNTADXgCBChqDMYVMmFtNd9k35FrpvVQRoE=;
 b=VkQDirIjLYp99yU+KocEFYv9YoU7VE3SxSMqJk9Q684YEvFFNPVoJVernTVcNTsvcuvM
 Vu6jfLV+b19CucUhYMKZZ5hg9ROCIob5df5SizD7aQtwqaAjkiL8FQQrS6EWQ5fcAh4E
 zs01qYsH4BjxIU3i/QBaQLFJdx+vniPZ61BcYpWrdAHUd0uJx9I+Uy0hIIKvbWRWVBXt
 q8wWQSZouvJSzA78+sFOkgZQYhqxnZsjQes/43ZG3lId/40+UYy8DqsxmMLDjfiyA0P+
 ECfm8QTZpbDcsVUPuS9u7vZoTxKOlckyRXjNfpahI/JQ8G9QgayvEMPUKb0flBQJmEHX hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cs9nme18q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 09:19:01 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B68wwWY027010;
        Mon, 6 Dec 2021 09:19:01 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cs9nme186-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 09:19:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B69CxDb025467;
        Mon, 6 Dec 2021 09:18:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3cqyyaafr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 09:18:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B69BD6727525546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 09:11:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E940A406D;
        Mon,  6 Dec 2021 09:18:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C6FCA4059;
        Mon,  6 Dec 2021 09:18:44 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.39.249])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 09:18:44 +0000 (GMT)
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
Subject: [PATCH 3/4] powerpc/perf: Add encodings to represent data based on newer composite PERF_MEM_LVLNUM* fields
Date:   Mon,  6 Dec 2021 14:47:48 +0530
Message-Id: <20211206091749.87585-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211206091749.87585-1-kjain@linux.ibm.com>
References: <20211206091749.87585-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2WXUQMUJtj8gRK9mH3oBVDnRCB1y1OQ4
X-Proofpoint-GUID: z0wq5gkXnBT3-BO3u0I-qLzrjW1ZqDEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_03,2021-12-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code represent data coming from L1/L2/L3 cache hits based on
PERF_MEM_LVL_* namespace, which is in the process of deprecation in
the favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_,HOPS_}
fields.

Add data source encodings to represent L1/L2/L3 cache hits based on
newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_,HOPS_} fields for
power10 and older platforms

Result in power9 system without patch changes:

localhost:# ./perf mem report --sort="mem,sym,dso" --stdio
 # Overhead       Samples  Memory access             Symbol                             Shared Object
 # ........  ............  ........................  .................................  ................
 #
    29.51%             1  L2 hit                    [k] perf_event_exec                [kernel.vmlinux]
    27.05%             1  L1 hit                    [k] perf_ctx_unlock                [kernel.vmlinux]
    13.93%             1  L1 hit                    [k] vtime_delta                    [kernel.vmlinux]
    13.11%             1  L1 hit                    [k] prepend_path.isra.11           [kernel.vmlinux]
     8.20%             1  L1 hit                    [.] 00000038.plt_call.__GI_strlen  libc-2.28.so
     8.20%             1  L1 hit                    [k] perf_event_interrupt           [kernel.vmlinux]

Result in power9 system with patch changes:

localhost:# ./perf mem report --sort="mem,sym,dso" --stdio
 # Overhead       Samples  Memory access             Symbol                      Shared Object
 # ........  ............  ........................  ..........................  ................
 #
    36.63%             1  L2 or L2 hit              [k] perf_event_exec         [kernel.vmlinux]
    25.50%             1  L1 or L1 hit              [k] vtime_delta             [kernel.vmlinux]
    13.12%             1  L1 or L1 hit              [k] unmap_region            [kernel.vmlinux]
    12.62%             1  L1 or L1 hit              [k] perf_sample_event_took  [kernel.vmlinux]
     6.93%             1  L1 or L1 hit              [k] perf_ctx_unlock         [kernel.vmlinux]
     5.20%             1  L1 or L1 hit              [.] __memcpy_power7         libc-2.28.so

Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 7ea873ab2e6f..6c6bc8b7d887 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -220,13 +220,13 @@ static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
 		/* Nothing to do */
 		break;
 	case 1:
-		ret = PH(LVL, L1);
+		ret = PH(LVL, L1) | LEVEL(L1) | P(SNOOP, HIT);
 		break;
 	case 2:
-		ret = PH(LVL, L2);
+		ret = PH(LVL, L2) | LEVEL(L2) | P(SNOOP, HIT);
 		break;
 	case 3:
-		ret = PH(LVL, L3);
+		ret = PH(LVL, L3) | LEVEL(L3) | P(SNOOP, HIT);
 		break;
 	case 4:
 		if (sub_idx <= 1)
-- 
2.27.0

