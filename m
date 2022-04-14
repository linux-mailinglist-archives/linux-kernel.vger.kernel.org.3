Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531E500A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbiDNJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiDNJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:41:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5106B70CFE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:38:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170C6139F;
        Thu, 14 Apr 2022 02:38:40 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA0993F5A1;
        Thu, 14 Apr 2022 02:38:37 -0700 (PDT)
Message-ID: <457e1f88-4eb0-53c4-a750-c8930c803272@arm.com>
Date:   Thu, 14 Apr 2022 11:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Linux 5.18-rc1] WARNING: CPU: 1 PID: 0 at
 kernel/sched/fair.c:3355 update_blocked_averages
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <b86541ea-7d96-5a24-1b65-37c24c70d3ff@gnuweeb.org>
 <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
 <675544de-3369-e26e-65ba-3b28fff5c126@gnuweeb.org>
 <000457c2-57af-95e3-7dff-2cbd99f0de5f@arm.com>
 <7f4b3fbf-c7c6-22cb-019b-520ad6a663aa@gnuweeb.org>
 <786190b3-b2cb-464d-9808-325d774c62a5@arm.com>
 <e1f9421d-e9dd-589c-bf88-407533e40797@gnuweeb.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <e1f9421d-e9dd-589c-bf88-407533e40797@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 08:03, Ammar Faizi wrote:
> On 4/7/22 5:52 PM, Dietmar Eggemann wrote:
> 
> [...]
> 
>> Looks like 21.10 finally abandoned legacy cgroup v1 and switched to v2
>> completely, which is now mounted under /sys/fs/cgroup .
>>
>> So your /sys/fs/cgroup/cgroup.controllers should contain `cpu`.
>>
>> Can you check if any of the cpu.max files under /sys/fs/cgroup has
>> something else then `max 100000` ?
> 
> I only see "max 100000" at the moment. Not sure if it may change when I
> do other activities anyway. If you need more information, I can always
> send it, so feel free to ask.

Looks like you saw the same issue which got fixed here:

https://lkml.kernel.org/r/20220414015940.9537-1-kuyo.chang@mediatek.com

So nothing to do with CFS BW control. It's triggered by a task with very
low nice value and load_avg=1 during cfs_rq attach.
