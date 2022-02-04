Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8C4A9DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376948AbiBDRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376939AbiBDRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643996236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EBwE2vdT3R+yn90gfFOhWS3yL67SYk8R43YGuWDZepg=;
        b=EHiNyDmOXcpKqPjxF4iLYgbR+tdJs9rR6qkLfKesDccg8JWM7FlHg2BiKpSdJsJKPw2yXS
        Kf2maHL3NvTbSF42p7nzoqZno1HhwtIVOaDXCcVeQE1qMuqkY1K00woW5jh9G6AzV3VpTr
        ifK5J0mWoV0MK0/6H9ieqwPDUU/5DqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-jAvjFZXpMDKfK6UsdsQxgA-1; Fri, 04 Feb 2022 12:37:13 -0500
X-MC-Unique: jAvjFZXpMDKfK6UsdsQxgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B88518710FB;
        Fri,  4 Feb 2022 17:37:11 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D2882764;
        Fri,  4 Feb 2022 17:37:11 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8F96E416EEF4; Fri,  4 Feb 2022 14:36:46 -0300 (-03)
Message-ID: <20220204173554.763888172@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Fri, 04 Feb 2022 14:35:44 -0300
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
Subject: [patch v11 07/13] task isolation: sync vmstats conditional on changes
References: <20220204173537.429902988@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than syncing VM-stats on every return to userspace
(or VM-entry), keep track of changes through a per-CPU bool.

This improves performance when enabling task isolated
for vcpu VMs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v11:
- Add TIF_TASK_ISOL bit to thread info flags and use it
  to decide whether to perform task isolation work on
  return to userspace     

 include/linux/vmstat.h |   13 ++++++++++++-
 mm/vmstat.c            |   29 ++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -22,7 +22,18 @@ int sysctl_vm_numa_stat_handler(struct c
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
-void sync_vmstat(void);
+DECLARE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+extern struct static_key vmstat_sync_enabled;
+
+void __sync_vmstat(void);
+static inline void sync_vmstat(void)
+{
+	if (static_key_false(&vmstat_sync_enabled))
+		__sync_vmstat();
+}
+
+void init_sync_vmstat(void);
 #else
 static inline void sync_vmstat(void)
 {
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -334,6 +334,31 @@ void set_pgdat_percpu_threshold(pg_data_
 	}
 }
 
+#ifdef CONFIG_TASK_ISOLATION
+struct static_key vmstat_sync_enabled;
+DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+static inline void mark_vmstat_dirty(void)
+{
+	if (!static_key_false(&vmstat_sync_enabled))
+		return;
+
+	raw_cpu_write(vmstat_dirty, true);
+	set_thread_flag(TIF_TASK_ISOL);
+}
+
+void init_sync_vmstat(void)
+{
+	raw_cpu_write(vmstat_dirty, true);
+	set_thread_flag(TIF_TASK_ISOL);
+}
+EXPORT_SYMBOL_GPL(vmstat_dirty);
+#else
+static inline void mark_vmstat_dirty(void)
+{
+}
+#endif
+
 /*
  * For use when we know that interrupts are disabled,
  * or when we know that preemption is disabled and that
@@ -366,6 +391,7 @@ void __mod_zone_page_state(struct zone *
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -404,6 +430,7 @@ void __mod_node_page_state(struct pglist
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -602,6 +629,7 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	mark_vmstat_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -670,6 +698,7 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	mark_vmstat_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -1087,6 +1116,7 @@ static void fill_contig_page_info(struct
 			info->free_blocks_suitable += blocks <<
 						(order - suitable_order);
 	}
+	mark_vmstat_dirty();
 }
 
 /*
@@ -1443,6 +1473,7 @@ static void walk_zones_in_node(struct se
 		if (!nolock)
 			spin_unlock_irqrestore(&zone->lock, flags);
 	}
+	mark_vmstat_dirty();
 }
 #endif
 
@@ -1512,6 +1543,7 @@ static void pagetypeinfo_showfree_print(
 		}
 		seq_putc(m, '\n');
 	}
+	mark_vmstat_dirty();
 }
 
 /* Print out the free pages at each order for each migatetype */
@@ -1932,6 +1964,7 @@ static void vmstat_update(struct work_st
 				this_cpu_ptr(&vmstat_work),
 				round_jiffies_relative(sysctl_stat_interval));
 	}
+	mark_vmstat_dirty();
 }
 
 /*
@@ -2019,13 +2052,14 @@ static void vmstat_shepherd(struct work_
 }
 
 #ifdef CONFIG_TASK_ISOLATION
-void sync_vmstat(void)
+void __sync_vmstat(void)
 {
 	int cpu;
 
 	cpu = get_cpu();
 
 	refresh_cpu_vm_stats(false);
+	raw_cpu_write(vmstat_dirty, false);
 	put_cpu();
 
 	/*


