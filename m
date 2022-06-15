Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607F54C363
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiFOIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243698AbiFOIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74A78286EE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655281274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81h1Uc0DDfOP7V1sbgrcsSnTyG++26Urw3Gv8Z70W2M=;
        b=T+qtPXVU7Jf/JXD286dNspuHLQpqbo3Y2IQWaaJZzBJMmE3Sy7HebIjxEbtLAM8JoZZSYi
        HhsbzlPxs71+P0Q3R8VKKAdj5QtR8n5Wd2Hiyqjbe7Ud7whE8a+vhWQUoO1PlvmtLXm1tc
        zrTCnfYrZDfz/ADtIHoqDUREL+wbsps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-aDxm7oAtOTeu2opLG9vImw-1; Wed, 15 Jun 2022 04:21:11 -0400
X-MC-Unique: aDxm7oAtOTeu2opLG9vImw-1
Received: by mail-wm1-f70.google.com with SMTP id p18-20020a05600c23d200b0039c40c05687so4795085wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=81h1Uc0DDfOP7V1sbgrcsSnTyG++26Urw3Gv8Z70W2M=;
        b=rqXSU4cZfAiwnz0IZQm5OWiOoTY6uECFTTark9r4G4PTw5WkyIuRmSqXz7ZqSmiFOZ
         grZt1ARJP2ot0sAKxT1EKQcxh6uj2XNOG59DQ4yBF9Zu92hx3kuDUtF1Qz0lSXPy+AnQ
         slyVrbLMxd2YPOiyEmuZposm0JDelH1FcKRJORUcpBdf3VOEwkxszpNW5+QgLZ8djzjV
         T8gyhTTpBOrfuIFMgGavNo1RiHTDzZrNRkUNcDFOTdCbHIOHQgVw+sdD3uAQst45SMVx
         Xmq4HjH3K+spKPFp7hSTbPXdQCcVUVoHkN2dcAJCwmj4Alng9l+kVuOgR9EotnDtrJDm
         JM5Q==
X-Gm-Message-State: AOAM533jUGkidzZfk5ROn2Q+55BxaJglMUx4FYyfpVsHgqzMywCYex2r
        rEP+KMVrPMk8Vl6DyazveVZ/21UvsvHMNEBXZbZbPBauV2lejfz6YpnHjtoLuJzwWlwicQUJ8Ct
        8DX4a1Qfm71OL420Ao31LefuQ
X-Received: by 2002:a7b:c1d4:0:b0:39c:4176:6a16 with SMTP id a20-20020a7bc1d4000000b0039c41766a16mr8620509wmj.8.1655281270585;
        Wed, 15 Jun 2022 01:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiAHKZyyHKCcb/92H2dDkxhfvHYpAh2o2kpsFcIcKAsR4XkO0uaAo1YCVuBIicAlN7G2glFQ==
X-Received: by 2002:a7b:c1d4:0:b0:39c:4176:6a16 with SMTP id a20-20020a7bc1d4000000b0039c41766a16mr8620483wmj.8.1655281270305;
        Wed, 15 Jun 2022 01:21:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:2700:1d28:26c3:b272:fcc6? (p200300cbc70a27001d2826c3b272fcc6.dip0.t-ipconnect.de. [2003:cb:c70a:2700:1d28:26c3:b272:fcc6])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000008500b00213d75491b0sm13817986wrx.48.2022.06.15.01.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 01:21:09 -0700 (PDT)
Message-ID: <425e44e9-6ec3-9a87-3441-78881f561a06@redhat.com>
Date:   Wed, 15 Jun 2022 10:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/1] mm/memory-failure: disable unpoison once hw error
 happens
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, zhenwei pi <pizhenwei@bytedance.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20220615020005.246295-1-pizhenwei@bytedance.com>
 <20220615020005.246295-2-pizhenwei@bytedance.com>
 <20220615081521.GB1663556@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220615081521.GB1663556@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.22 10:15, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Jun 15, 2022 at 10:00:05AM +0800, zhenwei pi wrote:
>> Currently unpoison_memory(unsigned long pfn) is designed for soft
>> poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
>> cleared on a x86 platform once hardware memory corrupts.
>>
>> Unpoisoning a hardware corrupted page puts page back buddy only,
>> the kernel has a chance to access the page with *NOT PRESENT* KPTE.
>> This leads BUG during accessing on the corrupted KPTE.
>>
>> Suggested by David&Naoya, disable unpoison mechanism when a real HW error
>> happens to avoid BUG like this:
> ...
> 
>>
>> Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
>> Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> 
> Cc to stable?
> I think that the current approach seems predictable to me than earlier versions,
> so I can agree with sending this to stable a little more confidently.
> 
>> ---
>>  Documentation/vm/hwpoison.rst |  3 ++-
>>  drivers/base/memory.c         |  2 +-
>>  include/linux/mm.h            |  1 +
>>  mm/hwpoison-inject.c          |  2 +-
>>  mm/madvise.c                  |  2 +-
>>  mm/memory-failure.c           | 12 ++++++++++++
>>  6 files changed, 18 insertions(+), 4 deletions(-)
>>
> 
> ...
> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index b85661cbdc4a..385b5e99bfc1 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -69,6 +69,8 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
>>  
>>  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>>  
>> +static bool hw_memory_failure;
> 
> Could you set the initial value explicitly?  Using a default value is good,
> but doing as the surrounding code do is better for consistency.  And this
> variable can be updated only once, so adding __read_mostly macro is also fine.

No strong opinion. __read_mostly makes sense, but I assume we don't
really care about performance that much when dealing with HW errors.

With or without changes around this initialization

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

