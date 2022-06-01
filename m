Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB8539B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiFADZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbiFADZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE16D45787
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654053950;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw63QfWJQqdPMs+HUkEhZ4GyLV/0EROyC/4c4l7tFAA=;
        b=TH9qgj/xLznyGMi0ftpkAg2ikTlNVZIRsrj22Hi0nFRQ5R6HrjqNF4G5m5eh9i7mp+HaC4
        QkRhdmUIFz5UZ0K+OYnilCqeykViBySZPhshJAzxKUNXFnIcWr2+oEUR5HUUrUB9Vug0YC
        XbupRztn6HD3zKf54Bzc8eGyfmeJuEo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-3AIUhQgvPnSFwiEiofBCjg-1; Tue, 31 May 2022 23:25:47 -0400
X-MC-Unique: 3AIUhQgvPnSFwiEiofBCjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8393B3C0CD42;
        Wed,  1 Jun 2022 03:25:46 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 477A32166B26;
        Wed,  1 Jun 2022 03:25:40 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 05/16] cacheinfo: Allow early detection and population
 of cache attributes
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
 <20220525081416.3306043-6-sudeep.holla@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <f8c39072-df60-ee9e-e05c-b85ebf328362@redhat.com>
Date:   Wed, 1 Jun 2022 11:25:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-6-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 5/25/22 4:14 PM, Sudeep Holla wrote:
> Some architecture/platforms may need to setup cache properties very
> early in the boot along with other cpu topologies so that all these
> information can be used to build sched_domains which is used by the
> scheduler.
> 
> Allow detect_cache_attributes to be called quite early during the boot.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/cacheinfo.c  | 45 ++++++++++++++++++++++++---------------
>   include/linux/cacheinfo.h |  1 +
>   2 files changed, 29 insertions(+), 17 deletions(-)
> 

With the comments improved, as below:

Reviewed-by: Gavin Shan <gshan@redhat.com>


> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index ed74db18468f..976142f3e81d 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -193,14 +193,8 @@ static int cache_setup_of_node(unsigned int cpu)
>   {
>   	struct device_node *np;
>   	struct cacheinfo *this_leaf;
> -	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	unsigned int index = 0;
>   
> -	/* skip if fw_token is already populated */
> -	if (this_cpu_ci->info_list->fw_token) {
> -		return 0;
> -	}
> -
>   	np = of_cpu_device_node_get(cpu);
>   	if (!np) {
>   		pr_err("Failed to find cpu%d device node\n", cpu);
> @@ -236,6 +230,18 @@ int __weak cache_setup_acpi(unsigned int cpu)
>   
>   unsigned int coherency_max_size;
>   
> +static int cache_setup_properties(unsigned int cpu)
> +{
> +	int ret = 0;
> +
> +	if (of_have_populated_dt())
> +		ret = cache_setup_of_node(cpu);
> +	else if (!acpi_disabled)
> +		ret = cache_setup_acpi(cpu);
> +
> +	return ret;
> +}
> +
>   static int cache_shared_cpu_map_setup(unsigned int cpu)
>   {
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> @@ -246,21 +252,21 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>   	if (this_cpu_ci->cpu_map_populated)
>   		return 0;
>   
> -	if (of_have_populated_dt())
> -		ret = cache_setup_of_node(cpu);
> -	else if (!acpi_disabled)
> -		ret = cache_setup_acpi(cpu);
> -
> -	if (ret)
> -		return ret;
> +	/*
> +	 * skip setting up cache properties if LLC is valid, just need
> +	 * to update the shared cpu_map if the cache attributes were
> +	 * populated early before all the cpus are brought online
> +	 */
> +	if (!last_level_cache_is_valid(cpu)) {
> +		ret = cache_setup_properties(cpu);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	for (index = 0; index < cache_leaves(cpu); index++) {
>   		unsigned int i;
>   
>   		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
> -		/* skip if shared_cpu_map is already populated */
> -		if (!cpumask_empty(&this_leaf->shared_cpu_map))
> -			continue;
>   
>   		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
>   		for_each_online_cpu(i) {
> @@ -330,10 +336,13 @@ int __weak populate_cache_leaves(unsigned int cpu)
>   	return -ENOENT;
>   }
>   
> -static int detect_cache_attributes(unsigned int cpu)
> +int detect_cache_attributes(unsigned int cpu)
>   {
>   	int ret;
>   
> +	if (per_cpu_cacheinfo(cpu)) /* Already setup */
> +		goto update_cpu_map;
> +
>   	if (init_cache_level(cpu) || !cache_leaves(cpu))
>   		return -ENOENT;
>  

Here it might be worthy to explain when CPU's cache info has been
populated, by mentioning CPU info can be populated at booting
and hot-add time.
  
> @@ -349,6 +358,8 @@ static int detect_cache_attributes(unsigned int cpu)
>   	ret = populate_cache_leaves(cpu);
>   	if (ret)
>   		goto free_ci;
> +
> +update_cpu_map:
>   	/*
>   	 * For systems using DT for cache hierarchy, fw_token
>   	 * and shared_cpu_map will be set up here only if they are
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 7e429bc5c1a4..00b7a6ae8617 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -84,6 +84,7 @@ int populate_cache_leaves(unsigned int cpu);
>   int cache_setup_acpi(unsigned int cpu);
>   bool last_level_cache_is_valid(unsigned int cpu);
>   bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
> +int detect_cache_attributes(unsigned int cpu);
>   #ifndef CONFIG_ACPI_PPTT
>   /*
>    * acpi_find_last_cache_level is only called on ACPI enabled
> 

Thanks,
Gavin

