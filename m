Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038A59E95F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiHWR1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiHWR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:26:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1955FDF645;
        Tue, 23 Aug 2022 08:04:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA95113E;
        Tue, 23 Aug 2022 08:04:38 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03F553F70D;
        Tue, 23 Aug 2022 08:04:34 -0700 (PDT)
Message-ID: <4abccfc9-fbaf-8683-5641-f4b767f3f913@arm.com>
Date:   Tue, 23 Aug 2022 10:04:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] ACPI: processor: Remove freq Qos request for all CPUs
Content-Language: en-US
To:     Riwen Lu <luriwen@hotmail.com>, rafael@kernel.org,
        rui.zhang@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>
References: <TYWP286MB2601183235622B29FAF707B5B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <TYWP286MB2601183235622B29FAF707B5B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/23/22 02:43, Riwen Lu wrote:
> From: Riwen Lu <luriwen@kylinos.cn>
> 
> The freq Qos request would be removed repeatedly if the cpufreq policy
> relates to more than one CPU. Then, it would cause the "called for unknown
> object" warning.
> 
> Remove the freq Qos request for each CPU relates to the cpufreq policy,
> instead of removing repeatedly for the last CPU of it.
> 
> Fixes: a1bb46c36ce3 ("ACPI: processor: Add QoS requests for all CPUs")
> Reported-by: Jeremy Linton <Jeremy.Linton@arm.com>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>   drivers/acpi/processor_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index db6ac540e924..e534fd49a67e 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -151,7 +151,7 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
>   	unsigned int cpu;
>   
>   	for_each_cpu(cpu, policy->related_cpus) {
> -		struct acpi_processor *pr = per_cpu(processors, policy->cpu);
> +		struct acpi_processor *pr = per_cpu(processors, cpu);
>   
>   		if (pr)
>   			freq_qos_remove_request(&pr->thermal_req);

This appears to have fixed the module unloading problem. I haven't seen 
any newer issues either so:

Tested-by: Jeremy Linton <jeremy.linton@arm.com>


Thanks,

