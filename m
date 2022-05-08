Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B4D51EABA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 02:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiEHAcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 20:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiEHAcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 20:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECED41707C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651969735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JVQ4SI8lG6xRIzugQ8tXt+YN3SSvNLYRKRIdK5XTMU=;
        b=eiCO2CefpmsX2/wz2ElXk5eSBCllpNAKRIqXn929BPIix/aX900N6XgvBfQ7KLA851IDcj
        xvfLM0pJlzko2JZFqHyC5VF2s8BUOE582LB+UtoN87mDlIhckXrWfIvoMoM0QEl5qTWijD
        NT1Lj7dzxmwEI2ewaXTiRTuD7Q2Lumk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-2tY7ty2CNJ-N-lzz6NmTBQ-1; Sat, 07 May 2022 20:28:54 -0400
X-MC-Unique: 2tY7ty2CNJ-N-lzz6NmTBQ-1
Received: by mail-qk1-f200.google.com with SMTP id o13-20020a05620a0d4d00b0069f47054e58so7409448qkl.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 17:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/JVQ4SI8lG6xRIzugQ8tXt+YN3SSvNLYRKRIdK5XTMU=;
        b=i5AKSr6WIDZYHwltfGCBJNVvtEWNZFzR4++t26bqT8WaM+Jx1FrwWP5Oqvz5BRARKK
         n/uqvLNZUKEscWwEG1f2uQiOh+5f1QbRsLSqO8TCZn2VwBt6BRX3ePznvVsQmG08EFOl
         I5ACtvlBQOWjkWZXv56/XjTBH98A4VE2ayw7ZsvGia85UyRBWbDXMJeKtwxndPyO5iN5
         jEVMX9exK2lhkb8ClcdEmy3ifgoMwA601BBDRIDqqYMIvB5b4mmhyJnqWaDhVPiOKNxA
         XZImRPcqYpt2rYozzNii66u5z6gXySK5HTRtnUbpfc8kzRSVHNtxiT4Xh41n24t0EhEV
         DmPw==
X-Gm-Message-State: AOAM533kaM1ytMiNZs1IaibAS7ce7oXKgrgVKC0i6PiwdVHNII7ES5sp
        rb88o1e4rKQFN6i3ZGb+9NI7H1a5FMaDvq+V0u9w5B8i2We40DncwDRBypM3zzsl2dyA8KMon5m
        5SJ/MzuaD48Wzc5YQ5Q/RpiSi
X-Received: by 2002:a0c:cc08:0:b0:45a:8f81:d8a8 with SMTP id r8-20020a0ccc08000000b0045a8f81d8a8mr8527270qvk.88.1651969734234;
        Sat, 07 May 2022 17:28:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWPkh3zBSc9oc61q1WzL0NdJ1Avcf+UZ74YgB60XC3dfGeDmiVRDE4qcyYoknIHnJJK5aBVQ==
X-Received: by 2002:a0c:cc08:0:b0:45a:8f81:d8a8 with SMTP id r8-20020a0ccc08000000b0045a8f81d8a8mr8527257qvk.88.1651969733946;
        Sat, 07 May 2022 17:28:53 -0700 (PDT)
Received: from [10.23.153.165] ([46.248.132.196])
        by smtp.gmail.com with ESMTPSA id c2-20020ac80542000000b002f39b99f67bsm4852527qth.21.2022.05.07.17.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 17:28:53 -0700 (PDT)
Message-ID: <efe00fa8-1a85-f687-b717-e22997dc42d7@redhat.com>
Date:   Sun, 8 May 2022 02:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnMC1jFoPvNLWqnG@google.com> <YnNzPlehofB57XXU@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YnNzPlehofB57XXU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.22 08:48, Minchan Kim wrote:
> On Wed, May 04, 2022 at 03:48:54PM -0700, Minchan Kim wrote:
>> On Tue, May 03, 2022 at 06:02:33PM +0200, David Hildenbrand wrote:
>>> On 03.05.22 17:26, Minchan Kim wrote:
>>>> On Tue, May 03, 2022 at 03:15:24AM +0200, David Hildenbrand wrote:
>>>>>
>>>>>>>>> However, I assume we have the same issue right now already with
>>>>>>> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
>>>>>>
>>>>>> ZONE_MOVALBE is also changed dynamically?
>>>>>>
>>>>>
>>>>> Sorry, with "same issue" I meant failing to pin if having to migrate and
>>>>> the page is temporarily unmovable.
>>>>>
>>>>>>> there are temporarily unmovable and we fail to migrate. But it would now
>>>>>>> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
>>>>>>
>>>>>> Didn't parse your last mention.
>>>>>
>>>>> On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
>>>>> to migrate now when pinning.
>>>>
>>>> I don't understand your point. My problem is pin_user_pages with
>>>> FOLL_LONGTERM. It shouldn't pin a page from ZONE_MOVABLE and cma area
>>>> without migrating page out of movable zone or CMA area.
>>>> That's why try_grab_folio checks whether target page stays in those
>>>> movable areas. However, to check CMA area, is_migrate_cma_page is
>>>> racy so the FOLL_LONGTERM flag semantic is broken right now.
>>>>
>>>> Do you see any problem of the fix?
>>>
>>> My point is that you might decide to migrate a page because you stumble
>>> over MIGRATE_ISOLATE, although there is no need to reject long-term
>>> pinning and to trigger page migration.
>>>
>>> Assume a system without ZONE_MOVABLE and without MIGRATE_CMA. Assume
>>> someone reserves gigantic pages (alloc_contig_range()) and you have
>>> concurrent long-term pinning on a page that is no MIGRATE_ISOLATE.
>>>
>>> GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
>>> be migrated, which can fail if the page is temporarily unmovable.
>>
>> A dump question since I'm not familiar with hugetlb.
>>
>> Is above reasonable scenario?
>>
>> The gigantic page is about to be created using alloc_contig_range so
>> they has MIGRATE_ISOLATE as temporal state. It means no one uses the
>> page yet so I guess the page is not mapped at userspace but other is
>> trying to access the page using pin_user_pages?
>>
> 
> Too dump question. Never mind.
> Posted v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/T/#u

Sorry for the late reply, still traveling :)

Just so we're on the same page: MIGRATE_ISOLATE would be set on
pageblocks that contain either free or movable pages. In case of movable
pages, they are in uese.

Regarding your is_cma_page() proposal, I think we might want to consider
that if it really turns out to be a problem. For now, I'm fine with just
documenting it.

Thanks!

-- 
Thanks,

David / dhildenb

