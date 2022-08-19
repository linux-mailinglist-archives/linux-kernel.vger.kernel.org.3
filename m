Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61059A731
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351711AbiHSUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351277AbiHSUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E8A00F2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y18so4222665qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=F0DFzzuR1hRvjFCx5f50gxrlxhxkE8RR47wLjamCGKQ=;
        b=PDRRy8BUg0BVEOmkM3/umMktIdoT0PATsFNsP3S9aQxm0mOktahmyf0W1PnRtMIF1k
         +hYZJlBjP2QS2bHR9G27hjQNi1b7nWu/8M6bLMaPfR20p+8TqhUwB5kWkI/00EKOkwrs
         kJv5t5QsRNzz6hP0aShIFbYqZnM6/c7rwDhDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=F0DFzzuR1hRvjFCx5f50gxrlxhxkE8RR47wLjamCGKQ=;
        b=wb2XMB7wJp4birRNkx667Vxm3h1wv9WrCNDxHvg3jvNILoIso3aKLlhaFHiOCoU3yv
         /b0AdEM89l8SR6MgJJy2D4GAbq9PVgBPQUDwBogO7qL7K+IjPETw+5NW6wBKQJ5BtPyB
         sSUqEeSmKm9LPWGG4dqxr0TxnKnQrlcL+XtXvKmezjFKzWjnL6pXAbRSsHUl8myld73z
         rnJQPk39zyGwioxqvt6szrx9g1/LpqRj0sMGWjsEfjNBahIZg6lxgTJXgXqoCn/9dLuz
         0rIMjvWWuoKTK9VzUwEUWx6aH58MZALM1NZrrgnZK5lj30WaYcuaYYbUFK2O3rjs2/DN
         yTEA==
X-Gm-Message-State: ACgBeo1TmuUSkW2/dfLSF7KZwuaZn5fWdKykq4PIZ2HXGG7LAasEwgCp
        luNrbe8zKzYlXl4pg9hqpARmFInN+/I4Hg==
X-Google-Smtp-Source: AA6agR47nKBv/28eI1huj/AljfLxaiQclxiU4+As9WyDKtjPCt5M3ct1MUu0njaW3f0XwqH8n6XDyQ==
X-Received: by 2002:ac8:5b03:0:b0:343:679b:64f2 with SMTP id m3-20020ac85b03000000b00343679b64f2mr8250251qtw.260.1660942145760;
        Fri, 19 Aug 2022 13:49:05 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Subject: [PATCH v4 02/14] rcu: shrinker for lazy rcu
Date:   Fri, 19 Aug 2022 20:48:45 +0000
Message-Id: <20220819204857.3066329-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
index 55636da76bc2..edb4e59dbf38 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1259,6 +1259,55 @@ int rcu_nocb_cpu_offload(int cpu)
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
@@ -1296,6 +1345,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running)
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
-- 
2.37.2.609.g9ff673ca1a-goog

