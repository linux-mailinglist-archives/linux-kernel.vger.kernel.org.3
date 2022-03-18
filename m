Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED64DDB61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiCROPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiCROPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94E282467F7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647612870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vrk5fX2xWSdP9n1bkww7mSZRBCrjbbAY4wpRt0kMGOs=;
        b=EZixjensjCoS1i3P6C0cotlk/+x6xjvwmasAkqgB+Fns7ko9zd9etxqF1E1St75QWEbV7L
        mLKiTTBJ8BwRu6sSK9IQorGedlYTS4ZyJrCNpc6VvTQ8bRmPQNyGKohR1UFd62hE3F0Eo/
        XcMAcZ9MHB2ygqkj+PszN4/r97GikKk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-7HqdSal_MX2qTdWMeMCIcw-1; Fri, 18 Mar 2022 10:14:29 -0400
X-MC-Unique: 7HqdSal_MX2qTdWMeMCIcw-1
Received: by mail-wm1-f69.google.com with SMTP id n62-20020a1ca441000000b0038124c99ebcso3124998wme.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Vrk5fX2xWSdP9n1bkww7mSZRBCrjbbAY4wpRt0kMGOs=;
        b=E/xGxTdn2p5ixY4vYc4ZKwPFGSy70I4bk9RcDSqErTl9P1TX7gM4kBarqNq+jOqSbo
         andRA4xWcFWV04SRLAPYFteyNwZQreNOvbmgSERk82OP+Ca3BsnNeAq5/btja8R5Ntqp
         IR2JcZNPoWs5LZm22XlWd+CIVcBCv2rJvOo7SO+/Yt0O139AJ/R5CYV8PBhKe8+9EyVt
         JWUxLtLgTOfb63cq1zI+KiK3YjJp3oj9Ffh3wo7ZJK6P8xjN8uL/rUPdnKWgMO5l3e/m
         wjL8cTGJO+6vFkOohnuqpiJQowjo/DXTl2Z6STAfWsgTSwke5xDE7NltBRosjRaGVILY
         qgFQ==
X-Gm-Message-State: AOAM5339L3w3yhpUlFC3Hd75bbQKMFlY6VuP+Oo5DNvgLQK0moUk6cmY
        uZDinbyDd4S3Ynt46TUp1K3jy9VfhRT4Fnm/ST4ssfs4Vbpw9H9vpKPGvxqtY4q6sNOfIPdWodt
        qIdDY9hIK68on2T2e7vXGElhy
X-Received: by 2002:adf:f604:0:b0:203:d9ca:bccf with SMTP id t4-20020adff604000000b00203d9cabccfmr8306945wrp.331.1647612868268;
        Fri, 18 Mar 2022 07:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjLDR4x76jQT8vPKbt5WCkwgszEYzxfTTeJzEyGuYsFFC95N5UVyBJYkEnjUBvTDuYOItNow==
X-Received: by 2002:adf:f604:0:b0:203:d9ca:bccf with SMTP id t4-20020adff604000000b00203d9cabccfmr8306914wrp.331.1647612867962;
        Fri, 18 Mar 2022 07:14:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c228700b00389865c646dsm9066181wmf.14.2022.03.18.07.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:14:27 -0700 (PDT)
Message-ID: <c4fcedf1-22a9-c912-824d-644a21b2fcfd@redhat.com>
Date:   Fri, 18 Mar 2022 15:14:25 +0100
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
 <8989a07b-3a5b-0c81-983f-b35403d19579@redhat.com> <YjRt7DqDFJRZA7Gt@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YjRt7DqDFJRZA7Gt@arm.com>
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

On 18.03.22 12:33, Catalin Marinas wrote:
> On Fri, Mar 18, 2022 at 10:59:10AM +0100, David Hildenbrand wrote:
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index b1e1b74d993c..fd6ddf14c190 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -14,6 +14,7 @@
>>   * Software defined PTE bits definition.
>>   */
>>  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
>> +#define PTE_SWP_EXCLUSIVE	(PTE_TABLE_BIT)		 /* only for swp ptes */
>>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 94e147e5456c..c78994073cd0 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -402,6 +402,22 @@ static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
>>  	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
>>  }
>>  
>> +#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>> +static inline pte_t pte_swp_mkexclusive(pte_t pte)
>> +{
>> +	return set_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
>> +}
>> +
>> +static inline int pte_swp_exclusive(pte_t pte)
>> +{
>> +	return pte_val(pte) & PTE_SWP_EXCLUSIVE;
>> +}
>> +
>> +static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>> +{
>> +	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
>> +}
>> +
>>  #ifdef CONFIG_NUMA_BALANCING
>>  /*
>>   * See the comment in include/linux/pgtable.h
>> @@ -908,7 +924,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>  
>>  /*
>>   * Encode and decode a swap entry:
>> - *	bits 0-1:	present (must be zero)
>> + *	bits 0:		present (must be zero)
>> + *	bits 1:		remember PG_anon_exclusive
> 
> It looks fine to me.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Great, thanks!

-- 
Thanks,

David / dhildenb

