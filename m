Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F644B6BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiBOMTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:19:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiBOMTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:19:48 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8C1074E6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:19:39 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id f6so13583481pfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t4VIfPOAozNC70kbDOl2dbBGsgdLxKSP4QJrhlwbu5k=;
        b=yyPjnmR65ZCx8CliAl5MrjTv9+HVfnSjBHgKjhUGGWHpNtMQ3MrbqjhZKmbJ4Ko+bx
         LumaWc5vrjhUHkrk/GCHfhEIlw9m+hQrIdOHvCwdRhQ1vbLqCIPgfRipClamscTA3LDw
         SwC3RN+HIeuaP2HLdtnAivns5km7Haf5yjKAJo2tIX7G6Fh+5ia+S7KGem6DBgSpCOTR
         Sn84/Y8jlIekJSXbhd8KTg4O1LOakBoFxYDA8U1ADohldqKVPkYVOFRPUt7MaCC+TSib
         TFrGXB+d33NMx/ESGHZHd6JMgsDxUI6Yyjf9WypdjvJDM1ml6XV/fgLioq40ccaxEFy1
         R/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t4VIfPOAozNC70kbDOl2dbBGsgdLxKSP4QJrhlwbu5k=;
        b=On4sAnvfbYhmzb1qjMhqi7YBpuBEWYlnR19C7rbfr1rj2TEupfFXsvZwDB0xWYSpCF
         IXZtmEu7l5VK9moRfYcd5brzA403SjTu/KtIAZT5X9i/r+bFLi2KtRAdz5BpJ4VCPX43
         zR59sCR4W5VYBkumTWKa/wN/D1/QiJ9ziAsIvqmhnestb6G9pHgTBXAntwhNBMBD6+H1
         tYPe+PYNl2JuYMHUonrtEa/jWo709y7Uzk6bgkRJAB2tFqa256hCiyRNAAvCHlT/0FfJ
         2yR4sidyGn1CCgk8gxBqvYNGB/skSX5yac8/ARRzzsAq74vMw+D87IofurO9et7XEC8h
         ik4Q==
X-Gm-Message-State: AOAM532BAF+NuWSLrCeFmPeZwaxWVJ14Ww5iPJCnZ/X2q7cMX6j5BfgB
        BW5C9My6QpCScuUqbLcAjNS6nUIpK9J7Jg==
X-Google-Smtp-Source: ABdhPJyyX/bNQ6faE4RjKlHG3VF68qqDZQ25cF/jMO0cIIJIK7Zt3bWZ6ezKMnlD1KgSLiGYM7nuuw==
X-Received: by 2002:a05:6a00:2444:: with SMTP id d4mr4123710pfj.46.1644927578757;
        Tue, 15 Feb 2022 04:19:38 -0800 (PST)
Received: from [10.255.13.118] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id s9sm5706044pjk.1.2022.02.15.04.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:19:38 -0800 (PST)
Message-ID: <b3f9e3c5-679d-1a15-f797-5e211d543a68@bytedance.com>
Date:   Tue, 15 Feb 2022 20:19:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [External] Re: [PATCH] sched/cpuacct: fix charge percpu cpuusage
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tj@kernel.org, arbn@yandex-team.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Minye Zhu <zhuminye@bytedance.com>
References: <20220213120118.93471-1-zhouchengming@bytedance.com>
 <YgoqPT67g2NcV/eH@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YgoqPT67g2NcV/eH@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/14 6:09 下午, Peter Zijlstra wrote:
> On Sun, Feb 13, 2022 at 08:01:18PM +0800, Chengming Zhou wrote:
>> The cpuacct_account_field() is always called by the current task
>> itself, so it's ok to use __this_cpu_add() to charge the tick time.
>>
>> But cpuacct_charge() maybe called by update_curr() in load_balance()
>> on a random CPU, different from the CPU on which the task is running.
>> So __this_cpu_add() will charge that cputime to a random incorrect CPU.
>>
>> Reported-by: Minye Zhu <zhuminye@bytedance.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Can I get a Fixes: tag for this?

Yes, Fixes: 73e6aafd9ea8 ("sched/cpuacct: Simplify the cpuacct code")
I will send a patch v2 to add it.

> 
>> ---
>>  kernel/sched/cpuacct.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
>> index 3d06c5e4220d..75fbc212cb71 100644
>> --- a/kernel/sched/cpuacct.c
>> +++ b/kernel/sched/cpuacct.c
>> @@ -335,11 +335,12 @@ static struct cftype files[] = {
>>  void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>>  {
>>  	struct cpuacct *ca;
>> +	unsigned int cpu = task_cpu(tsk);
>>  
>>  	rcu_read_lock();
>>  
>>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>> -		__this_cpu_add(*ca->cpuusage, cputime);
>> +		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
>>  
>>  	rcu_read_unlock();
>>  }
> 
> Also, while we there, what about this as an additional patch?
> 
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -334,15 +334,13 @@ static struct cftype files[] = {
>   */
>  void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  {
> -	struct cpuacct *ca;
>  	unsigned int cpu = task_cpu(tsk);
> +	struct cpuacct *ca;
>  
> -	rcu_read_lock();
> +	lockdep_assert_rq_held(cpu_rq(cpu));
>  
>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>  		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
> -
> -	rcu_read_unlock();
>  }
>  
>  /*

This is much better, I will send an additional patch to include this.

Thanks.

