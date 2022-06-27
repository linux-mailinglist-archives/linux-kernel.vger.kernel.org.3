Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D473B55DE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiF0NmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiF0Nl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:41:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62A1B2DCD;
        Mon, 27 Jun 2022 06:41:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E471758;
        Mon, 27 Jun 2022 06:41:57 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AB623F5A1;
        Mon, 27 Jun 2022 06:41:56 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:41:54 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 01/20] ACPI: PPTT: Use table offset as fw_token
 instead of virtual address
Message-ID: <Yrmzkwur1NVQ8NSA@arm.com>
References: <20220621192034.3332546-1-sudeep.holla@arm.com>
 <20220621192034.3332546-2-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621192034.3332546-2-sudeep.holla@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tuesday 21 Jun 2022 at 20:20:15 (+0100), Sudeep Holla wrote:
> There is need to use the cache sharing information quite early during
> the boot before the secondary cores are up and running. The permanent
> memory map for all the ACPI tables(via acpi_permanent_mmap) is turned
> on in acpi_early_init() which is quite late for the above requirement.
> 
> As a result there is possibility that the ACPI PPTT gets mapped to
> different virtual addresses. In such scenarios, using virtual address as
> fw_token before the acpi_permanent_mmap is enabled results in different
> fw_token for the same cache entity and hence wrong cache sharing
> information will be deduced based on the same.
> 
> Instead of using virtual address, just use the table offset as the
> unique firmware token for the caches. The same offset is used as
> ACPI identifiers if the firmware has not set a valid one for other
> entries in the ACPI PPTT.
> 
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Hi Rafael,
> 
> If you are happy with this change, can you provide Ack, so that it can be
> merged together with other changes ?
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 701f61c01359..763f021d45e6 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -437,7 +437,8 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>  		pr_debug("found = %p %p\n", found_cache, cpu_node);
>  		if (found_cache)
>  			update_cache_properties(this_leaf, found_cache,
> -			                        cpu_node, table->revision);
> +						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
> +						table->revision);
>  
>  		index++;
>  	}
> -- 
> 2.36.1
> 

I've run the set on Kunpeng920 where Dietmar noticed an issue [1] before
and it looks good to me.

Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>

[1]
https://lore.kernel.org/lkml/0bf199a0-251d-323c-974a-bfd4e26f4cce@arm.com/

Thanks,
Ionela.
