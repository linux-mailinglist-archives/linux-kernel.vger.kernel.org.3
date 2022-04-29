Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE95514A97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbiD2NkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359799AbiD2Njx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:39:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70613CABB4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q12so6523798pgj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieDn4aiMaGLBWCIS3wtwm2RaJ5ulm380NWzDeauNbb4=;
        b=EBM/v5v9b/++wKJ7UyNtJG3hOZtf0D0P421yMRX4mbDxLWaLjOnVd44J8Kojpk1/Jx
         wCFrmBGQ/ceCjK2D4mHXGw0dSrIqtbGqjjBrZNAFATQx+fQ3H5noDNFQwBzJ7OOgtWB+
         JVr1SHNAxpY01lGGs23Wp0T2G74lyX6XkV1W6acl+SBAclRUO5GvysEsfCuAuaRStabd
         GfI7JWXoZkXpXKsQkXGJI8UFEcFsomE5V4M3jZm36E83p3L+E9GJIPbxQ/45XJ5HkdU0
         inXCNH8Zsk7/VEzeqUaBbswbkgOHbaJakh63ipxlq9pP6hJllz+gzTUgl2B+oN4/WO8g
         3ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieDn4aiMaGLBWCIS3wtwm2RaJ5ulm380NWzDeauNbb4=;
        b=4BKTmDZUZiUvuIid52qyWJtlKhkt4AJTwaUtA1ekOi31R4CurQmT1B04U18vuhAeqx
         1lSRtrHVzdAPIEAXzeQvNHHWL7udjhgNhSoJXJhV+V0DFkRPQBJG6YQ+moiDLmjg+kNR
         sI8UYToNJct6u0exy3cGHdrBXqwjfCThmUYIfC+WWAoE2P8ZNaqu+YJpOwMIjqNYMf9z
         ptno+F7GVFvbmMuBFMedPBk7jhVholvY6Sf8PpPXdU/x9yM2dLlroRGaHJNONr3aIEES
         ywdroZyDsUuhjuPLyxmty4q5kFIiPi5k0wAI2dpf/onXRnWaI9COFB+zlzvZayVxK7dC
         uxsw==
X-Gm-Message-State: AOAM530eK5JVa3829p6GtpBR99Ukx1uJSvBSSmdgCme0zGgchbegk6N6
        uMnmVVCVMsIGlhp1JsIQnq//rQ==
X-Google-Smtp-Source: ABdhPJxItc3PJijXr/92XujdPMZZoCsMTMRrNeqFfimvMzqakWNCQB/zCudyZqo7pQwxbtrJvVy/Xg==
X-Received: by 2002:a65:6a56:0:b0:3aa:49b8:ee77 with SMTP id o22-20020a656a56000000b003aa49b8ee77mr32125077pgu.19.1651239392962;
        Fri, 29 Apr 2022 06:36:32 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:36:32 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 03/18] percpu_ref: make percpu_ref_switch_lock per percpu_ref
Date:   Fri, 29 Apr 2022 21:35:37 +0800
Message-Id: <20220429133552.33768-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, percpu_ref uses the global percpu_ref_switch_lock to
protect the mode switching operation. When multiple percpu_ref
perform mode switching at the same time, the lock may become a
performance bottleneck.

This patch introduces per percpu_ref percpu_ref_switch_lock to
fixes this situation.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/percpu-refcount.h |  2 ++
 lib/percpu-refcount.c           | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 75844939a965..eb8695e578fd 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -110,6 +110,8 @@ struct percpu_ref {
 	 */
 	unsigned long		percpu_count_ptr;
 
+	spinlock_t percpu_ref_switch_lock;
+
 	/*
 	 * 'percpu_ref' is often embedded into user structure, and only
 	 * 'percpu_count_ptr' is required in fast path, move other fields
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 3a8906715e09..4336fd1bd77a 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -36,7 +36,6 @@
 
 #define PERCPU_COUNT_BIAS	(1LU << (BITS_PER_LONG - 1))
 
-static DEFINE_SPINLOCK(percpu_ref_switch_lock);
 static DECLARE_WAIT_QUEUE_HEAD(percpu_ref_switch_waitq);
 
 static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
@@ -95,6 +94,7 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 		start_count++;
 
 	atomic_long_set(&data->count, start_count);
+	spin_lock_init(&ref->percpu_ref_switch_lock);
 
 	data->release = release;
 	data->confirm_switch = NULL;
@@ -137,11 +137,11 @@ void percpu_ref_exit(struct percpu_ref *ref)
 	if (!data)
 		return;
 
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	spin_lock_irqsave(&ref->percpu_ref_switch_lock, flags);
 	ref->percpu_count_ptr |= atomic_long_read(&ref->data->count) <<
 		__PERCPU_REF_FLAG_BITS;
 	ref->data = NULL;
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	spin_unlock_irqrestore(&ref->percpu_ref_switch_lock, flags);
 
 	kfree(data);
 }
@@ -287,7 +287,7 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 {
 	struct percpu_ref_data *data = ref->data;
 
-	lockdep_assert_held(&percpu_ref_switch_lock);
+	lockdep_assert_held(&ref->percpu_ref_switch_lock);
 
 	/*
 	 * If the previous ATOMIC switching hasn't finished yet, wait for
@@ -295,7 +295,7 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 	 * isn't in progress, this function can be called from any context.
 	 */
 	wait_event_lock_irq(percpu_ref_switch_waitq, !data->confirm_switch,
-			    percpu_ref_switch_lock);
+			    ref->percpu_ref_switch_lock);
 
 	if (data->force_atomic || percpu_ref_is_dying(ref))
 		__percpu_ref_switch_to_atomic(ref, confirm_switch, sync);
@@ -329,12 +329,12 @@ void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	spin_lock_irqsave(&ref->percpu_ref_switch_lock, flags);
 
 	ref->data->force_atomic = true;
 	__percpu_ref_switch_mode(ref, confirm_switch, sync);
 
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	spin_unlock_irqrestore(&ref->percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic);
 
@@ -376,12 +376,12 @@ void percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	spin_lock_irqsave(&ref->percpu_ref_switch_lock, flags);
 
 	ref->data->force_atomic = false;
 	__percpu_ref_switch_mode(ref, NULL, false);
 
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	spin_unlock_irqrestore(&ref->percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_percpu);
 
@@ -407,7 +407,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	spin_lock_irqsave(&ref->percpu_ref_switch_lock, flags);
 
 	WARN_ONCE(percpu_ref_is_dying(ref),
 		  "%s called more than once on %ps!", __func__,
@@ -417,7 +417,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 	__percpu_ref_switch_mode(ref, confirm_kill, false);
 	percpu_ref_put(ref);
 
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	spin_unlock_irqrestore(&ref->percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
 
@@ -438,12 +438,12 @@ bool percpu_ref_is_zero(struct percpu_ref *ref)
 		return false;
 
 	/* protect us from being destroyed */
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	spin_lock_irqsave(&ref->percpu_ref_switch_lock, flags);
 	if (ref->data)
 		count = atomic_long_read(&ref->data->count);
 	else
 		count = ref->percpu_count_ptr >> __PERCPU_REF_FLAG_BITS;
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	spin_unlock_irqrestore(&ref->percpu_ref_switch_lock, flags);
 
 	return count == 0;
 }
@@ -487,7 +487,7 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 	unsigned long __percpu *percpu_count;
 	unsigned long flags;
 
-	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	spin_lock_irqsave(&ref->percpu_ref_switch_lock, flags);
 
 	WARN_ON_ONCE(!percpu_ref_is_dying(ref));
 	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
@@ -496,6 +496,6 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 	percpu_ref_get(ref);
 	__percpu_ref_switch_mode(ref, NULL, false);
 
-	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+	spin_unlock_irqrestore(&ref->percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_resurrect);
-- 
2.20.1

