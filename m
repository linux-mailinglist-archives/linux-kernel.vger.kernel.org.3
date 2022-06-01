Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83033539BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbiFADiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiFADiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85B5456228
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654054730;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdJmymFf2YAiMmnGWERaLkVy5zEh8JzP2qaAQeVYdW8=;
        b=O1Qq7ZHbWGN5oSgiontQZtiSX/VVYrSWLfSK76wlhJ/WKR4GjPqZQalM8ocJpkXTNELqk+
        ahR0JtNGQd0EBsOo2dkGa5oZYfmo9MnoOwLbu9UnhzC7+jttzNfa6E/y+6BSRuHtkHPcpD
        vfgTPo47LDYaFYz+dGhVvmoRgr1hly8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-q6fYUvoyNNaHwJnVxqBdUg-1; Tue, 31 May 2022 23:38:42 -0400
X-MC-Unique: q6fYUvoyNNaHwJnVxqBdUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A293803D5B;
        Wed,  1 Jun 2022 03:38:42 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6C8140CF8ED;
        Wed,  1 Jun 2022 03:38:36 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 11/16] arch_topology: Check for non-negative value
 rather than -1 for IDs validity
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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
 <20220525081416.3306043-12-sudeep.holla@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <59764f2b-60c8-3f0c-8159-3103f606494c@redhat.com>
Date:   Wed, 1 Jun 2022 11:38:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-12-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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
> Instead of just comparing the cpu topology IDs with -1 to check their
> validity, improve that by checking for a valid non-negative value.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/arch_topology.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 59dc2c80c439..f73a5e669e42 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -637,7 +637,7 @@ static int __init parse_dt_topology(void)
>   	 * only mark cores described in the DT as possible.
>   	 */
>   	for_each_possible_cpu(cpu)
> -		if (cpu_topology[cpu].package_id == -1)
> +		if (cpu_topology[cpu].package_id < 0)
>   			ret = -EINVAL;
>   
>   out_map:
> @@ -709,7 +709,7 @@ void update_siblings_masks(unsigned int cpuid)
>   		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
>   			continue;
>   
> -		if (cpuid_topo->cluster_id != -1) {
> +		if (cpuid_topo->cluster_id >= 0) {
>   			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
>   			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
>   		}
> 

