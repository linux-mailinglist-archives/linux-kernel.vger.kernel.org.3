Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981284DA0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350489AbiCORP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350486AbiCORPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0BDF1E3EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647364450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FsVY1kXB4ioI1J1uyDxz0dDFxgjXb4CnXzGjz5blmOc=;
        b=jK7qNJyNLNLvNedzZc1p/IIn2ASX2Np0ylSOvwTtkUL0P6w+bH/VoJiZ8TM/asARHXEgGM
        BfNoEHF+YiWYMvmlnrFWrjj8H4Wi9pxbZbYnJMpZJ95GmMjscs0DfiENLcb9n+OrcbLpyg
        aXSH9f7y4JNtuX47qzfk1EqUG+fAbus=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-vzKRn9_ePyW_wG3GkcA1hQ-1; Tue, 15 Mar 2022 13:14:08 -0400
X-MC-Unique: vzKRn9_ePyW_wG3GkcA1hQ-1
Received: by mail-wr1-f71.google.com with SMTP id e6-20020a5d4e86000000b001f045d4a962so5527489wru.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=FsVY1kXB4ioI1J1uyDxz0dDFxgjXb4CnXzGjz5blmOc=;
        b=lksByKCv+1tf1L1F40Ay5YAUwLiY/Qk9cUcPyL1vbUKbdYFEA6aFmwoGxhBMUWsbuk
         pIQoxo5YBrY7onckx5bGzbkJA9gzuehmxsw0jbOpSYIz2/0UKSD1hukeONeswtMBByLB
         TyiLdHgIBM8xJuQn/8d52G1VqaS2LGJ8DAyZoESRhoKdv9CBuHVsSVPBnjlHpfqz7LhY
         tEFkquX7w5C3UYC+GJu3AJxEIPXyfhtbLI/Gv5+GRbcsbYv7+3oFKhe4ULaM/TIYPY9a
         tU3Lv3OOtmmPJdGjPAibG87WdePoVoL/5K8kEFHJaoYFrY/TIKKaFqXcy0+2rRobtXsk
         sJ8Q==
X-Gm-Message-State: AOAM531C5tjb2/H+jsvS5GjotAy1BOY+3HOe4LZBD74A2tYgj6L2krmF
        UJRJ9bAFsRItBT/mEBBH194mcBcHjDHjwI/aVWMhxKvEDmdLZyzAS502RcbLVLZAlRqO5zX7Zx2
        vbgYjmpWwXJb4/Alwfc8ug8dd
X-Received: by 2002:adf:db01:0:b0:1f1:dcea:2b7f with SMTP id s1-20020adfdb01000000b001f1dcea2b7fmr21378181wri.598.1647364447499;
        Tue, 15 Mar 2022 10:14:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdS8qTqdqR219JFpZK+GPZ5bYAnnLa33KsM4wjU9HkrplJGzUCifrTI55X5XaluCKbirwW1w==
X-Received: by 2002:adf:db01:0:b0:1f1:dcea:2b7f with SMTP id s1-20020adfdb01000000b001f1dcea2b7fmr21378152wri.598.1647364447236;
        Tue, 15 Mar 2022 10:14:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1800:42bd:3cac:d22a:3c62? (p200300cbc708180042bd3cacd22a3c62.dip0.t-ipconnect.de. [2003:cb:c708:1800:42bd:3cac:d22a:3c62])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4f07000000b00203db8f13c6sm466545wru.75.2022.03.15.10.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:14:06 -0700 (PDT)
Message-ID: <51afa7a7-15c5-8769-78db-ed2d134792f4@redhat.com>
Date:   Tue, 15 Mar 2022 18:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 5/7] s390/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-6-david@redhat.com> <20220315172102.771bd2cf@thinkpad>
 <c8229082-e8f1-e605-25c2-0ec9d23efd9e@redhat.com>
 <8b13b6c0-78d4-48e3-06f0-ec0680d013a9@redhat.com>
 <55b6b582-51ca-b869-2055-674fe4c563e6@redhat.com>
Organization: Red Hat
In-Reply-To: <55b6b582-51ca-b869-2055-674fe4c563e6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.22 18:12, David Hildenbrand wrote:
> On 15.03.22 17:58, David Hildenbrand wrote:
>>
>>>> This would mean that it is not OK to have bit 52 not zero for swap PTEs.
>>>> But if I read the POP correctly, all bits except for the DAT-protection
>>>> would be ignored for invalid PTEs, so maybe this comment needs some update
>>>> (for both bits 52 and also 55).
>>>>
>>>> Heiko might also have some more insight.
>>>
>>> Indeed, I wonder why we should get a specification exception when the
>>> PTE is invalid. I'll dig a bit into the PoP.
>>
>> SA22-7832-12 6-46 ("Translation-Specification Exception") is clearer
>>
>> "The page-table entry used for the translation is
>> valid, and bit position 52 does not contain zero."
>>
>> "The page-table entry used for the translation is
>> valid, EDAT-1 does not apply, the instruction-exe-
>> cution-protection facility is not installed, and bit
>> position 55 does not contain zero. It is model
>> dependent whether this condition is recognized."
>>
> 
> I wonder if the following matches reality:
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 008a6c856fa4..6a227a8c3712 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1669,18 +1669,16 @@ static inline int has_transparent_hugepage(void)
>  /*
>   * 64 bit swap entry format:
>   * A page-table entry has some bits we have to treat in a special way.
> - * Bits 52 and bit 55 have to be zero, otherwise a specification
> - * exception will occur instead of a page translation exception. The
> - * specification exception has the bad habit not to store necessary
> - * information in the lowcore.
>   * Bits 54 and 63 are used to indicate the page type.
>   * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
> - * This leaves the bits 0-51 and bits 56-62 to store type and offset.
> - * We use the 5 bits from 57-61 for the type and the 52 bits from 0-51
> - * for the offset.
> - * |                     offset                        |01100|type |00|
> + * |                     offset                        |XX1XX|type |S0|
>   * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
>   * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
> + *
> + * Bits 0-51 store the offset.
> + * Bits 57-62 store the type.

^ 57-61, I should stop working for today :)


-- 
Thanks,

David / dhildenb

