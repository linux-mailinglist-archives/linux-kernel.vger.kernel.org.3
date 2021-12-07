Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60F46C6EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhLGVsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241958AbhLGVsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638913507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAI5JnG1T3Xc8dsK0F9qlNVnynQkpY3/ReLlmQqCN6k=;
        b=Bpv9beXMW/sWebdW6JTXSVWO7QCPoTz4Csov6yRUQWh3qPaXKkgtjg8/ms0zPvtarwPau+
        uxCOEioskQEpSc1ZlqsBY+YWnt9ociCkjF3Flt/TGnUjoKzTUva+E5/BXKENyzY4RV1iKb
        hor/ff2oqCinpaY5c20Z78WQCmOZEQg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-89-eEgyVcoDOrCmSksTiHHldw-1; Tue, 07 Dec 2021 16:45:05 -0500
X-MC-Unique: eEgyVcoDOrCmSksTiHHldw-1
Received: by mail-il1-f197.google.com with SMTP id y3-20020a056e021be300b0029f6c440695so525804ilv.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wAI5JnG1T3Xc8dsK0F9qlNVnynQkpY3/ReLlmQqCN6k=;
        b=AW8xlq5KaYqdQRvD+wwodalS9+Xxwv/3/JATTi6/w8NHpsbOfSFfOOYjGazJ4AP1Eb
         0Uu160IEUvXeEgPyxdgdeWtVI3O8twOqbriREpFIr56rzxus4PXQEQWWnbbViSBmbAhI
         SCKmU1xxjaiXpIt3QTtmvTHqLN91YPdCCJ00guL8ifnYU8BjyrCvGmkJ+TKG2JDI+9yM
         pETWqVxPmVdy0iZQH8026OpL6R6Vc7vkIXYbjJuJVi+exFDC3Q3Y2K5/RzWPyNv4onTo
         bPye74eMfDo/oJiuO1Sj/knncNLZzcYCU50ghbrQYMjcjx8Z/+drW+ueC6STX0LcGOMR
         Gy1Q==
X-Gm-Message-State: AOAM533o480NhvTtc8m1CmWoIbMtRt9WY+RvIgxFPHoHgfly59WAIuPI
        XH7s8OmIfn37EKFtqJK8L9MjT1abDnutKsiBlrTJfJv8ZRXV4ZJsW2iFocf+ThLq3CBSqXL0Nvc
        6XPOkC//0lx1S+QYaIy6vrnvU
X-Received: by 2002:a92:cd8a:: with SMTP id r10mr2266897ilb.188.1638913504614;
        Tue, 07 Dec 2021 13:45:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMYHZCsw1EHLrPo28/eQFU7UdFKfesrmnc9NhTiTFBVkdcv5Jmy5Sdnopv1qfJC/LlSL2ahw==
X-Received: by 2002:a92:cd8a:: with SMTP id r10mr2266880ilb.188.1638913504462;
        Tue, 07 Dec 2021 13:45:04 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id p7sm532774ils.4.2021.12.07.13.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:45:04 -0800 (PST)
Message-ID: <ba4d3fd5-b64e-ce61-379e-27ae84a89cfd@redhat.com>
Date:   Tue, 7 Dec 2021 16:45:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        shy828301@gmail.com, guro@fb.com, vbabka@suse.cz,
        vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 08:19, Kirill Tkhai wrote:
> On 06.12.2021 13:45, David Hildenbrand wrote:
>>> This doesn't seen complete. Slab shrinkers are used in the reclaim
>>> context. Previously offline nodes could be onlined later and this would
>>> lead to NULL ptr because there is no hook to allocate new shrinker
>>> infos. This would be also really impractical because this would have to
>>> update all existing memcgs...
>>
>> Instead of going through the trouble of updating...
>>
>> ...  maybe just keep for_each_node() and check if the target node is
>> offline. If it's offline, just allocate from the first online node.
>> After all, we're not using __GFP_THISNODE, so there are no guarantees
>> either way ...
> 
> Hm, can't we add shrinker maps allocation to __try_online_node() in addition
> to this patch? 
> 
Thanks for the feedback :) I am currently working a solution similar to this.

