Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74A58C4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiHHIY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiHHIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F83913E38;
        Mon,  8 Aug 2022 01:24:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7B7560E05;
        Mon,  8 Aug 2022 08:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018EEC433D6;
        Mon,  8 Aug 2022 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659947063;
        bh=x60M8uF14PhoixZLHlj8iLaLgvduiiv6ReJSkA5FsZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlH//IkhzebBB3LrGC2aUNC5la0lerZR7hfof5hAKO+c9V8TQg5frGcGKMLTas4qy
         8NZgIu2tupPNWUEzhX/8ZXfChyFDrBjB4G7nbvM3uRmAqUKWRmn6ivlfFopE2XoxVI
         vkBvUdYXyEgnKu8H1oU8XeewL8g1jPP5cCo2CPdd/BzImHxSUQnvcVt59L9WLl6sIb
         KmZjlaQMuTVIBqTm8Hq7ldBXXC8FN5+VPFgvr/Z29BhoLtYGnOQOM62+VOkZhV2tte
         RV/ZO6rRkWWERA+p2jtGWxHBnpzNIHbrIXuKoTUfnxH/nhajVaVZYW4hPm299F93b4
         goC9eilB/CKkw==
Date:   Mon, 8 Aug 2022 10:24:15 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        robert.moore@intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH V2 1/2] ACPI / scan: Support multiple dma windows with
 different offsets
Message-ID: <YvDIL1/ZEpqUNAxP@lpieralisi>
References: <1659684674-40612-1-git-send-email-lvjianmin@loongson.cn>
 <1659684674-40612-2-git-send-email-lvjianmin@loongson.cn>
 <c43edf84-c93d-e695-e3db-4592cdc8a3d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43edf84-c93d-e695-e3db-4592cdc8a3d1@arm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 01:46:07PM +0100, Robin Murphy wrote:

[...]

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
> 
> We already have the number of resources in ret.
> 
> Looking at this, I also now wonder if we're doing the right thing if the
> object is present but contains no resources. The spec isn't clear whether
> that's even really valid, but if it is, is it meaningful? It seems we'd
> currently consider an empty object equivalent to no object, but if anything
> it should perhaps be interpreted as the opposite, i.e. that no DMA is
> possible because the bus does not decode any ranges. Is anyone more familiar
> with the intent of the spec here?

It is unclear. I agree with you (ie that an empty object implies that
no DMA is possible) but I believe this requires a spec update to avoid
any forthcoming issue; it should not be a real problem (other than
a FW bug) but it is better to be on the safe side.

Thanks,
Lorenzo

> Thanks,
> Robin.
> 
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
> > @@ -1639,20 +1640,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >   			  const u32 *input_id)
> >   {
> >   	const struct iommu_ops *iommu;
> > -	u64 dma_addr = 0, size = 0;
> >   	if (attr == DEV_DMA_NOT_SUPPORTED) {
> >   		set_dma_ops(dev, &dma_dummy_ops);
> >   		return 0;
> >   	}
> > -	acpi_arch_dma_setup(dev, &dma_addr, &size);
> > +	acpi_arch_dma_setup(dev);
> >   	iommu = acpi_iommu_configure_id(dev, input_id);
> >   	if (PTR_ERR(iommu) == -EPROBE_DEFER)
> >   		return -EPROBE_DEFER;
> > -	arch_setup_dma_ops(dev, dma_addr, size,
> > +	arch_setup_dma_ops(dev, 0, U64_MAX,
> >   				iommu, attr == DEV_DMA_COHERENT);
> >   	return 0;
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
> > index 44975c1..34e0545 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -280,12 +280,12 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
> >   #ifdef CONFIG_ARM64
> >   void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
> > -void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
> > +void acpi_arch_dma_setup(struct device *dev);
> >   #else
> >   static inline void
> >   acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
> >   static inline void
> > -acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
> > +acpi_arch_dma_setup(struct device *dev) { }
> >   #endif
> >   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
> > @@ -974,8 +974,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
> >   	return DEV_DMA_NOT_SUPPORTED;
> >   }
> > -static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
> > -				     u64 *offset, u64 *size)
> > +static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
> >   {
> >   	return -ENODEV;
> >   }
