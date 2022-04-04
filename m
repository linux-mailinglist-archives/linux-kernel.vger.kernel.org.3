Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07504F1120
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiDDIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiDDIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D0B1D47
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649061819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nzOmV29QheSBFXEv0g6CAx6KudpBQBHerurkVsHvJck=;
        b=GOOI/Bxhl/zZWFO9s9JLAsYZtokxPn5a++SV1f0eFVB+5+n6y0irrWvkj454TNQorvDBtI
        of0uusmOMvYxbmtiNzFR5yK/RbgSdMhkpt+lj26UV0ahlRc4m3MqywXDg9BUlLdtBIqjMm
        sazJPNAMf0cAaI1UvU5fn3JtqkMu1qA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-Eu3uPvQPMIW6eYlz5ZlvzQ-1; Mon, 04 Apr 2022 04:43:38 -0400
X-MC-Unique: Eu3uPvQPMIW6eYlz5ZlvzQ-1
Received: by mail-wr1-f70.google.com with SMTP id o26-20020adf8b9a000000b0020617a99c43so138065wra.16
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=nzOmV29QheSBFXEv0g6CAx6KudpBQBHerurkVsHvJck=;
        b=WfWmFsodQyEyNou4ZD3meIlHgZrMRnan8Kgh8wPMKPf5adIH+gEa+br8pYcEF3nBir
         xIOcLATbw+nbw3xIvZ3khmcARStm8+dgAKwHbLxvwcrrxXV7DrFsQNGrL2oFBGN1OUeA
         G2bkeUsCJLbpUOFoHVgOMDydA9Y2qjiItZNQD9cttq92lLejmN8yLfZBPA+qOCIfWe/u
         wG/vRfvfCdqqk/LaUa1/DmhnK6KgZBAL/Bz9IFM0172fJMxhIZ04fM3na2pZ18ULMq0z
         E151RX1ahcIiuLvitZ14so9laVbv1r2uNpYAsBZoVwcVCV/NF7R2Q2IMGq9pSVS2fklc
         /fjw==
X-Gm-Message-State: AOAM532KBFv5wD1Ep00DxOPlr0+doGVbe17FVdMNNBpYqpp51JN2HxLz
        gxVhfJiW/rz0zNbXntbUf2ziZ7RCAkXc9ziPHY5xnw2LtDCH4PULw4cwmNDZX2weWvEV3gup+i6
        tPUSVQuR7g3prurRXP+tgto3z
X-Received: by 2002:a5d:4f8a:0:b0:205:8ff4:c301 with SMTP id d10-20020a5d4f8a000000b002058ff4c301mr16230724wru.41.1649061816706;
        Mon, 04 Apr 2022 01:43:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXVBe/l3DKZvRp9rTXXTRR2BJ5nn68Alsm92u9HYZIbbr7VWgSox3J/MwfqZafKIluh7n8eA==
X-Received: by 2002:a5d:4f8a:0:b0:205:8ff4:c301 with SMTP id d10-20020a5d4f8a000000b002058ff4c301mr16230717wru.41.1649061816473;
        Mon, 04 Apr 2022 01:43:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4100:c220:ede7:17d4:6ff4? (p200300cbc7044100c220ede717d46ff4.dip0.t-ipconnect.de. [2003:cb:c704:4100:c220:ede7:17d4:6ff4])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm8810335wrg.62.2022.04.04.01.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 01:43:35 -0700 (PDT)
Message-ID: <d508b094-3d3e-46d1-d66c-cc759e6a8f5e@redhat.com>
Date:   Mon, 4 Apr 2022 10:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check
 in __free_one_page().
In-Reply-To: <87mth3udl2.fsf@tynnyri.adurom.net>
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

On 02.04.22 09:52, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> 
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 01.04.22 16:22, David Hildenbrand wrote:
>>>> On 01.04.22 16:19, Zi Yan wrote:
>>>>> On 1 Apr 2022, at 10:12, David Hildenbrand wrote:
>>>>>
>>>>>> On 01.04.22 15:58, Zi Yan wrote:
>>>>>>
>>>>>> It's weird, your mails arrive on my end as empty body with attachment. I
>>>>>> first suspected Thunderbird, but I get the same result on the google
>>>>>> mail web client.
>>>>>>
>>>>>> Not sure why that happens.
>>>>>
>>>>> No idea. They look fine (except mangled links by outlook) on my outlook
>>>>> desk client and web client on my side. lore looks OK too:
>>>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/
>>>>
>>>> I can spot in the raw mail I receive
>>>>
>>>> "Content-Type: application/octet-stream; x-default=true"
>>>>
>>>> But that seems to differ to the lore mail:
>>>>
>>>> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/raw
>>>>
>>>>
>>>> Maybe something in my mail server chain decides to do some nasty
>>>> conversion (grml, wouldn't be the first time)
>>>>
>>>
>>> Weird thing is that this only happens with your mails. I opened an
>>> internal ticket, sorry for the noise.
>>
>> Zi's patch emails I received didn't have Content-Type, that might have
>> something to do with this. (But his reply later in the thread did have
>> one.) Also last week I got one patch email with no Content-Type either
>> and my Gnus decided to convert it to octet-stream, I guess to be on the
>> safe side. No idea if something similar is happening to you, but wanted
>> to mention it anyway.
> 
> Just to clarify, I assumed Gnus was doing the conversion to octet-stream
> but I never verified that.
> 
> Heh, interestingly enough that patch was sent from redhat.com:
> 
> https://lore.kernel.org/all/877d8eyz61.fsf@kernel.org/
> 
> Is that just a coincidence or are Redhat servers doing something
> strange? If you find out, do let me know. I'm very curious :)
> 

It is strange. Also mails from Andrew result in the same,
unusable/unreadable mails in my inbox. :(

Right now I assume that Mimecast servers try to auto-detecting and
adding "Content-type:", and somehow mess up. And I do think that it
doesn't always mess up; some patch content (encoding?) seems to trigger
that.


-- 
Thanks,

David / dhildenb

