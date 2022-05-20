Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99352E426
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbiETE4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345048AbiETE4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:56:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B52180F;
        Thu, 19 May 2022 21:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653022605; x=1684558605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=db8OCYpOU9+2GEsh1+1fgkkwRuMU7Qb8PM9/UHoI+bI=;
  b=B2ImID1Yg90NzkcqaK7rGYEHCD2QL5NRTvYQsMg9Mopl+lTop3jkqlze
   8oANbhFrvQ81FL4JmDJXLvOXS/ybx+iGaDwv3crNXIKYK7CtyeIGEdug4
   kfeGvQdk6E2N5xb5EU2QEyQjv4GrSs+j7DlTz+1+fM4TgWa+E1EHsS6Ik
   7so1gXKQv0F9LzIYN3fu/1ZIavVl9jsL2WdE5GsGoh/rEWZlFy+hldnw+
   wh0UIY1kk9zFqn43J3wBizkndPpcHxDtWER4lN0KRVLAD2bnkisDoNsw1
   KMVv5eQdfltkrJcikAq3sVmgrp74WvfWB0umeI4YD0t2XLvpzn83R+iy0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="270073987"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="270073987"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 21:56:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="599005988"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 21:56:43 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Stop RCU Tasks scanning tasks which record on dyntick-idle entry
Date:   Fri, 20 May 2022 12:56:45 +0800
Message-Id: <20220520045645.1692124-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the RCU Tasks scanning on-rq tasks, there is no need to scanning
tasks which record on dyntick-idle entry, at this time, these tasks are
not remain within an RCU Tasks read-side critical section.

This commit skip scanning tasks which record on dyntick-idle entry in
rcu_tasks_pertask().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f6459343e4b6..7898da987581 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -206,6 +206,12 @@ static void set_tasks_gp_state(struct rcu_tasks *rtp, int newstate)
 	rtp->gp_jiffies = jiffies;
 }
 
+static bool task_is_on_dyntick_idle(struct task_struct *t)
+{
+	return IS_ENABLED(CONFIG_NO_HZ_FULL) && !is_idle_task(t) &&
+				t->rcu_tasks_idle_cpu >= 0;
+}
+
 #ifndef CONFIG_TINY_RCU
 /* Return state name. */
 static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
@@ -812,7 +818,8 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 /* Per-task initial processing. */
 static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 {
-	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t) &&
+				!task_is_on_dyntick_idle(t)) {
 		get_task_struct(t);
 		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
 		WRITE_ONCE(t->rcu_tasks_holdout, true);
@@ -842,8 +849,7 @@ static void check_holdout_task(struct task_struct *t,
 	if (!READ_ONCE(t->rcu_tasks_holdout) ||
 	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
 	    !READ_ONCE(t->on_rq) ||
-	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
-	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
+	    task_is_on_dyntick_idle(t)) {
 		WRITE_ONCE(t->rcu_tasks_holdout, false);
 		list_del_init(&t->rcu_tasks_holdout_list);
 		put_task_struct(t);
-- 
2.25.1

