Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B124C6E73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiB1NmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiB1Nl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:41:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C327C7AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sQtTKWJmjpY/ri7IYv25rVo1Rbt+2LizJ2pbjnDNo3Q=; b=cvw+XDmD0ZgdE5aLkvbVfFMS6l
        c/Ie3dW6zQ7w9oV5vT+5yQHgXAajqWaWo5YqvDupVLpOpqcHFv2KYVXXcUjUTm31WXDHpVC49VLEO
        HMz3fciGM/DoaYcOQ5QrnqTVm0hUXLqLu44j+stFj862JqqkA3DhO4HeXR9HK+WUkEd+9bAxvZ3yR
        PYNA0mUA363VIX9cdRz1cXyYAcnIe5UJmpY7EbWKjj/CScoJY04MM5ktWL1zWJoEQ90pqe14wU0Uv
        jXAYhhKNqSORA8Dgw25HMlvXhmlUBU0mLmFnFFt2hwaEone8bwzZpMG9y+HOuBWnyAQw64xGzl6qD
        UIz2MqoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOgH0-00CdxV-6a; Mon, 28 Feb 2022 13:41:10 +0000
Date:   Mon, 28 Feb 2022 05:41:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        willy@infradead.org, kirill@shutemov.name, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Export PageHeadHuge()
Message-ID: <YhzQ9izSfN7JQ9Go@infradead.org>
References: <2494562.1646054576@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2494562.1646054576@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 01:22:56PM +0000, David Howells wrote:
>     
> Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
> such as folio_file_page() and folio_contains().  Matthew suggested I use
> the first of those instead of doing the same calculation manually - but
> I can't call it from a module.
> 
> Kirill suggested rearranging things to put it in a header, but that
> introduces header dependencies because of where constants are defined.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: willy@infradead.org
> Link: https://lore.kernel.org/r/163707085314.3221130.14783857863702203440.stgit@warthog.procyon.org.uk/
> 
> ---
>  mm/hugetlb.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 61895cc01d09..5768df43b05c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1854,6 +1854,7 @@ int PageHeadHuge(struct page *page_head)
>  
>  	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
>  }
> +EXPORT_SYMBOL(PageHeadHuge);

EXPORT_SYMBOL_GPL for anything hugepage related, please.
