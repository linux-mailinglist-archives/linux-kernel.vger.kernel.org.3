Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA663556EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359812AbiFVWv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbiFVWvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:45 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBB740A3E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:43 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y14so22113329qvs.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZ2VmzE2lHGW4TDS5ibElbKctouxZ1GAoFxv9DWSNFQ=;
        b=uAvtO1wTymA1OKGzMjhdAg4Xrl4FVIKHWotoJraXcn07le/b0XJ7l01X76a8WK4Q90
         kmUbwQlNMXoi/6t3IXkCKFj3BN/t49X5NpYdWKYhWTCqUvfHy+wkYe934MhNMPgDiTFa
         hN6xqJX72Ktoan5doV3c3TtrMl4Bo7T3X2iuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZ2VmzE2lHGW4TDS5ibElbKctouxZ1GAoFxv9DWSNFQ=;
        b=BSXZ3NpuKo4reGTLj93kvrgXuUBwAjG/cyUd3VbUqQyezACXSXu6VjIGQmUNNxLi+W
         Udu1JtINVlI7mVjM/lkNMGyELGHMQi6AowGZg6KpMS4zCo2sRRkn/VTqhHwN57Kgbb+S
         /Ap9okn7vrMDXtm33rnHcB5LLCyfo1a22MslsXQdJGCxaq0XwetRbGOz1lg9mS7IhKhA
         KW/lf/d3H/UHNrw1ICX0LFRjF8vNoyerOBOCOyH8k4Tv7407PYj17fmGEyHGb8udnAk+
         NMNDXBSvWFbyAAP1+nBGIZlemsbjB1euY+IpqoHfafcFstX2p/OvF8closmDtnHJ6s43
         wKRg==
X-Gm-Message-State: AJIora/N6QQmnt6BoPuknDoBEGYExGm0/reNni37bXfn33eqmQfE9/CI
        PJWs3F9BDHk8yiq643ujOKo+yQ==
X-Google-Smtp-Source: AGRyM1tPJC4HgfQNhb89caYKVnJktcVYAzMTrPx9I8PteeedjGdtVYdEKZzoNlG7gLoLRzY4NHCDLQ==
X-Received: by 2002:a05:6214:f08:b0:470:519a:168a with SMTP id gw8-20020a0562140f0800b00470519a168amr9962716qvb.29.1655938303002;
        Wed, 22 Jun 2022 15:51:43 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:42 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 2/8] rcu: shrinker for lazy rcu
Date:   Wed, 22 Jun 2022 22:50:56 +0000
Message-Id: <20220622225102.2112026-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622225102.2112026-1-joel@joelfernandes.org>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <vineeth@bitbyteword.org>

The shrinker is used to speed up the free'ing of memory potentially
held by RCU lazy callbacks. RCU kernel module test cases show this to be
effective. Test is introduced in a later patch.

Signed-off-by: Vineeth Pillai <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.h | 14 +++++++++--
 kernel/rcu/tree_nocb.h     | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index c3d7de65b689..cf71425dbb5e 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,16 +15,26 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+#ifdef CONFIG_RCU_LAZY
 /* Return number of callbacks in the specified callback list. */
 static inline long rcu_cblist_n_lazy_cbs(struct rcu_cblist *rclp)
 {
-#ifdef CONFIG_RCU_LAZY
 	return READ_ONCE(rclp->lazy_len);
+}
+
+static inline void rcu_cblist_reset_lazy_len(struct rcu_cblist *rclp)
+{
+	WRITE_ONCE(rclp->lazy_len, 0);
+}
 #else
+static inline long rcu_cblist_n_lazy_cbs(struct rcu_cblist *rclp)
+{
 	return 0;
-#endif
 }
 
+static inline void rcu_cblist_reset_lazy_len(struct rcu_cblist *rclp) {}
+#endif
+
 /* Return number of callbacks in segmented callback list by summing seglen. */
 long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b9244f22e102..2f5da12811a5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1207,6 +1207,51 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+static unsigned long
+lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc) {
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		count += rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
+	}
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static unsigned long
+lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc) {
+	int cpu;
+	unsigned long flags;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		int _count = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
+		if (_count == 0)
+			continue;
+		rcu_nocb_lock_irqsave(rdp, flags);
+		rcu_cblist_reset_lazy_len(&rdp->nocb_bypass);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		wake_nocb_gp(rdp, false);
+		sc->nr_to_scan -= _count;
+		count += _count;
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+	return count ? count : SHRINK_STOP;
+}
+
+static struct shrinker lazy_rcu_shrinker = {
+	.count_objects = lazy_rcu_shrink_count,
+	.scan_objects = lazy_rcu_shrink_scan,
+	.batch = 0,
+	.seeks = DEFAULT_SEEKS,
+};
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -1244,6 +1289,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-- 
2.37.0.rc0.104.g0611611a94-goog

