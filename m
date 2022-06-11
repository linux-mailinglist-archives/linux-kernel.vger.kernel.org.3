Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95902547349
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiFKJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFKJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:32:14 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 953801CE;
        Sat, 11 Jun 2022 02:32:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B9D401E80D77;
        Sat, 11 Jun 2022 17:31:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cZ7eIsdfn8sV; Sat, 11 Jun 2022 17:31:14 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4F8361E80D70;
        Sat, 11 Jun 2022 17:31:13 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        hukun@nfschina.com, qixu@nfschina.com, yuzhe@nfschina.com,
        renyu@nfschina.com, Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] rcu: Handle failure of memory allocation functions
Date:   Sat, 11 Jun 2022 17:30:55 +0800
Message-Id: <20220611093055.1473-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add warning when these functions (eg:kmalloc,vmalloc) fail, handle the
failure.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 kernel/rcu/rcutorture.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7120165a9342..97f90e304ae3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1991,6 +1991,10 @@ static void rcu_torture_mem_dump_obj(void)
 
 	kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
 	rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
+	if (WARN_ON_ONCE(!rhp)) {
+		kmem_cache_destroy(kcp);
+		return;
+	}
 	pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
 	pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
 	mem_dump_obj(ZERO_SIZE_PTR);
@@ -2007,6 +2011,8 @@ static void rcu_torture_mem_dump_obj(void)
 	kmem_cache_free(kcp, rhp);
 	kmem_cache_destroy(kcp);
 	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+	if (WARN_ON_ONCE(!rhp))
+		return;
 	pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
 	pr_alert("mem_dump_obj(kmalloc %px):", rhp);
 	mem_dump_obj(rhp);
@@ -2014,6 +2020,8 @@ static void rcu_torture_mem_dump_obj(void)
 	mem_dump_obj(&rhp->func);
 	kfree(rhp);
 	rhp = vmalloc(4096);
+	if (WARN_ON_ONCE(!rhp))
+		return;
 	pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
 	pr_alert("mem_dump_obj(vmalloc %px):", rhp);
 	mem_dump_obj(rhp);
-- 
2.11.0

