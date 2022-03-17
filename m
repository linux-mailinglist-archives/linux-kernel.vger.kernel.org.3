Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF24DC9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbiCQPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiCQPTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:19:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84739D0D8;
        Thu, 17 Mar 2022 08:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F2D61944;
        Thu, 17 Mar 2022 15:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E413C340E9;
        Thu, 17 Mar 2022 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647530277;
        bh=iit+kNVt5zpWWwXPYJiPwGesFnvkto/Yc7KjVR9Mkhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tyQEo38PMkJ8Fcz5uNbmai5vvlIw0XgS6kAg5D05GCt+d7X5BfyCc+PpYF1iU2QWD
         OG97uXfq79ulLpRfKSBqM9viv1Dtp1gnsCQ4EnF+szPEQk1gK3hRluac8oo+LHDbYC
         VLnhpVj39kBL44dlWty5V6NN72lU7wAnLCwWyNBgNoo1t7JXW8yc/Phd/rbz4MQrlg
         wovOnFYsiyMRt+gRO+mhvRpuQ38cUoKcts9ess7FLhv77w85VE5yh5rNOT7ta0hxgg
         dvph5vdCelHBSF6z6z89fCsjaYyItggAblKWuaoBBMn6+Lv9mHHiEnwXLP3v8mOAUM
         v0zkOPpG62xcQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUrsx-00FDcZ-2F; Thu, 17 Mar 2022 15:17:55 +0000
MIME-Version: 1.0
Date:   Thu, 17 Mar 2022 15:17:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
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
        Fuad Tabba <tabba@google.com>, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data
In-Reply-To: <76a15179-560f-d412-1512-7ec28ea62cd9@arm.com>
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
 <20220317133419.3901736-2-Pierre.Gondois@arm.com>
 <746641141c630dc1d02943d6133a6c8d@kernel.org>
 <76a15179-560f-d412-1512-7ec28ea62cd9@arm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2741f16d17d646fb84ec96334265ef01@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pierre.gondois@arm.com, linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, mka@chromium.org, daniel.lezcano@linaro.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, ardb@kernel.org, tabba@google.com, robh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
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

On 2022-03-17 14:44, Pierre Gondois wrote:
> On 3/17/22 15:20, Marc Zyngier wrote:
>> On 2022-03-17 13:34, Pierre Gondois wrote:
>>> cppc_cpufreq_get_cpu_data() allocates a new struct cppc_cpudata
>>> for the input CPU at each call.
>>> 
>>> To search the struct associated with a cpu without allocating
>>> a new one, add cppc_cpufreq_search_cpu_data().
>>> Also add an early prototype.
>>> 
>>> This will be used in a later patch, when generating artificial
>>> performance states to register an artificial Energy Model in the
>>> cppc_cpufreq driver and enable the Energy Aware Scheduler for ACPI
>>> based systems.
>>> 
>>> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>> 
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 82d370ae6a4a..8f950fe72765 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -41,6 +41,8 @@
>>>    */
>>>   static LIST_HEAD(cpu_data_list);
>>> 
>>> +static struct cppc_cpudata *cppc_cpufreq_search_cpu_data(unsigned 
>>> int
>>> cpu);
>>> +
>>>   static bool boost_supported;
>>> 
>>>   struct cppc_workaround_oem_info {
>>> @@ -479,6 +481,19 @@ static void cppc_cpufreq_put_cpu_data(struct
>>> cpufreq_policy *policy)
>>>   	policy->driver_data = NULL;
>>>   }
>>> 
>>> +static inline struct cppc_cpudata *
>> 
>> Why the inline? This is hardly performance critical, and if
>> it is, you want something better than iterating over a list.
> 
> This was made inline mainly because the function was small. The 
> function
> is called only at boot, so it should not be performance critical. The
> 'inline' can be removed if necessary.
> Would letting it inlined have a negative impact ?

This is why we have a compiler. It is perfectly able to decide
on its own whether to inline or not, depending on how it can
optimise it. With modern compilers, 'inline' means nothing anyway,
and is ignored most of the time.

So dropping it will at least save 7 bytes of source code! ;-)

         M.
-- 
Jazz is not dead. It just smells funny...
