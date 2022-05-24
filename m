Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87562531FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiEXAfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiEXAfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:35:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB99BAFA;
        Mon, 23 May 2022 17:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653352499; x=1684888499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cn//lySDkZnoisvjz9SADhbX/aP26ag0T/ZF0md/lDg=;
  b=ZY9dayXL3bvYEu6+3b9TgGE5N6zXl3Fv09D8ZAt/PNT4DIUQbOokhQTP
   Av7dqC1PbbvCsZd6sRQXFzJaUev1k5kmJLhOfYk9zOd4OXQiS3XneAM/q
   iC3oOsf6xBqWhyr0p/IYj0ZWIkvqnmA6MhPoRAIqybFF3YdkW8GJJnu1v
   Y1EA5ZXRhs/UkPue6Q3JJI/VEJWZIKsgVpDql268UL9yuVRZQJXAmJvQd
   ZtA97VM8uPxC75Yxb3NuO9cYREPTvhSY/yX5P72en47VpqaKe4EEWjOLk
   mEOWqYSHbjdsice7yQn9pV6wA9QLiYCq4oQi/QCFADfUnLfk/xu0uxF+f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273509532"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273509532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:34:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="600952749"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 17:34:57 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/2] rcu-tasks: Stop RCU Tasks scanning no-idle tasks which record on dyntick-idle entry
Date:   Tue, 24 May 2022 08:34:53 +0800
Message-Id: <20220524003454.1887414-2-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524003454.1887414-1-qiang1.zhang@intel.com>
References: <20220524003454.1887414-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the RCU Tasks scanning on-rq tasks, there is no need to scanning
no-idle tasks(have invoked rcu_user_enter()) which record on dyntick-idle
entry, at this time, these tasks are not remain within an RCU Tasks
read-side critical section.

This commit skip scanning tasks which record on dyntick-idle entry in
rcu_tasks_pertask().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 195c97e85bcb..a28337f280e4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -809,10 +809,16 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	synchronize_rcu();
 }
 
+static bool task_is_on_dyntick_idle(struct task_struct *t)
+{
+	return IS_ENABLED(CONFIG_NO_HZ_FULL) && t->rcu_tasks_idle_cpu >= 0;
+}
+
 /* Per-task initial processing. */
 static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 {
-	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t) &&
+				!task_is_on_dyntick_idle(t)) {
 		get_task_struct(t);
 		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
 		WRITE_ONCE(t->rcu_tasks_holdout, true);
@@ -842,8 +848,7 @@ static void check_holdout_task(struct task_struct *t,
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

