Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8745A5A9E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiIARgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiIARfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A96357F4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h9-20020a256c09000000b0069671af62ecso4906895ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=p6utfGSGU2ZWrUa6c0eUAGSz6ILgySPKVkHsaiIDl8M=;
        b=LbkT/AkX1WcT/2fyJlqSXegH2trsBNyd6QrbYfZ/YY10o0bOfV+Ix+uJLegE6lSF35
         ne85BxCuyx7lBpnSiZ42TY86RYtZR3AAc5vYrFsx4gBxgTwamIONmdTxtR/0iKqdUJEh
         gCGpqjCaOQV7LzbqDjbUJKDXfAR5/j45YmmGmhxu+HXk+Hwd00xyXauy+PEzZWtLyw4U
         rqIn+41hVfJNUiIovZy6pL0FSV03X1G3rIrczW6PRcfgw8lXvG9gGaQmr8gUZrra+vXa
         CCuSzq9IAYSPtY4Wqdt70146omIRNbSeU/rl39Xw+3e0A38BgKuGXtDi12EMKnqTbGy3
         VnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=p6utfGSGU2ZWrUa6c0eUAGSz6ILgySPKVkHsaiIDl8M=;
        b=SM19pDNbF3jUfQ6svI8OGkKb/MNCMp4G3KGZXBkb+ol7+o1DBE82/ZSKsRlblqAe/w
         L43AkBS2LR5qC9RJpeWuPBsYj9kwe+w+IdhgUNsX/fl4cHOzqIz5cI8RTHH7NvHE4Rbm
         3WvyveCgBhh7MOBq1qvsBabCkND7DlgOMIB5KhRLmzo5vXy8P8OZ13vhvOr2BPwSyoA1
         RBFuKdkstwXL1ZlR6uTFlazUy43phSzvS4lhvRMbJqqs5QT9P3023mwgzvYpkGBzwdn2
         yV94qM0T4gEbc3a5eesBL9qJmmoh8N6PCEubtGvc2/4RfqSaOzJFiOukAAK6+GoxcYFO
         IUeg==
X-Gm-Message-State: ACgBeo0DjUEvQFK7YTxPNS9hoa02NWPOYV8VbPO7rrEQr7vW810if6SW
        mBNHejC6qxxn3eoyAHINOxP4AHtW1TdfMn1mCxsfvOidB0a1JR9AzZjrI/jjmW867K31+KFzt8x
        2e+4TtWvcU0X45fJBqFOl
X-Google-Smtp-Source: AA6agR4JzlVLX4tUxHHNIbaNOZW1dz2wXadaTbKwNizSq+Zw9LDNKeWUkMtSnrbieYwXe2AgTTBR2su3VSU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a81:5cc4:0:b0:327:59f2:d673 with SMTP id
 q187-20020a815cc4000000b0032759f2d673mr22886370ywb.272.1662053726626; Thu, 01
 Sep 2022 10:35:26 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:50 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-3-surenb@google.com>
Subject: [RFC PATCH RESEND 02/28] mm: rcu safe VMA freeing
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Lespinasse <michel@lespinasse.org>

This prepares for page faults handling under VMA lock, looking up VMAs
under protection of an rcu read lock, instead of the usual mmap read lock.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h | 16 +++++++++++-----
 kernel/fork.c            | 13 +++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cf97f3884fda..bed25ef7c994 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -403,12 +403,18 @@ struct anon_vma_name {
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
-	unsigned long vm_start;		/* Our start address within vm_mm. */
-	unsigned long vm_end;		/* The first byte after our end address
-					   within vm_mm. */
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start, vm_end;
 
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
+			/* linked list of VMAs per task, sorted by address */
+			struct vm_area_struct *vm_next, *vm_prev;
+		};
+#ifdef CONFIG_PER_VMA_LOCK
+		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
+#endif
+	};
 
 	struct rb_node vm_rb;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..614872438393 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -481,10 +481,23 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
+#ifdef CONFIG_PER_VMA_LOCK
+static void __vm_area_free(struct rcu_head *head)
+{
+	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
+						  vm_rcu);
+	kmem_cache_free(vm_area_cachep, vma);
+}
+#endif
+
 void vm_area_free(struct vm_area_struct *vma)
 {
 	free_anon_vma_name(vma);
+#ifdef CONFIG_PER_VMA_LOCK
+	call_rcu(&vma->vm_rcu, __vm_area_free);
+#else
 	kmem_cache_free(vm_area_cachep, vma);
+#endif
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
-- 
2.37.2.789.g6183377224-goog

