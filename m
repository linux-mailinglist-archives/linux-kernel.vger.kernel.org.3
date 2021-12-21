Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04247C3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbhLUQ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:26:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239772AbhLUQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:26:50 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLEqAXi005456;
        Tue, 21 Dec 2021 16:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=IYf1RoSQiwMU1yf7UnWK/psXN7tlzl8GWrji6iTXuvI=;
 b=rSV/OjGLS8bzCL47syudNheCsXuRs9gmmLEntSTpZizA+p9ZRXxNS0wzqhZAeMuh+B7X
 OoSNfqxlww1fSj2CnfA5qmL5ORyggWUp6VBvgdi9UirR+bTCBZT550dbevMBIkQWMlZq
 9FJPRnDkwfkdKXIG5SAbNWuzvEawDdqNPQBr3FdQvt9qmpf9F1nF8bEmYkyCZmAt2Xl2
 qqlbxSvgPX1ITZfkVOBV73MeH+6Os7gdHcWyMvw+YUvPvYca1YH8osdORFr+kaoU8/nn
 Zw6FgKUyznHE3D4FHMgSlt/c1MFxxMp49DhlsqZP4d0OzoGrBAqQjfg4Qo3ML4P3TlDo mw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d2q0kh6y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 16:26:32 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLGOYhI022374;
        Tue, 21 Dec 2021 16:26:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3d1799e8yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 16:26:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLGQQ5v42009008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 16:26:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0B8B4C04A;
        Tue, 21 Dec 2021 16:26:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D2AE4C04E;
        Tue, 21 Dec 2021 16:26:25 +0000 (GMT)
Received: from naverao1-tp.lan (unknown [9.43.119.26])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 16:26:25 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     <linux-kernel@vger.kernel.org>, bristot@kernel.org, luto@kernel.org
Subject: [PATCH] trace: Fix check for trace_percpu_buffer validity in get_trace_buf()
Date:   Tue, 21 Dec 2021 21:55:29 +0530
Message-Id: <20211221162529.1480652-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vAIRsvNg6_kzrHgaV_RjeaIx55WVbNF0
X-Proofpoint-ORIG-GUID: vAIRsvNg6_kzrHgaV_RjeaIx55WVbNF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxlogscore=468 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210078
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
Fix the check to be against trace_percpu_buffer. Also tag
trace_percpu_buffer as a percpu pointer.

Fixes: e2ace001176dc9 ("tracing: Choose static tp_printk buffer by explicit nesting count")
Cc: stable@vger.kernel.org
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 88de94da596b13..6a8bf33c413c99 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3207,7 +3207,7 @@ struct trace_buffer_struct {
 	char buffer[4][TRACE_BUF_SIZE];
 };
 
-static struct trace_buffer_struct *trace_percpu_buffer;
+static struct trace_buffer_struct __percpu *trace_percpu_buffer;
 
 /*
  * This allows for lockless recording.  If we're nested too deeply, then
@@ -3217,7 +3217,7 @@ static char *get_trace_buf(void)
 {
 	struct trace_buffer_struct *buffer = this_cpu_ptr(trace_percpu_buffer);
 
-	if (!buffer || buffer->nesting >= 4)
+	if (!trace_percpu_buffer || buffer->nesting >= 4)
 		return NULL;
 
 	buffer->nesting++;

base-commit: f7f0bb5eaecb1aff9cc8ab13425d43690b71ec44
-- 
2.34.1

