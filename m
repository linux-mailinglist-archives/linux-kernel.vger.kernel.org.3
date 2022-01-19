Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCB493862
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353609AbiASKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353785AbiASKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:25:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BFCC061574;
        Wed, 19 Jan 2022 02:25:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A6961566;
        Wed, 19 Jan 2022 10:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD3FC004E1;
        Wed, 19 Jan 2022 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642587926;
        bh=bdrR0jh4uIEP/y4l2LNkUBt0QakR1jJBM/S2utFPnMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/XW1Ibbtw8NHjDsv319EPUPZWWEdmA+4gzMQ0VVMF3ycFplUhm0vHx0JjMntmzZ1
         JIM9OotQ6IwXP1pGIn+/qyLbbRILglCDPI8VaGW1bkUVesOw0D5XIdhSWeF4f0UoId
         TtlxrX22uu0fZbJDlBjm1qit7QamBoiIsSa7cPVQ=
Date:   Wed, 19 Jan 2022 11:25:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] arch_topology: Sanity check cpumask in thermal
 pressure update
Message-ID: <YefnE7AuVTCe6rk3@kroah.com>
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

Sorry, but I do not want to add any more WARN_ON() calls to the kernel
unless really needed.  We don't try to save the kernel from itself all
the time by validating every internal api call parameters.

thjanks,

greg k-h
