Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850F852983E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiEQDcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiEQDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:32:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85ED3D1ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:32:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so29064696lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ER2JX2zn+fukFDj6cClopw15+MZZU+3In4sQBn9YEFk=;
        b=NGkGnmfB5hvf424RmyFYy0K3036u5k8OG3f+rE/p8W6RGg8LrqLjoJxzhtgxQyotps
         5iy548Kd43P0+luHulBEo7p59aoSKmB5FhinQ1LWqfQQ8/ynOgjgb1/+Uep1XAuI5cxR
         HgcmxcXE1cGRyXj36GkUFF++kXN+XchmJqgFSu940B8AqNajhzliO237KUje42Yp6z8N
         578LoRGdb6BrtYVYr8vLUjUXkA5a17N90mV6LZdi/V8tsxEeHjPBySZrhykMpctrnUoF
         88Gy9aMJYmgqpy3RyNWQ3Xz/1JG2DpE1J81w/ZL6w9PDRjaOeT4tQIl4HwFIiyQQIU6c
         KXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ER2JX2zn+fukFDj6cClopw15+MZZU+3In4sQBn9YEFk=;
        b=RKcidsBPIJqH96lVGClzhQyKbDO5Qv/t/pSiUR0LZEUKbsT1eBUL1XFHvkqr+ayHRC
         kUlWgFzr+F8DVAQdbtdFBuosZfzpq9j54AUTR0kkO2Z4kBYZ52QCCV6J79CWvup7OkeR
         h9kWTihcklHyIBcuKmnm6sRhzIF9ZdM99D06KOygR+EKovzEkEx0zSVVTXUHKlHIoDIK
         0ANnh12ILTbKa8jdvucdGM+mwg0xcTym/RV+NMihaN4pphZCFmJNlUJCkzNwtnQXkQmS
         QU0v5n14vUed1/iiytIZ+NKbL6wMyp+MIR32fMX+gNRVPA6ETSMS4bDaCVEbrSiiI2Lo
         dFXQ==
X-Gm-Message-State: AOAM530mfXUvjrnOmZV3LFqWIGJJYkTAcOZ1EKW3kcX79CTVdBxJBzO7
        +cNA5Kf1TzD7YWPbTnWFaVdHhA==
X-Google-Smtp-Source: ABdhPJx1INatyM5mlT8qQoY5ZCm2wYSuDesHOSmXNYRGYANspxQpW5ceCyQ+Pj0YWrDX9n1p5BqKdw==
X-Received: by 2002:a05:6512:ba9:b0:477:9e15:a6ec with SMTP id b41-20020a0565120ba900b004779e15a6ecmr1639004lfv.315.1652758350166;
        Mon, 16 May 2022 20:32:30 -0700 (PDT)
Received: from [192.168.1.72] (46-138-221-128.dynamic.spd-mgts.ru. [46.138.221.128])
        by smtp.gmail.com with ESMTPSA id x4-20020a2e9c84000000b0024f3d1dae8esm1746972lji.22.2022.05.16.20.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 20:32:29 -0700 (PDT)
Message-ID: <0aaf7b6d-6ed7-45ca-873e-394718f73c9a@openvz.org>
Date:   Tue, 17 May 2022 06:32:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel@openvz.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
 <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 22:10, Shakeel Butt wrote:
> On Mon, May 16, 2022 at 11:53 AM Vasily Averin <vvs@openvz.org> wrote:

>> +++ b/mm/slab.c
>> @@ -3492,6 +3492,9 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
> 
> What about kmem_cache_alloc_node()?

Thank you for the hint, I was inaccurate and missed *_node.

>>  {
>>         void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>>
>> +       if (cachep->flags & SLAB_ACCOUNT)
> 
> Should this 'if' be unlikely() or should we trace cachep->flags
> explicitly to avoid this branch altogether?

In general output of cachep->flags can be useful, but at the moment 
I am only interested in SLAB_ACCOUNT flag and in any case I would
prefer to translate it to GFP_ACCOUNT.
So I'm going to use unlikely() in v2 patch version.

>> +               flags |= __GFP_ACCOUNT;
>> +
>>         trace_kmem_cache_alloc(_RET_IP_, ret,
>>                                cachep->object_size, cachep->size, flags);
>>

Thank you,
	Vasily Averin
