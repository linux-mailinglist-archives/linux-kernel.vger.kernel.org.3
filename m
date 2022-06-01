Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E8539B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349243AbiFACwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiFACv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B87F26338E
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654051914;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZz1I+wyn0aWj3S3QoNUnvvCym824eLN41CHiYsQFi0=;
        b=W/ODVZQeSE0HS/S3PSCcxzKLifgyKFsmOWWBqBScBXlPHjg4BcDgWWL+FOTTwfQAVPhNG2
        UN34bmFpRHA/NyvNMhPkfiNljtxi77AsPuSW3Y7cFQE37YTYTHKltQxdWtqPC/A7W7dJTR
        AhYOk3b7DEUrcPfglcsCUOsKiXcPLic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-oR2SFYhPMnq0oHhTpTxB8w-1; Tue, 31 May 2022 22:51:50 -0400
X-MC-Unique: oR2SFYhPMnq0oHhTpTxB8w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ADC9858EED;
        Wed,  1 Jun 2022 02:51:50 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A5D7492C3B;
        Wed,  1 Jun 2022 02:51:44 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 03/16] cacheinfo: Move cache_leaves_are_shared out of
 CONFIG_OF
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <81bc47a8-ded7-be55-60c2-73bd1d363fd2@redhat.com>
Date:   Wed, 1 Jun 2022 10:51:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-4-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
> cache_leaves_are_shared is already used even with ACPI and PPTT. It checks
> if the cache leaves are the shared based on fw_token pointer. However it is
> defined conditionally only if CONFIG_OF is enabled which is wrong.
> 
> Move the function cache_leaves_are_shared out of CONFIG_OF and keep it
> generic. It also handles the case where both OF and ACPI is not defined.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/cacheinfo.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
> 

With below nits fixed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index c4547d8ac6f3..417e1ebf5525 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -33,13 +33,21 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
>   	return ci_cacheinfo(cpu);
>   }
>   
> -#ifdef CONFIG_OF
>   static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>   					   struct cacheinfo *sib_leaf)
>   {
> +	/*
> +	 * For non DT/ACPI systems, assume unique level 1 caches,
> +	 * system-wide shared caches for all other levels. This will be used
> +	 * only if arch specific code has not populated shared_cpu_map
> +	 */
> +	if (!IS_ENABLED(CONFIG_OF) && !(IS_ENABLED(CONFIG_ACPI)))
> +		return !(this_leaf->level == 1);
> +
>   	return sib_leaf->fw_token == this_leaf->fw_token;
>   }
>   

	if (!IS_ENABLED(CONFIG_OF) && !IS_ENABLED(CONFIG_ACPI))

         or

	if (!(IS_ENABLED(CONFIG_OF) || IS_ENABLED(CONFIG_ACPI)))

> +#ifdef CONFIG_OF
>   /* OF properties to query for a given cache type */
>   struct cache_type_info {
>   	const char *size_prop;
> @@ -193,16 +201,6 @@ static int cache_setup_of_node(unsigned int cpu)
>   }
>   #else
>   static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
> -static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
> -					   struct cacheinfo *sib_leaf)
> -{
> -	/*
> -	 * For non-DT/ACPI systems, assume unique level 1 caches, system-wide
> -	 * shared caches for all other levels. This will be used only if
> -	 * arch specific code has not populated shared_cpu_map
> -	 */
> -	return !(this_leaf->level == 1);
> -}
>   #endif
>   
>   int __weak cache_setup_acpi(unsigned int cpu)
> 

Thanks,
Gavin

