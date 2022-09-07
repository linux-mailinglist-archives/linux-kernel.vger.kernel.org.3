Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0BE5AFB5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIGEg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIGEgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:36:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E888DEB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:36:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u12-20020a25094c000000b006a9ad6b2cebso2460501ybm.15
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=7xWB4XnyIc05hqp29+Ov/me4j17Vvs2h2ECTnGXauQA=;
        b=SDmUz9LkUVm/33cr2fKGG4SmxGsrw9fW609UlO1Lh2n9kJAvfCfnCBYoBieiLK1YI4
         MPXnoJKs7HxJOBMeo211kZrqk641hONA1Abc3kl7lVLPSE2aHCTST/ZAGe/af7Ia1j+Y
         HSkzyUCEB5QeLvw41TwrGd/TwUv4YIM4WP861pR3jQm7dOBwu7Q0zlxU3M2K1wwpBOpB
         CpJIkspZw9r5LITpRw9Xg679OMVQjNafq6M/iV99mdZ3p+Qr3ZpmS2S+7O4Mi0TM+q+w
         DxfU/ss15LI61VWwYkkQPDsa/qz7JkfaqkZ89EbLkvsgKRetTJhSaS1Vm/9WvgNffImX
         t82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=7xWB4XnyIc05hqp29+Ov/me4j17Vvs2h2ECTnGXauQA=;
        b=qGZEDqotRy/euBvGAZjqbQdCMH7yx6lgHPCmYNV5VAyJ0VeIla5kUImiwyWbzC6ZuB
         A/EYorfJPkPVkvaGPriTkx5piCGwZbWwt7cbVaXd5RJ3kwGUdDecvcgRrv+IrBm/1k1t
         M3S4zksN0ecVRfZqdupQv7TRnPnU1acCa2vpwT1Ofmvkdlvce4Xk6q9FacUsUr3ZFWc4
         deLNmo/yfy6W66/3uqZNfSVrIuyovDHWRLfH2NtLVXgoHopJANclGyItygw8pBc0ptRd
         6y6bbvaq1LoPGdCGCsy4oZqOs4itDkyWb2wTYMZ4AJ1u8zMcvpNtDixHOalsRCtSsShF
         HmTA==
X-Gm-Message-State: ACgBeo031O6Y9kN4eLgeaNJDbn+U3ldjO5ol/AzETTEx+eo7tiWLyr0k
        y3Zqp81WYOAD7qgZMBc8tQrOFMcE/HJRew==
X-Google-Smtp-Source: AA6agR41qApOeAsNTHvyqJlEKDWWr4jqOOSYR9bBI0ISwpTGkM58sXdfS6K35j4AxALrx//Yb7zv/515y/Evow==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:bb44:0:b0:677:24c:308f with SMTP id
 b4-20020a25bb44000000b00677024c308fmr1554313ybk.433.1662525377841; Tue, 06
 Sep 2022 21:36:17 -0700 (PDT)
Date:   Wed,  7 Sep 2022 04:35:36 +0000
In-Reply-To: <20220907043537.3457014-1-shakeelb@google.com>
Mime-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907043537.3457014-3-shakeelb@google.com>
Subject: [PATCH 2/3] memcg: rearrange code
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory patch for easing the review of the follow up patch
which will reduce the memory overhead of memory cgroups.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b195d4ca2a72..d0ccc16ed416 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -669,6 +669,29 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
+/* Subset of vm_event_item to report for memcg event stats */
+static const unsigned int memcg_vm_event_stat[] = {
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
+	PGACTIVATE,
+	PGDEACTIVATE,
+	PGLAZYFREE,
+	PGLAZYFREED,
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+	ZSWPIN,
+	ZSWPOUT,
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_FAULT_ALLOC,
+	THP_COLLAPSE_ALLOC,
+#endif
+};
+
 struct memcg_vmstats_percpu {
 	/* Local (CPU and cgroup) page state & events */
 	long			state[MEMCG_NR_STAT];
@@ -1501,29 +1524,6 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
 }
 
-/* Subset of vm_event_item to report for memcg event stats */
-static const unsigned int memcg_vm_event_stat[] = {
-	PGSCAN_KSWAPD,
-	PGSCAN_DIRECT,
-	PGSTEAL_KSWAPD,
-	PGSTEAL_DIRECT,
-	PGFAULT,
-	PGMAJFAULT,
-	PGREFILL,
-	PGACTIVATE,
-	PGDEACTIVATE,
-	PGLAZYFREE,
-	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-	ZSWPIN,
-	ZSWPOUT,
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	THP_FAULT_ALLOC,
-	THP_COLLAPSE_ALLOC,
-#endif
-};
-
 static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 {
 	struct seq_buf s;
-- 
2.37.2.789.g6183377224-goog

