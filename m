Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B837F52DEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244870AbiESUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiESUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D697B98597
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652993398;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkTt7hc6XhJYTnGQ49PGsqXAQQ5w+haNy7QGBhSzpx4=;
        b=Rr3vjj4X1wFGX7gYTAlLFCSAMwfso7WlARs9SWe/tqkQ21tZOVccmcCWsHXYQwIrJE4Wdl
        P8FzJxN+eOdbq5xw9/2ErxACf5N4qNV+2gk0y+gPnPoe0U5peiaZCg/JvvnPz+GJoa96S6
        YyuO6zSkgT6XTpYKc2xL1cT6NFYw4gE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-JcOn773VOxCFmb8euKDIOw-1; Thu, 19 May 2022 16:49:54 -0400
X-MC-Unique: JcOn773VOxCFmb8euKDIOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B6A53C025C9;
        Thu, 19 May 2022 20:49:54 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.35.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D43611121314;
        Thu, 19 May 2022 20:49:53 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v4 06/11] smp: use smp_call_csd() from irq_work.c and core.c
Date:   Thu, 19 May 2022 16:49:38 -0400
Message-Id: <20220519204943.1079578-7-dqiao@redhat.com>
In-Reply-To: <20220519204943.1079578-1-dqiao@redhat.com>
References: <20220519204943.1079578-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_work.c and core.c should use the cross interface rather than
using a unpublished internal function __smp_call_single_queue.

But this change also exposed unpublished types SMP_CALL_TYPE_TTWU and
SMP_CALL_TYPE_IRQ_WORK. However, this is a temporarily change so that
all kernel clients can call the interface as the first step. A
permanent solution should implement new cross call func() for both
and from there the TTWU and IRQ_WORK types of requests can be processed.
That way, the special TTWU and IRQ_WORK types will not be visible from
the cross call interface. Because this needs to change core.s and
irq_work.c, this should be done with a follow up patch set to reduce
the level of risk.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: Removed 'x' from the function names and change XCALL to
          SMP_CALL from the new macros
v2 -> v3: Modifed the commit comments

 kernel/irq_work.c   | 4 ++--
 kernel/sched/core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..aa67ea2ccb8f 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -159,8 +159,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 			if (!irq_work_claim(work))
 				goto out;
 		}
-
-		__smp_call_single_queue(cpu, &work->node.llist);
+		smp_call_csd(cpu, (call_single_data_t *)&work->node.llist,
+					SMP_CALL_TYPE_IRQ_WORK);
 	} else {
 		__irq_work_queue_local(work);
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..6d1d30bd6220 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3780,7 +3780,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry.llist);
+	smp_call_csd(cpu, (call_single_data_t *)&p->wake_entry.llist, SMP_CALL_TYPE_TTWU);
 }
 
 void wake_up_if_idle(int cpu)
-- 
2.27.0

