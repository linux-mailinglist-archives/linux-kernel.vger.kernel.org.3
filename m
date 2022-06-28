Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3155CB87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbiF1DvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243730AbiF1DvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:51:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23395275D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:51:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso11485007pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uwMg1kjVBteskEOrYAj20PlkA0xYjmNq7G82E/n5gNo=;
        b=4Jm8V3PLgyo6j+KY8AHThuWudmS+gjyrypdWwzI0SOp2L+wfgMlXT1vekbFsdz2hyQ
         NTeeD06fvg1jOVnpRhjLxqGy0l27PaMPXVCj06kDcwyDuXCqq5622AwOBQZv0S0F/O9q
         6zt3VYEiS9EVNg95YBzMgb6pxjEL03p2DL0LPiTbWRgoBIcR2jG6MZ2LoEj7J6I1jwkj
         z6dakvA0+YlG2UhFou8OYA4nQY1lRyXQZB4513DupaD2u5LUtA0rB0bXi0mk8kLdmccC
         njE/lLV6Ta5QKFUWdWISVEngnjHk2fi9IsYmpovlExvxbUrxyWD2ouVc84iPsRCVkaR1
         n6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uwMg1kjVBteskEOrYAj20PlkA0xYjmNq7G82E/n5gNo=;
        b=ZO6IbMuuQWbOGg3uJ6RhGgj8XpmBpJu31nidHxTBE/osl1I/zGOHmxrjYaw86KNqWM
         CcmRMtYjIHu75dOxQDIUkQqc6LLqGHAnOmxNLL3CI0Y8bx/REnd5e0PHrTisgS5PhLAY
         MBgzCPikD8ZTID3vwAeG2xxSf3HrGMce15WLa12fIdIFzNRQzDuqEWWs69SfSAwDs6x1
         K4K5vYz4cMOqkWFNq5GHeNqBpFeM9JZJsrl9nasAO6xp2854fHRlUEPGfGLtmwx+bO8S
         uDJbKUZf4yKSGvEH+fTQQfBoOQgfkNjqatiISUGuzw4VTpfmuEDuzlzJuBg4LV4IRmN5
         Dqpg==
X-Gm-Message-State: AJIora/5niiOL9BTlMrVBtNEPxN78E7/HiEYxdc89X7vrLL/WX4HwJfN
        yReUERmY2i+H7Ha8ovuZDR+rHg==
X-Google-Smtp-Source: AGRyM1sABHBS/zBQ6zTqtUOLQeEwmv6qWoNeJOpQ6yWwfyNSO4vpbc8uW77tG0CFVIXcfPE/3uhuXg==
X-Received: by 2002:a17:902:c401:b0:16a:1873:5ca3 with SMTP id k1-20020a170902c40100b0016a18735ca3mr2760390plk.157.1656388266704;
        Mon, 27 Jun 2022 20:51:06 -0700 (PDT)
Received: from [10.4.116.59] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903405100b0016a25ba1f46sm7911411pla.256.2022.06.27.20.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 20:51:06 -0700 (PDT)
Message-ID: <73ab0143-b518-c0b5-328e-c8f3ec7013ed@bytedance.com>
Date:   Tue, 28 Jun 2022 11:51:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/7] sched/fair: remove useless check in
 select_idle_core
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-5-wuyun.abel@bytedance.com>
 <CABk29NuXvCTkbQ=MdX5F+YswhOAPZSAQTAXn7B_uuKRr4=XVnQ@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29NuXvCTkbQ=MdX5F+YswhOAPZSAQTAXn7B_uuKRr4=XVnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/28/22 7:42 AM, Josh Don Wrote:
> On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> The function only gets called when sds->has_idle_cores is true which can
>> be possible only when sched_smt_present is enabled.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index aba1dad19574..1cc86e76e38e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6256,9 +6256,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>>          bool idle = true;
>>          int cpu;
>>
>> -       if (!static_branch_likely(&sched_smt_present))
>> -               return __select_idle_cpu(core, p);
>> -
> 
> The static branch is basically free; although you're right that we
> currently don't take !smt_present branch direction here, it doesn't
> seem harmful to leave this check in case assumptions change about when
> we call select_idle_core().

I was thinking that it would be better to align with select_idle_smt
that the caller do the check if necessary.

> 
>>          for_each_cpu(cpu, cpu_smt_mask(core)) {
>>                  if (!available_idle_cpu(cpu)) {
>>                          idle = false;
>> --
>> 2.31.1
>>
