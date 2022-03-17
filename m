Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B354D4DC0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiCQILE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiCQILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:11:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1992DD2;
        Thu, 17 Mar 2022 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647504587; x=1679040587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i5uAxe0PmqtwfYW1OGC8/aQYpXunMY6vhmtGfo43Uek=;
  b=T2cnt2cxhMJB1+71/KOmiSZvc9YdCHVP1VLQrz6FgTLvtaP+uWsUVzIx
   O0il4Xl1hL5FKeASOMDLFaCfPMqZ3Zs3+bOVCgQbvyUO4N1QLCt2jJWux
   A7rzguSfj4zrMrRapJWibiey37BhExSVgA2xCfB5EmG2ECXs92evpwl3c
   D3DoWHQJDMIRpS94VFbQ2n4ag32ayvW43bC9QmOb0jsR/ykhUx2L5vy6J
   5YOwfiz7xD5hJhjMEtdZ1v5bxpGeWO4aEq4r3j5DOk529Pmj4DbuzH3fx
   ZI+7Ec47+Pylz3XI1Pb4vi6LD8/1QR2gFznYxrIsfCYECI5xP1mHtC7Y4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244265647"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="244265647"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516675048"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:09:42 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Mar 2022 10:08:30 +0200
Date:   Thu, 17 Mar 2022 10:08:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjLsfhUmhjOiy6G8@lahna>
References: <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna>
 <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Mar 16, 2022 at 07:17:57PM +0000, Robin Murphy wrote:
> The feeling I'm getting from all this is that if we've got as far as
> iommu_dma_protection_show() then it's really too late to meaningfully
> mitigate bad firmware.

Note, these are requirements from Microsoft in order for the system to
use the "Kernel DMA protection". Because of this, likelyhood of "bad
firmware" should be quite low since these systems ship with Windows
installed so they should get at least some soft of validation that this
actually works.

> We should be able to detect missing
> untrusted/external-facing properties as early as nhi_probe(), and if we
> could go into "continue at your own risk" mode right then *before* anything
> else happens, it all becomes a lot easier to reason about.

I think what we want is that the DMAR opt-in bit is set in the ACPI
tables and that we know the full IOMMU translation is happening for the
devices behind "external facing ports". If that's not the case the
iommu_dma_protection_show() should return 0 meaning the userspace can
ask the user whether the connected device is allowed to use DMA (e.g
PCIe is tunneled or not).

We do check for the DMAR bit in the Intel IOMMU code and we also do
check that there actually are PCIe ports marked external facing but we
could issue warning there if that's not the case. Similarly if the user
explicitly disabled the IOMMU translation. This can be done inside a new
IOMMU API that does something like the below pseudo-code:

#if IOMMU_ENABLED
bool iommu_dma_protected(struct device *dev)
{
	if (dmar_platform_optin() /* or the AMD equivalent */) {
		if (!iommu_present(...)) /* whatever is needed to check that the full translation is enabled */
			dev_warn(dev, "IOMMU protection disabled!");
		/*
		 * Look for the external facing ports. Should be at
		 * least 1 or issue warning.
		 */
		 ...

		return true;
	}

	return false;
}
#else
static inline bool iommu_dma_protected(struct device *dev)
{
	return false;
}
#endif

Then we can make iommu_dma_protection_show() to call this function.
