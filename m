Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E194E5A85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbiCWVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbiCWVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:18:47 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8ED84EF7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:17:17 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id r8so2981831oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9o+6xxE9gX10Taey3uxAiu/yqonSkF9+C51+NjLQ+c=;
        b=IAJm1SDQWFQEP0U2RiBFB7hE5MAQXFlmBrmb5Q1BA+lbK6z+et+l4n9P7gEfafeWd5
         MLvtpW4RVRrZ4Y0kgUXDNGvPfqMo/XzG7HgYKFhmSc13rmKaRmAYoHHkDYgKSaSmlnFS
         kJUxHcFm3h73ct7Sc38ucoApqQ2FqzoQSq45S0+1Y2MPmtZGB7lDYZRgY2fZPyAqp6Ib
         N1+gUUqOVY1UW1K3rrWAWuAJ/EbnZEYx3Dif0um8E6tyPpVpTNT9wUClJ2zJcBe8GuTS
         bC6Mfis2i3WY837Tp+LkJoF9M4euzAJSujpgvJTO1n3AJk/n1+DR//Zcfxexg0nTFJP/
         PhHg==
X-Gm-Message-State: AOAM530j/HscUyof6J2ZH4Q3BUwihvYSVOpu8e1sU116lzj/oU8Q2MWM
        0WhKoSN+hm0YJQoqn7pu/Q==
X-Google-Smtp-Source: ABdhPJwpI852GkTaURWFEFVnsAjcGLkR3Z3ziISvkXDZMdUEZnwkEClQGXhlVztVh9r4gUq8oQdRgw==
X-Received: by 2002:a05:6808:10cb:b0:2da:88e4:e352 with SMTP id s11-20020a05680810cb00b002da88e4e352mr5252705ois.159.1648070236487;
        Wed, 23 Mar 2022 14:17:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d9-20020a9d51c9000000b005b2466cd7b3sm495319oth.36.2022.03.23.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:17:15 -0700 (PDT)
Received: (nullmailer pid 468441 invoked by uid 1000);
        Wed, 23 Mar 2022 21:17:14 -0000
Date:   Wed, 23 Mar 2022 16:17:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
Subject: Re: [PATCH v3 21/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Message-ID: <YjuOWpqLfiP4u2AT@robh.at.kernel.org>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-22-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217182110.7176-22-james.morse@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:21:10PM +0000, James Morse wrote:
> resctrl_arch_rmid_read() returns a value in chunks, as read from the
> hardware. This needs scaling to bytes by mon_scale, as provided by
> the architecture code.
> 
> Now that resctrl_arch_rmid_read() performs the overflow and corrections
> itself, it may as well return a value in bytes directly. This allows
> the accesses to the architecture specific 'hw' structure to be removed.
> 
> Move the mon_scale conversion into resctrl_arch_rmid_read().
> mbm_bw_count() is updated to calculate bandwidth from bytes.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  6 ++----
>  arch/x86/kernel/cpu/resctrl/internal.h    |  4 ++--
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 22 +++++++++-------------
>  include/linux/resctrl.h                   |  2 +-
>  4 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index d3f7eb2ac14b..03fc91d8bc9f 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -549,7 +549,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  {
>  	struct kernfs_open_file *of = m->private;
> -	struct rdt_hw_resource *hw_res;
>  	u32 resid, evtid, domid;
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
> @@ -569,8 +568,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	domid = md.u.domid;
>  	evtid = md.u.evtid;
>  
> -	hw_res = &rdt_resources_all[resid];
> -	r = &hw_res->r_resctrl;
> +	r = &rdt_resources_all[resid].r_resctrl;
>  	d = rdt_find_domain(r, domid, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
>  		ret = -ENOENT;
> @@ -584,7 +582,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	else if (rr.err == -EINVAL)
>  		seq_puts(m, "Unavailable\n");
>  	else
> -		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
> +		seq_printf(m, "%llu\n", rr.val);
>  
>  out:
>  	rdtgroup_kn_unlock(of->kn);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e26a4d67e204..d6ce6ce91885 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -279,13 +279,13 @@ struct rftype {
>  
>  /**
>   * struct mbm_state - status for each MBM counter in each domain
> - * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
> + * @prev_bw_bytes: Previous bytes value read when for bandwidth calculation
>   * @prev_bw:	The most recent bandwidth in MBps
>   * @delta_bw:	Difference between the current and previous bandwidth
>   * @delta_comp:	Indicates whether to compute the delta_bw
>   */
>  struct mbm_state {
> -	u64	prev_bw_chunks;
> +	u64	prev_bw_bytes;
>  	u32	prev_bw;
>  	u32	delta_bw;
>  	bool	delta_comp;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3a6555f49720..437e7db77f93 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -186,7 +186,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct arch_mbm_state *am;
> -	u64 msr_val;
> +	u64 msr_val, chunks;
>  
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
> @@ -211,10 +211,11 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	if (am) {
>  		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>  						 hw_res->mbm_width);
> -		*val = get_corrected_mbm_count(rmid, am->chunks);
> +		chunks = get_corrected_mbm_count(rmid, am->chunks);
> +		*val = chunks * hw_res->mon_scale;

This can be moved out of the if/else if you make the following change:

>  		am->prev_msr = msr_val;
>  	} else {
> -		*val = msr_val;
> +		*val = msr_val * hw_res->mon_scale;

chunks = msr_val;

>  	}
>  
>  	return 0;
> @@ -229,7 +230,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  void __check_limbo(struct rdt_domain *d, bool force_free)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rmid_entry *entry;
>  	u32 crmid = 1, nrmid;
>  	bool rmid_dirty;
> @@ -252,7 +252,6 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  					   QOS_L3_OCCUP_EVENT_ID, &val)) {
>  			rmid_dirty = true;
>  		} else {
> -			val *= hw_res->mon_scale;
>  			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
>  		}
>  
> @@ -296,7 +295,6 @@ int alloc_rmid(void)
>  static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_domain *d;
>  	int cpu, err;
>  	u64 val = 0;
> @@ -308,7 +306,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>  						     QOS_L3_OCCUP_EVENT_ID,
>  						     &val);
> -			val *= hw_res->mon_scale;
>  			if (err || val <= resctrl_rmid_realloc_threshold)
>  				continue;
>  		}
> @@ -400,15 +397,14 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>  {
> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>  	struct mbm_state *m = &rr->d->mbm_local[rmid];
> -	u64 cur_bw, chunks, cur_chunks;
> +	u64 cur_bw, bytes, cur_bytes;
>  
> -	cur_chunks = rr->val;
> -	chunks = cur_chunks - m->prev_bw_chunks;
> -	m->prev_bw_chunks = cur_chunks;
> +	cur_bytes = rr->val;
> +	bytes = cur_bytes - m->prev_bw_bytes;
> +	m->prev_bw_bytes = cur_bytes;
>  
> -	cur_bw = (chunks * hw_res->mon_scale) >> 20;
> +	cur_bw = bytes >> 20;

'bytes / SZ_1M' would be more readable and any decent compiler should 
optimize a power of 2 divide. But maybe that's a separate change as 
there are other cases of bytes to MB.

Rob
