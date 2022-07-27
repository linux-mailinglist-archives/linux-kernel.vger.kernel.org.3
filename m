Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6A58251C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiG0LEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG0LEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:04:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6043648E9C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:04:45 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R9R24u030001;
        Wed, 27 Jul 2022 11:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=vv5qFt1NDCvv17wdgFFsbuxsFKiuUYjnW1RgvKY9+ek=;
 b=TDNmdfOxVEAdX5saijoRVPgjgNv9iX95gg3BRN3QhKJ+W111LmRASvt8iGUCqtP/5Jia
 Da+8Da5YKdZ8r8jX90nwc25SsYCYCjfoBMc/jVT7luf86XaZbzj7qq75b1QDeBN5WD6a
 A9ZzYI6V/+02znDny+lB06eOE7iY0ZVNVfP3LD6gc6G4dI3vg4mPrr0/USleKqKjj1Kh
 0uHkXp44631zkjRrY/K6PONDW8XCSyUzktButqslHjZiZtMMrKfoETOIk4gd9fhpHnPx
 RTPX/h35dBA+2EX9s3UayHmAXhzT80gLUGgrl4MJX3FuEKs2BcFgcuyTzyRKaAlj04Di 9Q== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hjunr1737-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 11:04:35 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 26RB4Wj9002884;
        Wed, 27 Jul 2022 11:04:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3hga2puq4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jul 2022 11:04:32 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26RB4VeZ002843;
        Wed, 27 Jul 2022 11:04:31 GMT
Received: from maow2-gv.ap.qualcomm.com (maow2-gv.qualcomm.com [10.232.193.133])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 26RB4VTX002842;
        Wed, 27 Jul 2022 11:04:31 +0000
Received: by maow2-gv.ap.qualcomm.com (Postfix, from userid 399080)
        id 52BE12102E3E; Wed, 27 Jul 2022 19:04:30 +0800 (CST)
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     tj@kernel.org, akpm@linux-foundation.org
Cc:     Kassey Li <quic_yingangl@quicinc.com>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: avoid re-entry of pwq->pool->lock through __queue_work
Date:   Wed, 27 Jul 2022 19:04:26 +0800
Message-Id: <20220727110426.19079-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HU8Uf9C56wwE_-2GYtBLJXA9TMiZ_-HJ
X-Proofpoint-ORIG-GUID: HU8Uf9C56wwE_-2GYtBLJXA9TMiZ_-HJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_01,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=483 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207270044
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[0:swapper/4]BUG: spinlock recursion on CPU#4, swapper/4/0
[0:swapper/4]lock: 0xffffff8000c0f400, .magic: dead4ead, .owner:
swapper/4/0, .owner_cpu: 4
[0:swapper/4]CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S
[0:swapper/4]Call trace:
[0:swapper/4] dump_backtrace.cfi_jt+0x0/0x8
[0:swapper/4] show_stack+0x1c/0x2c
[0:swapper/4] dump_stack_lvl+0xd8/0x16c
[0:swapper/4] spin_dump+0x104/0x278
[0:swapper/4] do_raw_spin_lock+0xec/0x15c
[0:swapper/4] _raw_spin_lock+0x28/0x3c
[0:swapper/4] __queue_work+0x1fc/0x618
[0:swapper/4] queue_work_on+0x64/0x134
[0:swapper/4] memlat_hrtimer_handler+0x28/0x3c [memlat]
[0:swapper/4] __run_hrtimer+0xe8/0x448
[0:swapper/4] hrtimer_interrupt+0x184/0x40c
[0:swapper/4] arch_timer_handler_virt+0x5c/0x98
[0:swapper/4] handle_percpu_devid_irq+0xd8/0x3e0
[0:swapper/4] __handle_domain_irq+0xd0/0x19c
[0:swapper/4] gic_handle_irq+0x6c/0x134
[0:swapper/4] el1_irq+0xe4/0x1c0
[0:swapper/4] _raw_spin_unlock_irqrestore+0x2c/0x60
[0:swapper/4] try_to_wake_up.llvm.14610847381734009831+0x334/0x888
[0:swapper/4] wake_up_process+0x1c/0x2c
[0:swapper/4] __queue_work+0x3e8/0x618
[0:swapper/4] delayed_work_timer_fn+0x24/0x34
[0:swapper/4] call_timer_fn+0x58/0x268
[0:swapper/4] expire_timers+0xe0/0x1c4
[0:swapper/4] __run_timers+0x16c/0x1c4
[0:swapper/4] run_timer_softirq+0x34/0x60
[0:swapper/4] efi_header_end+0x198/0x59c
[0:swapper/4] __irq_exit_rcu+0xdc/0xf0
[0:swapper/4] irq_exit+0x14/0x50
[0:swapper/4] __handle_domain_irq+0xd4/0x19c
[0:swapper/4] gic_handle_irq+0x6c/0x134
[0:swapper/4] el1_irq+0xe4/0x1c0
[0:swapper/4] cpuidle_enter_state+0x1b4/0x5dc
[0:swapper/4] cpuidle_enter+0x3c/0x58
[0:swapper/4] do_idle.llvm.6296834828977863291+0x1f4/0x2e8
[0:swapper/4] cpu_startup_entry+0x28/0x2c
[0:swapper/4] secondary_start_kernel+0x1c8/0x230

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 kernel/workqueue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..f23491f373b1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1468,10 +1468,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		} else {
 			/* meh... not running there, queue here */
 			raw_spin_unlock(&last_pool->lock);
-			raw_spin_lock(&pwq->pool->lock);
+			raw_spin_lock_irq(&pwq->pool->lock);
 		}
 	} else {
-		raw_spin_lock(&pwq->pool->lock);
+		raw_spin_lock_irq(&pwq->pool->lock);
 	}
 
 	/*
@@ -1484,7 +1484,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
-			raw_spin_unlock(&pwq->pool->lock);
+			raw_spin_unlock_irq(&pwq->pool->lock);
 			cpu_relax();
 			goto retry;
 		}
@@ -1517,7 +1517,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	insert_work(pwq, work, worklist, work_flags);
 
 out:
-	raw_spin_unlock(&pwq->pool->lock);
+	raw_spin_unlock_irq(&pwq->pool->lock);
 	rcu_read_unlock();
 }
 
-- 
2.17.1

