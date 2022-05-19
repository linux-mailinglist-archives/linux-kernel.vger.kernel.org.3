Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00A552DFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbiESWQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiESWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:16:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5295E17F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652998604; x=1684534604;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V49pp99X+pYdjATfmQyU9u+JGWms4wsV8/Z66YSfiEA=;
  b=jbEoRYkaucbBQtIpuBOBeUCrZKFswYfvGuVpmyPZOaPU28JwgXi6yi7M
   N/rvJKuI3ItjPOThddJM3x7iSOOnAIRvFCveLDHW09LSAYAUWO5NliTaF
   u3ORYGRCcW3J7kvbApPLvRlphNWrOyJLpxRA3rcnBOJqBjnpnsbq14aih
   pI4F+lwDmmNesSqYB2R+2E6llCjO3LDXnWqOyr5qnwxbCL294TRxmlxh2
   eupn/tlGIfvuKZZXdSzYAzDQBO66Zw1zP0sKBALTKOTQS2KCecP/2Zk/h
   r2UYfJD1FFzVf4rBds9tGI7EpO7AqQ0xB0duKSBZLiDOOJjHYKNCPY9eO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="271219784"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="271219784"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:16:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="640017454"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.69.70])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:16:43 -0700
Message-ID: <ddf05d4f0f1ffb1a3ff3076e01cc9752a9fd33a8.camel@linux.intel.com>
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 15:16:31 -0700
In-Reply-To: <20220505122331.42696-1-wuyun.abel@bytedance.com>
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 20:23 +0800, Abel Wu wrote:
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h | 12 ++++++++++
>  kernel/sched/core.c            | 38 ++++++++++++++++++++++++++++++
>  kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++-------
>  kernel/sched/idle.c            |  1 +
>  kernel/sched/sched.h           |  4 ++++
>  kernel/sched/topology.c        |  4 +++-
>  6 files changed, 92 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 56cffe42abbc..95c7ad1e05b5 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -81,8 +81,20 @@ struct sched_domain_shared {
>  	atomic_t	ref;
>  	atomic_t	nr_busy_cpus;
>  	int		has_idle_cores;
> +
> +	/*
> +	 * Tracking of the overloaded cpus can be heavy, so start
> +	 * a new cacheline to avoid false sharing.
> +	 */
> +	atomic_t	nr_overloaded_cpus ____cacheline_aligned;

Abel,

This is nice work. I have one comment.

The update and reading of nr_overloaded_cpus will incur cache bouncing cost.
As far as I can tell, this counter is used to determine if we should bail out
from the search for an idle CPUs if the system is heavily loaded.  And I
hope we can avoid using atomic counter in these heavily used scheduler paths.  
The logic to filter overloaded CPUs only need overloaded_cpus[] 
mask and not the nr_overloaded_cpus counter.

So I recommend that you break out the logic of using nr_overloaded_cpus
atomic counter to detect LLC has heavy load as a second patch so that
it can be evaluated on its own merit.

That functionality overlaps with Chen Yu's patch to limit search depending
on load, so it will be easier to compare the two approaches if it is separated.

Otherwise, the logic in the patch to use overloaded_cpus[]
mask to filter out the overloaded cpus looks fine and complements
Chen Yu's patch.

Thanks.

Tim

> +	unsigned long	overloaded_cpus[]; /* Must be last */ };
>  
> 

