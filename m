Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3977651893F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiECQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiECQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1238B193C1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651593770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTs41GXb8wIzvyXd50RZNuQtqo7++DwnC0mSBVTVZ0s=;
        b=ZyFJY72zkxVTmrSpaWUZtSE9T3X73Abu8uJqkLbVA3G+tUXYFzHuV7ZsT7qZh48jYXn9FU
        2RqsUKHGKjDxeHAPcKRSphQ84WEGDGvmRUKx3WoxX0GTrYj0UnQAvVjD2rp03HlU1krRNk
        8Gfywzj+hSz4tV1HvlJT4pcrW3TuyR0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-IHR32qGkMXazJvIkQI7kLg-1; Tue, 03 May 2022 12:02:37 -0400
X-MC-Unique: IHR32qGkMXazJvIkQI7kLg-1
Received: by mail-oi1-f197.google.com with SMTP id a10-20020acab10a000000b00322feff2ac2so9106383oif.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ZTs41GXb8wIzvyXd50RZNuQtqo7++DwnC0mSBVTVZ0s=;
        b=Uoq0R6PaKAtrgINmeKMNOJUKwSZi9Ud3sPDw2JkShB1tjDhmBpw4d9WoCiOxG0CScm
         dgOAlLWq7mjANGoGzA/XYfG7RAEufjs9ayVAF7cFQBwcNt3G8ad+msgdxHHUJxwRIbtX
         0DE4GGRmJspRViFfb2LNgihbXPpX6J3JSzODknN8bChw95gqTIE9MKtBVxnYs/IB45qE
         vHFWl13/rvOKkM8FZBkzaWaX8W97h/WzSBseiLNY9IhEtYaj4+ArSi+TwtPbrp9B3mv3
         lykhBJW7E1sSb48Nmoosar4jNgl8u/16MtW5bQYXrRZ+Zai4ITyIoq1faNhub1r5NXwQ
         tArw==
X-Gm-Message-State: AOAM531gLrgnuWLCvpOWPFlegi6NxHq2NCzA9h8J47bMlS998Qe/he1E
        rWn72XDF4WuK0yd22K4708GgwavmQayAetVWdYkEteV7ZbpNfGhR56luuLtowaYFnAYZAtIt2AK
        0W1eGe9phbgCcn9/TsoDnZ0oh
X-Received: by 2002:a05:6830:4196:b0:605:e96b:bb59 with SMTP id r22-20020a056830419600b00605e96bbb59mr5973756otu.361.1651593756905;
        Tue, 03 May 2022 09:02:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyTlwej4kwlhDyJ+P/DSGKgzh5AIBYDo0weUFflJsTWm5t+ac0cJZYqjj6GGYNw7wRsYPLRw==
X-Received: by 2002:a05:6830:4196:b0:605:e96b:bb59 with SMTP id r22-20020a056830419600b00605e96bbb59mr5973741otu.361.1651593756568;
        Tue, 03 May 2022 09:02:36 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id s18-20020a0568301e1200b006060322127csm4026733otr.76.2022.05.03.09.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:02:35 -0700 (PDT)
Message-ID: <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
Date:   Tue, 3 May 2022 18:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
In-Reply-To: <YnFJss0doXGCmq3w@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.22 17:26, Minchan Kim wrote:
> On Tue, May 03, 2022 at 03:15:24AM +0200, David Hildenbrand wrote:
>>
>>>>>> However, I assume we have the same issue right now already with
>>>> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
>>>
>>> ZONE_MOVALBE is also changed dynamically?
>>>
>>
>> Sorry, with "same issue" I meant failing to pin if having to migrate and
>> the page is temporarily unmovable.
>>
>>>> there are temporarily unmovable and we fail to migrate. But it would now
>>>> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
>>>
>>> Didn't parse your last mention.
>>
>> On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
>> to migrate now when pinning.
> 
> I don't understand your point. My problem is pin_user_pages with
> FOLL_LONGTERM. It shouldn't pin a page from ZONE_MOVABLE and cma area
> without migrating page out of movable zone or CMA area.
> That's why try_grab_folio checks whether target page stays in those
> movable areas. However, to check CMA area, is_migrate_cma_page is
> racy so the FOLL_LONGTERM flag semantic is broken right now.
> 
> Do you see any problem of the fix?

My point is that you might decide to migrate a page because you stumble
over MIGRATE_ISOLATE, although there is no need to reject long-term
pinning and to trigger page migration.

Assume a system without ZONE_MOVABLE and without MIGRATE_CMA. Assume
someone reserves gigantic pages (alloc_contig_range()) and you have
concurrent long-term pinning on a page that is no MIGRATE_ISOLATE.

GUP would see MIGRATE_ISOLATE and would reject pinning. The page has to
be migrated, which can fail if the page is temporarily unmovable.

See my point? We will try migrating in cases where we don't have to
migrate. I think what we would want to do is always reject pinning a CMA
page, independent of the isolation status. but we don't have that
information available.

I raised in the past that we should look into preserving the migration
type and turning MIGRATE_ISOLATE essentially into an additional flag.


So I guess this patch is the right thing to do for now, but I wanted to
spell out the implications.

> 
> A thing to get some attention is whether we need READ_ONCE or not
> for the local variable mt.
> 

Hmm good point. Staring at __get_pfnblock_flags_mask(), I don't think
there is anything stopping the compiler from re-reading the value. But
we don't care if we're reading MIGRATE_CMA or MIGRATE_ISOLATE, not
something in between.

-- 
Thanks,

David / dhildenb

