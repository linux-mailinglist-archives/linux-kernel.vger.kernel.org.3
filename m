Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52B4DC8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiCQOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCQOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:22:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAEB169B18;
        Thu, 17 Mar 2022 07:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1179CB81ECB;
        Thu, 17 Mar 2022 14:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2231C340E9;
        Thu, 17 Mar 2022 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647526845;
        bh=1jUnKiTd1ovbIfeqqvU+XJdp2zp/6es7srgZU1ueVYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K/Xy2Izpna9w9dzEslqf7bO8KZu+v9fBTe2zkXFrzLYzjVA2zW8PG2G6ccy2UzuCe
         +megLNyEoALM3Wc8R31tGQJskEsN8hODtURw7ibV+t4q7ilQhqt4qgn/13I7VIINMS
         Raevqn7AT3PUjJ6u8el4RlvUW+rE0W0awJW/fJDL0F+20UP/OW2m4wQTbde7j1uh0a
         ZyAoK4E1eJZOwaMp5kSQAIeN7ZeCJvZPHjrz7ckm6u5LxS/+/OIcijzsnNunJhLgdF
         aLl9ogG6jaQw2DzprxRfjZwrgMk2aombKs6hJyMAz/BWGJTwtc+L++V4JVOLZ+279E
         EFOsoMUelAbPg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUqzb-00FCgJ-4z; Thu, 17 Mar 2022 14:20:43 +0000
MIME-Version: 1.0
Date:   Thu, 17 Mar 2022 14:20:42 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Pierre Gondois <Pierre.Gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data
In-Reply-To: <20220317133419.3901736-2-Pierre.Gondois@arm.com>
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
 <20220317133419.3901736-2-Pierre.Gondois@arm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <746641141c630dc1d02943d6133a6c8d@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, mka@chromium.org, daniel.lezcano@linaro.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, ardb@kernel.org, tabba@google.com, valentin.schneider@arm.com, robh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-17 13:34, Pierre Gondois wrote:
> cppc_cpufreq_get_cpu_data() allocates a new struct cppc_cpudata
> for the input CPU at each call.
> 
> To search the struct associated with a cpu without allocating
> a new one, add cppc_cpufreq_search_cpu_data().
> Also add an early prototype.
> 
> This will be used in a later patch, when generating artificial
> performance states to register an artificial Energy Model in the
> cppc_cpufreq driver and enable the Energy Aware Scheduler for ACPI
> based systems.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
> b/drivers/cpufreq/cppc_cpufreq.c
> index 82d370ae6a4a..8f950fe72765 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -41,6 +41,8 @@
>   */
>  static LIST_HEAD(cpu_data_list);
> 
> +static struct cppc_cpudata *cppc_cpufreq_search_cpu_data(unsigned int 
> cpu);
> +
>  static bool boost_supported;
> 
>  struct cppc_workaround_oem_info {
> @@ -479,6 +481,19 @@ static void cppc_cpufreq_put_cpu_data(struct
> cpufreq_policy *policy)
>  	policy->driver_data = NULL;
>  }
> 
> +static inline struct cppc_cpudata *

Why the inline? This is hardly performance critical, and if
it is, you want something better than iterating over a list.

> +cppc_cpufreq_search_cpu_data(unsigned int cpu)
> +{
> +	struct cppc_cpudata *iter, *tmp;
> +
> +	list_for_each_entry_safe(iter, tmp, &cpu_data_list, node) {
> +		if (cpumask_test_cpu(cpu, iter->shared_cpu_map))
> +			return iter;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	unsigned int cpu = policy->cpu;

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
