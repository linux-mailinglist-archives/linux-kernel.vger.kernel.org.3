Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8B50C1C2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiDVWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiDVWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 864A940E329
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650660224;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yAh6HF4oclUNAmoKp6qIJ40bQfDLz8H5HJE2/XLu63Y=;
        b=dRlMkPFtzS9d20NzskF+9r1O6Lg3KrAlpjNgjmddFWhsdGgLR1i6EuloqbbQAGVmHMPyq4
        PKqg9CkdVhv8B7+ndlWkbw4NvcqFyowtRwvXxmeipsuUykAHvbIm6e7SEpnAvTOHFUeEPW
        f6mLBHYUvLkdGmFSD6BweQn8k0ay7uA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-DXAZYiwlPZ2gAYH_maiFDQ-1; Fri, 22 Apr 2022 16:01:01 -0400
X-MC-Unique: DXAZYiwlPZ2gAYH_maiFDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B4463C0FEC9;
        Fri, 22 Apr 2022 20:00:58 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.19.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A85BDC2811D;
        Fri, 22 Apr 2022 20:00:57 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v2 06/11] smp: use smp_call_private() fron irq_work.c and core.c
Date:   Fri, 22 Apr 2022 16:00:35 -0400
Message-Id: <20220422200040.93813-7-dqiao@redhat.com>
In-Reply-To: <20220422200040.93813-1-dqiao@redhat.com>
References: <20220422200040.93813-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_work.c and core.c should use the cross interface rather than
using a unpublished internal function __smp_call_single_queue.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v1 -> v2: removed 'x' from the function names and change XCALL to SMP_CALL from the new macros

 kernel/irq_work.c   | 4 ++--
 kernel/sched/core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index f7df715ec28e..0d17c9d03d03 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -159,8 +159,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 			if (!irq_work_claim(work))
 				goto out;
 		}
-
-		__smp_call_single_queue(cpu, &work->node.llist);
+		smp_call_private(cpu, (call_single_data_t *)&work->node.llist,
+					SMP_CALL_TYPE_IRQ_WORK);
 	} else {
 		__irq_work_queue_local(work);
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..4fda3dfb887b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3780,7 +3780,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry.llist);
+	smp_call_private(cpu, (call_single_data_t *)&p->wake_entry.llist, SMP_CALL_TYPE_TTWU);
 }
 
 void wake_up_if_idle(int cpu)
-- 
2.27.0

