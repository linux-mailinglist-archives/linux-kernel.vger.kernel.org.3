Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E0451E801
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446591AbiEGPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377471AbiEGPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:07:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66513F31;
        Sat,  7 May 2022 08:03:42 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KwVxL4LtKzGpL4;
        Sat,  7 May 2022 23:00:54 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 23:03:39 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 23:03:39 +0800
Subject: Re: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
To:     Besar Wicaksono <bwicaksono@nvidia.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <sudeep.holla@arm.com>
CC:     <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220419205432.46021-1-bwicaksono@nvidia.com>
 <20220419205432.46021-3-bwicaksono@nvidia.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bf994eb0-0e6d-fd0b-3499-8c28d2c13cc9@huawei.com>
Date:   Sat, 7 May 2022 23:03:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220419205432.46021-3-bwicaksono@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/20 4:54, Besar Wicaksono wrote:
> ARM Performance Monitoring Unit Table describes the properties of PMU
> support in ARM-based system. The APMT table contains a list of nodes,
> each represents a PMU in the system that conforms to ARM CoreSight PMU
> architecture. The properties of each node include information required
> to access the PMU (e.g. MMIO base address, interrupt number) and also
> identification. For more detailed information, please refer to the
> specification below:
>   * APMT: https://developer.arm.com/documentation/den0117/latest
>   * ARM Coresight PMU:
>          https://developer.arm.com/documentation/ihi0091/latest
> 
> The initial support adds the detection of APMT table and generic
> infrastructure to create platform devices for ARM CoreSight PMUs.
> Similar to IORT the root pointer of APMT is preserved during runtime
> and each PMU platform device is given a pointer to the corresponding
> APMT node.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>   arch/arm64/Kconfig          |   1 +
>   drivers/acpi/arm64/Kconfig  |   3 +
>   drivers/acpi/arm64/Makefile |   1 +
>   drivers/acpi/arm64/apmt.c   | 176 ++++++++++++++++++++++++++++++++++++
>   drivers/acpi/bus.c          |   2 +
>   include/linux/acpi_apmt.h   |  19 ++++
>   6 files changed, 202 insertions(+)
>   create mode 100644 drivers/acpi/arm64/apmt.c
>   create mode 100644 include/linux/acpi_apmt.h
> 
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM APMT table support.
> + * Design document number: ARM DEN0117.
> + *
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#define pr_fmt(fmt)	"ACPI: APMT: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>

Please include <linux/acpi_apmt.h>, here is the similar patch:

https://lore.kernel.org/lkml/CAJZ5v0gqr97AFuk855UZkcVpDnmj1Q6B2PE32zWmx4eKxbNvCw@mail.gmail.com/T/

Thanks
Hanjun
