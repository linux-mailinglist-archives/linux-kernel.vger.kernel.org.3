Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0F4E42DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiCVPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiCVPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9278126579
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647962496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSrGeq+LJXUTdyfvp379EAo/U/SsVrm3R6qBHMhjEAo=;
        b=BrRviQQOIPyxXQO5C31qsUbZyHTJ50KaubAeXHzKQDRVHS8vXYvwopCjyVcoagjTsaK4h7
        b4jZjnIbLXn+DdsKcOCEBgJQXzkB+4vmKOX9E3grEthRw1w6T2uZS94nNEgSHqc/vqnpho
        i8UsgXtYV+NWUFJ5OjviWFhZ2W+USYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-lh9LcO-2OjObP8fKOcWQcA-1; Tue, 22 Mar 2022 11:21:35 -0400
X-MC-Unique: lh9LcO-2OjObP8fKOcWQcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B60971066558;
        Tue, 22 Mar 2022 15:21:34 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8720D403D188;
        Tue, 22 Mar 2022 15:21:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/3] locking/rwsem: No need to check for handoff bit if wait queue empty
Date:   Tue, 22 Mar 2022 11:20:57 -0400
Message-Id: <20220322152059.2182333-2-longman@redhat.com>
In-Reply-To: <20220322152059.2182333-1-longman@redhat.com>
References: <20220322152059.2182333-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling
more consistent"), the handoff bit is always cleared if the wait queue
becomes empty. There is no need to check for RWSEM_FLAG_HANDOFF when
the wait list is known to be empty.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 69aba4abe104..f71a9693d05a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -977,12 +977,11 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	if (list_empty(&sem->wait_list)) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
-		 * by a writer or has the handoff bit set, this reader can
-		 * exit the slowpath and return immediately as its
-		 * RWSEM_READER_BIAS has already been set in the count.
+		 * by a writer, this reader can exit the slowpath and return
+		 * immediately as its RWSEM_READER_BIAS has already been set
+		 * in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) &
-		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
-- 
2.27.0

