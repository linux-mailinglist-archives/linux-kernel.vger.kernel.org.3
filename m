Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E4539BAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349381AbiFADaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiFADaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0B9D6B0A9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654054201;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/QwG2vgWhruUHVSTvB1NROdcFoX8UsFct3vWYpMtXc=;
        b=dXnkLHQRh0c/hxeCfkKJU3Mt6+EgO79eebVKv6CXMObdLXRkS231qAjj39+f8wdGx1J0/o
        BesP/BWjd2c4fuYFYTcHpvnY8vtCInHkse9+Keegw9AQR9EVvki6WErFbmc2UNV3dwsHow
        lEvjOHS5M2GeHUaWcvbRpfsATSWb7Eo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-_0wYGXsEMgO2MBWxFVFRVw-1; Tue, 31 May 2022 23:29:57 -0400
X-MC-Unique: _0wYGXsEMgO2MBWxFVFRVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A55C101A54E;
        Wed,  1 Jun 2022 03:29:56 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 680822166B26;
        Wed,  1 Jun 2022 03:29:50 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 06/16] arch_topology: Add support to parse and detect
 cache attributes
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <ccfcf360-fc61-7e6d-5814-1fb98a836f8f@redhat.com>
Date:   Wed, 1 Jun 2022 11:29:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220525081416.3306043-7-sudeep.holla@arm.com>
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
> Currently ACPI populates just the minimum information about the last
> level cache from PPTT in order to feed the same to build sched_domains.
> Similar support for DT platforms is not present.
> 
> In order to enable the same, the entire cache hierarchy information can
> be built as part of CPU topoplogy parsing both on ACPI and DT platforms.
> 
> Note that this change builds the cacheinfo early even on ACPI systems, but
> the current mechanism of building llc_sibling mask remains unchanged.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/arch_topology.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 

With below nits fixed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index f73b836047cf..765723448b10 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/acpi.h>
> +#include <linux/cacheinfo.h>
>   #include <linux/cpu.h>
>   #include <linux/cpufreq.h>
>   #include <linux/device.h>
> @@ -775,15 +776,23 @@ __weak int __init parse_acpi_topology(void)
>   #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>   void __init init_cpu_topology(void)
>   {
> +	int ret, cpu;
> +
>   	reset_cpu_topology();
> +	ret = parse_acpi_topology();
> +	if (!ret)
> +		ret = of_have_populated_dt() && parse_dt_topology();
>   
> -	/*
> -	 * Discard anything that was parsed if we hit an error so we
> -	 * don't use partial information.
> -	 */
> -	if (parse_acpi_topology())
> -		reset_cpu_topology();
> -	else if (of_have_populated_dt() && parse_dt_topology())
> +	if(ret) {
> +		/*
> +		 * Discard anything that was parsed if we hit an error so we
> +		 * don't use partial information.
> +		 */
>   		reset_cpu_topology();
> +		return;
> +	}
> +
> +	for_each_possible_cpu(cpu)
> +		detect_cache_attributes(cpu);
>   }
>   #endif
> 

# ./scripts/checkpatch.pl --codespell patch/check/0006*
ERROR: space required before the open parenthesis '('
#55: FILE: drivers/base/arch_topology.c:786:
+	if(ret) {

Thanks,
Gavin

