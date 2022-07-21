Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0499957D354
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiGUSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUSdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3785F8C8E2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658428424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KH2IQ7lvNvosAuw/khX6+zs8dl9iHbPrciywy6iP5nM=;
        b=YUCHiViLBy7Pnmf6iAwL/fgrDyi4Wsj+sivU3V+ydR3V0fFz6i8yJuCt6A1KpQB3PEJklJ
        CTnUVag6kOYXTJWufaosOSXcvc40rIWrS+krgoIyvhnHyWTk68riAuZfVRsOeBI3y93N/Y
        bF1ltrG8BQQNZDeD55OG0CKkbOD6FOg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-I4nX6CXEMLS40VSlGoXa2w-1; Thu, 21 Jul 2022 14:33:43 -0400
X-MC-Unique: I4nX6CXEMLS40VSlGoXa2w-1
Received: by mail-qv1-f70.google.com with SMTP id k7-20020a056214102700b004740a13b3bcso1557114qvr.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KH2IQ7lvNvosAuw/khX6+zs8dl9iHbPrciywy6iP5nM=;
        b=tB+UdwsZciTF0IiMqUFezvBi1MhCPkf/kyXBiTE/N3gKPHWasSkmtZ+tQ65sMFQtkV
         zMOUHza2ja3mfyE0qxJKU9a2P6Y8jmoLnryjqKKTbUGnZ2gFmpYck+SutE1jcB2Ldaqz
         zfOR1aa9tpG5ckHzamTvRD3qnJQ2+YOZI3AMl91iBbvDNZfn6jIxPeGEEOxCeU78Fh8a
         GDB1Y5+tlH5RZtozjZqPyItu+MV2PVjAiqE8OEB7NGny4FH0Flb+9a8rdbqrh6Hprugi
         tKTgWel89PeQy+vZBqTsw3kn/hQw/auRlvcAosvtRIpX3OmYu6ZsUrL42U6Xf9XSF4u+
         904A==
X-Gm-Message-State: AJIora9ueJj8pB1MGQ6XXXdSOJ5S+Z1E9LVPUojGJxlTJPKBdcL63ne5
        2L6+ptHA9e8aKiH+XbXW+vwjMLejdTKanFIc+7BADbAUbcDp3471hNdxjgrZLQXaDti9pSrUR1+
        Fpsc4KjWF5jNJEG5a0lpWtWZJJv/GEdQlH2pxCGu6MY9qfhfFVn31Cr4KPDpYPiF+c6jnaJtTEA
        ==
X-Received: by 2002:a05:622a:3d1:b0:31e:f837:6a9f with SMTP id k17-20020a05622a03d100b0031ef8376a9fmr13960530qtx.226.1658428422423;
        Thu, 21 Jul 2022 11:33:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sZ7wKbfXKinHSsJeIWKE6bOHV+sPExv1NjPbvw/3nqalaZMxK+iiLytgOcjEV/BxghohjA8A==
X-Received: by 2002:a05:622a:3d1:b0:31e:f837:6a9f with SMTP id k17-20020a05622a03d100b0031ef8376a9fmr13960499qtx.226.1658428422068;
        Thu, 21 Jul 2022 11:33:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bj9-20020a05620a190900b006a6a7b4e7besm1878519qkb.109.2022.07.21.11.33.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Jul 2022 11:33:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 1/3] mm/mprotect: Fix soft-dirty check in can_change_pte_writable()
Date:   Thu, 21 Jul 2022 14:33:36 -0400
Message-Id: <20220721183338.27871-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220721183338.27871-1-peterx@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
wasn't the source of problem, it's just that then anonymous memory will
also suffer from this problem with mprotect().

Fixes: 64fe24a3e05e ("mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection")
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

