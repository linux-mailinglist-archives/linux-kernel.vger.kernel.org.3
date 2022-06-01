Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D572D539B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiFACpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiFACpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 449B15AA56
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654051519;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwDnrFd7uXmUoAYEBuzB/Z1dpZnq4v5IwtowuAg3PDA=;
        b=M/FPx1DQp7vj0YARnV2kg+U22p3WotBDmaop/O6sKvMEuu069a+rZOloAUwwj+8vXCSJQ1
        MaI4CdXZwGPedJP+ip44W5vysBjluSrUhQuxF6yKfD4HSNaJjNZ4vYGvMTAoVWWHLTdrum
        l9IxNHSZAYpyAkamA5NZZvTLfTjfAQE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-djZtqZtiOnW-x7e8J32zNQ-1; Tue, 31 May 2022 22:45:13 -0400
X-MC-Unique: djZtqZtiOnW-x7e8J32zNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A45E811E7A;
        Wed,  1 Jun 2022 02:45:09 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F96C15E72;
        Wed,  1 Jun 2022 02:45:03 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 01/16] cacheinfo: Use of_cpu_device_node_get instead
 cpu_dev->of_node
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <42bb2efe-e28c-fd15-d00e-8f45dc24b0d1@redhat.com>
Date:   Wed, 1 Jun 2022 10:45:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-2-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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
> The of_cpu_device_node_get takes care of fetching the CPU'd device node
> either from cached cpu_dev->of_node if cpu_dev is initialised or uses
> of_get_cpu_node to parse and fetch node if cpu_dev isn't available yet.
> 
> Just use of_cpu_device_node_get instead of getting the cpu device first
> and then using cpu_dev->of_node for two reasons:
> 1. There is no other use of cpu_dev and can be simplified
> 2. It enabled the use detect_cache_attributes and hence cache_setup_of_node
>     much earlier before the CPUs are registered as devices.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/cacheinfo.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index dad296229161..b0bde272e2ae 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -14,7 +14,7 @@
>   #include <linux/cpu.h>
>   #include <linux/device.h>
>   #include <linux/init.h>
> -#include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/sched.h>
>   #include <linux/slab.h>
>   #include <linux/smp.h>
> @@ -157,7 +157,6 @@ static int cache_setup_of_node(unsigned int cpu)
>   {
>   	struct device_node *np;
>   	struct cacheinfo *this_leaf;
> -	struct device *cpu_dev = get_cpu_device(cpu);
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>   	unsigned int index = 0;
>   
> @@ -166,11 +165,7 @@ static int cache_setup_of_node(unsigned int cpu)
>   		return 0;
>   	}
>   
> -	if (!cpu_dev) {
> -		pr_err("No cpu device for CPU %d\n", cpu);
> -		return -ENODEV;
> -	}
> -	np = cpu_dev->of_node;
> +	np = of_cpu_device_node_get(cpu);
>   	if (!np) {
>   		pr_err("Failed to find cpu%d device node\n", cpu);
>   		return -ENOENT;
> 

