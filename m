Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05345A9D32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiIAQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiIAQer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A6B3E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662050084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/x6/oc1hUeYoqiDjprB/jyaSxWFouy8LEiafZnROgZo=;
        b=bRNkPFdTDnSMfpm6fNLpZsq18QNdE+XvKhIjQ3Xl+66jsMa2rSFBXWHelIow6jrthpPWXN
        leOwsxlx30crXHHFH54nRU8Jgq1tRU8G3KV4k+jWBgIxIYimWoSHl7xboJpxyOM6iRZFNl
        6Tb+Kr19RXzL4Exy/rP8HWsc/VmCinc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-EritIfH8OYutoZ6fyysxvg-1; Thu, 01 Sep 2022 12:34:43 -0400
X-MC-Unique: EritIfH8OYutoZ6fyysxvg-1
Received: by mail-wm1-f72.google.com with SMTP id h133-20020a1c218b000000b003a5fa79008bso1495660wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/x6/oc1hUeYoqiDjprB/jyaSxWFouy8LEiafZnROgZo=;
        b=snkovLEwveWqB1rDBgDz1vfmfCf/mWw1NDniHxkZCT/B6USUdVuOiGVREU6korHyNG
         /ojExZ5/Ddvco52aphAp5JOIFNe7VSjl+39sO2ZfS6I8szsG2kNTeXLwf058UCPfKFUi
         ppwKrOyOBJ0fiUWEziEMBSIPwQwlixZXYFTSd64GTId9radifJed8cXmrQXmWkL0dhsG
         8dVEJZlzzSnPd2AdyYy3M+9CXRSn045dQ1L3Okz0TGaL1lxDQQKWY7ia38nWOy+9DDez
         FyjOgcmfaz13WpapqYFgi7jzcQRMcQ+hfo5MrY5knZnxZ5XzwAnFCrZDXMOakQF308bv
         /yUQ==
X-Gm-Message-State: ACgBeo373uuoXB2YG1d/JBKCb4M8EN2yZ9Xk1oLljvam1VWennV2J5QB
        Fvq5d5XVnbfBH8Z9IQnBS8jR+ib2Qd8fFHTmqpibJbDL/XycmyHJn+q/9u11DeDb3CsXH3Gb62C
        o+KnlPjQYu2KqMnpYk5EbGdw2
X-Received: by 2002:a05:600c:1e05:b0:3a5:b441:e9c with SMTP id ay5-20020a05600c1e0500b003a5b4410e9cmr10079wmb.24.1662050082592;
        Thu, 01 Sep 2022 09:34:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR503i6mrjvEw1nYqtyo2ppBA/ekjSu4WAn4G9IZgxO0UmV8sujCH8OwwQL2OAfl2JkWvuO8Lw==
X-Received: by 2002:a05:600c:1e05:b0:3a5:b441:e9c with SMTP id ay5-20020a05600c1e0500b003a5b4410e9cmr10065wmb.24.1662050082371;
        Thu, 01 Sep 2022 09:34:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4e41000000b00226d1711276sm14940816wrt.1.2022.09.01.09.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:34:41 -0700 (PDT)
Message-ID: <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
Date:   Thu, 1 Sep 2022 18:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YxDdycTur733hMgt@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 18:28, Peter Xu wrote:
> On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
>> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
>> PMDs") didn't remove all details about the THP split requirements for
>> RCU GUP-fast.
>>
>> IPI broeadcasts on THP split are no longer required.
>>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Sasha Levin <sasha.levin@oracle.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Jerome Marchand <jmarchan@redhat.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/gup.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 5abdaf487460..cfe71f422787 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>   *
>>   * Another way to achieve this is to batch up page table containing pages
>>   * belonging to more than one mm_user, then rcu_sched a callback to free those
>> - * pages. Disabling interrupts will allow the fast_gup walker to both block
>> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
>> - * (which is a relatively rare event). The code below adopts this strategy.
>> + * pages. Disabling interrupts will allow the fast_gup walker to block the
>> + * rcu_sched callback.
> 
> This is the comment for fast-gup in general but not only for thp split.

"an IPI that we broadcast for splitting THP" is about splitting THP.

> 
> I can understand that we don't need IPI for thp split, but isn't the IPIs
> still needed for thp collapse (aka pmdp_collapse_flush)?

That was, unfortunately, never documented -- and as discussed in the
other thread, arm64 doesn't do that IPI before collapse and might need
fixing. We'll most probably end up getting rid of that
(undocumented/forgotten) IPI requirement and fix it in GUP-fast by
re-rechecking if the PMD changed.

Thanks!

-- 
Thanks,

David / dhildenb

