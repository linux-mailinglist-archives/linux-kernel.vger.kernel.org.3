Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D925859C4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiHVRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbiHVRJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:09:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83457CE3E;
        Mon, 22 Aug 2022 10:09:17 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MBJfC2B57z67xMh;
        Tue, 23 Aug 2022 01:05:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 19:09:14 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 22 Aug
 2022 18:09:14 +0100
Date:   Mon, 22 Aug 2022 18:09:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <john.garry@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/4] cxl/pci: Find and register CXL PMU devices
Message-ID: <20220822180852.000002f9@huawei.com>
In-Reply-To: <20220812151214.2025-3-Jonathan.Cameron@huawei.com>
References: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
        <20220812151214.2025-3-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 16:12:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> CXL PMU devices can be found from entries in the Register
> Locator DVSEC.
> 
> In order to register the minimum number of IRQ vectors necessary
> to support all CPMUs found, separate the registration into two
> steps.  First find the devices, and query the IRQs used and then
> register the devices. Between these two steps, request the
> IRQ vectors necessary and enable bus master support.
> 
> Future IRQ users for CXL type 3 devices (e.g. DOEs) will need to
> follow a similar pattern the number of vectors necessary is known
> before any parts of the driver stack rely on their availability.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
A few bugs in here that the kernel test robot found.

I'll send a v2 shortly with those tidied up.

One observation is that cxl/core/core.h dereferences
a struct cxl_memdev element which means we have a header ordering
dependency between that and cxl/cxlmem.h which we should find a clean
way to fix.
 
> 
> ---
> 
> Open questions
> 1) Is this IRQ vector 'count' / request then use approach flexible
>    enough for other interrupt users on these devices.
> 2) Does hanging the CPMU off the PCI device make sense. These can
>    occur in Switch upstream ports as well.
> 3) Naming.  It would be nice if the device naming indicated which
>    EP these were associated with, but that wouldn't be inline
>    with the rest of the CXL bus device naming.  What is best
>    option here?
> ---
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/core.h   |  3 ++
>  drivers/cxl/core/cpmu.c   | 67 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |  2 ++
>  drivers/cxl/core/regs.c   | 29 +++++++++++++++
>  drivers/cxl/cpmu.h        | 54 ++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         | 15 ++++++++
>  drivers/cxl/cxlpci.h      |  1 +
>  drivers/cxl/pci.c         | 76 ++++++++++++++++++++++++++++++++++++++-
>  9 files changed, 247 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79c7257f4107..1318e8a6830f 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -10,4 +10,5 @@ cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
> +cxl_core-y += cpmu.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1d8f87be283f..d2b12cdfd61f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -14,12 +14,14 @@ extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_delete_region;
>  extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
> +extern const struct device_type cxl_cpmu_type;
>  extern const struct device_type cxl_region_type;
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
>  #define CXL_REGION_TYPE(x) (&cxl_region_type)
>  #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
>  #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
> +#define CXL_CPMU_TYPE(x) (&cxl_cpmu_region_type)
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
>  #else
> @@ -37,6 +39,7 @@ static inline void cxl_region_exit(void)
>  #define CXL_REGION_TYPE(x) NULL
>  #define SET_CXL_REGION_ATTR(x)
>  #define CXL_PMEM_REGION_TYPE(x) NULL
> +#define CXL_CPMU_TYPE(x) NULL
>  #endif
>  

Side note, the presence of 
cxl_ep_load() in here means anything including this header needs to include
cxlmem.h which seems a bit of a violation of layering between the core
headers and more driver specific ones.


>  struct cxl_send_command;
> diff --git a/drivers/cxl/core/cpmu.c b/drivers/cxl/core/cpmu.c
> new file mode 100644
> index 000000000000..2d17d4083c8f
> --- /dev/null
> +++ b/drivers/cxl/core/cpmu.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Huawei. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include <cpmu.h>
> +#include <cxl.h>
> +
> +static DEFINE_IDA(cpmu_ida);
> +
> +static void cxl_cpmu_release(struct device *dev)
> +{
> +	struct cxl_cpmu *cpmu = container_of(dev, struct cxl_cpmu, dev);
> +
> +	ida_free(&cpmu_ida, cpmu->id);
> +	kfree(cpmu);
> +}
> +
> +const struct device_type cxl_cpmu_type = {

Should include core/core.h to avoid a should this be static warning.

> +	.name = "cxl_cpmu",
> +	.release = cxl_cpmu_release,
> +};
> +
> +static void remove_dev(void *dev)
> +{
> +	device_del(dev);
> +}
> +


> diff --git a/drivers/cxl/cpmu.h b/drivers/cxl/cpmu.h
> new file mode 100644
> index 000000000000..880077bf0b9f
> --- /dev/null
> +++ b/drivers/cxl/cpmu.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright(c) 2022 Huawei
> + * CXL Specification rev 3.0 Setion 8.2.7 (CPMU Register Interface)
> + */
> +#ifndef CXL_CPMU_H
> +#define CXL_CPMU_H
> +
> +#define CPMU_CAP_REG			0x0
> +#define   CPMU_CAP_NUM_COUNTERS_MSK		GENMASK_ULL(4, 0)
> +#define   CPMU_CAP_COUNTER_WIDTH_MSK		GENMASK_ULL(15, 8)
> +#define   CPMU_CAP_NUM_EVN_CAP_REG_SUP_MSK	GENMASK_ULL(24, 20)
> +#define   CPMU_CAP_FILTERS_SUP_MSK		GENMASK_ULL(39, 32)
> +#define   CPMU_CAP_MSI_N_MSK			GENMASK_ULL(47, 44)
> +#define   CPMU_CAP_WRITEABLE_WHEN_FROZEN	BIT(48)
> +#define   CPMU_CAP_FREEZE			BIT(49)
> +#define   CPMU_CAP_INT				BIT(50)
BIT_ULL() needed for these.

> +#define   CPMU_CAP_VERSION_MSK			GENMASK_ULL(63, 60)
> +
> +#define CPMU_OVERFLOW_REG		0x10
> +#define CPMU_FREEZE_REG			0x18
> +#define CPMU_EVENT_CAP_REG(n)		(0x100 + 8 * (n))
> +#define   CPMU_EVENT_CAP_SUPPORTED_EVENTS_MSK	GENMASK_ULL(31, 0)
> +#define   CPMU_EVENT_CAP_GROUP_ID_MSK		GENMASK_ULL(47, 32)
> +#define   CPMU_EVENT_CAP_VENDOR_ID_MSK		GENMASK_ULL(63, 48)
> +
> +#define CPMU_COUNTER_CFG_REG(n)		(0x200 + 8 * (n))
> +#define   CPMU_COUNTER_CFG_TYPE_MSK		GENMASK_ULL(1, 0)
> +#define     CPMU_COUNTER_CFG_TYPE_FREE_RUN	0
> +#define     CPMU_COUNTER_CFG_TYPE_FIXED_FUN	1
> +#define     CPMU_COUNTER_CFG_TYPE_CONFIGURABLE	2
> +#define   CPMU_COUNTER_CFG_ENABLE		BIT(8)
> +#define   CPMU_COUNTER_CFG_INT_ON_OVRFLW	BIT(9)
> +#define   CPMU_COUNTER_CFG_FREEZE_ON_OVRFLW	BIT(10)
> +#define   CPMU_COUNTER_CFG_EDGE			BIT(11)
> +#define   CPMU_COUNTER_CFG_INVERT		BIT(12)
> +#define   CPMU_COUNTER_CFG_THRESHOLD_MSK	GENMASK_ULL(23, 16)
> +#define   CPMU_COUNTER_CFG_EVENTS_MSK		GENMASK_ULL(55, 24)
> +#define   CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK	GENMASK_ULL(63, 59)
> +
> +#define CPMU_FILTER_CFG_REG(n, f)	(0x400 + 4 * ((f) + (n) * 8))
> +#define   CPMU_FILTER_CFG_VALUE_MSK		GENMASK(15, 0)
> +
> +#define CPMU_COUNTER_REG(n)			(0xc00 + 8 * (n))
> +
> +#define CPMU_REGMAP_SIZE 0xe00 /* Table 8-32 CXL 3.0 specification */
> +struct cxl_cpmu {
> +	struct device dev;
> +	void __iomem *base;
> +	int id;
> +};
> +
> +#define to_cxl_cpmu(dev) container_of(dev, struct cxl_cpmu, dev)
> +#endif
