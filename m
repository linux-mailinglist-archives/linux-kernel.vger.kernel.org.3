Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42BE553BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354101AbiFUUis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354390AbiFUUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:38:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B319C3B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5176AB80F63
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EE1C3411C;
        Tue, 21 Jun 2022 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655843921;
        bh=Ow+eTKi/AGhRax2ZmaF8XrqDcXcJRnKxDwli+QzUE38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fphi7PzNTHbXTZWnHWt/zNcSAqTwPTzjoDACizwcbGF6PHdDsNR4uj5Ito5piFgU8
         EMdTggkyPVnDdn8MtrGG1xGXmQRMGJkyykaBnM+xwp6oGHqg+U4yQVB99+9/UelhTm
         B5ujj6h+l/GLXu4LKvsw4hVIqL3Z+b6sIit9rh5A=
Date:   Tue, 21 Jun 2022 13:38:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Make mas_prealloc() error checking more
 generic
Message-Id: <20220621133827.1579fb8673d21d01e409de22@linux-foundation.org>
In-Reply-To: <20220621132251.sloxxcbecwmurb42@revolver>
References: <20220615174213.738849-1-Liam.Howlett@oracle.com>
        <f7e9b2a7-9ec8-3922-ee06-eea0e26a26dd@redhat.com>
        <20220621132251.sloxxcbecwmurb42@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 21 Jun 2022 13:22:59 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * David Hildenbrand <david@redhat.com> [220621 05:09]:
> > On 15.06.22 19:42, Liam Howlett wrote:
> > > Return the error regardless of what it is.  This is a safer option.
> > > 
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >  lib/maple_tree.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index f413b6f0da2b..89ff5ef7ee28 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -5670,16 +5670,15 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
> > >   */
> > >  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
> > >  {
> > > -
> > >  	mas_set_alloc_req(mas, 1 + mas_mt_height(mas) * 3);
> > >  	mas_alloc_nodes(mas, gfp);
> > > -	if (likely(mas->node != MA_ERROR(-ENOMEM)))
> > > +	if (likely(!mas_is_err(mas)))
> > >  		return 0;
> > >  
> > >  	mas_set_alloc_req(mas, 0);
> > >  	mas_destroy(mas);
> > >  	mas->node = MAS_START;
> > > -	return -ENOMEM;
> > > +	return xa_err(mas->node);
> > >  }
> > >  
> > >  /*
> > 
> > Liam, (as asked privately before, I was just too busy to respond :) )
> > once all known issues are fixed, can we have a new version posted to
> > ease review? That would make my life easier to see what needs review and
> > in which order patches apply. Thanks!
> > 
> 
> 
> Yes.  Thanks for asking.
> 
> Andrew didn't want to lose the comments so maybe I'll squash the fixes
> into a branch and send that out as a response to v9 if that works?

I guess it's time for a new series - things are getting a little
straggly:

maple-tree-add-new-data-structure-fix.patch
maple-tree-add-new-data-structure-fix-2.patch
maple-tree-add-new-data-structure-fix-3.patch
maple-tree-add-new-data-structure-fix-4.patch
maple-tree-add-new-data-structure-fix-5.patch
maple-tree-add-new-data-structure-fix-6.patch
maple-tree-add-new-data-structure-fix-7.patch
maple-tree-add-new-data-structure-fix-8.patch
maple-tree-add-new-data-structure-fix-8-fix.patch
maple-tree-add-new-data-structure-fix-9.patch
maple-tree-add-new-data-structure-fix-10.patch
lib-test_maple_tree-add-testing-for-maple-tree-fix.patch
lib-test_maple_tree-add-testing-for-maple-tree-fix-2.patch
mm-start-tracking-vmas-with-maple-tree-fix.patch
mm-start-tracking-vmas-with-maple-tree-fix-2.patch
damon-convert-__damon_va_three_regions-to-use-the-vma-iterator-fix.patch
mm-mmap-use-advanced-maple-tree-api-for-mmap_region-fix.patch
mm-mmap-use-advanced-maple-tree-api-for-mmap_region-fix-checkpatch-fixes.patch
mm-mmap-use-advanced-maple-tree-api-for-mmap_region-fix-2.patch
mm-mmap-use-advanced-maple-tree-api-for-mmap_region-fix-3.patch
mm-mmap-change-do_brk_munmap-to-use-do_mas_align_munmap-fix.patch
userfaultfd-use-maple-tree-iterator-to-iterate-vmas-fix.patch
nommu-remove-uses-of-vma-linked-list-fix.patch
nommu-remove-uses-of-vma-linked-list-fix-fix.patch
mm-remove-the-vma-linked-list-fix.patch
mm-remove-the-vma-linked-list-fix-fix.patch
mm-remove-the-vma-linked-list-fix-fix-fix.patch
mm-remove-the-vma-linked-list-fix-4.patch

So please send when convenient and I'll check that it matches what I
presently have.

