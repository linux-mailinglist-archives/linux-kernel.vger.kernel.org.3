Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C752FE5A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355583AbiEUQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355521AbiEUQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEB7C2FE78
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653151592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BRbo+vuq5LTP0pWUvZ2lm2FhUMJrA8InL1ab0wyx424=;
        b=D3fwSR4ppQjCCYdwU35BmacHqny5JYhY5wEYabFFlBtX95ooo9qCEvLBj8dJ5vx6+lUfiS
        DxfwNvAanWxT4o+ZX6kwi4GtvV8zKKBOD14qxJqt1kT915r2xwFUOjwFbvCGI38AE7XRMF
        ZcjAUxZ/yWax4t5btlGvmKOcn8nNLJc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-DQTqquAzPXie1yaGHycKpQ-1; Sat, 21 May 2022 12:46:31 -0400
X-MC-Unique: DQTqquAzPXie1yaGHycKpQ-1
Received: by mail-ed1-f72.google.com with SMTP id s9-20020aa7d789000000b0042ab9d77febso7621900edq.16
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=BRbo+vuq5LTP0pWUvZ2lm2FhUMJrA8InL1ab0wyx424=;
        b=cKiVHo47cig5sf3qSne7oR8Zz2fMryERgZagoG7ITL9NBpEt61mPOIXIpa/bopgX7/
         78ASfQht4pZVMLfs/UCXFQpo2yX+4oFVyZ8JJviLSe5h/N/xY8//iZM4s1nwh9VNR37h
         KuQNpiJXOBwgT5JJEsg9GMxwwgW65tAjN80sX7KChXHjkkO9gOM2FUR5ZAoOsHmyJIff
         I/jQf5QeGd/0amdEXThS1KRpGY5bN652wRECr4UPdFej+8xAUinJhqsuF1AADPgTfKwf
         PvKy8FAfaaFqekgxGI80ntTdvURYh1Xtb35OPWjehT4iL4ebcwSe2o5O1y0EwyOWQBcd
         WSPw==
X-Gm-Message-State: AOAM532iqA+t9J0eU6eXg8SZqeU7JZMkr1cBODFvQrHr1bzURm42L5l4
        6fI48hLuodSzyqlIEErDwhOkboSY6wAX9mbGAl/6mmAzPh5bxvJzKp/0o7k4FzW1lBYny+n2oOJ
        Z62pubSFYqezj17P1SMr/ANf2
X-Received: by 2002:a05:6402:5190:b0:42b:b2d:19b8 with SMTP id q16-20020a056402519000b0042b0b2d19b8mr12195056edd.390.1653151590266;
        Sat, 21 May 2022 09:46:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOr2awZAGQfDq6zgfxm1K78hPvGd4Wgc18hsuISrUainwzjTd3nsyVZq18CQK6uxycERgI0Q==
X-Received: by 2002:a05:6402:5190:b0:42b:b2d:19b8 with SMTP id q16-20020a056402519000b0042b0b2d19b8mr12195036edd.390.1653151590054;
        Sat, 21 May 2022 09:46:30 -0700 (PDT)
Received: from [172.29.4.249] ([45.90.93.190])
        by smtp.gmail.com with ESMTPSA id ia16-20020a170907a07000b006f3ef214e16sm4372877ejc.124.2022.05.21.09.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:46:29 -0700 (PDT)
Message-ID: <000a117a-694d-d3a9-a192-14d08d50c884@redhat.com>
Date:   Sat, 21 May 2022 18:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
 <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
 <YognlSdHAKgnkPPY@google.com>
 <b36a728c-03a1-0e07-b6d2-9515e647416f@oracle.com>
 <YokEEAemXTwTSZh5@google.com>
 <b025ddd5-aca2-f3e2-6a4f-24a1b4eda985@redhat.com>
 <YokVEZbOayed5hBb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
In-Reply-To: <YokVEZbOayed5hBb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> It should also be noted that hugetlb code sets up the CMA area from which
>>>>>> hugetlb pages can be allocated.  This area is never unreserved/freed.
>>>>>>
>>>>>> I do not think there is a reason to disallow long term pinning of hugetlb
>>>>>> pages allocated from THE hugetlb CMA area.
>>
>> Hm. We primarily use CMA for gigantic pages only IIRC. Ordinary huge
>> pages come via the buddy.
>>
>> Assume we allocated a (movable) 2MiB huge page ordinarily via the buddy
>> and it ended up on that CMA area by pure luck (as it's movable). If we'd
>> allow to pin it long-term, allocating a gigantic page from the
>> designated CMA area would fail.
> 
> If we allow the longterm pin against the hugetlb page come via buddy,
> it should be migrated out of CMA before the longterm pinning by
> check_and_migrate_movable_pages, IIUC.

Yes.

> If so, what the allocating a giganitc page from the designated CMA area
> would fail?

Nothing I just summarized it.

> 
>>
>> So we'd want to allow long-term pinning a gigantic page but we'd not
>> want to allow long-term pinning an ordinary huge page. We'd want to
>> migrate the latter away.
> 
> Sure. Gigantic page was already CMA claimed page so there is no user
> in the future to claim the memory again so fine to allow longterm pin
> but ordinary huge page shouldn't be allowed since CMA owner could
> claim the memory some day.
> 

Right.

>>
>>
>> The general rules are:
>>
>> ZONE_MOVABLE: nobody is allowed to place unmovable allocations there; it
>> could prevent memory offlining/unplug.
>>
>> CMA: nobody *but the designated owner* is allowed to place unmovable
>> memory there; it could prevent the actual owner to allocate contiguous
>> memory.
> 
> I am confused what's the meaning of designated owner and actuall owner
> in your context.

designated==actual here. I just wanted to distinguish from someone
current temporary owner of the page ("allocated it via a movable
allocation") but the actual designated owner (e.g., hugetlb CMA)

The page/memory owner terminology is just confusing. Let's rephrase to:
only the CMA area owner is allowed to place unmovable allocations there.

> 
> What I thought about the issue based on you explanation:
> 
> HugeTLB allocates its page by two types of allocation
> 
> 1. alloc_pages(GFP_MOVABLE)
>  
> It could allocate the hugetlb page from CMA area but longterm pin
> should migrate them out of cma before the pinning so allowing
> the pinning on the page is no problem and current code works like
> that.
> 
>     check_and_migrate_movable_pages
> 

Yes.

> 2. cma_alloc
> 
> The cma_alloc is used only for *gigantic page* and the hugetlbfs
> is the very owner of the page. IOW, if the hugetlbfs was succeeded
> to allocate the gigantic page by cma_alloc, there is no other
> owner to be able to claim the page any longer so it's fine to
> allow longterm pinning againt the gingantic page but current.
> However, current code doesn't work like that due to
> is_pinnable_page. IOW, hugetlbfs need a way to distinguish 
> whether the page owner is hugetlbfs or not.
> 
> Are we on same page?

Yes, exactly. What I wanted to express is: for huge pages we have to
make a smarter decision because there are cases where we want to
migrate, and cases where we don't want to migrate.


-- 
Thanks,

David / dhildenb

