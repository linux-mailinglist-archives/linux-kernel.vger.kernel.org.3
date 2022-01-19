Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A369493BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355160AbiASOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiASOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:34:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354AC061574;
        Wed, 19 Jan 2022 06:34:45 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p27so10273221lfa.1;
        Wed, 19 Jan 2022 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gtcKcgtvmZFmg0VIhIPJVczT0Y4Ko4N7yPLo6FJsaU=;
        b=CTVyJZhOFXd0Uhsjz/SYbGwrO0OSl7YmKxdCSQX2Fu9DuZuytY5lcNbXAi/VBQ0T91
         EskY3trzJBWqniUHMZkwcMfKHPjk04tSJcGSlcddkKS9BUPWSfu009JZJhc0ZqO4PF5I
         1gYwh7yLbqJDpwFbiMQ2lGEqPFUp2C8jlj962Udf8Jhz5nNV8zDh7DwHJ8bWbF0OVqs0
         39MOuwNiHx/zBGghqpCj5EZo/0AfJSxWO+l563AsGnIYfUJYeGzgDwriBNRW/Ku0SGVE
         2QvPcXXSl+5bjEyxukIkxHaG8Fe0dUtXHaBrvLBnaHKiKrsfKfXCcRcLeC/qYdF+G7Wv
         2qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2gtcKcgtvmZFmg0VIhIPJVczT0Y4Ko4N7yPLo6FJsaU=;
        b=dVNABdRffOY/7mE94W8133Ln00gVA++exx74mDchpnGxtyH7GrRHB6VGjQKwDn1e9q
         7O2Jp8SbzrgLG3OvqbztPcT4zs8UVH434iFuPDpAi3mjNhkCtBLZkK+LZn2EMCA+RelG
         CBnNK6xrss1NrjZBZ1jqgGbvEm1eNglFhI4SQAv15i9tglSZP6PvqErTym/OONGW58fl
         polXZI80KlstKhZ9kz/I3gg4KgPdVtTFrmLyJ+eJKgnbMSNb0M+0XVgQ+Pj3y0W4JI2q
         tGE6d/AJaKJwDsPL4TA7h7TD5qQtWuxcjTLQ/cCMs8uMMc9eed72qL3thg3vY7b/nxDx
         LB3g==
X-Gm-Message-State: AOAM5329OeYGl/qVetAcIZB5961vS26gDb2FnGA99u3l09AdSzTL4FD/
        +3VG2indrUsfy8MdhwuNfWhLD4FRngbRAw==
X-Google-Smtp-Source: ABdhPJxb+IYn0MbdAyX/wwjjLB+3+EHs7BJCHx2hj+Bls82ib0DVT1L5EZwRD+Bk1ayw5lv8rBWUZg==
X-Received: by 2002:a2e:bc0f:: with SMTP id b15mr13611327ljf.8.1642602884218;
        Wed, 19 Jan 2022 06:34:44 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id br14sm546234lfb.14.2022.01.19.06.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:34:43 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/3] mm/vmalloc: Move draining areas out of caller context
Date:   Wed, 19 Jan 2022 15:34:32 +0100
Message-Id: <20220119143434.601059-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A caller initiates the drain procces from its context once the
drain threshold is reached or passed. There are at least two
drawbacks of doing so:

a) a caller can be a high-prio or RT task. In that case it can
   stuck in doing the actual drain of all lazily freed areas.
   This is not optimal because such tasks usually are latency
   sensitive where the control should be returned back as soon
   as possible in order to drive such workloads in time. See
   96e2db456135 ("mm/vmalloc: rework the drain logic")

b) It is not safe to call vfree() during holding a spinlock due
   to the vmap_purge_lock mutex. The was a report about this from
   Zeal Robot <zealci@zte.com.cn> here:
   https://lore.kernel.org/all/20211222081026.484058-1-chi.minghao@zte.com.cn

Moving the drain to the separate work context addresses those
issues.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bdc7222f87d4..ed0f9eaa61a9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -793,6 +793,9 @@ RB_DECLARE_CALLBACKS_MAX(static, free_vmap_area_rb_augment_cb,
 static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
+static void drain_vmap_area(struct work_struct *work);
+static DECLARE_WORK(drain_vmap_area_work, drain_vmap_area);
+static atomic_t drain_vmap_area_work_in_progress;
 
 static atomic_long_t nr_vmalloc_pages;
 
@@ -1719,18 +1722,6 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	return true;
 }
 
-/*
- * Kick off a purge of the outstanding lazy areas. Don't bother if somebody
- * is already purging.
- */
-static void try_purge_vmap_area_lazy(void)
-{
-	if (mutex_trylock(&vmap_purge_lock)) {
-		__purge_vmap_area_lazy(ULONG_MAX, 0);
-		mutex_unlock(&vmap_purge_lock);
-	}
-}
-
 /*
  * Kick off a purge of the outstanding lazy areas.
  */
@@ -1742,6 +1733,23 @@ static void purge_vmap_area_lazy(void)
 	mutex_unlock(&vmap_purge_lock);
 }
 
+static void drain_vmap_area(struct work_struct *work)
+{
+	unsigned long nr_lazy;
+
+	do {
+		mutex_lock(&vmap_purge_lock);
+		__purge_vmap_area_lazy(ULONG_MAX, 0);
+		mutex_unlock(&vmap_purge_lock);
+
+		/* Recheck if further work is required. */
+		nr_lazy = atomic_long_read(&vmap_lazy_nr);
+	} while (nr_lazy > lazy_max_pages());
+
+	/* We are done at this point. */
+	atomic_set(&drain_vmap_area_work_in_progress, 0);
+}
+
 /*
  * Free a vmap area, caller ensuring that the area has been unmapped
  * and flush_cache_vunmap had been called for the correct range
@@ -1768,7 +1776,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 
 	/* After this point, we may free va at any time */
 	if (unlikely(nr_lazy > lazy_max_pages()))
-		try_purge_vmap_area_lazy();
+		if (!atomic_xchg(&drain_vmap_area_work_in_progress, 1))
+			schedule_work(&drain_vmap_area_work);
 }
 
 /*
-- 
2.30.2

