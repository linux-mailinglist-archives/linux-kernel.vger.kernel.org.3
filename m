Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE6D59763A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiHQTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiHQTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938543C8F5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660763036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n0ItpIZmzr3MlsvmDpXDhuK40hnz/P19I8npZQ9WGtY=;
        b=csCqWcXACqknuGSznQqiO6pqf+b5zNk5akNrrOsWVuFEAEgyTIMejVBmSGD0ZfmT95Pj64
        7Tx5eNEU9SPpfo7Fb7reEHwsOtLprnopcuWS5lWcIVz7SJIuczwdkf28Y1UazzJwfOearT
        aBBAenvv/Xsa7XCri9ulso/eD88KAoQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-ck2z4GR1NhmvDYwC8W9CYg-1; Wed, 17 Aug 2022 15:03:46 -0400
X-MC-Unique: ck2z4GR1NhmvDYwC8W9CYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D844381078F;
        Wed, 17 Aug 2022 19:03:45 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED3B818EB5;
        Wed, 17 Aug 2022 19:03:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 85099416D8A2; Wed, 17 Aug 2022 16:03:26 -0300 (-03)
Message-ID: <20220817190221.608436609@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 17 Aug 2022 16:01:39 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 3/3] mm/vmstat: do not queue vmstat_update if tick is stopped
References: <20220817190136.096849758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the vmstat shepherd, for CPUs that have the tick stopped,
do not queue local work to flush the per-CPU vmstats, since 
in that case the flush is performed on return to
userspace or when entering idle.

Per-cpu pages can be freed remotely from housekeeping CPUs.

Move the quiet_vmstat call after ts->tick_stopped = 1 assignment.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 kernel/time/tick-sched.c |    6 +++---
 mm/vmstat.c              |   22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -29,6 +29,7 @@
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
 #include <linux/migrate.h>
+#include <linux/tick.h>
 
 #include "internal.h"
 
@@ -1973,19 +1974,27 @@ static void vmstat_update(struct work_st
  */
 void quiet_vmstat(void)
 {
+	struct delayed_work *dw;
+
 	if (system_state != SYSTEM_RUNNING)
 		return;
 
 	if (!__this_cpu_read(vmstat_dirty))
 		return;
 
+	refresh_cpu_vm_stats(false);
+
 	/*
-	 * Just refresh counters and do not care about the pending delayed
-	 * vmstat_update. It doesn't fire that often to matter and canceling
-	 * it would be too expensive from this path.
-	 * vmstat_shepherd will take care about that for us.
+	 * If the tick is stopped, cancel any delayed work to avoid
+	 * interruptions to this CPU in the future.
+	 *
+	 * Otherwise just refresh counters and do not care about the pending
+	 * delayed vmstat_update. It doesn't fire that often to matter
+	 * and canceling it would be too expensive from this path.
 	 */
-	refresh_cpu_vm_stats(false);
+	dw = &per_cpu(vmstat_work, smp_processor_id());
+	if (delayed_work_pending(dw) && tick_nohz_tick_stopped())
+		cancel_delayed_work(dw);
 }
 
 /*
@@ -2007,6 +2016,9 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
+		if (tick_nohz_tick_stopped_cpu(cpu))
+			continue;
+
 		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 
Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -905,9 +905,6 @@ static void tick_nohz_stop_tick(struct t
 		ts->do_timer_last = 0;
 	}
 
-	/* Attempt to fold when the idle tick is stopped or not */
-	quiet_vmstat();
-
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
@@ -935,6 +932,9 @@ static void tick_nohz_stop_tick(struct t
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
+	/* Attempt to fold when the idle tick is stopped or not */
+	quiet_vmstat();
+
 	ts->next_tick = tick;
 
 	/*


