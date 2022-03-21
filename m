Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A194E2DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbiCUQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350949AbiCUQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE8A513D6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647879311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWSu+Df1NTcRHn2JTsvvlDbbrD7r44W7HRjFAAjbrvk=;
        b=b8wsH1Sk7frjWZoU5Vhm/7bYskBr9mE6ncFHK37Ck5kuu7rVzXM4lZWcwARWyvuExy5fvA
        DhQ4eYPSn5wqztrwnvo7m3qx6JqSG5x3HuOB5i9WDdDekyCuBtAN1eAnX63mqdFdUmJRzX
        Fy9cAkFm055M0+iDS5X3idoBc/EPMR4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-BwBZkTo-OUKzjmG192bviA-1; Mon, 21 Mar 2022 12:15:09 -0400
X-MC-Unique: BwBZkTo-OUKzjmG192bviA-1
Received: by mail-wm1-f72.google.com with SMTP id o10-20020a1c4d0a000000b0038c6e5fcbaeso5810152wmh.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=GWSu+Df1NTcRHn2JTsvvlDbbrD7r44W7HRjFAAjbrvk=;
        b=0PQ7jfrVYAY/NqrcRuVawwwn/Gz/ezZ6iNjb+DnAWEAG7h+0qYfSiTTcwoS+w+Bl05
         nkjO4t6Dl5Hor1vHIjZKzLpCXLqSFqcUCSzljVH/hcLfcS7lcRNi/vc5LkZMDI8XbCGF
         SNsNnmAnKyLTHf5x0L8Ad5TUEvkr5xNmEJ+KS1q0jjSiw40QnxRc5+Vr/MK/ncI0qvYT
         yHI3o/90/ALwsclZK3eCJXFPsF8oQ8VuT6ArsOqgtf6uL9/rIOEC1skOu2jpuZ3JWFTO
         Rte+r5Lin/52VndGTuJV2zcf6ApjTayOCeozjUJPhmWHXhiSIIDg1fd9OB6ZouDo1cuW
         lxOg==
X-Gm-Message-State: AOAM533TqIV1HQq42n9MCsOs6c7AP9UhdDCYva8Uq0cBXf83qT7AKIIf
        HJ6v2WtAHh4H6KO8xzj58Pp5yryy925dEpmA3ffMLDeYvO7QOu6NnJaBVqN7wFqSUWSRZscXCpF
        2u1Svygv61ktGJr9JSBe5hKoK
X-Received: by 2002:a7b:c186:0:b0:38c:75ea:4903 with SMTP id y6-20020a7bc186000000b0038c75ea4903mr20053752wmi.176.1647879308341;
        Mon, 21 Mar 2022 09:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9vbmXdlBs0qYvMyCxjbPwPobTZnA/F1kYqtLCUimqr9jidJsAu8QnRnWfnBt0Bn3okiqO+Q==
X-Received: by 2002:a7b:c186:0:b0:38c:75ea:4903 with SMTP id y6-20020a7bc186000000b0038c75ea4903mr20053707wmi.176.1647879308017;
        Mon, 21 Mar 2022 09:15:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95? (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de. [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm2509795wrr.100.2022.03.21.09.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:15:07 -0700 (PDT)
Message-ID: <de543fbc-0051-120b-c91a-74cf4dd6156b@redhat.com>
Date:   Mon, 21 Mar 2022 17:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 13/15] mm: support GUP-triggered unsharing of anonymous
 pages
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-14-david@redhat.com>
 <20220318233035.GA11336@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220318233035.GA11336@nvidia.com>
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

On 19.03.22 00:30, Jason Gunthorpe wrote:
> On Tue, Mar 15, 2022 at 11:47:39AM +0100, David Hildenbrand wrote:
>> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
>> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
>> on the page table entry will end up replacing the mapped anonymous page
>> due to COW, resulting in the GUP pin no longer being consistent with the
>> page actually mapped into the page table.
>>
>> The possible ways to deal with this situation are:
>>  (1) Ignore and pin -- what we do right now.
>>  (2) Fail to pin -- which would be rather surprising to callers and
>>      could break user space.
>>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
>>      pins.
>>
>> We want to implement 3) because it provides the clearest semantics and
>> allows for checking in unpin_user_pages() and friends for possible BUGs:
>> when trying to unpin a page that's no longer exclusive, clearly
>> something went very wrong and might result in memory corruptions that
>> might be hard to debug. So we better have a nice way to spot such
>> issues.
>>
>> To implement 3), we need a way for GUP to trigger unsharing:
>> FAULT_FLAG_UNSHARE. FAULT_FLAG_UNSHARE is only applicable to R/O mapped
>> anonymous pages and resembles COW logic during a write fault. However, in
>> contrast to a write fault, GUP-triggered unsharing will, for example, still
>> maintain the write protection.
> 
> Given the way this series has developed you might want to call this
> FAULT_FLAG_MAKE_ANON_EXCLUSIVE
> 
> Which strikes me as more directly connected to what it is trying to
> do.

I thought about something similar along those lines, and I think it
would apply even when extending that mechanism to anything !anon inside
a MAP_PRIVATE mapping.

The whole

const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;

would get a little more verbose, though

const bool make_anon_exclusive = vmf->flags &
				 FAULT_FLAG_MAKE_ANON_EXCLUSIVE;


No strong opinion, any other opinions or alternatives?

-- 
Thanks,

David / dhildenb

