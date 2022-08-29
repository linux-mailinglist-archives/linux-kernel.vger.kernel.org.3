Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD65A5618
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiH2VZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiH2VZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:25:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F945A168
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33f8988daecso138732817b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=VHFOj4kfUa3xGA3HxCxfqSH2fyPnkF//iB8ZL7PxHTQ=;
        b=XClgxH8bXaTLY5kgySHmNtvDCCVAB8mjOROUY69yCIkvhLsUcaeiTHEG390LZTJ0UJ
         f+bTq7v3mEXk1WZIYhpvHYfgX0MddKEDnFBtUXG7eI4mzGho1uyo+BRigftRuUZpe5ed
         yTJv9FwpqBMqwvSi+XVWkQi2sCAbfOGrPpu1lkrGFWjYvxB7buAqdmGdNV7OSfwNKssU
         SvorUO1mGFzFR5b/hO2rDfP9WSX1xgC98rCcdyQIaEqfPxTvpPYobfXt4iE+GIx2WNMy
         khAj4t26F+rdvp0rGETv3PRP0ykKrNZPVAZGmSPMWGLG1X6s1pkbIB5IUW2TBK/ZgFFb
         KwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=VHFOj4kfUa3xGA3HxCxfqSH2fyPnkF//iB8ZL7PxHTQ=;
        b=CKBxuEUKK1wm6WDvv6DRsswUfsnUVsg2BJHaYquEFKBSpGybGZB4WFgPEMKa2ILwj5
         wALUf6z/NgXSHlW3A61pkSC74qcH6nOLGjQ3SuOQU9un1To4Wt1fVQX290d9B2J1GiQv
         L6VNQ+pXuqJ63z7ResMfoOBn1MpvUAB/Qsny/ozbBHwf7bPoMMQR+ANnjFWBoiIULfg5
         JASVgcjs9YTRJRQtebc7BxSknVfvTtrbw901gTaAov88xdQanp8ChjHUBO2yVzpis/j8
         ARZm1p9DwQ6avEFzg83cBrsMsWvD+Bgkuc8G8OHUWLkKCjEvvP5svrKfQB03fPhv5Oxf
         oLNw==
X-Gm-Message-State: ACgBeo0vbAOGdzJKPRQyHr5GB1VLe8SS3rhXsxUebF8Wgf9YPeIwudzq
        6YLPnbsdf77l1rhdKgdQ2rJYGhzALiU=
X-Google-Smtp-Source: AA6agR6wyKOqZ82JQBWMvaTOKlqh8vry2Onq3V9mMTZsNJ+QDBtzKC1cVl90fnxR++4fsXM2QhKkAh66mSQ=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a0d:eac9:0:b0:33d:c025:8a74 with SMTP id
 t192-20020a0deac9000000b0033dc0258a74mr11722581ywe.430.1661808342911; Mon, 29
 Aug 2022 14:25:42 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:07 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-5-surenb@google.com>
Subject: [RFC PATCH 04/28] mm: move mmap_lock assert function definitions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mmap_lock assert function definitions up so that they can be used
by other mmap_lock routines.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mmap_lock.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 96e113e23d04..e49ba91bb1f0 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -60,6 +60,18 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
 
 #endif /* CONFIG_TRACING */
 
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
+{
+	lockdep_assert_held_write(&mm->mmap_lock);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
+}
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
@@ -150,18 +162,6 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 	up_read_non_owner(&mm->mmap_lock);
 }
 
-static inline void mmap_assert_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
-static inline void mmap_assert_write_locked(struct mm_struct *mm)
-{
-	lockdep_assert_held_write(&mm->mmap_lock);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
-}
-
 static inline int mmap_lock_is_contended(struct mm_struct *mm)
 {
 	return rwsem_is_contended(&mm->mmap_lock);
-- 
2.37.2.672.g94769d06f0-goog

