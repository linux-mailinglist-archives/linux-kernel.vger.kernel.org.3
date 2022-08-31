Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E375A8502
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiHaSIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiHaSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B06E1AA7;
        Wed, 31 Aug 2022 11:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D522161C14;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D48C433D7;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=IINFzSXV050MZ7p39aFiCw3ksGDcAruZYr0+y+xvqvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nitWNXI+In3pEwI/3JSH9oJN/skv/4jMUZfznb0dIKMjmHkxKYHR0NYhuQ+sWQHmm
         dm3GRPHd7xNUr3NUzGn1dgxFuZcZbrub5L5XCOvSafld81VyrIWWH0TjtqDMwr8Fzo
         vKSF1F64wiz6kbXk+fX5kZlEm3Q4rCwOeX733xQd5Mx3rYufF6mpDQAoY86d39QUDZ
         pUz88AwlWFBSyw4oJdmB2s7guG1pYH8pbd5y8nO0tD9DTMOVDxQQOzBYoWvPWsEzwM
         d8vPu3GMorxk2sYeWSDX1cfaiMgRApkc+NF2I3trBJyWyKNqtujMzlawVUCfkIynq8
         eLqnRSyz6x9XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECEAA5C019C; Wed, 31 Aug 2022 11:08:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/10] rcu: Update rcu_preempt_deferred_qs() comments for !PREEMPT kernels
Date:   Wed, 31 Aug 2022 11:07:57 -0700
Message-Id: <20220831180805.2693546-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

In non-premptible kernels, tasks never do context switches within
RCU read-side critical sections.  Therefore, in such kernels, each
leaf rcu_node structure's ->blkd_tasks list will always be empty.
The comment on the non-preemptible version of rcu_preempt_deferred_qs()
confuses this point, so this commit therefore fixes it.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 86772c95ed0ae..4152816dd29f6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -932,10 +932,13 @@ static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 	return false;
 }
 
-// Except that we do need to respond to a request by an expedited grace
-// period for a quiescent state from this CPU.  Note that requests from
-// tasks are handled when removing the task from the blocked-tasks list
-// below.
+// Except that we do need to respond to a request by an expedited
+// grace period for a quiescent state from this CPU.  Note that in
+// non-preemptible kernels, there can be no context switches within RCU
+// read-side critical sections, which in turn means that the leaf rcu_node
+// structure's blocked-tasks list is always empty.  is therefore no need to
+// actually check it.  Instead, a quiescent state from this CPU suffices,
+// and this function is only called from such a quiescent state.
 notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-- 
2.31.1.189.g2e36527f23

