Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB05A84FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiHaSGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiHaSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81385E3981;
        Wed, 31 Aug 2022 11:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98E51B82272;
        Wed, 31 Aug 2022 18:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED4EC43142;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969187;
        bh=YULC0Awo0Pmc3BNtKXn9TIdi3s0Oc+2WQtMPeTYpzNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQUcWmkPJrpPakJFFhALVi+buMr/rimCe9eo9vtqxMWvPwSN22Pk1+aMA52vIuQfo
         sx/JtT95oOe+YpTicgrT362gvTmRzQGMTlZ2GzNJ5btt5A0AmJqTOPsZmouD6pkv2G
         LTZLJXyKAEOR9sB/Le11G7SciQg0d/BmGCjlj7rxqFT6ipIjcOc0tFbL89kJ/2j/R7
         m7uP4oouL7HJ63C+sVrEwdGfCW0JYX5cocAQLZPJJp7JbFbR1smksgbEad6GObxkGM
         3YCT0xGfDiuiPDbYfZwkJ2b61okWEM1Cj0q5MeMYS/NioZHSmHpTmjqO+3N4i8OJ8Q
         fM+M1Y4HFjIug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 013A65C019C; Wed, 31 Aug 2022 11:06:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/7] doc: Call out queue_rcu_work() for blocking RCU callbacks
Date:   Wed, 31 Aug 2022 11:06:20 -0700
Message-Id: <20220831180625.2692892-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180617.GA2692480@paulmck-ThinkPad-P17-Gen-1>
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

The current checklist.rst file correctly notes that RCU callbacks execute
in BH context, and cannot block.  This commit adds words advising people
needing callbacks to block to use workqueues, for example, by replacing
call_rcu() with queue_rcu_work().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 5eedef027d922..2db206fc3465f 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -190,6 +190,9 @@ over a rather long period of time, but improvements are always welcome!
 
 5.	If call_rcu() or call_srcu() is used, the callback function will
 	be called from softirq context.  In particular, it cannot block.
+	If you need the callback to block, run that code in a workqueue
+	handler scheduled from the callback.  The queue_rcu_work()
+	function does this for you in the case of call_rcu().
 
 6.	Since synchronize_rcu() can block, it cannot be called
 	from any sort of irq context.  The same rule applies
-- 
2.31.1.189.g2e36527f23

