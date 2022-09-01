Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E15A94EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiIAKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiIAKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:43:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6720D7402
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:43:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819qP90030339;
        Thu, 1 Sep 2022 10:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MzYSklfDSZ1eVLHobpLfYIhewPgTOWPfrgVvYLnJNEA=;
 b=cM9iHRRDt5Q/QVsmoZVlWNtaOTicHSpbtUsHdU4NjxwmQBgAU6FQ5tj8Y3BUpScRPFrD
 w4qXrGODLz/hU/1dF0U2ZJOJ1APsLNK6gUm1Ag0jnWzu7qWXICACmz2YNXRgsOZR6eqj
 Cd5kfeQlNzxEADhl/QLFGzaCYlnt4S0ANEABMyp8IulRjytrt/gnyqT7O1cAG1sJCzED
 QBhUif//4Jv4xV88xt/zLefT+PcuL0Po7d8KsS8Y2odF4mC+VA9f9AqtutYH6jHqOdLL
 2a4P1VvMbTgoVEnWYpFA545DmW52CEGJA+8+ZJpFaR59rOcC10NiR7r/9DPz5ULTnTyo 2g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ja79kkpvr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 10:42:49 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 281ASLNx008420;
        Thu, 1 Sep 2022 10:28:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3jadjkf964-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 10:28:21 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 281ASLiS008414;
        Thu, 1 Sep 2022 10:28:21 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 281ASLlA008410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 10:28:21 +0000
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 1 Sep 2022 03:28:18 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] locking/rwsem: Disable preemption while trying for rwsem lock
Date:   Thu, 1 Sep 2022 15:58:10 +0530
Message-ID: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xYlC6nAwc7SfkACCLavzV9zs6uMOxmW4
X-Proofpoint-ORIG-GUID: xYlC6nAwc7SfkACCLavzV9zs6uMOxmW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=797 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>

Make the region inside the rwsem_write_trylock non preemptible.

We observe RT task is hogging CPU when trying to acquire rwsem lock
which was acquired by a kworker task but before the rwsem owner was set.

Here is the scenario:
1. CFS task (affined to a particular CPU) takes rwsem lock.

2. CFS task gets preempted by a RT task before setting owner.

3. RT task (FIFO) is trying to acquire the lock, but spinning until
RT throttling happens for the lock as the lock was taken by CFS task.

This patch attempts to fix the above issue by disabling preemption
until owner is set for the lock. while at it also fix this issue
at the place where owner being set/cleared.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/locking/rwsem.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 65f0262..3b4b32e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -251,13 +251,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
 static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
 {
 	long tmp = RWSEM_UNLOCKED_VALUE;
+	bool ret = false;
 
+	preempt_disable();
 	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
 		rwsem_set_owner(sem);
-		return true;
+		ret = true;
 	}
 
-	return false;
+	preempt_enable();
+	return ret;
 }
 
 /*
@@ -686,16 +689,21 @@ enum owner_state {
 static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 {
 	long count = atomic_long_read(&sem->count);
+	bool ret = false;
 
+	preempt_disable();
 	while (!(count & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count | RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_lock);
-			return true;
+			ret = true;
+			break;
 		}
 	}
-	return false;
+
+	preempt_enable();
+	return ret;
 }
 
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
@@ -1352,8 +1360,10 @@ static inline void __up_write(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
 			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
 
+	preempt_disable();
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
+	preempt_enable();
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
 		rwsem_wake(sem);
 }
-- 
2.7.4

