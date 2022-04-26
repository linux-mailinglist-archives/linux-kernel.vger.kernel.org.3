Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266F8510215
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352457AbiDZPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348522AbiDZPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:43:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBA9624BCA;
        Tue, 26 Apr 2022 08:40:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8543B23A;
        Tue, 26 Apr 2022 08:40:36 -0700 (PDT)
Received: from [10.57.41.198] (unknown [10.57.41.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20153F73B;
        Tue, 26 Apr 2022 08:40:34 -0700 (PDT)
Message-ID: <8ee5dfd0-558b-5ad6-63d2-b142550f04a3@arm.com>
Date:   Tue, 26 Apr 2022 16:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v1] PM: EM: Decrement policy counter
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     cristian.marussi@arm.com, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
References: <20220426144448.43682-1-pierre.gondois@arm.com>
From:   Vincent Donnefort <vincent.donnefort@arm.com>
In-Reply-To: <20220426144448.43682-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 15:44, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> Fixes: e458716a92b57 ("PM: EM: Mark inefficiencies in CPUFreq")
> In the above commit, cpufreq_cpu_get() is called without
> a cpufreq_cpu_put(), permanently increasing the reference counts
> of the policy struct.
> Decrement the reference count once the policy struct is not used
> anymore.


Not sure if the tag there will be caught properly. Usually it goes on
top of the Signed-off-by.

While at it:

Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>

Thanks for fixing this.

> 
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   kernel/power/energy_model.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 0153b0ca7b23..6219aaa454b5 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -259,6 +259,8 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
>   			found++;
>   	}
>   
> +	cpufreq_cpu_put(policy);
> +
>   	if (!found)
>   		return;
>   
