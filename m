Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B979149D527
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiAZWR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:17:57 -0500
Received: from foss.arm.com ([217.140.110.172]:43020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbiAZWR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:17:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 719E4D6E;
        Wed, 26 Jan 2022 14:17:55 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.196.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFEB43F793;
        Wed, 26 Jan 2022 14:17:54 -0800 (PST)
Date:   Wed, 26 Jan 2022 22:17:52 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [peterz-queue:sched/core 5/8] kernel/sched/sched.h:3006:32:
 warning: passing argument 1 of 'cpu_util_cfs' makes integer from pointer
 without a cast
Message-ID: <20220126221752.5yaftiwk32jrifll@e107158-lin.cambridge.arm.com>
References: <202201270319.tmnG6ICK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202201270319.tmnG6ICK-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/27/22 03:53, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> head:   dbaafd0f1651b35e07c20e33f8c3f133fc65705e
> commit: 6dd3d475cf576edd705885c66b6f1d638a6818f4 [5/8] sched/sugov: Ignore 'busy' filter when rq is capped by uclamp_max
> config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201270319.tmnG6ICK-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=6dd3d475cf576edd705885c66b6f1d638a6818f4
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue sched/core
>         git checkout 6dd3d475cf576edd705885c66b6f1d638a6818f4
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash kernel/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/sched/core.c:13:
>    kernel/sched/sched.h: In function 'uclamp_rq_is_capped':
> >> kernel/sched/sched.h:3006:32: warning: passing argument 1 of 'cpu_util_cfs' makes integer from pointer without a cast [-Wint-conversion]
>     3006 |         rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
>          |                                ^~
>          |                                |
>          |                                struct rq *
>    kernel/sched/sched.h:2919:46: note: expected 'int' but argument is of type 'struct rq *'
>     2919 | static inline unsigned long cpu_util_cfs(int cpu)

Seems cpu_utils_cfs() definition has changed since I posted my patch. Below
ought to fix it.

Thanks!

--
Qais Yousef

--->8---

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c7bf5309c162..9b33ba9c3c42 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3003,7 +3003,7 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
        if (!static_branch_likely(&sched_uclamp_used))
                return false;

-       rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
+       rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
        max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);

        return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
