Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECC257BFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiGTWDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGTWD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 051694E848
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658354608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x1PqLLBnq81fcVYE6PRnR8ilrAhon4mRiyv85by7udw=;
        b=JckdUBQ5k+1UJVwDdU3hFgIN6AeSulQmUG4tzZVxVpfGMQOjyMXGGaFsBckmStvxMflzgP
        0bdl3x6BzTW/jyKPipu7nKwexDqz+Zt4tSxiZAYTpv43DL0ujp/ASsBc2GukmsLVYYKcs/
        yllEXtQknxtA58Vl0lngIv1VvvfzH58=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-xUIpdd_tNMehpM2ia1LwSA-1; Wed, 20 Jul 2022 18:03:26 -0400
X-MC-Unique: xUIpdd_tNMehpM2ia1LwSA-1
Received: by mail-qv1-f71.google.com with SMTP id e1-20020ad44181000000b00472f8ad6e71so10369204qvp.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1PqLLBnq81fcVYE6PRnR8ilrAhon4mRiyv85by7udw=;
        b=LN8H9REi0kf4I7TDpCINOOcDAli2BHAaBjGrQyMKt/PHkPYwsTgH4X6sf4YX5PiyWP
         JMRd/Rr3VKrXFUNpDmfEDtn4zhLs+EwCmyzHn/Fwo+5wafp2BBSSB3X6OpaNw7gLtzQv
         f1lB1+cYUesveK1ZDrqnbUp9wvee/Wj/HChLFGEUG5EOJMBMpvcjujGI6E4MgYLtY6gk
         G6EN5lVAU0B/QuLXv4gWInvfMhVs5DUYBVupfRY4+7aV2Z+K6103oZAfcKmDHDh7XUB3
         8+QkvgLG9+V0CpOUZSOds+k6iHJBxaJn2sMl7vdiXpIX1eJR/JEGMj25ZPhOr8tlcQ9w
         c0EQ==
X-Gm-Message-State: AJIora+14NaLuGhMxA4cfCiALQzftbxFdPX9h5w56BHnTNtQvYNTmb7/
        ArQdyScg398w10g+Kcs2Gr48BO3w7wdUjblyjcdgFcUYjxouGntGhY64PMJbHQl4mYgpm89Zmkc
        OKtaMMgju6fjm6SVqX0XMTXR5iFrRieNDTsU0UVB9VklbgoHX/Sprfi2YG6TorcRqVDjT4Lfv8Q
        ==
X-Received: by 2002:a05:620a:1907:b0:6a6:2fac:462f with SMTP id bj7-20020a05620a190700b006a62fac462fmr25106210qkb.213.1658354606166;
        Wed, 20 Jul 2022 15:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1si1BGAVziAsccaGFKsgWpAnO0r1FpskyjFUTXIZYMAWYfTfMf5Ez4uvNHyWyhyJ/EOwHK1Cw==
X-Received: by 2002:a05:620a:1907:b0:6a6:2fac:462f with SMTP id bj7-20020a05620a190700b006a62fac462fmr25106174qkb.213.1658354605757;
        Wed, 20 Jul 2022 15:03:25 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id x2-20020a05620a448200b006a8b6848556sm262432qkp.7.2022.07.20.15.03.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Jul 2022 15:03:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm/mprotect: Fix soft-dirty check in can_change_pte_writable()
Date:   Wed, 20 Jul 2022 18:03:24 -0400
Message-Id: <20220720220324.88538-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check wanted to make sure when soft-dirty tracking is enabled we won't
grant write bit by accident, as a page fault is needed for dirty tracking.
The intention is correct but we didn't check it right because VM_SOFTDIRTY
set actually means soft-dirty tracking disabled.  Fix it.

It wasn't a bug for a long time because we used to only optimize the write
bit settings in change_pte_range() for page caches, and since we've got a
higher level check in vma_wants_writenotify(), we will never set the bit
MM_CP_TRY_CHANGE_WRITABLE for soft-dirty enabled page caches, hence even if
we checked with the wrong value of VM_SOFTDIRTY in change_pte_range() it'll
just be an no-op.  Functionally it was still correct, even if cpu cycles
wasted.

However after the recent work of anonymous page optimization on exclusive
pages we'll start to make it wrong because anonymous page does not require
the check in vma_wants_writenotify() hence it'll suffer from the wrong
check here in can_change_pte_writable().

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

So even if commit 64fe24a3e05e kept the old behavior and didn't attempt to
change the behavior here, the bug will only be able to be triggered after
commit 64fe24a3e05e because only anonymous page will suffer from it.

Fixes: 64fe24a3e05e ("mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0420c3ed936c..804807ab14e6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -48,8 +48,11 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 	if (pte_protnone(pte) || !pte_dirty(pte))
 		return false;
 
-	/* Do we need write faults for softdirty tracking? */
-	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
+	/*
+	 * Do we need write faults for softdirty tracking?  Note,
+	 * soft-dirty is enabled when !VM_SOFTDIRTY.
+	 */
+	if (!(vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
 		return false;
 
 	/* Do we need write faults for uffd-wp tracking? */
-- 
2.32.0

