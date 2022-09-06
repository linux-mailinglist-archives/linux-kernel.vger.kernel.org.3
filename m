Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29B85AE8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiIFMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiIFMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22113E74F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662468652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CS1sV3mhmp6RRPBp+HAVZ3XD9a2FK1IEmXWlvT/wGPA=;
        b=jBTQijSTNUbKpWs/deJUwZouNT/lp+pS7Glkntg40ZY78o3fQh/p7uI5QjBkv/P3JbFrYV
        mVftztCGwZ4WVmf2Q5CoxeAYeK7xEqpKOqQKAcDgkaUPMvw6FekFDUqM7vWEq1gny8t3Hd
        r86ucFcmvZ6Sw8a3Adc+DTIQEAhpADQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-tTnKDc41OgGiF7O_obOSWg-1; Tue, 06 Sep 2022 08:50:49 -0400
X-MC-Unique: tTnKDc41OgGiF7O_obOSWg-1
Received: by mail-wr1-f69.google.com with SMTP id s26-20020adfa29a000000b00228b0cdb116so1574042wra.23
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=CS1sV3mhmp6RRPBp+HAVZ3XD9a2FK1IEmXWlvT/wGPA=;
        b=bpCU0WXekOGq04QD5PM/PEqFxnSSlDaOPpsYGMaAPmzdVtYhMMthJtmJbu6GL9cZk2
         JXOM9UyPVaPoitS3OVMvKFAETsLipv6B/EZ5EZg4fEVj+0n1z7Y6khIi/3apjgc9QmM8
         cL15/BGUxyah9ymGUsmkxKbnYWwvOQqVReTL99BhIQvXUIioiyf3GqnfwMvc44tWjifB
         +sNiwtVLxQOrni7YrfbGKIfxxNwFz5+tgtuUG4vlH19G5n3L3hmzrVBslLcqXcJp1Tb3
         OI83xC4q+5CCyCYwNbqAtr1GpU/xw10pa4NnoO4FnsJ7zepmQK5aB+Yrg+SAEC0BbsAA
         ph9A==
X-Gm-Message-State: ACgBeo0b1ijsPMaXE/vAuNhYW5D6SZvgIvP3e5PUa3iWh/W9SOLUlJE+
        yDc4/Q7R/UOrCKZyEO56UePWg4+Uz8RcDglpJfRIuIwomupB7Umg/hI5zvbAVlJfVq+YgQIdd9Z
        3oATtJvGaJQRuuCE5iJFuKGEZ
X-Received: by 2002:a5d:4587:0:b0:226:d803:2acf with SMTP id p7-20020a5d4587000000b00226d8032acfmr25045773wrq.329.1662468648067;
        Tue, 06 Sep 2022 05:50:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR48HGgevMs+kFVKIQO+SzWnrQoNNZk5w3KONC0Iy/cSti59UErxZmeyl6ZqA3Z2IOUUjVNtwQ==
X-Received: by 2002:a5d:4587:0:b0:226:d803:2acf with SMTP id p7-20020a5d4587000000b00226d8032acfmr25045763wrq.329.1662468647714;
        Tue, 06 Sep 2022 05:50:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id bo11-20020a056000068b00b002251639bfd0sm12963908wrb.59.2022.09.06.05.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 05:50:47 -0700 (PDT)
Message-ID: <30e2f5e1-a2de-0036-6242-b6f7021a8692@redhat.com>
Date:   Tue, 6 Sep 2022 14:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        peterx@redhat.com, kirill.shutemov@linux.intel.com, jgg@nvidia.com,
        hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <c38494f0-1bc5-61e4-8459-be9160029539@nvidia.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c38494f0-1bc5-61e4-8459-be9160029539@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I believe you're referring to this:
> 
> 	folio = try_grab_folio(page, 1, flags);
> 
> just earlier in gup_pte_range(). Yes that's true...but it's hidden, which
> is unfortunate. Maybe a comment could help.
> 

Most certainly.

>>
>> If we still intend to change that code, we should fixup all GUP-fast
>> functions in a similar way. But again, I don't think we need a change here.
>>
> 
> It's really rough, having to play this hide-and-seek game of "who did
> the memory barrier". And I'm tempted to suggest adding READ_ONCE() to
> any and all reads of the page table entries, just to help stay out of
> trouble. It's a visual reminder that page table reads are always a
> lockless read and are inherently volatile.
> 
> Of course, I realize that adding extra READ_ONCE() calls is not a good
> thing. It might be a performance hit, although, again, these are
> volatile reads by nature, so you probably had a membar anyway.
> 
> And looking in reverse, there are actually a number of places here where
> we could probably get away with *removing* READ_ONCE()!
> 
> Overall, I would be inclined to load up on READ_ONCE() calls, yes. But I
> sort of expect to be overridden on that, due to potential performance
> concerns, and that's reasonable.
> 
> At a minimum we should add a few short comments about what memory
> barriers are used, and why we don't need a READ_ONCE() or something
> stronger when reading the pte.

Adding more unnecessary memory barriers doesn't necessarily improve the 
situation.

Messing with memory barriers is and remains absolutely disgusting.

IMHO, only clear documentation and ASCII art can keep it somehow 
maintainable for human beings.

> 
> 
>>
>>>> -	 * After this gup_fast can't run anymore. This also removes
>>>> -	 * any huge TLB entry from the CPU so we won't allow
>>>> -	 * huge and small TLB entries for the same virtual address
>>>> -	 * to avoid the risk of CPU bugs in that area.
>>>> +	 * This removes any huge TLB entry from the CPU so we won't allow
>>>> +	 * huge and small TLB entries for the same virtual address to
>>>> +	 * avoid the risk of CPU bugs in that area.
>>>> +	 *
>>>> +	 * Parallel fast GUP is fine since fast GUP will back off when
>>>> +	 * it detects PMD is changed.
>>>>    	 */
>>>>    	_pmd = pmdp_collapse_flush(vma, address, pmd);
>>>
>>> To follow up on David Hildenbrand's note about this in the nearby thread...
>>> I'm also not sure if pmdp_collapse_flush() implies a memory barrier on
>>> all arches. It definitely does do an atomic op with a return value on x86,
>>> but that's just one arch.
>>>
>>
>> I think a ptep/pmdp clear + TLB flush really has to imply a memory
>> barrier, otherwise TLB flushing code might easily mess up with
>> surrounding code. But we should better double-check.
> 
> Let's document the function as such, once it's verified: "This is a
> guaranteed memory barrier".

Yes. Hopefully it indeed is on all architectures :)

-- 
Thanks,

David / dhildenb

