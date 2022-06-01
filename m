Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96221539B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349313AbiFADUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349284AbiFADUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 978268B0B6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654053629;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBZo/5acJzjtkfbN0zPOUXTmooXsDFbwGkdumr2Rppw=;
        b=Cfc+tS+HvuC3/mK4nJa9EobrGl5VotDasG71zmWOTs43qXTxZFuX1pD+ph6N5oJqyhB4ps
        k0OK4IyVYBaYEzjIYgc8bIwC1+kU6s3VNBHuvlCu2IJJttmLW4kQywYpSTLssiqTM7YLCb
        nDEAbZ0FI0yFkSlcNFzY9+xv4EJLbUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-TIkAbRDJPAKi2hnHaoJ0_w-1; Tue, 31 May 2022 23:20:22 -0400
X-MC-Unique: TIkAbRDJPAKi2hnHaoJ0_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82E0E811E7A;
        Wed,  1 Jun 2022 03:20:21 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DB8A1731B;
        Wed,  1 Jun 2022 03:20:15 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 04/16] cacheinfo: Add support to check if last level
 cache(LLC) is valid or shared
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <bf63ca22-944d-b709-242f-fd09c66ff519@redhat.com>
Date:   Wed, 1 Jun 2022 11:20:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-5-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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
> It is useful to have helper to check if the given two CPUs share last level
> cache. We can do that check by comparing fw_token or by comparing the cache
> ID. Currently we check just for fw_token as the cache ID is optional.
> 
> This helper can be used to build the llc_sibling during arch specific
> topology parsing and feeding information to the sched_domains. This also
> helps to get rid of llc_id in the CPU topology as it is sort of duplicate
> information.
> 
> Also add helper to check if the llc information in cacheinfo is valid or not.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/cacheinfo.c  | 26 ++++++++++++++++++++++++++
>   include/linux/cacheinfo.h |  2 ++
>   2 files changed, 28 insertions(+)
> 

With below nits fixed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 417e1ebf5525..ed74db18468f 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -47,6 +47,32 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>   	return sib_leaf->fw_token == this_leaf->fw_token;
>   }
>   
> +bool last_level_cache_is_valid(unsigned int cpu)
> +{
> +	struct cacheinfo *llc;
> +
> +	if (!cache_leaves(cpu))
> +		return false;
> +
> +	llc = per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
> +
> +	return llc->fw_token;
> +}
> +

	return !!llc->fw_token;

> +bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y)
> +{
> +	struct cacheinfo *llc_x, *llc_y;
> +
> +	if (!last_level_cache_is_valid(cpu_x) ||
> +	    !last_level_cache_is_valid(cpu_y))
> +		return false;
> +
> +	llc_x = per_cpu_cacheinfo_idx(cpu_x, cache_leaves(cpu_x) - 1);
> +	llc_y = per_cpu_cacheinfo_idx(cpu_y, cache_leaves(cpu_y) - 1);
> +
> +	return cache_leaves_are_shared(llc_x, llc_y);
> +}
> +
>   #ifdef CONFIG_OF
>   /* OF properties to query for a given cache type */
>   struct cache_type_info {
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 4ff37cb763ae..7e429bc5c1a4 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -82,6 +82,8 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>   int init_cache_level(unsigned int cpu);
>   int populate_cache_leaves(unsigned int cpu);
>   int cache_setup_acpi(unsigned int cpu);
> +bool last_level_cache_is_valid(unsigned int cpu);
> +bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
>   #ifndef CONFIG_ACPI_PPTT
>   /*
>    * acpi_find_last_cache_level is only called on ACPI enabled
> 

Thanks,
Gavin

