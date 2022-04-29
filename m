Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3498514A95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352199AbiD2Njw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351569AbiD2Njq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:39:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D3CB002
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so7286133pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMZmZ4AGQljuOcKnvNnlPkQjL1BDLadEZvUt3w1Anw8=;
        b=iNbXqvglmSrqfFNb3nFzL0dKEc6ia3WcRkU7xNMP/tHBQSotTfWchC6ouLupv7gKG6
         mjLWcX7CspmW80y0Qeb/TyGyZZi5yxh/EQGlKJWLIMropwa6Iv2OOK9jr2sYgcXxprZ5
         UEr8ImcwooRjwwOIzUNVOu/4dBlKsJNZb0ph4n9C1AkUYJhYk1T7s4n+e/UvC/IBJXiH
         lelZrCLgW31cqCdXshBxLBAl5D20bnxmQwk5IutcdRzkuh3QaA7GJQaxil8805VZ+bKL
         LtZQu7le0S6cehGWwU6lFsz62Ehg8Ne/le2UyAqsY2z4SBsgcZzowDkcSOqKwQ72hUWd
         Ry/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMZmZ4AGQljuOcKnvNnlPkQjL1BDLadEZvUt3w1Anw8=;
        b=B+Dr6/yH3o3nA6kEEDslVGqpaxh81HBf8Ri4XePsFPLRSm4I43IOxAzHbyQKnMGpkZ
         ySOtin+c3/HmdfgcGICpdxQbRBmB4NYnsKxwIY35mALr9e8hagfAstEH9aR8JZlvzGgH
         XT2FNup5sdBzTWkQrK2cjmPb0UPXjntD4Q75J83eIV7g2EUFChkJw6QyYZ1FPNAT7A+9
         mJZHqpdkIkn4G0sjeNPrKiZGkqhfBN+dQqv0aM7yDbwLSVBAWhd61tEishMaouXAHuhF
         pMc+PBn4ur6ED3w8haoxwUT12JO4Ml4+Md8hBeLi6T4Rqh2IWVDJg54fnVzDmtj5GM1H
         mmDQ==
X-Gm-Message-State: AOAM530Oa/uhTb0NJtcutXUH2SCSM44GvjSQ2blIEIuvpDEGDui4eT2t
        BttkiqeBS4qqfOxSAL5GOsr2Wg==
X-Google-Smtp-Source: ABdhPJxpxUNyJ4Q8PzIgoCFgG7OivbK5xNlpIRA+PWmaJAKluGlH8xiPo6kD1HPbaMTFamIM9Vs/pw==
X-Received: by 2002:a17:90b:3a89:b0:1d9:b448:a932 with SMTP id om9-20020a17090b3a8900b001d9b448a932mr3941757pjb.173.1651239387248;
        Fri, 29 Apr 2022 06:36:27 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:36:26 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 02/18] percpu_ref: make ref stable after percpu_ref_switch_to_atomic_sync() returns
Date:   Fri, 29 Apr 2022 21:35:36 +0800
Message-Id: <20220429133552.33768-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
before calling percpu_ref_put(), which will cause the value of
percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
returns.

	CPU0				CPU1

percpu_ref_switch_to_atomic_sync(&ref)
--> percpu_ref_switch_to_atomic(&ref)
    --> percpu_ref_get(ref);	/* put after confirmation */
	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);

					percpu_ref_switch_to_atomic_rcu
					--> percpu_ref_call_confirm_rcu
					    --> data->confirm_switch = NULL;
						wake_up_all(&percpu_ref_switch_waitq);

    /* here waiting to wake up */
    wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
						(A)percpu_ref_put(ref);
/* The value of &ref is unstable! */
percpu_ref_is_zero(&ref)
						(B)percpu_ref_put(ref);

As shown above, assuming that the counts on each cpu add up to 0 before
calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
to atomic mode, percpu_ref_is_zero() can return true. But actually it will
return different values in the two cases of A and B, which is not what
we expected.

Now there are two users of percpu_ref_switch_to_atomic_sync() in the kernel:

	i. mddev->writes_pending in the driver/md/md.c
	ii. q->q_usage_counter in the block/blk-pm.c

And they are all used as shown above. In the worst case, percpu_ref_is_zero()
may not hold because of the case B every time. While this is unlikely to occur
in a production environment, it is a problem.

This patch moves percpu_ref_put() out of the rcu handler and call it after
wait_event(), which can makes ref stable after percpu_ref_switch_to_atomic_sync()
returns. Then in the example above, percpu_ref_is_zero() can see a steady 0 value,
which is what we would expect.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/percpu-refcount.h |  4 ++-
 lib/percpu-refcount.c           | 56 +++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..75844939a965 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -98,6 +98,7 @@ struct percpu_ref_data {
 	percpu_ref_func_t	*confirm_switch;
 	bool			force_atomic:1;
 	bool			allow_reinit:1;
+	bool			sync:1;
 	struct rcu_head		rcu;
 	struct percpu_ref	*ref;
 };
@@ -123,7 +124,8 @@ int __must_check percpu_ref_init(struct percpu_ref *ref,
 				 gfp_t gfp);
 void percpu_ref_exit(struct percpu_ref *ref);
 void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
-				 percpu_ref_func_t *confirm_switch);
+				 percpu_ref_func_t *confirm_switch,
+				 bool sync);
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref);
 void percpu_ref_switch_to_percpu(struct percpu_ref *ref);
 void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index af9302141bcf..3a8906715e09 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -99,6 +99,7 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	data->release = release;
 	data->confirm_switch = NULL;
 	data->ref = ref;
+	data->sync = false;
 	ref->data = data;
 	return 0;
 }
@@ -146,21 +147,33 @@ void percpu_ref_exit(struct percpu_ref *ref)
 }
 EXPORT_SYMBOL_GPL(percpu_ref_exit);
 
+static inline void percpu_ref_switch_to_atomic_post(struct percpu_ref *ref)
+{
+	struct percpu_ref_data *data = ref->data;
+
+	if (!data->allow_reinit)
+		__percpu_ref_exit(ref);
+
+	/* drop ref from percpu_ref_switch_to_atomic() */
+	percpu_ref_put(ref);
+}
+
 static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
 {
 	struct percpu_ref_data *data = container_of(rcu,
 			struct percpu_ref_data, rcu);
 	struct percpu_ref *ref = data->ref;
+	bool need_put = true;
+
+	if (data->sync)
+		need_put = data->sync = false;
 
 	data->confirm_switch(ref);
 	data->confirm_switch = NULL;
 	wake_up_all(&percpu_ref_switch_waitq);
 
-	if (!data->allow_reinit)
-		__percpu_ref_exit(ref);
-
-	/* drop ref from percpu_ref_switch_to_atomic() */
-	percpu_ref_put(ref);
+	if (need_put)
+		percpu_ref_switch_to_atomic_post(ref);
 }
 
 static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
@@ -210,14 +223,19 @@ static void percpu_ref_noop_confirm_switch(struct percpu_ref *ref)
 }
 
 static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
-					  percpu_ref_func_t *confirm_switch)
+					  percpu_ref_func_t *confirm_switch,
+					  bool sync)
 {
 	if (ref->percpu_count_ptr & __PERCPU_REF_ATOMIC) {
 		if (confirm_switch)
 			confirm_switch(ref);
+		if (sync)
+			percpu_ref_get(ref);
 		return;
 	}
 
+	ref->data->sync = sync;
+
 	/* switching from percpu to atomic */
 	ref->percpu_count_ptr |= __PERCPU_REF_ATOMIC;
 
@@ -232,13 +250,16 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
 }
 
-static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
+static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref, bool sync)
 {
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
 	int cpu;
 
 	BUG_ON(!percpu_count);
 
+	if (sync)
+		percpu_ref_get(ref);
+
 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
 		return;
 
@@ -261,7 +282,8 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 }
 
 static void __percpu_ref_switch_mode(struct percpu_ref *ref,
-				     percpu_ref_func_t *confirm_switch)
+				     percpu_ref_func_t *confirm_switch,
+				     bool sync)
 {
 	struct percpu_ref_data *data = ref->data;
 
@@ -276,9 +298,9 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 			    percpu_ref_switch_lock);
 
 	if (data->force_atomic || percpu_ref_is_dying(ref))
-		__percpu_ref_switch_to_atomic(ref, confirm_switch);
+		__percpu_ref_switch_to_atomic(ref, confirm_switch, sync);
 	else
-		__percpu_ref_switch_to_percpu(ref);
+		__percpu_ref_switch_to_percpu(ref, sync);
 }
 
 /**
@@ -302,14 +324,15 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
  * switching to atomic mode, this function can be called from any context.
  */
 void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
-				 percpu_ref_func_t *confirm_switch)
+				 percpu_ref_func_t *confirm_switch,
+				 bool sync)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
 	ref->data->force_atomic = true;
-	__percpu_ref_switch_mode(ref, confirm_switch);
+	__percpu_ref_switch_mode(ref, confirm_switch, sync);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
@@ -325,8 +348,9 @@ EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic);
  */
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref)
 {
-	percpu_ref_switch_to_atomic(ref, NULL);
+	percpu_ref_switch_to_atomic(ref, NULL, true);
 	wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
+	percpu_ref_switch_to_atomic_post(ref);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);
 
@@ -355,7 +379,7 @@ void percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
 	ref->data->force_atomic = false;
-	__percpu_ref_switch_mode(ref, NULL);
+	__percpu_ref_switch_mode(ref, NULL, false);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
@@ -390,7 +414,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 		  ref->data->release);
 
 	ref->percpu_count_ptr |= __PERCPU_REF_DEAD;
-	__percpu_ref_switch_mode(ref, confirm_kill);
+	__percpu_ref_switch_mode(ref, confirm_kill, false);
 	percpu_ref_put(ref);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
@@ -470,7 +494,7 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 
 	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
 	percpu_ref_get(ref);
-	__percpu_ref_switch_mode(ref, NULL);
+	__percpu_ref_switch_mode(ref, NULL, false);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
-- 
2.20.1

