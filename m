Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC385392CB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344834AbiEaNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbiEaNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:55:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9CC73
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:55:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso1135363pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ja22+6JGi4Fw6cG9r+qZlGyNX9xX4a0a15S3HAE/TcU=;
        b=jh1SxPxCjFoDs6Jrfq52420Fm/5GD8bQks9zwjw4yit43QDo5WERW5d+nYssrZDRdY
         VW9oF8WpU+xlIEgp//5yokj8FVwNXpcxGvD57ECKpieLnXooOiJyl3ftTrJh+lCyYuUe
         0TYQ7fM5I3jU18C1MUIIQQPJKiBi/GohQUl4+6IDKwfdjXu45ljVziR9Rz/vyPTsgKNL
         LaeCJcrHVSBPmH8R9zaqoHjQx00NwxCz2sdfEAN6u+3HSQZHde2r7qjQUXuhcXtvEuEc
         1LVO1xfl2TuZl1WTkTKPpKOOoznPObXJY4SJ1Ccam9YHgbKztWjXzOIdjlsczqOshuY1
         v9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ja22+6JGi4Fw6cG9r+qZlGyNX9xX4a0a15S3HAE/TcU=;
        b=5z8jJYR121OPMlZijXBYsLue20su7NLg06xFnLk0SOutEipi8HHvgGmr6tCSE7lKOf
         Nb5oqLK8ByVaJsBq5+iN3yqxH2xHLq86Y6LLwpkaLP+8/pdgFysxOdXsYQV+YGC9lx2K
         6Zg1zWmC1YnHJ5Qr4YKeZandT+jH6s8KwSNb6EJajfUdiKMRx7ejK1WGS52lohNGbINf
         oQ9nbHlEo/zQXMdIt7gg45bL3UbHxuxzZJsI87QN0fU+7+Ryxtq5D4+mSlX1An19U+ib
         5mE+AXmp9zeBUxy3U097JTx6qfUiajUrv7xwkUqD5Nqwnx5UnywmfACjvmmuZ8c6AJGg
         t2UA==
X-Gm-Message-State: AOAM530QhQ5nFFqEASmkJbG2TF5JksrgPC5lOkFwWfqjf5BB1Vnyh+xd
        10HworQL2vuajT2baA5x+Z9AZw==
X-Google-Smtp-Source: ABdhPJxLwYtuT4vmWIQfmLCoFeGmwmvTfCgz7DIbOKDWEwiWcs8E3dOHmMUzEkSYr11zLhkCHhzWQQ==
X-Received: by 2002:a17:902:ef43:b0:156:9c5d:b0fe with SMTP id e3-20020a170902ef4300b001569c5db0femr60960620plx.158.1654005332900;
        Tue, 31 May 2022 06:55:32 -0700 (PDT)
Received: from [10.4.211.178] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b0015e8d4eb26esm11165757plt.184.2022.05.31.06.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 06:55:32 -0700 (PDT)
Message-ID: <270c2315-7ba5-4bbb-ee5c-38cc8a57e628@bytedance.com>
Date:   Tue, 31 May 2022 21:55:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [External] Re: [PATCH v3 2/2] sched/fair: optimize and simplify
 rq leaf_cfs_rq_list
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        odin@uged.al, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220526103929.14976-1-zhouchengming@bytedance.com>
 <20220526103929.14976-3-zhouchengming@bytedance.com>
 <CAKfTPtADKqVSvUFmLRPCU_XGVvf3wme0EnnvPf1Q39HEs=VqRw@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKfTPtADKqVSvUFmLRPCU_XGVvf3wme0EnnvPf1Q39HEs=VqRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/5/30 15:52, Vincent Guittot wrote:
> On Thu, 26 May 2022 at 12:40, Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
[...]
>> @@ -11257,9 +11218,10 @@ static inline bool vruntime_normalized(struct task_struct *p)
>>   */
>>  static void propagate_entity_cfs_rq(struct sched_entity *se)
>>  {
>> -       struct cfs_rq *cfs_rq;
>> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>
>> -       list_add_leaf_cfs_rq(cfs_rq_of(se));
>> +       if (!throttled_hierarchy(cfs_rq))
>> +               list_add_leaf_cfs_rq(cfs_rq);
>>
>>         /* Start to propagate at parent */
>>         se = se->parent;
>> @@ -11268,7 +11230,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>>                 cfs_rq = cfs_rq_of(se);
>>
> 
>  you can break  if the cfs is throttled because it's sched_entity has
> been dequeued. In this case we check if the cfs is throttled not if
> the hierarchy is throttled
> 
> +               if (cfs_rq_throttled(cfs_rq))
> +                       break;
> 

This propagate part still make me confused. :-)

I wonder if you think we should change like this:

static void propagate_entity_cfs_rq(struct sched_entity *se)
{
        struct cfs_rq *cfs_rq = cfs_rq_of(se);

        if (cfs_rq_throttled(cfs_rq))			--> break if cfs is throttled
                return;

        if (!throttled_hierarchy(cfs_rq))
                list_add_leaf_cfs_rq(cfs_rq);

        /* Start to propagate at parent */
        se = se->parent;

        for_each_sched_entity(se) {
                cfs_rq = cfs_rq_of(se);

                if (cfs_rq_throttled(cfs_rq))		--> break if cfs is throttled
                        break;

                update_load_avg(cfs_rq, se, UPDATE_TG); --> throttled cfs_rq->prop not updated
                if (!throttled_hierarchy(cfs_rq))
                        list_add_leaf_cfs_rq(cfs_rq);
        }
}



If I understand right, we should update_load_avg() until cfs_rq_throttled(),
including that throttled cfs_rq? So we can go on propagating when unthrottle.

Maybe like this?

static void propagate_entity_cfs_rq(struct sched_entity *se)
{
        struct cfs_rq *cfs_rq = cfs_rq_of(se);

        if (cfs_rq_throttled(cfs_rq))			--> break if cfs is throttled
                return;

        if (!throttled_hierarchy(cfs_rq))
                list_add_leaf_cfs_rq(cfs_rq);

        /* Start to propagate at parent */
        se = se->parent;

        for_each_sched_entity(se) {
                cfs_rq = cfs_rq_of(se);

                update_load_avg(cfs_rq, se, UPDATE_TG);	--> update throttled cfs_rq->prop

                if (cfs_rq_throttled(cfs_rq))		--> break if cfs is throttled
                        break;

                if (!throttled_hierarchy(cfs_rq))
                        list_add_leaf_cfs_rq(cfs_rq);
        }
}


Thanks!


>>                 update_load_avg(cfs_rq, se, UPDATE_TG);
>> -               list_add_leaf_cfs_rq(cfs_rq);
>> +               if (!throttled_hierarchy(cfs_rq))
>> +                       list_add_leaf_cfs_rq(cfs_rq);
>>         }
>>  }
>>  #else
>> --
>> 2.36.1
>>
