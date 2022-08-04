Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496AA589C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiHDN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiHDN1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:27:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3115FD3;
        Thu,  4 Aug 2022 06:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20054B82431;
        Thu,  4 Aug 2022 13:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49571C433D6;
        Thu,  4 Aug 2022 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659619637;
        bh=ocujRJqNu6S8wBn4i4Rts7b5BhfeYX8ix7T9K2YDATw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhj9sYzz+Xzc/YOS/8Vu1tdGJjoSj6SLANF2Q274PJUxueDe15uQWXG7rAeWXGsnL
         a6u6WO9d+oAT6pIoOPTWIXyKBsmAgtDYp6TnkfD2YkjJAKcbOhfan5YEwWJvvE9fRX
         0IGn6e+en/IGfdo0omoSMCcksC3qVrCEBRlZT627H6qCZQyxBZoJxq36CG/5jq74T9
         3aIOH5HpmvZf/j/DEWxw6T9cMLefhJlYYSSvOUMrNLh2gqflEAvKxa6Vv+beJ/B4Qn
         SyHX2cP2ufArEDe5R29IZfOAsK2afggIseoTDywyG3BgnTKSkMwbxDGrXDaityTAAe
         +bTFUQhK17KPw==
Date:   Thu, 4 Aug 2022 15:27:11 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH] ACPI / scan: Support multiple dma windows with different
 offsets
Message-ID: <YuvJLxa5zsMj1pGf@lpieralisi>
References: <1659255431-22796-1-git-send-email-lvjianmin@loongson.cn>
 <e12706ef-70de-08b6-ada0-818d03b8c2f5@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e12706ef-70de-08b6-ada0-818d03b8c2f5@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Robin]

On Thu, Aug 04, 2022 at 05:59:23PM +0800, Jianmin Lv wrote:
> Hi, all
> 
> Can anybody help to review the patch, or I missed somebody else?

I will review the patch - added Robin since it affects the DMA
ranges handling.

Lorenzo

> Thanks!
> 
> On 2022/7/31 下午4:17, Jianmin Lv wrote:
> > For DT, of_dma_get_range returns bus_dma_region typed dma regions,
> > which makes multiple dma windows with different offset available
> > for translation between dma address and cpu address.
> > 
> > But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
> > causing no path for setting dev->dma_range_map conveniently. So the
> > patch changes acpi_dma_get_range and returns bus_dma_region typed
> > dma regions according to of_dma_get_range.
> > 
> > After changing acpi_dma_get_range, original part of internal code
> > only available for ARM is moved to acpi_arch_dma_setup for remaining
> > unchanged.
> > 
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > 
> > diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
> > index f16739a..840f918 100644
> > --- a/drivers/acpi/arm64/dma.c
> > +++ b/drivers/acpi/arm64/dma.c
> > @@ -9,6 +9,7 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >   	int ret;
> >   	u64 end, mask;
> >   	u64 dmaaddr = 0, size = 0, offset = 0;
> > +	const struct bus_dma_region *map = NULL;
> >   	/*
> >   	 * If @dev is expected to be DMA-capable then the bus code that created
> > @@ -26,10 +27,37 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >   	else
> >   		size = 1ULL << 32;
> > -	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> > +	ret = acpi_dma_get_range(dev, &map);
> >   	if (ret == -ENODEV)
> >   		ret = iort_dma_get_ranges(dev, &size);
> >   	if (!ret) {
> > +		const struct bus_dma_region *r = map;
> > +		u64 len, dma_start, dma_end = 0;
> > +
> > +		/* determine the overall bounds of all dma regions */
> > +		for (dma_start = U64_MAX; r->size; r++) {
> > +			if (offset && r->offset != offset) {
> > +				dev_warn(dev, "Can't handle multiple windows with different offsets\n");
> > +				return;
> > +			}
> > +			offset = r->offset;
> > +
> > +			/* Take lower and upper limits */
> > +			if (r->dma_start < dma_start)
> > +				dma_start = r->dma_start;
> > +			if (r->dma_start + r->size - 1 > dma_end)
> > +				dma_end = r->dma_start + r->size - 1;
> > +		}
> > +
> > +		if (dma_start >= dma_end) {
> > +			dev_dbg(dev, "Invalid DMA regions configuration\n");
> > +			return;
> > +		}
> > +
> > +		dmaaddr = dma_start;
> > +		len = dma_end - dma_start;
> > +		size = max(len, len + 1);
> > +
> >   		/*
> >   		 * Limit coherent and dma mask based on size retrieved from
> >   		 * firmware.
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 762b61f..8961b51 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/platform_data/x86/apple.h>
> >   #include <linux/pgtable.h>
> >   #include <linux/crc32.h>
> > +#include <linux/dma-direct.h>
> >   #include "internal.h"
> > @@ -1492,15 +1493,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
> >    *
> >    * Return 0 on success, < 0 on failure.
> >    */
> > -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> > -		       u64 *size)
> > +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >   {
> >   	struct acpi_device *adev;
> >   	LIST_HEAD(list);
> >   	struct resource_entry *rentry;
> >   	int ret;
> >   	struct device *dma_dev = dev;
> > -	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
> > +	int num_ranges = 0;
> > +	struct bus_dma_region *r;
> >   	/*
> >   	 * Walk the device tree chasing an ACPI companion with a _DMA
> > @@ -1525,31 +1526,31 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> >   	ret = acpi_dev_get_dma_resources(adev, &list);
> >   	if (ret > 0) {
> > +		list_for_each_entry(rentry, &list, node)
> > +			num_ranges++;
> > +
> > +		r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
> > +		if (!r) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		*map = r;
> > +
> >   		list_for_each_entry(rentry, &list, node) {
> > -			if (dma_offset && rentry->offset != dma_offset) {
> > +			if (rentry->res->start >= rentry->res->end) {
> >   				ret = -EINVAL;
> > -				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
> > +				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> >   				goto out;
> >   			}
> > -			dma_offset = rentry->offset;
> > -
> > -			/* Take lower and upper limits */
> > -			if (rentry->res->start < dma_start)
> > -				dma_start = rentry->res->start;
> > -			if (rentry->res->end > dma_end)
> > -				dma_end = rentry->res->end;
> > -		}
> > -		if (dma_start >= dma_end) {
> > -			ret = -EINVAL;
> > -			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
> > -			goto out;
> > +			r->cpu_start = rentry->res->start;
> > +			r->dma_start = rentry->res->start - rentry->offset;
> > +			r->size = rentry->res->end - rentry->res->start + 1;
> > +			r->offset = rentry->offset;
> > +			r++;
> >   		}
> > -		*dma_addr = dma_start - dma_offset;
> > -		len = dma_end - dma_start;
> > -		*size = max(len, len + 1);
> > -		*offset = dma_offset;
> >   	}
> >    out:
> >   	acpi_dev_free_resource_list(&list);
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 0dc1ea0b..e106073 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -611,8 +611,7 @@ struct acpi_pci_root {
> >   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> >   			   struct fwnode_handle *fwnode,
> >   			   const struct iommu_ops *ops);
> > -int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
> > -		       u64 *size);
> > +int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
> >   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >   			   const u32 *input_id);
> >   static inline int acpi_dma_configure(struct device *dev,
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 44975c1..f806092 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
> >   	return DEV_DMA_NOT_SUPPORTED;
> >   }
> > -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
> > -				     u64 *offset, u64 *size)
> > +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >   {
> >   	return -ENODEV;
> >   }
> > 
> 
