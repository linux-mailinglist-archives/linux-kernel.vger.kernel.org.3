Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AAC4DA038
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350128AbiCOQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349504AbiCOQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E276167DA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647362280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2ipbFlk5lqInrlinVKs+tHw6wDzJglC4+x65Q557sM=;
        b=fWTJ8pVYg7MbXxgYX/PkIUlGnQRshWUg8ILsBdrRRx5oU33rxx6qsQv1eJ2WXMZrJYZYes
        ycy7CZrWTxFwM75jqtoCTVmwPV65Gz05mi62+tZIOnLtsf8e2zlg7V+4sjhenth4nTSSEJ
        4fnwHFi6HcmLCDtSwDPYlqBAWmz1x5w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-enBCbftDO7KhNBnbx9sM4g-1; Tue, 15 Mar 2022 12:37:59 -0400
X-MC-Unique: enBCbftDO7KhNBnbx9sM4g-1
Received: by mail-wm1-f72.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so1440536wma.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=k2ipbFlk5lqInrlinVKs+tHw6wDzJglC4+x65Q557sM=;
        b=AB2K7yED4kPSGgJjfs/LHgRC2TQpINa6Nk70bmGOfETUye5r9xLMNmsPTDmG1zXJTW
         jzYiJY2UdGSWRayYX+l8/ozR/sYkYCnTB/dzt1EIFpoL+lnsQFXM4XchqkVZS606w3EJ
         hxP+aobmfjOOCP9qAT/qODQyd7W6bCguc0ygLmnvJBrWpzOgGEQMiH58snPi5PJDJbJK
         3js+tJJCwcTL7TR3/+yhfWDoNsav+H6daI4EIaR55C49wcPmEdtoMFpDWz3XEif1UBqM
         yXYC1SYekhJIVN2U7BVm98DrqjjuLQ5c+l2oPjdKvlmXYAoYeEp2f5sz+DBKKyX6905W
         UOfw==
X-Gm-Message-State: AOAM533dq2SSx6pzeappH6M1S9TrngDsipbLoeG9x1QGhi6MnakykHmm
        zI2Gq5vxM1GnicBZC6O66Q3fYV9Z8JcMUKqMazM8tfvE3Mpu89YlGv42gWgLO3PKUcN5usRX8Jz
        PTqQqkl7AtuS/7pedpXmxRRgh
X-Received: by 2002:adf:d1e5:0:b0:203:d609:38da with SMTP id g5-20020adfd1e5000000b00203d60938damr2900204wrd.675.1647362277282;
        Tue, 15 Mar 2022 09:37:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqktz7igkc2jhfj9HwK0wpaZBKo1SRBQEWLN2nVdKLP+WSku1/PyNMTjD1G0jtbc54uPZgJw==
X-Received: by 2002:adf:d1e5:0:b0:203:d609:38da with SMTP id g5-20020adfd1e5000000b00203d60938damr2900167wrd.675.1647362276942;
        Tue, 15 Mar 2022 09:37:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1800:42bd:3cac:d22a:3c62? (p200300cbc708180042bd3cacd22a3c62.dip0.t-ipconnect.de. [2003:cb:c708:1800:42bd:3cac:d22a:3c62])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdb84000000b001e8d8ac5394sm17229217wri.110.2022.03.15.09.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 09:37:56 -0700 (PDT)
Message-ID: <c8229082-e8f1-e605-25c2-0ec9d23efd9e@redhat.com>
Date:   Tue, 15 Mar 2022 17:37:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 5/7] s390/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
In-Reply-To: <20220315172102.771bd2cf@thinkpad>
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

On 15.03.22 17:21, Gerald Schaefer wrote:
> On Tue, 15 Mar 2022 15:18:35 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's steal one bit from the offset. While at it, document the meaning
>> of bit 62 for swap ptes.
> 
> You define _PAGE_SWP_EXCLUSIVE as _PAGE_LARGE, which is bit 52, and
> this is not part of the swap pte offset IIUC. So stealing any bit might
> actually not be necessary, see below.

Indeed, thanks for catching that. I actually intended to use bit 51 ...

> 
> Also, bit 62 should be the soft dirty bit for normal PTEs, and this
> doesn't seem to be used for swap PTEs at all. But I might be missing
> some use case where softdirty also needs to be preserved in swap PTEs.
> 

It is, see below.

>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/include/asm/pgtable.h | 37 ++++++++++++++++++++++++++-------
>>  1 file changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 008a6c856fa4..c182212a2b44 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -181,6 +181,8 @@ static inline int is_module_addr(void *addr)
>>  #define _PAGE_SOFT_DIRTY 0x000
>>  #endif
>>  
>> +#define _PAGE_SWP_EXCLUSIVE _PAGE_LARGE	/* SW pte exclusive swap bit */
>> +
>>  /* Set of bits not changed in pte_modify */
>>  #define _PAGE_CHG_MASK		(PAGE_MASK | _PAGE_SPECIAL | _PAGE_DIRTY | \
>>  				 _PAGE_YOUNG | _PAGE_SOFT_DIRTY)
>> @@ -796,6 +798,24 @@ static inline int pmd_protnone(pmd_t pmd)
>>  }
>>  #endif
>>  
>> +#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>> +static inline pte_t pte_swp_mkexclusive(pte_t pte)
>> +{
>> +	pte_val(pte) |= _PAGE_SWP_EXCLUSIVE;
>> +	return pte;
>> +}
>> +
>> +static inline int pte_swp_exclusive(pte_t pte)
>> +{
>> +	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
>> +}
>> +
>> +static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>> +{
>> +	pte_val(pte) &= ~_PAGE_SWP_EXCLUSIVE;
>> +	return pte;
>> +}
>> +
>>  static inline int pte_soft_dirty(pte_t pte)
>>  {
>>  	return pte_val(pte) & _PAGE_SOFT_DIRTY;
>> @@ -1675,16 +1695,19 @@ static inline int has_transparent_hugepage(void)
>>   * information in the lowcore.
>>   * Bits 54 and 63 are used to indicate the page type.
>>   * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
>> - * This leaves the bits 0-51 and bits 56-62 to store type and offset.
>> - * We use the 5 bits from 57-61 for the type and the 52 bits from 0-51
>> + * This leaves the bits 0-50 and bits 56-61 to store type and offset.
>> + * We use the 5 bits from 57-61 for the type and the 51 bits from 0-50
>>   * for the offset.
>> - * |			  offset			|01100|type |00|
>> - * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
>> - * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
>> + * |			  offset		       |E|01100|type |S0|
>> + * |000000000011111111112222222222333333333344444444445|5|55555|55566|66|
>> + * |012345678901234567890123456789012345678901234567890|1|23456|78901|23|
>> + *
>> + * S (bit 62) is used for softdirty tracking.
> 
> Unless there is some use for softdirty tracking in swap PTEs, I think
> this description does not belong here, to the swap PTE layout.

See pte_swp_soft_dirty and friends. E.g., do_swap_page() has to restore
it for the ordinary PTE from the swp pte.

if (pte_swp_soft_dirty(vmf->orig_pte))
	pte = pte_mksoft_dirty(pte);

> 
>> + * E (bit 51) is used to remember PG_anon_exclusive.
> 
> It is bit 52, at least with this patch, so I guess this could all be
> done w/o stealing anything. That is, of course, only if it is allowed
> to use bit 52 in this case. The POP says bit 52 has to be 0, or else
> a "translation-specification exception" is recognized. However, I think
> it could be OK for PTEs marked as invalid, like it is the case for swap
> PTEs.

My tests with this patch worked, BUT it was under z/VM on a fairly old z
machine. At least 2MiB huge pages are supported there. I did not run
into specification exception in that setup, but that doesn't mean that
that's the case under LPAR/KVM/newer systems.

> 
> The comment here says at the beginning:
> /*
>  * 64 bit swap entry format:
>  * A page-table entry has some bits we have to treat in a special way.
>  * Bits 52 and bit 55 have to be zero, otherwise a specification
>  * exception will occur instead of a page translation exception. The
>  * specification exception has the bad habit not to store necessary
>  * information in the lowcore.
> 
> This would mean that it is not OK to have bit 52 not zero for swap PTEs.
> But if I read the POP correctly, all bits except for the DAT-protection
> would be ignored for invalid PTEs, so maybe this comment needs some update
> (for both bits 52 and also 55).
> 
> Heiko might also have some more insight.

Indeed, I wonder why we should get a specification exception when the
PTE is invalid. I'll dig a bit into the PoP.

> 
> Anyway, stealing bit 51 might still be an option, but then
> _PAGE_SWP_EXCLUSIVE would need to be defined appropriately.
> 

Indeed.

Thanks for the very-fast review!

-- 
Thanks,

David / dhildenb

