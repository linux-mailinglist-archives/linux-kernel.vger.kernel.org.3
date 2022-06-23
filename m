Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74AF557CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiFWN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiFWN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:28:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796572FFCB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1QLhXNXQq+r3hNERezeB41wLtAhbEfpWTSG6Y6DdYeU=; b=QvjDTMvbet4svpj2PO0DW7TArw
        IVfhGKCjFkBSadPRkxM4lGwZlXrkCbtJ/SaeKJZGi12prlTbSd4hgxXgQp6Tb9vJLi3PDaRCjTOak
        rnbrjlV/DcuzK2F2SrJAPyLWnH04HotuXNVqza/lj/vtVrmTDg/rAQxlwcPwjvHJZpbolbNXuPG2b
        cHR51iP44Y0WOegMxiTrEoHNBAX9PKqdruY3i94RpN1Fa86hKwTaeYkWkxAuGOACEFZQiqXYv8V7V
        rbOFh+I5g9AaNPrNxXy2d17jeFB2ZUjWPgU/zPSddC5VtLgp9MrSS0Mnq/Z2WU+ZnphXQ5NAyLdNC
        i5a2To6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Msw-007tUb-RU; Thu, 23 Jun 2022 13:28:39 +0000
Date:   Thu, 23 Jun 2022 14:28:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] mm: Add PUD level pagetable account
Message-ID: <YrRqhj3p/KKU73f1@casper.infradead.org>
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <f7b2a6f6f5dfecbcac07fa3e187f10860c3a39ee.1655887440.git.baolin.wang@linux.alibaba.com>
 <YrMpZlQHMuCy06/m@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrMpZlQHMuCy06/m@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 09:38:30AM -0500, Mike Rapoport wrote:
> On Wed, Jun 22, 2022 at 04:58:53PM +0800, Baolin Wang wrote:
> > +++ b/arch/loongarch/include/asm/pgalloc.h
> > @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
> >  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
> >  {
> >  	pud_t *pud;
> > +	struct page *pg;
> 
> 	struct page *page;
> 
> looks better IMO.
> 
> > +
> > +	pg = alloc_pages(GFP_KERNEL & ~__GFP_HIGHMEM, PUD_ORDER);

GFP_KERNEL does not include __GFP_HIGHMEM, so you can just use
GFP_KERNEL here.

> > +	if (!pg)
> > +		return NULL;
> >  
> > -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
> > -	if (pud)
> > -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
> > +	pgtable_set_and_inc(pg);
> > +	pud = (pud_t *)page_address(pg);
> 
> I don't think __get_free_pages() should be replaced with alloc_pages()
> here, just call pgtable_set_and_inc() with virt_to_page(pud). 

I don't understand why you want that.  Take a look at the implementation
of __get_free_pages().  Converting back to a struct page after calling
that seems like a real waste of time to me.

