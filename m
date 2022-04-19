Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B89506096
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiDSAGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C220252B7;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83B53612DB;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA40C385BF;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=dq5EhGRV2Ky6K2MIwwoj/ydAY0Nn8LeiyWw4AjAjknk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdPxWn0X8WovhPqBfABGi2JA5idnO5voDpqxlPRx/LYFSXMhr8uJ0igVjL5Olfo3n
         9YXvZyZp32vewI01Dyz53JtD3GqYT9kHWXSlxh25qmeWSrnPKO8ISqn9wPe7JkziSP
         RbwRRJGedYWe+k/FNluGQPItvRPOUXnrDFtYhh1K9Nj3rt02h2aSqvmqBlXZ78xsD5
         CE0iQScP2CqwzR4p6o2wzCkWv/QRY8JZNbeJInDLzSaROdWzf0rgSrecuPGSHmehyE
         27CtMiAPHe+IUYa7Ssp5mcfCbyaizditBRh/cXDAYoP+odjZgH6Q+pcceD5Tv7EjXm
         kB5yiNQGl1t+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67C505C2DEA; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 15/21] srcu: Explain srcu_funnel_gp_start() call to list_add() is safe
Date:   Mon, 18 Apr 2022 17:03:16 -0700
Message-Id: <20220419000322.3948903-15-paulmck@kernel.org>
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

This commit adds a comment explaining why an unprotected call to
list_add() from srcu_funnel_gp_start() can be safe.  TL;DR: It is only
called during very early boot when we don't have no steeking concurrency!

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7209fd95dde9..64993a172cff 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -776,6 +776,12 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
+
+		// And how can that list_add() in the "else" clause
+		// possibly be safe for concurrent execution?  Well,
+		// it isn't.  And it does not have to be.  After all, it
+		// can only be executed during early boot when there is only
+		// the one boot CPU running with interrupts still disabled.
 		if (likely(srcu_init_done))
 			queue_delayed_work(rcu_gp_wq, &ssp->work,
 					   srcu_get_delay(ssp));
-- 
2.31.1.189.g2e36527f23

