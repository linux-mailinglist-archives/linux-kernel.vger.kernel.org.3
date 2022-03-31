Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9C4ED3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiCaG1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiCaG1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:27:13 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0828A1ED070;
        Wed, 30 Mar 2022 23:25:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 45FA080FA;
        Thu, 31 Mar 2022 06:23:13 +0000 (UTC)
Date:   Thu, 31 Mar 2022 09:25:20 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH v4 8/9] iommu: Remove unused argument in
 is_attach_deferred
Message-ID: <YkVJUBK5uHl7ELdv@atomide.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-9-baolu.lu@linux.intel.com>
 <YkRiawC2T9g+CHSJ@atomide.com>
 <20220330142340.GA2111031@nvidia.com>
 <YkSRKZcJO0q3v5WL@atomide.com>
 <20220330173323.GA2120790@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330173323.GA2120790@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Jason Gunthorpe <jgg@nvidia.com> [220330 17:31]:
> On Wed, Mar 30, 2022 at 08:19:37PM +0300, Tony Lindgren wrote:
> 
> > > > __iommu_probe_device from probe_iommu_group+0x2c/0x38
> > > > probe_iommu_group from bus_for_each_dev+0x74/0xbc
> > > > bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
> > > > bus_iommu_probe from bus_set_iommu+0x80/0xc8
> > > > bus_set_iommu from omap_iommu_init+0x88/0xcc
> > > > omap_iommu_init from do_one_initcall+0x44/0x24c
> > > > 
> > > > Any ideas for a fix?
> > > > 
> > > > It would be good to fix this quickly so we don't end up with a broken
> > > > v5.18-rc1..
> > > > 
> > > > For reference, this is mainline commit 41bb23e70b50 ("iommu: Remove unused
> > > > argument in is_attach_deferred").
> > > 
> > > Are you confident in the bisection? I don't see how that commit could
> > > NULL deref..
> > 
> > Oops sorry you're right, the breaking commit is a different patch, it's
> > 3f6634d997db ("iommu: Use right way to retrieve iommu_ops") instead. I must
> > have picked the wrong commit while testing.
> 
> That makes alot more sense
>  
> > > Can you find the code that is the NULL deref?
> > 
> > I can debug a bit more tomorrow.
> 
> Looks like omap's omap_iommu_probe_device() is buggy, it returns 0 on
> error paths:
> 
> 	num_iommus = of_property_count_elems_of_size(dev->of_node, "iommus",
> 						     sizeof(phandle));
> 	if (num_iommus < 0)
> 		return 0;
> 
> This function needs to return an errno -ENODEV
> 
> Otherwise it causes a NULL dev->iommu->iommu_dev and dev_iommu_ops() will
> crash.

You got it. This fixes the issue for me. Looks like the regression already
happened earlier and recent changes just expose it.

For reference, fix posted at:

https://lore.kernel.org/linux-iommu/20220331062301.24269-1-tony@atomide.com/T/#u

Regards,

Tony
