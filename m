Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57994AA471
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378280AbiBDXjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378231AbiBDXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED2BE025B2D;
        Fri,  4 Feb 2022 15:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA3A561C36;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A85C004E1;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=4LJKR8LrRJnPaBrRYneeP2Xiv81UOQNEztaGmdaYkWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrzsfZAU6BrQKiS8paJXVOS+vA8vuIFNCndI6SQEWTMRK35sU2o4Iv1IOqMYp1DNE
         EHlAIlGcpJYO5oZO+4gv51pGE2AA5+jI/yqnS2urARjckX3XiMBzOCcRdC7oW384s3
         /3T+UXNUGMnTD0ywBZ5ZN2BJxS6GoT79fkq7Fy/yrOHLverSXhREW/C3S2vNL9g2cZ
         54OmKpSZitYdNPqseO9A8v8uqoG2qeZUvtqWtJJBW+9vn6Gq+7qN1n/EJug33iYA0C
         DH9xPy5u6D6LdVP8mnxiVmQli9LDIQOnpOcO5b6OBubqM4+swyPVj85VsJp/Vch1Ym
         mqe2robaYreAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E77755C0418; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/19] srcu: Tighten cleanup_srcu_struct() GP checks
Date:   Fri,  4 Feb 2022 15:38:44 -0800
Message-Id: <20220204233902.1902-1-paulmck@kernel.org>
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

Currently, cleanup_srcu_struct() checks for a grace period in progress,
but it does not check for a grace period that has not yet started but
which might start at any time.  Such a situation could result in a
use-after-free bug, so this commit adds a check for a grace period that
is needed but not yet started to cleanup_srcu_struct().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6833d88871816..d30e4db04506a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -382,9 +382,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
+	    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
-		pr_info("%s: Active srcu_struct %p state: %d\n",
-			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)));
+		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
+			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
+			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
 	free_percpu(ssp->sda);
-- 
2.31.1.189.g2e36527f23

