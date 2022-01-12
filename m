Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EDE48C72E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354525AbiALP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:26:24 -0500
Received: from foss.arm.com ([217.140.110.172]:60632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239638AbiALP0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:26:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B5FD6E;
        Wed, 12 Jan 2022 07:26:20 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 937BB3F774;
        Wed, 12 Jan 2022 07:26:18 -0800 (PST)
Subject: Re: [PATCH v3 0/4] sched/pelt: Relax the sync of *_sum with *_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <61e9f5b0-39cf-c584-73ec-6a5ac8581bb7@arm.com>
Date:   Wed, 12 Jan 2022 16:26:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111134659.24961-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 14:46, Vincent Guittot wrote:
> Rick reported performance regressions in bugzilla because of cpu
> frequency being lower than before:
>     https://bugzilla.kernel.org/show_bug.cgi?id=215045
> 
> He bisected the problem to:
> commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> 
> More details are available in commit message of patch 1.
> 
> This patchset reverts the commit above and adds several checks when
> propagating the changes in the hierarchy to make sure that we still have
> coherent util_avg and util_sum.
> 
> Dietmar found a simple way to reproduce the WARN fixed by 
> commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> by looping on hackbench in several different sched group levels.
> 
> This patchset as run on the reproducer with success but it probably needs
> more tests by people who faced the WARN before.
> 
> The changes done on util_sum have been also applied to runnable_sum and
> load_sum which faces the same rounding problem although this has not been
> reflected in measurable performance impact.
> 
> Changes for v3:
> - split patch 1 in 2 patches
>   - One to fix rick's regression
>   - One to apply same changes in other places
> - some typos
> - move main comment so it appears in the 1st patch 
> 
> Changes for v2:
> - fix wrong update of load_sum
> - move a change from patch 3 to patch 2
> - update patch 3 commit message
> 
> Vincent Guittot (4):
>   sched/pelt: Relax the sync of util_sum with util_avg
>   sched/pelt: Continue to relax the sync of util_sum with util_avg
>   sched/pelt: Relax the sync of runnable_sum with runnable_avg
>   sched/pelt: Relax the sync of load_sum with load_avg
> 
>  kernel/sched/fair.c | 113 +++++++++++++++++++++++++++++---------------
>  1 file changed, 75 insertions(+), 38 deletions(-)

LGTM. Just a couple of questions on the patch header of 1/4.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
