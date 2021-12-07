Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54D246C6AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbhLGV17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhLGV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638912267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wn5kxaLGFOkCOE3vlVAq3FMKxlWOJF803iGWDpf7qyw=;
        b=RHXmZTDDrnX2s1EheIui9Dpcb+p8j3TqK2C7mMpRD6Iz2oJX1oP+CTEr0Gyyh7JeK+RC5F
        3b3eAB+JzEuUEMCV08a7qCJbJ3515yx7uSa2dN/BMhd7xlp0ghHmefYgX1fr6w11DNmZT1
        Or7bQo5C7RtOvck8J3/ZhS5sC6TFUXY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-GyTDXY-fPR2-6kj_2xPpGw-1; Tue, 07 Dec 2021 16:24:26 -0500
X-MC-Unique: GyTDXY-fPR2-6kj_2xPpGw-1
Received: by mail-io1-f71.google.com with SMTP id o11-20020a0566022e0b00b005e95edf792dso582448iow.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wn5kxaLGFOkCOE3vlVAq3FMKxlWOJF803iGWDpf7qyw=;
        b=yywKYJvzB8CRTgqdh6dl1MJkWzQqG8gmACASQ8djAxMSpT/qLuQui9huthcbXcAgLn
         74SIGW7YulwXZqehUGtuhJm4xRZsHMSNrLQ8L8DETqVpcNL7buJbE0tRLScH6rVIzC93
         nBU5FpapKox0c0se9MnS4JrY7nsQc5hGh1FT/duVT2llvdkQb8zG88IRJsnR3V91YN5P
         tNh6LzgAmD/3bM7yiEINlWxSr146U4iAKuoh03HI93dkpf5fPr4nBzm16aP1ssB9GJwf
         7q9D5mrVpwP7S7gYHDXWGvaKia1sfIrPp0OaOqlWYUsbqAKDF/kx9NSwZMmuF+ToDoe/
         4z1w==
X-Gm-Message-State: AOAM533bGz/Yi1DgRARjQqt8kG4DZuoqSqrMx6ZMdsd6J9/mMRz10Xmh
        GrWX4G+oVXP4UhkS5lWpeb1fQMHViA78qLGz89tU2ipKdNg8B3gMKDO1ubdFxBn5KsjZSPcwi2d
        ci58kvMf7gavFtEreUdDxEqJm
X-Received: by 2002:a05:6602:2c83:: with SMTP id i3mr2361762iow.54.1638912265538;
        Tue, 07 Dec 2021 13:24:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPpiZvgvkFBP4jYV9P3L95Lz+9Veit4KuNNxL4nYOgfZpNG3y+qSMJ3QgmydN2zLJlshtlYg==
X-Received: by 2002:a05:6602:2c83:: with SMTP id i3mr2361744iow.54.1638912265386;
        Tue, 07 Dec 2021 13:24:25 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id b8sm679453ilj.0.2021.12.07.13.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:24:24 -0800 (PST)
Message-ID: <09c3b733-974a-8672-b267-6be1f0b6009b@redhat.com>
Date:   Tue, 7 Dec 2021 16:24:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 1/2] include/linux/gfp.h: Do not allocate pages on a
 offlined node
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com,
        Rafael Aquini <aquini@redhat.com>
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-2-npache@redhat.com> <Ya3WZC1JWU5jdtlC@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <Ya3WZC1JWU5jdtlC@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 04:22, Michal Hocko wrote:
> On Sun 05-12-21 22:33:37, Nico Pache wrote:
>> We shouldn't allocate pages on a unavailable node. Add a check for this
>> in __alloc_pages_node and return NULL to avoid issues further down the
>> callchain.
>>
>> Also update the VM_WARN_ON in __alloc_pages_node which could skip this
>> warn if the gfp_mask is not GFP_THISNODE.
> 
> Page allocator trusts callers to know they are doing a right thing so
> that no unnecessary branches have to be implemented and the fast path is
> really optimized for performance. Allocating from an !node_online node
> is a bug in the caller. One that is not really that hard to make
> unfortunatelly but also one that is is not that common.

Thank you for your review,

That makes sense. I will drop this patch on my second posting to avoid any
performance regression.

Cheers,
-- Nico

> 
> That being said I am not really sure we want to introduce this check.
> 
>> Co-developed-by: Rafael Aquini <aquini@redhat.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>  include/linux/gfp.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index b976c4177299..e7e18f6d0d9d 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -565,7 +565,10 @@ static inline struct page *
>>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>>  {
>>  	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>> -	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
>> +	VM_WARN_ON(!node_online(nid));
>> +
>> +	if (!node_online(nid))
>> +		return NULL;
>>  
>>  	return __alloc_pages(gfp_mask, order, nid, NULL);
>>  }
>> -- 
>> 2.33.1
> 

