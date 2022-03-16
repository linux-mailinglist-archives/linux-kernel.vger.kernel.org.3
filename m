Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F604DAEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355237AbiCPLHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiCPLHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3285563BCF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647428781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5Ihu+GGtRm4fEJ6HynP8/a20rznPlsj581F0MFa4uw=;
        b=diWqw5fb/fF2+TsfHZw+0FfMc2tajaX2WlQIwXBkRXfLrToONiO+ZgRb9HKYClb+QKZpdH
        0LyacK0bt8kaqZnduNh9w9tkcx598zoCvHxGBxRlJ/+lcBNBNnYw5RzDfhha5j5j3B0/0p
        jv/vkLQbFtlsuNH+sePy9C2YqEOipFM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-EIFHz6EgOm6-PVV91llwlQ-1; Wed, 16 Mar 2022 07:06:20 -0400
X-MC-Unique: EIFHz6EgOm6-PVV91llwlQ-1
Received: by mail-wr1-f71.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so430322wrg.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=t5Ihu+GGtRm4fEJ6HynP8/a20rznPlsj581F0MFa4uw=;
        b=EbyvcluiWrPl2WGkeCMyxUqn6F3Mi6Zj5bWk8r7VvttnLCVNl5JJ/cOgFDWF79S7VV
         sBDvLKbloIGspqafA/ccGh1pRCWpUQPdtiM2DxkjJYecpqALXaEH7nw+uDPqnfNu1Cfm
         6NyPflkmwe04HGnO4/G8nPRz4QSqDXeWqqNWGzLgiQsxDa5Vsmp5MQVf79jWNKUJHKZ1
         ak7THojw2JDSCZjqI6d7u87h91wfT1TZnnbb5+kMUQAWMfe5YSpNbbLSWcNsUpTmGLC1
         0mpCgWExmbt8W1+dVvqahCC+UaxdYlerUAivAOuICDxnNbJ+KCxJMDPJJJe91f2BlTGv
         zKJA==
X-Gm-Message-State: AOAM533sXQKRGt/Fzsex5sH3A6pxkg8wpfLDpAn3tDCLK2gOUaxGo4FE
        6+8QHIQ5Vlh4EhpxIzW+2I2z+VkQAwSGJKEdOk7XiSC0LSspU2tZ32EmTDzjN7hUgOv1z2G7f4x
        s5c83kAOgsGDJS+dAMu2VldBM
X-Received: by 2002:a7b:ce84:0:b0:37c:52fe:a3ff with SMTP id q4-20020a7bce84000000b0037c52fea3ffmr6764674wmj.48.1647428779230;
        Wed, 16 Mar 2022 04:06:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Ty4wzGiM/UVhsobpjw4e4kn1lIS6tzrXaFm1t0sxrcd89jEgVRT6AP4ZmUkUF+bo9AfjLw==
X-Received: by 2002:a7b:ce84:0:b0:37c:52fe:a3ff with SMTP id q4-20020a7bce84000000b0037c52fea3ffmr6764640wmj.48.1647428778874;
        Wed, 16 Mar 2022 04:06:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:f900:aa79:cd25:e0:32d1? (p200300cbc706f900aa79cd2500e032d1.dip0.t-ipconnect.de. [2003:cb:c706:f900:aa79:cd25:e0:32d1])
        by smtp.gmail.com with ESMTPSA id k9-20020adfd849000000b00203d18bf389sm1341573wrl.17.2022.03.16.04.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 04:06:18 -0700 (PDT)
Message-ID: <655640d5-3886-c4fb-6531-3148fd90e3d5@redhat.com>
Date:   Wed, 16 Mar 2022 12:06:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 5/7] s390/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
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
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-6-david@redhat.com> <20220315172102.771bd2cf@thinkpad>
 <c8229082-e8f1-e605-25c2-0ec9d23efd9e@redhat.com>
 <8b13b6c0-78d4-48e3-06f0-ec0680d013a9@redhat.com>
 <55b6b582-51ca-b869-2055-674fe4c563e6@redhat.com>
 <20220316115654.12823b78@thinkpad>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220316115654.12823b78@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.22 11:56, Gerald Schaefer wrote:
> On Tue, 15 Mar 2022 18:12:16 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 15.03.22 17:58, David Hildenbrand wrote:
>>>
>>>>> This would mean that it is not OK to have bit 52 not zero for swap PTEs.
>>>>> But if I read the POP correctly, all bits except for the DAT-protection
>>>>> would be ignored for invalid PTEs, so maybe this comment needs some update
>>>>> (for both bits 52 and also 55).
>>>>>
>>>>> Heiko might also have some more insight.
>>>>
>>>> Indeed, I wonder why we should get a specification exception when the
>>>> PTE is invalid. I'll dig a bit into the PoP.
>>>
>>> SA22-7832-12 6-46 ("Translation-Specification Exception") is clearer
>>>
>>> "The page-table entry used for the translation is
>>> valid, and bit position 52 does not contain zero."
>>>
>>> "The page-table entry used for the translation is
>>> valid, EDAT-1 does not apply, the instruction-exe-
>>> cution-protection facility is not installed, and bit
>>> position 55 does not contain zero. It is model
>>> dependent whether this condition is recognized."
>>>
>>
>> I wonder if the following matches reality:
>>
>> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
>> index 008a6c856fa4..6a227a8c3712 100644
>> --- a/arch/s390/include/asm/pgtable.h
>> +++ b/arch/s390/include/asm/pgtable.h
>> @@ -1669,18 +1669,16 @@ static inline int has_transparent_hugepage(void)
>>  /*
>>   * 64 bit swap entry format:
>>   * A page-table entry has some bits we have to treat in a special way.
>> - * Bits 52 and bit 55 have to be zero, otherwise a specification
>> - * exception will occur instead of a page translation exception. The
>> - * specification exception has the bad habit not to store necessary
>> - * information in the lowcore.
>>   * Bits 54 and 63 are used to indicate the page type.
>>   * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
>> - * This leaves the bits 0-51 and bits 56-62 to store type and offset.
>> - * We use the 5 bits from 57-61 for the type and the 52 bits from 0-51
>> - * for the offset.
>> - * |                     offset                        |01100|type |00|
>> + * |                     offset                        |XX1XX|type |S0|
>>   * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
>>   * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
>> + *
>> + * Bits 0-51 store the offset.
>> + * Bits 57-62 store the type.
>> + * Bit 62 (S) is used for softdirty tracking.
>> + * Bits 52, 53, 55 and 56 (X) are unused.
>>   */
>>  
>>  #define __SWP_OFFSET_MASK      ((1UL << 52) - 1)
>>
>>
>> I'm not sure why bit 53 was indicated as "1" and bit 55 was indicated as
>> "0". At least for 52 and 55 there was a clear description.
> 
> Bit 53 is the invalid bit, and that is always 1 for swap ptes, in addition

Ah, right, I missed the meaning of bot 53 because this documentation is just
sub-optimal.

> to protection bit 54. Bit 55, along with bit 52, has to be zero according
> to the (potentially deprecated) comment.

Yeah, that 52/55 comment is just wrong when dealing with invalid PTEs.

> 
> It is interesting that bit 56 seems to be unused, at least according
> to the comment, but that would also mention bit 62 as unused, so that
> clearly needs some update.

I currently have the following cleanup patch:

From a4a8db2920e035e90a410b9170829326bb1fab92 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 15 Mar 2022 18:14:09 +0100
Subject: [PATCH] s390/pgtable: cleanup description of swp pte layout

Bit 52 and bit 55 don't have to be zero: they only trigger a
translation-specifiation exception if the PTE is marked as valid, which
is not the case for swap ptes.

Document which bits are used for what, and which ones are unused.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 008a6c856fa4..64fbe5fd3853 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1669,18 +1669,17 @@ static inline int has_transparent_hugepage(void)
 /*
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
- * Bits 52 and bit 55 have to be zero, otherwise a specification
- * exception will occur instead of a page translation exception. The
- * specification exception has the bad habit not to store necessary
- * information in the lowcore.
- * Bits 54 and 63 are used to indicate the page type.
+ * Bits 54 and 63 are used to indicate the page type. Bit 53 marks the pte
+ * as invalid.
  * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
- * This leaves the bits 0-51 and bits 56-62 to store type and offset.
- * We use the 5 bits from 57-61 for the type and the 52 bits from 0-51
- * for the offset.
- * |			  offset			|01100|type |00|
+ * |			  offset			|X11XX|type |S0|
  * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
  * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
+ *
+ * Bits 0-51 store the offset.
+ * Bits 57-61 store the type.
+ * Bit 62 (S) is used for softdirty tracking.
+ * Bits 52, 55 and 56 (X) are unused.
  */
 
 #define __SWP_OFFSET_MASK	((1UL << 52) - 1)
-- 
2.35.1


> 
> If bit 56 could be used for _PAGE_SWP_EXCLUSIVE, that would be better
> than stealing a bit from the offset, or using potentially dangerous
> bit 52. It is defined as _PAGE_UNUSED and only used for kvm, not sure
> if this is also relevant for swap ptes, similar to bit 62.

I don't think it is, and I also don't think there is anything wrong
with reusing bit 52.

> 
> Adding Christian on cc, maybe he has some insight on _PAGE_UNUSED
> bit 56 and swap ptes.


-- 
Thanks,

David / dhildenb

