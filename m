Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0959157D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiHLSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLSbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6C2E9C2F2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660329069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t++bwPtXfG50NpOvD1A/s4vywozAFXDDPLujSLnotyg=;
        b=ZyJmm+s0wE9umsaMHXCzHyl6CqOs7HkOphP352Bz/mVhs4fwHdN90lrOHNQyaHAXkR6tG8
        xgoiA7qwvwc5lvL95/gRx0GwZSHax1qBLMDCG1z3cqlvzGHw4aHqTaq5VyyBejc3UCtv1K
        ngONLuoSCtk2bxI3z3TeqpCUOFAz0+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-m9ipcWOaMNqre15G0R9xOg-1; Fri, 12 Aug 2022 14:31:04 -0400
X-MC-Unique: m9ipcWOaMNqre15G0R9xOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 210B9811E75;
        Fri, 12 Aug 2022 18:31:02 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95E1F9458A;
        Fri, 12 Aug 2022 18:31:00 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock
Date:   Fri, 12 Aug 2022 14:30:33 -0400
Message-Id: <20220812183033.346425-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A circular locking problem is reported by lockdep due to the following
circular locking dependency.

  +--> cpu_hotplug_lock --> slab_mutex --> kn->active --+
  |                                                     |
  +-----------------------------------------------------+

The forward cpu_hotplug_lock ==> slab_mutex ==> kn->active dependency
happens in

  kmem_cache_destroy():	cpus_read_lock(); mutex_lock(&slab_mutex);
  ==> sysfs_slab_unlink()
      ==> kobject_del()
          ==> kernfs_remove()
	      ==> __kernfs_remove()
	          ==> kernfs_drain(): rwsem_acquire(&kn->dep_map, ...);

The backward kn->active ==> cpu_hotplug_lock dependency happens in

  kernfs_fop_write_iter(): kernfs_get_active();
  ==> slab_attr_store()
      ==> cpu_partial_store()
          ==> flush_all(): cpus_read_lock()

One way to break this circular locking chain is to avoid holding
cpu_hotplug_lock and slab_mutex while deleting the kobject in
sysfs_slab_unlink() which should be equivalent to doing a write_lock
and write_unlock pair of the kn->active virtual lock.

Since the kobject structures are not protected by slab_mutex or the
cpu_hotplug_lock, we can certainly release those locks before doing
the delete operation.

Move sysfs_slab_unlink() and sysfs_slab_release() to the newly
created kmem_cache_release() and call it outside the slab_mutex &
cpu_hotplug_lock critical sections. There will be a slight delay
in the deletion of sysfs files if kmem_cache_release() is called
indirectly from a work function.

Signed-off-by: Waiman Long <longman@redhat.com>
---

 [v3] Move sysfs_slab_unlink() out to kmem_cache_release() and move
      schedule_work() back right after list_add_tail().

 mm/slab_common.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 17996649cfe3..07b948288f84 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -392,6 +392,28 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
+#ifdef SLAB_SUPPORTS_SYSFS
+/*
+ * For a given kmem_cache, kmem_cache_destroy() should only be called
+ * once or there will be a use-after-free problem. The actual deletion
+ * and release of the kobject does not need slab_mutex or cpu_hotplug_lock
+ * protection. So they are now done without holding those locks.
+ *
+ * Note that there will be a slight delay in the deletion of sysfs files
+ * if kmem_cache_release() is called indrectly from a work function.
+ */
+static void kmem_cache_release(struct kmem_cache *s)
+{
+	sysfs_slab_unlink(s);
+	sysfs_slab_release(s);
+}
+#else
+static void kmem_cache_release(struct kmem_cache *s)
+{
+	slab_kmem_cache_release(s);
+}
+#endif
+
 static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 {
 	LIST_HEAD(to_destroy);
@@ -418,11 +440,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 	list_for_each_entry_safe(s, s2, &to_destroy, list) {
 		debugfs_slab_release(s);
 		kfence_shutdown_cache(s);
-#ifdef SLAB_SUPPORTS_SYSFS
-		sysfs_slab_release(s);
-#else
-		slab_kmem_cache_release(s);
-#endif
+		kmem_cache_release(s);
 	}
 }
 
@@ -437,20 +455,11 @@ static int shutdown_cache(struct kmem_cache *s)
 	list_del(&s->list);
 
 	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
-#ifdef SLAB_SUPPORTS_SYSFS
-		sysfs_slab_unlink(s);
-#endif
 		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
 		schedule_work(&slab_caches_to_rcu_destroy_work);
 	} else {
 		kfence_shutdown_cache(s);
 		debugfs_slab_release(s);
-#ifdef SLAB_SUPPORTS_SYSFS
-		sysfs_slab_unlink(s);
-		sysfs_slab_release(s);
-#else
-		slab_kmem_cache_release(s);
-#endif
 	}
 
 	return 0;
@@ -465,14 +474,16 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
+	int refcnt;
+
 	if (unlikely(!s) || !kasan_check_byte(s))
 		return;
 
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
-	s->refcount--;
-	if (s->refcount)
+	refcnt = --s->refcount;
+	if (refcnt)
 		goto out_unlock;
 
 	WARN(shutdown_cache(s),
@@ -481,6 +492,8 @@ void kmem_cache_destroy(struct kmem_cache *s)
 out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
+	if (!refcnt && !(s->flags & SLAB_TYPESAFE_BY_RCU))
+		kmem_cache_release(s);
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
-- 
2.31.1

