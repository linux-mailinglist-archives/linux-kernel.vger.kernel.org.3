Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A45A9E35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiIARhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiIARgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E28E103C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g9-20020a17090a290900b001fd59cc2c14so1628490pjd.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=VpPGH26B3JaNkIfQAA8lk0M2gmgFVNCTIjkTHyeGjq0=;
        b=pbMRwoSFwQraZzGGZr7x5dEEGoBSSezJwWCkFmGpQHOK/gJ9jZl7heInRLvxfZubEx
         Wj7mEqLcXRU9xxWHf3t+7qSl6CnhQuuJSVxfC2zOp1biHU7QYf19J34qbstjhGHRGexS
         HGkcltAazUrmNYZt5EcV0prllxXaFrscwVZ4MeMfR5YBnXhADmsl05WrPEXFggi7Gjas
         iHFv8bsKjSzXGdd4TTCY9kFoj2NTn7nIEkBcfDuEl9YbNXUKLbiljFvk9VYo3diziCwb
         KLzO8tBeRwrd5fwSMEAfN7AuoAZXQe3a89hFtIYEbzmUJ/R7GnSkDta2dkqtwJ/Rto29
         WT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VpPGH26B3JaNkIfQAA8lk0M2gmgFVNCTIjkTHyeGjq0=;
        b=O82uCkXwoDsKSKgrNbehXGVZ7VqNZe2WShBCi7tPMmPxdTDuZrHGXR0pS70lw9sTlg
         myRA4dOHdxxC+0ywCGjt+oEfH9aohSrIKQpe+pbLyUUejTIoNLRau+qI96EK7QFpxnIg
         WSdTMGroJ12Sp0Jgw2SnCuroDuNsnIvs8odZVc8jlAulFFsSNCyOzWwceqEB43Gye1ot
         LPlQthj6sBq3nc/5hs7XNANsXCj7p2g5lYWPeyPbNYM8odoDCGoz44d1zA4Zje6z29cD
         ltf0P65WH0j/Qb1Ms2RWdcoelNVOXq/hlfhXGRB3cbxrrP4tHKlnP99c3MrAeKtnl9M+
         m7+w==
X-Gm-Message-State: ACgBeo0Hqo13rHUAT+6smWiez6As+uoSXnpiTytBKvxe6HF9UT3l4X6j
        hOK2RPPjKSFRyT+9a4UmUizGzEkJOZM=
X-Google-Smtp-Source: AA6agR5wOS2QTAVmPmwy5O8cxRkpTpms/e+UYL0OyAuyLY0hN8kJNMUzvy3oLdSFlDJRhvwngVhT3DguUUM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a63:b250:0:b0:422:e3a6:47f2 with SMTP id
 t16-20020a63b250000000b00422e3a647f2mr4539554pgo.478.1662053763882; Thu, 01
 Sep 2022 10:36:03 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:04 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-17-surenb@google.com>
Subject: [RFC PATCH RESEND 16/28] kernel/fork: assert no VMA readers during
 its destruction
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assert there are no holders of VMA lock for reading when it is about to be
destroyed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 8 ++++++++
 kernel/fork.c      | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc72be923e5b..0d9c1563c354 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -676,6 +676,13 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma, int pos)
 	VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
 }
 
+static inline void vma_assert_no_reader(struct vm_area_struct *vma)
+{
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock) &&
+		      vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
+		      vma);
+}
+
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_init_lock(struct vm_area_struct *vma) {}
@@ -685,6 +692,7 @@ static inline bool vma_read_trylock(struct vm_area_struct *vma)
 static inline void vma_read_unlock(struct vm_area_struct *vma) {}
 static inline void vma_assert_locked(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma, int pos) {}
+static inline void vma_assert_no_reader(struct vm_area_struct *vma) {}
 
 #endif /* CONFIG_PER_VMA_LOCK */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 1872ad549fed..b443ba3a247a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -487,6 +487,8 @@ static void __vm_area_free(struct rcu_head *head)
 {
 	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
 						  vm_rcu);
+	/* The vma should either have no lock holders or be write-locked. */
+	vma_assert_no_reader(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 #endif
-- 
2.37.2.789.g6183377224-goog

