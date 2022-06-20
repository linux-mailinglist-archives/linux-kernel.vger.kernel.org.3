Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F85526D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbiFTWSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFTWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:18:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11470DF33;
        Mon, 20 Jun 2022 15:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 863A7B81649;
        Mon, 20 Jun 2022 22:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF85C3411B;
        Mon, 20 Jun 2022 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763479;
        bh=04DJ1/1K8PMW4hsTpIKiSFs2fsEYB7ypcGETpqL6l6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yh6XneSOsTIuYKGdQ++TLQCmIn/BYK6nrobeOl1jgzTzwLrNcoUTpNZyzzbqap/kk
         O6o9WifBkPji0iir0MewLIADsuAvXjU8dJHxSg4xRx7h35cTfb7hMvYFVuBQV/ApYm
         9dplx2KQdUgDdlUWMRxMtURVmL5pIa+Bz8/901zV7eyzfkfuGAeZdeZPeRjRMMHIQ7
         17NvNC7wmIfgcKE6le7c2Vs8ZVEqLkv/2+FKpujPGaFlg79vlvA5VTciC+2/Dfo+TN
         9WrXTtrEUiGETQC+ENn6p/ta0FCdqiR9ZYYdsiPd3WFhwFp7VIw3VonQB+m+e7OIOh
         qNtg3SAs6bO9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D834A5C05C8; Mon, 20 Jun 2022 15:17:58 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH rcu 2/3] doc: Document the rcutree.rcu_divisor kernel boot parameter
Date:   Mon, 20 Jun 2022 15:17:56 -0700
Message-Id: <20220620221757.3839212-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
References: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
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

This commit adds kernel-parameters.txt documentation for the
rcutree.rcu_divisor kernel boot parameter, which controls the softirq
callback-invocation batch limit.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f2..bdf431bdbfdc4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4666,6 +4666,21 @@
 			When RCU_NOCB_CPU is set, also adjust the
 			priority of NOCB callback kthreads.
 
+	rcutree.rcu_divisor= [KNL]
+			Set the shift-right count to use to compute
+			the callback-invocation batch limit bl from
+			the number of callbacks queued on this CPU.
+			The result will be bounded below by the value of
+			the rcutree.blimit kernel parameter.  Every bl
+			callbacks, the softirq handler will exit in
+			order to allow the CPU to do other work.
+
+			Please note that this callback-invocation batch
+			limit applies only to non-offloaded callback
+			invocation.  Offloaded callbacks are instead
+			invoked in the context of an rcuoc kthread, which
+			scheduler will preempt as it does any other task.
+
 	rcutree.rcu_nocb_gp_stride= [KNL]
 			Set the number of NOCB callback kthreads in
 			each group, which defaults to the square root
-- 
2.31.1.189.g2e36527f23

