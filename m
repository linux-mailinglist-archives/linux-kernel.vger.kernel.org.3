Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA135493C15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355234AbiASOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:44:07 -0500
Received: from foss.arm.com ([217.140.110.172]:58214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355133AbiASOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:44:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42849ED1;
        Wed, 19 Jan 2022 06:44:04 -0800 (PST)
Received: from bogus (unknown [10.57.34.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC5B3F774;
        Wed, 19 Jan 2022 06:44:01 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:43:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] arch_topology: Sanity check cpumask in thermal
 pressure update
Message-ID: <20220119144328.cvt76mhsufxg7qbr@bogus>
References: <20220118185612.2067031-1-bjorn.andersson@linaro.org>
 <20220118185612.2067031-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118185612.2067031-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:56:12AM -0800, Bjorn Andersson wrote:
> Occasionally during boot the Qualcomm cpufreq driver was able to cause
> an invalid memory access in topology_update_thermal_pressure() on the
> line:
> 
> 	if (max_freq <= capped_freq)
> 
> It turns out that this was caused by a race, which resulted in the
> cpumask passed to the function being empty, in which case
> cpumask_first() will return a cpu beyond the number of valid cpus, which
> when used to access the per_cpu max_freq would return invalid pointer.
> 
> The bug in the Qualcomm cpufreq driver is being fixed, but having a
> sanity check of the arguments would have saved quite a bit of time and
> it's not unlikely that others will run into the same issue.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/base/arch_topology.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 976154140f0b..6560a0c3b969 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -177,6 +177,9 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
>  	u32 max_freq;
>  	int cpu;
>  
> +	if (WARN_ON(cpumask_empty(cpus)))
> +		return;
> +

Why can't the caller check and call this only when cpus is not empty ?
IIUC there are many such APIs that use cpumask and could result in similar
issues if called with empty cpus. Probably we could add a note that cpus
must not be empty if that helps the callers ?

-- 
Regards,
Sudeep
