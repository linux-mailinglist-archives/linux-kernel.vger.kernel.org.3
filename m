Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C890484126
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiADLrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:47:00 -0500
Received: from foss.arm.com ([217.140.110.172]:58564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbiADLq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:46:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDF431FB;
        Tue,  4 Jan 2022 03:46:57 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0063F774;
        Tue,  4 Jan 2022 03:46:55 -0800 (PST)
Subject: Re: [PATCH v2 0/3] sched/pelt: Don't sync hardly *_sum with *_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9dc6b6f7-ba6e-0b7f-e8ee-f425eb7d1bd5@arm.com>
Date:   Tue, 4 Jan 2022 12:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211222093802.22357-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 10:37, Vincent Guittot wrote:

INHO you mean s/hardly/hard here?

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

I think the overall idea here is that:

  [add\|sub]_positive(&sa->X_avg, Y); (`add` in update_tg_cfs_X())
  sa->FOO_sum = sa->X_avg * divider;

with X equal (util, runnable, load)

changes to:

  [add\|sub]_positive(&sa->X_avg, Y);
  [add\|sub]_positive(&sa->X_sum, Z);
  sa->X_sum = max_t(u32, sa->X_sum, sa->X_avg * MIN_DIVIDER);

This change is done in:

(1) update_cfs_rq_load_avg()
(2) detach_entity_load_avg() and dequeue_load_avg()
(3) update_tg_cfs_X() (+ down-propagating _sum independently from _avg)

Prior to:

1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
fcf6631f3736 ("sched/pelt: Ensure that *_sum is always synced w/ *_avg")
ceb6ba45dc80 ("sched/fair: Sync load_sum with load_avg after dequeue")

(i.e. the commits which get fixed by this patchset):

  sub_positive(&sa->X_avg, Y);
  sub_positive(&sa->X_sum, Z);

was used in (1) and (2).

(3) used sa->util_sum = sa->util_avg * divider already before (Since
95d685935a2e ("sched/pelt: Sync util/runnable_sum with PELT window when
propagating").

[...]
