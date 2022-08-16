Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70398595522
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiHPIY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHPIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:22:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF914410F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:00:35 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G4m8cF030863;
        Tue, 16 Aug 2022 06:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=17A5XgzIslLl1w0X8XOBzNYOt3ViA7v3u3+KeLKY6NU=;
 b=np6p2dpNnUfqpExDsaGH0Bn7FLucHdyOSd78KeApQsPxZu3TYLMFTPN/MELVZGcb8xOn
 c+QUzOos015kywVNQRkRSPLZccY4EsElCTYwVpAGhz7Zgwr6lo27Pmgfzi6YVR7Apagy
 6mBhv8Z4glkDNHzuDk5tqMugZ7iutLhQarCi/DtD0e86l60nH9em4UDAueQSRd7CjyX7
 cu4x+rXkCc81Qia+gCM0nIHLNpnOEURKyWP0R+ThXeP5GTsbSVjajTrwmh73ETNetnoZ
 jVX46VEVwwB2TYpUpHW5qNg40V4i3g+VC69KPcyW0mh+G+Vk6nQQ4DisxOqYXEg+StmJ uQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j0445rafg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 06:00:25 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27G60Mwi030772;
        Tue, 16 Aug 2022 06:00:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3hxnep8jfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Aug 2022 06:00:22 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27G60Ldr030766;
        Tue, 16 Aug 2022 06:00:21 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-pbrahma-hyd.qualcomm.com [10.213.107.125])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 27G60LgP030762;
        Tue, 16 Aug 2022 06:00:21 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2370061)
        id B9C875001D9; Tue, 16 Aug 2022 11:30:20 +0530 (+0530)
From:   Pratyush Brahma <pbrahma@qti.qualcomm.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        quic_charante@quicinc.com,
        Pratyush Brahma <quic_pbrahma@quicinc.com>
Subject: [PATCH v2] mm: oom_kill: add trace logs in process_mrelease() system call
Date:   Tue, 16 Aug 2022 11:30:17 +0530
Message-Id: <20220816060017.17996-1-pbrahma@qti.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PmydXDOiBMMuIpx-8SEodg6JjntJ-xgb
X-Proofpoint-GUID: PmydXDOiBMMuIpx-8SEodg6JjntJ-xgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_04,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160022
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charan Teja Kalla <quic_charante@quicinc.com>

The process_mrelease() system call[1] is used to release the memory of
a dying process from the context of the caller, which is similar to and
uses the functions of the oom reaper logic. There exists trace logs for
a process when reaped by the oom reaper. Just extend the same to when
done by the process_mrelease() system call.

[1]
https://lore.kernel.org/linux-mm/20210809185259.405936-1-surenb@google.com/

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
---
Changes in v2:
- Added trace_skip_task_reaping() to cover more cases where we skip
  reaping.
- Print debug information in pr_debug instead of pr_info
- The original author email domain has changed. Update the new email
  address.

[v1]
https://patchwork.kernel.org/project/linux-mm/patch/1629106756-20874-1-git-send-email-charante@codeaurora.org/

 mm/oom_kill.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c6cf9e3cd66..51ad5f0b612e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -995,7 +995,6 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 	mmdrop(mm);
 	put_task_struct(victim);
 }
-#undef K
 
 /*
  * Kill provided task unless it's secured by setting
@@ -1241,17 +1240,33 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		goto drop_mm;
 
 	if (mmap_read_lock_killable(mm)) {
+		trace_skip_task_reaping(task->pid);
 		ret = -EINTR;
-		goto drop_mm;
+		goto read_unlock;
 	}
 	/*
 	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
 	 * possible change in exit_mmap is seen
 	 */
-	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
+	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
+		trace_skip_task_reaping(task->pid);
+		goto read_unlock;
+	}
+
+	trace_start_task_reaping(task->pid);
+
+	if (!__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
-	mmap_read_unlock(mm);
 
+	pr_debug("process_mrelease: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
+						task_pid_nr(task), task->comm,
+						K(get_mm_counter(mm, MM_ANONPAGES)),
+						K(get_mm_counter(mm, MM_FILEPAGES)),
+						K(get_mm_counter(mm, MM_SHMEMPAGES)));
+	trace_finish_task_reaping(task->pid);
+
+read_unlock:
+	mmap_read_unlock(mm);
 drop_mm:
 	mmdrop(mm);
 put_task:
@@ -1261,3 +1276,4 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+#undef K
-- 
2.17.1

