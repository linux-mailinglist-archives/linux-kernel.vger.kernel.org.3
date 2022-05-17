Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52052986A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiEQDtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEQDtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:49:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B84506C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:49:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h29so29151628lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lGiz4p3kxgbMH9lusf5BWvhTcTAA3XuA7I+cyo20aFU=;
        b=KGPssm/7bmpN1DTbVssXvg9tm6OfO3jm9NFcr2pufN/1/sLBZUGaDWghu23RRa/0Zn
         x/x0exYJZInOQCGV9Lxc8XiA7JL10BxrgMGhO/zAwUYwkfbY1IVdTtrz9bYhCYkyhBCM
         VqeWzGjmxZalZh6UDw5GOE69mpmcAFuYsicwAbdaR8+roNrFH7Cz1dqO8BAreDSGyEaJ
         QZ3KjARK6ZBMibp6AMrxKzm9s24jI+xrU/rFGdu249zu75LTLWKiaffd3YiYHxmQVX8h
         ECfhmLQ4NXgBHPBctbSBq3ZcV+TiCjSxE9p46x6mG03JYiBu6nGbDPH++ZvXu0AagmZ0
         WdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lGiz4p3kxgbMH9lusf5BWvhTcTAA3XuA7I+cyo20aFU=;
        b=0xTijEM01llRZ4Q8+M/If+8TDFN7uzopruddL/UJLppVKfxmuc1vSrYq5qU9/VTFMA
         q4QaWj0KLdJ+PjhLhpnIV8EKyjh2BnfUGDWwpraOtGkF5LpvkkwCJH5RWZbfIhnuVAGQ
         kmXk9fa4PrgcIv2aEGPqSdE0VCtPSSbNB2EXGN2VbwIeS/jvYM6yglA17FCs64vQKESm
         pwTwTzr+GUl6ZHL8JOl2p78o53NZcrNSac+lqIlwXGQ/ykGbRIFNEXg9LpEhYQUKa1oc
         uyz0hIrxuuJFXLf16uLneR1KJYnkYrOR4sEpMEm8pdAoyL8ZDjsLyMWYHn4A1UTFY4Uw
         zasw==
X-Gm-Message-State: AOAM530v1Q+66PqJnVZmV3wAJW82aUlJHpmMtwax8GeydbDJ5ZNvTz8m
        Z6JvmQCvjyy9OC12ccJPm+1uMA==
X-Google-Smtp-Source: ABdhPJxOHUcBQrR1cJ96BRB3ARHbqZ3B+VU/xSoanrIBMJQJ59fSC2XfpV+rK/KpaxxjhuCX0GtHMQ==
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id y19-20020a0565123f1300b00464f55f7806mr16024479lfa.598.1652759346146;
        Mon, 16 May 2022 20:49:06 -0700 (PDT)
Received: from [192.168.1.72] (46-138-221-128.dynamic.spd-mgts.ru. [46.138.221.128])
        by smtp.gmail.com with ESMTPSA id 27-20020ac25f5b000000b0047255d210desm1468420lfz.13.2022.05.16.20.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 20:49:05 -0700 (PDT)
Message-ID: <768859b4-5cae-4e16-1d9c-8b78a7b36ced@openvz.org>
Date:   Tue, 17 May 2022 06:49:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] tracing: add ACCOUNT flag for allocations from marked
 slab caches
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel@openvz.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <1fd21e25-b095-e055-fc2e-abda640a0575@openvz.org>
 <CALvZod6wmxxigoLVg8Q+upqOkyoh+nPuVT0yx_XTbu8RXYYFgA@mail.gmail.com>
 <8eccb3bc-e6b1-354b-e1de-bd3d896dcb35@suse.cz> <YoLLcFFi5UXFEIYg@carbon>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YoLLcFFi5UXFEIYg@carbon>
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

On 5/17/22 01:08, Roman Gushchin wrote:
> On Mon, May 16, 2022 at 11:41:27PM +0200, Vlastimil Babka wrote:
>> On 5/16/22 21:10, Shakeel Butt wrote:
>>> On Mon, May 16, 2022 at 11:53 AM Vasily Averin <vvs@openvz.org> wrote:
>>>>  {
>>>>         void *ret = slab_alloc(cachep, lru, flags, cachep->object_size, _RET_IP_);
>>>>
>>>> +       if (cachep->flags & SLAB_ACCOUNT)
>>>
>>> Should this 'if' be unlikely() or should we trace cachep->flags
>>> explicitly to avoid this branch altogether?
>>
>> Hm I think ideally the tracepoint accepts cachep instead of current
>> cachep->*size parameters and does the necessary extraction and
>> modification in its fast_assign.
> 
> +1 for fast_assign
> 
> Changing flags just for tracing looks a bit excessive.

At the kmem_cache_alloc and kmem_alloc use the same tracing template.
Ok, I'll try to redesign this.
