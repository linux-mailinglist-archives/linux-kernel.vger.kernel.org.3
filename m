Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72021506618
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349491AbiDSHmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349494AbiDSHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6105A237DF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650353979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOpmuM2i+aI3NSsRRZHn/eWgehmHPwpUAsrONEKKMOs=;
        b=XRt5+yVdy0i9x4xVTwi6zlWd3kJLM6ZL41ccf0EJDEiwj1YUgqPc4n7lOVhBaT1UQ4k7RT
        r+F888NUOoVI/T5L2UMOISlTRbvZyR9jHLZoZQoGMAeiwIb9EhMMu54DhTqEOhDQ91sRME
        CNG64d8qqChjUsQvVBciBpTsED4YldM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-6_zsPT36PdShp5fuhaIB6A-1; Tue, 19 Apr 2022 03:39:38 -0400
X-MC-Unique: 6_zsPT36PdShp5fuhaIB6A-1
Received: by mail-wr1-f71.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so1691802wrg.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XOpmuM2i+aI3NSsRRZHn/eWgehmHPwpUAsrONEKKMOs=;
        b=CT7rhuUmpx6Ls6C9beOyc1DBwfp0BrutIZCItWbz8tayF4TnhViKZPIiIfcpKFU5Vc
         LB9wbrcVcBoP1kg8WmwrVHZC26LUlTWXaiuA4BXmKI80rl1zcdhZcnJBHq7y6mm5PBwL
         ZoyG48URkl7a4Fj/HkbNLvL5IvoDdCdqu1d5IY8wgiyBDk5Ovw/swqQSizYPjn3880fi
         NYh07EXmjYd+xPgQBiAPQ85DmKMPRs/vkBX04iRjSlKepwTxyYsqEEmkwh7rDOCVZeFl
         9z/rww8kcxmFJxEwb//WBqxB0/jqjsqXzBygLJCN1kvaMTJNbvM7CVLAB3el2QSnExSK
         oUkg==
X-Gm-Message-State: AOAM533z+kEgokJgJ7ILQrp9MqcUCd5Hh3Mw4O8GGQFSV7fDluBjLcvj
        uIOwcierN0WJoy9lGY/mrLMPmkkQBugB8qkzhT+1zSuTEwNFo/vTQEdXEPznVjG/TRU+ZsP9n/O
        6HjsuxtVvnIfMmNJshvFYYt0k
X-Received: by 2002:a5d:6da9:0:b0:20a:8d08:9977 with SMTP id u9-20020a5d6da9000000b0020a8d089977mr8724751wrs.24.1650353977099;
        Tue, 19 Apr 2022 00:39:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPnGJoHNCRvBkoifHOOljCQXSGLKIO7XF3Y29udTxBvINx0tU0Slt2gzNuLzPFknUJ1K6L2Q==
X-Received: by 2002:a5d:6da9:0:b0:20a:8d08:9977 with SMTP id u9-20020a5d6da9000000b0020a8d089977mr8724729wrs.24.1650353976824;
        Tue, 19 Apr 2022 00:39:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm16241144wmn.16.2022.04.19.00.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:39:36 -0700 (PDT)
Message-ID: <72cfde7a-61d7-980c-4653-94ae83eb4257@redhat.com>
Date:   Tue, 19 Apr 2022 09:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        rcampbell@nvidia.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal>
 <5a78dd68-343d-ac57-a698-2cfead8ee366@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <5a78dd68-343d-ac57-a698-2cfead8ee366@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 09:29, Miaohe Lin wrote:
> On 2022/4/19 11:51, Alistair Popple wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>
>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>> page filled with random data is mapped into user address space. In case
>>> of error, a special swap entry indicating swap read fails is set to the
>>> page table. So the swapcache page can be freed and the user won't end up
>>> with a permanently mounted swap because a sector is bad. And if the page
>>> is accessed later, the user process will be killed so that corrupted data
>>> is never consumed. On the other hand, if the page is never accessed, the
>>> user won't even notice it.
>>
>> Hi Miaohe,
>>> It seems we're not actually using the pfn that gets stored in the special swap
>> entry here. Is my understanding correct? If so I think it would be better to use
> 
> Yes, you're right. The pfn is not used now. What we need here is a special swap entry
> to do the right things. I think we can change to store some debugging information instead
> of pfn if needed in the future.
> 
>> the new PTE markers Peter introduced[1] rather than adding another swap entry
>> type.
> 
> IIUC, we should not reuse that swap entry here. From definition:
> 
> PTE markers
> ===========
> ...
> PTE marker is a new type of swap entry that is ony applicable to file
> backed memories like shmem and hugetlbfs.  It's used to persist some
> pte-level information even if the original present ptes in pgtable are
> zapped.
> 
> It's designed for file backed memories while swapin error entry is for anonymous
> memories. And there has some differences in processing. So it's not a good idea
> to reuse pte markers. Or am I miss something?

I tend to agree. As raised in my other reply, maybe we can simply reuse
hwpoison entries and update the documentation of them accordingly.

-- 
Thanks,

David / dhildenb

