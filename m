Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CEB54FC47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382767AbiFQRgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382714AbiFQRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:36:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900735249
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655487367; x=1687023367;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ojZXvlomwwAk5LBD57zzpFvYqmoQfWAuuImQZsSw1Hk=;
  b=TwXM+jUHNYW0jvM/5FmKnoeh/XAK8mxHEEpxBdr+6A/Q/Mmn1Z7I8XvD
   0JvfkTHMDS/0GjYrU+fEpDJVoq3rabqVUaW1Fry3+TjvSmftMtDTNi2t9
   Ckb3JkzwGgZMPjKMCiv10TzGF2bHi8fGZiJezyQGChpZftEFqOgUdLmuG
   ccvneUcmsZoWNh6jmFFN3ig7elbvAFBRYvT0frtm7CM1OwxcE4mKI0+6l
   vgg/kTKnfJV85yUx1O8t9YtuzBr7mwKdKFthkopSYzmuCm19IUiAhk4MS
   f3PfiLBk5RkQowowGETFZ/mHXsLHXQusC+H+T49CPYdNH8uYqyu7+dmBb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280264943"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280264943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 09:50:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="613597090"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.204.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 09:50:24 -0700
Message-ID: <b87ddfd7a8dd418edfcdbad22a4fc1e9ef03109a.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com, feng.tang@intel.com
Date:   Fri, 17 Jun 2022 09:50:24 -0700
In-Reply-To: <6bf4f032-7d07-d4a4-4f5a-28f3871131c0@amd.com>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
         <20220609120622.47724-2-yangyicong@hisilicon.com>
         <e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com>
         <81fbcadb-a58d-2cef-9c05-154555ec1d68@huawei.com>
         <6bf4f032-7d07-d4a4-4f5a-28f3871131c0@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-17 at 17:50 +0530, K Prateek Nayak wrote:
> 
> 
> --
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e9f3dc6dcbf4..97a3895416ab 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1750,12 +1750,12 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>  	return sd;
>  }
>  
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> +DECLARE_PER_CPU(int, sd_share_id);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
> -DECLARE_PER_CPU(int, sd_share_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> -DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> --
> 
> The System-map of each kernel is as follows:
> 
> - On "tip"
> 
> 0000000000020518 D sd_asym_cpucapacity
> 0000000000020520 D sd_asym_packing
> 0000000000020528 D sd_numa
> 0000000000020530 D sd_llc_shared
> 0000000000020538 D sd_llc_id
> 000000000002053c D sd_llc_size
> -------------------------------------------- 64B Cacheline Boundary
> 0000000000020540 D sd_llc
> 
> - On "tip + Patch 1 only" and "tip + both patches"
> 
> 0000000000020518 D sd_asym_cpucapacity
> 0000000000020520 D sd_asym_packing
> 0000000000020528 D sd_numa
> 0000000000020530 D sd_cluster     <-----
> 0000000000020538 D sd_llc_shared
> -------------------------------------------- 64B Cacheline Boundary
> 0000000000020540 D sd_share_id    <-----
> 0000000000020544 D sd_llc_id
> 0000000000020548 D sd_llc_size
> 0000000000020550 D sd_llc
> 
> 
> - On "tip + both patches (Move declaration to top)"
> 
> 0000000000020518 D sd_asym_cpucapacity
> 0000000000020520 D sd_asym_packing
> 0000000000020528 D sd_numa
> 0000000000020530 D sd_llc_shared
> 0000000000020538 D sd_llc_id
> 000000000002053c D sd_llc_size
> -------------------------------------------- 64B Cacheline Boundary
> 0000000000020540 D sd_llc

Wonder if it will help to try keep sd_llc and sd_llc_size into the same
cache line.  They are both used in the wake up path. 


> 0000000000020548 D sd_share_id    <-----
> 0000000000020550 D sd_cluster     <-----
> 
> > Or change the layout a bit to see if there's any difference,
> > like:
> > 
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> >  DEFINE_PER_CPU(int, sd_llc_size);
> >  DEFINE_PER_CPU(int, sd_llc_id);
> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > +DEFINE_PER_CPU(int, sd_share_id);
> > +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > 
> > I need to further look into it and have some tests on a SMT machine. Would you mind to share
> > the kernel config as well? I'd like to compare the config as well.
> 
> I've attached the kernel config used to build the test kernel
> to this mail.
> 
> > Thanks,
> > Yicong
> 
> We are trying to debug the issue using perf and find an optimal
> arrangement of the per cpu declarations to get the relevant data
> used in the wakeup path on the same 64B cache line.

A check of perf c2c profile difference between tip and the move new declarations to
the top case could be useful.  It may give some additional clues of possibel 
false sharing issues.

Tim

> 
> We'll keep you posted of out finding. Let me know if you need
> anything else in the meantime.
> --
> Thanks and Regards,
> Prateek

