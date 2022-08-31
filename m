Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9815A7CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiHaL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHaL5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:57:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76005D25E5;
        Wed, 31 Aug 2022 04:57:00 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHjLw2xxvz687hH;
        Wed, 31 Aug 2022 19:56:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 13:56:58 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 12:56:57 +0100
Date:   Wed, 31 Aug 2022 12:56:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH 11/15] cxl/acpi: Extract the host's component register
 base address from RCRB
Message-ID: <20220831125656.00007beb@huawei.com>
In-Reply-To: <20220831081603.3415-12-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-12-rrichter@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Wed, 31 Aug 2022 10:15:59 +0200
Robert Richter <rrichter@amd.com> wrote:

> A downstream port must be connected to a component register block.
> Determine its base address from the RCRB.
> 
> The implementation is analog to how cxl_setup_regs() is implemented
> for CXL VH mode. A struct cxl_component_reg_map is filled in, mapped
> and probed.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
A few comments inline.  Mostly requests for references for things
I couldn't find in the specs.

> ---
>  drivers/cxl/acpi.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 439df9df2741..88bbd2bb61fc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -401,12 +401,84 @@ static resource_size_t cxl_get_rcrb(u32 uid)
>  	return ctx.chbcr;
>  }
>  
> +static resource_size_t cxl_get_component_reg_phys(resource_size_t rcrb)
> +{
> +	resource_size_t component_reg_phys;
> +	u32 bar0, bar1;
> +	void *addr;
> +
> +	/*
> +	 * RCRB's BAR[0..1] point to component block containing CXL subsystem
> +	 * component registers.
> +	 * CXL 8.2.4 - Component Register Layout Definition.

For references include spec version.  Based on discussion other day,
preference is always latest version. So r3.0 8.2.3
is probably right. I think your references are CXL r2.0?


> +	 *
> +	 * Also, RCRB accesses must use MMIO readl()/readq() to guarantee
> +	 * 32/64-bit access.
> +	 * CXL 8.2.2 - CXL 1.1 Upstream and Downstream Port Subsystem Component
> +	 * Registers
> +	 */
> +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);

The spec is a bit confusing on this, but I think you are reading into
MEMBAR0 of the RCRB, for which there isn't a lot of description other than
it being an address. It's referred to as a 64-bit BAR in places so you
might be right - or it might be intended to be a bare address..

We might want a clarification on this...

Also it's a 64 bit address so we need to read it in one go. However it's
referred to as a being a 64 bit address at 0x10 and 0x14 so who knows...


> +	iounmap(addr);
> +
> +	/* sanity check */
> +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> +		return CXL_RESOURCE_NONE;
> +
> +	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
> +	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
> +		component_reg_phys |= ((u64)bar1) << 32;
> +
> +	if (!component_reg_phys)
> +		return CXL_RESOURCE_NONE;
> +
> +	/*
> +	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
> +	 * Upstream Port RCRBs).

The rcrb is 8k though I'm not immediately spotting an alignment requirement,
but I'm not sure the component regs have any restrictions do... Add a reference perhaps?
For non RCD devices there is a 64K alignment requirement, but I can't find
anything for RCDs (might just be missing it).

> +	 */
> +	if (component_reg_phys & (SZ_8K - 1))
> +		return CXL_RESOURCE_NONE;
> +
> +	return component_reg_phys;
> +}
> +
> +static int cxl_setup_component_reg(struct device *parent,
> +				   resource_size_t component_reg_phys)
> +{
> +	struct cxl_component_reg_map comp_map;
> +	void __iomem *base;
> +
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -EINVAL;
> +
> +	base = ioremap(component_reg_phys, SZ_64K);

Add a spec reference for the size. Table 8-21 perhaps?

> +	if (!base) {
> +		dev_err(parent, "failed to map registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	cxl_probe_component_regs(parent, base, &comp_map);
> +	iounmap(base);
> +
> +	if (!comp_map.hdm_decoder.valid) {
> +		dev_err(parent, "HDM decoder registers not found\n");
> +		return -ENXIO;

Hmm. HDM decoder capability is optional for RCDs - might be using the
range registers.  Seems like we'd really want to handle that for
RCDs.  Future work I guess.

> +	}
> +
> +	dev_dbg(parent, "Set up component registers\n");
> +
> +	return 0;
> +}
> +
>  static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  {
>  	struct pci_host_bridge *host = NULL;
>  	struct acpi_device *adev;
>  	unsigned long long uid = ~0;
>  	resource_size_t rcrb;
> +	resource_size_t component_reg_phys;
Trivial: As before, if we can reduce scope to inside the while loop, slightly cleaner
and more local.
> +	int rc;
>  
>  	while ((host = cxl_find_next_rch(host)) != NULL) {
>  		adev = ACPI_COMPANION(&host->dev);
> @@ -425,10 +497,18 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
>  
>  		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
>  
> +		component_reg_phys = cxl_get_component_reg_phys(rcrb);
> +		rc = cxl_setup_component_reg(&host->dev, component_reg_phys);

Perhaps rename to make it clear this is getting the DSP component registers.

Future work would be to add support for the CXL 3.0 feature that lets even an
RCD just put some of these registers in a BAR as per CXL 2.0 devices.

> +		if (rc)
> +			goto fail;

> +
>  		dev_info(&host->dev, "host supports CXL\n");
>  	}
>  
>  	return 0;
> +fail:

Better to have a more specific error message and return directly above.
Note that so far vast majority of CXL error messages are dev_dbg,
so for consistency perhaps this should be as well.
(I prefer dev_err() but not my subsystem ;)

> +	dev_err(&host->dev, "failed to initialize CXL host: %d\n", rc);
dev_err_probe() is slightly nicer to use if things can only happen in
probe() paths.

> +	return rc;
>  }
>  
>  static struct lock_class_key cxl_root_key;

