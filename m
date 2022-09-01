Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB45A9D79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiIAQqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiIAQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA978210
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662050786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2b9v4HXJzhZu/yaMjJXJJEE+gK1pvbHfVCvX7BuxTMI=;
        b=C8sdvL1n0FbFwS/0AjZ0P1oAztgHYgOBclZh7qhzrAJBiF4nhSBoxIwkM+YS+0NgwPpE7n
        mNt15T/5Ay+QgotaLVyYyqk3Ewt7lb/q0GmZXpcCimWNdLq1ydl8misQpFQzEloT8U9Kta
        SwiYvqYzrBgP29ogG7U9kXkm8M4gJk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-8nmyFxM2N8iMFf80UffMtg-1; Thu, 01 Sep 2022 12:46:17 -0400
X-MC-Unique: 8nmyFxM2N8iMFf80UffMtg-1
Received: by mail-wm1-f70.google.com with SMTP id h82-20020a1c2155000000b003a64d0510d9so10079960wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=2b9v4HXJzhZu/yaMjJXJJEE+gK1pvbHfVCvX7BuxTMI=;
        b=Mth1LL/DYkpUKVQ1RdwpvRiWSS4CrPsUbtPVu0DjwjktGoxC1/cA9qZxhrlSNsn/vn
         YUDOwxdTNiqhhmuihmXVDVBBETg7ctroIXhZh7hZ8oZp6FTTgDW4djyZJO/XY5OdL9ez
         Zmy85zJD4CruHwjqK/XeNUMaaGmUjnZAeC9mTbXum0FYnEDFY3ECIfNySfHd6KHhhMAq
         qGItxcxEpKUtZG977EdSBuOxho8yWQZJp1r2pZ+wlK4YGw4bvVmjoKA1VBfsyxHRkBFk
         PUlfPptMi9aNdcZhumIUwXVB/53mq0+Ok+wogbS/LnGnzqDwKgl8+IirOFh17pWfVzDl
         j9TA==
X-Gm-Message-State: ACgBeo0HGEjWOY4Badfycq0brbUMN1zxNd5LkZ1YyL/3ur1LWhkpMKYn
        fE64+atolrXvntJ4PFbeEMeAafiVfT57hqt7Vtm78PxK7t9HAiqUM8mT9eCYu+V8CCbKZmSS8SD
        iPiiZ2+LVgn+CtAldX5ROSZRd
X-Received: by 2002:a7b:c4d5:0:b0:3a6:161b:4d77 with SMTP id g21-20020a7bc4d5000000b003a6161b4d77mr11048wmk.87.1662050774952;
        Thu, 01 Sep 2022 09:46:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46f7lDfKgw7Jdfg/C67X2AVW4i1hdeIwsRk9vy73cEvdnFAp98R9rCbQQNyYOFDaDsj/3Aqg==
X-Received: by 2002:a7b:c4d5:0:b0:3a6:161b:4d77 with SMTP id g21-20020a7bc4d5000000b003a6161b4d77mr11029wmk.87.1662050774652;
        Thu, 01 Sep 2022 09:46:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bcb8f000000b003a83b066401sm5620862wmi.31.2022.09.01.09.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:46:14 -0700 (PDT)
Message-ID: <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
Date:   Thu, 1 Sep 2022 18:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
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
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
In-Reply-To: <YxDghv54uHYMGCfG@xz-m1.local>
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

On 01.09.22 18:40, Peter Xu wrote:
> On Thu, Sep 01, 2022 at 06:34:41PM +0200, David Hildenbrand wrote:
>> On 01.09.22 18:28, Peter Xu wrote:
>>> On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
>>>> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
>>>> PMDs") didn't remove all details about the THP split requirements for
>>>> RCU GUP-fast.
>>>>
>>>> IPI broeadcasts on THP split are no longer required.
>>>>
>>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Cc: Sasha Levin <sasha.levin@oracle.com>
>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>>> Cc: Jerome Marchand <jmarchan@redhat.com>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>>> Cc: Peter Xu <peterx@redhat.com>
>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  mm/gup.c | 5 ++---
>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index 5abdaf487460..cfe71f422787 100644
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>>>>   *
>>>>   * Another way to achieve this is to batch up page table containing pages
>>>>   * belonging to more than one mm_user, then rcu_sched a callback to free those
>>>> - * pages. Disabling interrupts will allow the fast_gup walker to both block
>>>> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
>>>> - * (which is a relatively rare event). The code below adopts this strategy.
>>>> + * pages. Disabling interrupts will allow the fast_gup walker to block the
>>>> + * rcu_sched callback.
>>>
>>> This is the comment for fast-gup in general but not only for thp split.
>>
>> "an IPI that we broadcast for splitting THP" is about splitting THP.
> 
> Ah OK.  Shall we still keep some "IPI broadcast" information here if we're
> modifying it?  Otherwise it gives a feeling that none needs the IPIs.

I guess that's the end goal -- and we forgot about the PMD collapse case.

Are we aware of any other case that needs an IPI? I'd rather avoid
documenting something that's no longer true.

> 
> It can be dropped later if you want to rework the thp collapse side and
> finally remove IPI dependency on fast-gup, but so far it seems to me it's
> still needed.  Or just drop this patch until that rework happens?

The doc as is is obviously stale, why drop this patch?

We should see a fix for the THP collapse issue very soon I guess. Most
probably this patch will go upstream after that fix.

> 
>>
>>>
>>> I can understand that we don't need IPI for thp split, but isn't the IPIs
>>> still needed for thp collapse (aka pmdp_collapse_flush)?
>>
>> That was, unfortunately, never documented -- and as discussed in the
>> other thread, arm64 doesn't do that IPI before collapse and might need
>> fixing. We'll most probably end up getting rid of that
>> (undocumented/forgotten) IPI requirement and fix it in GUP-fast by
>> re-rechecking if the PMD changed.
> 
> Yeah from an initial thought that looks valid to me.  It'll also allow
> pmdp_collapse_flush() to be dropped too, am I right?

I think the magic about pmdp_collapse_flush() is not only the IPIs, but
that we don't perform an ordinary PMD flush but we logically flush "all
PTEs in that range".

Apparently, that's a difference on some architectures.


-- 
Thanks,

David / dhildenb

