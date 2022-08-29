Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045325A4C02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiH2MgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiH2Mfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F26C76758
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661775542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHsCu4PSGMMuSAfnOsJ7Dba+vX8wHbqdb2+wxTgeECc=;
        b=C+/jGpR7SMIbzeKG0HmJ5fdCplQQuOQwD6Bh0xoXoCsZupke1mUD9WkZ26UeXoH0Kchbut
        Z5EpgJYRean6JilBnq9bNXUQQjXUKJEjAbuPqmfGQ/e7igYDOYJRicRzasp6xQJfnfhCBS
        /K+mK1S7Zbj2t6cBBm2Ni1x3uc8sXRE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-n8K6ltZENsuUwsbsulnpDA-1; Mon, 29 Aug 2022 08:19:01 -0400
X-MC-Unique: n8K6ltZENsuUwsbsulnpDA-1
Received: by mail-wm1-f72.google.com with SMTP id c25-20020a05600c0ad900b003a5ebad295aso1222517wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=qHsCu4PSGMMuSAfnOsJ7Dba+vX8wHbqdb2+wxTgeECc=;
        b=0BmBqW1a/w38q5ldV/yXaGxmwKMJql2c1Zo06N9kGMq24S6Adp8LlisOiNKmZY+5aw
         z5sIa3c3zVFH7Xl5+jqj6XpfyyowpyWkaXWLDxaQUtwC2BEbT2odj3oEF/iISdE78G1V
         vzdo+5yDH3/q9a/MGA3sLMB3RgqfpEzRwwFbMKOu2vxzljsDf0RlqNZVrxt85sUcg6ze
         gt7qOvrD2RTuH5ixd0FbZgaHYBXXryEWIAv9yMYyEQZWcwu8RxnuJ5yS/wRgp23vE4fe
         wBsce945RZVnI0OKo9hSe5T0914nHuZayPY+GYYyynLkTCVk+KicUljGMfne10WLCxXz
         mLAA==
X-Gm-Message-State: ACgBeo3/CjHtpdz0eCExp1b+bCxjdv0XgV3adiU4MIQbqdz+YuBa+BFH
        3Ev8Dq92bnV9qpcRBMb+v5jU1CXh0RUEqSAg6+/eQR/tUD4HjbXPxwdUTUK9gK0K3OSwBxin054
        nY9Do9WZCLHpU0Hm5D1E7FxbU
X-Received: by 2002:a05:600c:4148:b0:3a5:4f94:577b with SMTP id h8-20020a05600c414800b003a54f94577bmr6847178wmm.167.1661775540284;
        Mon, 29 Aug 2022 05:19:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR566u8yQL/dsHj6E0xJFg9T/xKNBx103f42nGS1y+P4fOgxuaxBGSCYrKHG6wpysCcd27sWAw==
X-Received: by 2002:a05:600c:4148:b0:3a5:4f94:577b with SMTP id h8-20020a05600c414800b003a54f94577bmr6847159wmm.167.1661775539960;
        Mon, 29 Aug 2022 05:18:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:658b:bed0:4260:4c25? (p200300cbc7073900658bbed042604c25.dip0.t-ipconnect.de. [2003:cb:c707:3900:658b:bed0:4260:4c25])
        by smtp.gmail.com with ESMTPSA id w17-20020a5d6091000000b002237fd66585sm6874586wrt.92.2022.08.29.05.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 05:18:59 -0700 (PDT)
Message-ID: <12759ac7-4a6c-89fa-5fd0-914728f6415e@redhat.com>
Date:   Mon, 29 Aug 2022 14:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm: skip reserved page for kmem leak scanning
Content-Language: en-US
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
References: <1661483530-11308-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznH=Gwr_TDF3=fv+_ZH5P4QN6JXEAtH4DAzNus20pHxyeg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAGWkznH=Gwr_TDF3=fv+_ZH5P4QN6JXEAtH4DAzNus20pHxyeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.22 05:23, Zhaoyang Huang wrote:
> On Fri, Aug 26, 2022 at 11:13 AM zhaoyang.huang
> <zhaoyang.huang@unisoc.com> wrote:
>>
>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>
>> It is no need to scan reserved page, skip it.
>>
>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> ---
>>  mm/kmemleak.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index a182f5d..c546250 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1471,7 +1471,7 @@ static void kmemleak_scan(void)
>>                         if (page_zone(page) != zone)
>>                                 continue;
>>                         /* only scan if page is in use */
>> -                       if (page_count(page) == 0)
>> +                       if (page_count(page) == 0 || PageReserved(page))
> Sorry for previous stupid code by my faint, correct it here

Did you even test the initial patch?

I wonder why we should consider this change

(a) I doubt it's a performance issue. If it is, please provide numbers
    before/after.
(b) We'll stop scanning early allocations. As the memmap is usually
    allocated early during boot ... we'll stop scanning essentially the
    whole mmap and that whole loop would be dead code? What am i
    missing?

-- 
Thanks,

David / dhildenb

