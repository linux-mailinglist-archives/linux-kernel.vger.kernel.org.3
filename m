Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD65297BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiEQDNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiEQDNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:13:07 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401611E3C5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:13:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o16so3321161ilq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=niDVomHWwkj1X3m8uRV45HIt1hqCr2KxXgjlHwPIKZw=;
        b=KxLOcxyT1YZOFWo202Qc637ttcdVK7B5an5XESVLniA4Ab/jI52SQicfzWoGA9QNlC
         OhJgpaVbdEV8KiFIhxZWepcVWAKfF4WsdUMNkZGQLXyByOXy90RATcUOe7uWgJypH379
         z4WGQjjO3WFR0SmtoXYCCIOD1gEf/sL1j83hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=niDVomHWwkj1X3m8uRV45HIt1hqCr2KxXgjlHwPIKZw=;
        b=FGN0KHfuQiBQgcDTqVmnUH0v2VzsInt7VsKRarmmNIoKp9QVpCFE8G0qN/8r9yudHQ
         NWrq0M/HP9el5/njl72KnAcdiIYG+TFtod/jECa6CMaarBzrNqB57/3mLLRqYgRRBwsH
         HLTYFdMEnPjlfFfIvrx6AsLKn+/d5N8F4TzdNE4Z4Y1nPfE/ekcmtY511dQFJ0EKh8JA
         beEzYDPRV+7PV3b4AvfMpuxOCxtC+PEAUBF9+5hwi2NFgx3qzPfWSjX96q5HGfk13zKR
         5SsuEcZZXiAPPhtdAezWWJXkFer9WofTJ98+u7HCx3yGRZs9V3IbsrKgilVOJfaXBnZW
         q+Jw==
X-Gm-Message-State: AOAM533KPQWslMI3W3XO27RRwbqJLPDEisbZQHVdgkMv1U9b6pJBEPi4
        TZpA5ZgZVA2sTptVGWlIE2eiZg==
X-Google-Smtp-Source: ABdhPJxaK8Ju413pdWokrmfK3dJZx0P/woREOdnS5matvmYa13VHk5GOklWBYzlSw0FXutwEgGzDKQ==
X-Received: by 2002:a05:6e02:12ee:b0:2d1:36d2:5de9 with SMTP id l14-20020a056e0212ee00b002d136d25de9mr1059489iln.200.1652757186684;
        Mon, 16 May 2022 20:13:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n5-20020a6b4105000000b0065a47e16f5esm301697ioa.48.2022.05.16.20.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 20:13:06 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220516075619.1277152-1-surenb@google.com>
 <20220516075619.1277152-2-surenb@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fae23c69-18fa-a86f-f35a-e3c4d646a53c@linuxfoundation.org>
Date:   Mon, 16 May 2022 21:13:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220516075619.1277152-2-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 1:56 AM, Suren Baghdasaryan wrote:
> With the last usage of MMF_OOM_VICTIM in exit_mmap gone, this flag is
> now unused and can be removed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>   include/linux/oom.h            | 9 ---------
>   include/linux/sched/coredump.h | 7 +++----
>   mm/oom_kill.c                  | 4 +---
>   3 files changed, 4 insertions(+), 16 deletions(-)
> 
Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
