Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4605C54576A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiFIW2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345847AbiFIW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:28:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07F5D5CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654813721; x=1686349721;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4aMBkYKnK6oAfQmvu2MwiSPKAfzZjPqC87w6qpy3iaU=;
  b=aJ2wE2/XL1kWonObAg4+H9frfacFXLx/fcb81Q/hpn6ImlTpDL6jM3AX
   T2XnHXR1whIYXIzkUKJsbbIiN07ZHr4zRG/JOT6mOqjQEt5v2oRCySRUG
   2tNE3q4LV39H0N/LoBnwcE0MIWbOZ75aOgQWJ7tFdeii0r2XC6GnJyP9x
   59Yq2av/+o8Q7hoR4tw7VL9smJLrfdKKXi+Xzu6ro4an/SQT1feqpmms5
   riwHyE6S2oegDDuv6b6pTnrmCGzQ/WIKz9vg+Snzt1z2FcOG1XNQVULlG
   Hz1uyfNGbhLI1yR8wpRVEZt0UDnV50uLCaVEY+LrJlLN6tMhAMrGbxGI2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363767682"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363767682"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 15:28:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="585843382"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.167.148])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 15:28:40 -0700
Message-ID: <05472b4ed10c694bce1a2b6dd4a0ef13ea337db3.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com
Date:   Thu, 09 Jun 2022 15:28:38 -0700
In-Reply-To: <20220609120622.47724-2-yangyicong@hisilicon.com>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
         <20220609120622.47724-2-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-09 at 20:06 +0800, Yicong Yang wrote:
> 
>  
> +/*
> + * Whether CPUs are share cache resources, which means LLC on non-cluster
> + * machines and LLC tag or L2 on machines with clusters.
> + */
> +bool cpus_share_resources(int this_cpu, int that_cpu)

Suggest cpus_share_lowest_cache to be a bit more informative

> +{
> +	if (this_cpu == that_cpu)
> +		return true;
> +
> +	return per_cpu(sd_share_id, this_cpu) == per_cpu(sd_share_id, that_cpu);
> +}
> +
>  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  {
>  	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 01259611beb9..b9bcfcf8d14d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1753,7 +1753,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
> +DECLARE_PER_CPU(int, sd_share_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05b6c2ad90b9..0595827d481d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_share_id);

Some minor nits about the name of "sd_share_id".  
It is not quite obvious what it is.  

Maybe something like sd_lowest_cache_id to denote
it is the id of lowest shared cache domain between CPU. 

Otherwise the patch looks good to me.  You can add

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Tim

