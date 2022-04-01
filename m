Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF84EE8C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiDAHHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbiDAHHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:07:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF26FA238
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:05:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w8so1707908pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DgqOKKf2QPWibHI++3a4qElNtqGNYsPXAymuITvgbww=;
        b=NaWjXWOVRG8zYJAo01P6Bae8CTdC/AZpskHAWVHlIfyVAnPQhoM0EHcb5BgVJAJic0
         UuO//02kyZt70g/h79qvCWj2L9j8HUMVIUAx1YVRoyE+rmKpLmppjdP3bwT/zILRfd/x
         zZrdWoBZabP0fcujPVmeQyiw2xGoAqrx+C2NpVzXwf391zKMe71GNUA67OCdDxaOoogG
         yExVwdPfqJLJhNwS+pXgGpmBtSeFW4vNfia4Vf1YYV8uEjt2OhVqzT12VvJLBGt8PcnO
         bpBIVyQyMN5VYBHRBKFg3aX5/k2WVj3QXbp71RmfwZh2J0GNlM6Appj9XMH3ruuCvWcT
         E4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DgqOKKf2QPWibHI++3a4qElNtqGNYsPXAymuITvgbww=;
        b=VHpxDO9Hq+CAD377bMKREGxqPxtjOtAi9xcgKxuC4oqQzP9LCf6hVJLcA9jpx+ED6/
         XSGeJQZibwPhbv4Ir0UXoHdVyWQbbIKt589D3ShqSxMZ0Rb2JdR41QnH6/APTvySiwx6
         W24uf8ynQO27mt3IB8lic+JHtFMdSEglGv6skhxxND2Yb1LnhPINLUSmz3jwqiubqy5/
         +ovw29l3lvryN3NpRbAuBlB3Vjnaj8+xpRNi7RgzmfTtQF4yC3gv5aUZnZN1oZzYFlQv
         MJ3Ihi3e0NuTSfhHTnRxXxN6TldDLUWFu+XbLmOdnYi70DlvTAvkWG53QHLqpKn1H/3h
         R0WA==
X-Gm-Message-State: AOAM5311CUVpgMIAwy/aoXAV/tBtCf9UX9Kg+Wuw6CPGUKkjFriH1nQK
        ScgruA93qPB1g/8Pp3cnoan/oQ==
X-Google-Smtp-Source: ABdhPJwr/N4+d353Pr+bgVkOXaa2KhIRQTdZiVrZBVriWKv8NUxHiG1Epi3pLbPTWxa+RzzF3VugSA==
X-Received: by 2002:a17:902:c745:b0:151:e8fa:629b with SMTP id q5-20020a170902c74500b00151e8fa629bmr45891827plq.90.1648796751375;
        Fri, 01 Apr 2022 00:05:51 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6d:3f10:69f0:2593:647c:15eb? ([2409:8a28:e6d:3f10:69f0:2593:647c:15eb])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090a6a0500b001c9ba10352fsm1382968pjj.25.2022.04.01.00.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 00:05:50 -0700 (PDT)
Message-ID: <2f178bad-06e1-83de-0430-b0107053f248@bytedance.com>
Date:   Fri, 1 Apr 2022 15:05:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
 <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
 <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
 <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
 <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
 <20220328124454.08ab6126@gandalf.local.home>
 <20220330182327.GO8939@worktop.programming.kicks-ass.net>
 <20220330191439.GC17246@pauld.bos.csb>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220330191439.GC17246@pauld.bos.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/3/31 03:14, Phil Auld wrote:
> Hi Peter,
> 
> On Wed, Mar 30, 2022 at 08:23:27PM +0200 Peter Zijlstra wrote:
>> On Mon, Mar 28, 2022 at 12:44:54PM -0400, Steven Rostedt wrote:
>>> On Mon, 28 Mar 2022 17:56:07 +0200
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>>>> echo $$ > test/cgroup.procs
>>>>> taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled  
>>>>
>>>> Ofcourse.. I'm arguing that bandiwdth control and NOHZ_FULL are somewhat
>>>> mutually exclusive, use-case wise. So I really don't get why you'd want
>>>> them both.
>>>
>>> Is it?
>>>
>>> One use case I can see for having both is for having a deadline task that
>>> needs to get something done in a tight deadline. NOHZ_FULL means "do not
>>> interrupt this task when it is the top priority task on the CPU and is
>>> running in user space".
>>
>> This is absolute batshit.. It means no such thing. We'll happily wake
>> another task to this CPU and re-enable the tick any instant.
>>
>> Worse; the use-case at hand pertains to cfs bandwidth control, which
>> pretty much guarantees there *will* be an interrupt.
> 
> The problem is (at least in some cases) that container orchestration userspace
> code allocates a whole CPU by setting quota == period.  Or 3 cpus as 3*period etc.
> 
> In cases where an isolated task is expected to run uninterrupted (only task in 
> the system affined to that cpu, nohz_full, nocbs etc) you can end up with it
> getting throttled even though it theoritically has enough bandwidth for the full
> cpu and therefore should never get throttled. 
> 
> There are radio network setups where the packet processing is isolated
> like this but the system as a whole is managed by container orchestration so 
> everything has cfs bandwidth quotas set.
> 
> I don't think generally the bandwidth controls in these cases are used for 
> CPU sharing (quota < period). I agree that doesn't make much sense with NOHZ_FULL
> and won't work right. 
> 
> It's doled out as full cpu(s) in these cases.
> 
> Thats not a VM case so is likely different from the one that started this thread
> but I thought I should mention it.

Yes, it's a different use-case from ours. Thanks for sharing with us. I should
put these in the patch log and send an updated version.

Thanks.

> 
> 
> Cheers,
> Phil
> 
>>
>>> Why is it mutually exclusive to have a deadline task that does not want to
>>> be interrupted by timer interrupts?
>>
>> This has absolutely nothing to do with deadline tasks, nada, noppes.
>>
>>> Just because the biggest pushers of NOHZ_FULL is for those that are running
>>> RT tasks completely in user space and event want to fault if it ever goes
>>> into the kernel, doesn't mean that's the only use case.
>>
>> Because there's costs associated with the whole thing. system entry/exit
>> get far more expensive. It just doesn't make much sense to use NOHZ_FULL
>> if you're not absoultely limiting system entry.
>>
>>> Chengming brought up VMs. That's a case to want to control the bandwidth,
>>> but also not interrupt them with timer interrupts when they are running as
>>> the top priority task on a CPU.
>>
>> It's CFS, there is nothing top priority about that.
>>
> 
