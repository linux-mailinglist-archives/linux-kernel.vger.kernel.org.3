Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72415A8509
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiHaSIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiHaSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE3E397F;
        Wed, 31 Aug 2022 11:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BE28ACE1EA8;
        Wed, 31 Aug 2022 18:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3734EC433C1;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=HYR3hoM0Ydmx6dDsk73iVgFWt9139ZE43iky0FI7k8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4KXR+uCJLQzTIhgXky3CODmPEstNfZhZHCvQc5yWFxrM6zvl0RBWLUzxESa3wYZ2
         YhFK0UWPGkcmjedf+yzkE2rV14QXLv5YzDRf6cM0h7jfHYNWctzOXXef8mtdFarbH0
         kq9QtElnBHr04r4/z4SSfRdrt/qUm/n6ynQVpf4KIQsYErvoDuso7RBfCv1caMzO/f
         KbzprbFI84uo9PpE2q9VPhVcF00bu2YCYYO4te+9nTsB3KTLSMzRhtVQoE3YK28Vpq
         WW7VjJovstgQSgzFMp4iBNFNtk08qyxSki8jjHre15aMk8Z/OpTeeDmEdVHcjx4vV9
         S3m3viBbKL7TQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAC195C015D; Wed, 31 Aug 2022 11:08:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/10] rcu: Fix rcu_read_unlock_strict() strict QS reporting
Date:   Wed, 31 Aug 2022 11:07:56 -0700
Message-Id: <20220831180805.2693546-1-paulmck@kernel.org>
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

Kernels built with CONFIG_PREEMPT=n and CONFIG_RCU_STRICT_GRACE_PERIOD=y
report the quiescent state directly from the outermost rcu_read_unlock().
However, the current CPU's rcu_data structure's ->cpu_no_qs.b.norm
might still be set, in which case rcu_report_qs_rdp() will exit early,
thus failing to report quiescent state.

This commit therefore causes rcu_read_unlock_strict() to clear
CPU's rcu_data structure's ->cpu_no_qs.b.norm field before invoking
rcu_report_qs_rdp().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 438ecae6bd7e7..86772c95ed0ae 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -824,6 +824,7 @@ void rcu_read_unlock_strict(void)
 	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
 		return;
 	rdp = this_cpu_ptr(&rcu_data);
+	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
 	udelay(rcu_unlock_delay);
 }
-- 
2.31.1.189.g2e36527f23

