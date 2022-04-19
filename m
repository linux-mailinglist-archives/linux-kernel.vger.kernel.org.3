Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A56506CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbiDSM4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348523AbiDSM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24CBE3702E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650372801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFWX1fe131b/DTH6pn8hO6mxcNJSXq3lBnVZqFiI2qw=;
        b=i7STRNR5zcs4qOSNtnXaSFFAZRGCUkT8wSjLzbxEBb6+XS+dpKQV1Nc8nvvPubJhsG+oYz
        WsC62MIoS4VRK0AjavelErzzVeLuhY/Zjm7b/EsR+tmPBD7XyTp79gv14Bz0m1zuA36kn0
        sW1/91FcrgQZIwwxgpUcVGkq3nbXr+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-1bi_xdCHMKiMRBCKATsWUA-1; Tue, 19 Apr 2022 08:53:19 -0400
X-MC-Unique: 1bi_xdCHMKiMRBCKATsWUA-1
Received: by mail-wm1-f69.google.com with SMTP id b12-20020a05600c4e0c00b003914432b970so1180881wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=yFWX1fe131b/DTH6pn8hO6mxcNJSXq3lBnVZqFiI2qw=;
        b=DzhgcPoajwJOPxWwmaCi+DtYkRaO7CGPty79dT8D1vDLKqKineckj04ywqQYY9z3Vu
         JFUmYT3/uwv9gWfPAhlXBFquimG3eR9Fcrjn0EsGYyH4lf7ae6YnwG1pNXJ8Rg4P/Kxy
         K6NPFOi07hI6yb5WzYs4yD9PqrDUhcPcijq1+fJqfc7XVXr+01Fxby3JLN8B87XxopxH
         JbFg2k/Wzsr9HRPfEMBiGY5Z0Z9lc4pC2fq+CZouIbnKRx/pC8jHlIs+PL0mw0cISNnS
         zsF/KyaztKpRekMtmqm73Dm0rOTOKGnDSKKHYPNfzf7/kXd+VkPoiJ8kY3acMF8lIVmC
         zY3g==
X-Gm-Message-State: AOAM531Aruj5tQFV7vO1VV7295aGyg5YDPZHpQ0ZuNO4H+RiETyVL/vb
        oM5LBxz4kDfivTr3lR3CvO+dJR5PV/010rJycllUwgGj/bjoRDs2OYIW55KiBXDq2rCusDl9u5b
        TUqrck5CxlhSm5rkytDK+8O2G
X-Received: by 2002:a5d:4d82:0:b0:207:a0da:8f06 with SMTP id b2-20020a5d4d82000000b00207a0da8f06mr11711669wru.680.1650372798511;
        Tue, 19 Apr 2022 05:53:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw11mtYc4J0pW+3pLYQQcVXLgtbfYePDpNhRkKvYgk9JRVRFqGoRNPh8QMia8rDNSqj2C3OeQ==
X-Received: by 2002:a5d:4d82:0:b0:207:a0da:8f06 with SMTP id b2-20020a5d4d82000000b00207a0da8f06mr11711646wru.680.1650372798241;
        Tue, 19 Apr 2022 05:53:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id 3-20020a056000154300b0020a9dcac3c2sm4269185wry.20.2022.04.19.05.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:53:17 -0700 (PDT)
Message-ID: <1126a1ae-8eff-8962-4253-d6e430ecc892@redhat.com>
Date:   Tue, 19 Apr 2022 14:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/mmzone: Introduce a new macro
 for_each_node_zonelist()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, Donghyeok Kim <dthex5d@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220416132037.6395-1-dthex5d@gmail.com>
 <Yl1wO/cqNJYf0H7Y@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yl1wO/cqNJYf0H7Y@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.22 16:05, Mike Rapoport wrote:
> On Sat, Apr 16, 2022 at 10:20:35PM +0900, Donghyeok Kim wrote:
>> There are some codes using for_each_zone_zonelist() even when only
>> iterating each node is needed. This commit introduces a new macro
>> for_each_node_zonelist() which iterates through valid nodes in the
>> zonelist.
>>
>> By using this new macro, code can be written in a much simpler form.
>> Also, slab/slub can now skip trying to allocate from the node which was
>> previously tried and failed.
>>
>> Co-developed-by: Ohhoon Kwon <ohkwon1043@gmail.com>
>> Signed-off-by: Ohhoon Kwon <ohkwon1043@gmail.com>
>> Signed-off-by: Donghyeok Kim <dthex5d@gmail.com>
>> ---
>> V1 -> V2: Fix a compile error
>>
>>  include/linux/mmzone.h | 36 ++++++++++++++++++++++++++++++++++++
>>  mm/hugetlb.c           | 17 +++++++----------
>>  mm/mmzone.c            | 17 +++++++++++++++++
>>  mm/slab.c              |  7 ++-----
>>  mm/slub.c              |  8 ++++----
>>  mm/vmscan.c            | 16 ++++++----------
>>  6 files changed, 72 insertions(+), 29 deletions(-)
> 
> Even counting the comments this does not look like a great simplification.
> 

I tend to agree.


-- 
Thanks,

David / dhildenb

