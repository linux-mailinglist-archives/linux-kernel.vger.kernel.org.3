Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC24CB46C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiCCBgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiCCBgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:36:17 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD9A1B127A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:35:33 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso3309481otq.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=gkSN7ZvNvd/0m/mkYGWwCvWjNrGtNp3nzKCzQIc5Go4=;
        b=Peqfovp4UGvowB6XN/lkQXan457qd0WjSWexd2I3wFuJGidEStuSmvMy7HbGPYCf1D
         h0853GoGpbWoIgAglm4eHpy3WAj65EhHaF7M4kxjqccPCVaiuu2phP8eWfsrfSM4hA3T
         YAf3Ff7T7IP2z6Xdb0yRq7K03bCb4uQzDr9ZOMx44OSR3aYaaWSnAmZddFNe8gA9Ygvq
         CeZDJAPnPW/bGBg+W6yJY/PFmInaA9sa57Co9UfT0j5+EeWQFN51EDfjL0Q4+ShiyE6c
         ZKbrCGkrAmwdR1UYOTf/psw3MXAVbceU4bKtkx8d+C7vW3lQNPDzj0Bf8DNsB1FM+W/c
         fIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=gkSN7ZvNvd/0m/mkYGWwCvWjNrGtNp3nzKCzQIc5Go4=;
        b=5Oca4mgVOEWOCjwB2+k7e1R23fqIdg6FyDi2ON914PjCKhjjqPDLCHsf5sjUETGRyv
         QRPoId7IiX0cz5STEEq9zQhgls51/1/AWmUA0SGD/n7+IyR3pHvXU4oDPTuW/S7kS1CH
         T8aclsn50oIn8/x4I60skXvY0Ge5bh148miRIDshu+7mJKCrV82bUyNgHrICyJzZf67n
         9/qpzbZ3NskQ6Cbo3/dXnbxpiUINKKHUpG5QWL/tFFRbvYh/2MHmBoF5tV9bkyXMx6VV
         WFK7tyR5ynW0+eqJgnbeUvTkI2JdKH4S4jDEUJMcf4FYAuXbuaKS6W3m7CWOlxO96rAE
         sudg==
X-Gm-Message-State: AOAM533DkeJhZDDs/M0XMY3pazyHPUt/Xjt1THlU05/M/mAxnFFhYgaU
        G5wXzeY4xTpDdPmW9Zu332ByfN9k5tavbA==
X-Google-Smtp-Source: ABdhPJwtU441wydHepaGEFzGV3+hX4X6j7bgaDd+Ws05CmRj7iyeePVqs5IJFRZZ3Sq4J7i731b8jw==
X-Received: by 2002:a05:6830:34a0:b0:5b0:37d7:ab38 with SMTP id c32-20020a05683034a000b005b037d7ab38mr6487277otu.40.1646271332947;
        Wed, 02 Mar 2022 17:35:32 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r41-20020a056870582900b000d6cbaf589esm466018oap.40.2022.03.02.17.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:35:32 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:35:30 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm/munlock: mlock_vma_folio() check against
 VM_SPECIAL
Message-ID: <9b95d366-1719-f8e2-a5a3-429f9e808288@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although mmap_region() and mlock_fixup() take care that VM_LOCKED
is never left set on a VM_SPECIAL vma, there is an interval while
file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
still be set while VM_SPECIAL bits are added: so mlock_vma_folio()
should ignore VM_LOCKED while any VM_SPECIAL bits are set.

This showed up as a "Bad page" still mlocked, when vfree()ing pages
which had been vm_inserted by remap_vmalloc_range_partial(): while
release_pages() and __page_cache_release(), and so put_page(), catch
pages still mlocked when freeing (and clear_page_mlock() caught them
when unmapping), the vfree() path is unprepared for them: fix it?
but these pages should not have been mlocked in the first place.

I assume that an mlockall(MCL_FUTURE) had been done in the past; or
maybe the user got to specify MAP_LOCKED on a vmalloc'ing driver mmap.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Diffed against top of next-20220301 or mmotm 2022-02-28-14-45.
This patch really belongs as a fix to the mm/munlock series in
Matthew's tree, so he might like to take it in there (but the patch
here is the foliated version, so easiest to place it after foliation).

 mm/internal.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/mm/internal.h
+++ b/mm/internal.h
@@ -421,8 +421,15 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
 static inline void mlock_vma_folio(struct folio *folio,
 			struct vm_area_struct *vma, bool compound)
 {
-	/* VM_IO check prevents migration from double-counting during mlock */
-	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_IO)) == VM_LOCKED) &&
+	/*
+	 * The VM_SPECIAL check here serves two purposes.
+	 * 1) VM_IO check prevents migration from double-counting during mlock.
+	 * 2) Although mmap_region() and mlock_fixup() take care that VM_LOCKED
+	 *    is never left set on a VM_SPECIAL vma, there is an interval while
+	 *    file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
+	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
+	 */
+	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
 	    (compound || !folio_test_large(folio)))
 		mlock_folio(folio);
 }
