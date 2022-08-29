Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADDE5A5629
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiH2V1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiH2V1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:27:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A99E12A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340a4dcb403so126518207b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=NYe8oOJNfY11QXfRhGHbzq3PtP5qYF5OBWlNRgI/ICw=;
        b=gO3BAu2tPnt5ajc2wonv12EyC/cky1iEagPrWs8TIsmrfOPEdnZICXVlt39nBHt3WW
         tTV55lawhiZGMRBmA7gdT3YGawg8JjnJFEe5+7PrxS+L7PuBHZcRqu/eGZS5+7HkD+/v
         WBe3l/+DgKFH8adTgdOoThkCyU3oUkPdhTm9bGePyXaQUn5Kf04YxKMvEOmZ7WCBWmLN
         BXoUJ7D1rnsd47mFF47xSWH/cS8u1UFuDHVuHAEZYgUQ7/tjgR1JcWJgnN0k47FfJT+A
         /f4moE4fkIQHN9Nb1qOXqxym1C/DCmqaA6CVw+YBif80n7h7hRdtT5oL02KCkdJe7ned
         iBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=NYe8oOJNfY11QXfRhGHbzq3PtP5qYF5OBWlNRgI/ICw=;
        b=cnfgOFBEp44v6e9buEgtVfvaaXKmdShB/IIcT+Bp5/Zy+lp2GKtDZW6UpsMUZcOjqo
         Ew9FVrZ13MMVqJuulrjotw3Zli0ySBEg1cuDtZy0SJOjsfL4mA/0aIabimI09ctfIDBN
         aNvyaCVuINvMn6DLXhVPCmnYBek56T30IaPUDKZ2wzXuAyMiiELNdnSr5ln2CLZDPzl5
         QZC2OD/mDbgOrIkI7WuszVyqF/9AMlGf8vx+nDVxVSLLTe31/2sCsWHufRK44erwaXFd
         +ai9MiC8rJZXA34ZLU5S1Apq0fw2nNxyhCA6spm6+cHGk4atGk9wgsKJ+UGxRhHE7bLc
         PBSA==
X-Gm-Message-State: ACgBeo2VXBr/PkgDQ9LqivGKKOjX55ARFSlFFXK70a7COJKh8U/7bG1E
        Bm8I3BAS4Dn71C1v8GkrLwOTDGQXdXs=
X-Google-Smtp-Source: AA6agR7nmkBRROpS79vTx3reOak4mrTZffxlmMbexsEub45N/wO5CnqJNjif+IJpyxwlCbKERnK2QUttv8k=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a25:d944:0:b0:695:6056:7dda with SMTP id
 q65-20020a25d944000000b0069560567ddamr9840482ybg.277.1661808364958; Mon, 29
 Aug 2022 14:26:04 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:19 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-17-surenb@google.com>
Subject: [RFC PATCH 16/28] kernel/fork: assert no VMA readers during its destruction
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
2.37.2.672.g94769d06f0-goog

