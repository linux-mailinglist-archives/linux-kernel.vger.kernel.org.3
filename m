Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139DB4DC8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiCQOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCQOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:24:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F71549FA2;
        Thu, 17 Mar 2022 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647527020; x=1679063020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CRwG4aY4JJ4LjAE7lBFW8th+dS3FJs6IUGzKssvwkes=;
  b=b/5rUZ+jPBKWx28C5Avm2VD+DjWyNwXmm4mwWbaznz1vTpasv5cIpAdj
   b5QGVf8n+5OchGnEVtvSaYwdhD0NtN+6Q4nvfQ/Gc5dFaK2S0shfOZ5h4
   3oTFsv5QnUKkNcYw4BIg6MGKao/RDIiJxxWtd06UqxPGWTiHV/43jql4j
   APDF2QeW+uUnX1KWPi+rV6VEl6GFYLOL01WnShUaZtr0RbMQHon5cj/RV
   WeYv0lfHh6xmCBLmc0F98sHEniQxNwbuL/VVihusk0JwdRNjxeLHU4nsH
   d7MYT17P7jlhW07k5AeEnXeNGg8NBjMJyRq18ROFKfkMhdQ3t0ULY9BLK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254434487"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254434487"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:23:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581306413"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:23:36 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Mar 2022 16:21:22 +0200
Date:   Thu, 17 Mar 2022 16:21:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjND4iZaLZbhJhbg@lahna>
References: <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna>
 <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
 <YjLsfhUmhjOiy6G8@lahna>
 <23f232a1-f511-d2fe-b1f8-5fd32b3a1a8f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f232a1-f511-d2fe-b1f8-5fd32b3a1a8f@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Thu, Mar 17, 2022 at 01:42:56PM +0000, Robin Murphy wrote:
> On 2022-03-17 08:08, Mika Westerberg wrote:
> > Hi Robin,
> > 
> > On Wed, Mar 16, 2022 at 07:17:57PM +0000, Robin Murphy wrote:
> > > The feeling I'm getting from all this is that if we've got as far as
> > > iommu_dma_protection_show() then it's really too late to meaningfully
> > > mitigate bad firmware.
> > 
> > Note, these are requirements from Microsoft in order for the system to
> > use the "Kernel DMA protection". Because of this, likelyhood of "bad
> > firmware" should be quite low since these systems ship with Windows
> > installed so they should get at least some soft of validation that this
> > actually works.
> > 
> > > We should be able to detect missing
> > > untrusted/external-facing properties as early as nhi_probe(), and if we
> > > could go into "continue at your own risk" mode right then *before* anything
> > > else happens, it all becomes a lot easier to reason about.
> > 
> > I think what we want is that the DMAR opt-in bit is set in the ACPI
> > tables and that we know the full IOMMU translation is happening for the
> > devices behind "external facing ports". If that's not the case the
> > iommu_dma_protection_show() should return 0 meaning the userspace can
> > ask the user whether the connected device is allowed to use DMA (e.g
> > PCIe is tunneled or not).
> 
> Ah, if it's safe to just say "no protection" in the case that we don't know
> for sure, that's even better. Clearly I hadn't quite grasped that aspect of
> the usage model, thanks for the nudge!

There is some documentation here too, hope it is helpful:

https://docs.kernel.org/admin-guide/thunderbolt.html

> > We do check for the DMAR bit in the Intel IOMMU code and we also do
> > check that there actually are PCIe ports marked external facing but we
> > could issue warning there if that's not the case. Similarly if the user
> > explicitly disabled the IOMMU translation. This can be done inside a new
> > IOMMU API that does something like the below pseudo-code:
> > 
> > #if IOMMU_ENABLED
> > bool iommu_dma_protected(struct device *dev)
> > {
> > 	if (dmar_platform_optin() /* or the AMD equivalent */) {
> > 		if (!iommu_present(...)) /* whatever is needed to check that the full translation is enabled */
> > 			dev_warn(dev, "IOMMU protection disabled!");
> > 		/*
> > 		 * Look for the external facing ports. Should be at
> > 		 * least 1 or issue warning.
> > 		 */
> > 		 ...
> > 
> > 		return true;
> > 	}
> > 
> > 	return false;
> > }
> > #else
> > static inline bool iommu_dma_protected(struct device *dev)
> > {
> > 	return false;
> > }
> > #endif
> > 
> > Then we can make iommu_dma_protection_show() to call this function.
> 
> The problem that I've been trying to nail down here is that
> dmar_platform_optin() really doesn't mean much for us - I don't know how
> Windows' IOMMU drivers work, but there's every chance it's not the same way
> as ours. The only material effect that dmar_platform_optin() has for us is
> to prevent the user from disabling the IOMMU driver altogether, and thus
> ensure that iommu_present() is true. Whether or not we can actually trust
> the IOMMU driver to provide reliable protection depends entirely on whether
> it knows the PCIe ports are external-facing. If not, we can only
> *definitely* know what the IOMMU driver will do for a given endpoint once
> that endpoint has appeared behind the port and iommu_probe_device() has
> decided what its default domain should be, and as far as I now understand,
> that's not an option for Thunderbolt since it can only happen *after* the
> tunnel has been authorised and created.

That's correct. We do know the PCIe root/downstream ports (the external
facing ones) that host the tunneled PCIe topology but rest will appear
dynamically after the connection manager established the protocol
tunnel.

> Much as I'm tempted to de-scope back to my IOMMU API cleanup and run away
> from the rest of the issue, I think I can crib enough from the existing code
> to attempt a reasonable complete fix, so let me give that a go...

Sure ;-)
