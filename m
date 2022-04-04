Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4154F1129
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiDDIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbiDDIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D628616597
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649061975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FGlpUlGTCy+w2gh0UmqmOnB72uDz0ge+Yxa+SxTUPk=;
        b=RwCBROBBnUAas7efnv7FQkekdTl/HqsMN6p6EplTqiORi7hNFfFW7/eFHRje5+Bk6hnSql
        b7F5AxejvPlKyXhcLEWfycekq1z21jBgzncUr4Gos5FKs3mzDk9nl5MeKXhNFhrrWsZhnx
        ZqpdF3zhzW7m3DqaH+vdM0Sphew/QLE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-fNNYYjaHNi-l_nEIohpcUg-1; Mon, 04 Apr 2022 04:46:13 -0400
X-MC-Unique: fNNYYjaHNi-l_nEIohpcUg-1
Received: by mail-wm1-f69.google.com with SMTP id f19-20020a7bcd13000000b0038c01defd5aso4708830wmj.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=2FGlpUlGTCy+w2gh0UmqmOnB72uDz0ge+Yxa+SxTUPk=;
        b=sfTrc5Gf4HMdUwZPj1dzKZwE9LCHlfI1ASYfeYEH0ptm4qxj02IyDORcJO1XVbK7oA
         YRoTXitRlgv5HtgLrxsWFsGKyNcQASSKo8Hj9jPlJI1XEh++CM0wCpA/aYNpHYEgC+5O
         3HW3RaJZ+xqSXiHUUxGjuhp9vtrgDm58nMaUZGna7d6xm+Ai22s391Nsfzlcqb4/BkYW
         ds/cEJfJR6U8AJU7wxUwomzHxUav7SBsTb0E5cGh95c4Be3dk9lfurGMgmqmCVwhs+9j
         6o4ZCGkkSe+0bXjcCihl0eb/l1hTcx2ZYh/LcrBb6FkfL6HbZhyEL0+IyKtpBv0SONp2
         Lkyw==
X-Gm-Message-State: AOAM5326eiAuQ/pp5ZMWByZH1I4nkgEqXX4nUR0PZ5bG2psuOgP6a7aR
        wl691ZudExLuAqRgADxswGNvadPR/6bw//O3ufT1GYH2MsaF6612P8VkvNCf5Zsx5t/ThpB3Ro8
        HZitTEXj++w40G/cyPCjfmBsB
X-Received: by 2002:adf:de8b:0:b0:206:893:6aee with SMTP id w11-20020adfde8b000000b0020608936aeemr6835638wrl.368.1649061972742;
        Mon, 04 Apr 2022 01:46:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvhC7T+sJ2cNb00lM1hfXlH/qni7IvZKgUo5cucvxi+zgzb1rPMxu4bLJIXtVvJRDnx0I5Vg==
X-Received: by 2002:adf:de8b:0:b0:206:893:6aee with SMTP id w11-20020adfde8b000000b0020608936aeemr6835623wrl.368.1649061972491;
        Mon, 04 Apr 2022 01:46:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4100:c220:ede7:17d4:6ff4? (p200300cbc7044100c220ede717d46ff4.dip0.t-ipconnect.de. [2003:cb:c704:4100:c220:ede7:17d4:6ff4])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm9091663wrs.43.2022.04.04.01.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 01:46:12 -0700 (PDT)
Message-ID: <78a9f784-51c8-7693-28ed-84fe3db4bc71@redhat.com>
Date:   Mon, 4 Apr 2022 10:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check
 in __free_one_page().
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Kalle Valo <kvalo@kernel.org>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220401135820.1453829-1-zi.yan@sent.com>
 <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
 <66F9766D-A7D8-4310-9FA9-5EC8B2CC341C@nvidia.com>
 <85520c49-5ef9-25f2-d6fa-f8b26e5dfec2@redhat.com>
 <6696fb21-090c-37c6-77a7-79423cc9c703@redhat.com>
 <87sfqwszc2.fsf@tynnyri.adurom.net> <87mth3udl2.fsf@tynnyri.adurom.net>
 <51D1B1D7-66D6-48A6-9E66-8C7686465EE4@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <51D1B1D7-66D6-48A6-9E66-8C7686465EE4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.22 14:00, Zi Yan wrote:
> On 2 Apr 2022, at 3:52, Kalle Valo wrote:
> 
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 01.04.22 16:22, David Hildenbrand wrote:
>>>>> On 01.04.22 16:19, Zi Yan wrote:
>>>>>> On 1 Apr 2022, at 10:12, David Hildenbrand wrote:
>>>>>>
>>>>>>> On 01.04.22 15:58, Zi Yan wrote:
>>>>>>>
>>>>>>> It's weird, your mails arrive on my end as empty body with attachment. I
>>>>>>> first suspected Thunderbird, but I get the same result on the google
>>>>>>> mail web client.
>>>>>>>
>>>>>>> Not sure why that happens.
>>>>>>
>>>>>> No idea. They look fine (except mangled links by outlook) on my outlook
>>>>>> desk client and web client on my side. lore looks OK too:
>>>>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/
>>>>>
>>>>> I can spot in the raw mail I receive
>>>>>
>>>>> "Content-Type: application/octet-stream; x-default=true"
>>>>>
>>>>> But that seems to differ to the lore mail:
>>>>>
>>>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/raw
>>>>>
>>>>>
>>>>> Maybe something in my mail server chain decides to do some nasty
>>>>> conversion (grml, wouldn't be the first time)
>>>>>
>>>>
>>>> Weird thing is that this only happens with your mails. I opened an
>>>> internal ticket, sorry for the noise.
>>>
>>> Zi's patch emails I received didn't have Content-Type, that might have
>>> something to do with this. (But his reply later in the thread did have
>>> one.) Also last week I got one patch email with no Content-Type either
>>> and my Gnus decided to convert it to octet-stream, I guess to be on the
>>> safe side. No idea if something similar is happening to you, but wanted
>>> to mention it anyway.
> 
> The emails I got from linux-mm mailing list do not have Content-Type either,
> but the ones I got directly from my git-send-email have it. David is in the
> cc list, so the emails sent to him should have Content-Type.

I assume I received them without a Content-type, or mail servers
stripped them, and Mimecast servers (which RH uses) fail to auto-detect
and add a wrong Content-type. Wouldn't be the first time that Mimecast
messed with mail encodings etc, unfortunately.


-- 
Thanks,

David / dhildenb

