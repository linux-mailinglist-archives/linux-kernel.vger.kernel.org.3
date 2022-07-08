Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6856B9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiGHMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiGHMei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:34:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8384D76948
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:34:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4141D6E;
        Fri,  8 Jul 2022 05:34:37 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A303F70D;
        Fri,  8 Jul 2022 05:34:35 -0700 (PDT)
Message-ID: <f15b27fa-6802-6bab-5d5c-93f7134debec@arm.com>
Date:   Fri, 8 Jul 2022 14:34:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] sched/deadline: Use sched_dl_entity's dl_density in
 dl_task_fits_capacity()
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
References: <20220629122053.287165-1-dietmar.eggemann@arm.com>
 <20220629122053.287165-4-dietmar.eggemann@arm.com>
 <CAKfTPtAFC5Pk7nfJvSYTmaQNayDoGy40kTnT9j8-yZpDezKNYw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtAFC5Pk7nfJvSYTmaQNayDoGy40kTnT9j8-yZpDezKNYw@mail.gmail.com>
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

On 06/07/2022 12:47, Vincent Guittot wrote:
> On Wed, 29 Jun 2022 at 14:21, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

>>  static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
>>  {
>>         unsigned long cap = arch_scale_cpu_capacity(cpu);
>>
>> -       return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
>> +       return cap >= p->dl.dl_density >> SCHED_CAPACITY_SHIFT;
> 
> There is no direct relation between BW_SHIFT and SCHED_CAPACITY_SHIFT
> and we can change one without modifying the other.
> 
> Should you use (BW_SHIFT-SCHED_CAPACITY_SHIFT) instead of SCHED_CAPACITY_SHIFT ?

Yes, that's better, similar to cpu_bw_dl(). Thanks!

[...]
