Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93B58D272
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiHIDpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiHIDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:45:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654DE00
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:45:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i24so7886346qkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 20:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+HVuUoTv/hcZh+nVQHfE/DwnGU0VTtZkIAwTKHUXkE=;
        b=p6wM30KxXMWYMheCM9NHChPX+30J7zCsg0tW+SXxLonFUZingOyxiKfMLhzBiKcUs7
         GLMVV6xHy/Ihobz7aIE4E7oH3bCXzPi7sCfWC/+axLdfShsiTwn7p+fP9mdDWcMNdQrS
         M+2IxMz+P1abjlRPBLzOfkOdyIdRxin8CtB4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+HVuUoTv/hcZh+nVQHfE/DwnGU0VTtZkIAwTKHUXkE=;
        b=P0oYpYUmvY+5Pm3Zbqx3U6oXNPFobOceSBKYTySwNa4V3CAC5cUNzmcvZ8EvSZr5kx
         JyQdpQHUf8WsX9IvEsyCqOqtLd9D2Pq7wKP5FLk94dHe8IzBDZI0S0NkGRYinsaT/RBs
         ZP4GZ0MUOGLnJafvEGzzopAvRTfm7rMMEVoKJ+nxTKp3wqAE49WO/08VnT2bK99CK7iO
         O34WE1ne4wUhYX1q6xMA6ZM59JS/VV5yzCMC0a2jRQG4NtEIlOA0VLomrRGzyD4zRU32
         zDDpgkM54HOhSBQgTetkVDvZ9LmvGoeaMgOiujQcfT5dhko2o+fW7VfbEsPhIo9Ai+O6
         OyUw==
X-Gm-Message-State: ACgBeo0KE8ZV4vWnguwqhY+XxXuH+n4a1yyE7boKOuVCk2kbn7nTpWNF
        VWkS1nApPORN0NnUD5WhI550MeBGsxy3ZQ==
X-Google-Smtp-Source: AA6agR7MOwPivnTLcWzn3SAKLw+nYkpuMxj95FH/cMuG3ODmwi68cH2fQonJP/RA5m1AEhYyQcJj5Q==
X-Received: by 2002:a05:620a:4611:b0:6b5:fefb:5fb5 with SMTP id br17-20020a05620a461100b006b5fefb5fb5mr16268506qkb.71.1660016724334;
        Mon, 08 Aug 2022 20:45:24 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b0031f0b43629dsm9170979qtb.23.2022.08.08.20.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:45:23 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: [PATCH v3 resend 2/6] rcu: shrinker for lazy rcu
Date:   Tue,  9 Aug 2022 03:45:13 +0000
Message-Id: <20220809034517.3867176-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
In-Reply-To: <20220809034517.3867176-1-joel@joelfernandes.org>
References: <20220809034517.3867176-1-joel@joelfernandes.org>
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

The shrinker is used to speed up the free'ing of memory potentially held
by RCU lazy callbacks. RCU kernel module test cases show this to be
effective. Test is introduced in a later patch.

Signed-off-by: Vineeth Pillai <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 61b1409bd4d6..f8d7255f4f0a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1249,6 +1249,55 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+static unsigned long
+lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		count += rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
+	}
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static unsigned long
+lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long flags;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		int _count = rcu_cblist_n_lazy_cbs(&rdp->nocb_bypass);
+
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
@@ -1286,6 +1335,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-- 
2.37.1.559.g78731f0fdb-goog

