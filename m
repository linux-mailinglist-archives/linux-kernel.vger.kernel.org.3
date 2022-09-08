Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB29A5B1F98
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiIHNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiIHNtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:49:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FBC6381
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:49:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t65so5877305pgt.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AoTWfXAoa8AgG4nMDe/SF1cuNtQoz1t7eSVMtl59jjI=;
        b=qSZgZmR5MYqagzRko2k6fI48nqZ5yq742perWJmDRL9lVEpxlCrpoRMqaDcglYVhAa
         7bkYNZMpSU+VZRs17YWB7wZB/T4rRSzMokR3thljE4oOEp9ARLYWSG/s4cNWF+Jp3epS
         8gTDdAQv37qrH628QaSYQFzWWx5QGyw/X+lLy117J2odAqeiPF2bR+kdmor4cxrJWPPS
         NSo8l3bnRjZ8M1lhGbJkpu230Xe6l0Up5IGBbxw5QcDXcVc45skHRRuD+n5V2GTJgCMk
         fzZp5smYhVE3kEXni3GtuEqaLndX9CfYOwTvrHakz4Qoha6Jdbzc/S6rAX3U7+ULD5nR
         sj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AoTWfXAoa8AgG4nMDe/SF1cuNtQoz1t7eSVMtl59jjI=;
        b=yGVXPAoDgjXk6o7AsHyu+Xc8YfzqYSepK7xwvO8vh/PyQUwturEWDFXQ1TAHrQtmt/
         BNJ0xYFpkObt2PuzpdA5eSw3v6lIUPvHiFUWmf/1xP4idjyfw/YZD2j316GXJQ4/Cqqc
         Sf6xZ81+LHZntv4iMdBryQldImLkChDyvt5A40D933SKxsZf2UetVLgXmjaWMtry+5nF
         ZybdW12DIcMHzF2nhBwMgvXzgbvONsQldmIKupEU8raqOWyOVY2gflL79yb6fZh5NhEE
         ygTA19gXzbO0z+2QtCbmOFZfE4QszqSrgFGHZXSLfIOqpFo0qwTosoOK4MmG+Rclnk1x
         mPHg==
X-Gm-Message-State: ACgBeo3+HsqLjpBUZgE5kUosBEcYgd82lOj8JI0gu/odAWXNkVICcgCY
        bh8Z1uyWGs+hhD8FnMOsdJv576TEciT5/Q==
X-Google-Smtp-Source: AA6agR6caGBnqC86j+5h6qiwf0CrcOUbZjwmryaQEj93QMk6IV66kjO/Okiv9jnT9S1Xe29UzG3ofQ==
X-Received: by 2002:a05:6a00:842:b0:52e:2515:d657 with SMTP id q2-20020a056a00084200b0052e2515d657mr9029865pfk.31.1662644966925;
        Thu, 08 Sep 2022 06:49:26 -0700 (PDT)
Received: from [10.4.233.238] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902f65000b0017682b90532sm12418215plg.194.2022.09.08.06.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:49:26 -0700 (PDT)
Message-ID: <b3d2c694-e2a2-63ea-817f-113b5445dfda@bytedance.com>
Date:   Thu, 8 Sep 2022 21:49:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] sched/fair: Fix misuse of available_idle_cpu()
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Rohit Jain <rohit.k.jain@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20220908080702.58938-1-wuyun.abel@bytedance.com>
 <20220908103632.yzm5boxrr3nmvhpm@suse.de>
 <YxnrTdwA493gIHS8@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YxnrTdwA493gIHS8@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 9:17 PM, Peter Zijlstra wrote:
> On Thu, Sep 08, 2022 at 11:36:32AM +0100, Mel Gorman wrote:
>> On Thu, Sep 08, 2022 at 04:07:02PM +0800, Abel Wu wrote:
>>> The function available_idle_cpu() was introduced to distinguish
>>> between the code paths that cares if the vCPU is preempted and
>>> the ones don't care. In general, available_idle_cpu() is used in
>>> selecting cpus for immediate use, e.g. ttwu. While idle_cpu() is
>>> used in the paths that only cares about the cpu is idle or not,
>>> and __update_idle_core() is one of them.
>>>
>>> Use idle_cpu() instead in the idle path to make has_idle_core
>>> a better hint.
>>>
>>> Fixes: 943d355d7fee (sched/core: Distinguish between idle_cpu() calls based on desired effect, introduce available_idle_cpu())
>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>
>> Seems fair. As vCPU preemption is specific to virtualisation, it is very
>> unlikely that SMT is exposed to the guest so the impact of the patch is
> 
> Right; only pinned guests typically expose such topology information
> (anything else would be quite broken).
> 
>> minimal but I still think it's right so;
> 
> I'm not convinced; all of select_idle_sibling() seems to use
> available_idle_cpu(), and that's the only consumer of
> __update_idle_core(), so in that respect the current state makes sense.

Hi Peter, Mel, thanks for your reviewing!

My thought was that the preempted core can become active again before
select_idle_sibling() is called, so using available_idle_cpu() in
__update_idle_core() can potentially lose the opportunity to kick an
idle core running. While the downside of using idle_cpu() is that a
full scan can be triggered irrespective of non-preempted cores exist,
but even available_idle_cpu() can not make sure of that either.

BTW, I am also confused with select_idle_core() in which all the cpus
of a core need to be non-preempted before the core can be taken as an
idle core. IMHO, it might be enough that at least one cpu of an idle
core is non-preempted and allowed by task's taskset.

Thanks & BR,
Abel
