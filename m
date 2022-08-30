Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88B25A679C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiH3Pn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiH3Pnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B0B95B6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661874228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5LIdhu1lS7jdtXtXqeaM3XP6rtL42Pg7PAfv3l7oebo=;
        b=IV53Ttd32XeYWOHgftAAdmpyRTjTuN5C522ipxOfaCUdnB6TVRc4PvI6VmHukEyo07KyHF
        E3BlXxOlX0LR5AhuGeC10pNTpBP8ySMUzZ0d5+3btwI9hTDuMM/AU6O9gjarvzkcdopIg3
        oMej10XnKqFZ57mwIswFXaccOqC1hNM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-112-AfJUtegQNna_HIU2mEvkoA-1; Tue, 30 Aug 2022 11:43:47 -0400
X-MC-Unique: AfJUtegQNna_HIU2mEvkoA-1
Received: by mail-wr1-f71.google.com with SMTP id j12-20020adfff8c000000b002265dcdfad7so1803191wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=5LIdhu1lS7jdtXtXqeaM3XP6rtL42Pg7PAfv3l7oebo=;
        b=ma3fW2P5Y1Ox+5rAK+DcPcnRKwfkYF8rPbrfsb2/mb5xqpWZpNMPK/3TcMTaWp0eTm
         wg1wViTUg8ibGTCRTf7r98abTl2FHi8dOtUbwcMfeNBQLMLlgS4GX9g69c37m4tXPzMy
         oJqmR6GAC7BeqoUKxovXE0TXGXk4NhuMaAfzFEk22ri1Lfrvs04vQwF/FCCQ1ygAqD+6
         WOljHinJmWFm8kY7RCI61blpvsYXYQIYf6A4THzZ1kLuKNru9XxuqM7qQyFplfF1anof
         X48rtf0326Jcx41KdqSlSbDnErgw50buTgPkqeFM5TmjGyarZ/gg0x8BaSSYOIxV2H5F
         bwgg==
X-Gm-Message-State: ACgBeo1j+vPpQ/iwSzjqPKIRC0XDrK+gLe6fRu9x1vsfbQXKHRIuD2tD
        l2jqHc0IkEUlGpqbrL0MHtpfJqa2kzah57MqNZF7khNSP8NXGrr3Wsq6iNpIQceWbvd25LDSjpu
        vz3xePqP/wOJzx0fMwX/q4rxx
X-Received: by 2002:a5d:59af:0:b0:220:6daf:5f64 with SMTP id p15-20020a5d59af000000b002206daf5f64mr9648509wrr.192.1661874224283;
        Tue, 30 Aug 2022 08:43:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4gkqPdWZbUokRdCqwdy4IuKKkxA7Rj+Tnk9DhqwplLuPQUU4aRQaSFoXshT0hGQOn942TiHA==
X-Received: by 2002:a5d:59af:0:b0:220:6daf:5f64 with SMTP id p15-20020a5d59af000000b002206daf5f64mr9648492wrr.192.1661874224005;
        Tue, 30 Aug 2022 08:43:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d4f85000000b0021e6c52c921sm11807206wru.54.2022.08.30.08.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:43:43 -0700 (PDT)
Message-ID: <e1747d53-a02d-ca32-cdc4-702315da57df@redhat.com>
Date:   Tue, 30 Aug 2022 17:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpivarc@redhat.com
References: <166182871735.3518559.8884121293045337358.stgit@omen>
 <39145649-c378-d027-8856-81b4f09050fc@redhat.com>
 <20220830091110.3f6d1737.alex.williamson@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] vfio/type1: Unpin zero pages
In-Reply-To: <20220830091110.3f6d1737.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.22 17:11, Alex Williamson wrote:
> On Tue, 30 Aug 2022 09:59:33 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 30.08.22 05:05, Alex Williamson wrote:
>>> There's currently a reference count leak on the zero page.  We increment
>>> the reference via pin_user_pages_remote(), but the page is later handled
>>> as an invalid/reserved page, therefore it's not accounted against the
>>> user and not unpinned by our put_pfn().
>>>
>>> Introducing special zero page handling in put_pfn() would resolve the
>>> leak, but without accounting of the zero page, a single user could
>>> still create enough mappings to generate a reference count overflow.
>>>
>>> The zero page is always resident, so for our purposes there's no reason
>>> to keep it pinned.  Therefore, add a loop to walk pages returned from
>>> pin_user_pages_remote() and unpin any zero pages.
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Luboslav Pivarc <lpivarc@redhat.com>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>  drivers/vfio/vfio_iommu_type1.c |   12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>> index db516c90a977..8706482665d1 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -558,6 +558,18 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>>>  	ret = pin_user_pages_remote(mm, vaddr, npages, flags | FOLL_LONGTERM,
>>>  				    pages, NULL, NULL);
>>>  	if (ret > 0) {
>>> +		int i;
>>> +
>>> +		/*
>>> +		 * The zero page is always resident, we don't need to pin it
>>> +		 * and it falls into our invalid/reserved test so we don't
>>> +		 * unpin in put_pfn().  Unpin all zero pages in the batch here.
>>> +		 */
>>> +		for (i = 0 ; i < ret; i++) {
>>> +			if (unlikely(is_zero_pfn(page_to_pfn(pages[i]))))
>>> +				unpin_user_page(pages[i]);
>>> +		}
>>> +
>>>  		*pfn = page_to_pfn(pages[0]);
>>>  		goto done;
>>>  	}
>>>
>>>   
>>
>> As discussed offline, for the shared zeropage (that's not even
>> refcounted when mapped into a process), this makes perfect sense to me.
>>
>> Good question raised by Sean if ZONE_DEVICE pages might similarly be
>> problematic. But for them, we cannot simply always unpin here.
> 
> What sort of VM mapping would give me ZONE_DEVICE pages?  Thanks,

I think one approach is mmap'ing a devdax device. To test without actual
NVDIMM hardware, there are ways to simulate it even on bare metal using
the "memmap=" kernel parameter.

https://nvdimm.wiki.kernel.org/

Alternatively, you can use an emulated nvdimm device under QEMU -- but
then you'd have to run VFIO inside the VM. I know (that you know) that
there are ways to get that working, but it certainly requires more effort :)

... let me know if you need any tips&tricks.

-- 
Thanks,

David / dhildenb

