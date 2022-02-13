Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3A4B3C86
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiBMR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:27:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiBMR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:27:03 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323552F7;
        Sun, 13 Feb 2022 09:26:57 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee62.dynamic.kabel-deutschland.de [95.90.238.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7352161E64846;
        Sun, 13 Feb 2022 18:26:54 +0100 (CET)
Message-ID: <18464474-77e9-1a53-265f-b9718d43e8cd@molgen.mpg.de>
Date:   Sun, 13 Feb 2022 18:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: BUG: sleeping function called from invalid context at
 include/linux/sched/mm.h:256
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
References: <244218af-df6a-236e-0a52-268247dd8271@molgen.mpg.de>
 <20220212234802.GR4285@paulmck-ThinkPad-P17-Gen-1>
 <3fa9ec7e-0bc1-b972-c21b-473a9ef2e15f@molgen.mpg.de>
 <20220213144542.GT4285@paulmck-ThinkPad-P17-Gen-1>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220213144542.GT4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul,


Am 13.02.22 um 15:45 schrieb Paul E. McKenney:
> On Sun, Feb 13, 2022 at 08:39:13AM +0100, Paul Menzel wrote:

>> Am 13.02.22 um 00:48 schrieb Paul E. McKenney:
>>> On Sun, Feb 13, 2022 at 12:05:50AM +0100, Paul Menzel wrote:
>>
>> […]
>>
>>>> Running rcutorture on the POWER8 system IBM S822LC with Ubuntu 20.10, it
>>>> found the bug below. I more or less used rcu/dev (0ba8896d2fd7
>>>> (lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe))
>>>> [1]. The bug manifested for the four configurations below.
>>>>
>>>> 1.  results-rcutorture-kasan/SRCU-T
>>>> 2.  results-rcutorture-kasan/TINY02
>>>> 3.  results-rcutorture/SRCU-T
>>>> 4.  results-rcutorture/TINY02
>>>
>>> Adding Frederic on CC...
>>>
>>> I am dropping these three for the moment:
>>>
>>> 0ba8896d2fd75 lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe
>>> efa8027149a1f tick/rcu: Stop allowing RCU_SOFTIRQ in idle
>>> d338d22b9d338 tick/rcu: Remove obsolete rcu_needs_cpu() parameters
>>>
>>> Though it might be that these are victims of circumstance, in other
>>> words, that the original bug that Paul Menzel reported was caused by
>>> something else.
>>
>> Even without these three patches, the issue is reproducible. I tested commit
>> 7a935b7ac61b (tools/nolibc/stdlib: implement abort()).
> 
> Ah, I thought you were saying that the issue was caused by them.
> 
> I will put them back.  And apologies to Frederic for kicking his
> patches out!

Sorry for being unclear.

> Are you able to bisect to see what commit introduced the problem?

I have not checked yet, if it’s a regression. I am going to test it next 
week.

[…]


Kind regards,

