Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997264FBB65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiDKL6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiDKL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:57:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8E3E0F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:55:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h19so14411987pfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sEywtpYv2PctFlTmV9AJrH5ksus0GSOYvDqq2/5FNuo=;
        b=sUtItqawKtyMuODSoAjOrQ7UoWi7Yex4vyke2nwkDiBC58YhKeQ9odon0oXJB3VDYP
         pZNbF80AD4mWVx4OdQ+v4NN4Xh5Ac8vy8t/iqQSg08CLuj3PNkUERrkBgtOjvu6jODmK
         evOmUGSkd+1od2Gd3KkrNaX6rfqImhtqHuzUa1ckJB4rVfNpNibjz6tI1uLK4wtIxFwr
         qyXdHrwD5ZcJ2bDJswENTT+oI0B/vJ8rj2wzraeriXhgCya7c/3nrqZ7x2RlC1cUVcLF
         C0CSOWLyEDPpzpcnlXfPOkRHxes4g2B5mk7DRiyNucfINyQ+bcwwjBthTB2aORQqNPQs
         TRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sEywtpYv2PctFlTmV9AJrH5ksus0GSOYvDqq2/5FNuo=;
        b=VzQ6HEOQwFaLRgIV7UMbp/1wCuXRMYJTMnQbIJsRfu3w5VUSjnLoUiJhsZx+CHzpXQ
         y+s3iyGFBtlPzKb6dUqnJhqOt7nfl+KIRRK0apiInlNJDO0/akr4Si2Wwo2sC62fa9wq
         nL63nx+zfK1qgHTTcHoYjFglYgOZTGfmHl4/vLpcNbD+8m3FWtjvkTeroefWxmMVeQ6l
         KGz8coqioz8ikZNQl38s8ioLm3w22+PTC3RRAeEZ9qqlolVAJ2NrumdbJEWuV8jLuwyX
         HUCniS+MLb7gMZZMMhgyLG5+G9SrCGGTy99VFIFHlh3zQF3xFm8HdG62B73TKPyT+Gzb
         C8Hw==
X-Gm-Message-State: AOAM531UEMXlmnWsrKDWsMhoG+ca735d4mJmzf9VWnV53CwyFQJOChCO
        VmTou0OBI8Vx7td0h0SBTaoS5g==
X-Google-Smtp-Source: ABdhPJx1D/wcONbVHYdgL4VYnSrlamOPssmoh4xrWDJL384BVwJcME9fnClJ9N0keeE8iZ8O7Sz4sg==
X-Received: by 2002:aa7:8893:0:b0:4fb:10e1:8976 with SMTP id z19-20020aa78893000000b004fb10e18976mr31901251pfe.36.1649678115699;
        Mon, 11 Apr 2022 04:55:15 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id o34-20020a634e62000000b0039cc4376415sm12282280pgl.63.2022.04.11.04.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:55:15 -0700 (PDT)
Date:   Mon, 11 Apr 2022 19:55:09 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, 21cnbao@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
Message-ID: <YlQXHeWPzRm8E2TC@FVFYT0MHHV2J.usts.net>
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com>
 <5b27aa62-da2b-e19d-3378-be5102ebebb6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b27aa62-da2b-e19d-3378-be5102ebebb6@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 03:42:52PM +0530, Anshuman Khandual wrote:
> 
> 
> On 3/31/22 12:26, Muchun Song wrote:
> > --- a/arch/arm64/mm/flush.c
> > +++ b/arch/arm64/mm/flush.c
> > @@ -68,6 +68,19 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
> >   */
> >  void flush_dcache_page(struct page *page)
> >  {
> > +	/*
> > +	 * Only the head page's flags of HugeTLB can be cleared since the tail
> > +	 * vmemmap pages associated with each HugeTLB page are mapped with
> > +	 * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
> > +	 * details can refer to vmemmap_remap_pte()).  Although
> 
> Did you see real permission fault when flush_dcache_page() accessed remapped
> tail pages, with readonly vmemmap ? OR this change is from code inspection ?
>

Not a real word issue. Just a code-inspection one.
 
> > +	 * __sync_icache_dcache() only set PG_dcache_clean flag on the head
> > +	 * page struct, some tail page structs still can be seen the flag is
> 
> Sentence here needs restructuring ....               ^^^^^^^^^^^^^^^^^^
> 

Will do.

> > +	 * set since the head vmemmap page frame is reused (more details can
> > +	 * refer to the comments above page_fixed_fake_head()).
> > +	 */
> > +	if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
> > +		page = compound_head(page);
> 
> This should also be applicable to any other platform with both configs enabled
> i.e ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE and ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP ?

Yes.

> If yes, then how to ensure that the platforms change flush_dcache_page() before
> subscribing into ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP ?
> 

The one who enable this feature has to make sure there is no any issues
(e.g. He should fix flush_dcache_page() or other related issues) with this
feature enabled.

Thanks.

