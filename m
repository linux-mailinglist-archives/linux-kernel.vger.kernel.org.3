Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558474EC55F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiC3NSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344548AbiC3NSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67E7430553
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648646182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnxtFaPEsAbcqp1OXIyz2pPqcdL85OCUy3HvsOGAwFo=;
        b=OO0Ev6VWdEbEDLQwhq8mlJw4DHHXcjwHOiS1iyXpnx0BZhlFDNc5oeck9r4vRH0jf//HwJ
        3B67z1JhtOIe3uUAq5ioL2s5xhnxLggjakkURhSdXP+KN6SoRiiwB8jkDmi+xCP4yYJ/YF
        FVhYWFkf9o98G5aj7dwDCV7t0OiqG+0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-y6rOGr_bPy2mnzYOKyw1hg-1; Wed, 30 Mar 2022 09:16:20 -0400
X-MC-Unique: y6rOGr_bPy2mnzYOKyw1hg-1
Received: by mail-wr1-f71.google.com with SMTP id i27-20020adfa51b000000b00205c997f177so1785117wrb.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=PnxtFaPEsAbcqp1OXIyz2pPqcdL85OCUy3HvsOGAwFo=;
        b=bVBjoMqyiqfK2VEA/Al9bOVgA8maQNludThqiEJPOAs+E8Ldh6Ihez/UKVHxB2Vp3G
         lgAqk7ylwyIURupC2JYsTtTZQmSnsX8ikNiPmHPYZvkYPkhm0HPeMcmlUqgqdLMyRnuS
         ui6UrafmIFNNUiWat0XeZVFYmN4XYYl6dqxoVBXfWw5m+DBErqqIkK071hOZ2fwQcdyy
         4c0Rj5pPWGGCXB+0VNqwnnQC1ZPY12lYcGkj9WXQ8PV/awpiLOCxvuj86xYK6oyzZj1X
         pOqtk1jfV/r0sql/nqFBZmqz4HeFRHdxNG/sHgz7/YJtvirbAVInmur1BYdglCACANRd
         6xTA==
X-Gm-Message-State: AOAM532DkiKvE0omtPqaVLyTuEtwCDJBGJaJuBkeyCprmkz2vAsYvcrY
        S+MdwhbYlppgZuYn1SBJLgYeq3RTIfZUOTiG/ZSZsnB3ZGxynz17B7ernER2QRRD1Wf10Oe61/m
        z2vButTKQUB2lJ8vAfN4htBrK
X-Received: by 2002:adf:fe06:0:b0:205:c132:dbad with SMTP id n6-20020adffe06000000b00205c132dbadmr19574801wrr.533.1648646179253;
        Wed, 30 Mar 2022 06:16:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo4kSgzx5PzxRIo+ZQLkRE2eAGXIuAS40ZlmFQA5g7ZOMJcX0MypYbjC51u++JFMlRa/3IcA==
X-Received: by 2002:adf:fe06:0:b0:205:c132:dbad with SMTP id n6-20020adffe06000000b00205c132dbadmr19574780wrr.533.1648646178934;
        Wed, 30 Mar 2022 06:16:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2200:178b:7244:2a1f:b5d8? (p200300cbc7052200178b72442a1fb5d8.dip0.t-ipconnect.de. [2003:cb:c705:2200:178b:7244:2a1f:b5d8])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm5141804wmb.48.2022.03.30.06.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 06:16:18 -0700 (PDT)
Message-ID: <d29d5b05-ad7e-d459-be58-f183f32fe8a9@redhat.com>
Date:   Wed, 30 Mar 2022 15:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] mm: fix contiguous memmap assumptions about
 alloc/free pages
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org
References: <20220330102534.1053240-1-chenwandun@huawei.com>
 <20220330102534.1053240-3-chenwandun@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220330102534.1053240-3-chenwandun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.22 12:25, Chen Wandun wrote:
> It isn't true for only SPARSEMEM configs to assume that a compound page
> has virtually contiguous page structs, so use nth_page to iterate each
> page.

I really don't see how that is currently the case. The buddy deals with
order < MAX_ORDER and we know that these always fall into a single
memory section.

IOW, this patch here would result in overhead where it's not required to
have that overhead.

What am I missing and which scenario are we fixing?

> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/page_alloc.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 855211dea13e..758d8f069b32 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -721,7 +721,7 @@ static void prep_compound_head(struct page *page, unsigned int order)
>  
>  static void prep_compound_tail(struct page *head, int tail_idx)
>  {
> -	struct page *p = head + tail_idx;
> +	struct page *p = nth_page(head, tail_idx);
>  
>  	p->mapping = TAIL_MAPPING;
>  	set_compound_head(p, head);
> @@ -1199,10 +1199,10 @@ static inline int check_free_page(struct page *page)
>  	return 1;
>  }
>  
> -static int free_tail_pages_check(struct page *head_page, struct page *page)
> +static int free_tail_pages_check(struct page *head_page, int index)
>  {
> +	struct page *page = nth_page(head_page, index);
>  	int ret = 1;
> -
>  	/*
>  	 * We rely page->lru.next never has bit 0 set, unless the page
>  	 * is PageTail(). Let's make sure that's true even for poisoned ->lru.
> @@ -1213,7 +1213,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
>  		ret = 0;
>  		goto out;
>  	}
> -	switch (page - head_page) {
> +	switch (index) {
>  	case 1:
>  		/* the first tail page: ->mapping may be compound_mapcount() */
>  		if (unlikely(compound_mapcount(page))) {
> @@ -1322,6 +1322,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	if (unlikely(order)) {
>  		bool compound = PageCompound(page);
>  		int i;
> +		struct page *tail_page;
>  
>  		VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
>  
> @@ -1330,13 +1331,14 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  			ClearPageHasHWPoisoned(page);
>  		}
>  		for (i = 1; i < (1 << order); i++) {
> +			tail_page = nth_page(page, i);
>  			if (compound)
> -				bad += free_tail_pages_check(page, page + i);
> -			if (unlikely(check_free_page(page + i))) {
> +				bad += free_tail_pages_check(page, i);
> +			if (unlikely(check_free_page(tail_page))) {
>  				bad++;
>  				continue;
>  			}
> -			(page + i)->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
> +			tail_page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
>  		}
>  	}
>  	if (PageMappingFlags(page))


-- 
Thanks,

David / dhildenb

