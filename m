Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2D4AA474
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378373AbiBDXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47904 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378241AbiBDXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F7F661CAE;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A862C34101;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=N5jnqfLu0rIDFCwoYEN18JsUpJw3bRQcJZW9jv7EzbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mx1x6Z3tsckbbkDcQLaxbGSdko9wjpCJpgpqS3fUnp3WDOwvzTGqFmCDQfDXfvosh
         00zS8VtHbzV5TU/QPm/2Agnevzv9x4E6B0Et9IPIONnV387Tdmq2ZFbU6dKZyyuyid
         wmwa0df42hHC73YchWBFUH65y5IKVDLfgbAQOeDTtCOsQ2uMYq1mJFXE6DutRIzDmq
         8hwohOugZIk7uXKEzeDcPOrFOlyYyUg69sSNXHe6uoWIWFUySH7ibuVJE7j3/eU5Fp
         1hIQ/mFaaxzSxLE56qPamJXJot1A7/71y367TkwseQXWfZQMrn9Wl9I7Ow9tzwdyOi
         AU0INPor/pZVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0A8F85C0F91; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/19] srcu: Prevent cleanup_srcu_struct() from freeing non-dynamic ->sda
Date:   Fri,  4 Feb 2022 15:38:56 -0800
Message-Id: <20220204233902.1902-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 44e998643f483..44bd204498a11 100644
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
index 767487ad5440a..39dc3015dfeba 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -206,8 +206,11 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
-	if (!is_static)
+	ssp->sda_is_static = false;
+	if (!is_static) {
 		ssp->sda = alloc_percpu(struct srcu_data);
+		ssp->sda_is_static = true;
+	}
 	if (!ssp->sda)
 		return -ENOMEM;
 	init_srcu_struct_data(ssp);
@@ -215,7 +218,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && convert_to_big == 1) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
-			if (!is_static) {
+			if (ssp->sda_is_static) {
 				free_percpu(ssp->sda);
 				ssp->sda = NULL;
 			}
@@ -434,8 +437,10 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
-	free_percpu(ssp->sda);
-	ssp->sda = NULL;
+	if (ssp->sda_is_static) {
+		free_percpu(ssp->sda);
+		ssp->sda = NULL;
+	}
 	kfree(ssp->node);
 	ssp->node = NULL;
 	ssp->srcu_size_state = SRCU_SIZE_SMALL;
-- 
2.31.1.189.g2e36527f23

