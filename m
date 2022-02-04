Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BE4A9DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377065AbiBDRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:37:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376950AbiBDRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=38DxtezcbsPH3GE2fOqFRXG7ww80lFsCaLv2fHu/vZU=;
        b=OwNmmTLSN+673kwaz0/Iv5rtdQUQuRqtRgxF/RgwkKX61HOJfHtD/lzSsb8BB8g7D0SW63
        /17GslRzCkpQHWwMNVjbXBL2nD7P9qaiMs8veXitF4lPRzcuxsmYNZuGYh1K8rYUWFhf1d
        E2AUuI1iG3u9EduLL5JnVjQ3YoZZALk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-O_9DZqciPCuyJCgftt8nKw-1; Fri, 04 Feb 2022 12:37:40 -0500
X-MC-Unique: O_9DZqciPCuyJCgftt8nKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13A564146;
        Fri,  4 Feb 2022 17:37:38 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABA3210A4B2C;
        Fri,  4 Feb 2022 17:37:11 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A5D754168B9E; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.995206454@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v11 12/13] mm: vmstat_refresh: avoid queueing work item if cpu stats are clean
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to queue work item to run refresh_vm_stats 
on a remote CPU if that CPU has no dirty stats and no per-CPU
allocations for remote nodes.

This fixes sosreport hang (which uses vmstat_refresh) with 
spinning SCHED_FIFO process.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/vmstat.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -1924,6 +1924,31 @@ static bool need_update(int cpu)
 }
 
 #ifdef CONFIG_PROC_FS
+static bool need_drain_remote_zones(int cpu)
+{
+#ifdef CONFIG_NUMA
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_pages *pcp;
+
+		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		if (!pcp->count)
+			continue;
+
+		if (!pcp->expire)
+			continue;
+
+		if (zone_to_nid(zone) == cpu_to_node(cpu))
+			continue;
+
+		return true;
+	}
+#endif
+
+	return false;
+}
+
 static void refresh_vm_stats(struct work_struct *work)
 {
 	refresh_cpu_vm_stats(true);
@@ -1933,8 +1958,12 @@ int vmstat_refresh(struct ctl_table *tab
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
-	int err;
-	int i;
+	int i, cpu;
+	struct work_struct __percpu *works;
+
+	works = alloc_percpu(struct work_struct);
+	if (!works)
+		return -ENOMEM;
 
 	/*
 	 * The regular update, every sysctl_stat_interval, may come later
@@ -1948,9 +1977,19 @@ int vmstat_refresh(struct ctl_table *tab
 	 * transiently negative values, report an error here if any of
 	 * the stats is negative, so we know to go looking for imbalance.
 	 */
-	err = schedule_on_each_cpu(refresh_vm_stats);
-	if (err)
-		return err;
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = per_cpu_ptr(works, cpu);
+
+		INIT_WORK(work, refresh_vm_stats);
+		if (need_update(cpu) || need_drain_remote_zones(cpu))
+			schedule_work_on(cpu, work);
+	}
+	for_each_online_cpu(cpu)
+		flush_work(per_cpu_ptr(works, cpu));
+	cpus_read_unlock();
+	free_percpu(works);
+
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 		/*
 		 * Skip checking stats known to go negative occasionally.


