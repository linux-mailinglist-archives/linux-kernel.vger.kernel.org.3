Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2EA5B259A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiIHSYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIHSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:24:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206013F73
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:24:45 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288IKOxj001987;
        Thu, 8 Sep 2022 18:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=97nQBZTKNx0F+1ixxWZLuJvYPxe0AqfQkkDvFn+MPi8=;
 b=fDq9DpzZetsSjtcLYq4y/yq1c13qbgBcItFoZlW+fmgMKhkn3qdjz7gOfSPK0WJ4b1KD
 kaKKUHBQqcePpIeqpmZcbA1cTWp9TPq0jvH5lDOFWP71tJ5PcrLgi3MM4hn5mt4FXBow
 LZ2y7Fc1hkAx+vKfvbIGrDlUTm8DVGnOtvOOP6Zwieyzx60yDhIfASyciguThQ7FHJ9b
 u8vmRARkXmTs12pqMxFh6ZoIZNZH7mXLz1aWnnz8wxZVK7cCCY/zk8rI5VEQZyj9J293
 0WbZkT2gOABWC9GmDg1KiDHEXse6yO92G6xS1g8KFwxH7AVrpajdypaaAo0OtP/mrSlD aQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfcpbswps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 18:24:40 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 288INsHC011170;
        Thu, 8 Sep 2022 18:24:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 3jeq4ds5r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 18:24:39 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 288INdA3010628;
        Thu, 8 Sep 2022 18:24:39 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 288IOdHl012473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 18:24:39 +0000
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 11:24:36 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2] locking/rwsem: Disable preemption while trying for rwsem lock
Date:   Thu, 8 Sep 2022 23:54:27 +0530
Message-ID: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9DbUiLg6BPgIbc-LT5VsGyq57RW3JOdF
X-Proofpoint-GUID: 9DbUiLg6BPgIbc-LT5VsGyq57RW3JOdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=689 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
until owner is set for the lock. While at it also fix the issues
at the places where rwsem_{set,clear}_owner() are called.

This also adds lockdep annotation of preemption disable in
rwsem_{set,clear}_owner() on Peter Z. suggestion.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2:
 - Remove preempt disable code in rwsem_try_write_lock_unqueued()
 - Addressed suggestion from Peter Z.
 - Modified commit text
 kernel/locking/rwsem.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 65f0262..4487359 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -133,14 +133,19 @@
  * the owner value concurrently without lock. Read from owner, however,
  * may not need READ_ONCE() as long as the pointer value is only used
  * for comparison and isn't being dereferenced.
+ *
+ * Both rwsem_{set,clear}_owner() functions should be in the same
+ * preempt disable section as the atomic op that changes sem->count.
  */
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
 {
+	lockdep_assert_preemption_disabled();
 	atomic_long_set(&sem->owner, (long)current);
 }
 
 static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 {
+	lockdep_assert_preemption_disabled();
 	atomic_long_set(&sem->owner, 0);
 }
 
@@ -251,13 +256,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
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

