Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F102522684
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiEJVyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiEJVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:54:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE3297424
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:54:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w17-20020a17090a529100b001db302efed6so299562pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dM2MOp7+Nv3LrAgQGv5Bd3rXalt2DgaTDZiB1+yMCN4=;
        b=lSjEVHnorne5+Kxt+cpi2lMixGxPrZRttPkvNoh3TQLLN3mzHQJwtph53eHaVKOkvC
         p7muuCME/A4uxZhsl83UQnNtMY8NMii7rw3C9Ew2WCQXteRDwKjqjXe/blp2VbNICJC7
         MtvPCnbbfNCG9hEl27hxY6+n+4AG5jM0wy2U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dM2MOp7+Nv3LrAgQGv5Bd3rXalt2DgaTDZiB1+yMCN4=;
        b=jTCjBPZNDBxZ8es+bRWLO28q1J9asPEH671blzjjT1q0an0OupYRPIdoQMcb/QkTPv
         zM5mrfp/gHIA+9ZcM7FE132YfRIwhnSk8SjLqRsb4d6979wNt2tpzjyXG3aVIjd3YtrD
         2Mt43vZWqQ52BzK03ThnSiSzOeLml1xkDSZnjA2vujxmuHC8l3hq0EspvcPs+JROyVK4
         u13RsG9xfe8fe64Von+piRkjOjjsJUt4HjgqQgIkr7j/R1fxqAvia/wZGno5DFJWUYpY
         7V0IPbeqecD4MmguIutV0NF6N7T8g2Df8z9iPggXEEkhQFiUtOJ90T1jud3uFuOCv96F
         cTaQ==
X-Gm-Message-State: AOAM530NgwI4GEL5HH7nUJrvNyN7qDyKZRCH3bpjC2uFvbXIowgm/F0I
        w07AIg/utEpn2Eg/YvgKjq82Fw==
X-Google-Smtp-Source: ABdhPJxTHw2t/gxEnToutFMM1kBiMch7wUVNUKhamPCzu7/JWeWpETNidI8u+4KPjULB98ElT3cCPA==
X-Received: by 2002:a17:90a:e7c3:b0:1dc:5d85:9fd0 with SMTP id kb3-20020a17090ae7c300b001dc5d859fd0mr1934949pjb.168.1652219688697;
        Tue, 10 May 2022 14:54:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902a60400b0015eab1b097dsm125753plq.22.2022.05.10.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 14:54:48 -0700 (PDT)
Date:   Tue, 10 May 2022 14:54:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanzheng Song <songyuanzheng@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: usercopy: move the virt_addr_valid() below the
 is_vmalloc_addr()
Message-ID: <202205101453.145A1C4F@keescook>
References: <20220505071037.4121100-1-songyuanzheng@huawei.com>
 <20220509203732.951da2e00ddfa628decf24a2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509203732.951da2e00ddfa628decf24a2@linux-foundation.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:37:32PM -0700, Andrew Morton wrote:
> Matthew & Kees,
> 
> On Thu, 5 May 2022 07:10:37 +0000 Yuanzheng Song <songyuanzheng@huawei.com> wrote:
> 
> > The is_kmap_addr() and the is_vmalloc_addr() in the check_heap_object()
> > will not work, because the virt_addr_valid() will exclude the kmap and
> > vmalloc regions. So let's move the virt_addr_valid() below
> > the is_vmalloc_addr().
> 
> The author,
> 
> > Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
> 
> Tells me off-list that this fix:
> 
> > --- a/mm/usercopy.c
> > +++ b/mm/usercopy.c
> > @@ -163,9 +163,6 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
> >  {
> >  	struct folio *folio;
> >  
> > -	if (!virt_addr_valid(ptr))
> > -		return;
> > -
> >  	if (is_kmap_addr(ptr)) {
> >  		unsigned long page_end = (unsigned long)ptr | (PAGE_SIZE - 1);
> >  
> > @@ -190,6 +187,9 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
> >  		return;
> >  	}
> >  
> > +	if (!virt_addr_valid(ptr))
> > +		return;
> > +
> >  	folio = virt_to_folio(ptr);
> >  
> >  	if (folio_test_slab(folio)) {
> 
> is required to fix patches "mm/usercopy: Check kmap addresses properly"
> and "mm/usercopy: Detect vmalloc overruns".

Ah, this very well may be true! I will need to study this (or more
likely, I will build some selftests), but I suspect willy knows off the
top of his head. :)

-- 
Kees Cook
