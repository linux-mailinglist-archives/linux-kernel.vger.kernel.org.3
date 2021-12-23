Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7928A47E186
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347748AbhLWKfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:35:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50270 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347734AbhLWKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:35:13 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BN8BkS1010398;
        Thu, 23 Dec 2021 10:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KHo7CSJbe6zvntKOZLMbARhA/PTArpW+TfR10DCQYoo=;
 b=R2tywok+RFYGwzE8CouhPf4y6eeDuyA2FrMyUwtzBfqAJlUUBeTFJekHtu7UW3/CtTD3
 8d7PowKgshmyKPu4On5Q34AaEVr5qzKiErdKNPiVys70CWQAxhzhN9fvqpvZW9e1zdHM
 FzMmlwC//fRIwDNcG39rO9NrQ1s1oGqGjAqa6xrdlx/pltrN+3mH5hF9a6L/tVbhBGrB
 XlXwBdJ1vbCbRIJDItEP3AfOmtV/q7gB+gcNuauNt09gYw4HmZfe/FTdEqd4wi2hsWF7
 yT+FS9BvAmhTFZlyDDPuO3Z5H2gjFy1cL71UMsei5l4y3GlrOCmXtxhrs+/CP6SA+9W+ pQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d4ncw2c01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:34:57 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BNAWKfH019924;
        Thu, 23 Dec 2021 10:34:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3d179a3srn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:34:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BNAYquT41419020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 10:34:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B155204E;
        Thu, 23 Dec 2021 10:34:52 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.95.224])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 75AAC52054;
        Thu, 23 Dec 2021 10:34:51 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     <linux-kernel@vger.kernel.org>, bristot@kernel.org, luto@kernel.org
Subject: [PATCH v2 2/2] trace: Tag trace_percpu_buffer as a percpu pointer
Date:   Thu, 23 Dec 2021 16:04:39 +0530
Message-Id: <ebabd3f23101d89cb75671b68b6f819f5edc830b.1640255304.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1640255304.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1640255304.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p2liL2_NV3LE_czkeo82QhBnXEJYbPwg
X-Proofpoint-ORIG-GUID: p2liL2_NV3LE_czkeo82QhBnXEJYbPwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_03,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=899 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag trace_percpu_buffer as a percpu pointer to resolve warnings
reported by sparse:
  /linux/kernel/trace/trace.c:3218:46: warning: incorrect type in initializer (different address spaces)
  /linux/kernel/trace/trace.c:3218:46:    expected void const [noderef] __percpu *__vpp_verify
  /linux/kernel/trace/trace.c:3218:46:    got struct trace_buffer_struct *
  /linux/kernel/trace/trace.c:3234:9: warning: incorrect type in initializer (different address spaces)
  /linux/kernel/trace/trace.c:3234:9:    expected void const [noderef] __percpu *__vpp_verify
  /linux/kernel/trace/trace.c:3234:9:    got int *

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e1f55851e53faa..78ea542ce3bc2e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3207,7 +3207,7 @@ struct trace_buffer_struct {
 	char buffer[4][TRACE_BUF_SIZE];
 };
 
-static struct trace_buffer_struct *trace_percpu_buffer;
+static struct trace_buffer_struct __percpu *trace_percpu_buffer;
 
 /*
  * This allows for lockless recording.  If we're nested too deeply, then
@@ -3236,7 +3236,7 @@ static void put_trace_buf(void)
 
 static int alloc_percpu_trace_buffer(void)
 {
-	struct trace_buffer_struct *buffers;
+	struct trace_buffer_struct __percpu *buffers;
 
 	if (trace_percpu_buffer)
 		return 0;
-- 
2.34.1

