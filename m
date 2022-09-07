Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078F35AF98C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIGBzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:55:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE2D61702
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:55:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so13058904plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xyD4Pb2btMZ+ktk/ltP1p8JWsLx2B7oKf49IB7a3hmw=;
        b=s3UYPk0Ct+f4DGBqXw94s4gfbvQOJzYetBO/7uEBLrzkQYgmjrZFhZYfFuuFVSg4RJ
         4m242WFFh3Rh9XzSI4nfxcVJsRwB+1dnA9Qn8rjnyUb6L/6oikLS1XP/QoSrMGIgis/j
         ZqHXIiLsjL+XYncZn0mcNZjCsxMrdMH2G8B1oiPBRtPQBEDzmGSnKfr8RVISEnSq/MGb
         I51ZIKIWki5K+9nENzI3tP0HMLtrsjlkRDqb01/9P1XEdTBLpytUoIwOVVd1rSrmimzA
         tkmpu+guejoPlmp2WTMCZSA8o5Ypk51i0GiSJRl9VC4n1fD2MRP4cyewoBbvTe8aDEf9
         38YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xyD4Pb2btMZ+ktk/ltP1p8JWsLx2B7oKf49IB7a3hmw=;
        b=Hkft6Jk/oFadfBVYUITbtkVbQAWClTSUegpHZkWQKjDfLdO/5CW3qejfG8aWIhdfmj
         ugMhtCBze81f4XgU251m40ncISpfiEbC85IjefcywklTxfKE98a2RM60ZwrILG09d+RN
         3XDVjaTT0ynNcH5onLdK+lu9PvvWZiMwfPLCVDCoGp9DEJ0Ml9Icd9UaSisdWynb5YM7
         F6B8m3gZbEcUFRyXSQAFrYoq7lcw4CCTkFn8pc8/WryMN7+CuldwTPOF8O2xkfU63G+s
         5ElJhYQ0/TNon/VwADgxbAhiKwIk5k++lqCzip6Eei8nb33EjSte6V9n11Y/io+2/rmv
         gOmA==
X-Gm-Message-State: ACgBeo3LOlMb81zg8YqJUSBC5T/MBc59kLZlcWr1MC0nK6e9gh/FMDrE
        yOvRAyGr6T+1Fmw/XwkAFwScow==
X-Google-Smtp-Source: AA6agR6U6Soqe91ZpUakEjIcaAAttNetAgOL4T8q91JW56/DmqIf1u7BQWolTUcIGF0pC4zlgE3Frg==
X-Received: by 2002:a17:902:e545:b0:174:d8df:7303 with SMTP id n5-20020a170902e54500b00174d8df7303mr1584088plf.66.1662515713778;
        Tue, 06 Sep 2022 18:55:13 -0700 (PDT)
Received: from [10.254.68.181] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id e7-20020a63db07000000b0041a67913d5bsm9291330pgg.71.2022.09.06.18.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 18:55:13 -0700 (PDT)
Message-ID: <94fdf793-a568-704e-b6f8-093b8b7fe24a@bytedance.com>
Date:   Wed, 7 Sep 2022 09:55:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v4 00/10] sched/psi: some optimizations and extensions
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, tj@kernel.org, surenb@google.com,
        mkoutny@suse.com, mingo@redhat.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
 <be071d5a-ff2d-d06e-2f89-f2ca247dd19e@bytedance.com>
 <YxdcfX4Ss/9k8qA9@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YxdcfX4Ss/9k8qA9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/6 22:43, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 09:13:27PM +0800, Chengming Zhou wrote:
> 
> Ah, I see Johannes has acked them all, I missed that.
> 
>>> Chengming Zhou (9):
>>>   sched/psi: fix periodic aggregation shut off
>>>   sched/psi: don't create cgroup PSI files when psi_disabled
>>>   sched/psi: save percpu memory when !psi_cgroups_enabled
>>>   sched/psi: move private helpers to sched/stats.h
>>>   sched/psi: optimize task switch inside shared cgroups again
>>>   sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
>>>   sched/psi: consolidate cgroup_psi()
>>>   sched/psi: cache parent psi_group to speed up groups iterate
>>>   sched/psi: per-cgroup PSI accounting disable/re-enable interface
>>>
>>> Johannes Weiner (1):
>>>   sched/psi: remove NR_ONCPU task accounting
> 
> For future reference:
> 
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
> 
> Note all patches violate 1.2.2 for not starting the patch description
> with a uppercase letter. I'll go manually fix up this time.

Sorry about that, thanks for the reference and your manual fix up!

