Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFF4C3FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiBYIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiBYIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52591DFDC4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645776083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxEkgFHWlRHgNokt14zVKg7qW6czfGlbSzwkwZw75A0=;
        b=FA53RrpZWJbuuaSndEfJUIrsgoQ6b9Jxdl08OxIHYCfDfpkD8/yRprEO1ZuCdbS1woPTIM
        diCkJ6vCz+7WPgsmPrbw2qSXIs1u2m1VtWJfP1XPx1ec52qvI67ihR41SvzTK37qj5ck/e
        KP/q7l6N2W+xEprPzezjiTWRpBKOK0M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-Irk-rA1pOCGdS4LHuhN2Lw-1; Fri, 25 Feb 2022 03:01:22 -0500
X-MC-Unique: Irk-rA1pOCGdS4LHuhN2Lw-1
Received: by mail-wr1-f72.google.com with SMTP id j27-20020adfb31b000000b001ea8356972bso606443wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=kxEkgFHWlRHgNokt14zVKg7qW6czfGlbSzwkwZw75A0=;
        b=Kq/FgqNnmTEGkndGfZUTOv5Hyx/MwvkrACLZEklZsx0F1N8dvp5gJm+ku90hmEHFzE
         X1c0nDATxpiq9P2reVdqdgMiHjZlwdUB+midZ4DvCvaSqDqZg9yJSBsME4JyAs+lUV7z
         AYyqoBJisCwOmAdkuivacXQNgkewRGeYhXv9PIWljfoei6/H1XUht3id47vLDeWIQTHw
         ZPwJcI68c7AX+nVxyszlJjV3tx0ZSWROCEEjRBwso/MegSoEQDkVE2j/cMvPM3AQxJxl
         gAVxoFqboesIxegUV2c3U8KqVsUvzT4jqZeKs6nF3m6aPhdh9i0mnM4rCFpYJTjM/Rd0
         SFoQ==
X-Gm-Message-State: AOAM5323TG47SNTay58vRUkb7d5gJUlKMJ4AB/RPf8oHJ83sPG9m9PL6
        ZgO77osy60YkMZiZgvru3z5fCIWnWm/dpElIoGUSA0KjJq/SAqATVXgthc8ChWVNiJ6Ebttl2nN
        VXkaOWgPLAKR1seFrEeU/zLRh
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id o24-20020a1c7518000000b0037c07ebf255mr1578000wmc.29.1645776080818;
        Fri, 25 Feb 2022 00:01:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyN87poyQBw/1i3JAFgNDtFHBe+rKf4EKP/70Us8z5RNeOxRIiN3s9a/T3STfYSEMuqEoSweA==
X-Received: by 2002:a1c:7518:0:b0:37c:7eb:f255 with SMTP id o24-20020a1c7518000000b0037c07ebf255mr1577979wmc.29.1645776080505;
        Fri, 25 Feb 2022 00:01:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:1900:f2f7:d2ad:80d9:218f? (p200300cbc7061900f2f7d2ad80d9218f.dip0.t-ipconnect.de. [2003:cb:c706:1900:f2f7:d2ad:80d9:218f])
        by smtp.gmail.com with ESMTPSA id k4-20020adfe8c4000000b001e68c92af35sm1523883wrn.30.2022.02.25.00.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 00:01:20 -0800 (PST)
Message-ID: <2df1e602-4182-b1e9-62f1-a8e29153d8d1@redhat.com>
Date:   Fri, 25 Feb 2022 09:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Oded Gabbay <oded.gabbay@gmail.com>
References: <20220224122614.94921-1-david@redhat.com>
 <20220225051511.2383-1-hdanton@sina.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 03/13] mm/memory: slightly simplify copy_present_pte()
In-Reply-To: <20220225051511.2383-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.22 06:15, Hillf Danton wrote:
> On Thu, 24 Feb 2022 13:26:04 +0100 David Hildenbrand wrote:
>> Let's move the pinning check into the caller, to simplify return code
>> logic and prepare for further changes: relocating the
>> page_needs_cow_for_dma() into rmap handling code.
>>
>> While at it, remove the unused pte parameter and simplify the comments a
>> bit.
>>
>> No functional change intended.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/memory.c | 53 ++++++++++++++++-------------------------------------
>>  1 file changed, 16 insertions(+), 37 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c6177d897964..accb72a3343d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -865,19 +865,11 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  }
>>  
>>  /*
>> - * Copy a present and normal page if necessary.
>> + * Copy a present and normal page.
>>   *
>> - * NOTE! The usual case is that this doesn't need to do
>> - * anything, and can just return a positive value. That
>> - * will let the caller know that it can just increase
>> - * the page refcount and re-use the pte the traditional
>> - * way.
>> - *
>> - * But _if_ we need to copy it because it needs to be
>> - * pinned in the parent (and the child should get its own
>> - * copy rather than just a reference to the same page),
>> - * we'll do that here and return zero to let the caller
>> - * know we're done.
>> + * NOTE! The usual case is that this isn't required;
>> + * instead, the caller can just increase the page refcount
>> + * and re-use the pte the traditional way.
>>   *
>>   * And if we need a pre-allocated page but don't yet have
>>   * one, return a negative error to let the preallocation
>> @@ -887,25 +879,10 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  static inline int
>>  copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>  		  pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
>> -		  struct page **prealloc, pte_t pte, struct page *page)
>> +		  struct page **prealloc, struct page *page)
>>  {
>>  	struct page *new_page;
>> -
>> -	/*
>> -	 * What we want to do is to check whether this page may
>> -	 * have been pinned by the parent process.  If so,
>> -	 * instead of wrprotect the pte on both sides, we copy
>> -	 * the page immediately so that we'll always guarantee
>> -	 * the pinned page won't be randomly replaced in the
>> -	 * future.
>> -	 *
>> -	 * The page pinning checks are just "has this mm ever
>> -	 * seen pinning", along with the (inexact) check of
>> -	 * the page count. That might give false positives for
>> -	 * for pinning, but it will work correctly.
>> -	 */
>> -	if (likely(!page_needs_cow_for_dma(src_vma, page)))
>> -		return 1;
>> +	pte_t pte;
>>  
>>  	new_page = *prealloc;
>>  	if (!new_page)
>> @@ -947,14 +924,16 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>  	struct page *page;
>>  
>>  	page = vm_normal_page(src_vma, addr, pte);
>> -	if (page) {
>> -		int retval;
>> -
>> -		retval = copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>> -					   addr, rss, prealloc, pte, page);
>> -		if (retval <= 0)
>> -			return retval;
>> -
>> +	if (page && unlikely(page_needs_cow_for_dma(src_vma, page))) {
>> +		/*
>> +		 * If this page may have been pinned by the parent process,
>> +		 * copy the page immediately for the child so that we'll always
>> +		 * guarantee the pinned page won't be randomly replaced in the
>> +		 * future.
>> +		 */
>> +		return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>> +					 addr, rss, prealloc, page);
> 
> Off topic question, is it likely that the DMA tranfer from device in parallel
> to copying page ends up with different data between parent and kid?

If the parent has a GUP pin on the page before fork(), the parent will
keep that page mapped exclusively and the child will receive a copy.

It's pretty much undefined which content that copy will have if there is
concurrent DMA via that GUP pin: we'll snapshot that page at some point
in time.

It's fully under the parent process control when to start/stop I/O via a
GUP pin and when to call fork().

So yes, if there is fork() with concurrent DMA via a GUP pin modifying
the page, the page content isn't well defined: could be the content
before DMA, mid DMA or post DMA.


-- 
Thanks,

David / dhildenb

