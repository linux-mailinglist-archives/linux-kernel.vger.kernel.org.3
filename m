Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6C4F1310
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357208AbiDDK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357678AbiDDK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 461E13CA5B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649067962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ev9r8nw0gvvhZdLigMKa0VV1CoeFkIP8Q2gOXiOQYyE=;
        b=AzylU1fpWHnXCUf5VHUwONx1jttk7gI8nX1xVc4NT4JhWeBO4KxPnvGfs/QR+K6YhCVxGg
        Vr41g3oRIrsCu7i57lmyInBFP/F9Cgl18uzeqVh6j4UHvpMy4DjDtpTellILfOvShkXfUE
        78+yIzusHbUyRT34XINr71s/arNgTH4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-Lur7ZMw7OlaCk7D4PIwh2w-1; Mon, 04 Apr 2022 06:26:01 -0400
X-MC-Unique: Lur7ZMw7OlaCk7D4PIwh2w-1
Received: by mail-wm1-f69.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so6748468wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 03:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ev9r8nw0gvvhZdLigMKa0VV1CoeFkIP8Q2gOXiOQYyE=;
        b=ZrxzW+26qxtSzwJOgmuyw4VJUs8Ym0Z7x70Siy4BrRGdHiJL1syhocHUKoVagHH/le
         0YbamWNAM/0/ibGmE5+mthzgIQ8S9hq1HWS2dK7UAS/cbslj/1FieRn5Tyy0CsPNYZdq
         X+CAqhSV1fSPmPdWyh/gRV8IFCO187ljaT5zh41I7O2vBZvZ9iRO6oUv38jiwv2gyrgd
         YhPoM3K+Sfc9XpBWrRgY5vZRy29JIGfeTAFSP1bwmrukw2+6NnwyXCQQrqgqyBnUWMSs
         xMI2nrSfa0WjWsuKtk3K5hKwv68NPWuX5YEFWA9IRsd9u/+hkEh9IEiZTe6GJVD1Y0pk
         +yNA==
X-Gm-Message-State: AOAM530BJJ96939IBf3x1OiS0ncBIDvaYVuMreFBa0XTPYq84EhR+1oD
        4bBa+GYLKr7wrvXspRhYaM+UaC+cq+goHnzBOu1fcX0bBcG6i63odUn4xP2Hslu4s91dCeoCUFJ
        C9nLMOSXS36aunjfefOOayXiM
X-Received: by 2002:a5d:588c:0:b0:205:7f17:3901 with SMTP id n12-20020a5d588c000000b002057f173901mr16415374wrf.359.1649067960065;
        Mon, 04 Apr 2022 03:26:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDhOTNsjVxzvF6M18iw9IgWqrnWcRXuK4JSl6J/cMFyPw8GGHQFk4MgsKtAwVwBQYbv68K8A==
X-Received: by 2002:a5d:588c:0:b0:205:7f17:3901 with SMTP id n12-20020a5d588c000000b002057f173901mr16415358wrf.359.1649067959818;
        Mon, 04 Apr 2022 03:25:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4100:c220:ede7:17d4:6ff4? (p200300cbc7044100c220ede717d46ff4.dip0.t-ipconnect.de. [2003:cb:c704:4100:c220:ede7:17d4:6ff4])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm16523093wmb.15.2022.04.04.03.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 03:25:59 -0700 (PDT)
Message-ID: <314bea6d-a6ce-0c83-0b39-c9cda90a7281@redhat.com>
Date:   Mon, 4 Apr 2022 12:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/2] hugetlb: Fix return value of __setup handlers
Content-Language: en-US
To:     "liupeng (DM)" <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20220401101232.2790280-1-liupeng256@huawei.com>
 <20220401101232.2790280-3-liupeng256@huawei.com>
 <533f85f9-82e2-bfa7-3788-4b2a668daedf@redhat.com>
 <03d68ba4-0d8f-824b-8c4e-92c9cade6fef@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <03d68ba4-0d8f-824b-8c4e-92c9cade6fef@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.22 03:33, liupeng (DM) wrote:
> 
> On 2022/4/1 18:46, David Hildenbrand wrote:
>> On 01.04.22 12:12, Peng Liu wrote:
>>> When __setup() return '0', using invalid option values causes the
>>> entire kernel boot option string to be reported as Unknown. Hugetlb
>>> calls __setup() and will return '0' when set invalid parameter
>>> string.
>>>
>>> The following phenomenon is observed:
>>>  cmdline:
>>>   hugepagesz=1Y hugepages=1
>>>  dmesg:
>>>   HugeTLB: unsupported hugepagesz=1Y
>>>   HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
>>>   Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
>>>
>>> Since hugetlb will print warn or error information before return for
>>> invalid parameter string, just use return '1' to avoid print again.
>>>
>>> Signed-off-by: Peng Liu <liupeng256@huawei.com>
>>> ---
>>>  mm/hugetlb.c | 18 ++++++++----------
>>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 9cd746432ca9..6dde34c115c9 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4131,12 +4131,11 @@ static int __init hugepages_setup(char *s)
>>>  	int count;
>>>  	unsigned long tmp;
>>>  	char *p = s;
>>> -	int ret = 1;
>> Adding this in #1 to remove it in #2 is a bit sub-optimal IMHO.
>>
> For #2, which is not necessary for stable, #1 may be needed for stable,
> this is why we split #2 into a single patch.
> 

Again, I don't think #1 is stable material, sorry.

-- 
Thanks,

David / dhildenb

