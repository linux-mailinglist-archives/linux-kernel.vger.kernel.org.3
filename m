Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997FA52EC36
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbiETMeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbiETMeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:34:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B44AD166467
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:34:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FF431477;
        Fri, 20 May 2022 05:34:02 -0700 (PDT)
Received: from [172.29.1.145] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF0A3F718;
        Fri, 20 May 2022 05:33:59 -0700 (PDT)
Message-ID: <087176fc-1018-b107-06cc-055d7926b500@arm.com>
Date:   Fri, 20 May 2022 14:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 8/8] arch_topology: Add support to build llc_sibling on
 DT platforms
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-9-sudeep.holla@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220518093325.2070336-9-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 11:33, Sudeep Holla wrote:
> ACPI PPTT provides cache identifiers and especially the last level cache
> identifier is used in obtaining last level cache siblings amongst CPUs.
> 
> While we have the cpu map representing all the CPUs sharing last level
> cache in the cacheinfo driver, it is populated quite late in the boot
> while the information is needed to build scheduler domains quite early.
> 
> On DT platforms we can use the pointer to the last level cache as the
> firmware identifier for the last level cache and build the cpumap sharing
> the last level cache based on the same.

[...]

> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 58cbe18d825c..d8a36b0e27c9 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -69,6 +69,7 @@ struct cpu_topology {
>  	int cluster_id;
>  	int package_id;
>  	int llc_id;
> +	void *llc_fw_node;

Would be nicer if you could set llc_id directly to avoid all this
addition sync `llc_id and llc_fw_node` code. ACPI PPTT has this
ACPI_PTR_DIFF() macro which IMHO lets it create distinct ids.

>  	cpumask_t thread_sibling;
>  	cpumask_t core_sibling;
>  	cpumask_t cluster_sibling;

