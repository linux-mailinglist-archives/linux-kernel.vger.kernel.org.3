Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE24E4326
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiCVPkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiCVPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:40:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DACA606F0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=lEHQr9MFDVRybsndbZDyXYT1aET9Z4Ka7yxHnPlx84Q=; b=KrRSfV215S6/eudAsgON0tFVGR
        YnYqmbTnfVE+kg497gwJZxPC7V8GQapq70MrAOyWZQjY/9X7qukDlghSzs+Vh0+Rcjc3OfIfeCW9S
        FB3qE6Z3182DQ7aFxEAgqk8EdiA46jZOdqfw5+qihx5O8BvIpsVwZo74tnrz84ImO23pLCrjjTg9v
        OnvLVlcfaVhaXGNT5f5I4fbetj3p4Ub28rAorBCueKl8q3BI0n3/bIVazphLJDKYSDKxTyFdO7T50
        SK1140ncI2YiEOsELwcgSGwwT8pXwD8tNoSBa63jYb+XVATrrfeLnFiT07OkkGowkps6nkGRykSWx
        VrTirN2g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgbB-00Bik7-KP; Tue, 22 Mar 2022 15:39:05 +0000
Message-ID: <8ef010a1-d28a-a9f0-78cc-1ad8c40cfb59@infradead.org>
Date:   Tue, 22 Mar 2022 08:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] scheduler updates for v5.18
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <YjhZUezhnamHAl0H@gmail.com>
 <YjiddAnoCCz7Tbt3@dev-arch.thelio-3990X> <YjmAzX9kSeSjumKd@gmail.com>
 <YjnsJkUl5mO22mzg@dev-arch.thelio-3990X>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YjnsJkUl5mO22mzg@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/22 08:32, Nathan Chancellor wrote:
> On Tue, Mar 22, 2022 at 08:54:53AM +0100, Ingo Molnar wrote:
>>
>> * Nathan Chancellor <nathan@kernel.org> wrote:
>>
>>> Hi Ingo,
>>>
>>> On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
>>>> Ingo Molnar (17):
>>>>       sched/headers: Fix header to build standalone: <linux/sched_clock.h>
>>>>       sched/headers: Add header guard to kernel/sched/sched.h
>>>>       sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
>>>>       sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
>>>>       sched/headers: Add initial new headers as identity mappings
>>>>       sched/headers: Fix comment typo in kernel/sched/cpudeadline.c
>>>>       sched/headers: Make the <linux/sched/deadline.h> header build standalone
>>>>       sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there
>>>>       sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
>>>>       sched/headers: Standardize kernel/sched/sched.h header dependencies
>>>>       sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
>>>>       sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
>>>>       sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
>>>>       sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
>>>>       sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
>>>>       sched/headers: Only include <linux/entry-common.h> when CONFIG_GENERIC_ENTRY=y
>>>>       headers/prep: Fix header to build standalone: <linux/psi.h>
>>>
>>> This series regresses ARCH=arm allmodconfig:
>>>
>>> $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig kernel/sched/
>>> In file included from kernel/sched/fair.c:52:
>>> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>>>    87 | # include <asm/paravirt_api_clock.h>
>>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>> make[3]: *** [scripts/Makefile.build:288: kernel/sched/fair.o] Error 1
>>> In file included from kernel/sched/core.c:81:
>>> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>>>    87 | # include <asm/paravirt_api_clock.h>
>>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>> make[3]: *** [scripts/Makefile.build:288: kernel/sched/core.o] Error 1
>>> In file included from kernel/sched/build_policy.c:33:
>>> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>>>    87 | # include <asm/paravirt_api_clock.h>
>>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>> make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_policy.o] Error 1
>>> In file included from kernel/sched/build_utility.c:52:
>>> kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
>>>    87 | # include <asm/paravirt_api_clock.h>
>>>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> compilation terminated.
>>> make[3]: *** [scripts/Makefile.build:288: kernel/sched/build_utility.o] Error 1
>>> make[3]: Target '__build' not remade because of errors.
>>> make[2]: *** [scripts/Makefile.build:550: kernel/sched] Error 2
>>>
>>> Randy Dunlap has sent a patch that fixes it, which I just reviewed:
>>>
>>> https://lore.kernel.org/r/20220316204146.14000-1-rdunlap@infradead.org/
>>
>> Applied, thanks Nathan!
>>
>>> It would be nice if this could be taken with the pull (or submitted with
>>> the pull in a v2 as I see Qian's comment) to avoid regressing the build.
>>
>> Will do.
> 
> Thank you a lot for the quick response and fix, I appreciate it!

and my thanks to both of you for taking care of that.

-- 
~Randy
