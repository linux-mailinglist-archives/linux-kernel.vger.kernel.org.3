Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5A53B2CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiFBEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiFBEwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:52:41 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05CC70
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:52:38 -0700 (PDT)
X-UUID: 4ff4440716a24f549134accc90c5eaa0-20220602
X-Spam-Fingerprint: 0
X-GW-Reason: 13103
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 91
        audit/email.address 1
X-CPASD-INFO: a618c05e78804ae1b72ad106831ec851@qoZrWJBiY5VjWHp8g6Swa4JoYpGUXVC
        Fem1RlZFoYVGVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3sHhrWJNeZQ==
X-CLOUD-ID: a618c05e78804ae1b72ad106831ec851
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:158.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:223.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:10,DUF:42064,ACD:302,DCD:404,SL:0,EISP:0,AG:0,CFC:0.786,CFSR:0.04,UAT:0
        ,RAF:2,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 4ff4440716a24f549134accc90c5eaa0-20220602
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 4ff4440716a24f549134accc90c5eaa0-20220602
X-User: huangbing@kylinos.cn
Received: from [172.20.108.189] [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <huangbing@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 460479508; Thu, 02 Jun 2022 10:59:48 +0800
Message-ID: <6940568c-a9e9-bf6d-0071-25e00c42f621@kylinos.cn>
Date:   Thu, 2 Jun 2022 10:56:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] sched/fair: static cpumasks for load balance
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org
Cc:     brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        vincent.guittot@linaro.org
References: <20220531031255.30966-1-huangbing@kylinos.cn>
 <b1c1bfa7-f1ba-8590-65fb-df6b8c0d1168@arm.com>
From:   "huangbing@kylinos" <huangbing@kylinos.cn>
In-Reply-To: <b1c1bfa7-f1ba-8590-65fb-df6b8c0d1168@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/22 16:45, Dietmar Eggemann wrote:
> On 31/05/2022 05:12, Bing Huang wrote:
>> The both cpu mask load_balance_mask and select_idle_mask just only used
>> in fair.c, but allocation in core.c in CONFIG_CPUMASK_OFFSTACK=y case,
>> and global via declare per cpu variations. More or less, it looks wired.
>>
>> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
>> ---
>>
>>   v2: move load_balance_mask and select_idle_mask allocation from
>> sched_init() to init_sched_fair_class()
> This would align CFS with RT (local_cpu_mask) and DL
> (local_cpu_mask_dl).
>
> [...]
>
>> @@ -11841,6 +11841,16 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
>>   __init void init_sched_fair_class(void)
>>   {
>>   #ifdef CONFIG_SMP
>      `int i` missing for DEBUG_PER_CPU_MAPS/CONFIG_CPUMASK_OFFSTACK case.
sorry,my fault.
>
>> +
>> +#ifdef CONFIG_CPUMASK_OFFSTACK
>> +	for_each_possible_cpu(i) {
>> +		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
>> +			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>> +		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
>> +			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>> +	}
>> +#endif
>> +
> What about:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 98319b654788..9ef5133c72d6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11811,15 +11811,14 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
>   __init void init_sched_fair_class(void)
>   {
>   #ifdef CONFIG_SMP
> +       int i;
>   
> -#ifdef CONFIG_CPUMASK_OFFSTACK
>          for_each_possible_cpu(i) {
> -               per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> -                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> -               per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
> -                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +               zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i),
> +                                       GFP_KERNEL, cpu_to_node(i));
> +               zalloc_cpumask_var_node(&per_cpu(select_idle_mask, i),
> +                                       GFP_KERNEL, cpu_to_node(i));
>          }
> -#endif
>
> to get rid of the #ifdef ? We do the same for RT (local_cpu_mask) and DL
> (local_cpu_mask_dl).
good suggestion, thanks very much. happy to do that.
>
> [...]
