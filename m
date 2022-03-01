Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A982F4C888E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiCAJyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiCAJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:54:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD60A7C16B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646128408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4oRUxyIudwvhVVrS54YaQp6VJMJXHr3tnh94n7twRo=;
        b=N3Yk1BbWQfpO1ZOECgCEmlMln8g/GnbwEbn8bdXmWNuHZ9Efh2Yk7cwE81HrkGw64aSRlL
        xkxLcujnoHFP9UQAknXJu+gc1cIpAOjxB5G9qkoG1+ZJHKdTL+HypTNQ/YvV11du0NxhX1
        q6bIfblef6+4gil9E6UoxKxnKXJVHAM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-9jZeg2SlPGaWx7tHWifn2w-1; Tue, 01 Mar 2022 04:53:27 -0500
X-MC-Unique: 9jZeg2SlPGaWx7tHWifn2w-1
Received: by mail-wm1-f71.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so737943wma.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 01:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=o4oRUxyIudwvhVVrS54YaQp6VJMJXHr3tnh94n7twRo=;
        b=CBiCu3RB71nQUAJgbqYZjuXJ8DhKcPibZRn8rfrYSTUc2sW+RO/K0iYrwvs/AhlGzo
         YbuiwK/mb+2mt6IRqk4nzPshZDuD+l5lHC1ai9qGWYuBty9KUIq+a0oTShaxlJNNMTWO
         e+DRYvhyW6y/HFg/hSxkUxJghRhnNq7vJPnkhZheZMcJjIOkLhTKKPJeW9Smt9k760F2
         yWiFUpmfa3Ujl+eHyoRHCAiEb4s6dH8Unok1r9grkzgNe4InMUazjYaTk7xWB6NV7F+w
         PdQnuu17ATBfbSWi7FxJWyfEy5q9gZLHXt/YAY4xdHk4XeQLGz27RI94mUZsnDgRemHj
         r2WA==
X-Gm-Message-State: AOAM531jxp4u7yzpy2jvqLhaBb2vFTpJOnoLsbr7I+GASly6sn+F0hEU
        ipvom7QWFFb+npL9VeP4eh6gHJY75gk1gM56hRfej7ASwdyHjWsLm2xXmebHBzH+o8bqS3FvTnk
        HfLclpEgkx1x583MnE3dm5314
X-Received: by 2002:adf:eb11:0:b0:1ef:ca9b:7bd9 with SMTP id s17-20020adfeb11000000b001efca9b7bd9mr7128684wrn.125.1646128406486;
        Tue, 01 Mar 2022 01:53:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzi4JCao71n6SvZQPj7T+De0HoitkMQverTg8yxnxgSWl7qGbndd3ReprpyccF7QVyCtMYWvA==
X-Received: by 2002:adf:eb11:0:b0:1ef:ca9b:7bd9 with SMTP id s17-20020adfeb11000000b001efca9b7bd9mr7128677wrn.125.1646128406274;
        Tue, 01 Mar 2022 01:53:26 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm2821572wmq.35.2022.03.01.01.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:53:25 -0800 (PST)
Message-ID: <4307e915-ac24-58bc-23ad-7e94e2b37170@redhat.com>
Date:   Tue, 1 Mar 2022 10:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC] mm/memory-failure.c: fix memory failure race with
 memory offline
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220226094034.23938-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220226094034.23938-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.22 10:40, Miaohe Lin wrote:
> There is a theoretical race window between memory failure and memory
> offline. Think about the below scene:
> 
>   CPU A					  CPU B
> memory_failure				offline_pages
>   mutex_lock(&mf_mutex);
>   TestSetPageHWPoison(p)
> 					  start_isolate_page_range
> 					    has_unmovable_pages
> 					      --PageHWPoison is movable
> 					  do {
> 					    scan_movable_pages
> 					    do_migrate_range
> 					      --PageHWPoison isn't migrated
> 					  }
> 					  test_pages_isolated
> 					    --PageHWPoison is isolated
> 					remove_memory
>   access page... bang
>   ...

I think the motivation for the offlining code was to not block memory
hotunplug (especially on ZONE_MOVABLE) just because there is a
HWpoisoned page. But how often does that happen?

It's all semi-broken either way. Assume you just offlined a memory block
with a hwpoisoned page. The memmap is stale and the information about
hwpoison is lost. You can happily re-online that memory block and use
*all* memory, including previously hwpoisoned memory. Note that this
used to be different in the past, when the memmap was initialized when
adding memory, not when onlining that memory.


IMHO, we should stop special casing hwpoison. Either fail offlining
completely if we stumble over a hwpoisoned page, or allow offlining only
if the refcount==0 -- just as any other page.


-- 
Thanks,

David / dhildenb

