Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372D95A0053
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiHXR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiHXR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:26:10 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9E7CA84
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:26:04 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u6so8801812qvp.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VWySvkZldTY+fvD6JpQoqkZjKQJbcVSs+XSbi2x9CeM=;
        b=Gwke+cwl23d5sJHvqeLcSUzK1lDSjhvcUPp5qj69DeIEqipqxJF6hSPQXDhArE3vKX
         8sSAsyVlfZQqvpdE7Vj+GmNvMf1N0G90PXUweTDzfO2wq/28xRbTj6oIk+W/Iwnhg9Zk
         Z1Y90XVivd4K004BNZK2tIhVZARIxhLRN4Zpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VWySvkZldTY+fvD6JpQoqkZjKQJbcVSs+XSbi2x9CeM=;
        b=qsg6vdqFyjRXrKOezoctvzPcRdqfD4U8ANb8kSL3U01C2IIwtdM9xKZGs7iRLpNB5A
         h2yG1cBg+rOYjIA+sQJVrIsgfhRNkD7HLxU2UQf4KhevnTo8OSXZt4A+8c9WkK/Mjoya
         X046YVPLQnJokhJlKemfJlopl87oC3K097M10eQTg9gMRvIEvH35llVBzlQ9aLRNbgxB
         zPRACqIjliFblA3BiCTmy5VA64W8rO31tRt3xKfoVqEDvulyqYq8FWhx1kD9l0Vh0wmK
         qwQSR+ZndqZeUxy5CxAQE6ErHkb2d/Xo4TjMbsOPZkswEcWV5xfup8L4fqtir2xSUVOh
         D9iw==
X-Gm-Message-State: ACgBeo1lv0P3Vqa5yyyUt8DftNc2/Vm4PzNpkrd9AphNzsxUpEI/wc1E
        +KX9M5R/UzcB35GO/NsYr5x5zwY70Nav+w==
X-Google-Smtp-Source: AA6agR5T/7K/Z9HpMieKWdq1haL0G1C7Ezku0CdFoFSGiaFu8raCZzf9WiAJ83e/057DCALmC2JxXA==
X-Received: by 2002:a05:6214:1941:b0:496:ca94:98aa with SMTP id q1-20020a056214194100b00496ca9498aamr142885qvk.8.1661361963720;
        Wed, 24 Aug 2022 10:26:03 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id ge8-20020a05622a5c8800b003437a694049sm13326278qtb.96.2022.08.24.10.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:26:03 -0700 (PDT)
Message-ID: <de70b840-df04-5a52-c36f-9eaed839aa7c@joelfernandes.org>
Date:   Wed, 24 Aug 2022 13:26:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
Content-Language: en-US
To:     paulmck@kernel.org, Pingfan Liu <kernelfans@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, boqun.feng@gmail.com
References: <20220822021520.6996-1-kernelfans@gmail.com>
 <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1>
 <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
 <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTup0uTqnKi79Tu+5Q0POYVdcE4UkGes8KfHXBd6VR552A@mail.gmail.com>
 <20220824162050.GA6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220824162050.GA6159@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2022 12:20 PM, Paul E. McKenney wrote:
> On Wed, Aug 24, 2022 at 09:53:11PM +0800, Pingfan Liu wrote:
>> On Tue, Aug 23, 2022 at 11:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>>>
>>> On Tue, Aug 23, 2022 at 09:50:56AM +0800, Pingfan Liu wrote:
>>>> On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
>>>>> On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
>>>>>> In order to support parallel, rcu_state.n_online_cpus should be
>>>>>> atomic_dec()
>>>>>>
>>>>>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
>>>>>
>>>>> I have to ask...  What testing have you subjected this patch to?
>>>>>
>>>>
>>>> This patch subjects to [1]. The series aims to enable kexec-reboot in
>>>> parallel on all cpu. As a result, the involved RCU part is expected to
>>>> support parallel.
>>>
>>> I understand (and even sympathize with) the expectation.  But results
>>> sometimes diverge from expectations.  There have been implicit assumptions
>>> in RCU about only one CPU going offline at a time, and I am not sure
>>> that all of them have been addressed.  Concurrent CPU onlining has
>>> been looked at recently here:
>>>
>>> https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing
>>>
>>> You did us atomic_dec() to make rcu_state.n_online_cpus decrementing be
>>> atomic, which is good.  Did you look through the rest of RCU's CPU-offline
>>> code paths and related code paths?
>>
>> I went through those codes at a shallow level, especially at each
>> cpuhp_step hook in the RCU system.
> 
> And that is fine, at least as a first step.
> 
>> But as you pointed out, there are implicit assumptions about only one
>> CPU going offline at a time, I will chew the google doc which you
>> share.  Then I can come to a final result.
> 
> Boqun Feng, Neeraj Upadhyay, Uladzislau Rezki, and I took a quick look,
> and rcu_boost_kthread_setaffinity() seems to need some help.  As it
> stands, it appears that concurrent invocations of this function from the
> CPU-offline path will cause all but the last outgoing CPU's bit to be
> (incorrectly) set in the cpumask_var_t passed to set_cpus_allowed_ptr().
> 
> This should not be difficult to fix, for example, by maintaining a
> separate per-leaf-rcu_node-structure bitmask of the concurrently outgoing
> CPUs for that rcu_node structure.  (Similar in structure to the
> ->qsmask field.)
> 
> There are probably more where that one came from.  ;-)

Should rcutree_dying_cpu() access to rnp->qsmask have a READ_ONCE() ? I was
thinking grace period initialization or qs reporting paths racing with that. Its
just tracing, still :)

Thanks,

- Joel
