Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4425800A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiGYOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiGYOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4998C12AF9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658758856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+PLJwm8I4XNgq7thKsEyZwGg7Y79QmzOuQLBYBftOA=;
        b=UrRzCgI6iGajSWten5nEf5EsT8ydVHRmYoXFCKtj0nlrqiCOCi+JhObGLksUnjyC5fRWsR
        79+IuSYXmmXlM32gZvXrRYsur10qz5rhmlvrOknmaas4bOEzlfP9m1lrxQhx5JgAx32mqj
        cqU63th3QCC2eH0mqt+URmsBmoUuEYM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-1JlLvA1kPoa3gq9HqtGYCw-1; Mon, 25 Jul 2022 10:20:52 -0400
X-MC-Unique: 1JlLvA1kPoa3gq9HqtGYCw-1
Received: by mail-qt1-f200.google.com with SMTP id a18-20020a05622a02d200b0031ed7ae9abeso5607917qtx.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+PLJwm8I4XNgq7thKsEyZwGg7Y79QmzOuQLBYBftOA=;
        b=TATLORKsKB0NLM7n9xug/UfN5BguddjHGOzmVJxZ5pWL24yj2V1LdgK/xFifPBj5/y
         ZWLrgQF1ytqi9v4kO+Wt0eKhy4nbmNMCeS5RoBs5jPt/rFSq5L+eAy5NFkiNdelc8i/7
         l/a/CqXjU2AEW9xAjUj0ckL8/nUIKd6cxa4MpBS76gjRXhfv5qeJCX75L6QtsQBDb4Ss
         mXZb21Zj3CJjyxshtyN47eeiVr+F9XolBuFGQ0MqwDoamqhXQoghg4LHDCRvhHibRGis
         hpUq4GCLarhNHHOiv2p6xkMNCL0rUFGj3ICDcAgyEdbqYpHHhaQerFjBhfd/3L3xJZ4b
         hUNw==
X-Gm-Message-State: AJIora8QItm2kFjpcRbbsB2pQcInFp7oKe+v06esYjWT4IoTl9i0pj6l
        eFCeuLQIu2qBfW3obfyNCjoAI4k8VCNPh94RV3cb1iLIAnG6uc6zuDUHvKczBo6liHeT0T1RgA7
        QLcSoS9s6v4adFY4ujU+73a1LnarEPBeqqXqtgWiFMTo32xSY2lbANLQiQ11zBidqWP5f0JI6JA
        ==
X-Received: by 2002:a05:620a:29d6:b0:6b5:bd2a:7d6c with SMTP id s22-20020a05620a29d600b006b5bd2a7d6cmr8958400qkp.322.1658758851865;
        Mon, 25 Jul 2022 07:20:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vQlOnDDtn0B1X4C7h3+oTl7Q6HIl52JZgS9lE9HukTaSgN/hsfyN4YSFElUBcqMbdEwPEPzQ==
X-Received: by 2002:a05:620a:29d6:b0:6b5:bd2a:7d6c with SMTP id s22-20020a05620a29d600b006b5bd2a7d6cmr8958367qkp.322.1658758851484;
        Mon, 25 Jul 2022 07:20:51 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id ey14-20020a05622a4c0e00b0031f0ab4eceasm7626071qtb.7.2022.07.25.07.20.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Jul 2022 07:20:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in can_change_pte_writable()
Date:   Mon, 25 Jul 2022 10:20:46 -0400
Message-Id: <20220725142048.30450-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220725142048.30450-1-peterx@redhat.com>
References: <20220725142048.30450-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check wanted to make sure when soft-dirty tracking is enabled we won't
grant write bit by accident, as a page fault is needed for dirty tracking.
The intention is correct but we didn't check it right because VM_SOFTDIRTY
set actually means soft-dirty tracking disabled.  Fix it.

There's another thing tricky about soft-dirty is that, we can't check the
vma flag !(vma_flags & VM_SOFTDIRTY) directly but only check it after we
checked CONFIG_MEM_SOFT_DIRTY because otherwise VM_SOFTDIRTY will be
defined as zero, and !(vma_flags & VM_SOFTDIRTY) will constantly return
true.  To avoid misuse, introduce a helper for checking whether vma has
soft-dirty tracking enabled.

We can easily verify this with any exclusive anonymous page, like program
below:

=======8<======
  #include <stdio.h>
  #include <unistd.h>
  #include <stdlib.h>
  #include <assert.h>
  #include <inttypes.h>
  #include <stdint.h>
  #include <sys/types.h>
  #include <sys/mman.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <unistd.h>
  #include <fcntl.h>
  #include <stdbool.h>

  #define BIT_ULL(nr)                   (1ULL << (nr))
  #define PM_SOFT_DIRTY                 BIT_ULL(55)

  unsigned int psize;
  char *page;

  uint64_t pagemap_read_vaddr(int fd, void *vaddr)
  {
      uint64_t value;
      int ret;

      ret = pread(fd, &value, sizeof(uint64_t),
                  ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
      assert(ret == sizeof(uint64_t));

      return value;
  }

  void clear_refs_write(void)
  {
      int fd = open("/proc/self/clear_refs", O_RDWR);

      assert(fd >= 0);
      write(fd, "4", 2);
      close(fd);
  }

  #define  check_soft_dirty(str, expect)  do {                            \
          bool dirty = pagemap_read_vaddr(fd, page) & PM_SOFT_DIRTY;      \
          if (dirty != expect) {                                          \
              printf("ERROR: %s, soft-dirty=%d (expect: %d)\n", str, dirty, expect); \
              exit(-1);                                                   \
          }                                                               \
  } while (0)

  int main(void)
  {
      int fd = open("/proc/self/pagemap", O_RDONLY);

      assert(fd >= 0);
      psize = getpagesize();
      page = mmap(NULL, psize, PROT_READ|PROT_WRITE,
                  MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
      assert(page != MAP_FAILED);

      *page = 1;
      check_soft_dirty("Just faulted in page", 1);
      clear_refs_write();
      check_soft_dirty("Clear_refs written", 0);
      mprotect(page, psize, PROT_READ);
      check_soft_dirty("Marked RO", 0);
      mprotect(page, psize, PROT_READ|PROT_WRITE);
      check_soft_dirty("Marked RW", 0);
      *page = 2;
      check_soft_dirty("Wrote page again", 1);

      munmap(page, psize);
      close(fd);
      printf("Test passed.\n");

      return 0;
  }
=======8<======

Here we attach a Fixes to commit 64fe24a3e05e only for easy tracking, as
this patch won't apply to a tree before that point.  However the commit
wasn't the source of problem, but instead 64e455079e1b. It's just that
after 64fe24a3e05e anonymous memory will also suffer from this problem with
mprotect().

Fixes: 64e455079e1b ("mm: softdirty: enable write notifications on VMAs after VM_SOFTDIRTY cleared")
Fixes: 64fe24a3e05e ("mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 mm/mmap.c     |  2 +-
 mm/mprotect.c |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 15e8cb118832..e2d442e3c0b2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -860,4 +860,22 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
 
 DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
+{
+	/*
+	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
+	 * enablements, because when without soft-dirty being compiled in,
+	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
+	 * will be constantly true.
+	 */
+	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+		return false;
+
+	/*
+	 * Soft-dirty is kind of special: its tracking is enabled when the
+	 * vma flags not set.
+	 */
+	return !(vma->vm_flags & VM_SOFTDIRTY);
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index 125e8903c93c..93f9913409ea 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1518,7 +1518,7 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 		return 0;
 
 	/* Do we need to track softdirty? */
-	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !(vm_flags & VM_SOFTDIRTY))
+	if (vma_soft_dirty_enabled(vma))
 		return 1;
 
 	/* Specialty mapping? */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0420c3ed936c..c403e84129d4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -49,7 +49,7 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
-	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
+	if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
-- 
2.32.0

