Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF31597646
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbiHQTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbiHQTJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793932ED7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660763352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QjliH6Zbs7SxREI0yAVgUWAGnTR2b2eGLogi48MSCUs=;
        b=WsK0wkOatdbuTT7NXAkOqsGK/g96Qo+FTlOj810C+x52S5mdIHARubDGpH4Vs0JCHGWA+R
        DNstANuhPG8yxn/P0qaDKw1fbOuqF+dqwmsIMcHAhqkIlggKVZ+AJ4gEqFnPyhnasug8aJ
        z4Ka5fbxyl28ynkGreyU+Miv71bq1n0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-fTXZom6eMEu2rTTjmBq4cA-1; Wed, 17 Aug 2022 15:09:11 -0400
X-MC-Unique: fTXZom6eMEu2rTTjmBq4cA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B865E296A609;
        Wed, 17 Aug 2022 19:09:10 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 889C4400E122;
        Wed, 17 Aug 2022 19:09:10 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A417E416D5E9; Wed, 17 Aug 2022 16:08:54 -0300 (-03)
Message-ID: <20220817190221.486745251@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 17 Aug 2022 16:01:37 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v7 1/3] mm/vmstat: Use per cpu variable to track a vmstat discrepancy
References: <20220817190136.096849758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Tomlin <atomlin@redhat.com>

Add CPU-specific variable namely vmstat_dirty to indicate if
a vmstat imbalance is present for a given CPU. Therefore, at the
appropriate time, we can fold all the remaining differentials.

This speeds up quiet_vmstat in case no per-CPU differentials exist.

Based on 
https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/vmstat.c |   54 ++++++++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
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
@@ -367,6 +373,7 @@ void __mod_zone_page_state(struct zone *
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -405,6 +412,7 @@ void __mod_node_page_state(struct pglist
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -603,6 +611,7 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	mark_vmstat_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -671,6 +680,7 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	mark_vmstat_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -825,6 +835,14 @@ static int refresh_cpu_vm_stats(bool do_
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 	int changes = 0;
 
+	/*
+	 * Clear vmstat_dirty before clearing the percpu vmstats.
+	 * If interrupts are enabled, it is possible that an interrupt
+	 * or another task modifies a percpu vmstat, which will
+	 * set vmstat_dirty to true.
+	 */
+	this_cpu_write(vmstat_dirty, false);
+
 	for_each_populated_zone(zone) {
 		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
 #ifdef CONFIG_NUMA
@@ -1949,35 +1967,6 @@ static void vmstat_update(struct work_st
 }
 
 /*
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
-/*
  * Switch off vmstat processing and then fold all the remaining differentials
  * until the diffs stay at zero. The function is used by NOHZ and can only be
  * invoked when tick processing is not active.
@@ -1987,10 +1976,7 @@ void quiet_vmstat(void)
 	if (system_state != SYSTEM_RUNNING)
 		return;
 
-	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
-		return;
-
-	if (!need_update(smp_processor_id()))
+	if (!__this_cpu_read(vmstat_dirty))
 		return;
 
 	/*
@@ -2021,7 +2007,7 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
-		if (!delayed_work_pending(dw) && need_update(cpu))
+		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
 		cond_resched();


