Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCDC539BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiFADhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiFADhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E73044BFE3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654054621;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=diXfH14fQbDhfoWdKmQOqCsBx1nPcLvkXuJMvjSWG+c=;
        b=GV07hMvrNZBoO3SV7nB4o9PsuhupnlQJmAsD+up9iEKEuSFLzqruSk0ntYQEdaLSwJzdXW
        O0yK/yxVp6Pn7feEqJwkN3sxnbk4UIPNQQit8ZVusJZ/OCm8Y2rUJWu5W8AxMfPCvaYn+u
        lrfev7ajVEkWr2KFFRGx9ogaM35snEg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-Zr9aHkJcNhGBXJ_V-BDaRA-1; Tue, 31 May 2022 23:36:55 -0400
X-MC-Unique: Zr9aHkJcNhGBXJ_V-BDaRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BDDB1C08989;
        Wed,  1 Jun 2022 03:36:55 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDBD61410F36;
        Wed,  1 Jun 2022 03:36:49 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 10/16] arch_topology: Set thread sibling cpumask only
 within the cluster
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
 <20220525081416.3306043-9-sudeep.holla@arm.com>
 <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <1a35c21c-25cf-46ef-6400-152db421de52@redhat.com>
Date:   Wed, 1 Jun 2022 11:36:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-11-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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
> Currently the cluster identifier is not set on the DT based platforms.
> The reset or default value is -1 for all the CPUs. Once we assign the
> cluster identifier values correctly that imay result in getting the thread
> siblings wrongs as the core identifiers can be same for 2 different CPUs
> belonging to 2 different cluster.
> 
> So, in order to get the thread sibling cpumasks correct, we need to
> update them only if the cores they belong are in the same cluster within
> the socket. Let us skip updation of the thread sibling cpumaks if the
> cluster identifier doesn't match.
> 
> This change won't affect even if the cluster identifiers are not set
> currently but will avoid any breakage once we set the same correctly.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/arch_topology.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 76c702c217c5..59dc2c80c439 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -703,15 +703,17 @@ void update_siblings_masks(unsigned int cpuid)
>   		if (cpuid_topo->package_id != cpu_topo->package_id)
>   			continue;
>   
> -		if (cpuid_topo->cluster_id == cpu_topo->cluster_id &&
> -		    cpuid_topo->cluster_id != -1) {
> +		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
> +		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
> +
> +		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
> +			continue;
> +
> +		if (cpuid_topo->cluster_id != -1) {
>   			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
>   			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
>   		}
>   
> -		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
> -		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
> -
>   		if (cpuid_topo->core_id != cpu_topo->core_id)
>   			continue;
>   
> 

