Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1C49E8D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbiA0RWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:22:22 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:15312 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244634AbiA0RWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:22:07 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RFPKWo009268;
        Thu, 27 Jan 2022 17:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=QpjO5xsD8YzBkAUFyLkFIF/TwoWy4yKVLopWUDETO1c=;
 b=TfSONXEW9t4QqV2yAGRvk+7WVtGHYpojRLOmC3zzrxVcl9eU6Jnj5ogsw8bPXyjDKx7G
 smfKrSw9yCUIxqAPr+ELIYEpSLwimVT92TEOHKuKpMTgTQLYlTE+nlMryxrBJuh3tNsr
 YW0wrKI1sJkYjcP1QqL057GxawcNCtgHD9ABhDPTROlycSKcMxoMmGqWB4xjXffnZWNG
 bWErM5S7RDeGTstpyl4znPKSSQbs8SQwXLQg9tglWFxSi5OC4hr83Aj6DDenBHhnizhs
 IjiAzmiR8BCBTPists1F1QNNCs26hqADLiKTER2GJMaJGDNoMRF/7Y+NHqvIx6xw79AZ XQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3duprgw0fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 17:20:43 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 6D397C5;
        Thu, 27 Jan 2022 17:20:40 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.99.224.14])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 96FDF37;
        Thu, 27 Jan 2022 17:20:33 +0000 (UTC)
Date:   Thu, 27 Jan 2022 11:20:33 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>, x86@kernel.org,
        nouveau@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 15/54] arch/x86: replace cpumask_weight with
 cpumask_empty where appropriate
Message-ID: <YfLUYSh8Qyv6wEHd@swahl-home.5wahls.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-16-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-16-yury.norov@gmail.com>
X-Proofpoint-ORIG-GUID: d1Kt8X-N0PUO31rBEkE346Fy5PGO5vIJ
X-Proofpoint-GUID: d1Kt8X-N0PUO31rBEkE346Fy5PGO5vIJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=626 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Sun, Jan 23, 2022 at 10:38:46AM -0800, Yury Norov wrote:
> In some cases, arch/x86 code calls cpumask_weight() to check if any bit of
> a given cpumask is set. We can do it more efficiently with cpumask_empty()
> because cpumask_empty() stops traversing the cpumask as soon as it finds
> first set bit, while cpumask_weight() counts all bits unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 +++++++-------
>  arch/x86/mm/mmio-mod.c                 |  2 +-
>  arch/x86/platform/uv/uv_nmi.c          |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index b57b3db9a6a7..e23ff03290b8 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -341,14 +341,14 @@ static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
>  
>  	/* Check whether cpus belong to parent ctrl group */
>  	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
> -	if (cpumask_weight(tmpmask)) {
> +	if (!cpumask_empty(tmpmask)) {
>  		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
>  		return -EINVAL;
>  	}
>  
>  	/* Check whether cpus are dropped from this group */
>  	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
> -	if (cpumask_weight(tmpmask)) {
> +	if (!cpumask_empty(tmpmask)) {
>  		/* Give any dropped cpus to parent rdtgroup */
>  		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
>  		update_closid_rmid(tmpmask, prgrp);
> @@ -359,7 +359,7 @@ static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
>  	 * and update per-cpu rmid
>  	 */
>  	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
> -	if (cpumask_weight(tmpmask)) {
> +	if (!cpumask_empty(tmpmask)) {
>  		head = &prgrp->mon.crdtgrp_list;
>  		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
>  			if (crgrp == rdtgrp)
> @@ -394,7 +394,7 @@ static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
>  
>  	/* Check whether cpus are dropped from this group */
>  	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
> -	if (cpumask_weight(tmpmask)) {
> +	if (!cpumask_empty(tmpmask)) {
>  		/* Can't drop from default group */
>  		if (rdtgrp == &rdtgroup_default) {
>  			rdt_last_cmd_puts("Can't drop CPUs from default group\n");
> @@ -413,12 +413,12 @@ static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
>  	 * and update per-cpu closid/rmid.
>  	 */
>  	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
> -	if (cpumask_weight(tmpmask)) {
> +	if (!cpumask_empty(tmpmask)) {
>  		list_for_each_entry(r, &rdt_all_groups, rdtgroup_list) {
>  			if (r == rdtgrp)
>  				continue;
>  			cpumask_and(tmpmask1, &r->cpu_mask, tmpmask);
> -			if (cpumask_weight(tmpmask1))
> +			if (!cpumask_empty(tmpmask1))
>  				cpumask_rdtgrp_clear(r, tmpmask1);
>  		}
>  		update_closid_rmid(tmpmask, rdtgrp);
> @@ -488,7 +488,7 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
>  
>  	/* check that user didn't specify any offline cpus */
>  	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
> -	if (cpumask_weight(tmpmask)) {
> +	if (!cpumask_empty(tmpmask)) {
>  		ret = -EINVAL;
>  		rdt_last_cmd_puts("Can only assign online CPUs\n");
>  		goto unlock;
> diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> index 933a2ebad471..c3317f0650d8 100644
> --- a/arch/x86/mm/mmio-mod.c
> +++ b/arch/x86/mm/mmio-mod.c
> @@ -400,7 +400,7 @@ static void leave_uniprocessor(void)
>  	int cpu;
>  	int err;
>  
> -	if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
> +	if (!cpumask_available(downed_cpus) || cpumask_empty(downed_cpus))
>  		return;
>  	pr_notice("Re-enabling CPUs...\n");
>  	for_each_cpu(cpu, downed_cpus) {
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index 1e9ff28bc2e0..ea277fc08357 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -985,7 +985,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
>  
>  	/* Clear global flags */
>  	if (master) {
> -		if (cpumask_weight(uv_nmi_cpu_mask))
> +		if (!cpumask_empty(uv_nmi_cpu_mask))
>  			uv_nmi_cleanup_mask();
>  		atomic_set(&uv_nmi_cpus_in_nmi, -1);
>  		atomic_set(&uv_nmi_cpu, -1);
> -- 
> 2.30.2
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
