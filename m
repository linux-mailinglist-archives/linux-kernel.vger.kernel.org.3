Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56061522E39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbiEKIWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbiEKIWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:22:36 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E63DA5A;
        Wed, 11 May 2022 01:22:30 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 24B8LfE9037644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Wed, 11 May 2022 16:21:42 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 11 May 2022 16:21:42 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <xuewen.yan@unisoc.com>,
        <ke.wang@unisoc.com>, <ben.dai@unisoc.com>,
        <shian.wang@unisoc.com>, <linux-rt-users@vger.kernel.org>
Subject: [RFC PATCH] kernel: locking: rwsem optimization for rtlinux
Date:   Wed, 11 May 2022 16:21:21 +0800
Message-ID: <1652257281-11494-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 24B8LfE9037644
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

With regard to rtlinux, releasing the lock to RT waiter could be helpful to
increase its responding time even if cfs writer listed at the head of the
wait_list.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/locking/rwsem-xadd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908..1b3f836 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -138,6 +138,18 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	waiter = list_first_entry(&sem->wait_list, struct rwsem_waiter, list);
 
 	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
+		if ((waiter->task->policy != SCHED_NORMAL)
+			&&(waiter->task->policy != SCHED_BATCH))
+			;
+		else {
+			list_for_each_entry(tmp, sem->wait_list.next, list) {
+				if ((tmp->task->policy != SCHED_NORMAL)
+					&&(tmp->task->policy != SCHED_BATCH)) {
+					wake_q_add(wake_q, tmp->task);
+					return;
+				}
+			}
+		}
 		if (wake_type == RWSEM_WAKE_ANY) {
 			/*
 			 * Mark writer at the front of the queue for wakeup.
-- 
1.9.1

