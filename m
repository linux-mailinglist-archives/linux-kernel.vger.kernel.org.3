Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120E1587486
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiHAXnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiHAXnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A182D3F32A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659397385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEGgPc6kXu5gJq3u5V+y6qTg7ywEaMnnfFNE/DMiRTs=;
        b=eix1GixDA+jCsE3ncvYQd8HvpCIHT93FCicYJUXb6CClnfa3VqASjVQ/uFukpnBAM7hcWj
        uZ0Spfr2/Jrlw57lIVJ+ggSNBbFkwlEL5AAGB0zyJMzsoRg1mBX4RlzBVriDsJIbR89vWm
        7wNQsMiMY0dOUWe1p43Rn3KbC47wSbk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-Z4xtZyuEOgKvx6CVPQsWhQ-1; Mon, 01 Aug 2022 19:43:04 -0400
X-MC-Unique: Z4xtZyuEOgKvx6CVPQsWhQ-1
Received: by mail-wr1-f69.google.com with SMTP id h18-20020adfaa92000000b0021ec200d50fso2975207wrc.14
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 16:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IEGgPc6kXu5gJq3u5V+y6qTg7ywEaMnnfFNE/DMiRTs=;
        b=n80VzQ8nViAFl8Ha3HB1v6sp9nQBl6URak55J49sBHeXNzhIwRQB5ZVI+jgkkwvP0t
         tNd04adQziVILHxKP/cMfIzLZtwetlzOxzD59gkb1T23P3fJBcwyWx64c+EmWBrQ275m
         L+4OWHzFADWsYWBwR6pteOuEuiC+fPxRZU4a6YYUt6BeJPwf3I8D/i3KIqZECiF1F0FU
         +ZCPo+r8bZzgYa2Kejbb+46VRt/VzT/dgn0a96IR9kyKzbqrb/AvN5S0L10ILV6fImgd
         WYGErF5mgjkjO+2wtNvgYTi9Q1xxKMGBPtkjB2eJPT5iBe3AJ8sst5Co7zOFAuMz+Rkp
         x2vQ==
X-Gm-Message-State: AJIora9BdN+Il1Z3SxgZghSuSs9+k61MiTy++xdM5kNlJ3xjJrL6pYko
        Oy/Y9l61UaSmUC95bMPPnMsflwMYvyTjUSqJZpCErZ0KhbOt97UeFzHpU45Ay3hMG1wkoUGd/+P
        AyKVL/WoGeh2J0wHawKwaCW4=
X-Received: by 2002:a05:600c:3485:b0:3a3:71cf:12ca with SMTP id a5-20020a05600c348500b003a371cf12camr12509707wmq.28.1659397383140;
        Mon, 01 Aug 2022 16:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tt9VBtSPGh3mC9EcQq1e40LVCdxbvJ4b1WifbOvCdYQfXPSqMKbpgLIRXhRlNA/3/jkJopyg==
X-Received: by 2002:a05:600c:3485:b0:3a3:71cf:12ca with SMTP id a5-20020a05600c348500b003a371cf12camr12509701wmq.28.1659397382951;
        Mon, 01 Aug 2022 16:43:02 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c480600b003a31f71c5b8sm23376844wmo.27.2022.08.01.16.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 16:43:01 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v5 1/2] mm/vmstat: Use per cpu variable to track a vmstat discrepancy
Date:   Tue,  2 Aug 2022 00:42:57 +0100
Message-Id: <20220801234258.134609-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801234258.134609-1-atomlin@redhat.com>
References: <20220801234258.134609-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

