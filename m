Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4253A4B8B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiBPOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:39:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBPOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:39:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255BA2A64E0;
        Wed, 16 Feb 2022 06:39:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D284B81EC6;
        Wed, 16 Feb 2022 14:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A58EC004E1;
        Wed, 16 Feb 2022 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645022368;
        bh=yICmxNU28lCRdCrR490KpNGJYusepKied6d/R03vGi4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fiGImpU+swl24FQ/pSJSGhxKF/6eSiYXxMzZoLhiUt4GRpFnHC+RWL8y1YNeEFn1Q
         DLPIYbUXLnurEoj4HI2aCRxv3HYMlXh8yFWmkC5rUCEA6CLipzmXQKAYR5lQaaWfTG
         QdM3LgJmvNWP6PRmhGsqZ+7kQ3xFtmgOApXHoRPYJP0WXvDQ+pfKo+MO0FQlJdgv46
         wpeLwZN2cstsCq/ujP4mR0JBMmTaZkShLmGCekNOASaUQ+mP6YlqAgYGEzMj4f1Fj+
         w/xIY9Z/S3xL2mh90ycrFdt9D01NgWSK2u5ZBeOyr77+sNRebTEViMB1vNL6d6dl30
         bI6wUo2tnKvbA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nKLSo-008LuX-CC; Wed, 16 Feb 2022 14:39:26 +0000
MIME-Version: 1.0
Date:   Wed, 16 Feb 2022 14:39:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cpuidle: psci: Call cpu_cluster_pm_enter() on the
 last CPU
In-Reply-To: <20220216132830.32490-2-shawn.guo@linaro.org>
References: <20220216132830.32490-1-shawn.guo@linaro.org>
 <20220216132830.32490-2-shawn.guo@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b690d382d989bd99eaf870e79f63cfb9@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shawn.guo@linaro.org, tglx@linutronix.de, quic_mkshah@quicinc.com, bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-16 13:28, Shawn Guo wrote:
> Make a call to cpu_cluster_pm_enter() on the last CPU going to low 
> power
> state (and cpu_cluster_pm_exit() on the firt CPU coming back), so that
> platforms can be notified to set up hardware for getting into the 
> cluster
> low power state.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c 
> b/drivers/cpuidle/cpuidle-psci.c
> index b51b5df08450..c748c1a7d7b1 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -37,6 +37,7 @@ struct psci_cpuidle_data {
>  static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, 
> psci_cpuidle_data);
>  static DEFINE_PER_CPU(u32, domain_state);
>  static bool psci_cpuidle_use_cpuhp;
> +static atomic_t cpus_in_idle;
> 
>  void psci_set_domain_state(u32 state)
>  {
> @@ -67,6 +68,14 @@ static int __psci_enter_domain_idle_state(struct
> cpuidle_device *dev,
>  	if (ret)
>  		return -1;
> 
> +	if (atomic_inc_return(&cpus_in_idle) == num_online_cpus()) {
> +		ret = cpu_cluster_pm_enter();
> +		if (ret) {
> +			ret = -1;
> +			goto dec_atomic;
> +		}
> +	}
> +
>  	/* Do runtime PM to manage a hierarchical CPU toplogy. */
>  	rcu_irq_enter_irqson();
>  	if (s2idle)
> @@ -88,6 +97,10 @@ static int __psci_enter_domain_idle_state(struct
> cpuidle_device *dev,
>  		pm_runtime_get_sync(pd_dev);
>  	rcu_irq_exit_irqson();
> 
> +	if (atomic_read(&cpus_in_idle) == num_online_cpus())
> +		cpu_cluster_pm_exit();
> +dec_atomic:
> +	atomic_dec(&cpus_in_idle);
>  	cpu_pm_exit();
> 
>  	/* Clear the domain state to start fresh when back from idle. */

Is it just me, or does anyone else find it a bit odd that a cpuidle 
driver
calls back into the core cpuidle code to generate new events?

Also, why is this PSCI specific? I would assume that the core cpuidle 
code
should be responsible for these transitions, not a random cpuidle 
driver.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
