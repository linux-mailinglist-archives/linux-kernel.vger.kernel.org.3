Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE24B5C78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiBNVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:19:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiBNVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E49420F4F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644873549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q96OLP5Yl8UkjEdoCatzc1klg8X6Lv50lENo/00OMTY=;
        b=RYXfHa57pY26fvAP3ArhStL+ooPq6dyyVyHr3Gt6xF3XgeIZEkotL1CEl2BuySGy7FyelR
        NK8be1idCPtIomgQPHxhjG98kLnPx9LE5YywE2U0XDF9t0exIBdvkR50dBVLSya0k7v8K9
        pqWyM4W0zI2HhBkrE3mAoYdfzWlnAcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-6Fhu9fOOOiSWMWAnquGI1g-1; Mon, 14 Feb 2022 15:07:35 -0500
X-MC-Unique: 6Fhu9fOOOiSWMWAnquGI1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44CA181431A;
        Mon, 14 Feb 2022 20:07:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14747610A8;
        Mon, 14 Feb 2022 20:07:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2] locking/lockdep: Cleanup reinit_class()
Date:   Mon, 14 Feb 2022 15:07:12 -0500
Message-Id: <20220214200712.43452-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the duplicated WARN_ON_ONCE() tests in reinit_class() with
BUILD_BUG_ON() which have the same effect of making sure that those
lists aren't cleared accidentally because of their placements in the
lock_class structure.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep_types.h | 4 ++++
 kernel/locking/lockdep.c      | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d22430840b53..446d981ae3a2 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -108,6 +108,10 @@ struct lock_class {
 	 */
 	struct list_head		locks_after, locks_before;
 
+	/*
+	 * All the fields that require re-initialization after being zapped
+	 * must be put after "key".
+	 */
 	const struct lockdep_subclass_key *key;
 	unsigned int			subclass;
 	unsigned int			dep_gen_id;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2e6892ec3756..5fb015dc1686 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6011,13 +6011,15 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 
 static void reinit_class(struct lock_class *class)
 {
+	const unsigned int key_offset = offsetof(struct lock_class, key);
+
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > key_offset);
+	BUILD_BUG_ON(offsetof(struct lock_class, locks_after) > key_offset);
+	BUILD_BUG_ON(offsetof(struct lock_class, locks_before) > key_offset);
 	memset_startat(class, 0, key);
-	WARN_ON_ONCE(!class->lock_entry.next);
-	WARN_ON_ONCE(!list_empty(&class->locks_after));
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
 }
 
 static inline int within(const void *addr, void *start, unsigned long size)
-- 
2.27.0

