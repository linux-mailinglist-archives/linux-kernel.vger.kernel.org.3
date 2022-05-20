Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D562752E2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiETCs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiETCsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:48:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3B1498CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:48:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l14so6870148pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QVqkVgSPQg+paLMVFz7WpJ9XjeyoBHXntaGD9HA2EME=;
        b=AU2sagCEbx4tlcmoW6+EvHY3Dd4dDCK34S52ir8THvbOcJgF3Q/ghTldOGhmjC/gfr
         pWvNnTk9TQHlGpcf2w9ND8iqxlEF0vpPW3uRLUS320T34YQEs1IPmV1sJjgFOonhv6fN
         Q63lwbM9JFYUUB+QO4vB67vIKJ7dSqyGtKnveuln70VF4piPAqXha1KJGZM7XjUBj8fc
         GL0YsLKtLDW7OOtIVoY2N0K2EGivDdMcmiE2LqtWrgA1OAmQDMdE+BnwYuAw3V46i3bA
         O3B91E0Drv/QmenAIOf7YjYLOvcp+EjZft9tzVoDr9z3chZyYYOrHCeCsRcBq3lpGMfJ
         Zj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QVqkVgSPQg+paLMVFz7WpJ9XjeyoBHXntaGD9HA2EME=;
        b=cuv6fP41/x5HATu7KQi75WFeNw9zwLmfJX5Gm8gtyo/sSAM2YSaRqfojJzf18+Syfj
         iiyQVt7rMCwpAs2QhQ5ib/FZmcSLqBAXuHgzqudS7LEWwb4zXuwUtGQ7qdeL+sCExtod
         IKgplGr6TngGgzgjY/PoTsvouS5tZlKci6a321VOxq4MT2XjN73BXdmascLZN+ivspzI
         nxtz7vPhvu7Z+j45dESeIfr4UYdSvuieo/GiqXbrp9uLjUCCrZIGOx7P2VCWy6MAVq5n
         o70YgxBJlnAu/CISABOvjg92UcrDKtS6xOJu+zeC1f7VEJURUrCLZPOGTTHVwUnmsyLS
         y7mQ==
X-Gm-Message-State: AOAM532CK1j326+7ckVYe6I7EE7h3NQfrQyTMei1bHAtnzm9c69USTT4
        shTl2nyljWroupcC/AxaAVFDX2Q82me7cA==
X-Google-Smtp-Source: ABdhPJxr7ZZYTBnuZu6v3SZnNAQ3H2DM/QTg6/Wmkt7GwELl2EmWsxuEU/qfVleKgi6FZ3R7hnGliQ==
X-Received: by 2002:a17:90a:a097:b0:1de:cddd:1970 with SMTP id r23-20020a17090aa09700b001decddd1970mr8566513pjp.65.1653014924175;
        Thu, 19 May 2022 19:48:44 -0700 (PDT)
Received: from [10.254.77.173] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001615ca9ab2asm4381148plb.20.2022.05.19.19.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 19:48:43 -0700 (PDT)
Message-ID: <c741142d-7e29-a721-ffa9-34e3d5806b60@bytedance.com>
Date:   Fri, 20 May 2022 10:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
 <ddf05d4f0f1ffb1a3ff3076e01cc9752a9fd33a8.camel@linux.intel.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ddf05d4f0f1ffb1a3ff3076e01cc9752a9fd33a8.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/20/22 6:16 AM, Tim Chen Wrote:
> On Thu, 2022-05-05 at 20:23 +0800, Abel Wu wrote:
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/sched/topology.h | 12 ++++++++++
>>   kernel/sched/core.c            | 38 ++++++++++++++++++++++++++++++
>>   kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++-------
>>   kernel/sched/idle.c            |  1 +
>>   kernel/sched/sched.h           |  4 ++++
>>   kernel/sched/topology.c        |  4 +++-
>>   6 files changed, 92 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 56cffe42abbc..95c7ad1e05b5 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -81,8 +81,20 @@ struct sched_domain_shared {
>>   	atomic_t	ref;
>>   	atomic_t	nr_busy_cpus;
>>   	int		has_idle_cores;
>> +
>> +	/*
>> +	 * Tracking of the overloaded cpus can be heavy, so start
>> +	 * a new cacheline to avoid false sharing.
>> +	 */
>> +	atomic_t	nr_overloaded_cpus ____cacheline_aligned;
> 
> Abel,
> 
> This is nice work. I have one comment.
> 
> The update and reading of nr_overloaded_cpus will incur cache bouncing cost.
> As far as I can tell, this counter is used to determine if we should bail out
> from the search for an idle CPUs if the system is heavily loaded.  And I
> hope we can avoid using atomic counter in these heavily used scheduler paths.
> The logic to filter overloaded CPUs only need overloaded_cpus[]
> mask and not the nr_overloaded_cpus counter.
> 
> So I recommend that you break out the logic of using nr_overloaded_cpus
> atomic counter to detect LLC has heavy load as a second patch so that
> it can be evaluated on its own merit.
> 
> That functionality overlaps with Chen Yu's patch to limit search depending
> on load, so it will be easier to compare the two approaches if it is separated.
> 
> Otherwise, the logic in the patch to use overloaded_cpus[]
> mask to filter out the overloaded cpus looks fine and complements
> Chen Yu's patch.

OK, will do. And ideally the nr_overloaded_cpus atomic can be replaced
by Chen's patch.

Thanks & BR
Abel
