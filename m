Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3960356A0E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiGGLH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiGGLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:07:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA3A359245;
        Thu,  7 Jul 2022 04:07:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 178F61063;
        Thu,  7 Jul 2022 04:07:49 -0700 (PDT)
Received: from [10.57.86.163] (unknown [10.57.86.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21DFB3F66F;
        Thu,  7 Jul 2022 04:07:45 -0700 (PDT)
Message-ID: <6c418ba1-36a6-1d54-6908-6235d8155904@arm.com>
Date:   Thu, 7 Jul 2022 12:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v3 2/2] perf: coresight_pmu: Add support for NVIDIA
 SCF and MCF attribute
To:     Besar Wicaksono <bwicaksono@nvidia.com>, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
 <20220621055035.31766-3-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220621055035.31766-3-bwicaksono@nvidia.com>
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

On 21/06/2022 06:50, Besar Wicaksono wrote:
> Add support for NVIDIA System Cache Fabric (SCF) and Memory Control
> Fabric (MCF) PMU attributes for CoreSight PMU implementation in
> NVIDIA devices.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>   drivers/perf/coresight_pmu/Makefile           |   3 +-
>   .../perf/coresight_pmu/arm_coresight_pmu.c    |   4 +
>   .../coresight_pmu/arm_coresight_pmu_nvidia.c  | 312 ++++++++++++++++++
>   .../coresight_pmu/arm_coresight_pmu_nvidia.h  |  17 +
>   4 files changed, 335 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
>   create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h
> 
> diff --git a/drivers/perf/coresight_pmu/Makefile b/drivers/perf/coresight_pmu/Makefile
> index a2a7a5fbbc16..181b1b0dbaa1 100644
> --- a/drivers/perf/coresight_pmu/Makefile
> +++ b/drivers/perf/coresight_pmu/Makefile
> @@ -3,4 +3,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_ARM_CORESIGHT_PMU) += \
> -	arm_coresight_pmu.o
> +	arm_coresight_pmu.o \
> +	arm_coresight_pmu_nvidia.o
> diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu.c b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
> index ba52cc592b2d..12179d029bfd 100644
> --- a/drivers/perf/coresight_pmu/arm_coresight_pmu.c
> +++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
> @@ -42,6 +42,7 @@
>   #include <acpi/processor.h>
>   
>   #include "arm_coresight_pmu.h"
> +#include "arm_coresight_pmu_nvidia.h"
>   
>   #define PMUNAME "arm_system_pmu"
>   
> @@ -396,6 +397,9 @@ struct impl_match {
>   };
>   
>   static const struct impl_match impl_match[] = {
> +	{ .pmiidr = 0x36B,
> +	  .mask = PMIIDR_IMPLEMENTER_MASK,
> +	  .impl_init_ops = nv_coresight_init_ops },
>   	{}
>   };
>   
> diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
> new file mode 100644
> index 000000000000..54f4eae4c529
> --- /dev/null
> +++ b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +/* Support for NVIDIA specific attributes. */
> +
> +#include "arm_coresight_pmu_nvidia.h"
> +
> +#define NV_MCF_PCIE_PORT_COUNT		10ULL
> +#define NV_MCF_PCIE_FILTER_ID_MASK	((1ULL << NV_MCF_PCIE_PORT_COUNT) - 1)
> +
> +#define NV_MCF_GPU_PORT_COUNT		2ULL
> +#define NV_MCF_GPU_FILTER_ID_MASK	((1ULL << NV_MCF_GPU_PORT_COUNT) - 1)
> +
> +#define NV_MCF_NVLINK_PORT_COUNT	4ULL
> +#define NV_MCF_NVLINK_FILTER_ID_MASK	((1ULL << NV_MCF_NVLINK_PORT_COUNT) - 1)
> +
> +#define PMIIDR_PRODUCTID_MASK		0xFFF
> +#define PMIIDR_PRODUCTID_SHIFT		20
> +
> +#define to_nv_pmu_impl(coresight_pmu)	\
> +	(container_of(coresight_pmu->impl.ops, struct nv_pmu_impl, ops))
> +
> +#define CORESIGHT_EVENT_ATTR_4_INNER(_pref, _num, _suff, _config)	\
> +	CORESIGHT_EVENT_ATTR(_pref##_num##_suff, _config)
> +
> +#define CORESIGHT_EVENT_ATTR_4(_pref, _suff, _config)			\
> +	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _0_, _suff, _config),	\
> +	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _1_, _suff, _config + 1),	\
> +	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _2_, _suff, _config + 2),	\
> +	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _3_, _suff, _config + 3)
> +
> +struct nv_pmu_impl {
> +	struct coresight_pmu_impl_ops ops;
> +	const char *name;
> +	u32 filter_mask;
> +	struct attribute **event_attr;
> +	struct attribute **format_attr;
> +};
> +
> +static struct attribute *scf_pmu_event_attrs[] = {
> +	CORESIGHT_EVENT_ATTR(bus_cycles,			0x1d),
> +
> +	CORESIGHT_EVENT_ATTR(scf_cache_allocate,		0xF0),
> +	CORESIGHT_EVENT_ATTR(scf_cache_refill,			0xF1),
> +	CORESIGHT_EVENT_ATTR(scf_cache,				0xF2),
> +	CORESIGHT_EVENT_ATTR(scf_cache_wb,			0xF3),
> +
> +	CORESIGHT_EVENT_ATTR_4(socket, rd_data,			0x101),
> +	CORESIGHT_EVENT_ATTR_4(socket, dl_rsp,			0x105),
> +	CORESIGHT_EVENT_ATTR_4(socket, wb_data,			0x109),
> +	CORESIGHT_EVENT_ATTR_4(socket, ev_rsp,			0x10d),
> +	CORESIGHT_EVENT_ATTR_4(socket, prb_data,		0x111),
> +
> +	CORESIGHT_EVENT_ATTR_4(socket, rd_outstanding,		0x115),
> +	CORESIGHT_EVENT_ATTR_4(socket, dl_outstanding,		0x119),
> +	CORESIGHT_EVENT_ATTR_4(socket, wb_outstanding,		0x11d),
> +	CORESIGHT_EVENT_ATTR_4(socket, wr_outstanding,		0x121),
> +	CORESIGHT_EVENT_ATTR_4(socket, ev_outstanding,		0x125),
> +	CORESIGHT_EVENT_ATTR_4(socket, prb_outstanding,		0x129),
> +
> +	CORESIGHT_EVENT_ATTR_4(socket, rd_access,		0x12d),
> +	CORESIGHT_EVENT_ATTR_4(socket, dl_access,		0x131),
> +	CORESIGHT_EVENT_ATTR_4(socket, wb_access,		0x135),
> +	CORESIGHT_EVENT_ATTR_4(socket, wr_access,		0x139),
> +	CORESIGHT_EVENT_ATTR_4(socket, ev_access,		0x13d),
> +	CORESIGHT_EVENT_ATTR_4(socket, prb_access,		0x141),
> +
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_rd_data,		0x145),
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_rd_access,		0x149),
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wb_access,		0x14d),
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_rd_outstanding,	0x151),
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wr_outstanding,	0x155),
> +
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_rd_data,		0x159),
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_rd_access,		0x15d),
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_wb_access,		0x161),
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_rd_outstanding,		0x165),
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_wr_outstanding,		0x169),
> +
> +	CORESIGHT_EVENT_ATTR(gmem_rd_data,			0x16d),
> +	CORESIGHT_EVENT_ATTR(gmem_rd_access,			0x16e),
> +	CORESIGHT_EVENT_ATTR(gmem_rd_outstanding,		0x16f),
> +	CORESIGHT_EVENT_ATTR(gmem_dl_rsp,			0x170),
> +	CORESIGHT_EVENT_ATTR(gmem_dl_access,			0x171),
> +	CORESIGHT_EVENT_ATTR(gmem_dl_outstanding,		0x172),
> +	CORESIGHT_EVENT_ATTR(gmem_wb_data,			0x173),
> +	CORESIGHT_EVENT_ATTR(gmem_wb_access,			0x174),
> +	CORESIGHT_EVENT_ATTR(gmem_wb_outstanding,		0x175),
> +	CORESIGHT_EVENT_ATTR(gmem_ev_rsp,			0x176),
> +	CORESIGHT_EVENT_ATTR(gmem_ev_access,			0x177),
> +	CORESIGHT_EVENT_ATTR(gmem_ev_outstanding,		0x178),
> +	CORESIGHT_EVENT_ATTR(gmem_wr_data,			0x179),
> +	CORESIGHT_EVENT_ATTR(gmem_wr_outstanding,		0x17a),
> +	CORESIGHT_EVENT_ATTR(gmem_wr_access,			0x17b),
> +
> +	CORESIGHT_EVENT_ATTR_4(socket, wr_data,			0x17c),
> +
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wr_data,		0x180),
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wb_data,		0x184),
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wr_access,		0x188),
> +	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wb_outstanding,	0x18c),
> +
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_wr_data,		0x190),
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_wb_data,		0x194),
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_wr_access,		0x198),
> +	CORESIGHT_EVENT_ATTR_4(ocu, rem_wb_outstanding,		0x19c),
> +
> +	CORESIGHT_EVENT_ATTR(gmem_wr_total_bytes,		0x1a0),
> +	CORESIGHT_EVENT_ATTR(remote_socket_wr_total_bytes,	0x1a1),
> +	CORESIGHT_EVENT_ATTR(remote_socket_rd_data,		0x1a2),
> +	CORESIGHT_EVENT_ATTR(remote_socket_rd_outstanding,	0x1a3),
> +	CORESIGHT_EVENT_ATTR(remote_socket_rd_access,		0x1a4),
> +
> +	CORESIGHT_EVENT_ATTR(cmem_rd_data,			0x1a5),
> +	CORESIGHT_EVENT_ATTR(cmem_rd_access,			0x1a6),
> +	CORESIGHT_EVENT_ATTR(cmem_rd_outstanding,		0x1a7),
> +	CORESIGHT_EVENT_ATTR(cmem_dl_rsp,			0x1a8),
> +	CORESIGHT_EVENT_ATTR(cmem_dl_access,			0x1a9),
> +	CORESIGHT_EVENT_ATTR(cmem_dl_outstanding,		0x1aa),
> +	CORESIGHT_EVENT_ATTR(cmem_wb_data,			0x1ab),
> +	CORESIGHT_EVENT_ATTR(cmem_wb_access,			0x1ac),
> +	CORESIGHT_EVENT_ATTR(cmem_wb_outstanding,		0x1ad),
> +	CORESIGHT_EVENT_ATTR(cmem_ev_rsp,			0x1ae),
> +	CORESIGHT_EVENT_ATTR(cmem_ev_access,			0x1af),
> +	CORESIGHT_EVENT_ATTR(cmem_ev_outstanding,		0x1b0),
> +	CORESIGHT_EVENT_ATTR(cmem_wr_data,			0x1b1),
> +	CORESIGHT_EVENT_ATTR(cmem_wr_outstanding,		0x1b2),
> +
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_rd_data,		0x1b3),
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_rd_access,		0x1b7),
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wb_access,		0x1bb),
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_rd_outstanding,	0x1bf),
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wr_outstanding,	0x1c3),
> +
> +	CORESIGHT_EVENT_ATTR(ocu_prb_access,			0x1c7),
> +	CORESIGHT_EVENT_ATTR(ocu_prb_data,			0x1c8),
> +	CORESIGHT_EVENT_ATTR(ocu_prb_outstanding,		0x1c9),
> +
> +	CORESIGHT_EVENT_ATTR(cmem_wr_access,			0x1ca),
> +
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wr_access,		0x1cb),
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wb_data,		0x1cf),
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wr_data,		0x1d3),
> +	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wb_outstanding,	0x1d7),
> +
> +	CORESIGHT_EVENT_ATTR(cmem_wr_total_bytes,		0x1db),
> +
> +	CORESIGHT_EVENT_ATTR(cycles, CORESIGHT_PMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +static struct attribute *mcf_pmu_event_attrs[] = {
> +	CORESIGHT_EVENT_ATTR(rd_bytes_loc,			0x0),
> +	CORESIGHT_EVENT_ATTR(rd_bytes_rem,			0x1),
> +	CORESIGHT_EVENT_ATTR(wr_bytes_loc,			0x2),
> +	CORESIGHT_EVENT_ATTR(wr_bytes_rem,			0x3),
> +	CORESIGHT_EVENT_ATTR(total_bytes_loc,			0x4),
> +	CORESIGHT_EVENT_ATTR(total_bytes_rem,			0x5),
> +	CORESIGHT_EVENT_ATTR(rd_req_loc,			0x6),
> +	CORESIGHT_EVENT_ATTR(rd_req_rem,			0x7),
> +	CORESIGHT_EVENT_ATTR(wr_req_loc,			0x8),
> +	CORESIGHT_EVENT_ATTR(wr_req_rem,			0x9),
> +	CORESIGHT_EVENT_ATTR(total_req_loc,			0xa),
> +	CORESIGHT_EVENT_ATTR(total_req_rem,			0xb),
> +	CORESIGHT_EVENT_ATTR(rd_cum_outs_loc,			0xc),
> +	CORESIGHT_EVENT_ATTR(rd_cum_outs_rem,			0xd),
> +	CORESIGHT_EVENT_ATTR(cycles, CORESIGHT_PMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +static struct attribute *scf_pmu_format_attrs[] = {
> +	CORESIGHT_FORMAT_EVENT_ATTR,
> +	NULL,
> +};
> +
> +static struct attribute *mcf_pcie_pmu_format_attrs[] = {
> +	CORESIGHT_FORMAT_EVENT_ATTR,
> +	CORESIGHT_FORMAT_ATTR(root_port, "config1:0-9"),
> +	NULL,
> +};
> +
> +static struct attribute *mcf_gpu_pmu_format_attrs[] = {
> +	CORESIGHT_FORMAT_EVENT_ATTR,
> +	CORESIGHT_FORMAT_ATTR(gpu, "config1:0-1"),
> +	NULL,
> +};
> +
> +static struct attribute *mcf_nvlink_pmu_format_attrs[] = {
> +	CORESIGHT_FORMAT_EVENT_ATTR,
> +	CORESIGHT_FORMAT_ATTR(socket, "config1:0-3"),
> +	NULL,
> +};
> +
> +static struct attribute **
> +nv_coresight_pmu_get_event_attrs(const struct coresight_pmu *coresight_pmu)
> +{
> +	const struct nv_pmu_impl *impl = to_nv_pmu_impl(coresight_pmu);
> +
> +	return impl->event_attr;
> +}
> +
> +static struct attribute **
> +nv_coresight_pmu_get_format_attrs(const struct coresight_pmu *coresight_pmu)
> +{
> +	const struct nv_pmu_impl *impl = to_nv_pmu_impl(coresight_pmu);
> +
> +	return impl->format_attr;
> +}
> +
> +static const char *
> +nv_coresight_pmu_get_name(const struct coresight_pmu *coresight_pmu)
> +{
> +	const struct nv_pmu_impl *impl = to_nv_pmu_impl(coresight_pmu);
> +
> +	return impl->name;
> +}
> +
> +static u32 nv_coresight_pmu_event_filter(const struct perf_event *event)
> +{
> +	const struct nv_pmu_impl *impl =
> +		to_nv_pmu_impl(to_coresight_pmu(event->pmu));
> +	return event->attr.config1 & impl->filter_mask;
> +}
> +
> +int nv_coresight_init_ops(struct coresight_pmu *coresight_pmu)
> +{
> +	u32 product_id;
> +	struct device *dev;
> +	struct nv_pmu_impl *impl;
> +	static atomic_t pmu_idx = {0};
> +
> +	dev = coresight_pmu->dev;
> +
> +	impl = devm_kzalloc(dev, sizeof(struct nv_pmu_impl), GFP_KERNEL);
> +	if (!impl)
> +		return -ENOMEM;
> +
> +	product_id = (coresight_pmu->impl.pmiidr >> PMIIDR_PRODUCTID_SHIFT) &
> +		     PMIIDR_PRODUCTID_MASK;
> +
> +	switch (product_id) {
> +	case 0x103:
> +		impl->name =
> +			devm_kasprintf(dev, GFP_KERNEL,
> +				       "nvidia_mcf_pcie_pmu_%u",
> +				       coresight_pmu->apmt_node->proc_affinity);
> +		impl->filter_mask	= NV_MCF_PCIE_FILTER_ID_MASK;
> +		impl->event_attr	= mcf_pmu_event_attrs;
> +		impl->format_attr	= mcf_pcie_pmu_format_attrs;
> +		break;
> +	case 0x104:
> +		impl->name =
> +			devm_kasprintf(dev, GFP_KERNEL,
> +				       "nvidia_mcf_gpuvir_pmu_%u",
> +				       coresight_pmu->apmt_node->proc_affinity);
> +		impl->filter_mask	= NV_MCF_GPU_FILTER_ID_MASK;
> +		impl->event_attr	= mcf_pmu_event_attrs;
> +		impl->format_attr	= mcf_gpu_pmu_format_attrs;
> +		break;
> +	case 0x105:
> +		impl->name =
> +			devm_kasprintf(dev, GFP_KERNEL,
> +				       "nvidia_mcf_gpu_pmu_%u",
> +				       coresight_pmu->apmt_node->proc_affinity);
> +		impl->filter_mask	= NV_MCF_GPU_FILTER_ID_MASK;
> +		impl->event_attr	= mcf_pmu_event_attrs;
> +		impl->format_attr	= mcf_gpu_pmu_format_attrs;
> +		break;
> +	case 0x106:
> +		impl->name =
> +			devm_kasprintf(dev, GFP_KERNEL,
> +				       "nvidia_mcf_nvlink_pmu_%u",
> +				       coresight_pmu->apmt_node->proc_affinity);
> +		impl->filter_mask	= NV_MCF_NVLINK_FILTER_ID_MASK;
> +		impl->event_attr	= mcf_pmu_event_attrs;
> +		impl->format_attr	= mcf_nvlink_pmu_format_attrs;
> +		break;
> +	case 0x2CF:
> +		impl->name =
> +			devm_kasprintf(dev, GFP_KERNEL, "nvidia_scf_pmu_%u",
> +				       coresight_pmu->apmt_node->proc_affinity);
> +		impl->filter_mask	= 0x0;
> +		impl->event_attr	= scf_pmu_event_attrs;
> +		impl->format_attr	= scf_pmu_format_attrs;
> +		break;
> +	default:
> +		impl->name =
> +			devm_kasprintf(dev, GFP_KERNEL, "nvidia_uncore_pmu_%u",
> +				       atomic_fetch_inc(&pmu_idx));
> +		impl->filter_mask = CORESIGHT_FILTER_MASK;
> +		impl->event_attr  = coresight_pmu_get_event_attrs(coresight_pmu);
> +		impl->format_attr =
> +			coresight_pmu_get_format_attrs(coresight_pmu);

Couldn't we make the generic driver fall back to these routines if a 
"IP" pmu specific backend doesn't implement these callback ?

Thanks
Suzuki
