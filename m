Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13A14F1878
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378589AbiDDPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357519AbiDDPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:34:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED33EB86
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SYr2TLjhGlOZxobWEY7RDAlP3qLX6lnM8lEfGNU7Who=; b=YtDXaz0GHV+kaFKec4Gbg/qSKw
        iluMjpKAovS3BE6Q+5NxvoLctO+LcJ2xP2/br78wpqAKs/XTplmFsaUc+lGRW6y0UmgyH4KRFt1Qx
        DZIal9b/Y1RY2bpBm95LSmf4tqk4OyCMzMlYoJvLGfreWE2KE2lEJAxmFyuN49fEUW2koJqA61ghl
        L4YbSzRtdcFnfhTJdc4XGt0sxPw0ZzfBk1LUWnsbrPq00bnywDvm7Tc8NFmCRs5DN5KvxUh4Fks7g
        DIYY6Oo3LluikXL2cuYvHcjklNhsB/rhcY/5X4k46PQvlSy2xiccuLYyNY64Ajzuh6IBsadNvZfgJ
        olhIFPIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbOh0-005qrA-12; Mon, 04 Apr 2022 15:32:34 +0000
Date:   Mon, 4 Apr 2022 16:32:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        william.kucharski@oracle.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        agruenba@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: remove obsolete comment in lock_page
Message-ID: <YksPkskcR6AdMaZf@casper.infradead.org>
References: <20220402062218.30709-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220402062218.30709-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 02:22:18PM +0800, Miaohe Lin wrote:
> lock_page needs the caller to have a reference on the page->mapping inode
> due to sync_page. Also lock_page_nosync is introduced which does not do a
> sync_page via commit db37648cd6ce ("[PATCH] mm: non syncing lock_page()").
> But commit 7eaceaccab5f ("block: remove per-queue plugging") kills off the
> old plugging along with aops->sync_page() and lock_page_nosync. So there
> is no need to have a reference on the page->mapping inode when calling
> lock_page anymore. Remove this obsolete and confusing comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.  I'll fix up the changelog (some of the tenses are a little
strange) and take this through my pagecache tree.

>  include/linux/pagemap.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 993994cd943a..8dfe8e49c427 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -908,9 +908,6 @@ static inline void folio_lock(struct folio *folio)
>  		__folio_lock(folio);
>  }
>  
> -/*
> - * lock_page may only be called if we have the page's inode pinned.
> - */
>  static inline void lock_page(struct page *page)
>  {
>  	struct folio *folio;
> -- 
> 2.23.0
> 
