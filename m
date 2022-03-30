Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27B04EBB56
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiC3HBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243595AbiC3HAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 514CDDFD76
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648623518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BF9Fr3Hf2Q3seTfZG5uyvCg9ZVloRlsxZukD5j+fS4A=;
        b=LILja68p93ujgunKcSzMgpDX3ug346qSFD0y+glc5bTbCCYMTwUZxkPKwSQ21xBsZDcg/0
        UVJ6edyNVKNbFwOqdDGWq2faDq4mEnY/Lv259GNDI/5bgN9JNPfOM0DtyZUM068QEyx3fn
        Cyz34CPWzWlJKK/4SOSWh6AKkI7+Zk0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-9c5b1pQgMZ-hRewjdbbqHQ-1; Wed, 30 Mar 2022 02:58:37 -0400
X-MC-Unique: 9c5b1pQgMZ-hRewjdbbqHQ-1
Received: by mail-wm1-f72.google.com with SMTP id n19-20020a7bcbd3000000b0038c94b86258so2214788wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BF9Fr3Hf2Q3seTfZG5uyvCg9ZVloRlsxZukD5j+fS4A=;
        b=W/0MLhCv90lF/lRdtQI2PkbAzsRYpfa3+gFAxzt5RHfI+wUxH5BWz7CJeIiENJpMy5
         6eIvOzXTq0b1jY/Ye376Oo2kGgoDIjvL+7Q+jJRxZND5JaP3zYSGAyKg9l1nKP5a/lTB
         KA2fMcwrHosTvRLQdkQ633swfuulzExRMfC5JIoWVSD/4Mm+HlwBhDyngtNRje83H0KE
         IFo+iwuftn+IqPtY8RwrAIz1JG7W1Ir4yswz6VP5tlQk0xI6tpVJz5OSBUADe/nG4A0e
         ycMrmLVVdvNzNhxYQ/qPNEktxHUhRbUY1O8zGMMJ0MpIBVSMTn2uG1ubOo5KKd1cxLFC
         EWRQ==
X-Gm-Message-State: AOAM533x9iBMxMmgxfoVCjCXILo9MYiJR2HHiF93CiY2LE1S0qg1dpSP
        ctDQ+JJ8vwQZCm0GP9ifGjunzFELE/WPIwZ3dtkihNsE+kMMQsufHv4JRyHvzABql3eTBb6K3SN
        D8vSfWPgGz25TcBwMAn1iJbEU
X-Received: by 2002:adf:f943:0:b0:203:e832:129 with SMTP id q3-20020adff943000000b00203e8320129mr34761262wrr.626.1648623515916;
        Tue, 29 Mar 2022 23:58:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtto01FveovjFViTUCxDqiAQ+5FDv0R1GlHAedwP32FH88iQTdtwzmDfuXuu4j6BvJ3hJeZg==
X-Received: by 2002:adf:f943:0:b0:203:e832:129 with SMTP id q3-20020adff943000000b00203e8320129mr34761230wrr.626.1648623515578;
        Tue, 29 Mar 2022 23:58:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2200:178b:7244:2a1f:b5d8? (p200300cbc7052200178b72442a1fb5d8.dip0.t-ipconnect.de. [2003:cb:c705:2200:178b:7244:2a1f:b5d8])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm6003935wma.5.2022.03.29.23.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 23:58:35 -0700 (PDT)
Message-ID: <3272510e-ff5c-8694-c45c-7be9eaed4b42@redhat.com>
Date:   Wed, 30 Mar 2022 08:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 7/8] powerpc/pgtable: remove _PAGE_BIT_SWAP_TYPE for
 book3s
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>, Jan Kara <jack@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Donald Dutile <ddutile@redhat.com>,
        Liang Zhang <zhangliang5@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Oleg Nesterov <oleg@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-8-david@redhat.com>
 <22d3c42d-402f-8aeb-e989-c05d023b2ed3@csgroup.eu>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <22d3c42d-402f-8aeb-e989-c05d023b2ed3@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.22 08:07, Christophe Leroy wrote:
> 
> 
> Le 29/03/2022 à 18:43, David Hildenbrand a écrit :
>> The swap type is simply stored in bits 0x1f of the swap pte. Let's
>> simplify by just getting rid of _PAGE_BIT_SWAP_TYPE. It's not like that
>> we can simply change it: _PAGE_SWP_SOFT_DIRTY would suddenly fall into
>> _RPAGE_RSV1, which isn't possible and would make the
>> BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY) angry.
>>
>> While at it, make it clearer which bit we're actually using for
>> _PAGE_SWP_SOFT_DIRTY by just using the proper define and introduce and
>> use SWP_TYPE_MASK.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/powerpc/include/asm/book3s/64/pgtable.h | 12 +++++-------
> 
> Why only BOOK3S ? Why not BOOK3E as well ?

Hi Cristophe,

I'm focusing on the most relevant enterprise architectures for now. I
don't have the capacity to convert each and every architecture at this
point (especially, I don't to waste my time in case this doesn't get
merged, and book3e didn't look straight forward to me).

Once this series hits upstream, I can look into other architectures --
and I'll be happy if other people jump in that have more familiarity
with the architecture-specific swp pte layouts.

Thanks

-- 
Thanks,

David / dhildenb

