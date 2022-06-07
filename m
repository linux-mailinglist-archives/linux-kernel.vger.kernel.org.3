Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B985424DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443566AbiFHCCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842829AbiFHAKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:10:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64301210F85
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654636028; x=1686172028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37mmixr31+JpMckV2p6utumpOl/5/0swYmKvvppfkoA=;
  b=KmuwPnZibKAR4/S1dYXPAXaz9d4K+TmO+DwcwnKmigIEajH7le4Mppyy
   d1rAoJufn+lwmf8tXF1xmnin3fQDhfCn+dMDRgojZh8lHJpdb5BlHZzBa
   3WlW9jJLnp5Jw8xqQHidbzYFg+JECt4EjeD0dwxW2Fp2FoRXt1XDgMzFr
   MHVcGYjBxQwCWxKzQfe5QtClaFvLDel/g3RW2AWxI+g3864T7Ca7hCFgI
   ICfGTC6QUwd+VEYC7jO0MTDxkpnygqHGx2I3dV7ujnf3maTGGvEWvPeG7
   zeKla2trEtHEmN/3J1YPTntMvu8jL6VJWj2UfY/jlCKMb1D+LIqqjk/+N
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340708978"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="340708978"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:06:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="609368562"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:06:46 -0700
Date:   Tue, 7 Jun 2022 14:07:15 -0700
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
Subject: Re: [PATCH v4 16/21] x86/resctrl: Pass the required parameters into
 resctrl_arch_rmid_read()
Message-ID: <Yp++A0tuEqAN7eHo@fyu1.sc.intel.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-17-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412124419.30689-17-james.morse@arm.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On Tue, Apr 12, 2022 at 12:44:14PM +0000, James Morse wrote:
> resctrl_arch_rmid_read() is intended as the function that an
> architecture agnostic resctrl filesystem driver can use to
> read a value in bytes from a hardware register. Currently the function
> returns the MBM values in chunks directly from hardware.
> 
> To convert this to bytes, some correction and overflow calculations
> are needed. These depend on the resource and domain structures.
> Overflow detection requires the old chunks value. None of this
> is available to resctrl_arch_rmid_read(). MPAM requires the
> resource and domain structures to find the MMIO device that holds
> the registers.
> 
> Pass the resource and domain to resctrl_arch_rmid_read(). This makes
> rmid_dirty() too big.

rmid_dirty() is not called by resctrl_arch_rmid_read(). Why does parring r and d
make rmid_dirty() too big?

> Instead merge it with its only caller, and the
> name is kept as a local variable.
> 
> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>  * Added comment about where resctrl_arch_rmid_read() can be called from.
> 
> Changes since v2:
>  * Typos.
>  * Kerneldoc fixes.
> 
> This is all a little noisy for __mon_event_count(), as the switch
> statement work is now before the resctrl_arch_rmid_read() call.
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 31 +++++++++++++++------------
>  include/linux/resctrl.h               | 18 +++++++++++++++-
>  2 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 20c54cbadc0c..81cc7587b598 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  		memset(am, 0, sizeof(*am));
>  }
>  
> -int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> +			   u32 rmid, enum resctrl_event_id eventid, u64 *val)

Can this be a concise interface by just adding one more parameter "rr"?

int resctrl_arch_rmid_read(struct rmid_read *rr, u32 rmid, u64 *val);
>  {
>  	u64 msr_val;

Then inside the API, add:
	struct rdt_resource *r = rr->r;
	struct rdt_domain *d = rr->d;
	struct rdt_resource r = rr->r;
	enum resctrl_event_id evtid = rr->evtid;

>  
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> +		return -EINVAL;
> +
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>  	 * with a valid event code for supported resource type and the bits
> @@ -192,16 +196,6 @@ int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	return 0;
>  }
>  
> -static bool rmid_dirty(struct rmid_entry *entry)
> -{
> -	u64 val = 0;
> -
> -	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
> -		return true;
> -
> -	return val >= resctrl_cqm_threshold;
> -}
> -
>  /*
>   * Check the RMIDs that are marked as busy for this domain. If the
>   * reported LLC occupancy is below the threshold clear the busy bit and
> @@ -213,6 +207,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  	struct rmid_entry *entry;
>  	struct rdt_resource *r;
>  	u32 crmid = 1, nrmid;
> +	bool rmid_dirty;
> +	u64 val = 0;
>  
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  
> @@ -228,7 +224,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  			break;
>  
>  		entry = __rmid_entry(nrmid);
> -		if (force_free || !rmid_dirty(entry)) {
> +
> +		if (resctrl_arch_rmid_read(r, d, entry->rmid,
> +					   QOS_L3_OCCUP_EVENT_ID, &val))
> +			rmid_dirty = true;
> +		else
> +			rmid_dirty = (val >= resctrl_cqm_threshold);
> +
> +		if (force_free || !rmid_dirty) {
>  			clear_bit(entry->rmid, d->rmid_busy_llc);
>  			if (!--entry->busy) {
>  				rmid_limbo_count--;
> @@ -278,7 +281,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	cpu = get_cpu();
>  	list_for_each_entry(d, &r->domains, list) {
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(entry->rmid,
> +			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>  						     QOS_L3_OCCUP_EVENT_ID,
>  						     &val);
>  			if (err || val <= resctrl_cqm_threshold)
> @@ -336,7 +339,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>  	if (rr->first)
>  		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
>  
> -	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
> +	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);

Is resctrl_arch_rmid_read(rr, rmid, &tval) concise and better?

>  	if (rr->err)
>  		return rr->err;
>  
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 70112dbfa128..cc6311a40582 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -219,7 +219,23 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type);
>  int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>  void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> -int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
> +
> +/**
> + * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
> + *			      for this resource and domain.
> + * @r:			resource that the counter should be read from.
> + * @d:			domain that the counter should be read from.
> + * @rmid:		rmid of the counter to read.
> + * @eventid:		eventid to read, e.g. L3 occupancy.
> + * @val:		result of the counter read in chunks.
> + *
> + * Call from process context on a CPU that belongs to domain @d.
> + *
> + * Return:
> + * 0 on success, or -EIO, -EINVAL etc on error.
> + */
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> +			   u32 rmid, enum resctrl_event_id eventid, u64 *val);

Then it's a concise API:

int resctrl_arch_rmid_read(struct rmid_read *rr, u32 rmid, u64 *val);

r, d and eventid can be easily retrieved from rr inside the API implementation.

>  
>  /**
>   * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
> -- 
> 2.30.2
> 

Thanks. 

-Fenghua
