Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356AC4DD78E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiCRKAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiCRKAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1775554BC2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647597555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WwojpOjEOr4mcSzqZ4SMu6wiIk7XFK36I3d0bzyiUkI=;
        b=IvQlUpiBRkmXt8T8S3LzlSaQdEbJyRv2A53JJaxzDsf2hBTL9eySzm7mfYuUkMpy7v2Agw
        iq78Dg/tewE/cYo6VHJbsYm6uxDv30FbOXuJNjFc9MzsaoRK/UZdc+M8fz0TIaHTd0ueh3
        SpIsfUsurrxe1xajRu4u3Q519OgVLUM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-jt4m09yVNuKpaR7EndqEnQ-1; Fri, 18 Mar 2022 05:59:14 -0400
X-MC-Unique: jt4m09yVNuKpaR7EndqEnQ-1
Received: by mail-wm1-f71.google.com with SMTP id c19-20020a05600c0ad300b00385bb3db625so5566422wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WwojpOjEOr4mcSzqZ4SMu6wiIk7XFK36I3d0bzyiUkI=;
        b=rJd5NNuVinbv5BX/OPu7J/tryWSn+p+Bv/cvb519Gl9MJwLHBrYCBwjoRQsaLnm3d1
         6r9GYJ1jLUqUAWAkonUaO5+IdB8cR9WMd3DQD1b+9RGpZeFSGQwrK4objd7Ufsfg938u
         cs11immX+59kxr2TuXNRyT7y64N91EGtKTAc1LI3zJfkc8gH60WrzD9ebHJjd5i6hSB6
         rb5h8ns/SXVCL36mci42tg8Tgnkj4HRZ9aMZNhavQkaKQyTf3E/Jk/7bWHCe7hThysj6
         jPUsW9dGH1iTx5QE4+ghMvs45d5UyRThOQylmLvi3PlQ/1K73GPyXOSohOZdJc2cR9Hb
         rpEQ==
X-Gm-Message-State: AOAM5334ifxLsQ1LqYh6xC27CBCCdag+KZjvMv8oZo8TtaQiFCvsmZCX
        K7x1EJ+d3DVBaprev2q6y9Bcx4LBLb/ikTlAyU6zFDACyfScLNulIwENSIlAcQ0iO5jy7qWKoh5
        xHiZRIqHv18+heIYLEe5Ka7WS
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id k10-20020a5d66ca000000b00203fb72a223mr245300wrw.12.1647597552869;
        Fri, 18 Mar 2022 02:59:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiCIQSTvlMRLKh05ZCde60bXcYKmdiZDixZ35I2lQ1acs/d/cg5mxdfxUGemiF/KqVi8TxQQ==
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id k10-20020a5d66ca000000b00203fb72a223mr245257wrw.12.1647597552568;
        Fri, 18 Mar 2022 02:59:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id i35-20020adf90a6000000b00203e767a1d2sm4123361wri.103.2022.03.18.02.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:59:12 -0700 (PDT)
Message-ID: <8989a07b-3a5b-0c81-983f-b35403d19579@redhat.com>
Date:   Fri, 18 Mar 2022 10:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 4/7] arm64/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
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
 <20220315141837.137118-5-david@redhat.com> <YjIr9f9qaz4xITVd@arm.com>
 <c3d39666-52ae-42ba-eaa2-7a0ca489f766@redhat.com> <YjN2qsXkmlEUTg4u@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YjN2qsXkmlEUTg4u@arm.com>
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

On 17.03.22 18:58, Catalin Marinas wrote:
> On Thu, Mar 17, 2022 at 11:04:18AM +0100, David Hildenbrand wrote:
>> On 16.03.22 19:27, Catalin Marinas wrote:
>>> On Tue, Mar 15, 2022 at 03:18:34PM +0100, David Hildenbrand wrote:
>>>> @@ -909,12 +925,13 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>>>  /*
>>>>   * Encode and decode a swap entry:
>>>>   *	bits 0-1:	present (must be zero)
>>>> - *	bits 2-7:	swap type
>>>> + *	bits 2:		remember PG_anon_exclusive
>>>> + *	bits 3-7:	swap type
>>>>   *	bits 8-57:	swap offset
>>>>   *	bit  58:	PTE_PROT_NONE (must be zero)
>>>
>>> I don't remember exactly why we reserved bits 0 and 1 when, from the
>>> hardware perspective, it's sufficient for bit 0 to be 0 and the whole
>>> pte becomes invalid. We use bit 1 as the 'table' bit (when 0 at pmd
>>> level, it's a huge page) but we shouldn't check for this on a swap
>>> entry.
>>
>> You mean
>>
>> arch/arm64/include/asm/pgtable-hwdef.h:#define PTE_TABLE_BIT            (_AT(pteval_t, 1) << 1)
>>
>> right?
> 
> Yes.
> 
>> I wonder why it even exists, for arm64 I only spot:
>>
>> arch/arm64/include/asm/pgtable.h:#define pte_mkhuge(pte)                (__pte(pte_val(pte) & ~PTE_TABLE_BIT))
>>
>> I don't really see code that sets PTE_TABLE_BIT.
>>
>> Similarly, I don't see code that sets PMD_TABLE_BIT/PUD_TABLE_BIT/P4D_TABLE_BIT.
>> Most probably setting code is not using the defines,  that's why I'm not finding it.
> 
> It gets set as part of P*D_TYPE_TABLE via p*d_populate(). We use the
> P*D_TABLE_BIT mostly for checking whether it's a huge page or not (the
> arm64 hugetlbpage.c code).
> 

Makes sense, after digging into the arm arm, I agree that it should
be safe to reuse bit 1. I'll use this (yet untested) patch in v2:


From a48d08339574b7c42e0b032f0fc334872591744c Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Mar 2022 11:46:26 +0100
Subject: [PATCH] arm64/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE

Let's use bit 1, which should be irrelevant if the PTE is marked invalid
eiher way --  we really only care about bit 0.

Note that one alternative would be using one of the type bits: core-mm only
supports 5 bits, so there is no need to reserve space for 6.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  1 +
 arch/arm64/include/asm/pgtable.h      | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index b1e1b74d993c..fd6ddf14c190 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -14,6 +14,7 @@
  * Software defined PTE bits definition.
  */
 #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
+#define PTE_SWP_EXCLUSIVE	(PTE_TABLE_BIT)		 /* only for swp ptes */
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 94e147e5456c..c78994073cd0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -402,6 +402,22 @@ static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
 	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
 }
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
+}
+
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & PTE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
+}
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/linux/pgtable.h
@@ -908,7 +924,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 
 /*
  * Encode and decode a swap entry:
- *	bits 0-1:	present (must be zero)
+ *	bits 0:		present (must be zero)
+ *	bits 1:		remember PG_anon_exclusive
  *	bits 2-7:	swap type
  *	bits 8-57:	swap offset
  *	bit  58:	PTE_PROT_NONE (must be zero)
-- 
2.35.1


-- 
Thanks,

David / dhildenb

