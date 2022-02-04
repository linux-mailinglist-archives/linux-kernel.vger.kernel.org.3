Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEB4AA479
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378407AbiBDXj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378247AbiBDXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0CE025B34;
        Fri,  4 Feb 2022 15:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E0761CAB;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD1CC340F9;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=vMfcdUf1wVddckJ+Hs5AKckEdG/I81gYVH5ZKNn9rPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Du9GrBbcTixFYdS8ZTNv8eGpml/GYOZkQ78syOhoE+k9dZGyoiOH4fZLIVD/sKd2y
         Z7T7MJ1ZgLfxiPtZF41d2TwVGNYnJDJ3Oc7X7ZHs39cIfFGlksGXJDmQM61AZazQ9e
         SkHJrLBHoZ44LXSahR/vlco0K3WgQ22ANDyi1/31Gr0y+6eUI29PQgctO09im7neTg
         tgXj1DkuXVtEs5cgjyoUMcbSXytKwbBFS/YmkaUa9Yf6ZjT0PL60Q2szsK/OSnqZhW
         vYJiIFb3hxvTyAprfcgBG6TUNEmcAVcj+tZ23L+7DcptS1Sr3hDQDPXlsObZzMWJdI
         59dccLjtUrIVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F37795C0A21; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/19] srcu: Make rcutorture dump the SRCU size state
Date:   Fri,  4 Feb 2022 15:38:50 -0800
Message-Id: <20220204233902.1902-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index fce041b648ee3..550991cc213d3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1400,15 +1400,34 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 }
 EXPORT_SYMBOL_GPL(srcutorture_get_gp_data);
 
+const char * const srcu_size_state_name[] =
+{
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

