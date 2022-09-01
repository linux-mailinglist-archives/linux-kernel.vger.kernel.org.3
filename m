Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54945A9EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiIASdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiIASdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:33:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C327E02F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B7YWWxgdwGX8fRegL9+nqJ6tES+1V/k9HDc5eItCkcg=; b=pSQXXM1gehMmdnG/Cim3BGcgZl
        eQCMHcBzm9rbMcB9oUMUo3PHghTlt9WYtJ40Ff33BGnGch3Sa59pqeIyDvy6ian+lHYPvcbaoqqw0
        nePch6kTIX+Ymk2gdMOkjyKGRr/gHm1N7XC/KyE0cbul6hGhPYj+fX1xteafiNP1osAl1gCbA2lIv
        /+0wv+4Xyq9v/CsNZIMI6amJN4fCk8DLdHCLe6WcT14vpKlee/LGZtbSlH4ohWbTzF0vmHUh9gD9q
        0EIwHhJnDUvu0dZnGFIzDT1eoo7RIm89rqJ7ikdZ6ATm4NT71UocMO+80/wHw/N90MSZqtmPagt1D
        ki9OgsjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTozr-006GDQ-H9; Thu, 01 Sep 2022 18:32:59 +0000
Date:   Thu, 1 Sep 2022 19:32:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        vbabka@suse.cz, william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 2/7] mm: add private field of first tail to struct page
 and struct folio
Message-ID: <YxD6215MS+L+tGLc@casper.infradead.org>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-3-sidhartha.kumar@oracle.com>
 <YxDsu8Ol/yOg7sMV@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDsu8Ol/yOg7sMV@monkey>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:32:43AM -0700, Mike Kravetz wrote:
> Not really an issue with this patch, but it made me read more of this
> comment about folios.  It goes on to say ...
> 
>  * same power-of-two.  It is at least as large as %PAGE_SIZE.  If it is
>  * in the page cache, it is at a file offset which is a multiple of that
>  * power-of-two.  It may be mapped into userspace at an address which is
>  * at an arbitrary page offset, but its kernel virtual address is aligned
>  * to its size.
>  */
> 
> This series is to begin converting hugetlb code to folios.  Just want to
> note that 'hugetlb folios' have specific user space alignment restrictions.
> So, I do not think the comment about arbitrary page offset would apply to
> hugetlb.
> 
> Matthew, should we note that hugetlb is special in the comment?  Or, is it
> not worth updating?

I'm open to updating it if we can find good wording.  What I'm trying
to get across there is that when dealing with folios, you can assume
that they're naturally aligned physically, logically (in the file) and
virtually (kernel address), but not necessarily virtually (user
address).  Hugetlb folios are special in that they are guaranteed to
be virtually aligned in user space, but I don't know if here is the
right place to document that.  It's an additional restriction, so code
which handles generic folios doesn't need to know it.

> Also, folio_get_private_1 will be used for the hugetlb subpool pointer
> which resides in page[1].private.  This is used in the next patch of
> this series.  I'm sure you are aware that hugetlb also uses page private
> in sub pages 2 and 3.  Can/will/should this method of accessing private
> in sub pages be expanded to cover these as well?  Expansion can happen
> later, but if this can not be expanded perhaps we should come up with
> another scheme.

There's a few ways of tackling this.  What I'm currently thinking is
that we change how hugetlbfs uses struct page to store its extra data.
It would end up looking something like this (in struct page):

+++ b/include/linux/mm_types.h
@@ -147,9 +147,10 @@ struct page {
                };
                struct {        /* Second tail page of compound page */
                        unsigned long _compound_pad_1;  /* compound_head */
-                       unsigned long _compound_pad_2;
                        /* For both global and memcg */
                        struct list_head deferred_list;
+                       unsigned long hugetlbfs_private_2;
+                       unsigned long hugetlbfs_private_3;
                };
                struct {        /* Page table pages */
                        unsigned long _pt_pad_1;        /* compound_head */

although we could use better names and/or types?  I haven't looked to
see what you're storing here yet.  And then we can make the
corresponding change to struct folio to add these elements at the
right place.

Does that sound sensible?
