Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26F4B1D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbiBKDzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiBKDzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B1E1125
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644551751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7T3Os6oDYB/2abU0AodlQMxDyRkNZMiJu4SBO/39vec=;
        b=C3Tx5/vl+NWNbylQcQr5xMpLouTAOkDX013pmLj+lIDug6hLp34tK6ecECUYoDwdwbDE1w
        FpLLu0WtOqHbvoTAXvT9Rac0rmVNxv2O1OL+i6KNR/Q+kw8Qq5FgMT2d9I02wmYFWl3ZtH
        sGQkBHmMn3b/9kq/MJ8tsjRdLI2+yOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-emkjnUV6PhSxWFGMnqckIQ-1; Thu, 10 Feb 2022 22:55:48 -0500
X-MC-Unique: emkjnUV6PhSxWFGMnqckIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06D351800D50;
        Fri, 11 Feb 2022 03:55:47 +0000 (UTC)
Received: from llong.com (unknown [10.22.19.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A6D84CEE0;
        Fri, 11 Feb 2022 03:55:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/lockdep: Cleanup reinit_class()
Date:   Thu, 10 Feb 2022 22:55:25 -0500
Message-Id: <20220211035526.1329503-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the duplicated WARN_ON_ONCE() tests in reinit_class() with
BUILD_BUG_ON().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep_types.h | 4 ++++
 kernel/locking/lockdep.c      | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

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
index d4252b5c9863..77bbe557d48b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6015,10 +6015,10 @@ static void reinit_class(struct lock_class *class)
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	BUILD_BUG_ON(offsetof(struct lock_class, lock_entry) > offset);
+	BUILD_BUG_ON(offsetof(struct lock_class, locks_after) > offset);
+	BUILD_BUG_ON(offsetof(struct lock_class, locks_before) > offset);
 	memset(p + offset, 0, sizeof(*class) - offset);
-	WARN_ON_ONCE(!class->lock_entry.next);
-	WARN_ON_ONCE(!list_empty(&class->locks_after));
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
 }
 
 static inline int within(const void *addr, void *start, unsigned long size)
-- 
2.27.0

