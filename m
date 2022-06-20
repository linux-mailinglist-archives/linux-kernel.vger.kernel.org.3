Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA50552727
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiFTWvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbiFTWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9161AF21;
        Mon, 20 Jun 2022 15:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD7D6109E;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45045C341CE;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=eUpgO1c60yqx1sVHsEK3tqCXl4W3K3gevZDtGvq7AMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aA5fegcbErOrphRxjB+QI5k/fSuYeUu3LsUQ1jGk2pokTrmPjIkQyGOL4o5TFWPAb
         hZFIXoehwcbJgL7gk38Rvlch30dr1i9WYJo+9OUKXl7VMLCnl7PBdsA4dFFkgF6Typ
         HpEnyFmoVnWHdNl9MRYw0kVXvn/X+JZCjifOCm7UTFkn3JemwmKpH3uOvmOcho9zX3
         awCJ9GFJgac+UpysUf3zPqltxy9nk2sEAJqzwFZq5OyesQpm3hw/CyaIDwHSFFGhpd
         CUd4lq6QN6fw9px+3m3+bHsitgoJqzcbuvt/wJph7+enkCXIJcrakldw1A1zflFLXD
         D0vfzDzAKuhTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D1CC5C0B06; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 06/12] rcu: Make Tiny RCU grace periods visible to polled APIs
Date:   Mon, 20 Jun 2022 15:51:22 -0700
Message-Id: <20220620225128.3842050-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the Tiny RCU implementation of synchronize_rcu()
increment the rcu_ctrlblk.gp_seq counter, thus making both
synchronize_rcu() and synchronize_rcu_expedited() visible to
get_state_synchronize_rcu() and friends.

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tiny.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dbee6bea67269..60071817d9399 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -139,8 +139,10 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
 /*
  * Wait for a grace period to elapse.  But it is illegal to invoke
  * synchronize_rcu() from within an RCU read-side critical section.
- * Therefore, any legal call to synchronize_rcu() is a quiescent
- * state, and so on a UP system, synchronize_rcu() need do nothing.
+ * Therefore, any legal call to synchronize_rcu() is a quiescent state,
+ * and so on a UP system, synchronize_rcu() need do nothing, other than
+ * let the polled APIs know that another grace period elapsed.
+ *
  * (But Lai Jiangshan points out the benefits of doing might_sleep()
  * to reduce latency.)
  *
@@ -152,6 +154,7 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
+	WRITE_ONCE(rcu_ctrlblk.gp_seq, rcu_ctrlblk.gp_seq + 2);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-- 
2.31.1.189.g2e36527f23

