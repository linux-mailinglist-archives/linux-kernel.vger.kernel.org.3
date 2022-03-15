Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045B64DA0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350364AbiCORAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350321AbiCORAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:00:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9691D57B25
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647363527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGUrQuXOtgHlUwtoNupql+5VRYbS7vNf+UN5ulYsPQo=;
        b=Sy7CfHn0xlufviv5ErFCTH9mbdgH4mYkAsE1udi4s0Ftmc34xkVX7vUILT1hos0qBiKUUH
        GShyX/PkgR+JCVeFSCWPTRBDVd/LfQIgfJ9DHn21QuK8NklO9Jd24viaioR2jugEO9AhhM
        OCizdOhw8eVOhYoSYJp7k3yrwMCeH+Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-3xd_qDZgM0W526WNADTtaA-1; Tue, 15 Mar 2022 12:58:46 -0400
X-MC-Unique: 3xd_qDZgM0W526WNADTtaA-1
Received: by mail-wr1-f72.google.com with SMTP id 8-20020adf8108000000b00203d97ba415so530010wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=LGUrQuXOtgHlUwtoNupql+5VRYbS7vNf+UN5ulYsPQo=;
        b=Jlu3bb8awm5vxEzcvMr33FK6tkR8NKjvTnRP+BR8iZCTD5Dfcy6oBJA65VABpxz+Jz
         YI/kjkAfoaJ5pcBNQcANCHUyykWOTuU3MdXkIxzEhRM7MeLLWw5dCgGpgTRhaszr2cTW
         IAVDXaignDAERyQPoU5UpRvQOyAQGgu3w7lbol+w2mL8lVFECXMv11LqzfmSgjfxFOwP
         yWaA19rsyWwpQmP4S9tn8f94Ei3mQE5RIYB+9khXmNN2gObJj2pG99+5q3nW8vKOvoVP
         dKXt1UUKBwTG7Pnc/joPAm4HhxvXtjeXAyceoWj5A7Ob6q9jiOhXzRqWYC0JmaiPh+6Z
         Trhw==
X-Gm-Message-State: AOAM532VYNp9pN7IS7YkIazORLrZIdC8gMrafJxKdwzQpHe/abrBc8VW
        CPCEW6x7fq/AMAUhoSBlcSdTcsWNWS2M39mbp++eIpJyodHbi3P5MsIA+XD54PAXX9alaSmJ7fz
        JQ1LAPAdULEkOHSzhMQhdZbus
X-Received: by 2002:a7b:c5d6:0:b0:381:4127:84d3 with SMTP id n22-20020a7bc5d6000000b00381412784d3mr4077957wmk.24.1647363525117;
        Tue, 15 Mar 2022 09:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlZot5PU2X0oLNLaK3DaCcFcYOa0tVNe87pG0OWN67pZZ94UjPsh6UkkIWtNctJtwqc7+3yg==
X-Received: by 2002:a7b:c5d6:0:b0:381:4127:84d3 with SMTP id n22-20020a7bc5d6000000b00381412784d3mr4077947wmk.24.1647363524808;
        Tue, 15 Mar 2022 09:58:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1800:42bd:3cac:d22a:3c62? (p200300cbc708180042bd3cacd22a3c62.dip0.t-ipconnect.de. [2003:cb:c708:1800:42bd:3cac:d22a:3c62])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b001e4bbbe5b92sm17551203wrj.76.2022.03.15.09.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 09:58:44 -0700 (PDT)
Message-ID: <8b13b6c0-78d4-48e3-06f0-ec0680d013a9@redhat.com>
Date:   Tue, 15 Mar 2022 17:58:42 +0100
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
Organization: Red Hat
In-Reply-To: <c8229082-e8f1-e605-25c2-0ec9d23efd9e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> This would mean that it is not OK to have bit 52 not zero for swap PTEs.
>> But if I read the POP correctly, all bits except for the DAT-protection
>> would be ignored for invalid PTEs, so maybe this comment needs some update
>> (for both bits 52 and also 55).
>>
>> Heiko might also have some more insight.
> 
> Indeed, I wonder why we should get a specification exception when the
> PTE is invalid. I'll dig a bit into the PoP.

SA22-7832-12 6-46 ("Translation-Specification Exception") is clearer

"The page-table entry used for the translation is
valid, and bit position 52 does not contain zero."

"The page-table entry used for the translation is
valid, EDAT-1 does not apply, the instruction-exe-
cution-protection facility is not installed, and bit
position 55 does not contain zero. It is model
dependent whether this condition is recognized."

-- 
Thanks,

David / dhildenb

