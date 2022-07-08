Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E856B19D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiGHEht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiGHEhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:37:48 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F098ADFE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:37:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e7so275738qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MmKC25FiipS06xMXsFIpzuCZtvcWJ/Q7PRv+HUCJq4M=;
        b=QhpRMmgtNVjveo3PWpHNyCFN3vhQfm4ElDRk0CydFk0UI3aZt8vPPNtIu4W3je5L54
         TRYGF1kPqInY7+t0AakiAylKBu61lCp14z8EkPoq+4sDX/VMtvFStwIpKWA+K5+LjX87
         Smo1LRDMogx5D/f3nV6jaXeiZU8wxi497NIZrqAIpZm7ztcY1mPS0Vy3xinYK92yUcYL
         +oyxiBLL9BrJ3J+VHNdC98A8hQmFpaqZGeQqXgFCIrCPeUJIGeRoEGLBVpr5DGkGrjPl
         /+EXR+2utK+e8itnCNUeJi4vHdXho0F/jGzBGf/x7dlbA4PCsdwm6+Ez0QmkZzZ0fVyJ
         ZWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=MmKC25FiipS06xMXsFIpzuCZtvcWJ/Q7PRv+HUCJq4M=;
        b=sFqLhpDBGX00VhEdLmLFuaUHlTRasCgaXNbrp6BaRysyeckR0gITp/5onL/cXgW+lq
         MS9hdrUXOcLqJ1qxEoba4HedOw7oQphybk/X94D5qG/IzkQvyV0kVV3WjD4UwuHobqr0
         yZ4BthX6fVmh5bqsF6EtoRQmsqNrzEkEFbVfQk0Yocz26CkTfSqt9umgtkSGVXJLa+iS
         Yi/+aO1YOyC93HzIvyZmYSYHpL3IvnP7/ouXlJZNM/BaomfG4Bip0oowHzSMoeDacksY
         ZaGRsQpseD9NNdFnXAF4DZEjJbBmGN7DziXe9Cefzte9Nch4cq1higMKcnSGQW4oEqKC
         a1vA==
X-Gm-Message-State: AJIora8kv/4Y63uuSq0aHg3Vf8AE1i3f+uBxJox764xyyWMgjJKcQl5K
        Cf5GsTit/ZsSRLVD1UdCGqJJ355Beax8JA==
X-Google-Smtp-Source: AGRyM1ud5NTBv/AyZNuQsd7rewmqNRB7HOO4D8HMqqEhxDbqT5olX/n4u3fa2wzoNR5CNa8aIXjSFg==
X-Received: by 2002:a0c:ca07:0:b0:473:276:9a06 with SMTP id c7-20020a0cca07000000b0047302769a06mr1248484qvk.56.1657255065957;
        Thu, 07 Jul 2022 21:37:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id cd10-20020a05622a418a00b00304e5839734sm28222481qtb.55.2022.07.07.21.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 21:37:45 -0700 (PDT)
Date:   Thu, 7 Jul 2022 21:37:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] maple_tree: Fix use of node for global range in
 mas_wr_spanning_store()
In-Reply-To: <20220706140814.hjf5d2hbfupd6kyp@revolver>
Message-ID: <e2df94dc-f54c-ebb9-14f0-98b232358d4@google.com>
References: <20220706020526.1869453-1-Liam.Howlett@oracle.com> <20220705195535.a32ce0de9b45fe73eea72c82@linux-foundation.org> <20220706140814.hjf5d2hbfupd6kyp@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022, Liam Howlett wrote:
> * Andrew Morton <akpm@linux-foundation.org> [220705 22:55]:
> > On Wed, 6 Jul 2022 02:05:37 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > 
> > > When writing a range with a NULL which expands to 0 - ULONG_MAX, don't
> > > use a node to store this value.  Instead, call mas_new_root() which will
> > > set the tree pointer to NULL and free all the nodes.
> > > 
> > > Fix a comment for the allocations in mas_wr_spanning_store().
> > > 
> > > Add mas_node_count_gfp() and use it to clean up mas_preallocate().
> > > 
> > > Clean up mas_preallocate() and ensure the ma_state is safe on return.
> > > 
> > > Update maple_tree.h to set alloc = NULL.
> > 
> > Cool.
> > 
> > How are we looking now?  Any known issues still being worked on?
> 
> Did you pick up "Subject: [PATCH] mm/mmap: Fix copy_vma() new_vma
> check"?  I sent that yesterday as well.
> 
> I think we are in good shape.  There were two outstanding issues I had
> and this patch plus the copy_vma() patch fixes both.

I'm not so sure.

I haven't gone back to check, but I do think there was a very recent
lib/maple_tree.c change or set of changes which greatly improved it
(say an hour to reach a problem instead of a minute).

But errors I do see still (I've only had time for it this month, and
there have been three other non-maple-tree bugs in linux-next which
got in the way of my huge tmpfs kernel build swapping load testing).

I see one kind of problem on one machine, and another on another,
and have no idea why the difference, so cannot advise you on how
to reproduce either.  I do have CONFIG_DEBUG_VM_MAPLE_TREE=y and
CONFIG_DEBUG_MAPLE_TREE=y on both; but might try removing those,
since they tell me nothing without a long education, and more
important for me to write this mail now than get into capturing
those numbers for you.

One machine does show such output, with BUG at mas_validate_gaps,
doing __vma_adjust from __split_vma from do_mas_align_munmap.
That's fairly typical of all reports from that machine, I think.

Other machine (laptop I'm writing from) has never shown any such MT
debug output, but hits the kernel BUG at include/linux/swapops.h:378!
pfn_swap_entry_to_page() BUG_ON(is_migration_entry() && !PageLocked().

I've often called that the best BUG in the kernel: it tells whether
rmap is holding together: migration entries were inserted on one
rmap walk, some may have been zapped by unmapping meanwhile, but
before midnight strikes and the page is unlocked, all the remaining
ones have to be found by the second rmap walk.  (And if we removed the
BUG, then it would be mysterious rare segfaults and/or data leaks:
which I cannot call "stable").

Hitting that BUG suggests that the rmap locking is deficient somewhere
(might be something else, but that's a best guess), and I wouldn't be
surprised if that somewhere is __vma_adjust() - which is not quite
the same as it was before (I wonder if the changes were essential for
maple tree, or "simplifications" which seemed a good idea at the time).
If there's a way to minimally maple-ize how it was before, known working,
that would be a useful comparison to make.

Here's a patch I've applied, that makes no difference to the problems
I see, but fixes or highlights a little that worried me in the source.
Earlier, you had that anon_vma locking in vma_expand() under "else",
it's good to see that fixed, but I believe there's a case it misses;
and I don't think you can change the lock ordering just because it looks
nicer (see comments at head of mm/rmap.c for lock ordering, or mm/mremap.c
for an example of what order we take file versus anon rmap locks).

Hopefully maple tree stable is not far off, but seems not quite yet.

Hugh

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -528,7 +528,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 		if (next->anon_vma && !vma->anon_vma) {
 			int error;
 
-			vma->anon_vma = next->anon_vma;
+			anon_vma = next->anon_vma;
+			vma->anon_vma = anon_vma;
 			error = anon_vma_clone(vma, next);
 			if (error)
 				return error;
@@ -546,16 +547,19 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 
 	vma_adjust_trans_huge(vma, start, end, 0);
 
+	if (file) {
+		mapping = file->f_mapping;
+		root = &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
 	if (anon_vma) {
 		anon_vma_lock_write(anon_vma);
 		anon_vma_interval_tree_pre_update_vma(vma);
 	}
 
 	if (file) {
-		mapping = file->f_mapping;
-		root = &mapping->i_mmap;
-		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
-		i_mmap_lock_write(mapping);
 		flush_dcache_mmap_lock(mapping);
 		vma_interval_tree_remove(vma, root);
 	}
@@ -3021,8 +3025,12 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 		}
 		vma->vm_end = addr + len;
 		vma->vm_flags |= VM_SOFTDIRTY;
-		if (mas_store_gfp(mas, vma, GFP_KERNEL))
-			return -ENOMEM;
+		if (WARN_ON(mas_store_gfp(mas, vma, GFP_KERNEL))) {
+			/*
+			 * Rewind not yet worked out: at the very least
+			 * we must unlock if locked, so proceed to below.
+			 */
+		}
 
 		if (vma->anon_vma) {
 			anon_vma_interval_tree_post_update_vma(vma);
