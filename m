Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE35020B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiDOCuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348792AbiDOCtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0E45A7740
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649990839;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0HOoTlJ77JIY9PMpW6Wx44RA1KL7bQTqNJ5xqcwRD4=;
        b=drzvB3i5laXrQTuaHJH6RwkePhbHVCDdaPuZBjYZjVsn2p5PB8JL50iGij0QJ7Dsoqkafl
        o5RPN1LjLXfwDRJsQczNGdQIImYAQPt/ubluE+zhDVwD8W1YYU51ndXkeW+Q2d+OC4n4Z7
        UGlfDkOdhnZj8MGPCV/28q2JvObSnRI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-aQkAjkZOMZy_FtsS8RwoqA-1; Thu, 14 Apr 2022 22:47:16 -0400
X-MC-Unique: aQkAjkZOMZy_FtsS8RwoqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B61329AB454;
        Fri, 15 Apr 2022 02:47:15 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.8.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15BA6440ADF;
        Fri, 15 Apr 2022 02:47:15 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH 06/11] smp: use smp_xcall_private() fron irq_work.c and core.c
Date:   Thu, 14 Apr 2022 22:46:56 -0400
Message-Id: <20220415024701.876364-7-dqiao@redhat.com>
In-Reply-To: <20220415024701.876364-1-dqiao@redhat.com>
References: <20220415024701.876364-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_work.c and core.c should use the cross interface rather than
using a unpublished internal function __smp_call_single_queue.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
 kernel/irq_work.c   | 4 ++--
 kernel/sched/core.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index f7df715ec28e..dac94a625665 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -159,8 +159,8 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 			if (!irq_work_claim(work))
 				goto out;
 		}
-
-		__smp_call_single_queue(cpu, &work->node.llist);
+		smp_xcall_private(cpu, (call_single_data_t *)&work->node.llist,
+					XCALL_TYPE_IRQ_WORK);
 	} else {
 		__irq_work_queue_local(work);
 	}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..417355fbe32d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3780,7 +3780,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry.llist);
+	smp_xcall_private(cpu, (call_single_data_t *)&p->wake_entry.llist, XCALL_TYPE_TTWU);
 }
 
 void wake_up_if_idle(int cpu)
-- 
2.27.0

