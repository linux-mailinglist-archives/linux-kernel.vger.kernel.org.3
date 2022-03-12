Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050D84D6EAD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiCLMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCLMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:38:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CF5DF;
        Sat, 12 Mar 2022 04:37:05 -0800 (PST)
Date:   Sat, 12 Mar 2022 12:37:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647088623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImDKjyjIaqyBgsE3pDCKcxhGjzMBqWvERgvYQx/Ct4I=;
        b=L1aO2Oe5qTpKPzWOvnFEiThM+t8kteIfw9M9af1eXl6R2W7Ybc2YA3SrExelYPmCo2AvQo
        XDfqLojNovJsNeMFP3UmND2DJUWb3mFaV71N9QRxO7nzhebAQI0fxpKEKxnfwQSKSHjhMF
        S8H4jLRCW4h7qY/FX7BNFjRwa/ZGhCdNqFHgwW+kJ94lPtXZM5Ou3tmcvw3T/5mI/yxZzZ
        eapQ/CVinuSWsy+u6HGkfyLtaO5W2l4tPqFsItIqLW4+t/Uq/N7ubiPmc5ypL39o8l8/yJ
        ktX2fa7cqmRrYD7MgD3nRo5i4AmvYZnQ/Mri37XVawAWTu/2T8KOy3a+yTqoYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647088623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImDKjyjIaqyBgsE3pDCKcxhGjzMBqWvERgvYQx/Ct4I=;
        b=vtF/fpC0rwgCCIGVGBCbbNrZvO1DJDratI69JSHhwoasOhLtUQH67lrYtuMEUuFE30lvaV
        inHJrJxYV4gyY3DA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cgroup: Fix suspicious rcu_dereference_check()
 usage warning
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220305034103.57123-1-zhouchengming@bytedance.com>
References: <20220305034103.57123-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <164708862156.16921.16724154187249548862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f2aa197e4794bf4c2c0c9570684f86e6fa103e8b
Gitweb:        https://git.kernel.org/tip/f2aa197e4794bf4c2c0c9570684f86e6fa103e8b
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Sat, 05 Mar 2022 11:41:03 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 12 Mar 2022 13:22:11 +01:00

cgroup: Fix suspicious rcu_dereference_check() usage warning

task_css_set_check() will use rcu_dereference_check() to check for
rcu_read_lock_held() on the read-side, which is not true after commit
dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
commit drop explicit rcu_read_lock(), change to RCU-sched read-side
critical section. So fix the RCU warning by adding check for
rcu_read_lock_sched_held().

Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20220305034103.57123-1-zhouchengming@bytedance.com
---
 include/linux/cgroup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 1e356c2..0d1ada8 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -450,6 +450,7 @@ extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
+		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
