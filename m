Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7E4F1A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378858AbiDDQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 12:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378843AbiDDQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:04:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7834D427DD;
        Mon,  4 Apr 2022 09:02:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44BFFD6E;
        Mon,  4 Apr 2022 09:02:25 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DED9D3F73B;
        Mon,  4 Apr 2022 09:02:24 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:02:23 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: Re: [RESEND][PATCH 5/8] PM: EM: Remove old debugfs files and print
 all 'flags'
Message-ID: <YksWj8GhZWUimF74@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-6-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321095729.20655-6-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

IMO the debugfs files were fine as they were:
 - They offered information on units and inefficiencies without having
   to dig into the code to see which bit is for which flag.
 - I believe the artificial EM power values fit under bogoWatts as unit,
   so that part would still be correct.

On the other hand, your new file offers more information: we'd be able
to see in debugfs whether we're dealing with an artificial EM, despite
needing a bit more looking over the code to understand the output.

I don't have a strong opinion and the code looks fine, so:

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>


On Monday 21 Mar 2022 at 09:57:26 (+0000), Lukasz Luba wrote:
> The Energy Model gets more bits used in 'flags'. Avoid adding another
> debugfs file just to print what is the status of a new flag. Simply
> remove old debugfs files and add one generic which prints all flags
> as a hex value.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index babefc72085d..092513575e4e 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -54,28 +54,15 @@ static int em_debug_cpus_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
>  
> -static int em_debug_units_show(struct seq_file *s, void *unused)
> +static int em_debug_flags_show(struct seq_file *s, void *unused)
>  {
>  	struct em_perf_domain *pd = s->private;
> -	char *units = (pd->flags & EM_PERF_DOMAIN_MILLIWATTS) ?
> -		"milliWatts" : "bogoWatts";
>  
> -	seq_printf(s, "%s\n", units);
> +	seq_printf(s, "%#lx\n", pd->flags);
>  
>  	return 0;
>  }
> -DEFINE_SHOW_ATTRIBUTE(em_debug_units);
> -
> -static int em_debug_skip_inefficiencies_show(struct seq_file *s, void *unused)
> -{
> -	struct em_perf_domain *pd = s->private;
> -	int enabled = (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES) ? 1 : 0;
> -
> -	seq_printf(s, "%d\n", enabled);
> -
> -	return 0;
> -}
> -DEFINE_SHOW_ATTRIBUTE(em_debug_skip_inefficiencies);
> +DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
>  
>  static void em_debug_create_pd(struct device *dev)
>  {
> @@ -89,9 +76,8 @@ static void em_debug_create_pd(struct device *dev)
>  		debugfs_create_file("cpus", 0444, d, dev->em_pd->cpus,
>  				    &em_debug_cpus_fops);
>  
> -	debugfs_create_file("units", 0444, d, dev->em_pd, &em_debug_units_fops);
> -	debugfs_create_file("skip-inefficiencies", 0444, d, dev->em_pd,
> -			    &em_debug_skip_inefficiencies_fops);
> +	debugfs_create_file("flags", 0444, d, dev->em_pd,
> +			    &em_debug_flags_fops);
>  
>  	/* Create a sub-directory for each performance state */
>  	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
> -- 
> 2.17.1
> 
