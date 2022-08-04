Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2E589A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbiHDJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbiHDJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:59:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 906D06612B;
        Thu,  4 Aug 2022 02:59:30 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxsM57mOtiIqQFAA--.21101S3;
        Thu, 04 Aug 2022 17:59:23 +0800 (CST)
Subject: Re: [PATCH] ACPI / scan: Support multiple dma windows with different
 offsets
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1659255431-22796-1-git-send-email-lvjianmin@loongson.cn>
Message-ID: <e12706ef-70de-08b6-ada0-818d03b8c2f5@loongson.cn>
Date:   Thu, 4 Aug 2022 17:59:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1659255431-22796-1-git-send-email-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxsM57mOtiIqQFAA--.21101S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWUXFW3trWUJr4UGrW5Awb_yoW7KF4rp3
        WkKFy3Gr47tr4DWr4kZr4ru3W5Z3s8uw4xurW8G3sak3sFgr1DJF4DC34j9a4fAFyqkr4x
        ZF4qgFyrCa1jqF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
        W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK6svPMxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x07beAp5UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

Can anybody help to review the patch, or I missed somebody else?

Thanks!

On 2022/7/31 下午4:17, Jianmin Lv wrote:
> For DT, of_dma_get_range returns bus_dma_region typed dma regions,
> which makes multiple dma windows with different offset available
> for translation between dma address and cpu address.
> 
> But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
> causing no path for setting dev->dma_range_map conveniently. So the
> patch changes acpi_dma_get_range and returns bus_dma_region typed
> dma regions according to of_dma_get_range.
> 
> After changing acpi_dma_get_range, original part of internal code
> only available for ARM is moved to acpi_arch_dma_setup for remaining
> unchanged.
> 
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> 
> diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> index f16739a..840f918 100644
> --- a/drivers/acpi/arm64/dma.c
> +++ b/drivers/acpi/arm64/dma.c
> @@ -9,6 +9,7 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   	int ret;
>   	u64 end, mask;
>   	u64 dmaaddr = 0, size = 0, offset = 0;
> +	const struct bus_dma_region *map = NULL;
>   
>   	/*
>   	 * If @dev is expected to be DMA-capable then the bus code that created
> @@ -26,10 +27,37 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   	else
>   		size = 1ULL << 32;
>   
> -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> +	ret = acpi_dma_get_range(dev, &map);
>   	if (ret == -ENODEV)
>   		ret = iort_dma_get_ranges(dev, &size);
>   	if (!ret) {
> +		const struct bus_dma_region *r = map;
> +		u64 len, dma_start, dma_end = 0;
> +
> +		/* determine the overall bounds of all dma regions */
> +		for (dma_start = U64_MAX; r->size; r++) {
> +			if (offset && r->offset != offset) {
> +				dev_warn(dev, "Can't handle multiple windows with different offsets\n");
> +				return;
> +			}
> +			offset = r->offset;
> +
> +			/* Take lower and upper limits */
> +			if (r->dma_start < dma_start)
> +				dma_start = r->dma_start;
> +			if (r->dma_start + r->size - 1 > dma_end)
> +				dma_end = r->dma_start + r->size - 1;
> +		}
> +
> +		if (dma_start >= dma_end) {
> +			dev_dbg(dev, "Invalid DMA regions configuration\n");
> +			return;
> +		}
> +
> +		dmaaddr = dma_start;
> +		len = dma_end - dma_start;
> +		size = max(len, len + 1);
> +
>   		/*
>   		 * Limit coherent and dma mask based on size retrieved from
>   		 * firmware.
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 762b61f..8961b51 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -20,6 +20,7 @@
>   #include <linux/platform_data/x86/apple.h>
>   #include <linux/pgtable.h>
>   #include <linux/crc32.h>
> +#include <linux/dma-direct.h>
>   
>   #include "internal.h"
>   
> @@ -1492,15 +1493,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>    *
>    * Return 0 on success, < 0 on failure.
>    */
> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size)
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   {
>   	struct acpi_device *adev;
>   	LIST_HEAD(list);
>   	struct resource_entry *rentry;
>   	int ret;
>   	struct device *dma_dev = dev;
> -	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> +	int num_ranges = 0;
> +	struct bus_dma_region *r;
>   
>   	/*
>   	 * Walk the device tree chasing an ACPI companion with a _DMA
> @@ -1525,31 +1526,31 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
>   
>   	ret = acpi_dev_get_dma_resources(adev, &list);
>   	if (ret > 0) {
> +		list_for_each_entry(rentry, &list, node)
> +			num_ranges++;
> +
> +		r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
> +		if (!r) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		*map = r;
> +
>   		list_for_each_entry(rentry, &list, node) {
> -			if (dma_offset && rentry->offset != dma_offset) {
> +			if (rentry->res->start >= rentry->res->end) {
>   				ret = -EINVAL;
> -				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
> +				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
>   				goto out;
>   			}
> -			dma_offset = rentry->offset;
> -
> -			/* Take lower and upper limits */
> -			if (rentry->res->start < dma_start)
> -				dma_start = rentry->res->start;
> -			if (rentry->res->end > dma_end)
> -				dma_end = rentry->res->end;
> -		}
>   
> -		if (dma_start >= dma_end) {
> -			ret = -EINVAL;
> -			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> -			goto out;
> +			r->cpu_start = rentry->res->start;
> +			r->dma_start = rentry->res->start - rentry->offset;
> +			r->size = rentry->res->end - rentry->res->start + 1;
> +			r->offset = rentry->offset;
> +			r++;
>   		}
>   
> -		*dma_addr = dma_start - dma_offset;
> -		len = dma_end - dma_start;
> -		*size = max(len, len + 1);
> -		*offset = dma_offset;
>   	}
>    out:
>   	acpi_dev_free_resource_list(&list);
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 0dc1ea0b..e106073 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -611,8 +611,7 @@ struct acpi_pci_root {
>   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
>   			   struct fwnode_handle *fwnode,
>   			   const struct iommu_ops *ops);
> -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> -		       u64 *size);
> +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   			   const u32 *input_id);
>   static inline int acpi_dma_configure(struct device *dev,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 44975c1..f806092 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>   	return DEV_DMA_NOT_SUPPORTED;
>   }
>   
> -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
> -				     u64 *offset, u64 *size)
> +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   {
>   	return -ENODEV;
>   }
> 

