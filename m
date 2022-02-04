Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4A4AA39C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355430AbiBDWzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:55:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51526 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355228AbiBDWzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:55:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D876861AE4;
        Fri,  4 Feb 2022 22:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E127C340ED;
        Fri,  4 Feb 2022 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644015309;
        bh=P+ojzxqenLejeCItnmyBFPt2VGf6j96fThZ8UVIBRYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHKmctannmKHUrJzHzmcO/yPgn8p9ryi7B1Cs5nyx66lpnHGpzex8Xr5W/Nh2Wi+U
         jQWn5RHlkeLf3FsrA4RrhVBqVwO6gHGwLu71Q6J22z4bg+NM9SAq83aNSsXdUPUi5Q
         NXjsIffO2T14PbS7gTqkM91g7yr63CjtUoHeIzB5cKexQ9fI3AjadQRUNrgctJruwJ
         V2lx0k8r31B8hCIB+tLzjajKdLk30pZ/zofAqrVAZScOOtt/aVEymNKuiyzLfgVzVd
         cvTSsZNLTGUHe9Szdr4QYbTqzEo5MXmG44VkgDvf2Yi8SjuBbm/EAUYNHjJ+CSIzCV
         NS+BacmVFB4KA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0EF305C0829; Fri,  4 Feb 2022 14:55:09 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] rcu: Mark ->expmask access in synchronize_rcu_expedited_wait()
Date:   Fri,  4 Feb 2022 14:55:06 -0800
Message-Id: <20220204225507.4193113-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
References: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a READ_ONCE() to an access to the rcu_node structure's
->expmask field to prevent compiler mischief.  Detected by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1568c8ef185b2..60197ea24ceb9 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -502,7 +502,8 @@ static void synchronize_rcu_expedited_wait(void)
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
-			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+			mask = READ_ONCE(rnp->expmask);
+			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (rdp->rcu_forced_tick_exp)
 					continue;
-- 
2.31.1.189.g2e36527f23

