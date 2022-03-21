Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD04E24C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbiCULAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346529AbiCULAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:00:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010033E9C;
        Mon, 21 Mar 2022 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647860324; x=1679396324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6RtiG0C2v7b3JHoXbKF81Ytg+qc2VwLCD93SLy7ttLA=;
  b=X06SdEPQ3PbBdTSPLDzDPK5q8eRrwuy0AOsLlAQkZRpr4SqBKSFmfFCo
   wngRn88y9NGpg67+U7enGhh7s8QvsMEBtx27AV56Xr9DHU+xymsRnsB3f
   +KbSfDTC4d5qW6nqn9kN2dCuduIOo8o9Ug4iuMClUfDKQjYVBoJT8Pr+a
   i9y0nJ40JvptBGqs751+twasiom3/PF8gWh6AXHy79hKaSIeVqoxA36ya
   Uuf5QmCh5J86Qj2src5vRhfXjP9jqTyzIEX7rGKvFcwZXSFjKwuEC7ZdO
   RooFcWHq+Xcz8ozg8qVZxmzrlvvvfOCkwFPZsDuQQxCfzpE9RBTpmfjwX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257471392"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257471392"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:58:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="551675891"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:58:32 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Mar 2022 12:58:30 +0200
Date:   Mon, 21 Mar 2022 12:58:30 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Message-ID: <YjhaViFzmEjBgmmu@lahna>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
 <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Fri, Mar 18, 2022 at 10:29:59PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > Between me trying to get rid of iommu_present() and Mario wanting to
> > support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
> > shown
> > that the iommu_dma_protection attribute is being far too optimistic.
> > Even if an IOMMU might be present for some PCI segment in the system,
> > that doesn't necessarily mean it provides translation for the device(s)
> > we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> > is tell us that memory was protected before the kernel was loaded, and
> > prevent the user from disabling the intel-iommu driver entirely. While
> > that lets us assume kernel integrity, what matters for actual runtime
> > DMA protection is whether we trust individual devices, based on the
> > "external facing" property that we expect firmware to describe for
> > Thunderbolt ports.
> > 
> > It's proven challenging to determine the appropriate ports accurately
> > given the variety of possible topologies, so while still not getting a
> > perfect answer, by putting enough faith in firmware we can at least get
> > a good bit closer. If we can see that any device near a Thunderbolt NHI
> > has all the requisites for Kernel DMA Protection, chances are that it
> > *is* a relevant port, but moreover that implies that firmware is playing
> > the game overall, so we'll use that to assume that all Thunderbolt ports
> > should be correctly marked and thus will end up fully protected.
> > 
> 
> This approach looks generally good to me.  I do worry a little bit about older
> systems that didn't set ExternalFacingPort in the FW but were previously setting
> iommu_dma_protection, but I think that those could be treated on a quirk
> basis to set PCI IDs for those root ports as external facing if/when they come
> up.

There are no such systems out there AFAICT.

> I'll send up a follow up patch that adds the AMD ACPI table check.
> If it looks good can roll it into your series for v3, or if this series goes
> as is for v2 it can come on its own.
> 
> > CC: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > v2: Give up trying to look for specific devices, just look for evidence
> >     that firmware cares at all.
> 
> I still do think you could know exactly which devices to use if you're in
> SW CM mode, but I guess the consensus is to not bifurcate the way this
> can be checked.

Indeed.

The patch looks good to me now. I will give it a try on a couple of
systems later today or tomorrow and let you guys know how it went. I
don't expect any problems but let's see.

Thanks a lot Robin for working on this :)
