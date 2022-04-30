Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97745515AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382257AbiD3H15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiD3H1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:27:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29E84EC8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:24:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so340936pjv.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=UK4UjZH71X3EUoef8c/h5m7QQlnYpArG780O4uR8mE8=;
        b=g5RyF3woRn6ot+TgA+Jqb9YI0Svu39gOBN9h/atb0554eqK2GyDbA1nt9g5wLkjyHe
         MKkNFhYfu4RdLhFGsuN+pGMOFUeXSQsWKL5SC64mMWl9GJ7sROZdNuxOhFVEusZJO6tw
         R4K/bvVEGeWjnNO+qTIO8DE+U97d0ki8qfZCXyM4zdc2VbY+EVVAaMwW3Q5n9RP5D6E2
         0F9G03ZiuICl4EpfmGxBstWKQwtvn6c4nozX4cTwffsCkAI3fZ0xYv9I+udbwkLTf688
         RcRlZNtp8/LCOJt90aQtl8d+ca82uhQC/dSg9la+cEOu7nqWr5nKjJYg0avsiguXK9VN
         RG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UK4UjZH71X3EUoef8c/h5m7QQlnYpArG780O4uR8mE8=;
        b=R+J0R47FVs67RPyBeYtnUDTQA9NC3hCHb3UB1JCwY1Hs0H+Bla5EughQxEg0iGBwZ/
         f3ljICgdaowIHt79hTzDsPdwAXJM1JMJNrzJ/BXpDsdIrn5r8PSsy1qdtYAMsp4/4X24
         Hcf/mkm3teVPM6LNNhuT4r8uzQjFs8BpbHE1ISbkX4+2wUlp+YH2Z3RGzpz60mlDSG6q
         kK0IfVCSyyWZS2PbEbSr3bWCCf6iIWne7SEpQK5CJJEdVlsERNhEPzHK/S9vo1wi5eNf
         5VBcBV/qsiVd/rXuf9XpcZlGp64D7fE/5vnG4AlL0z5lB7Qg3CXaICvMkD7L+gbFIisF
         Op2g==
X-Gm-Message-State: AOAM531rGq5AfloVgyV6FFGLo53EvsE1fmibvPwcc3AhFxzjy9Z1/uCN
        iQUZFLdG651bnvsSJy1xDMYVjw==
X-Google-Smtp-Source: ABdhPJy7QSJSN+8UlCFHm60tKSbj/OP51zjCGDbuIKlteQFP5S0Wdd25siktlg23W4HKoWhuMdms1g==
X-Received: by 2002:a17:90b:314d:b0:1db:c8b6:e9d0 with SMTP id ip13-20020a17090b314d00b001dbc8b6e9d0mr3014471pjb.99.1651303472649;
        Sat, 30 Apr 2022 00:24:32 -0700 (PDT)
Received: from ?IPV6:240e:390:e65:5bb0:6169:3d99:b5ff:4a84? ([240e:390:e65:5bb0:6169:3d99:b5ff:4a84])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a6d8800b001cd4c118b07sm12464784pjk.16.2022.04.30.00.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 00:24:32 -0700 (PDT)
Message-ID: <9b411c72-eda8-e98f-4e03-526ea645a7db@bytedance.com>
Date:   Sat, 30 Apr 2022 15:24:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [External] Re: [PATCH v3 1/2] sched/core: Avoid obvious double
 update_rq_clock warning
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20220427080014.18483-1-jiahao.os@bytedance.com>
 <20220427080014.18483-2-jiahao.os@bytedance.com>
 <0058249a-5f9f-9f67-db5b-f7c3c10c3729@arm.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <0058249a-5f9f-9f67-db5b-f7c3c10c3729@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/29 Dietmar Eggemann wrote:
> On 27/04/2022 10:00, Hao Jia wrote:
> 
> [...]
> 
> LGTM, comments are only nit-picks.
> 
>> Since we directly use raw_spin_rq_lock() to acquire rq lock instead of
>> rq_lock(), there is no corresponding change to rq->clock_update_flags.
>> In particular, we have obtained the rq lock of other cores,
> 
> s/cores/CPUs, with SMT, a core can have multiple (logical) CPUs.

Thanks for your review comments.
I will do it in patch v4.
Thanks.

> 
> [...]
> 
>> So we need to clear RQCF_UPDATED of rq->clock_update_flags synchronously
>> to avoid the WARN_DOUBLE_CLOCK warning.
> 
> Why you mention `synchronously` here? Isn't this obvious? (1)

I will do it in patch v4.
Thanks.

> 
> [...]
> 
>> @@ -1833,6 +1833,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
>>   static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
>>   {
>>   	struct rq *rq;
>> +	struct rq_flags rf;
> 
> -       struct rq *rq;
>          struct rq_flags rf;
> +       struct rq *rq;
> 
> Use reverse fir tree order for variable declarations.
> (./Documentation/process/maintainer-tip.rst)

I will do it in patch v4.
Thanks.

> 
> [...]
> 
>> +#ifdef CONFIG_SCHED_DEBUG
>> +/*
>> + * In double_lock_balance()/double_rq_lock(), we use raw_spin_rq_lock() to acquire
>> + * rq lock instead of rq_lock(). So at the end of these two functions we need to
>> + * call double_rq_clock_clear_update() synchronously to clear RQCF_UPDATED of
>                                            ^^^^^^^^^^^^^
>                                            (1)
> 
>> + * rq->clock_update_flags to avoid the WARN_DOUBLE_CLOCK warning.
>> + */
>> +static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
>> +{
>> +	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>> +	/*
>> +	 * If CONFIG_SMP is not defined, rq1 and rq2 are the same,
>> +	 * so we just clear RQCF_UPDATED one of them.
>> +	 */
> 
> Maybe shorter:
> 
>        /* rq1 == rq2 for !CONFIG_SMP, so just clear RQCF_UPDATED once. */

I will do it in patch v4.
Thanks.
> 
> [...]
> 
>> @@ -2543,14 +2564,15 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
>>   	__acquires(busiest->lock)
>>   	__acquires(this_rq->lock)
>>   {
>> -	if (__rq_lockp(this_rq) == __rq_lockp(busiest))
>> -		return 0;
>> -
>> -	if (likely(raw_spin_rq_trylock(busiest)))
>> +	if (__rq_lockp(this_rq) == __rq_lockp(busiest) ||
>> +		likely(raw_spin_rq_trylock(busiest))) {
> 
> indention:
> 
>          if (__rq_lockp(this_rq) == __rq_lockp(busiest) ||
> -               likely(raw_spin_rq_trylock(busiest))) {
> +           likely(raw_spin_rq_trylock(busiest))) {

Thanks again for your review and suggestion.
I will do it in patch v4.
Thanks.

> 
> [...]
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Tested on Arm64 Juno with mainline & preempt-rt (linux-5.17.y-rt).
