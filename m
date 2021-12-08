Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB446D7D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhLHQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:18:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236658AbhLHQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638980101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yAJOTF1Wb6vE93SvpuKBqtjwdtIt5j1CTtRKEnx35ko=;
        b=VW/tVF+2BvcigzBwyIn+DBfZdBEORozxYGo3NR7Jtd5qQyjLjD0lIxZ0uEgLx4kvJCVn5y
        v/jq/RuOeXKYDqAu5PLwsAJ9gyPbFcNf0yRajclhCal/b/XOXy7tS2650vi4h7uZqjkj1c
        dJB9iafWIG9VWiHHiF5hsu9dHHTzZa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-181-Qj-uKcU9NTqF6EFlKOHvzg-1; Wed, 08 Dec 2021 11:14:58 -0500
X-MC-Unique: Qj-uKcU9NTqF6EFlKOHvzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF7D281CCB4;
        Wed,  8 Dec 2021 16:14:56 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A7FC5BE05;
        Wed,  8 Dec 2021 16:14:33 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 48AD5415EE6E; Wed,  8 Dec 2021 13:13:05 -0300 (-03)
Message-ID: <20211208161000.895462515@fuller.cnet>
User-Agent: quilt/0.66
Date:   Wed, 08 Dec 2021 13:09:15 -0300
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
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v8 09/10] mm: vmstat: move need_update
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move need_update() function up in vmstat.c, needed by next patch.
No code changes.

Remove a duplicate comment while at it.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/vmstat.c |   58 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -1865,6 +1865,35 @@ static const struct seq_operations vmsta
 static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
 int sysctl_stat_interval __read_mostly = HZ;
 
+/*
+ * Check if the diffs for a certain cpu indicate that
+ * an update is needed.
+ */
+static bool need_update(int cpu)
+{
+	pg_data_t *last_pgdat = NULL;
+	struct zone *zone;
+
+	for_each_populated_zone(zone) {
+		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		struct per_cpu_nodestat *n;
+
+		/*
+		 * The fast way of checking if there are any vmstat diffs.
+		 */
+		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
+			return true;
+
+		if (last_pgdat == zone->zone_pgdat)
+			continue;
+		last_pgdat = zone->zone_pgdat;
+		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
+		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
+			return true;
+	}
+	return false;
+}
+
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
@@ -1946,35 +1975,6 @@ static void vmstat_update(struct work_st
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


