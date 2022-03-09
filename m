Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88344D3B5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbiCIUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiCIUvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:51:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F0065499
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8407DB823CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 20:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45758C340F3;
        Wed,  9 Mar 2022 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646859047;
        bh=OgKg/0vp35QJf41JfruLbYi6bvW8ZM/QnzZq2U4YFCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRaMnKngT/vueTUdBgVKEAtGsWlVUdZXX+uG41GutJ9FLINk1O67xy3/cWX3W7oPn
         jircwk4P6VKvPxc64gnZagjIAZ1t6ChGboVcx9qnAkdD3LwH/eZksTQh2mD/9pzlLJ
         jxBmjx/d1KMvw6qMDBV9EEaWDJAUejijZv8WaFK8=
Date:   Wed, 9 Mar 2022 12:50:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3 3/9] mm: slightly clarify KSM logic in do_swap_page()
Message-Id: <20220309125045.b04d20235a7260afceaf04d6@linux-foundation.org>
In-Reply-To: <a01de28c-2195-eab3-fd3c-0e8ad3f58040@redhat.com>
References: <20220131162940.210846-1-david@redhat.com>
        <20220131162940.210846-4-david@redhat.com>
        <CAHbLzkpoNeSPyzGV9arXK7BrVWpERy0yGRggn1ZaRam8RrHyRQ@mail.gmail.com>
        <a01de28c-2195-eab3-fd3c-0e8ad3f58040@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 20:15:54 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 09.03.22 19:48, Yang Shi wrote:
> > On Mon, Jan 31, 2022 at 8:33 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> Let's make it clearer that KSM might only have to copy a page
> >> in case we have a page in the swapcache, not if we allocated a fresh
> >> page and bypassed the swapcache. While at it, add a comment why this is
> >> usually necessary and merge the two swapcache conditions.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/memory.c | 38 +++++++++++++++++++++++---------------
> >>  1 file changed, 23 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 923165b4c27e..3c91294cca98 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3615,21 +3615,29 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>                 goto out_release;
> >>         }
> >>
> >> -       /*
> >> -        * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
> > 
> > We could remove the reference to "reuse_swap_page", right?
> >
> Yes, I noticed this a couple of days ago as well and already have a
> patch prepared for that ("mm: adjust stale comment in do_swap_page()
> mentioning reuse_swap_page()" at
> https://github.com/davidhildenbrand/linux/commits/cow_fixes_part_3)
> 
> If Andrew wants, we can fix that up directly before sending upstream or
> I'll simply include that patch when sending out part2 v2.
> 
> (I want to avoid sending another series just for this)

Thanks, I did this.  The same change plus gratuitous comment reflowing.

--- a/mm/memory.c~mm-slightly-clarify-ksm-logic-in-do_swap_page-fix
+++ a/mm/memory.c
@@ -3609,11 +3609,11 @@ vm_fault_t do_swap_page(struct vm_fault
 
 	if (swapcache) {
 		/*
-		 * Make sure try_to_free_swap or reuse_swap_page or swapoff did
-		 * not release the swapcache from under us.  The page pin, and
-		 * pte_same test below, are not enough to exclude that.  Even if
-		 * it is still swapcache, we need to check that the page's swap
-		 * has not changed.
+		 * Make sure try_to_free_swap or swapoff did not release the
+		 * swapcache from under us.  The page pin, and pte_same test
+		 * below, are not enough to exclude that.  Even if it is still
+		 * swapcache, we need to check that the page's swap has not
+		 * changed.
 		 */
 		if (unlikely(!PageSwapCache(page) ||
 			     page_private(page) != entry.val))
_

