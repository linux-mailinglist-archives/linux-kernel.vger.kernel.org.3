Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD394D6923
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351146AbiCKThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiCKThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19387A1BCF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647027402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPUrpfRAqac225NyEd4nrs7asUwgp/J03uajT5hWfqA=;
        b=ODb/Hqet88t30d9PPigV44qy9132GbWtMnzdvmrmvz4P1HKd9Ev2/+JWOe6CqWsSH7FXOe
        b33VGd+GshOW/qq6nYYpI9Uuc/cf9n3xLnp0VxkQbjHppKpgYY0C7+PfOOTSNFKYTMoYBQ
        UjYypYiOVMFb68xtPBDesMW3Uc2yuy0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649--ZpX_t2XPv2ZnqpHW4ifqg-1; Fri, 11 Mar 2022 14:36:41 -0500
X-MC-Unique: -ZpX_t2XPv2ZnqpHW4ifqg-1
Received: by mail-wm1-f69.google.com with SMTP id z9-20020a7bc7c9000000b00389bd375677so3798875wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wPUrpfRAqac225NyEd4nrs7asUwgp/J03uajT5hWfqA=;
        b=a9Ji4FKq/NfYpczWqoW106ClYIxdtL7c+H53VkHaoJmJIY+74CZNlns/y+nTz09IxV
         DTfqtAF4nnO3IC4OGshYxi/WvodWeJBLIxig9Ld9OxXINLujimNN7AjJQ15oK1HAU8T1
         lcSvqOnl5QyZsNLIt2BKVItUqybtovNyLByxyoufBVBGYAC0QsGq0H6/Nqwj+ZbEuJ00
         5lhdVlsLFJ4TQR9xNMzSfUD1X0/EncwFsjczgMKzQn88BXVhwpcBK3k+24FczdFZ73U2
         nHnUGWA4VPVDxg0UrNHkIstixT8HJmJTW9DgJXI5/iReUzY7D2E+vyGiUONUBMTEjb8W
         LrMw==
X-Gm-Message-State: AOAM531AE1bEhrdpollPkTHm7GpytVoVW29rT8rloijbYND4896/Ojch
        usdsawTXeiFTGXDa++CEItMkAzBUGmcRJBZ1YyLjhKZHkE0Ub9xCuofcu60cpI4XD0K/xkZNrU8
        g0/3wa5GUW129p90YwRBhv7cH
X-Received: by 2002:a05:600c:a0a:b0:350:564b:d55e with SMTP id z10-20020a05600c0a0a00b00350564bd55emr8525939wmp.124.1647027399838;
        Fri, 11 Mar 2022 11:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmSNNgK3mtCqM8BBLibdarWwsWTj73jvbn2Q9MTbGHUOVZZYQKYfSDUZJrKEFrYJWsCU7UaA==
X-Received: by 2002:a05:600c:a0a:b0:350:564b:d55e with SMTP id z10-20020a05600c0a0a00b00350564bd55emr8525926wmp.124.1647027399517;
        Fri, 11 Mar 2022 11:36:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d5906000000b001f0639f69e6sm7631228wrd.55.2022.03.11.11.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 11:36:39 -0800 (PST)
Message-ID: <e166e925-508e-3830-574f-59b2d2cf2431@redhat.com>
Date:   Fri, 11 Mar 2022 20:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
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
        Linux-MM <linux-mm@kvack.org>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
 <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
 <CAHk-=wjWx_bPBLB=qMMae8Sy3KrO+Kvaf4juPknO5HX-+Ot0XQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wjWx_bPBLB=qMMae8Sy3KrO+Kvaf4juPknO5HX-+Ot0XQ@mail.gmail.com>
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

On 11.03.22 20:22, Linus Torvalds wrote:
> On Fri, Mar 11, 2022 at 10:46 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> -       PG_has_hwpoisoned = PG_mappedtodisk,
>> +       PG_has_hwpoisoned = PG_waiters,
> 
> That makes me too nervous for words. PG_waiters is very subtle.

Yes, but PG_has_hwpoisoned is located on the second subpage of a
compound page, not on the head page.

> 
> Not only is it magical in bit location ways (and the special
> clear_bit_unlock_is_negative_byte() macro that *literally* exists only
> for unlocking a page), it just ends up having fairly subtle semantics
> with intentionally racy clearing etc.
> 
> Mixing that up with any hwpoison bits - that aren't used by any normal
> mortals and thus get very little coverage - just sounds horribly
> horribly wrong.

I used PG_error before, but felt like using a bit that is never ever
valid to be set/cleared/checked on a subpage would be even a better fit:

Note the:

  PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)

whereby PF_ONLY_HEAD translates to:

"for compound page, callers only ever operate on the head page."


I can just switch to PG_error, but for the second subpage, PG_waiters
should be just fine (unless I am missing something important).

-- 
Thanks,

David / dhildenb

