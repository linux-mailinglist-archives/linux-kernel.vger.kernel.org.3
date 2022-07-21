Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82FC57D1AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiGUQi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiGUQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:38:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580337C18E;
        Thu, 21 Jul 2022 09:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0707FB8258F;
        Thu, 21 Jul 2022 16:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43162C3411E;
        Thu, 21 Jul 2022 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658421531;
        bh=XQuaI9JDOz1OBn9ObdPK5HEn8VD/Fw7EKM1NPRG5An0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M/Uh2T7kTP3dCVvPz+LAe+f4IOJVm/09AEsKH1uHLzIeH+V/Lx5oQOb12/zYBuTcw
         N1p+JBreNfBebraTaMw1n9SjLLYNZZJrFvmr1iEVwv03R9KyxYQq3xevqZZQIDNPIs
         R/wZo3Qwr3IRUy/etzDCIiQNtDO8hwIzRK+SGae6Jq14nfqYBF4XyELRPlXL6gjg5d
         Deo3f281WwJqbDQmNquxwYZ5OQ9it9JgbfccUmg7p7+yYICqQUyOmPdWTv5wGVdI8l
         138Bn41gCCM33yVu6h323aRWbTS0n3TScA8H8e/h7jVlir3y3K1bGZnIPN4p/TSfQU
         fH4ZYEz4oYeMg==
Message-ID: <26c5c095-2aff-3c7b-80ad-7b21702a3fdd@kernel.org>
Date:   Thu, 21 Jul 2022 18:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V6 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1658244826.git.bristot@kernel.org>
 <9ffc05b67fff087413143a420373731e0e34eef4.1658244826.git.bristot@kernel.org>
 <20220720160606.3e672b55@gandalf.local.home>
 <3c0a4cb5-f88f-ec5f-e614-d1e8ceb036c2@kernel.org>
 <20220721095924.151c6f5d@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220721095924.151c6f5d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 15:59, Steven Rostedt wrote:
> On Thu, 21 Jul 2022 14:08:38 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> On 7/20/22 22:06, Steven Rostedt wrote:
>>>> +/*												\
>>>> + * da_monitor_enabled_##name - checks if the monitor is enabled					\
>>>> + */												\
>>>> +static inline bool da_monitor_enabled_##name(void)						\
>>>> +{												\  
>>> Should we add a:
>>>
>>> 	smp_rmb();
>>>
>>> here? And then a smp_wmb() where these switches get updated?
>>>  
>>
>> Makes sense.
>>
>> Should I also add the READ_ONCE/WRITE_ONCE? like
>>
>> smp_rmb()
>> READ_ONCE(var)
>>
>> WRITE_ONCE(var, value)
>> smp_wmb()
> 
> I'm not sure the WRITE_ONCE() is necessary with the memory barriers.
> Because they should also prevent gcc from doing anything after that
> barrier. As Linus once stated, most cases WRITE_ONCE() is useless, but it's
> fine to keep more for annotation (as to pair with the READ_ONCE()) than for
> anything that is critical.

Ack, I can keep for annotation.

>>
>> for all these on/off knobs, or just the barriers?
>>
>>> I guess how critical is it that these turn off immediately after the switch
>>> is flipped?  
>>
>> It is not critical to continue the execution of those that have already crossed by
>> the variable. Still, waiting for the tracepoints to finish their execution before
>> returning to the user-space task that disabled the variable might be a good thing.
> 
> You mean after disabling, to wait for the tracepoints that are currently
> running to end?

yes, after disabling tracepoints.

>>
>> IIRC, we can do that via RCU... like, synchronize_rcu()?
> 
> We have tracepoint_synchronize_unregister() that does that, as some
> traceponits use SRCU and not RCU.

yep, that is it!
 
-- Daniel

> -- Steve
> 
> 
>>
>>>> +	/* global switch */									\
>>>> +	if (unlikely(!rv_monitoring_on()))							\
>>>> +		return 0;									\
>>>> +												\
>>>> +	/* monitor enabled */									\
>>>> +	if (unlikely(!rv_##name.enabled))							\
>>>> +		return 0;									\
>>>> +												\
>>>> +	return 1;										\
>>>> +}												\
>>>> +												\  
> 

