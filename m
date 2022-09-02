Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98505AA929
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiIBHyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiIBHyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:54:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53962BB698
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:54:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81A46D6E;
        Fri,  2 Sep 2022 00:54:14 -0700 (PDT)
Received: from [192.168.1.162] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CBDF3F766;
        Fri,  2 Sep 2022 00:54:05 -0700 (PDT)
Message-ID: <12b3443a-6456-4a57-95b3-dd6be5b10873@arm.com>
Date:   Fri, 2 Sep 2022 09:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
 <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 12:13, Vincent Guittot wrote:
> On Mon, 29 Aug 2022 at 12:03, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Aug 29, 2022 at 10:08:13AM +0200, Peter Zijlstra wrote:
>>> On Mon, Aug 29, 2022 at 07:54:50AM +0200, Dietmar Eggemann wrote:
>>>> From: Vincent Donnefort <vincent.donnefort@arm.com>

[...]

>>> Hurmph... I'd almost go write you something like
>>> static_call()/static_branch() but for immediates.
>>>
>>> That said; given there's only like 3 options, perhaps a few
>>> static_branch() instances work just fine ?
>>
>> Also, I'm not at all sure about exposing that as an official sysctl.
> 
> Me too, I would even make it a boot time parameter so we can remove

Isn't a sched feature even less official than a boot parameter?
But AFAIK at least some of the Android folks want to change this during
runtime and they don't have debugfs mounted.

> the new clock_task_mult clock and left shift clock_taslk or the delta
> before passing it to clock_pelt

We still need rq_clock_task_mult(rq), i.e. `rq->clock_task_mult` in
_update_idle_rq_clock_pelt() though.
