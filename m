Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267FF58CEB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiHHTsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHHTsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AFA018392
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659988108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEGgPc6kXu5gJq3u5V+y6qTg7ywEaMnnfFNE/DMiRTs=;
        b=gtOvi2PB+5zrvHxRYTVa0Ggw0F7BExWG3otpM+4A9aqSDR93tRunV80wUihgqRjEn3AgrZ
        etXrNTfrYi2KE/q983IPXPmsJA6GBU3AqY1D//UnBTDEbF+Zf/RLb77jAs/GKd3J+2qhjP
        hWzpowmyQHOhk1QEWgh319LZyzpF+xw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-5CDCvLSiMOOryVtb8q_5CA-1; Mon, 08 Aug 2022 15:48:27 -0400
X-MC-Unique: 5CDCvLSiMOOryVtb8q_5CA-1
Received: by mail-wm1-f70.google.com with SMTP id r10-20020a1c440a000000b003a538a648a9so2188778wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IEGgPc6kXu5gJq3u5V+y6qTg7ywEaMnnfFNE/DMiRTs=;
        b=EUHhAo3RNCIaxF2Heu1Gtrpq9QN7CJysy9IpX3y0oUz8QNq6J7/ST65FqG5+qMvcjH
         hpN4abQ+f/VYck/EbKsI5q1n2xsLbwcUluYxoY2hpzJBL4M4cQr1BBF1HNsaVVd/aWUB
         mExQvu2SZ9vaFQgeEAQ/naOV6HFJC5bSENkVqS4vxzZdIm+vYAhbGAabgR3J7H1ZRQdo
         LqEPtGekL9HM06Mcs/94nxmvmNGQCI68CceF9SZJ+7/+Ah29jTsGREb/OxJtErQ+S8zg
         Zs2oPFD/G1BUmuku6vSLZNyf00LxT/naix1Urjvyx+UgL4btdHLQxEEhQhDs2y/89zKL
         7afw==
X-Gm-Message-State: ACgBeo0o0GkWDO1o4iWivWEupzalHdqicHfsyFt1QO+8VOf6bNEeCSHY
        HKMCLlFAn+cbctvjHUKKN8rBhxK+XbJEoDmnrp4+NhorstoEIt7wkTx7gA04MA6UGyisqDhob7P
        s2u3cWw8jb/SA1C+EOG3oHNc=
X-Received: by 2002:a05:6000:a13:b0:220:62e6:5f79 with SMTP id co19-20020a0560000a1300b0022062e65f79mr12348661wrb.45.1659988105662;
        Mon, 08 Aug 2022 12:48:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Db4VKdX6HbbVZxJFXbXkTzkfDbMXt99KIC4g2B5bXybiUQFPjoT64TLqnJf38iLorwCfxAA==
X-Received: by 2002:a05:6000:a13:b0:220:62e6:5f79 with SMTP id co19-20020a0560000a1300b0022062e65f79mr12348652wrb.45.1659988105429;
        Mon, 08 Aug 2022 12:48:25 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d5551000000b0021e4f595590sm12076081wrw.28.2022.08.08.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:48:24 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v6 1/2] mm/vmstat: Use per cpu variable to track a vmstat discrepancy
Date:   Mon,  8 Aug 2022 20:48:19 +0100
Message-Id: <20220808194820.676246-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808194820.676246-1-atomlin@redhat.com>
References: <20220808194820.676246-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch incorporates an idea from Marcelo's patch [1] where a
CPU-specific variable namely vmstat_dirty is used to indicate if
a vmstat imbalance is present for a given CPU. Therefore, at the
appropriate time, we can fold all the remaining differentials.

[1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/vmstat.c | 46 +++++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf2..51564b7c85fe 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -195,6 +195,12 @@ void fold_vm_numa_events(void)
 #endif
 
 #ifdef CONFIG_SMP
+static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+static inline void mark_vmstat_dirty(void)
+{
+	this_cpu_write(vmstat_dirty, true);
+}
 
 int calculate_pressure_threshold(struct zone *zone)
 {
@@ -367,6 +373,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -405,6 +412,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -603,6 +611,7 @@ static inline void mod_zone_state(struct zone *zone,
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	mark_vmstat_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -671,6 +680,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	mark_vmstat_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -1873,6 +1883,7 @@ int sysctl_stat_interval __read_mostly = HZ;
 static void refresh_vm_stats(struct work_struct *work)
 {
 	refresh_cpu_vm_stats(true);
+	this_cpu_write(vmstat_dirty, false);
 }
 
 int vmstat_refresh(struct ctl_table *table, int write,
@@ -1937,6 +1948,7 @@ int vmstat_refresh(struct ctl_table *table, int write,
 static void vmstat_update(struct work_struct *w)
 {
 	if (refresh_cpu_vm_stats(true)) {
+		this_cpu_write(vmstat_dirty, false);
 		/*
 		 * Counters were updated so we expect more updates
 		 * to occur in the future. Keep on running the
@@ -1948,35 +1960,6 @@ static void vmstat_update(struct work_struct *w)
 	}
 }
 
-/*
- * Check if the diffs for a certain cpu indicate that
- * an update is needed.
- */
-static bool need_update(int cpu)
-{
-	pg_data_t *last_pgdat = NULL;
-	struct zone *zone;
-
-	for_each_populated_zone(zone) {
-		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
-		struct per_cpu_nodestat *n;
-
-		/*
-		 * The fast way of checking if there are any vmstat diffs.
-		 */
-		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
-			return true;
-
-		if (last_pgdat == zone->zone_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
-		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
-		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
-			return true;
-	}
-	return false;
-}
-
 /*
  * Switch off vmstat processing and then fold all the remaining differentials
  * until the diffs stay at zero. The function is used by NOHZ and can only be
@@ -1990,7 +1973,7 @@ void quiet_vmstat(void)
 	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
 		return;
 
-	if (!need_update(smp_processor_id()))
+	if (!__this_cpu_read(vmstat_dirty))
 		return;
 
 	/*
@@ -2000,6 +1983,7 @@ void quiet_vmstat(void)
 	 * vmstat_shepherd will take care about that for us.
 	 */
 	refresh_cpu_vm_stats(false);
+	__this_cpu_write(vmstat_dirty, false);
 }
 
 /*
@@ -2021,7 +2005,7 @@ static void vmstat_shepherd(struct work_struct *w)
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
-		if (!delayed_work_pending(dw) && need_update(cpu))
+		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
 		cond_resched();
-- 
2.37.1

