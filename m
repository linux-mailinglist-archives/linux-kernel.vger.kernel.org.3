Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F55A5A18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiH3Dgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH3Dgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:36:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9627FE52
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uRgJgJxuAtkFqhcrFtpIXGr2qJkeEfRvFFtV3MUVJKg=; b=lkuoSRY94uq2I9RzVPvlgPl/F7
        cGGeAzHCVeMN62Xg4IT6DYHHKK0fpb2+Mb0hd8nxm1VQLJLa1tY2shASO5agTDTJXlOzRLcZc/7ZL
        mIsu3IdwedATtQHfPPEOB4P92SPM48epx0gUdPkVZm2lJwVteJHt6Nb9v6vUoiH8WqOFb+raYYZ8f
        8uW6MjNEWE+HlEGVQmgq28ODTxPhtwYpBYyv4cQ3x+7OgPZRGNmRsSGwnbJSTk5+1nXjS+WsoTk4o
        OQpLgaCSlzxZ3cqU3nHhLuuRwSE5v/WNtaAy/BNWH/vdyp2MNfyjeZxbACQHwPNy75KxHpxunyw7R
        +GxItWOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSs3I-003e6W-GS; Tue, 30 Aug 2022 03:36:36 +0000
Date:   Tue, 30 Aug 2022 04:36:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com
Subject: Re: [PATCH 2/7] mm: add private field of first tail to struct page
 and struct folio
Message-ID: <Yw2FxCKxm429Py9P@casper.infradead.org>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
 <20220829230014.384722-3-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829230014.384722-3-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 04:00:09PM -0700, Sidhartha Kumar wrote:
> +++ b/include/linux/mm_types.h
> @@ -144,6 +144,7 @@ struct page {
>  #ifdef CONFIG_64BIT
>  			unsigned int compound_nr; /* 1 << compound_order */
>  #endif
> +			unsigned long _private_1;
>  		};
>  		struct {	/* Second tail page of compound page */
>  			unsigned long _compound_pad_1;	/* compound_head */

Have you tested compiling this on 32-bit?  I think you need to move
the _private_1 inside the ifdef CONFIG_64BIT.

> @@ -251,6 +252,7 @@ struct page {
>   * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
>   * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
>   * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
> + * @_private_1: Do not use directly, call folio_get_private_1().
>   *
>   * A folio is a physically, virtually and logically contiguous set
>   * of bytes.  It is a power-of-two in size, and it is aligned to that
> @@ -298,6 +300,8 @@ struct folio {
>  #ifdef CONFIG_64BIT
>  	unsigned int _folio_nr_pages;
>  #endif
> +	unsigned long _private_1;

(but don't do that here!)

The intent is that _private_1 lines up with head[1].private on 32-bit.
It's a bit tricky, and I'm not sure that I'm thinking about it quite right.

>  };
>  
>  #define FOLIO_MATCH(pg, fl)						\
> @@ -325,6 +329,7 @@ FOLIO_MATCH(compound_mapcount, _total_mapcount);
>  FOLIO_MATCH(compound_pincount, _pincount);
>  #ifdef CONFIG_64BIT
>  FOLIO_MATCH(compound_nr, _folio_nr_pages);
> +FOLIO_MATCH(_private_1, _private_1);
>  #endif
>  #undef FOLIO_MATCH
>  
> @@ -370,6 +375,16 @@ static inline void *folio_get_private(struct folio *folio)
>  	return folio->private;
>  }
>  
> +static inline void folio_set_private_1(struct folio *folio, unsigned long private)
> +{
> +	folio->_private_1 = private;
> +}
> +
> +static inline unsigned long folio_get_private_1(struct folio *folio)
> +{
> +	return folio->_private_1;
> +}
> +
>  struct page_frag_cache {
>  	void * va;
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -- 
> 2.31.1
> 
