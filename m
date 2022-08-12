Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6446590DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiHLJKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbiHLJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DECE1CB19;
        Fri, 12 Aug 2022 02:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04A19B8233B;
        Fri, 12 Aug 2022 09:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81898C433C1;
        Fri, 12 Aug 2022 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660295429;
        bh=L1qQj4Sqy95V3asSe6S78PEGO1+bZY/V3xlMQXx4ZYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0Ecn2SaYIZtNwkyyeQW930uXrROqPecE0AIBdlCAkCSmcIWYotrY0SWSV00LyCx7
         rvSSbniLHJsMoNw1Z/wjBbch6aaHTv9P+c6ytFlRLoyj6Mezo4YLPexr7jKdQ00+aT
         JGrHIGqTeSoi9O9QGbQPLYIaHvNWfFqWbpLdG57t8jwgxwysRrMWfgxvpG04rPX8BC
         T5VfY2qMXjCcwgXIIHOiySXy5XSF0yWOZcMXhFpsS6lyOXnykeqPD6A7el1jLSsAVH
         7GiAQX89+I+H7weZEZmCxSebJdFrtRRlHg0dLrNvISQqaYupZet7m4YrT+nNwQ6EVz
         yBKJ+uz2b7dGA==
Date:   Fri, 12 Aug 2022 14:40:12 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, beanhuo@micron.com,
        avri.altman@wdc.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        jongmin jeong <jjmin.jeong@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] scsi: ufs: Add Multi-Circular Queue support
Message-ID: <20220812091012.GB4956@thinkpad>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
 <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1660213984-37793-2-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 03:33:03AM -0700, Can Guo wrote:
> From: Asutosh Das <quic_asutoshd@quicinc.com>
> 
> Adds MCQ support to UFS.
> 
> The design uses shared tags across all the hw queues.
> The queue-depth is chosen within range supported by controller &
> device. It also takes EXT_IID into account while choosing the queue
> depth.
> 
> It supports default, read, poll and a dev cmd queue.
> It enables MCQ after determining the queue-depth that the ufs
> device supports.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>

As per the Documentation, "Co-developed-by" should be followed by
"Signed-off-by" of the author. So you can just move this "Co-developed-by"
below Asutosh's S-o-b and that should be fine.

> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/ufs/core/Makefile  |   2 +-
>  drivers/ufs/core/ufs-mcq.c | 524 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd.c  | 394 ++++++++++++++++++++++++++--------
>  include/ufs/ufs.h          |   5 +
>  include/ufs/ufshcd.h       | 223 ++++++++++++++++++-
>  include/ufs/ufshci.h       |  77 +++++++
>  6 files changed, 1135 insertions(+), 90 deletions(-)

This patch is too big to review. Could you please split it into multiple
patches?

>  create mode 100644 drivers/ufs/core/ufs-mcq.c
> 
> diff --git a/drivers/ufs/core/Makefile b/drivers/ufs/core/Makefile
> index 62f38c5..4d02e0f 100644
> --- a/drivers/ufs/core/Makefile
> +++ b/drivers/ufs/core/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_SCSI_UFSHCD)		+= ufshcd-core.o
> -ufshcd-core-y				+= ufshcd.o ufs-sysfs.o
> +ufshcd-core-y				+= ufshcd.o ufs-sysfs.o ufs-mcq.o
>  ufshcd-core-$(CONFIG_DEBUG_FS)		+= ufs-debugfs.o
>  ufshcd-core-$(CONFIG_SCSI_UFS_BSG)	+= ufs_bsg.o
>  ufshcd-core-$(CONFIG_SCSI_UFS_CRYPTO)	+= ufshcd-crypto.o
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> new file mode 100644
> index 0000000..9d87153
> --- /dev/null
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, Linux Foundation. All rights reserved.

I think you need to add a new Copyright for quicinc.

> + *
> + * Authors:
> + *	Asutosh Das <quic_asutoshd@quicinc.com>
> + *	Can Guo <quic_cang@quicinc.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <asm/unaligned.h>
> +
> +#include <ufs/ufshcd.h>
> +

Please sort the includes alphabetically.

> +#define MCQ_CFG_MAC_OFFSET	8
> +#define MCQ_CFG_MAC_MASK	UFS_MASK(0x1FF, MCQ_CFG_MAC_OFFSET)

Please use lowercase for hex

> +
> +#define MCQ_QCFGPTR_MASK	0xff
> +#define MCQ_QCFGPTR_UNIT	0x200
> +#define mcq_sqattr_offset(c) \
> +	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
> +
> +#define MCQ_ENTRY_SIZE_IN_DWORD	8
> +#define MCQ_QCFG_SIZE	0x40
> +
> +static unsigned int dev_cmd_queue = 1;
> +static unsigned int read_queues;

Where is this initialized?

> +static unsigned int poll_queues = 1;

Since these are the default sizes, this could be best defined as a define
instead of a variable.

> +
> +static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret)
> +		return ret;
> +	if (n > num_possible_cpus())
> +		return -EINVAL;
> +	return param_set_uint(val, kp);
> +}
> +
> +static const struct kernel_param_ops rw_queue_count_ops = {
> +	.set = rw_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int rw_queues = 8;
> +module_param_cb(rw_queues, &rw_queue_count_ops, &rw_queues, 0644);
> +MODULE_PARM_DESC(rw_queues, "Number of queues used for rw. Default value is 8");
> +

Using module params is not encouraged these days. So please switch to Kconfig.

> +/* resources */
> +static const struct ufshcd_res_info_t ufshcd_res_info[RES_MAX] = {
> +	{"ufs_mem", NULL, NULL},
> +	{"mcq", NULL, NULL},
> +	{"mcq_sqd", NULL, NULL},
> +	{"mcq_sqis", NULL, NULL},
> +	{"mcq_cqd", NULL, NULL},
> +	{"mcq_cqis", NULL, NULL},
> +	{"mcq_vs", NULL, NULL},

These resources also need a devicetree binding change, isn't it?

> +};
> +
> +u32 ufshcd_mcq_find_queue_depth(struct ufs_hba *hba)
> +{
> +	u32 qd, val, mac;

s/qd/depth

> +
> +	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);

This could be moved inside the if() condition below to avoid reading the
register if platform provides the MAC value.

> +	mac = ufshcd_mcq_vops_get_hba_mac(hba);
> +	if (mac < 0)
> +		mac = (val & MCQ_CFG_MAC_MASK) >> MCQ_CFG_MAC_OFFSET;

Use bitfield macros here and throughout the driver where applicable.

> +
> +	/*  MAC is a 0 based value. */
> +	mac += 1;
> +	qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
> +	if (!qd)
> +		qd = mac;
> +
> +	/* Adjust queue depth based on ext_iid support. */
> +	if (qd > 256 && (!hba->ext_iid_sup || !hba->dev_info.b_ext_iid_en))
> +		qd = 256;
> +	if (qd > 4096 && hba->ext_iid_sup && hba->dev_info.b_ext_iid_en)
> +		qd = 4096;
> +
> +	return qd;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_find_queue_depth);

Is this API used outside of this driver? If not, then there is no need to
export it. This seems to be the case for below APIs as well. Please audit
all of them.

If you think that the APIs might be needed for other drivers in the future,
then at that time, they can be exported.

> +
> +void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 set)
> +{
> +	u32 val;
> +
> +	val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
> +	val &= ~MCQ_CFG_MAC_MASK;
> +	val |= set << MCQ_CFG_MAC_OFFSET;
> +	ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
> +
> +struct ufs_hw_queue *ufshcd_mcq_find_hwq(struct ufs_hba *hba,
> +					 struct request *req)
> +{
> +	u32 utag, hwq;
> +
> +	utag = blk_mq_unique_tag(req);
> +	hwq = blk_mq_unique_tag_to_hwq(utag);
> +
> +	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_find_hwq);
> +
> +int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
> +{
> +	struct ufs_hw_queue *hwq;
> +	size_t utrdl_size, cqe_size;
> +	int i;
> +
> +	for_each_hw_queue(hba, i) {
> +		hwq = &hba->uhq[i];
> +
> +		utrdl_size = sizeof(struct utp_transfer_req_desc) *
> +			     hwq->max_entries;
> +		hwq->sqe_base_addr = dmam_alloc_coherent(hba->dev, utrdl_size,
> +							 &hwq->sqe_dma_addr,
> +							 GFP_KERNEL);
> +		if (!hwq->sqe_dma_addr || WARN_ON(hwq->sqe_dma_addr &
> +						  (PAGE_SIZE - 1))) {
> +			dev_err(hba->dev, "Alloc SQE failed\n");

SQE allocation failed?

> +			return -ENOMEM;
> +		}
> +
> +		cqe_size = sizeof(struct cq_entry) * hwq->max_entries;
> +		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
> +							 &hwq->cqe_dma_addr,
> +							 GFP_KERNEL);
> +		if (!hwq->cqe_dma_addr || WARN_ON(hwq->cqe_dma_addr &
> +						  (PAGE_SIZE - 1))) {
> +			dev_err(hba->dev, "Alloc CQE failed\n");

CQE allocation failed?

> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_memory_alloc);
> +
> +#define MCQ_CFG_n(r, i) \
> +	((r) + MCQ_QCFG_SIZE * (i))
> +#define MCQ_ROP_OFFSET_n(p, i) \
> +	(hba->mcq_rop[(p)].offset + hba->mcq_rop[(p)].stride * (i))
> +
> +static inline void __iomem *mcq_rop_base(struct ufs_hba *hba,
> +					 enum ufshcd_mcq_rop n, int i)

No inline please... compiler should do it if it sees fit.

> +{
> +	struct ufshcd_mcq_rop_info_t *rop = &hba->mcq_rop[n];
> +
> +	return rop->base + rop->stride * i;
> +}
> +
> +void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
> +{
> +	struct ufs_hw_queue *hwq;
> +	u16 qsize;
> +	int i;
> +
> +	for_each_hw_queue(hba, i) {
> +		hwq = &hba->uhq[i];
> +		hwq->id = i;
> +		qsize = hwq->max_entries * MCQ_ENTRY_SIZE_IN_DWORD - 1;
> +
> +		/* SQLBA */
> +		ufsmcq_writel(hba, lower_32_bits(hwq->sqe_dma_addr),
> +			      MCQ_CFG_n(REG_SQLBA, i));
> +		/* SQUBA */
> +		ufsmcq_writel(hba, upper_32_bits(hwq->sqe_dma_addr),
> +			      MCQ_CFG_n(REG_SQUBA, i));
> +		/* SQDAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_SQD, i),
> +			      MCQ_CFG_n(REG_SQDAO, i));
> +		/* SQISAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_SQIS, i),
> +			      MCQ_CFG_n(REG_SQISAO, i));
> +
> +		/* CQLBA */
> +		ufsmcq_writel(hba, lower_32_bits(hwq->cqe_dma_addr),
> +			      MCQ_CFG_n(REG_CQLBA, i));
> +		/* CQUBA */
> +		ufsmcq_writel(hba, upper_32_bits(hwq->cqe_dma_addr),
> +			      MCQ_CFG_n(REG_CQUBA, i));
> +		/* CQDAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_CQD, i),
> +			      MCQ_CFG_n(REG_CQDAO, i));
> +		/* CQISAO */
> +		ufsmcq_writel(hba, MCQ_ROP_OFFSET_n(ROP_CQIS, i),
> +			      MCQ_CFG_n(REG_CQISAO, i));
> +
> +		/* Save the base addresses for quicker access */
> +		hwq->mcq_sq_hp = mcq_rop_base(hba, ROP_SQD, i) + REG_SQHP;
> +		hwq->mcq_sq_tp = mcq_rop_base(hba, ROP_SQD, i) + REG_SQTP;
> +		hwq->mcq_cq_hp = mcq_rop_base(hba, ROP_CQD, i) + REG_CQHP;
> +		hwq->mcq_cq_tp = mcq_rop_base(hba, ROP_CQD, i) + REG_CQTP;
> +
> +		/* enable CQIE.TEPS interrupt only for non-poll queues */
> +		if (i < hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL])
> +			writel(1, mcq_rop_base(hba, ROP_CQIS, i) + REG_CQIE);
> +
> +		/* cqen|size */
> +		ufsmcq_writel(hba, (1 << 31) | qsize, MCQ_CFG_n(REG_CQATTR, i));
> +
> +		/* sqen|size|cqid */
> +		ufsmcq_writel(hba, (1 << 31) | qsize | (i << 16),
> +			      MCQ_CFG_n(REG_SQATTR, i));

If you are writing to the same memory region, like in this case "mcq_base",
then you should be able to use _relaxed variants as the writes to the same
device memory are guaranteed to be in-order.

This also removes the overhead associated with __iowmb included in writel.

Please audit this change throught the driver and use _relaxed variants where
applicable.

> +	}
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_make_queues_operational);
> +
> +static void ufshcd_mcq_release_resource(struct ufs_hba *hba)
> +{
> +	struct ufshcd_res_info_t *res;
> +	int i;
> +
> +	for (i = RES_MCQ; i < RES_MAX; i++) {
> +		res = &hba->res[i];
> +
> +		if (res->base) {
> +			devm_iounmap(hba->dev, res->base);
> +			res->base = NULL;
> +		}
> +
> +		if (res->is_alloc)
> +			devm_kfree(hba->dev, res->resource);

I see that this function is called only in error path. Is there any reason to
free the managed allocation explicitly?

> +	}
> +}
> +
> +static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
> +{
> +	struct platform_device *pdev = to_platform_device(hba->dev);
> +	struct ufshcd_res_info_t *res;
> +	struct resource *res_mem, *res_mcq;
> +	int i, ret = 0;
> +
> +	memcpy(hba->res, ufshcd_res_info, sizeof(ufshcd_res_info));
> +
> +	for (i = 0; i < RES_MAX; i++) {
> +		res = &hba->res[i];
> +
> +		res->resource = platform_get_resource_byname(pdev,
> +							     IORESOURCE_MEM,
> +							     res->name);

If you have the platform_get_resource_byname() out of the for-loop just to get
the "ufs_mem" resource alone, then you can simplify this for-loop with rest of
the resources.

> +		if (!res->resource) {
> +			dev_err(hba->dev, "Resource %s not provided\n");

You didn't pass resource to dev_err.

> +			if (i == RES_MEM)
> +				return -ENOMEM;
> +			continue;
> +		} else if (i == RES_MEM) {
> +			res_mem = res->resource;
> +			res->base = hba->mmio_base;
> +			continue;
> +		}
> +
> +		res->base = devm_ioremap_resource(hba->dev, res->resource);
> +		if (IS_ERR(res->base)) {
> +			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
> +					 res->name, PTR_ERR(res->base));
> +			res->base = NULL;
> +			ret = PTR_ERR(res->base);
> +			goto out_err;
> +		}
> +	}
> +
> +	res = &hba->res[RES_MCQ];
> +	/* MCQ resource provided */

MCQ resource provided by the platform

> +	if (res->base)
> +		goto out;
> +
> +	/* Manually allocate MCQ resource */
> +	res_mcq = res->resource;
> +	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
> +	if (!res_mcq) {
> +		dev_err(hba->dev, "Failed to alloate MCQ resource\n");
> +		goto out_err;
> +	}
> +	res->is_alloc = true;
> +
> +	res_mcq->start = res_mem->start +
> +			 mcq_sqattr_offset(hba->mcq_capabilities);
> +	res_mcq->end = res_mcq->start + hba->nr_hw_queues * MCQ_QCFG_SIZE - 1;
> +	res_mcq->flags = res_mem->flags;
> +	res_mcq->name = "mcq";
> +
> +	ret = insert_resource(&iomem_resource, res_mcq);
> +	if (ret) {
> +		dev_err(hba->dev, "Failed to insert MCQ resource %d\n", ret);
> +		goto out_err;
> +	}
> +
> +	res->base = devm_ioremap_resource(hba->dev, res_mcq);
> +	if (IS_ERR(res->base)) {
> +		dev_err(hba->dev, "Map MCQ registers failed, err=%d\n",
> +			PTR_ERR(res->base));
> +		ret = PTR_ERR(res->base);
> +		res->base = NULL;
> +		goto out_err;
> +	}
> +
> +out:
> +	hba->mcq_base = res->base;
> +	return 0;

This looks odd. Move this into the caller.

> +
> +out_err:
> +	ufshcd_mcq_release_resource(hba);
> +	return ret;
> +}
> +

[....]

> +static inline int ufshcd_mcq_get_tag(struct ufs_hba *hba,
> +				     struct ufs_hw_queue *hwq,
> +				     struct cq_entry *cqe)
> +{
> +	dma_addr_t dma_addr;
> +
> +	dma_addr = ((u64)le32_to_cpu(cqe->command_desc_base_addr_hi) << 32) |
> +		   (le32_to_cpu(cqe->command_desc_base_addr_lo) & 0xffffff80);

Define the mask

> +
> +	return (dma_addr - hba->ucdl_dma_addr) /
> +		sizeof_utp_transfer_cmd_desc(hba);
> +}
> +

[...]

> +/**
> + * @sqe_base_addr: submission queue entry base address
> + * @sqe_dma_addr: submission queue dma address
> + * @cqe_base_addr: completion queue base address
> + * @cqe_dma_addr: completion queue dma address
> + * @max_entries: max number of slots in this hardware queue
> + * @id: hardware queue ID
> + * @mcq_sq_hp: base address of submission queue head pointer
> + * @mcq_sq_tp: base address of submission queue tail pointer
> + * @mcq_cq_hp: base address of completion queue head pointer
> + * @mcq_cq_tp: base address of completion queue tail pointer
> + * @sq_lock: lock to protect submission queue head/tail pointer and slot update
> + * @sq_tp_slot: current slot to which SQ tail pointer is pointing
> + * @cq_lock: lock to protect completion queue head/tail pointer and slot update
> + * @cq_tp_slot: current slot to which CQ tail pointer is pointing
> + * @cq_hp_slot: current slot to which CQ head pointer is pointing
> + */
> +struct ufs_hw_queue {
> +	void *sqe_base_addr;

s/sqe_base_addr/sqe_base

> +	dma_addr_t sqe_dma_addr;

s/sqe_dma_addr/sqe_dma

> +	struct cq_entry *cqe_base_addr;

s/cqe_base_addr/cqe_base

> +	dma_addr_t cqe_dma_addr;

s/cqe_dma_addr/cqe_dma

> +	u32 max_entries;
> +	u32 id;
> +
> +	void __iomem *mcq_sq_hp;
> +	void __iomem *mcq_sq_tp;
> +	void __iomem *mcq_cq_hp;
> +	void __iomem *mcq_cq_tp;

Move these pointers to the top of the struct to avoid any holes.

> +
> +	spinlock_t sq_lock;
> +	u32 sq_tp_slot;
> +	spinlock_t cq_lock;
> +	u32 cq_tp_slot;
> +	u32 cq_hp_slot;
> +};
> +

[...]

>  /* Returns true if clocks can be gated. Otherwise false */
>  static inline bool ufshcd_is_clkgating_allowed(struct ufs_hba *hba)
>  {
> @@ -1017,11 +1180,16 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
>  	return hba->caps & UFSHCD_CAP_WB_EN;
>  }
>  
> -#define ufshcd_writel(hba, val, reg)	\
> +#define ufshcd_writel(hba, val, reg)		\

spurious change?

>  	writel((val), (hba)->mmio_base + (reg))
>  #define ufshcd_readl(hba, reg)	\
>  	readl((hba)->mmio_base + (reg))
>  
> +#define ufsmcq_writel(hba, val, reg)	\
> +	writel((val), (hba)->mcq_base + (reg))
> +#define ufsmcq_readl(hba, reg)	\
> +	readl((hba)->mcq_base + (reg))
> +

[...]

> @@ -482,6 +539,26 @@ struct utp_transfer_req_desc {
>  	__le16  prd_table_offset;
>  };
>  
> +struct cq_entry {
> +	/* DW 0-1 */
> +	__le32 command_desc_base_addr_lo;
> +	__le32 command_desc_base_addr_hi;
> +
> +	/* DW 2 */
> +	__le16  response_upiu_length;
> +	__le16  response_upiu_offset;
> +
> +	/* DW 3 */
> +	__le16  prd_table_length;
> +	__le16  prd_table_offset;
> +
> +	/* DW 4 */
> +	__le32 status;
> +
> +	/* DW 5-7 */
> +	u32 reserved[3];
> +};

packed?

I've left reviewing some portions of the code. I'll do a thorough review with
your next version.

Thanks,
Mani

> +
>  /*
>   * UTMRD structure.
>   */
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

-- 
மணிவண்ணன் சதாசிவம்
