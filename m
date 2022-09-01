Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8DF5A9541
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiIALAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIALAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:00:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A0FE0F3;
        Thu,  1 Sep 2022 04:00:07 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJJ2p1dnFz688J4;
        Thu,  1 Sep 2022 18:59:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 13:00:04 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 12:00:04 +0100
Date:   Thu, 1 Sep 2022 12:00:03 +0100
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
Message-ID: <20220901120003.000024ce@huawei.com>
In-Reply-To: <YxBhZdYz606i+pAN@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
        <20220831081603.3415-12-rrichter@amd.com>
        <20220831125656.00007beb@huawei.com>
        <YxBhZdYz606i+pAN@rric.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Thu, 1 Sep 2022 09:38:13 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 31.08.22 12:56:56, Jonathan Cameron wrote:
> > On Wed, 31 Aug 2022 10:15:59 +0200
> > Robert Richter <rrichter@amd.com> wrote:  
> 
> > A few comments inline.  Mostly requests for references for things
> > I couldn't find in the specs.  
> 
> Most of it comes from the pci base spec (5 or 6).

Ok. Extra references appreciated - these specs are huge, so saving
searching time always good!

> 
> > 
> >   
> > > +	 *
> > > +	 * Also, RCRB accesses must use MMIO readl()/readq() to guarantee
> > > +	 * 32/64-bit access.
> > > +	 * CXL 8.2.2 - CXL 1.1 Upstream and Downstream Port Subsystem Component
> > > +	 * Registers
> > > +	 */
> > > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> > > +	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
> > > +	bar1 = readl(addr + PCI_BASE_ADDRESS_1);  
> > 
> > The spec is a bit confusing on this, but I think you are reading into
> > MEMBAR0 of the RCRB, for which there isn't a lot of description other than
> > it being an address. It's referred to as a 64-bit BAR in places so you
> > might be right - or it might be intended to be a bare address..
> > 
> > We might want a clarification on this...
> > 
> > Also it's a 64 bit address so we need to read it in one go. However it's
> > referred to as a being a 64 bit address at 0x10 and 0x14 so who knows...  
> 
> This is part of the pci base spec and clearly defined there. There are
> also some similar implementation in the kernel already.

There isn't a cross reference from CXL spec and PCI doesn't use
the term membar.

I guess it is fairly obvious though that it's an abbreviation
of Base Address Register for Memory.  I might raise the wish to tidy that
up for a future spec revision.


> 
> > 
> >   
> > > +	iounmap(addr);
> > > +
> > > +	/* sanity check */
> > > +	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
> > > +		return CXL_RESOURCE_NONE;
> > > +
> > > +	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
> > > +	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > > +		component_reg_phys |= ((u64)bar1) << 32;
> > > +
> > > +	if (!component_reg_phys)
> > > +		return CXL_RESOURCE_NONE;
> > > +
> > > +	/*
> > > +	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
> > > +	 * Upstream Port RCRBs).  
> > 
> > The rcrb is 8k though I'm not immediately spotting an alignment requirement,
> > but I'm not sure the component regs have any restrictions do... Add a reference perhaps?
> > For non RCD devices there is a 64K alignment requirement, but I can't find
> > anything for RCDs (might just be missing it).  
> 
> This are the requirements of the pci base spec to membar ranges. The
> range size is power of 2 and base must be aligned to its size.

Ok.  It feels convoluted to rely on the CXL glossary entry for BAR
to cover MEMBAR0 and hence inherit the restrictions of a PCIe bar.

Maybe just add a comment here so that anyone who hits this can understand
the source of the restriction seeing as it isn't in the CXL spec and this
isn't a PCI BAR.

> 
> >   
> > > +	 */
> > > +	if (component_reg_phys & (SZ_8K - 1))
> > > +		return CXL_RESOURCE_NONE;
> > > +
> > > +	return component_reg_phys;
> > > +}
> > > +



> >   
> > > +	if (!base) {
> > > +		dev_err(parent, "failed to map registers\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	cxl_probe_component_regs(parent, base, &comp_map);
> > > +	iounmap(base);
> > > +
> > > +	if (!comp_map.hdm_decoder.valid) {
> > > +		dev_err(parent, "HDM decoder registers not found\n");
> > > +		return -ENXIO;  
> > 
> > Hmm. HDM decoder capability is optional for RCDs - might be using the
> > range registers.  Seems like we'd really want to handle that for
> > RCDs.  Future work I guess.  
> 
> I used the same message as for the non-RCD code path. HDM decoding is
> just a subset of features handled with component regs. We need to
> generalize the code for this in the future.

Sure - much more likely to need that generalized code for an RCD.
IIRC a CXL 2.0 device must implement HDM decoders, even though the
other path can be used by software that doesn't understand CXL 2.0.
Our RCD might be because the device is CXL 1.1...



> 
> >   
> > > +		if (rc)
> > > +			goto fail;  
> >   
> > > +
> > >  		dev_info(&host->dev, "host supports CXL\n");
> > >  	}
> > >  
> > >  	return 0;
> > > +fail:  
> > 
> > Better to have a more specific error message and return directly above.
> > Note that so far vast majority of CXL error messages are dev_dbg,
> > so for consistency perhaps this should be as well.
> > (I prefer dev_err() but not my subsystem ;)  
> 
> There is more verbosity on the errors with dbg enabled. Note there are
> only a few dev_info/dev_err messages to not polute the logs. dev_err()
> is only used if something unexpected happens (e.g. the device exists
> but component regs are broken).
> 
Ok. I'll leave the question of balance between the two for CXL maintainers
to comment on if they wish.

Thanks,

Jonathan

