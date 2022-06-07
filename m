Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A153B3CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiFBGnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiFBGnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30CF9E0B3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654152180;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsd0rEL421smM5kXILQFm1d6e8rO04GSNAHeoKg8KqM=;
        b=M5R9BIzesHelirJFvEsSGbF26+icaNlu2apqGDa+sTIx+25DquusWeliaSLGdk3gLwu6TC
        dyHqbTFRXeKiRCpTb3gqIY4+Oo//dkBRvJgFukZwv/y9YStIcn+XQDbOKTWGV+FAibhsQw
        iZY58h31/0Ri9zWl7h0+HhN616x1CP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-Ko-f9xzWNhmZ6rRWwFv-Og-1; Thu, 02 Jun 2022 02:42:59 -0400
X-MC-Unique: Ko-f9xzWNhmZ6rRWwFv-Og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84DDA101A56C;
        Thu,  2 Jun 2022 06:42:58 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFF52166B26;
        Thu,  2 Jun 2022 06:42:53 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 09/16] arch_topology: Drop LLC identifier stash from
 the CPU topology
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <a8cd3ce8-64a7-e97d-0dba-71e910296258@redhat.com>
Date:   Thu, 2 Jun 2022 14:42:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-10-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
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
> there is no need to parse and store the LLC ID information only for
> ACPI systems in the CPU topology.
> 
> Remove the redundant LLC ID from the generic CPU arch_topology information.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/arch_topology.c  | 1 -
>   include/linux/arch_topology.h | 1 -
>   2 files changed, 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 4c486e4e6f2f..76c702c217c5 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -747,7 +747,6 @@ void __init reset_cpu_topology(void)
>   		cpu_topo->core_id = -1;
>   		cpu_topo->cluster_id = -1;
>   		cpu_topo->package_id = -1;
> -		cpu_topo->llc_id = -1;
>   
>   		clear_cpu_topology(cpu);
>   	}
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 58cbe18d825c..a07b510e7dc5 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -68,7 +68,6 @@ struct cpu_topology {
>   	int core_id;
>   	int cluster_id;
>   	int package_id;
> -	int llc_id;
>   	cpumask_t thread_sibling;
>   	cpumask_t core_sibling;
>   	cpumask_t cluster_sibling;
> 

