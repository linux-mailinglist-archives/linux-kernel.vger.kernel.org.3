Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400505424CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiFHDVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiFHDVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:21:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA2826130
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654635181; x=1686171181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GF8W8B32JQSitdmtnoiXM24ZrzD0GHTMXBlcbGBZU5A=;
  b=MOyU6ZjUDhogRM7rZ17sGxSCvEVWpWbLOJBPU0mQ9kRDDhsJkPbDrcNE
   2YknNtTY1lmImCkriwK8XDf5gvylUfRsOUJV69QwQNw8bWAoF2NbhwtrI
   2p+YZoZIjyPaoir6UvzRDHYMoOeN7pt0KOkBoNXdQQw+oMGLnumXQyzqA
   SoA7Z/5NF9KR4nbbbVvrnO8Qw0Huoe0w56CyVRk24G0aBYIMRn6WMsH2V
   Vh/dst5jKlBusb5TC/uaFXgnv6z2QfjWpzcKdY11u+txVlr144MkXBb5u
   c9273rAHKDeqyd3YmXNOoPe5Es915mgxy45bbxv50mfv5IdXFna3aTdPQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="265383564"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="265383564"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:44:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="636329123"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:44:33 -0700
Date:   Tue, 7 Jun 2022 13:44:56 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
Subject: Re: [PATCH v4 15/21] x86/resctrl: Abstract __rmid_read()
Message-ID: <Yp+4yIvRgghnmmz/@fyu1.sc.intel.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-16-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412124419.30689-16-james.morse@arm.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On Tue, Apr 12, 2022 at 12:44:13PM +0000, James Morse wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 71a13c04a846..20c54cbadc0c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -167,9 +167,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  		memset(am, 0, sizeof(*am));
>  }
>  
> -static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
> +int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
> -	u64 val;
> +	u64 msr_val;
>  
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> @@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>  	 * are error bits.
>  	 */
>  	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, val);
> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
> -	return val;
> +	if (msr_val & RMID_VAL_ERROR)
> +		return -EIO;
> +	if (msr_val & RMID_VAL_UNAVAIL)
> +		return -EINVAL;
> +
> +	*val = msr_val;
> +
> +	return 0;
>  }
>  
>  static bool rmid_dirty(struct rmid_entry *entry)
>  {
> -	u64 val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
> +	u64 val = 0;
> +
> +	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
> +		return true;
>  
>  	return val >= resctrl_cqm_threshold;
>  }
> @@ -259,8 +269,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> -	int cpu;
> -	u64 val;
> +	int cpu, err;
> +	u64 val = 0;
>  
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  
> @@ -268,8 +278,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	cpu = get_cpu();
>  	list_for_each_entry(d, &r->domains, list) {
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
> -			if (val <= resctrl_cqm_threshold)
> +			err = resctrl_arch_rmid_read(entry->rmid,
> +						     QOS_L3_OCCUP_EVENT_ID,
> +						     &val);
> +			if (err || val <= resctrl_cqm_threshold)
>  				continue;
>  		}
>  
> @@ -315,19 +327,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  	return chunks >> shift;
>  }
>  
> -static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
> +static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>  	struct mbm_state *m;
> -	u64 chunks, tval;
> +	u64 chunks, tval = 0;
>  
>  	if (rr->first)
>  		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
>  
> -	tval = __rmid_read(rmid, rr->evtid);
> -	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
> -		return tval;
> -	}
> +	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
> +	if (rr->err)
> +		return rr->err;
> +
>  	switch (rr->evtid) {
>  	case QOS_L3_OCCUP_EVENT_ID:
>  		rr->val += tval;
> @@ -343,7 +355,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>  		 * Code would never reach here because an invalid
>  		 * event id would fail the __rmid_read.
>  		 */
> -		return RMID_VAL_ERROR;
> +		return -EINVAL;
>  	}
>  
>  	if (rr->first) {
> @@ -399,7 +411,7 @@ void mon_event_count(void *info)
>  	struct rdtgroup *rdtgrp, *entry;
>  	struct rmid_read *rr = info;
>  	struct list_head *head;
> -	u64 ret_val;
> +	int ret_val;

Now ret_val's meaning is changed from rmid value to error value.
I would suggest to name it as "ret" to avoid confusion that this is still a
returned rmid value.

>  
>  	rdtgrp = rr->rgrp;
>  
> @@ -419,9 +431,13 @@ void mon_event_count(void *info)
>  		}
>  	}
>  
> -	/* Report error if none of rmid_reads are successful */
> -	if (ret_val)
> -		rr->val = ret_val;
> +	/*
> +	 * __mon_event_count() calls for newly created monitor groups may
> +	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
> +	 * Discard error if any of the monitor event reads succeeded.
> +	 */
> +	if (ret_val == 0)
> +		rr->err = 0;
>  }
>  

Thanks.

-Fenghua
