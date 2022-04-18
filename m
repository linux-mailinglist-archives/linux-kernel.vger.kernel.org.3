Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D643A5059E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbiDROar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345508AbiDROZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:25:00 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F13506CE
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:20:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k29so18816800pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=29+EQDW4PzB6PGPDYNZxij95Jg8dyZKWVfgccFNsSMY=;
        b=idDBiRzJlr0Trq4/zQOVkSmvC2K6ySSJGG/M9NFOI+2vN8nYQtN9xzKtOD/+Yjf0ge
         gV35GWEh2ejQqiU8SpEbc+AfnI2Z3vHFw1isbgpYpUQy++wILIx6ErfxZdor9rpwQ4wl
         OJ2LZD4qIw+z3nJFlUTPIfJUqTri6NdTutDpYD2au/YBngarCw4HoaMmbcqlNiJ8Z6Hy
         FJUZlAOcaC1wfheVUIDNamFICR1Sz3o44y3r9/UzR3Equjdz7X38zLxH5oIcAneKO3DN
         LWQ0eWwieLN0+1mnpSUYOKQCZMB7AD/BRqkdX67f/J/Fdedu/UKNDVcXBmBYE4Rw2irn
         /7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29+EQDW4PzB6PGPDYNZxij95Jg8dyZKWVfgccFNsSMY=;
        b=IVadm5w/ICXvgwXhh99p/hTYkrP4OZg0gpYvWNMOiyUlcL4eEOL3h5ztu3uqfs0NKo
         7yUfPLsj8p5lwkjAba7WiGX4UAc8NQIhQKxrALBx6iHnYV+g/RAcF6g9mqVIjQ6/bOsk
         bNrROrOmeE8xaMg3dfwNhNQHpJJcWRhisB4fPcor5FlqZQdLg/ovPT83VTOEVEjVaeW3
         WQH58h8B4QmVkuG+XLoknBe+LKhcb4FxoIw5mgniJLbh2kPLYvp7pUYmjNfEw1YJZIU1
         WYXpDiE2e1dxFtK22V5bsxSYbzDsi95zNCg7QahUnm/WFlf9cqd4OKMrMxm7kSElcU6o
         T0Pg==
X-Gm-Message-State: AOAM531A+BeWM340p5fxPoAsVHNQjxUPTkthUqYLKAPhNaZ+5yx3hR9p
        NYQxVnwFpBiX/3SSvgovMCWmeA==
X-Google-Smtp-Source: ABdhPJwCPuixMbb5o3UXUNYnrASSeIe1KhG7qvYeu117vLTR67xtV6wNHDIb8Moy/pMO3PnNXjV+2A==
X-Received: by 2002:a63:fd53:0:b0:386:66d:b40c with SMTP id m19-20020a63fd53000000b00386066db40cmr10044968pgj.266.1650288033475;
        Mon, 18 Apr 2022 06:20:33 -0700 (PDT)
Received: from [10.254.152.226] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id j6-20020aa79286000000b004fdf02851eesm12475019pfa.4.2022.04.18.06.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 06:20:32 -0700 (PDT)
Message-ID: <1edf3ea4-6c77-1cc1-9537-13acdfe67cf1@bytedance.com>
Date:   Mon, 18 Apr 2022 21:20:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [External] Re: [PATCH] sched/fair: update tg->load_avg and
 se->load in throttle_cfs_rq()
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Benjamin Segall <bsegall@google.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        zhengqi.arch@bytedance.com
References: <20220413041627.41521-1-zhouchengming@bytedance.com>
 <xm26h76wvql9.fsf@bsegall-linux.svl.corp.google.com>
 <14737e0f-3d33-125b-57cc-966de00430be@bytedance.com>
 <CAKfTPtBWXyamX0jFSvgP3VnZacd5SNb_Yg9jAq1y0koHwr7DxQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtBWXyamX0jFSvgP3VnZacd5SNb_Yg9jAq1y0koHwr7DxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/15 15:51, Vincent Guittot wrote:
> On Fri, 15 Apr 2022 at 07:42, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2022/4/14 01:30, Benjamin Segall wrote:
>>> Chengming Zhou <zhouchengming@bytedance.com> writes:
>>>
>>>> We use update_load_avg(cfs_rq, se, 0) in throttle_cfs_rq(), so the
>>>> cfs_rq->tg_load_avg_contrib and task_group->load_avg won't be updated
>>>> even when the cfs_rq's load_avg has changed.
>>>>
>>>> And we also don't call update_cfs_group(se), so the se->load won't
>>>> be updated too.
>>>>
>>>> Change to use update_load_avg(cfs_rq, se, UPDATE_TG) and add
>>>> update_cfs_group(se) in throttle_cfs_rq(), like we do in
>>>> dequeue_task_fair().
>>>
>>> Hmm, this does look more correct; Vincent, was having this not do
>>> UPDATE_TG deliberate, or an accident that we all missed when checking?
> 
> The cost of UPDATE_TG/update_tg_load_avg() is not free and the parent
> cfs->load_avg should not change because of the throttling but only the
> cfs->weight so I don't see a real benefit of UPDATE_TG.

Hi Vincent,

If the current task has dequeued before throttle_cfs_rq() when pick_next_task_fair,
the parent cfs_rq will wait to update_tg_load_avg() until the throttle_cfs_rq()
when enqueue_entity(), cause delay update of parent cfs_rq->load_avg and the
load.weight of that group_se, so the fairness of task_groups may be delayed.

update_tg_load_avg() won't touch tg->load_avg if (delta <= cfs_rq->tg_load_avg_contrib / 64).
So the cost may have been avoided if the load_avg is really unchanged ?

> 
> Chengming,
> have you faced an issue or this change is based on code review ?

Yes, this change is based on code review and git log history.

Thanks.

> 
>>>
>>> It looks like the unthrottle_cfs_rq side got UPDATE_TG added later in
>>> the two-loops pass, but not the throttle_cfs_rq side.
>>
>> Yes, UPDATE_TG was added in unthrottle_cfs_rq() in commit 39f23ce07b93
>> ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list").
>>
>>>
>>> Also unthrottle_cfs_rq I'm guessing could still use update_cfs_group(se)
>>
>> It looks like we should also add update_cfs_group(se) in unthrottle_cfs_rq().
>>
>> Thanks.
>>
>>>
>>>
>>>>
>>>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>>> ---
>>>>  kernel/sched/fair.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index d4bd299d67ab..b37dc1db7be7 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -4936,8 +4936,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>>>              if (!se->on_rq)
>>>>                      goto done;
>>>>
>>>> -            update_load_avg(qcfs_rq, se, 0);
>>>> +            update_load_avg(qcfs_rq, se, UPDATE_TG);
>>>>              se_update_runnable(se);
>>>> +            update_cfs_group(se);
>>>>
>>>>              if (cfs_rq_is_idle(group_cfs_rq(se)))
>>>>                      idle_task_delta = cfs_rq->h_nr_running;
