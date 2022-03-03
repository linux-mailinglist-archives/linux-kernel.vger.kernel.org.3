Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1254CC80B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiCCVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCCVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:30:45 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C39166E25
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:29:58 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 185so5031589qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJm6rEfe6QChserQuJSZLkAQP22tqq4oajdg4WrPTzA=;
        b=rjFirQQfFh4ulxYx7aVCojr3fd5pqh1Jw1kbTCIPcKS70KJAgNT0fOilTmG98RH+Aq
         2IADMLT0rYcG5f0jdWo5lNufgz52zYYQX0a0P4cPl3zvCXwCy3Oou5bikCHmP4ay00Q+
         R5jS1FKoAYpdD442M8hB16LMhO2omPHD8kH7PBZbxAO3ncOJok0pR7hN6HvIk5zGrGcJ
         aFHZVDjib3ELve/RXF8kOB8h1I0haoiDZgdyDmgCvbSEDqWOXhSGLqXjJSSg0x2xTfE8
         oxCkGpAk98F6NDIUdU87Ohk79PT8D1l9pDkinvBL/HFxKmWRsBvvzqFkX4XguVJKP6Ig
         qyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJm6rEfe6QChserQuJSZLkAQP22tqq4oajdg4WrPTzA=;
        b=nZmH45HA1QoBRljxyoWnaPQ7ImV/q+QgHUf3lfFwKlFcPELVXcTJ1VyfEd31jzPGk6
         1SCK/sd5vu9G0mpHrlzZ/dIpCGvF72MTD+NzswXKuocvbLLgSf/HdxL8wyT6vglTRjRh
         +tv/js3yn5ymE8mVCo8B1OsMPLbX9KrIqxZvYQOfjn8ZaWTzpi54lmkOWG9NsgTyQtDC
         4wbTaC0rRTwdfa1Hjce6o2ChXRxUcMJYhziG/SLw1t6TmmLHodbbPVcXBKcWPUapOpHi
         vz2jKiG4JiQ2pqLfQW57JMo9WsklEFRqdwZLncMjJH4DSfuEuSqxxZHbNrjthggFdptU
         w0WQ==
X-Gm-Message-State: AOAM533AKBTLsifORtAPbQEzGl9KUxoUfI9LKcLg9KwBHGtG9sCvw4d6
        WcorAOEh2cj1Uh8wRkgTQBDv9Q==
X-Google-Smtp-Source: ABdhPJzmib5vwTvU2gQ6huUHKU/Ce1Z7GZasquxbAu5zYSlWbMi8LHHZAmVedXMj3aKijmI2McBtIg==
X-Received: by 2002:a05:620a:c44:b0:508:201b:39d0 with SMTP id u4-20020a05620a0c4400b00508201b39d0mr726361qki.437.1646342997651;
        Thu, 03 Mar 2022 13:29:57 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id x12-20020ac85f0c000000b002de8931d4d6sm2206171qta.77.2022.03.03.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 13:29:57 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
Date:   Thu,  3 Mar 2022 16:29:56 -0500
Message-Id: <20220303212956.229409-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_DONTNEED historically rejects mlocked ranges, but with
MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
there are valid use cases for depopulating locked ranges as well.

Users mlock memory to protect secrets. There are allocators for secure
buffers that want in-use memory generally mlocked, but cleared and
invalidated memory to give up the physical pages. This could be done
with explicit munlock -> mlock calls on free -> alloc of course, but
that adds two unnecessary syscalls, heavy mmap_sem write locks, vma
splits and re-merges - only to get rid of the backing pages.

Users also mlockall(MCL_ONFAULT) to suppress sustained paging, but are
okay with on-demand initial population. It seems valid to selectively
free some memory during the lifetime of such a process, without having
to mess with its overall policy.

Why add a separate flag? Isn't this a pretty niche usecase?

- MADV_DONTNEED has been bailing on locked vmas forever. It's at least
  conceivable that someone, somewhere is relying on mlock to protect
  data from perhaps broader invalidation calls. Changing this behavior
  now could lead to quiet data corruption.

- It also clarifies expectations around MADV_FREE and maybe
  MADV_REMOVE. It avoids the situation where one quietly behaves
  different than the others. MADV_FREE_LOCKED can be added later.

- The combination of mlock() and madvise() in the first place is
  probably niche. But where it happens, I'd say that dropping pages
  from a locked region once they don't contain secrets or won't page
  anymore is much saner than relying on mlock to protect memory from
  speculative or errant invalidation calls. It's just that we can't
  change the default behavior because of the two previous points.

Given that, an explicit new flag seems to make the most sense.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/uapi/asm-generic/mman-common.h |  2 ++
 mm/madvise.c                           | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 1567a3294c3d..6c1aa92a92e4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -75,6 +75,8 @@
 #define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
 #define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
 
+#define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..12dfa14bc985 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -800,6 +800,13 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 	return 0;
 }
 
+static bool can_madv_dontneed_free(struct vm_area_struct *vma, int behavior)
+{
+	if (behavior == MADV_DONTNEED_LOCKED)
+		return !(vma->vm_flags & (VM_HUGETLB|VM_PFNMAP));
+	return can_madv_lru_vma(vma);
+}
+
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
@@ -808,7 +815,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
-	if (!can_madv_lru_vma(vma))
+
+	if (!can_madv_dontneed_free(vma, behavior))
 		return -EINVAL;
 
 	if (!userfaultfd_remove(vma, start, end)) {
@@ -830,7 +838,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
-		if (!can_madv_lru_vma(vma))
+		if (!can_madv_dontneed_free(vma, behavior))
 			return -EINVAL;
 		if (end > vma->vm_end) {
 			/*
@@ -850,7 +858,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		VM_WARN_ON(start >= end);
 	}
 
-	if (behavior == MADV_DONTNEED)
+	if (behavior == MADV_DONTNEED || behavior == MADV_DONTNEED_LOCKED)
 		return madvise_dontneed_single_vma(vma, start, end);
 	else if (behavior == MADV_FREE)
 		return madvise_free_single_vma(vma, start, end);
@@ -988,6 +996,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		return madvise_pageout(vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
@@ -1113,6 +1122,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_REMOVE:
 	case MADV_WILLNEED:
 	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
 	case MADV_FREE:
 	case MADV_COLD:
 	case MADV_PAGEOUT:
-- 
2.35.1

