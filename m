Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE66558E9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiHJJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiHJJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B489A84EF2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660124237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgtUL/ut4ckTYGF2mnm2NIvF4nw0MtnKMGbr3fh8PYE=;
        b=duXlsGvqN6PBacMn8aDAmYxMABYWaBZ1Oei6WXUFbpLh3UZy15NZRkFL07sWTS6pEzXwo6
        ASJX7djm/kQhGwizE8UGydA+LuhTpzg+OjsWJJLv7Z5Whs0K4N16/JNfgc45G6ym0O8BgX
        xWgHbvNtZQh0U/Fxn76cmlDrtB1bekc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-6pmRRsY3NP2V12TFFR-e9Q-1; Wed, 10 Aug 2022 05:37:16 -0400
X-MC-Unique: 6pmRRsY3NP2V12TFFR-e9Q-1
Received: by mail-wm1-f72.google.com with SMTP id 131-20020a1c0289000000b003a52a0c70b0so5409086wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=tgtUL/ut4ckTYGF2mnm2NIvF4nw0MtnKMGbr3fh8PYE=;
        b=n696uFHZO3NSm3Ku433U2G2+lPIz7lOheQtefHJY5XTCuL3bWowHdEij453IYEY4E5
         tsPttidNfs/4SJPjv06RejlUMKiyVveVpK1/reaQhtRIvi7OipT2CYJWAHUMXf691f69
         qDKk0GS30uws0W60PaQbgkFwLU0ChxajnexqMwsz7mjDJfEiJ2ItZxSH3YbkKJOoLtW1
         z3MGjju2DccSroOq7wR8KzJPcCqCnSH63IhrCX+vNNH/FLnN4NAiyKGZyv96J3OcZ3zm
         xvv0IoCnah7NZKhWyxRvn/mUmFdFlJrU4QJhMiSYOdUgmCzsKGmS/N6e6iAWJ5XooRRM
         nwRg==
X-Gm-Message-State: ACgBeo09a8JNxBTYkUTXx1bVUOI3fEHxqQB7iCIV38a09LQ2kQ/mGUXu
        seEuEb25rwPThsrz7IvjQDpPWqbiZyTkHZJKW3hzGHHx0XtU0puS9vbFdPVMD3FUpPTFprFqA5R
        OZRrxkUubM+uYtub1aZRcu/Y7
X-Received: by 2002:a5d:5584:0:b0:220:6c21:2fbf with SMTP id i4-20020a5d5584000000b002206c212fbfmr16884035wrv.320.1660124235295;
        Wed, 10 Aug 2022 02:37:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7wiJ4EkLf7y2zWa+evXh4h5i+8Ti76R2immsKuI2Y3gywe4sfOc8qVhE2oghIFgQyWoXzY7g==
X-Received: by 2002:a5d:5584:0:b0:220:6c21:2fbf with SMTP id i4-20020a5d5584000000b002206c212fbfmr16884018wrv.320.1660124235026;
        Wed, 10 Aug 2022 02:37:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c5457000000b003a54f5fcc5dsm1786318wmi.10.2022.08.10.02.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:37:14 -0700 (PDT)
Message-ID: <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
Date:   Wed, 10 Aug 2022 11:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-3-david@redhat.com> <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
 <YvFwU4e3WOSRseh6@xz-m1.local> <YvGJQaYeT9Y8PlDX@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YvGJQaYeT9Y8PlDX@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.22 00:08, Peter Xu wrote:
> On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
>> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
>>>>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
>>>>> unfortunately wrong.
>>>>>
>>>>> If you're curious, take a look at f83a275dbc5c ("mm: account for
>>>>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
>>>>> and mmap() code.
>>>>>
>>>>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
>>>>> not VM_SHARED (and consequently also not VM_MAYWRITE).
>>>>
>>>> To ask in another way: if file is RO but mapped RW (mmap() will have
>>>> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
>>>> won't we grant write bit errornously while we shouldn't? As the user
>>>> doesn't really have write permission to the file.
>>>
>>> Thus the VM_WRITE check. :)
>>>
>>> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
>>> semantics here as well. Then there is no need for additional VM_WRITE
>>> checks and hugetlb will work just like !hugetlb.
>>
>> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
>> the cases where MAYSHARE && !SHARE - we used to silently let it pass.
> 
> Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
> with/without the patch on any write to hugetlb RO regions.
> 
> Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
> here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
> don't see a problem.
> 
> It also means I can't think of any valid case of having VM_WRITE when
> reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
> Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
> hugetlbfs after all.
> 

The main reason we'd have it would be to scream out lout and fail
gracefully if someone would -- for example -- use it for something like
FOLL_FORCE. I mean triggering a write fault without VM_WRITE on !hugetlb
works, so it would be easy to assume that it similarly simply works for
hugetlb as well. And the code most probably wouldn't even blow up
immediately :)

-- 
Thanks,

David / dhildenb

