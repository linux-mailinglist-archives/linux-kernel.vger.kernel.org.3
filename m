Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEB25A5098
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiH2Pst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiH2Ps1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E58E4EA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661788105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GIxYeJVZ3AuDfEsQOkmwkGW18m9HV0rDJe5mYfX2jec=;
        b=IVF+0Hbl3YfH0jmlPvN2upCjEe9+RpokBxse/Cz0/tj62zRoN93e0hcK8YteslsyMgrHwd
        ENNbRPP97A7P9hs0aK4Em8iuLn2xG3/wl6V9Ko6CqRHWB23qgUqGDPGujqwAb5BFp4EzpA
        6mM6/ccqNIg96Q9w7lHG/d4HSNHAZRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-D1Qn4vfKMD67meAw8x86Pw-1; Mon, 29 Aug 2022 11:48:24 -0400
X-MC-Unique: D1Qn4vfKMD67meAw8x86Pw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E92D8A520E;
        Mon, 29 Aug 2022 15:48:08 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B3F3492CAE;
        Mon, 29 Aug 2022 15:48:05 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     vbabka@suse.cz
Cc:     linux-mm@kvack.org, rientjes@google.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de
Subject: [PATCH RFC] mm: slub: fix flush_cpu_slab()/__free_slab() invocations in task context.
Date:   Mon, 29 Aug 2022 17:48:05 +0200
Message-Id: <20220829154805.1205507-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
__free_slab() invocations out of IRQ context") moved all flush_cpu_slab()
invocations to the global workqueue to avoid a problem related
with deactivate_slab()/__free_slab() being called from an IRQ context
on PREEMPT_RT kernels.

When the flush_all_cpu_locked() function is called from a task context
the flush_cpu_slab() function should be called directly, without deferring
it to the global workqueue, otherwise a workqueue with the WQ_MEM_RECLAIM
bit set could end up flushing a workqueue without the aforementioned bit,
triggering a dependency issue.

 workqueue: WQ_MEM_RECLAIM nvme-delete-wq:nvme_delete_ctrl_work [nvme_core]
   is flushing !WQ_MEM_RECLAIM events:flush_cpu_slab
 WARNING: CPU: 37 PID: 410 at kernel/workqueue.c:2637
   check_flush_dependency+0x10a/0x120
 Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
 RIP: 0010:check_flush_dependency+0x10a/0x120[  453.262125] Call Trace:
 __flush_work.isra.0+0xbf/0x220
 ? __queue_work+0x1dc/0x420
 flush_all_cpus_locked+0xfb/0x120
 __kmem_cache_shutdown+0x2b/0x320
 kmem_cache_destroy+0x49/0x100
 bioset_exit+0x143/0x190
 blk_release_queue+0xb9/0x100
 kobject_cleanup+0x37/0x130
 nvme_fc_ctrl_free+0xc6/0x150 [nvme_fc]
 nvme_free_ctrl+0x1ac/0x2b0 [nvme_core]

Fixes: 5a836bf6b09f ("mm: slub: move flush_cpu_slab()
invocations __free_slab() invocations out of IRQ context")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 mm/slub.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..d46ee90651d2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2681,30 +2681,34 @@ struct slub_flush_work {
 	bool skip;
 };
 
+static void flush_cpu_slab(void *d)
+{
+	struct kmem_cache *s = d;
+	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
+
+	if (c->slab)
+		flush_slab(s, c);
+
+	unfreeze_partials(s);
+}
+
 /*
  * Flush cpu slab.
  *
  * Called from CPU work handler with migration disabled.
  */
-static void flush_cpu_slab(struct work_struct *w)
+static void flush_cpu_slab_work(struct work_struct *w)
 {
-	struct kmem_cache *s;
-	struct kmem_cache_cpu *c;
 	struct slub_flush_work *sfw;
 
 	sfw = container_of(w, struct slub_flush_work, work);
 
-	s = sfw->s;
-	c = this_cpu_ptr(s->cpu_slab);
-
-	if (c->slab)
-		flush_slab(s, c);
-
-	unfreeze_partials(s);
+	flush_cpu_slab(sfw->s);
 }
 
-static bool has_cpu_slab(int cpu, struct kmem_cache *s)
+static bool has_cpu_slab(int cpu, void *info)
 {
+	struct kmem_cache *s = info;
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	return c->slab || slub_percpu_partial(c);
@@ -2721,13 +2725,18 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
 	lockdep_assert_cpus_held();
 	mutex_lock(&flush_lock);
 
+	if (in_task()) {
+		on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
+		goto unlock_exit;
+	}
+
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
 		if (!has_cpu_slab(cpu, s)) {
 			sfw->skip = true;
 			continue;
 		}
-		INIT_WORK(&sfw->work, flush_cpu_slab);
+		INIT_WORK(&sfw->work, flush_cpu_slab_work);
 		sfw->skip = false;
 		sfw->s = s;
 		schedule_work_on(cpu, &sfw->work);
@@ -2740,6 +2749,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
 		flush_work(&sfw->work);
 	}
 
+unlock_exit:
 	mutex_unlock(&flush_lock);
 }
 
-- 
2.31.1

