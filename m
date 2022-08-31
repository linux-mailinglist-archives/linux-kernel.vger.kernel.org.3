Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC92E5A84FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiHaSGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiHaSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE3E3947;
        Wed, 31 Aug 2022 11:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECD1961C0C;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE77C4347C;
        Wed, 31 Aug 2022 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969187;
        bh=u6+OpkwptEc2yhoOgNkuvcCrF65KG3Z4JJroWIzxvQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdz2xhPcuQlqdbwWJcq8kGmBxqXYpiBJ3RnaoQOPswiOYyaIxarvXI+u1pljhT8t5
         +baji/Gw2jI8ItXDuxj7JZLN0OY7LmB4Hwk4JM9OPWzSxA6gXurl0kD5A1pQ3X6vya
         fXnuNKlph5Xcq9QWzWZ83Cz9+HRLLXrJQQLEbdo1FeiK6GykBNmJBF6teOqWOyVmUU
         MPNaoXyU/LALbw8ydyp+4FJC9d+dGeijTzOCC14054gSJgZs3L5BZLw7abL3ZVz7/t
         bH9w1RK5duH/Ec6NYjs836YXCPrZ3M/1iamD4ZAOanNqqxvQu9x8wz1tzDVozqmHGL
         oCqRN816FZ+IA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F247A5C015D; Wed, 31 Aug 2022 11:06:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] doc: Emphasize the need for explicit RCU read-side markers
Date:   Wed, 31 Aug 2022 11:06:19 -0700
Message-Id: <20220831180625.2692892-1-paulmck@kernel.org>
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

This commit updates checklist.rst to emphasize the need for explicit
markers for RCU read-side critical sections.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 42cc5d891bd26..5eedef027d922 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -66,8 +66,13 @@ over a rather long period of time, but improvements are always welcome!
 	As a rough rule of thumb, any dereference of an RCU-protected
 	pointer must be covered by rcu_read_lock(), rcu_read_lock_bh(),
 	rcu_read_lock_sched(), or by the appropriate update-side lock.
-	Disabling of preemption can serve as rcu_read_lock_sched(), but
-	is less readable and prevents lockdep from detecting locking issues.
+	Explicit disabling of preemption (preempt_disable(), for example)
+	can serve as rcu_read_lock_sched(), but is less readable and
+	prevents lockdep from detecting locking issues.
+
+	Please not that you *cannot* rely on code known to be built
+	only in non-preemptible kernels.  Such code can and will break,
+	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
 
 	Letting RCU-protected pointers "leak" out of an RCU read-side
 	critical section is every bit as bad as letting them leak out
-- 
2.31.1.189.g2e36527f23

