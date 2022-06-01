Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6FB539BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349444AbiFADcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349442AbiFADcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0834625C45
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654054330;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFnZIZTCkehypn5WjpiRH1ndutxaCmXxpws7LN8oRps=;
        b=ZSD3UqMrXyHNg979JFB+6EYus2CIPzgzgZMru9K++7otKYSTiWNmhy+avPAzAriIaQVeUD
        Q3uMolGpLT1Zb/FIGQDCKCSLiXHcE9k5NBq2eZWQSw0Z7+xgNm1VJUWPutVS8I9ArxrM5c
        qEEEyvHQyKspYnBwaVJUMHg/5qCmaUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-OCLPGme_PkSjycFeBZ5Y3w-1; Tue, 31 May 2022 23:32:00 -0400
X-MC-Unique: OCLPGme_PkSjycFeBZ5Y3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3D5880029D;
        Wed,  1 Jun 2022 03:31:59 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 202C940E80E1;
        Wed,  1 Jun 2022 03:31:53 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 07/16] arch_topology: Use the last level cache
 information from the cacheinfo
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
 <20220525081416.3306043-7-sudeep.holla@arm.com>
 <20220525081416.3306043-8-sudeep.holla@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7e77071b-ba1f-20f4-91b8-aa0b95e92967@redhat.com>
Date:   Wed, 1 Jun 2022 11:31:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-8-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 4:14 PM, Sudeep Holla wrote:
> The cacheinfo is now initialised early along with the CPU topology
> initialisation. Instead of relying on the LLC ID information parsed
> separately only with ACPI PPTT elsewhere, migrate to use the similar
> information from the cacheinfo.
> 
> This is generic for both DT and ACPI systems. The ACPI LLC ID information
> parsed separately can now be removed from arch specific code.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/arch_topology.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 765723448b10..4c486e4e6f2f 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -663,7 +663,8 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>   		/* not numa in package, lets use the package siblings */
>   		core_mask = &cpu_topology[cpu].core_sibling;
>   	}
> -	if (cpu_topology[cpu].llc_id != -1) {
> +
> +	if (last_level_cache_is_valid(cpu)) {
>   		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
>   			core_mask = &cpu_topology[cpu].llc_sibling;
>   	}
> @@ -694,7 +695,7 @@ void update_siblings_masks(unsigned int cpuid)
>   	for_each_online_cpu(cpu) {
>   		cpu_topo = &cpu_topology[cpu];
>   
> -		if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
> +		if (last_level_cache_is_shared(cpu, cpuid)) {
>   			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
>   			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
>   		}
> 

