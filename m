Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E04F4C38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576683AbiDEXKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455565AbiDEQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E921710E8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:16:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF28D23A;
        Tue,  5 Apr 2022 08:16:40 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87E7F3F73B;
        Tue,  5 Apr 2022 08:16:39 -0700 (PDT)
Message-ID: <81b5bab9-1347-a2cf-dcd3-2ec1e451cef3@arm.com>
Date:   Tue, 5 Apr 2022 17:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "T.J. Alumbaugh" <talumbau@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
 <20220316210341.GD14330@worktop.programming.kicks-ass.net>
 <20220321133037.7d0d0c7f@gandalf.local.home>
 <20220329172236.48683eb5@gandalf.local.home>
 <51b21470-cd72-7ae3-6f33-2dd2e1d6b716@chromium.org>
 <20220405074855.GA30877@worktop.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220405074855.GA30877@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 09:48, Peter Zijlstra wrote:
> On Mon, Apr 04, 2022 at 04:17:54PM -0400, T.J. Alumbaugh wrote:
>>
>> On 3/29/22 17:22, Steven Rostedt wrote:
>>> On Mon, 21 Mar 2022 13:30:37 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>>> On Wed, 16 Mar 2022 22:03:41 +0100
>>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>>> Does something like the below (untested in the extreme) help?
>>>> Hi Peter,
>>>>
>>>> This has been tested extensively by the ChromeOS team and said that it does
>>>> appear to fix the problem.
>>>>
>>>> Could you get this into mainline, and tag it for stable so that it can be
>>>> backported to the appropriate stable releases?
>>>>
>>>> Thanks for the fix!
>>>>
>>> Hi Peter,
>>>
>>> I just don't want you to forget about this :-)
>>>
>>> -- Steve
>>>
>> Hi Peter,
>>
>> Just a note that if/when you send this out as a patch, feel free to add:
>>
>> Tested-by: T.J. Alumbaugh <talumbau@chromium.org>
> 
> https://lkml.kernel.org/r/20220330160535.GN8939@worktop.programming.kicks-ass.net

I still wonder if this issue happened on a system w/o:

     565790d28b1e ("sched: Fix balance_callback()")

Maybe chromeos-5.10 or earlier? In this case applying 565790d28b1e could
fix it as well.

The reason why I think the original issue happened on a system w/o
565790d28b1e is the call-stack in:

https://lkml.kernel.org/r/20220315174606.02959816@gandalf.local.home

[56064.673346] Call Trace:
[56064.676066]  dump_stack+0xb9/0x117
[56064.679861]  ? print_usage_bug+0x2af/0x2c2
[56064.684434]  mark_lock_irq+0x25e/0x27d
[56064.688618]  mark_lock+0x11a/0x16c
[56064.692412]  mark_held_locks+0x57/0x87
[56064.696595]  ? _raw_spin_unlock_irq+0x2c/0x40
[56064.701460]  lockdep_hardirqs_on+0xb1/0x19d
[56064.706130]  _raw_spin_unlock_irq+0x2c/0x40
[56064.710799]  sched_core_balance+0x8a/0x4af
[56064.715369]  ? __balance_callback+0x1f/0x9a        <--- !!!
[56064.720030]  __balance_callback+0x4f/0x9a
[56064.724506]  rt_mutex_setprio+0x43a/0x48b
[56064.728982]  task_blocks_on_rt_mutex+0x14d/0x1d5

has __balance_callback().

565790d28b1e changes __balance_callback() to __balance_callbacks()
                                                               ^
