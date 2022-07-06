Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5E568503
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiGFKQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiGFKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:16:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C325B4B7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:16:42 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2669b3QK017435;
        Wed, 6 Jul 2022 10:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=E4eGx5leFv3Cl1qwDnRHe/cqaF2cf/A2t6fNZFqTNi4=;
 b=l/okrt3aT8Q1xgVK5eGi8GEnxjH9y99BF5nJJpWVCAXdZmswPFJ2ALpqg2JRbezf+hdT
 U39tmj14k5f/SYg9guxZSgc1TiINUhuPWJH/xbAva+I8tTjNdoG1DWXBs+wmAzOTQDPp
 Bnuy2c2433UOs4yI+mJjMguVe5bFHa+V5BvP1YjfQBlkf6J51DZC638inN9mTiXXV/jC
 Htnl8Bd2KtA0JngXd8YZTkz0htzc6x5QOqXYqT8EBbsBM9PrZujUQ6Y3hLz3Aa+VeyMY
 DLlA0RWQ7qNMmBN5pgCIDt+K88kDypfgDyJmrweEAkWVGdIDjI0oYD70Fq4kWGVAcfm9 Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h578921cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 10:16:37 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2669dQhc024759;
        Wed, 6 Jul 2022 10:16:37 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h578921c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 10:16:37 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266A5Gaa019948;
        Wed, 6 Jul 2022 10:16:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3h4ucy8m2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 10:16:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266AGWD621103014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 10:16:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E99D5204F;
        Wed,  6 Jul 2022 10:16:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3E2835204E;
        Wed,  6 Jul 2022 10:16:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 0E1F9E0256; Wed,  6 Jul 2022 12:16:32 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ptrace: fix clearing of JOBCTL_TRACED in ptrace_unfreeze_traced()
Date:   Wed,  6 Jul 2022 12:16:25 +0200
Message-Id: <20220706101625.2100298-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 71k1yHelHqcV-QqWvyR7mX1K5WrNXvv_
X-Proofpoint-ORIG-GUID: vgcbDNUS3vjKBJ_9JnyjJVf12SPyGpXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=751 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CI reported the following splat while running the strace testsuite:

[ 3976.640309] WARNING: CPU: 1 PID: 3570031 at kernel/ptrace.c:272 ptrace_check_attach+0x12e/0x178
[ 3976.640391] CPU: 1 PID: 3570031 Comm: strace Tainted: G           OE     5.19.0-20220624.rc3.git0.ee819a77d4e7.300.fc36.s390x #1
[ 3976.640410] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[ 3976.640452] Call Trace:
[ 3976.640454]  [<00000000ab4b645a>] ptrace_check_attach+0x132/0x178
[ 3976.640457] ([<00000000ab4b6450>] ptrace_check_attach+0x128/0x178)
[ 3976.640460]  [<00000000ab4b6cde>] __s390x_sys_ptrace+0x86/0x160
[ 3976.640463]  [<00000000ac03fcec>] __do_syscall+0x1d4/0x200
[ 3976.640468]  [<00000000ac04e312>] system_call+0x82/0xb0
[ 3976.640470] Last Breaking-Event-Address:
[ 3976.640471]  [<00000000ab4ea3c8>] wait_task_inactive+0x98/0x190

This is because JOBCTL_TRACED is set, but the task is not in TASK_TRACED
state. Caused by ptrace_unfreeze_traced() which does:

task->jobctl &= ~TASK_TRACED

but it should be:

task->jobctl &= ~JOBCTL_TRACED

Fixes: 31cae1eaae4f ("sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 156a99283b11..1893d909e45c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -222,7 +222,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	if (lock_task_sighand(task, &flags)) {
 		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
 		if (__fatal_signal_pending(task)) {
-			task->jobctl &= ~TASK_TRACED;
+			task->jobctl &= ~JOBCTL_TRACED;
 			wake_up_state(task, __TASK_TRACED);
 		}
 		unlock_task_sighand(task, &flags);
-- 
2.34.1

