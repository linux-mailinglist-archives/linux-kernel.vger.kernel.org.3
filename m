Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C895E4D6D78
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiCLIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiCLIM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EE80268C2E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647072680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFLnAdgDOQ5hQlNRliUXXsmFU+Cm7xTjHzqvxYTuqXE=;
        b=A8B0eXS7ieULiDIG7UVy8D9Yb7Ztv0ODeqi/4Fh3JoL+Xida5v7T/1N7jYkzrprpMf2PBs
        qHvZBhjeRVIgkoVbCqoBvlYT1TYyzRadfjgD0BuRvJwylDMs8KpuxUFLP7o0HrrkggS4pr
        xLPMfNyrDl0jT14lHpkCdVf/LC+6V2g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-MMqqmVFDNuOlxsHdy4CYFA-1; Sat, 12 Mar 2022 03:11:19 -0500
X-MC-Unique: MMqqmVFDNuOlxsHdy4CYFA-1
Received: by mail-wm1-f70.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so4062058wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OFLnAdgDOQ5hQlNRliUXXsmFU+Cm7xTjHzqvxYTuqXE=;
        b=cUYPXTvtZSXlQY1022juzXzL491gLZRfsTPwuR2xyqRMYVUsbkYEB19sttukcFNyYb
         cqDSfKQO8RMjZPaSacvN5XAF84tUQtwRuMDs+npSm0rIeQ4ADbTOnnZ2nMjjf+eisNKv
         EcMbZLMnPVY4JFwfsz+iVDkz9c9GKNIbb6Tmwn/leNZK+CSAoOAFR6V+kzyyl18p21hu
         sfzCpxj6atGH8nWOEF0fiWlD4nyOFLipRmuUxEPd6f1eCqw1/lZhBBYyEbvkt4Oa9OKc
         mlJaiS7bMwpMBcDwtBW4KHEIXLEALStuFW+3x3EMf9865zq3oVPof0m3ABCX4cTXLmyK
         M4Vg==
X-Gm-Message-State: AOAM530KqXpH4KDtB9bbiZKXQpWlv2MzNhrx9ujBWqtBX0jOtBUX47+o
        0Gylo4Qnfn0XUWSgOuVphl3ngwqP6igfRpJ3xomhA1U6ZnzBt3anx43ZVp5A40ADL1D4dDs8HCO
        RQK0ItsxduNp1UiSs2LzIoeuM
X-Received: by 2002:a05:600c:35d4:b0:389:cdff:7f47 with SMTP id r20-20020a05600c35d400b00389cdff7f47mr10073081wmq.127.1647072677801;
        Sat, 12 Mar 2022 00:11:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQpvEXNxt9hA7e0QKh4J0CgDiDeYaJnud26vT5cgg1hnewDfl+WaiLYT8dPf+LJSQaCG/esw==
X-Received: by 2002:a05:600c:35d4:b0:389:cdff:7f47 with SMTP id r20-20020a05600c35d400b00389cdff7f47mr10073055wmq.127.1647072677552;
        Sat, 12 Mar 2022 00:11:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c71e:1600:ad89:c64e:8371:c9c4? (p200300cbc71e1600ad89c64e8371c9c4.dip0.t-ipconnect.de. [2003:cb:c71e:1600:ad89:c64e:8371:c9c4])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm8257257wrs.16.2022.03.12.00.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 00:11:17 -0800 (PST)
Message-ID: <6e0c4a21-7dff-044b-cd4b-6d612559f10d@redhat.com>
Date:   Sat, 12 Mar 2022 09:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Linux-MM <linux-mm@kvack.org>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
 <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
 <CAHk-=wjWx_bPBLB=qMMae8Sy3KrO+Kvaf4juPknO5HX-+Ot0XQ@mail.gmail.com>
 <e166e925-508e-3830-574f-59b2d2cf2431@redhat.com>
 <Yiu693LTmhLyo1yu@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yiu693LTmhLyo1yu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 22:11, Matthew Wilcox wrote:
> On Fri, Mar 11, 2022 at 08:36:37PM +0100, David Hildenbrand wrote:
>> I used PG_error before, but felt like using a bit that is never ever
>> valid to be set/cleared/checked on a subpage would be even a better fit:
>>
>> Note the:
>>
>>   PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
>>
>> whereby PF_ONLY_HEAD translates to:
>>
>> "for compound page, callers only ever operate on the head page."
>>
>>
>> I can just switch to PG_error, but for the second subpage, PG_waiters
>> should be just fine (unless I am missing something important).
> 
> I think you're missing something important that almost everybody misses
> when looking at this code (including me).
> 
> PF_ANY flags can be set on individual pages.
> PF_HEAD means "we automatically redirect all operations to the head page".
> PF_ONLY_HEAD means "If you try to call this on a tail page, we BUG".
> PF_NO_TAIL means "If you try to read this flag on a tail page, we'll
> look at the head page instead, but if you try to set/clear this flag
> on a tail page, we BUG"

^ that's actually the confusing part for me

"modifications of the page flag must be done on small or head pages,
checks can be done on tail pages too."

Just from reading that I thought checks on the tail page would *not* get
redirected to the head.

I'd have written that as and extended version of PF_HEAD:

"for compound page all operations related to the page flag are applied
to head page. Checks done on a tail page will be redirected to the head
page."

[...]

> 
> So really, you can reuse any flag as PF_SECOND that isn't PF_ANY.
> 

I'll go back to PG_error, thanks!

-- 
Thanks,

David / dhildenb

