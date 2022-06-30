Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483FC561D89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbiF3OOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbiF3ONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50316419A9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656597589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GZL7A1rDCS9BWoMyYGxRSSo338VZcyjs0gmjggSCak=;
        b=Etzmo4O4pwCY8kO0u8ilNHRSzcs1R3wYE5wYEOmNMB+WdoDbyqX3Mn/kj+hWDYUi8P2yP4
        dchEWFAV86p6miPxxfWz4U9OZxk4En3BeJVnxZOZfpvTTpo6o5KIq4YIH0wjCh9h1yW3Ke
        kVI7GTKLrHGFNbNK/0lekWO/Q6W/JeY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-YLw-229DPCCjkNgIoXGUaA-1; Thu, 30 Jun 2022 09:59:46 -0400
X-MC-Unique: YLw-229DPCCjkNgIoXGUaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49F7189C7DC;
        Thu, 30 Jun 2022 13:59:45 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC25C815B;
        Thu, 30 Jun 2022 13:59:44 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     will@kernel.org
Cc:     peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, jacob.e.keller@intel.com,
        akpm@linux-foundation.org, linux-sparse@vger.kernel.org,
        cluster-devel@redhat.com, luc.vanoostenryck@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        aahringo@redhat.com
Subject: [RFC 2/2] kref: move kref_put_lock() callback to caller
Date:   Thu, 30 Jun 2022 09:59:34 -0400
Message-Id: <20220630135934.1799248-3-aahringo@redhat.com>
In-Reply-To: <20220630135934.1799248-1-aahringo@redhat.com>
References: <20220630135934.1799248-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the release callback call to the caller of kref_put_lock()
functionality. Since refcount_dec_and_lock() uses __cond_lock() we get
the following warning for e.g. net/sunrpc/svcauth.c:

warning: context imbalance in 'auth_domain_put' - wrong count at exit

The warning occurs now because it seems that before __cond_lock() change
sparse was able to detect the correct locking behaviour. Now it thinks
there is an additional lock acquire. However the __cond_lock()
instrumentation in refcount_dec_and_lock() was making it possible to
avoid sparse warnings by evaluating the return value and unlock the lock
if conditional necessary.

This patch solves the problem by just do the passed release callback
call based by the return value of kref_put_lock() and not inside of
kref_put_lock() and evaluating the return value of
refcount_dec_and_lock() that surprisingly sparse can recognize.

It seems it's only possible to have the one way or the other. This patch
changes the kref_put_lock() in way that it works like
refcount_dec_and_lock() way with __cond_lock().

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/kref.h | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..a70d45940d55 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -68,27 +68,19 @@ static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref)
 	return 0;
 }
 
-static inline int kref_put_mutex(struct kref *kref,
-				 void (*release)(struct kref *kref),
-				 struct mutex *lock)
+static inline bool raw_kref_put_mutex(struct kref *kref, struct mutex *lock)
 {
-	if (refcount_dec_and_mutex_lock(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	return refcount_dec_and_mutex_lock(&kref->refcount, lock);
 }
+#define kref_put_mutex(kref, release, lock) \
+	((raw_kref_put_mutex(kref, lock)) ? ({ release(kref); 1; }) : 0)
 
-static inline int kref_put_lock(struct kref *kref,
-				void (*release)(struct kref *kref),
-				spinlock_t *lock)
+static inline bool raw_kref_put_lock(struct kref *kref, spinlock_t *lock)
 {
-	if (refcount_dec_and_lock(&kref->refcount, lock)) {
-		release(kref);
-		return 1;
-	}
-	return 0;
+	return refcount_dec_and_lock(&kref->refcount, lock);
 }
+#define kref_put_lock(kref, release, lock) \
+	((raw_kref_put_lock(kref, lock)) ? ({ release(kref); 1; }) : 0)
 
 /**
  * kref_get_unless_zero - Increment refcount for object unless it is zero.
-- 
2.31.1

