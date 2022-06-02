Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5153B3C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiFBGm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiFBGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82B0F33372
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654152142;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvZ5OMbEcwo0Xa7CqN8M7maUXV2iBoekFoadMgX1RCs=;
        b=CEZWq2HnYYaZ9tQSaYyHYmmZVX1XVFQoPJgegboGeH7KaK1B3oonrI8NbgXnGJ3JQwFhMX
        1150CjBv8qqQr4Ii4OWZTl8jp+8XJ9TeT8Ue/DEoK87JgMPN/FCssKuKn8ZDl/3ERVU93e
        R2Lqa/Xf5JfHADJ308ur97rVI2XNLvY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-J5AQOQPmNeCLDk1obVMTng-1; Thu, 02 Jun 2022 02:42:18 -0400
X-MC-Unique: J5AQOQPmNeCLDk1obVMTng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A61AA8032E5;
        Thu,  2 Jun 2022 06:42:17 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 293D8492C3B;
        Thu,  2 Jun 2022 06:42:11 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 08/16] arm64: topology: Remove redundant setting of
 llc_id in CPU topology
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <444a1540-cf3d-7144-4ebc-d6f4587272a5@redhat.com>
Date:   Thu, 2 Jun 2022 14:42:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-9-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 4:14 PM, Sudeep Holla wrote:
> Since the cacheinfo LLC information is used directly in arch_topology,
> there is no need to parse and fetch the LLC ID information only for
> ACPI systems.
> 
> Just drop the redundant parsing and setting of llc_id in CPU topology
> from ACPI PPTT.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   arch/arm64/kernel/topology.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 9ab78ad826e2..869ffc4d4484 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -89,8 +89,6 @@ int __init parse_acpi_topology(void)
>   		return 0;
>   
>   	for_each_possible_cpu(cpu) {
> -		int i, cache_id;
> -
>   		topology_id = find_acpi_cpu_topology(cpu, 0);
>   		if (topology_id < 0)
>   			return topology_id;
> @@ -107,18 +105,6 @@ int __init parse_acpi_topology(void)
>   		cpu_topology[cpu].cluster_id = topology_id;
>   		topology_id = find_acpi_cpu_topology_package(cpu);
>   		cpu_topology[cpu].package_id = topology_id;
> -
> -		i = acpi_find_last_cache_level(cpu);
> -
> -		if (i > 0) {
> -			/*
> -			 * this is the only part of cpu_topology that has
> -			 * a direct relationship with the cache topology
> -			 */
> -			cache_id = find_acpi_cpu_cache_topology(cpu, i);
> -			if (cache_id > 0)
> -				cpu_topology[cpu].llc_id = cache_id;
> -		}
>   	}
>   
>   	return 0;
> 

