Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC24D2A42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiCIICG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiCIIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA955169212
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646812826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O+zcul7Y4mG3bPoT64KcHkOlEBwFPJd5IbrPAZk9VZ8=;
        b=FjfoTuwowJG+7fCePKOZAv3jo4tS6DfuGPs5Ta3vNBHfvgidPYi1HmGxuMtneTSmnarlCm
        CpxVw35dIy6Wa6IPzHuqW1AanDsJeeTSAfq+cq61wcXKq4InVbFgHJVWpIh/+yHTjFejx5
        aFFaRCowt269OZb2UJnc2Tdr4WRyFEc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-Ru5ntdR9Mgm8oaBli31NRg-1; Wed, 09 Mar 2022 03:00:25 -0500
X-MC-Unique: Ru5ntdR9Mgm8oaBli31NRg-1
Received: by mail-wm1-f72.google.com with SMTP id f24-20020a1c6a18000000b00388874b17a8so657719wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 00:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=O+zcul7Y4mG3bPoT64KcHkOlEBwFPJd5IbrPAZk9VZ8=;
        b=jyTwTAejUnyw0/Npg7Hgq7ZN3pBzh1Lk5/rj6Cr7M1g9Q420i4tMsteq9MSa29SSCU
         hECexgUwx4UYCTVmzHvbyFsAaQYwfs2/vZbhQf61ukYXHX3KhhVLnfY+mhYBToaVzxM1
         e/o/Mr+gZo8wAlk3nEdCKDIA8rW/Mxa7I4aJKee2Ot/SbY3UuaPaEdDCb1yoOZfv3S/V
         uMoRODtQPq4FYCsr1vncxNcWBqgvUrHK+IXbq55EhmDQs0zp3s2ZqFfFDp0DHQQOqHiI
         IKOhEgWeEDxjUWJXjPdMseqr9idkLJNDv7RicNCwGFkAqeK4g84WGzXTOQbidP5waqFa
         6HzQ==
X-Gm-Message-State: AOAM530sz1YofHCyBZfRbUmL65tAnwVDS7B3kKy6OyazWvqk+RkeZ1+8
        5+v1sjuJxRh6VVsw5CWoPEONRWuoM3n+RjTnKadyv+A2NTF7bDsQCTEsJkLju2tO5s+3kqL4eAR
        IWSSiLkEZb7wYK3CuiLsnk/GH
X-Received: by 2002:adf:d4c8:0:b0:1f0:22df:d67c with SMTP id w8-20020adfd4c8000000b001f022dfd67cmr14881704wrk.510.1646812823973;
        Wed, 09 Mar 2022 00:00:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFOehg1l5XZe3AiXYAKbHawb2OS36nEHSYzfhypBEi98srCSBnnaKrh3a1a+Sz1wf5A16JOg==
X-Received: by 2002:adf:d4c8:0:b0:1f0:22df:d67c with SMTP id w8-20020adfd4c8000000b001f022dfd67cmr14881675wrk.510.1646812823670;
        Wed, 09 Mar 2022 00:00:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6300:8418:c653:d01f:3bd2? (p200300cbc70763008418c653d01f3bd2.dip0.t-ipconnect.de. [2003:cb:c707:6300:8418:c653:d01f:3bd2])
        by smtp.gmail.com with ESMTPSA id z3-20020a1cf403000000b0037d1f4a2201sm964689wma.21.2022.03.09.00.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:00:23 -0800 (PST)
Message-ID: <d615d51d-8643-190e-9cc2-844a28a349cf@redhat.com>
Date:   Wed, 9 Mar 2022 09:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
References: <20220308141437.144919-1-david@redhat.com>
 <CAHk-=wiA0KMVbLacK-Gi5_ZsZhXVi++6ePTtPrJkgf0az7r2ww@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 00/15] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
In-Reply-To: <CAHk-=wiA0KMVbLacK-Gi5_ZsZhXVi++6ePTtPrJkgf0az7r2ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.22 22:22, Linus Torvalds wrote:
> On Tue, Mar 8, 2022 at 6:14 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
>> on an anonymous page and COW logic fails to detect exclusivity of the page
>> to then replacing the anonymous page by a copy in the page table [...]
> 
> From a cursory scan of the patches, this looks sane.

Thanks for skimming over the patches that quickly!

> 
> I'm not sure what the next step should be, but I really would like the
> people who do a lot of pinning stuff to give it a good shake-down.
> Including both looking at the patches, but very much actually running
> it on whatever test-cases etc you people have.
> 
> Please?

My proposal would be to pull it into -next early after we have
v5.18-rc1. I expect some minor clashes with folio changes that should go
in in the next merge window, so I'll have to rebase+resend either way,
and I'm planning on thoroughly testing at least on s390x as well.

We'd then have plenty of time to further review+test while in -next
until the v5.19 merge window opens up.

By that time I should also have my selftests cleaned up and ready, and
part 3 ready to improve the situation for FOLL_GET|FOLL_WRITE until we
have the full FOLL_GET->FOLL_PIN conversion from John (I'll most
probably sent out an early RFC of part 3 soonish). So we *might* be able
to have everything fixed in v5.19.

Last but not least, tools/cgroup/memcg_slabinfo.py as mentioned in patch
#10 still needs care due to the PG_slab reuse, but I consider that a
secondary concern (yet, it should be fixed and help from the Authors
would be appreciated ;) ).

-- 
Thanks,

David / dhildenb

