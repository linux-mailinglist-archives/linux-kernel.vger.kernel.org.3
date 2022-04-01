Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A674EEBB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbiDAKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344960AbiDAKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D27492493FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648809794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4pBRJ5YN5a24OMJIf40rb52pBXc7gp40076N5cz8GU=;
        b=SLEbSpuk0w46PFkb0Wo2+bMnIhsz42yAB/tl0PGZzPqATTs8ME5OEAoqWOIrnrA4dzxvAc
        MYngs/tK10L9E8vPrPd+wZSEYbkC1gZfTA6Cvu6nv6NULEQazfmjOeoCpkIyYXhjQ3jWeu
        GpMf8tDN6H3fnl7EAKuuv+qHiJ2Upd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-NjfXgTzgMBe3VULUqVVJmg-1; Fri, 01 Apr 2022 06:43:13 -0400
X-MC-Unique: NjfXgTzgMBe3VULUqVVJmg-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso995023wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+4pBRJ5YN5a24OMJIf40rb52pBXc7gp40076N5cz8GU=;
        b=gqjJFBttLOij+y/3UGieSgJrlVt96HkHvl/H0ddBJlqjmvmiBuwJUNH/V2J0/16QTW
         CSWnhq8w/1RDVuksDH718gcdmLIYW5AqO6z5eJamh5nrUj4lGjDp/y4OUqEND1vAdeDH
         ZFv1gD+LwcTG+qYfzAfY/fjcuUcCU8K9Dz2moI78bFzTLsNWpicJwpJIpPAvsHC8TzzF
         lolqBGPXi1ni9JB1ml0FEWqxpPiLGMEmfoIQfW5Lz2K/ocHedgBQPX1nEEjmLhJ8qeb4
         PNPk9DtAPxvu2Iuy2UkiL97hhK+nLhYMLBDLCnaFCgc84E+vsHby/x0BOm00PFiCV2xT
         P5BA==
X-Gm-Message-State: AOAM532yse603OlvdKuljcC7ecYpsSuWHalnavvaPDNdioJaU+sl30bP
        QGgojBXGd4EsCxi/up24ZfvDFLL/NZmRXY1tNhKjttjvM9fME8fOzAbCY9S1imkRPE5T8zo7fnx
        BJ7uzCS7tED/kJZbecuf2o7pl
X-Received: by 2002:a05:600c:2192:b0:38c:8b45:ecf5 with SMTP id e18-20020a05600c219200b0038c8b45ecf5mr8320504wme.85.1648809791888;
        Fri, 01 Apr 2022 03:43:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRTBc25bk4mXGUimWBG0gQaL17FMWYkZ/3pdWCRPJysHyjJZ+NIDT/7uYxgPkQaxE1+XJR8A==
X-Received: by 2002:a05:600c:2192:b0:38c:8b45:ecf5 with SMTP id e18-20020a05600c219200b0038c8b45ecf5mr8320486wme.85.1648809791602;
        Fri, 01 Apr 2022 03:43:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9e00:229d:4a10:2574:c6fa? (p200300cbc7069e00229d4a102574c6fa.dip0.t-ipconnect.de. [2003:cb:c706:9e00:229d:4a10:2574:c6fa])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600018aa00b002042a98168csm2125388wri.15.2022.04.01.03.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 03:43:11 -0700 (PDT)
Message-ID: <0aefbc18-4232-0bae-b37a-d4c6995e3d00@redhat.com>
Date:   Fri, 1 Apr 2022 12:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/2] hugetlb: Fix hugepages_setup when deal with
 pernode
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20220401101232.2790280-1-liupeng256@huawei.com>
 <20220401101232.2790280-2-liupeng256@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220401101232.2790280-2-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 12:12, Peng Liu wrote:
> Hugepages can be specified to pernode since "hugetlbfs: extend
> the definition of hugepages parameter to support node allocation",
> but the following problem is observed.
> 
> Confusing behavior is observed when both 1G and 2M hugepage is set
> after "numa=off".
>  cmdline hugepage settings:
>   hugepagesz=1G hugepages=0:3,1:3
>   hugepagesz=2M hugepages=0:1024,1:1024
>  results:
>   HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
>   HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages
> 
> Furthermore, confusing behavior can be also observed when invalid
> node behind valid node.
> 
> To fix this, hugetlb_hstate_alloc_pages should be called even when
> hugepages_setup going to invalid.

Shouldn't we bail out if someone requests node-specific allocations but
we are not running with NUMA?

What's the result after your change?

> 
> Cc: <stable@vger.kernel.org>

I am not sure if this is really stable material.

> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

-- 
Thanks,

David / dhildenb

