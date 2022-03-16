Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF2A4DB757
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357672AbiCPRia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357657AbiCPRi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:38:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692068FB6;
        Wed, 16 Mar 2022 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647452232; x=1678988232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O35iNXQlRH+OS+APj1svNRdnOY4rt7s7kW6OPFwzhnA=;
  b=Xzy1ll8ePcbMN4hVXc0iG+h8pU/7SNcX3nHhfFKgy1NMtjHUefLjonTS
   UjgpcY5/hlN+NuD/TmDtZlhPlt0x/KAnyhOC4r9w1lLJVbikeaRVqpmUE
   IMQJ1w0yYeSgDw3LTHDDQdc9HaIWSMlcuAf1btL5U/syIgHy8biRGO126
   CLw5lLUKdJrXIdKbhV/iXC4i5aLnWoiSod3eAfU+69g/Ri2K7+Q9a8tpP
   4qkynTlZyBdDXtdGW/WXEuA8ckz+28qw7pAFvsVjyBlxbZn9Yo13Esmr7
   ZPHI6d+RzIP1ZXJgXyJe6gwonpO0z7Q+NqsctCS00wH4bTK7PG3sWdnsI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236619157"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="236619157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:37:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="516437363"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:37:08 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 19:37:05 +0200
Date:   Wed, 16 Mar 2022 19:37:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjIgQfmcw6fydkXd@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Wed, Mar 16, 2022 at 05:24:38PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > On Wed, Mar 16, 2022 at 02:49:09PM +0000, Robin Murphy wrote:
> > > > What we want is to make sure the Tunneled PCIe ports get the full
> > IOMMU
> > > > protection. In case of the discrete above it is also fine if all the
> > > > devices behind the PCIe root port get the full IOMMU protection. Note in
> > > > the integrated all the devices are "siblings".
> > >
> > > Ah, OK, I wasn't aware that the NHI isn't even the right thing in the first
> > > place :(
> > >
> > > Is there an easy way to get from the struct tb to a PCI device representing
> > > the end of its relevant tunnel, or do we have a circular dependency
> > problem
> > > where the latter won't appear until we've authorised it (and thus the
> > IOMMU
> > > layer won't know about it yet either)?
> > 
> > The PCIe root ports (and the PCIe downstream ports) are there already
> > even without "authorization".
> > 
> > There is a way to figure out the "tunneled" PCIe ports by looking at
> > certain properties and we do that already actually. The BIOS has the
> > following under these ports:
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
> > .microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-
> > for-pcie-root-ports%23identifying-externally-exposed-pcie-root-
> > ports&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C0465d319a
> > 6684335d9c208da07710e7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > C0%7C637830479402895833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> > p;sdata=z6hpYGpj%2B%2BVvz9d6MXiO4N66PUm4zwhOdI%2Br6l3PjhQ%3D
> > &amp;reserved=0
> > 
> > and the ports will have dev->external_facing set to 1. Perhaps looking
> > at that field helps here?
> 
> External facing isn't a guarantee from the firmware though.  It's something we
> all expect in practice, but I think it's better to look at the ones that are from
> the _DSD usb4-host-interface to be safer.

Right but then we have the discrete ones with the DVSEC that exposes the
tunneled ports :(

> Mika, you might not have seen it yet, but I sent a follow up diff in this thread
> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy to do
> so as well as I confirmed it helps my original intent too).

I saw it now and I'm thinking are we making this unnecessary complex? I
mean Microsoft solely depends on the DMAR platform opt-in flag:

  https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt

We also do turn on full IOMMU mappings in that case for devices that are
marked as external facing by the same firmware that provided the DMAR
bit. If the user decides to disable IOMMU from command line for instance
then we expect she knows what she is doing.
