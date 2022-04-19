Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5250608B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbiDSAHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997C729811;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2124AB81147;
        Tue, 19 Apr 2022 00:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10929C385BB;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=lyjONtqSbnzzy2uBjKzwL8KfGkjOoSlgn7pyA+mj6/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mkgdn4M5oB9OoSqAu55ZEyQz393wg6gC6DZAwCRubHlDFFbt87VBtGr8Vko7bWh4u
         Iui26/tjpkfUxiXQ+x5dt56JOjUN5+DoBVbxyH7TTp2+rwrmg30EiIDE4d/wqfnkyi
         ZPnYEwaDXU2QvosmHPtStrD4cp15M/624W+rdifuxnDuV3WgSMy283vrOS4xtiXL06
         EZy+myupAat6x0JQHbB06wAanOWOUqVj8dnu5xD/za3V0xL/RtLp7vQMWoxIbpwvYb
         rkuA6hgP+VaGPTqsttKtSrFoXfE/vTxhw93j2+ueym18o18bM0lvpsXY/m1Ub/fZgM
         his/QY6is5SBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 660AC5C2B13; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 14/21] srcu: Prevent cleanup_srcu_struct() from freeing non-dynamic ->sda
Date:   Mon, 18 Apr 2022 17:03:15 -0700
Message-Id: <20220419000322.3948903-14-paulmck@kernel.org>
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

When an srcu_struct structure is created (but not in a kernel module)
by DEFINE_SRCU() and friends, the per-CPU srcu_data structure is
statically allocated.  In all other cases, that structure is obtained
from alloc_percpu(), in which case cleanup_srcu_struct() must invoke
free_percpu() on the resulting ->sda pointer in the srcu_struct pointer.

Which it does.

Except that it also invokes free_percpu() on the ->sda pointer
referencing the statically allocated per-CPU srcu_data structures.
Which free_percpu() is surprisingly OK with.

This commit nevertheless stops cleanup_srcu_struct() from freeing
statically allocated per-CPU srcu_data structures.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 1 +
 kernel/rcu/srcutree.c    | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 44e998643f48..44bd204498a1 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -73,6 +73,7 @@ struct srcu_struct {
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
+	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
 	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
 	struct completion srcu_barrier_completion;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b7138dbe1a2d..7209fd95dde9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -217,6 +217,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
+	ssp->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
@@ -226,7 +227,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 1) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
-			if (!is_static) {
+			if (!ssp->sda_is_static) {
 				free_percpu(ssp->sda);
 				ssp->sda = NULL;
 				return -ENOMEM;
@@ -446,8 +447,10 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
-	free_percpu(ssp->sda);
-	ssp->sda = NULL;
+	if (!ssp->sda_is_static) {
+		free_percpu(ssp->sda);
+		ssp->sda = NULL;
+	}
 	kfree(ssp->node);
 	ssp->node = NULL;
 	ssp->srcu_size_state = SRCU_SIZE_SMALL;
-- 
2.31.1.189.g2e36527f23

