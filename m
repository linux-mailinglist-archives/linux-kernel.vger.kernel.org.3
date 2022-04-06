Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83A4F6CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiDFVbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiDFVaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:30:39 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153DD1F761F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:34:17 -0700 (PDT)
Received: from [192.168.223.80] (unknown [114.10.20.104])
        by gnuweeb.org (Postfix) with ESMTPSA id 1AAB37E357;
        Wed,  6 Apr 2022 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1649277257;
        bh=fyeTyT6/sVCNXUxxthqtTBSMElMjKCqGdhSXrfEBdd4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=lMxze+V+T3fViuSilMbSZOB5mkR4y/gtgIj4t+K5kOU+OLi0Fi2iqcSikEeCKQEoj
         RLjku6+IazQFqgU/ZPVGA9BJvNNFiv7T/hWu8nRCwQxpaSw7SPW4tH9uWZzO5FkwvJ
         rX+cmgxDum+YW3DK04dEcZh5FMUzyZjXx8xttJ33whfopbWgP/0YHdUZ7jcIEQL20G
         MCvhxhnwmpzw+KYOC6E2fIksjMarL3NlfrPMzpmOFI5850KYV5p4lXPjWUUgfAiwsd
         Zp2sH8ztQMv5JJ4dxG+MNrJ1IVQM6P9FxqUF4KOv5o22N3ESfumgDwmU7WBWs+q4Hy
         dTKxS6L4DNyWA==
Message-ID: <7f4b3fbf-c7c6-22cb-019b-520ad6a663aa@gnuweeb.org>
Date:   Thu, 7 Apr 2022 03:34:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [Linux 5.18-rc1] WARNING: CPU: 1 PID: 0 at
 kernel/sched/fair.c:3355 update_blocked_averages
In-Reply-To: <000457c2-57af-95e3-7dff-2cbd99f0de5f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 7:21 PM, Dietmar Eggemann wrote:
> On 05/04/2022 15:13, Ammar Faizi wrote:
>> On 4/5/22 7:21 PM, Dietmar Eggemann wrote:
>>> Tried to recreate the issue but no success so far. I used you config
>>> file, clang-14 and a Xeon CPU E5-2690 v2 (2 sockets 40 CPUs) with 20
>>> two-level cgoupv1 taskgroups '/X/Y' with 'hackbench (10 groups, 40 fds)
>>> + idling' running in all '/X/Y/'.
>>>
>>> What userspace are you running?
>>
>> HP Laptop, Intel i7-1165G7, 8 CPUs, with 16 GB of RAM. Ubuntu 21.10.
>> Just for
>> daily workstation. Compiling kernel, browsing and coding stuff.
> 
> Can you check that CFS Bandwidth control (CONFIG_CFS_BANDWIDTH=y) is
> still not used on Ubuntu desktop 21.10?
> 
> It shouldn't but I can't verify since I'm still on 20.04 LTS Desktop:
> 
> $ mount | grep "cgroup2\|\bcpu\b"
> cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
> cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
> 
> CPU controller is still used in cgroupv1. So cgroupv2 can't use it:
> 
> $ cat /sys/fs/cgroup/unified/cgroup.controllers
> /* empty */
> 
> And there is no cgroupv1 hierarchy under /sys/fs/cgroup/cpu,cpuacct/ .
> 
> No cpu.cfs_quota_us files with something other than -1.
> 
> So CFS Bandwidth control is not used.

Not familiar with CFS stuff, but here...

===============
ammarfaizi2@integral2:~$ mount | grep "cgroup2\|\bcpu\b"
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
ammarfaizi2@integral2:~$ cat /sys/fs/cgroup/unified/cgroup.controllers
cat: /sys/fs/cgroup/unified/cgroup.controllers: No such file or directory
ammarfaizi2@integral2:~$ ls /sys/fs/cgroup/{cpu,cpuacct}
ls: cannot access '/sys/fs/cgroup/cpu': No such file or directory
ls: cannot access '/sys/fs/cgroup/cpuacct': No such file or directory
ammarfaizi2@integral2:~$
ammarfaizi2@integral2:~$ cat /etc/os-release
PRETTY_NAME="Ubuntu 21.10"
NAME="Ubuntu"
VERSION_ID="21.10"
VERSION="21.10 (Impish Indri)"
VERSION_CODENAME=impish
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=impish
ammarfaizi2@integral2:~$
===============

Update:
So far I have been using and torturing my machine for a day, but
still couldn't reproduce the issue. It seems I hit a rarely
happened bug. I will continue using this until 5.18-rc2 before
recompile my kernel.

-- 
Ammar Faizi
