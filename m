Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E684347E187
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347754AbhLWKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:35:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38990 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347741AbhLWKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:35:13 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNA7Kas009194;
        Thu, 23 Dec 2021 10:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=01Nc3SAHjeSJKkkf+3mng3aB0PmZP1cXf/8S2BUijbg=;
 b=td7rSTCRNQMcQUz9qt4wDJ54R2aZ9J5y7olreEOitnez3KQpgfDH3FLpC98aG6tI8XFg
 cZzPUx2pabjYmoG95DKnkNLvRU7P7cbQySrqLK/O3n6+ecMqCakCLHIUjhw2+GCDN/lL
 6ukJbL362gvoKlKo0yc4hpBhEcA3eY2GytxPoIR9omFSxaQ30MXaZwKBt+yVeAaBz7SR
 Ge+i4Ut/ShYDMQMXGbmdRUNLUu+Af6TtS3p3tTcmisVzuu7czLTglyV9H12qIb0xjwOR
 Gq4njcc1D/D5jQzGz4/Sy47UCV9ZZmvlvscqt/U8hBIF/ByGEM5NgrdwB64+q6miyUFz +w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d4hqpws8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:34:55 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BNAWPUC002738;
        Thu, 23 Dec 2021 10:34:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3d179a3pyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:34:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BNAQYgA45482400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Dec 2021 10:26:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18CA652057;
        Thu, 23 Dec 2021 10:34:51 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.43.95.224])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B7C575205F;
        Thu, 23 Dec 2021 10:34:49 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     <linux-kernel@vger.kernel.org>, bristot@kernel.org, luto@kernel.org
Subject: [PATCH v2 1/2] trace: Fix check for trace_percpu_buffer validity in get_trace_buf()
Date:   Thu, 23 Dec 2021 16:04:38 +0530
Message-Id: <a920e4272e0b0635cf20c444707cbce1b2c8973d.1640255304.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1640255304.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1640255304.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n2sC9lm47EHGTsfWIzYmDG3vc5L-s7fp
X-Proofpoint-GUID: n2sC9lm47EHGTsfWIzYmDG3vc5L-s7fp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_03,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=620 clxscore=1015 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the new osnoise tracer, we are seeing the below splat:
    Kernel attempted to read user page (c7d880000) - exploit attempt? (uid: 0)
    BUG: Unable to handle kernel data access on read at 0xc7d880000
    Faulting instruction address: 0xc0000000002ffa10
    Oops: Kernel access of bad area, sig: 11 [#1]
    LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
    ...
    NIP [c0000000002ffa10] __trace_array_vprintk.part.0+0x70/0x2f0
    LR [c0000000002ff9fc] __trace_array_vprintk.part.0+0x5c/0x2f0
    Call Trace:
    [c0000008bdd73b80] [c0000000001c49cc] put_prev_task_fair+0x3c/0x60 (unreliable)
    [c0000008bdd73be0] [c000000000301430] trace_array_printk_buf+0x70/0x90
    [c0000008bdd73c00] [c0000000003178b0] trace_sched_switch_callback+0x250/0x290
    [c0000008bdd73c90] [c000000000e70d60] __schedule+0x410/0x710
    [c0000008bdd73d40] [c000000000e710c0] schedule+0x60/0x130
    [c0000008bdd73d70] [c000000000030614] interrupt_exit_user_prepare_main+0x264/0x270
    [c0000008bdd73de0] [c000000000030a70] syscall_exit_prepare+0x150/0x180
    [c0000008bdd73e10] [c00000000000c174] system_call_vectored_common+0xf4/0x278

osnoise tracer on ppc64le is triggering osnoise_taint() for negative
duration in get_int_safe_duration() called from
trace_sched_switch_callback()->thread_exit().

The problem though is that the check for a valid trace_percpu_buffer is
incorrect in get_trace_buf(). The check is being done after calculating
the pointer for the current cpu, rather than on the main percpu pointer.
Fix the check to be against trace_percpu_buffer.

Fixes: e2ace001176dc9 ("tracing: Choose static tp_printk buffer by explicit nesting count")
Cc: stable@vger.kernel.org
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b13..e1f55851e53faa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3217,7 +3217,7 @@ static char *get_trace_buf(void)
 {
 	struct trace_buffer_struct *buffer = this_cpu_ptr(trace_percpu_buffer);
 
-	if (!buffer || buffer->nesting >= 4)
+	if (!trace_percpu_buffer || buffer->nesting >= 4)
 		return NULL;
 
 	buffer->nesting++;
-- 
2.34.1

