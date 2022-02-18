Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E915E4BAFDD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiBRCwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:52:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiBRCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:52:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE0FBC26
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1627B82550
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4C7C340E8;
        Fri, 18 Feb 2022 02:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645152712;
        bh=pDo91M3PNlrxJHco55R7gPQNSPaQ+ns6guVq0na8uYs=;
        h=Date:To:From:Subject:From;
        b=vow8+OLd/CxePq+a9C9BOiZ9cEb5/ca84jyQUziNh+qFexYwP2i7wIzDsSQhEgGXO
         bDRMuT4xRZzq+HDcC+lDNInwVXsfd97R8KGPatLGddSqt6GPEetBebcZuh/YeCLwzN
         lWKwNC2kjtvF8AIOhIgWlkoKlpYBIr67o0IJ2c+I=
Date:   Thu, 17 Feb 2022 18:51:51 -0800
To:     yzaikin@google.com, keescook@chromium.org,
        zhanglianjie@uniontech.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 2/2] mm: move page-writeback sysctls to their own file
Message-Id: <20220218025152.1B4C7C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhanglianjie <zhanglianjie@uniontech.com>
Subject: mm: move page-writeback sysctls to their own file

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we just
care about the core logic.

So move the page-writeback sysctls to its own file.

[akpm@linux-foundation.org: coding-style cleanups]
akpm@linux-foundation.org: fix CONFIG_SYSCTL=n warnings]
Link: https://lkml.kernel.org/r/20220129012955.26594-1-zhanglianjie@uniontech.com
Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/writeback.h |   15 -----
 kernel/sysctl.c           |   69 ------------------------
 mm/page-writeback.c       |  103 ++++++++++++++++++++++++++++++++----
 3 files changed, 93 insertions(+), 94 deletions(-)

--- a/include/linux/writeback.h~mm-move-page-writeback-sysctls-to-is-own-file
+++ a/include/linux/writeback.h
@@ -345,28 +345,13 @@ void wb_domain_exit(struct wb_domain *do
 extern struct wb_domain global_wb_domain;
 
 /* These are exported to sysctl. */
-extern int dirty_background_ratio;
-extern unsigned long dirty_background_bytes;
-extern int vm_dirty_ratio;
-extern unsigned long vm_dirty_bytes;
 extern unsigned int dirty_writeback_interval;
 extern unsigned int dirty_expire_interval;
 extern unsigned int dirtytime_expire_interval;
-extern int vm_highmem_is_dirtyable;
 extern int laptop_mode;
 
-int dirty_background_ratio_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_background_bytes_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_ratio_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_bytes_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
 int dirtytime_interval_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
-int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
 
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
--- a/kernel/sysctl.c~mm-move-page-writeback-sysctls-to-is-own-file
+++ a/kernel/sysctl.c
@@ -100,8 +100,6 @@
 static const int six_hundred_forty_kb = 640 * 1024;
 #endif
 
-/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
-static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 
 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
@@ -2377,55 +2375,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 	{
-		.procname	= "dirty_background_ratio",
-		.data		= &dirty_background_ratio,
-		.maxlen		= sizeof(dirty_background_ratio),
-		.mode		= 0644,
-		.proc_handler	= dirty_background_ratio_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "dirty_background_bytes",
-		.data		= &dirty_background_bytes,
-		.maxlen		= sizeof(dirty_background_bytes),
-		.mode		= 0644,
-		.proc_handler	= dirty_background_bytes_handler,
-		.extra1		= SYSCTL_LONG_ONE,
-	},
-	{
-		.procname	= "dirty_ratio",
-		.data		= &vm_dirty_ratio,
-		.maxlen		= sizeof(vm_dirty_ratio),
-		.mode		= 0644,
-		.proc_handler	= dirty_ratio_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "dirty_bytes",
-		.data		= &vm_dirty_bytes,
-		.maxlen		= sizeof(vm_dirty_bytes),
-		.mode		= 0644,
-		.proc_handler	= dirty_bytes_handler,
-		.extra1		= (void *)&dirty_bytes_min,
-	},
-	{
-		.procname	= "dirty_writeback_centisecs",
-		.data		= &dirty_writeback_interval,
-		.maxlen		= sizeof(dirty_writeback_interval),
-		.mode		= 0644,
-		.proc_handler	= dirty_writeback_centisecs_handler,
-	},
-	{
-		.procname	= "dirty_expire_centisecs",
-		.data		= &dirty_expire_interval,
-		.maxlen		= sizeof(dirty_expire_interval),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
 		.maxlen		= sizeof(dirtytime_expire_interval),
@@ -2597,13 +2546,6 @@ static struct ctl_table vm_table[] = {
 	},
 #endif
 	{
-		.procname	= "laptop_mode",
-		.data		= &laptop_mode,
-		.maxlen		= sizeof(laptop_mode),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
 		.procname	= "vfs_cache_pressure",
 		.data		= &sysctl_vfs_cache_pressure,
 		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
@@ -2700,17 +2642,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif
-#ifdef CONFIG_HIGHMEM
-	{
-		.procname	= "highmem_is_dirtyable",
-		.data		= &vm_highmem_is_dirtyable,
-		.maxlen		= sizeof(vm_highmem_is_dirtyable),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_MEMORY_FAILURE
 	{
 		.procname	= "memory_failure_early_kill",
--- a/mm/page-writeback.c~mm-move-page-writeback-sysctls-to-is-own-file
+++ a/mm/page-writeback.c
@@ -70,30 +70,33 @@ static long ratelimit_pages = 32;
 /*
  * Start background writeback (via writeback threads) at this percentage
  */
-int dirty_background_ratio = 10;
+static int dirty_background_ratio = 10;
 
 /*
  * dirty_background_bytes starts at 0 (disabled) so that it is a function of
  * dirty_background_ratio * the amount of dirtyable memory
  */
-unsigned long dirty_background_bytes;
+static unsigned long dirty_background_bytes;
 
 /*
  * free highmem will not be subtracted from the total free memory
  * for calculating free ratios if vm_highmem_is_dirtyable is true
  */
-int vm_highmem_is_dirtyable;
+static int vm_highmem_is_dirtyable;
 
 /*
  * The generator of dirty data starts writeback at this percentage
  */
-int vm_dirty_ratio = 20;
+static int vm_dirty_ratio = 20;
+
+/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
+static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 
 /*
  * vm_dirty_bytes starts at 0 (disabled) so that it is a function of
  * vm_dirty_ratio * the amount of dirtyable memory
  */
-unsigned long vm_dirty_bytes;
+static unsigned long vm_dirty_bytes;
 
 /*
  * The interval between `kupdate'-style writebacks
@@ -503,7 +506,8 @@ bool node_dirty_ok(struct pglist_data *p
 	return nr_pages <= limit;
 }
 
-int dirty_background_ratio_handler(struct ctl_table *table, int write,
+#ifdef CONFIG_SYSCTL
+static int dirty_background_ratio_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -514,7 +518,7 @@ int dirty_background_ratio_handler(struc
 	return ret;
 }
 
-int dirty_background_bytes_handler(struct ctl_table *table, int write,
+static int dirty_background_bytes_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -525,7 +529,7 @@ int dirty_background_bytes_handler(struc
 	return ret;
 }
 
-int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
+static int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int old_ratio = vm_dirty_ratio;
@@ -539,7 +543,7 @@ int dirty_ratio_handler(struct ctl_table
 	return ret;
 }
 
-int dirty_bytes_handler(struct ctl_table *table, int write,
+static int dirty_bytes_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned long old_bytes = vm_dirty_bytes;
@@ -552,6 +556,7 @@ int dirty_bytes_handler(struct ctl_table
 	}
 	return ret;
 }
+#endif
 
 static unsigned long wp_next_time(unsigned long cur_time)
 {
@@ -1993,10 +1998,11 @@ bool wb_over_bg_thresh(struct bdi_writeb
 	return false;
 }
 
+#ifdef CONFIG_SYSCTL
 /*
  * sysctl handler for /proc/sys/vm/dirty_writeback_centisecs
  */
-int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
+static int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	unsigned int old_interval = dirty_writeback_interval;
@@ -2017,6 +2023,7 @@ int dirty_writeback_centisecs_handler(st
 
 	return ret;
 }
+#endif
 
 void laptop_mode_timer_fn(struct timer_list *t)
 {
@@ -2081,6 +2088,79 @@ static int page_writeback_cpu_online(uns
 	return 0;
 }
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_page_writeback_sysctls[] = {
+	{
+		.procname   = "dirty_background_ratio",
+		.data       = &dirty_background_ratio,
+		.maxlen     = sizeof(dirty_background_ratio),
+		.mode       = 0644,
+		.proc_handler   = dirty_background_ratio_handler,
+		.extra1     = SYSCTL_ZERO,
+		.extra2     = SYSCTL_ONE_HUNDRED,
+	},
+	{
+		.procname   = "dirty_background_bytes",
+		.data       = &dirty_background_bytes,
+		.maxlen     = sizeof(dirty_background_bytes),
+		.mode       = 0644,
+		.proc_handler   = dirty_background_bytes_handler,
+		.extra1     = SYSCTL_LONG_ONE,
+	},
+	{
+		.procname   = "dirty_ratio",
+		.data       = &vm_dirty_ratio,
+		.maxlen     = sizeof(vm_dirty_ratio),
+		.mode       = 0644,
+		.proc_handler   = dirty_ratio_handler,
+		.extra1     = SYSCTL_ZERO,
+		.extra2     = SYSCTL_ONE_HUNDRED,
+	},
+	{
+		.procname   = "dirty_bytes",
+		.data       = &vm_dirty_bytes,
+		.maxlen     = sizeof(vm_dirty_bytes),
+		.mode       = 0644,
+		.proc_handler   = dirty_bytes_handler,
+		.extra1     = (void *)&dirty_bytes_min,
+	},
+	{
+		.procname   = "dirty_writeback_centisecs",
+		.data       = &dirty_writeback_interval,
+		.maxlen     = sizeof(dirty_writeback_interval),
+		.mode       = 0644,
+		.proc_handler   = dirty_writeback_centisecs_handler,
+	},
+	{
+		.procname   = "dirty_expire_centisecs",
+		.data       = &dirty_expire_interval,
+		.maxlen     = sizeof(dirty_expire_interval),
+		.mode       = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1     = SYSCTL_ZERO,
+	},
+#ifdef CONFIG_HIGHMEM
+	{
+		.procname	= "highmem_is_dirtyable",
+		.data		= &vm_highmem_is_dirtyable,
+		.maxlen		= sizeof(vm_highmem_is_dirtyable),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif
+	{
+		.procname	= "laptop_mode",
+		.data		= &laptop_mode,
+		.maxlen		= sizeof(laptop_mode),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_jiffies,
+	},
+	{}
+};
+#endif
+
 /*
  * Called early on to tune the page writeback dirty limits.
  *
@@ -2105,6 +2185,9 @@ void __init page_writeback_init(void)
 			  page_writeback_cpu_online, NULL);
 	cpuhp_setup_state(CPUHP_MM_WRITEBACK_DEAD, "mm/writeback:dead", NULL,
 			  page_writeback_cpu_online);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", vm_page_writeback_sysctls);
+#endif
 }
 
 /**
_
