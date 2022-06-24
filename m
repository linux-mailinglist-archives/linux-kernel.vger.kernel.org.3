Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D93559FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiFXRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiFXRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F616DB25
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k206-20020a2556d7000000b0066c815d2aa5so941335ybb.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HisKs0OAYNP82NuB/Frk0iPqJLb2lc+sAZjNm287jcQ=;
        b=P/aHZ9fJlVwvkJfaZVFajZm98KOIfMj2IYppFM5LuQ1zf9EsSZ8qMdlGw+rfUUepxT
         Rk4rneqzgNI3hBkLTvsDOw/sovXOPg7QHxBlzbSMDv947qVGHCYD/AKf6PpAucF+SB8+
         CPR/TNLo08h/tyhtM460hIdHHPcABjdzuulR5lTk4iFehrldnIL1GfqZda2In7YFtggB
         usvpcPQWqZ0WphYnX3EhkMBx+Typu02xyZyvlY2VIUMvBbNVFv8qTl1N/MQr/QOO/hLC
         HQXC2pLyWYxCtUrqnUx0Na56WcsA/KgE6sPe3nZndOHiUWkRsKxAtTwz+BZWdqDY7Yot
         OYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HisKs0OAYNP82NuB/Frk0iPqJLb2lc+sAZjNm287jcQ=;
        b=inpdvmUfXcdc8NIsDaRe0EJei0qQrrijB2J9nk69Ct0hMQfF80yT0hks0joGf7OlBB
         /lEYxDaWll/g9p4JUNEEI0gAhWZHRdAOJM2JC9ioTkKN8LwF7/qVEFcXJY4nj3R4YbZT
         j75grbvusV9QE24XQAlGeRyxQsjNR5qIHlU/ANShMkVHluXGqeJAb6T3NH9U+4g+zLas
         fPTmyVigB7A3j/JVFg0z6tVryRBNaGvzAk/KoK35eAPB6GFMuZiCWMX6OqDGeRSo4oQB
         IKTuhUd58TkYBe1idkrX0+yXWp8+mvjLH2Ve3HIAlZ9ogandy/CP0tZ1FqRd+psQNyYR
         PHrw==
X-Gm-Message-State: AJIora+j3In+lotx9Pp94AwTqD455KBpjRQjvim4IXqCSkXW3S9itAOs
        xIXjcoUiRWLOEp0BO8o8hrfC/FTJhXiEbLrb
X-Google-Smtp-Source: AGRyM1tzk7GXyftSzcieFt/kefrccg/jUZ3bHYFjHpboz2q85ML1dIMb8Z3beFS8X7RsMAKgtTvTxLeNH4OzIoqy
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:e60e:0:b0:317:893c:90a3 with SMTP
 id p14-20020a0de60e000000b00317893c90a3mr18394744ywe.241.1656092260720; Fri,
 24 Jun 2022 10:37:40 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:52 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-23-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 22/26] madvise: add uapi for HugeTLB HGM collapse: MADV_COLLAPSE
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

This commit is co-opting the same madvise mode that is being introduced
by zokeefe@google.com to manually collapse THPs[1].

As with the rest of the high-granularity mapping support, MADV_COLLAPSE
is only supported for shared VMAs right now.

[1] https://lore.kernel.org/linux-mm/20220604004004.954674-10-zokeefe@google.com/

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/uapi/asm-generic/mman-common.h |  2 ++
 mm/madvise.c                           | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6c1aa92a92e4..b686920ca731 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -77,6 +77,8 @@
 
 #define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
 
+#define MADV_COLLAPSE	25		/* collapse an address range into hugepages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index d7b4f2602949..c624c0f02276 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -59,6 +59,7 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_FREE:
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
+	case MADV_COLLAPSE:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -981,6 +982,20 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static int madvise_collapse(struct vm_area_struct *vma,
+			    struct vm_area_struct **prev,
+			    unsigned long start, unsigned long end)
+{
+	bool shared = vma->vm_flags & VM_SHARED;
+	*prev = vma;
+
+	/* Only allow collapsing for HGM-enabled, shared mappings. */
+	if (!is_vm_hugetlb_page(vma) || !hugetlb_hgm_enabled(vma) || !shared)
+		return -EINVAL;
+
+	return hugetlb_collapse(vma->vm_mm, vma, start, end);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1011,6 +1026,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 		return madvise_populate(vma, prev, start, end, behavior);
+	case MADV_COLLAPSE:
+		return madvise_collapse(vma, prev, start, end);
 	case MADV_NORMAL:
 		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
 		break;
@@ -1158,6 +1175,9 @@ madvise_behavior_valid(int behavior)
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
+#endif
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	case MADV_COLLAPSE:
 #endif
 		return true;
 
@@ -1351,6 +1371,9 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *		triggering read faults if required
  *  MADV_POPULATE_WRITE - populate (prefault) page tables writable by
  *		triggering write faults if required
+ *  MADV_COLLAPSE - collapse a high-granularity HugeTLB mapping into huge
+ *		mappings. This is useful after an entire hugepage has been
+ *		mapped with individual small UFFDIO_CONTINUE operations.
  *
  * return values:
  *  zero    - success
-- 
2.37.0.rc0.161.g10f37bed90-goog

