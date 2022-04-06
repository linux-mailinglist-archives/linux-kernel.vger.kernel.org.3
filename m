Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED6B4F6351
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiDFPWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiDFPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:21:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 827BFBE3B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:21:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4261516;
        Wed,  6 Apr 2022 05:21:37 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1DB3F718;
        Wed,  6 Apr 2022 05:21:35 -0700 (PDT)
Message-ID: <000457c2-57af-95e3-7dff-2cbd99f0de5f@arm.com>
Date:   Wed, 6 Apr 2022 14:21:19 +0200
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <675544de-3369-e26e-65ba-3b28fff5c126@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 15:13, Ammar Faizi wrote:
> On 4/5/22 7:21 PM, Dietmar Eggemann wrote:
>> Tried to recreate the issue but no success so far. I used you config
>> file, clang-14 and a Xeon CPU E5-2690 v2 (2 sockets 40 CPUs) with 20
>> two-level cgoupv1 taskgroups '/X/Y' with 'hackbench (10 groups, 40 fds)
>> + idling' running in all '/X/Y/'.
>>
>> What userspace are you running?
> 
> HP Laptop, Intel i7-1165G7, 8 CPUs, with 16 GB of RAM. Ubuntu 21.10.
> Just for
> daily workstation. Compiling kernel, browsing and coding stuff.

Can you check that CFS Bandwidth control (CONFIG_CFS_BANDWIDTH=y) is
still not used on Ubuntu desktop 21.10?

It shouldn't but I can't verify since I'm still on 20.04 LTS Desktop:

$ mount | grep "cgroup2\|\bcpu\b"
cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)

CPU controller is still used in cgroupv1. So cgroupv2 can't use it:

$ cat /sys/fs/cgroup/unified/cgroup.controllers
/* empty */

And there is no cgroupv1 hierarchy under /sys/fs/cgroup/cpu,cpuacct/ .

No cpu.cfs_quota_us files with something other than -1.

So CFS Bandwidth control is not used.

[...]
