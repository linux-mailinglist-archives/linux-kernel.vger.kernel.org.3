Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D44DDE37
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiCRQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiCRQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAC2F1D788F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647620198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSrGeq+LJXUTdyfvp379EAo/U/SsVrm3R6qBHMhjEAo=;
        b=YypCkIMlyZiToa5YftQ4IekcmuT6rAX0EtfDw+KXzuS34cvX6LL2a2cg+4dZKDI/7APsC3
        kaakVCfS6+tHC73mTgeyg6SJzBGTtDA+AfUCDS5x014O10sElooGtEtFyZlZSgAqAA9jNr
        bET40fLnpnKouCAQ2DlOwGoFLkVBSgQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-uo_6fWQZMea7a61HeDiMTg-1; Fri, 18 Mar 2022 12:16:35 -0400
X-MC-Unique: uo_6fWQZMea7a61HeDiMTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4330A802803;
        Fri, 18 Mar 2022 16:16:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.19.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 059CA112D182;
        Fri, 18 Mar 2022 16:16:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/rwsem: No need to check for handoff bit if wait queue empty
Date:   Fri, 18 Mar 2022 12:16:08 -0400
Message-Id: <20220318161609.1939957-2-longman@redhat.com>
In-Reply-To: <20220318161609.1939957-1-longman@redhat.com>
References: <20220318161609.1939957-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

