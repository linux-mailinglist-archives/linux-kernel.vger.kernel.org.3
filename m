Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999245A9B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiIAPHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiIAPHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177E857C4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662044834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n51zgqgBl470PB0vgcZT4BRIRHbxoQSrqhNCiStba2E=;
        b=ObDiSLMfQ9MXDmrGnlC1LZZNZWle7oseddosLR97XfdCMFtq6NiEU84hrrYb+YIX+PVJ95
        lMwvk1ghQb+NVS3Q/a+XVJLVsH26CMN+7TkcbwgomSX2qCI1PUwBoHSpVpz7igyTQh4Sou
        4X/G4lPfE32Y+MmVTqFcZL1HZ3QkZEY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-283-5f9x3F5rPtKr2sIHHlE51A-1; Thu, 01 Sep 2022 11:07:13 -0400
X-MC-Unique: 5f9x3F5rPtKr2sIHHlE51A-1
Received: by mail-wr1-f71.google.com with SMTP id d11-20020adfc08b000000b002207555c1f6so3126357wrf.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=n51zgqgBl470PB0vgcZT4BRIRHbxoQSrqhNCiStba2E=;
        b=wF+/IUK/Qw2Jh+jWI7NKAAcyJa8PfheLu43J/enr0ToL4n/riJq9LQ9qv/1EhieYyN
         ow/4TNrVknLv96kYObwLsMVGN2AtzLobyvyrYc6rl2guUIW2PrhPWhH7ild05uYebcSc
         +hS58g8IT2A5GEsRvjEhaicgHgARvEUq5joDYTvIwnG9AvX6EbmvP50xHuI5JpNdzMVE
         uwNcqdGilSLrkKxK+NJKYB0g6TaVLewkaAbf4j6QoOTk7PCbwxl9qpVgxChugF3zqTGZ
         7s2cNZ5xU3+iA2FSi6kFmbjZni/t8SI6Q1r0KMqZAWEnxTOtB77L+Qr7m2nafF+x9uox
         VQsQ==
X-Gm-Message-State: ACgBeo22GaI50/J6GrYep9frXbI1I+x8QKZhKqTI4FztxeCjgXfuMWDG
        xPyTVCb6n9cnywBlVPLQGvBZKMPMISI5U1G7ASfPExUB5RpoHmxVtbeycmM5S6bA6VmINtPwmK/
        luPHultcL5Hqlm+45hgLmsbNC
X-Received: by 2002:a7b:ce13:0:b0:3a6:34f8:e21d with SMTP id m19-20020a7bce13000000b003a634f8e21dmr5628113wmc.22.1662044831141;
        Thu, 01 Sep 2022 08:07:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4MsTHzosmA7E7hGiZjHmjlTUlB0s2DWeDkp38EpmRPnqXeJG3hehRWe5SqC6TIKnfqy7LhVg==
X-Received: by 2002:a7b:ce13:0:b0:3a6:34f8:e21d with SMTP id m19-20020a7bce13000000b003a634f8e21dmr5628080wmc.22.1662044830813;
        Thu, 01 Sep 2022 08:07:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id a6-20020a5d4d46000000b00226dedf1ab7sm9303786wru.76.2022.09.01.08.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:07:09 -0700 (PDT)
Message-ID: <78e55029-0eaf-b4b3-7e86-1086b97c60c6@redhat.com>
Date:   Thu, 1 Sep 2022 17:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, void@manifault.com, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, peterx@redhat.com, axboe@kernel.dk,
        mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org,
        changbin.du@intel.com, ytcoode@gmail.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-mm@kvack.org, iommu@lists.linux.dev,
        kasan-dev@googlegroups.com, io-uring@vger.kernel.org,
        linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220830214919.53220-1-surenb@google.com>
 <Yw8P8xZ4zqu121xL@hirez.programming.kicks-ass.net>
 <20220831084230.3ti3vitrzhzsu3fs@moria.home.lan>
 <20220831101948.f3etturccmp5ovkl@suse.de> <Yw88RFuBgc7yFYxA@dhcp22.suse.cz>
 <20220831190154.qdlsxfamans3ya5j@moria.home.lan>
 <404e947a-e1b2-0fae-8b4f-6f2e3ba6328d@redhat.com>
 <20220901142345.agkfp2d5lijdp6pt@moria.home.lan>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/30] Code tagging framework and applications
In-Reply-To: <20220901142345.agkfp2d5lijdp6pt@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 16:23, Kent Overstreet wrote:
> On Thu, Sep 01, 2022 at 10:05:03AM +0200, David Hildenbrand wrote:
>> On 31.08.22 21:01, Kent Overstreet wrote:
>>> On Wed, Aug 31, 2022 at 12:47:32PM +0200, Michal Hocko wrote:
>>>> On Wed 31-08-22 11:19:48, Mel Gorman wrote:
>>>>> Whatever asking for an explanation as to why equivalent functionality
>>>>> cannot not be created from ftrace/kprobe/eBPF/whatever is reasonable.
>>>>
>>>> Fully agreed and this is especially true for a change this size
>>>> 77 files changed, 3406 insertions(+), 703 deletions(-)
>>>
>>> In the case of memory allocation accounting, you flat cannot do this with ftrace
>>> - you could maybe do a janky version that isn't fully accurate, much slower,
>>> more complicated for the developer to understand and debug and more complicated
>>> for the end user.
>>>
>>> But please, I invite anyone who's actually been doing this with ftrace to
>>> demonstrate otherwise.
>>>
>>> Ftrace just isn't the right tool for the job here - we're talking about adding
>>> per callsite accounting to some of the fastest fast paths in the kernel.
>>>
>>> And the size of the changes for memory allocation accounting are much more
>>> reasonable:
>>>  33 files changed, 623 insertions(+), 99 deletions(-)
>>>
>>> The code tagging library should exist anyways, it's been open coded half a dozen
>>> times in the kernel already.
>>
>> Hi Kent,
>>
>> independent of the other discussions, if it's open coded already, does
>> it make sense to factor that already-open-coded part out independently
>> of the remainder of the full series here?
> 
> It's discussed in the cover letter, that is exactly how the patch series is
> structured.

Skimming over the patches (that I was CCed on) and skimming over the
cover letter, I got the impression that everything after patch 7 is
introducing something new instead of refactoring something out.

>  
>> [I didn't immediately spot if this series also attempts already to
>> replace that open-coded part]
> 
> Uh huh.
> 
> Honestly, some days it feels like lkml is just as bad as slashdot, with people
> wanting to get in their two cents without actually reading...

... and of course you had to reply like that. I should just have learned
from my last upstream experience with you and kept you on my spam list.

Thanks, bye

-- 
Thanks,

David / dhildenb

