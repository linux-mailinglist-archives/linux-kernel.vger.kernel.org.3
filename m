Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B15A5617
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiH2VZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiH2VZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:25:41 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E5ED53
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id n30-20020a17090a5aa100b001fb0c492d5eso3876529pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=cPhW2Jsm5VYfGL+tNkfF3HbuaaNlLZ4rflaa6thsEZ0=;
        b=Ef83aGWTdm10niN8twSSpG3ds5UuJPZXIlmBxHFg2pzrVEdcovVnDh3P/RYOinFzyL
         56g3s4OBiiWq4sYS4zyOn+I3sJdcQzzrlMjpsAwGpe/6DNb56LumMLV46gfcGkdOoroQ
         Xn2Ez1+n3LVumJ9ul/e3Fo4g/eC812QXSiR/GOAlZ/X37IBJZ8GhOEEF+zxhXhrBOhrA
         wyQ3RxsgNeUblE3TddZPmpCUfJPQ1JoHkMsqbRXnrreQjskaAOAntkxj5MpJLWS1ppBQ
         s3y364HBN4NsSi7BBvtTGWNjoBJVZ6VaguwCOOzVv7z+u5EVx5HkEViGicNoS6cS9car
         5ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=cPhW2Jsm5VYfGL+tNkfF3HbuaaNlLZ4rflaa6thsEZ0=;
        b=vUCD+/JSTxgS+AoyvoIDXIUt01raJEQlBSaZpvI6jplZP6B1Q4OEAeMAqcBp0SgtUi
         EcTqYFYNv2ca1RZJr9KWHoOT2saek8Cz+gD9DGQ7iEQF2zt3GJC7f9X29yoHMq4piVf6
         xDIfepskCEvaXpuWcGC3aQ/xvnUDvjTkp3dEGcF0l8Gw/HP8dp/W8RIG21Gt/BMaAktz
         pvVQvM644X2iMRH6Raupdq2qQU5w1fTeJzSG3ha6LVqlIdjqmZ15QV1nz7+tMfLnxSC7
         5K+VFYsZ3bzHmtPVfrv3YWsFLhiR7OLiHyX3rTKHWcY1bLRLqfPjrzTzloprg8Hmq2kA
         dvGA==
X-Gm-Message-State: ACgBeo2uOf5/c/tGHAbA0727BoEKXzPv3a29VlUGs2f1p2zARP7B25vq
        RXI6kv9TPRZHV2gd/dZya8nvIHk+HatCUt/Wf9Iad+eqv1mdua3IPeCUlME6q3suIiGque3/lbx
        rkpqoz7Jt2E97FMPrjDBc
X-Google-Smtp-Source: AA6agR4h8d6XU8wf7Rba89JuzvO6/M5QQD9xRgO2erAMFyngZx2nEIGpax2LUa1YM3lFKVFmr9HgbHhBg9U=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:902:694a:b0:16e:e270:1f84 with SMTP id
 k10-20020a170902694a00b0016ee2701f84mr17988146plt.89.1661808339339; Mon, 29
 Aug 2022 14:25:39 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:05 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-3-surenb@google.com>
Subject: [RFC PATCH 02/28] mm: rcu safe VMA freeing
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
2.37.2.672.g94769d06f0-goog

