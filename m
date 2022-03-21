Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83F4E2B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349815AbiCUPJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiCUPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56D528FE53
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647875274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFVfxmzhaFPMubA718aiLUSwyIk5+iMjz6qfYM1xb4A=;
        b=DVHm0uKT7xW0U1TaTtwIelzGlG8+HOjJTYj57VSeAVa9JDpeDHtZKxZJknxcu2ll5vKOOH
        RsmxiSdjGUtilg+QiU+7KYpE0P6gLkYjp9zKP0+L3Uj+JliK08fcTV9sCXyvyxWQXTYXqV
        4W2al2u3raZ6uUaux/D7egF7SpnNPUs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-dVEWOziVO4uExGGdPYtiaQ-1; Mon, 21 Mar 2022 11:07:52 -0400
X-MC-Unique: dVEWOziVO4uExGGdPYtiaQ-1
Received: by mail-wm1-f72.google.com with SMTP id t124-20020a1c4682000000b0038c8e8f8212so2704418wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZFVfxmzhaFPMubA718aiLUSwyIk5+iMjz6qfYM1xb4A=;
        b=OidJ+YbJN+W34VEHML4Er5sqDuH2DgM1C0FmECezM7/0gkKs7ifwAJ2B/S2KAbx+UJ
         oaVwo6ylkNfAIJCOBOq2bZCMl+ZQkCbqgSE33bfInYYoJUidQ9twHunE6G/JBCp/tTU6
         85uQJl+9WyukR12KO/7kmqdBSoQIpPnkzDHVbA8hE9lvhTKygTwfAAeAKwTlPxwbFqsH
         upT2y0zxfpE5YCQgqnd9BSe0o33ptaN/HnhQaTa2zVACTeXXDKnkzyp8hgJgHra+ehRM
         DG7FC9hfmLD9iMJ5UiT0ik5Lz3MGmfX/rqMLG12XyzXgwm8ZJ63LnbXJQvHYQXB8vLNw
         b6vg==
X-Gm-Message-State: AOAM530c81/BCXhlnkBRAYZ05efMhbeMVgDXMN2Wby4XtaYjCHpcFnBp
        7C8HkMKPTTgsckBthBHUtSlDWadMR6e9ApahVjKuV8b5g4+sqPTFl/TtHA5ePkUaX+A1fD8E4IX
        TK6h10+foTW5zqECmL0+mjwxc
X-Received: by 2002:a05:600c:4ed2:b0:38c:93ad:4825 with SMTP id g18-20020a05600c4ed200b0038c93ad4825mr11133373wmq.181.1647875271717;
        Mon, 21 Mar 2022 08:07:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKoU0nGg0p5jibfOm4Ew1arWHbW+SRBIfaAS1QHWKwXAqgZDqMtY1m9j1jU9wOkm317ZDDsQ==
X-Received: by 2002:a05:600c:4ed2:b0:38c:93ad:4825 with SMTP id g18-20020a05600c4ed200b0038c93ad4825mr11133335wmq.181.1647875271332;
        Mon, 21 Mar 2022 08:07:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d46ca000000b00203fd86e198sm7209759wrs.96.2022.03.21.08.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:07:50 -0700 (PDT)
Message-ID: <ea570f92-f896-7f9b-91c4-ad0a025bb340@redhat.com>
Date:   Mon, 21 Mar 2022 16:07:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 4/7] arm64/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
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
 <20220315141837.137118-5-david@redhat.com> <YjIr9f9qaz4xITVd@arm.com>
 <20220321143802.GC11145@willie-the-truck>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220321143802.GC11145@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.22 15:38, Will Deacon wrote:
> On Wed, Mar 16, 2022 at 06:27:01PM +0000, Catalin Marinas wrote:
>> On Tue, Mar 15, 2022 at 03:18:34PM +0100, David Hildenbrand wrote:
>>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>>> index b1e1b74d993c..62e0ebeed720 100644
>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>> @@ -14,6 +14,7 @@
>>>   * Software defined PTE bits definition.
>>>   */
>>>  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
>>> +#define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */
>>
>> I think we can use bit 1 here.
>>
>>> @@ -909,12 +925,13 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>>  /*
>>>   * Encode and decode a swap entry:
>>>   *	bits 0-1:	present (must be zero)
>>> - *	bits 2-7:	swap type
>>> + *	bits 2:		remember PG_anon_exclusive
>>> + *	bits 3-7:	swap type
>>>   *	bits 8-57:	swap offset
>>>   *	bit  58:	PTE_PROT_NONE (must be zero)
>>
>> I don't remember exactly why we reserved bits 0 and 1 when, from the
>> hardware perspective, it's sufficient for bit 0 to be 0 and the whole
>> pte becomes invalid. We use bit 1 as the 'table' bit (when 0 at pmd
>> level, it's a huge page) but we shouldn't check for this on a swap
>> entry.
> 
> I'm a little worried that when we're dealing with huge mappings at the
> PMD level we might lose the ability to distinguish them from a pte-level
> mapping with this new flag set if we use bit 1. A similar issue to this
> was fixed a long time ago by 59911ca4325d ("ARM64: mm: Move PTE_PROT_NONE
> bit") when we used to use bit 1 for PTE_PROT_NONE.
> 
> Is something like:
> 
> 	pmd_to_swp_entry(swp_entry_to_pmd(pmd));

Note that __HAVE_ARCH_PTE_SWP_EXCLUSIVE currently only applies to actual
swap entries, not non-swap entries (migration, hwpoison, ...). So it
really only applies to PTEs -- PMDs are not applicable.

So the example you gave cannot possibly have that bit set. From what I
understand, it should be fine. But I have no real preference: I can also
just stick to the original patch, whatever you prefer.

Thanks!

-- 
Thanks,

David / dhildenb

