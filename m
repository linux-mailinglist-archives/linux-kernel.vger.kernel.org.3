Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCF4AA409
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378012AbiBDXIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377898AbiBDXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82252DF99CE5;
        Fri,  4 Feb 2022 15:08:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE1C61BB6;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218BBC340F5;
        Fri,  4 Feb 2022 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016087;
        bh=B7FvPqeozGPDV9tkcqYeb//UtgSVBahiXAeDSDUUo24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQYQ6V+U0M9A0ZYoUl1E6hknxd/84B6yAj5N6tmmlFgkFkw516jAFK6PzAtcc6cIC
         XlQPgMF0rTfzhNgVZMFPBt2cGYRc5ABd+nB8O6QWD5Ko+Tfku0XqBLYRvyEkYlb5FW
         poraXgASREN6c7pKHn3vDhGGKfLiHhnyEAY4O+aOHzJLvzIkgYCJXnXJsW8iAgwPB2
         MZLqc9XIFLAhDL01TGADSOCTlHTP/xWRs0/crxnJ0Lrlt6DOjEpG21T8PxjWU4ni8k
         2FDdEfdyGJI0pynGLHMrry4NF2WaH1bnfw/GQIVNJ0pRZJKsNpAElwOTdhHoLyzzKd
         65qBiw666a1cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A26005C0A21; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/9] rcu: Uninline multi-use function: finish_rcuwait()
Date:   Fri,  4 Feb 2022 15:08:03 -0800
Message-Id: <20220204230805.4193767-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
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

From: Ingo Molnar <mingo@kernel.org>

This is a rarely used function, so uninlining its 3 instructions
is probably a win or a wash - but the main motivation is to
make <linux/rcuwait.h> independent of task_struct details.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcuwait.h | 6 +-----
 kernel/rcu/update.c     | 7 +++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 61c56cca95c43..8052d34da7826 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -47,11 +47,7 @@ static inline void prepare_to_rcuwait(struct rcuwait *w)
 	rcu_assign_pointer(w->task, current);
 }
 
-static inline void finish_rcuwait(struct rcuwait *w)
-{
-        rcu_assign_pointer(w->task, NULL);
-	__set_current_state(TASK_RUNNING);
-}
+extern void finish_rcuwait(struct rcuwait *w);
 
 #define rcuwait_wait_event(w, condition, state)				\
 ({									\
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 156892c22bb56..df6197f0d5ce8 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -407,6 +407,13 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
 
+void finish_rcuwait(struct rcuwait *w)
+{
+        rcu_assign_pointer(w->task, NULL);
+	__set_current_state(TASK_RUNNING);
+}
+EXPORT_SYMBOL_GPL(finish_rcuwait);
+
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 void init_rcu_head(struct rcu_head *head)
 {
-- 
2.31.1.189.g2e36527f23

