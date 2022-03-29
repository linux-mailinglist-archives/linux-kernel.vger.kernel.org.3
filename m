Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039C04EA59A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiC2DAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiC2DAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:00:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D892876
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:58:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id jx9so16108353pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9fotObbMpyiaSJTVr0Qrjpwe6XllSSEz1lK4iYWy6A0=;
        b=nji4DHr3QLzVlxKT2yhmeV+lZux+De0GXrDozrN9twH4AhNyvW21NCvDp3EXs5aimt
         G/2JpNvbg0Q2Mir7/x2l/OkXALngSIjrwtLv2zCDW0Bj6ay150cJbDHRQ34P1d/J3CeN
         D4zjEaD1HOR5MFwPO8WScGbEv0+Snpdh5Q1UlGFI/TqRF279SOnabnNGc4NDtxCWUhq6
         d2SRO4jPv2aHRZRKMIEg09tguYsvARXfC0agcl3GLCaN7kaZwwQbpNZ2XnQToG8Y52K2
         9UaFzBefTECsMqMpGG4p7OP79Bi0b94YaLn7NlpWo6bmfSHZ7LvJz77L5s1VFjjep0E0
         Ej+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9fotObbMpyiaSJTVr0Qrjpwe6XllSSEz1lK4iYWy6A0=;
        b=mx3C4v1HZLajE/iKzgsANTSSjMNaTcsgoe3OLhRaJdF5yvq+e1W0aT+WfqQ62bcHJl
         bg9jmz+8OY8miF1GWo1KSR1mp4a4mqwAJTkDjsN5ndZyhwxBuYrT21WmC3Iyz513MnNH
         VLyJODqDaWLwRuPyZchd1iGq7WwfwC2+q0D2T9eVT++aT4YofN/qy7Arx/eJPKAaIoeA
         eGGqcGSnVXamt5nYnMNuCMOr8xE5fq+i92zx0H4xKkptGYB2yup9YppNw0KWAvf96zxM
         pcoxR9+rJ/rF9CQvUyP9IEC8u4LJa7lxO8OfLvVTMQu/m3+SotHkVNKttNNB52r/5zNO
         7oQw==
X-Gm-Message-State: AOAM533Nmk7WnPnvm1lKy/vGbr75oCCyPSIGqCW/awhob5NWywAqt6sF
        YOQ9LRsPhLhRTvU4XT7GDqKCGw==
X-Google-Smtp-Source: ABdhPJymAs3pZnzXytpLwLpqwa6yRhdpRiao6RquaXPwapfqpjgyqQJR9zEoO53wZ4MYIwPjbyDusQ==
X-Received: by 2002:a17:90b:3a8a:b0:1c6:47fe:c9b0 with SMTP id om10-20020a17090b3a8a00b001c647fec9b0mr2206634pjb.151.1648522706664;
        Mon, 28 Mar 2022 19:58:26 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e65:74c0:705b:241a:6dc0:a4ac? ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm13943758pgd.7.2022.03.28.19.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 19:58:26 -0700 (PDT)
Message-ID: <e037ef13-dd83-a820-5b91-56d48481c7f8@bytedance.com>
Date:   Tue, 29 Mar 2022 10:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH] sched/fair: fix broken bandwidth control
 with nohz_full
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, Frederic Weisbecker <fweisbec@gmail.com>
References: <20220328110751.39987-1-zhouchengming@bytedance.com>
 <20220328132047.GD8939@worktop.programming.kicks-ass.net>
 <c0465b27-328a-1288-fb50-d4c6321c8b4d@bytedance.com>
 <YkHRmv/OcABIB0wP@hirez.programming.kicks-ass.net>
 <6fc49cff-f8a1-8b09-5a25-a64e5d07d258@bytedance.com>
 <YkHal1m3pnxGoQ1Y@hirez.programming.kicks-ass.net>
 <20220328124454.08ab6126@gandalf.local.home>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220328124454.08ab6126@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/29 00:44, Steven Rostedt wrote:
> On Mon, 28 Mar 2022 17:56:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>>> echo $$ > test/cgroup.procs
>>> taskset -c 1 bash -c "while true; do let i++; done"  --> will be throttled  
>>
>> Ofcourse.. I'm arguing that bandiwdth control and NOHZ_FULL are somewhat
>> mutually exclusive, use-case wise. So I really don't get why you'd want
>> them both.
> 
> Is it?
> 
> One use case I can see for having both is for having a deadline task that
> needs to get something done in a tight deadline. NOHZ_FULL means "do not
> interrupt this task when it is the top priority task on the CPU and is
> running in user space".

Yes, this is similar with our use-case.

> 
> Why is it mutually exclusive to have a deadline task that does not want to
> be interrupted by timer interrupts?
> 
> Just because the biggest pushers of NOHZ_FULL is for those that are running
> RT tasks completely in user space and event want to fault if it ever goes
> into the kernel, doesn't mean that's the only use case.
> 
> Chengming brought up VMs. That's a case to want to control the bandwidth,
> but also not interrupt them with timer interrupts when they are running as
> the top priority task on a CPU.

Agree. NOHZ_FULL means don't want timer interrupts when running mostly in
user space or guest mode, bandwidth control just means need to go into kernel
to schedule out only when its quota used up. We shouldn't make them mutually
exclusive.

Thanks.

> 
> -- Steve
