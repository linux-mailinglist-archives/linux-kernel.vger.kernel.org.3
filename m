Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97351EAB4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiEHAXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 20:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiEHAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 20:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3AEBC12
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 17:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651969165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8RQ/NBXUo1sDphRtbdglnAAjd1UBg3u9Ic5xtzocgM=;
        b=EnpLw0edi2nEVOHFIKDfYXJn8ye/Jo2ca+DFdYRTGDqIMe3E2Hk3jvPDWK3y2rdaRgskOO
        EIa1yTnLlRpt+8w5G08TqFyS3heZDnQClF+d/jwjVdTTg3zl3Ybti16Glhfld1ruG8bU4X
        iveyLXojCINq7LJSbBB02ftOoz6NFNY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-NRfQsSVOP5GiCVEUqY9k_w-1; Sat, 07 May 2022 20:19:24 -0400
X-MC-Unique: NRfQsSVOP5GiCVEUqY9k_w-1
Received: by mail-qk1-f200.google.com with SMTP id x191-20020a3763c8000000b0069fb66f3901so7392984qkb.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 17:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=D8RQ/NBXUo1sDphRtbdglnAAjd1UBg3u9Ic5xtzocgM=;
        b=0uxG4Tr/jOjZwkEG0fqQ3VUMaOuwagXSE6F5+UWvp83q40j8QqH95nke29DIqdXvfk
         Kff3AZ+ZvFYsfzTHyEw4ox38irdAUqw7bJAdVGqEcqbAzd6TOedYsKxLG3Y6We1XvOLn
         aDdUpUUH2SnM4GV8D2Iw14bZUeehwFjfJZKe3GDHyk2wa2D2v4qUKZVtzW9+2XqfLBxV
         wB520icyfi0eOv5Vxq58qknvdz016ZMGmqYJ/a2huReqhtvqPz4VaxerB1DSHVMFpVMO
         9bY97XRgcBxDSTBQ/dHUQwxlHU5nZWEsdHSTWdDQS5+bthrxWDraGjwIWq2dnXRgL1WW
         wmBg==
X-Gm-Message-State: AOAM531yaj8rsb3xRNzkMOeSqJnZQmtlJXLp5/sL3zL7MiG0mEAPULmT
        7NNPR9x6lmi11fPwNlv+hRlLXb5ry680jzr78n/FGYB2Ea0qjuNc5cHFq7QdGBSdigCEvO1bECE
        ArqDza/ZVb/hEtMCzapq8y1Et
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id h7-20020a05620a284700b0067d2bad422fmr7502666qkp.559.1651969163921;
        Sat, 07 May 2022 17:19:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhYz6BDmqA0tlTwXwMx+7nJK9CIoatYh8eI+7kQRPiNqOGNPgaez+SXAKYyc0zKb3Qz8wdng==
X-Received: by 2002:a05:620a:2847:b0:67d:2bad:422f with SMTP id h7-20020a05620a284700b0067d2bad422fmr7502659qkp.559.1651969163670;
        Sat, 07 May 2022 17:19:23 -0700 (PDT)
Received: from [10.23.153.165] ([46.248.132.196])
        by smtp.gmail.com with ESMTPSA id c138-20020ae9ed90000000b0069fc13ce211sm4544498qkg.66.2022.05.07.17.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 17:19:22 -0700 (PDT)
Message-ID: <5871724a-3a9c-75c8-15d9-d3f9fe31a3f0@redhat.com>
Date:   Sun, 8 May 2022 02:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
References: <20220505064429.2818496-1-minchan@kernel.org>
 <20220507122301.3b50eb030f9cd6f047f14352@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220507122301.3b50eb030f9cd6f047f14352@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.05.22 21:23, Andrew Morton wrote:
> On Wed,  4 May 2022 23:44:29 -0700 Minchan Kim <minchan@kernel.org> wrote:
> 
>> Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
>> so current is_pinnable_page could miss CMA pages which has MIGRATE_
>> ISOLATE. It ends up putting CMA pages longterm pinning possible on
>> pin_user_pages APIs so CMA allocation fails.
>>
>> The CMA allocation path protects the migration type change race
>> using zone->lock but what GUP path need to know is just whether the
>> page is on CMA area or not rather than exact type. Thus, we don't
>> need zone->lock but just checks the migratype in either of
>> (MIGRATE_ISOLATE and MIGRATE_CMA).
>>
>> Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
>> rejecting of pinning the page on MIGRATE_ISOLATE pageblock even
>> thouth it's neither CMA nor movable zone if the page is temporarily
> 
> "though"
> 
>> unmovable. However, the migration failure is general issue, not
>> only come from MIGRATE_ISOLATE and the MIGRATE_ISOLATE is also
>> transient state like other temporal refcount holding of pages.
>>
>> ...
>>
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1625,8 +1625,18 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>>  #ifdef CONFIG_MIGRATION
>>  static inline bool is_pinnable_page(struct page *page)
>>  {
>> -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
>> -		is_zero_pfn(page_to_pfn(page));
>> +#ifdef CONFIG_CMA
>> +	/*
>> +	 * use volatile to use local variable mt instead of
>> +	 * refetching mt value.
>> +	 */
>> +	volatile int mt = get_pageblock_migratetype(page);
>> +
>> +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>> +		return false;
>> +#endif
> 
> Open-coded use of `volatile' draws unwelcome attention.
> 
> What are we trying to do here?  Prevent the compiler from rerunning all
> of get_pageblock_migratetype() (really __get_pfnblock_flags_mask())
> twice?  That would be pretty dumb of it?
> 
> Would a suitably-commented something like
> 
> 	int __mt = get_pageblock_migratetype(page);
> 	int mt = __READ_ONCE(__mt);
> 
> express this better?

Yes, we want READ_ONCE I think. Apart from that LGTM.


-- 
Thanks,

David / dhildenb

