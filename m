Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0665236BF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbiEKPLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245605AbiEKPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E8EF5A16D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652281881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39RuDmaNXDQBWH0X/kkcsp5HOrtgFjXcurofW9ePNCM=;
        b=cZDez6dq8JlgfyTG/BZrVg5VfeI5OO1jQaQ6b2bAfMZDExqkc0y71cIMpiX3SM0v9imZ/n
        i/Qjd92wGtNTiJBXlv9ekDmcSP+dwe/AARg1B5a/L5PW5ZoihHEAqjwpxj40h+UXcFUpu6
        VAzIP9wpvmYCsd4wroWTseKD4x8U42I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-Xbqf-21QNTafiAGkvraN5Q-1; Wed, 11 May 2022 11:11:20 -0400
X-MC-Unique: Xbqf-21QNTafiAGkvraN5Q-1
Received: by mail-wm1-f71.google.com with SMTP id o24-20020a05600c379800b003943412e81dso803311wmr.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=39RuDmaNXDQBWH0X/kkcsp5HOrtgFjXcurofW9ePNCM=;
        b=mmJCfvLt6BKSgd3HZ8bhqnii9+mxbMUnvhsE8COGaE2UT814G7cw4091dNoZFwe5AQ
         g8+RJyXdCuzoODJr8ZHra/8eQ6y0Bq0xUKfrJtz0IJJZ1Yk1E2UjKaJTiZGv+kJSRgLT
         NBTPs9FZKmkobnXTKacFCNulgc80cojjn6BwpFLWqUC7CLXX7X16lrgnWg9AQrDOm0nm
         2A/dBlgXs4eY3PXTjMDeZOh6HCPKLzCPufU6FK0QN1Q2kRe1pc/dwF3Y87o3+8/R+UPO
         7Ma2o4LC5EAez5DRu0WDS16HqegcEAUhS5lZ21Y0oe+JNk7NSkNGlG4foOKQQ6ofYyJG
         62DQ==
X-Gm-Message-State: AOAM5301VGi8KZfJRGUywTnLe1/Qw1CzC/5ruYQSEfchhhwi2XmL2Ghd
        V3z1fwS0EF5JcKIj8sLzdn4pUCMSOWC5iKUWHhc0GWUdnXIg1I5hR+ncqY6jX+Kq7orpKBbc56e
        UdBhKkvu2SzZB09mlHPAFDMAR
X-Received: by 2002:a05:6000:178d:b0:20c:5bfd:4d7d with SMTP id e13-20020a056000178d00b0020c5bfd4d7dmr23049801wrg.23.1652281879117;
        Wed, 11 May 2022 08:11:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxsf9oFM7Gk42CfSx1fKwFraAW0U7qz+SidUX3vN/Bplz5t0edJ1yw0cEoY4YS/Cm/duWrAA==
X-Received: by 2002:a05:6000:178d:b0:20c:5bfd:4d7d with SMTP id e13-20020a056000178d00b0020c5bfd4d7dmr23049777wrg.23.1652281878846;
        Wed, 11 May 2022 08:11:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id n7-20020adffe07000000b0020c5253d8dasm1865846wrr.38.2022.05.11.08.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:11:18 -0700 (PDT)
Message-ID: <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
Date:   Wed, 11 May 2022 17:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
In-Reply-To: <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 12:53, Miaohe Lin wrote:
> On 2022/5/9 17:58, Oscar Salvador wrote:
>> On Mon, May 09, 2022 at 05:04:54PM +0800, Miaohe Lin wrote:
>>>>> So that leaves us with either
>>>>>
>>>>> 1) Fail offlining -> no need to care about reonlining
>>>
>>> Maybe fail offlining will be a better alternative as we can get rid of many races
>>> between memory failure and memory offline? But no strong opinion. :)
>>
>> If taking care of those races is not an herculean effort, I'd go with
>> allowing offlining + disallow re-onlining.
>> Mainly because memory RAS stuff.
> 
> This dose make sense to me. Thanks. We can try to solve those races if
> offlining + disallow re-onlining is applied. :)
> 
>>
>> Now, to the re-onlining thing, we'll have to come up with a way to check
>> whether a section contains hwpoisoned pages, so we do not have to go
>> and check every single page, as that will be really suboptimal.
> 
> Yes, we need a stable and cheap way to do that.

My simplistic approach would be a simple flag/indicator in the memory block devices
that indicates that any page in the memory block was hwpoisoned. It's easy to
check that during memory onlining and fail it.

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 084d67fd55cc..3d0ef812e901 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -183,6 +183,9 @@ static int memory_block_online(struct memory_block *mem)
        struct zone *zone;
        int ret;
 
+       if (mem->hwpoisoned)
+               return -EHWPOISON;
+
        zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
                                  start_pfn, nr_pages);
 


Once the problematic DIMM would actually get unplugged, the memory block devices
would get removed as well. So when hotplugging a new DIMM in the same
location, we could online that memory again.

Another place to store that would be the memory section, we'd then have to check
all underlying sections here.

We're a bit short on flags in the memory section I think, but they are easier to
lookup from other code eventually then memory block devices.

-- 
Thanks,

David / dhildenb

