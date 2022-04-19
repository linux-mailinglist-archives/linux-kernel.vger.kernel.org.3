Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4DF506078
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbiDSAGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbiDSAGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56022520;
        Mon, 18 Apr 2022 17:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57E2612CC;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB0BC385B4;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=TExMxQ+s8VL+lQFQF6UBa6tCSz4HgmmMt09Ph4H2mgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WP4zQvdAs6tW8skCp2dzVy51tOq+QW5m977wUJbWpQdp56UVNsxkZSiYcjzzxtqov
         KXDPM7lL+H2w1aYt8ok8LFu21RAjStpe/KodLqT86Q67GN8Yh1PC9Och3OlWOQEAJ0
         6zokfgPMRPrDsUsQsAUst99VWPZ34KyF3diJXgMI/tWD2XbQki5erTLa8D7+pPmaPU
         DPtAEMRvaJf6ecbRBIpv3uwZdVbnoR3qQsG4x2gG9YgNmisJge4SXDttHX2CYL7niN
         H/Ub1jj0JgmuXdXunYVMudmKIl4Bv/m+UVHDbgQhER3AbPPeqSOAe3uLr3pztj1CNf
         c+YJQ5hatZDXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 59BD25C0DFD; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 07/21] srcu: Make rcutorture dump the SRCU size state
Date:   Mon, 18 Apr 2022 17:03:08 -0700
Message-Id: <20220419000322.3948903-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

This commit adds the numeric and string version of ->srcu_size_state to
the Tree-SRCU-specific portion of the rcutorture output.

[ paulmck: Apply feedback from kernel test robot and Dan Carpenter. ]
[ quic_neeraju: Apply feedback from Jiapeng Chong. ]

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 00f9aed6f7b9..0874e3be6a5a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1407,15 +1407,33 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 }
 EXPORT_SYMBOL_GPL(srcutorture_get_gp_data);
 
+static const char * const srcu_size_state_name[] = {
+	"SRCU_SIZE_SMALL",
+	"SRCU_SIZE_ALLOC",
+	"SRCU_SIZE_WAIT_BARRIER",
+	"SRCU_SIZE_WAIT_CALL",
+	"SRCU_SIZE_WAIT_CBS1",
+	"SRCU_SIZE_WAIT_CBS2",
+	"SRCU_SIZE_WAIT_CBS3",
+	"SRCU_SIZE_WAIT_CBS4",
+	"SRCU_SIZE_BIG",
+	"SRCU_SIZE_???",
+};
+
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 {
 	int cpu;
 	int idx;
 	unsigned long s0 = 0, s1 = 0;
+	int ss_state = READ_ONCE(ssp->srcu_size_state);
+	int ss_state_idx = ss_state;
 
 	idx = ssp->srcu_idx & 0x1;
-	pr_alert("%s%s Tree SRCU g%ld per-CPU(idx=%d):",
-		 tt, tf, rcu_seq_current(&ssp->srcu_gp_seq), idx);
+	if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
+		ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;
+	pr_alert("%s%s Tree SRCU g%ld state %d (%s) per-CPU(idx=%d):",
+		 tt, tf, rcu_seq_current(&ssp->srcu_gp_seq), ss_state,
+		 srcu_size_state_name[ss_state_idx], idx);
 	for_each_possible_cpu(cpu) {
 		unsigned long l0, l1;
 		unsigned long u0, u1;
-- 
2.31.1.189.g2e36527f23

