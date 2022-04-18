Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C4506001
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiDRW4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629252CE28;
        Mon, 18 Apr 2022 15:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C595761155;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356A0C385A7;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=T23Yz4zWKpA2oFr2jAlYdX5ehd6jgS26JMF7aI6PzXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHobq5IfsW7/XWjNQMzAzb0OWrrYP3MtawaQmCDA/ZLHQvpu5i2rQKrrq9kaJVPKV
         /FnfyduhPDzz1/jEFVXOHf9r6nIYDE7ULp2Xpznu2V+K+sxFoykqKiwVkLi2UthkYC
         TMmA3dWvFxa1Ts+g+h6XZMxeApB2oCHeOPEn5E8gSITJ5ccDcknKhGbp27kA0VuhXA
         KcsRiqKZQ1AHeHDQBmzD3gTzSKw0AL4K5VPAPvlFdhgvXsqOSMG2AeRHUP4nHkxm+j
         a0nRDMuVMVkp5X6s9SDE3JuczuvW8CEBYec5/xKohk4uGpw3J/YcLPR1XL0zLrZi4R
         F4DrSGdvl/5Ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E16D95C04C6; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/11] rcu: Fix rcu_preempt_deferred_qs_irqrestore() strict QS reporting
Date:   Mon, 18 Apr 2022 15:53:50 -0700
Message-Id: <20220418225359.3945217-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
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

Suppose we have a kernel built with both CONFIG_RCU_STRICT_GRACE_PERIOD=y
and CONFIG_PREEMPT=y.  Suppose further that an RCU reader from which RCU
core needs a quiescent state ends in rcu_preempt_deferred_qs_irqrestore().
This function will then invoke rcu_report_qs_rdp() in order to immediately
report that quiescent state.  Unfortunately, it will not have cleared
that reader's CPU's rcu_data structure's ->cpu_no_qs.b.norm field.
As a result, rcu_report_qs_rdp() will take an early exit because it
will believe that this CPU has not yet encountered a quiescent state,
and there will be no reporting of the current quiescent state.

This commit therefore causes rcu_preempt_deferred_qs_irqrestore() to
clear the ->cpu_no_qs.b.norm field before invoking rcu_report_qs_rdp().

Kudos to Boqun Feng and Neeraj Upadhyay for helping with analysis of
this issue!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8360d86db1c0..176639c6215f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -486,6 +486,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	t->rcu_read_unlock_special.s = 0;
 	if (special.b.need_qs) {
 		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
+			rdp->cpu_no_qs.b.norm = false;
 			rcu_report_qs_rdp(rdp);
 			udelay(rcu_unlock_delay);
 		} else {
-- 
2.31.1.189.g2e36527f23

