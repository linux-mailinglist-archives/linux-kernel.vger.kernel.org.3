Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AEF4DB019
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355924AbiCPMu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354780AbiCPMux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:50:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0126F2DD6F;
        Wed, 16 Mar 2022 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647434980; x=1678970980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IIrsq5OUhyurUfvKKtDLorbLqzXKEGzZOMn7vCsCkiA=;
  b=QbU5MWAhyyu0adBQdnPatDWvOaQlgTUrJUykW7IVhNc6nhtmQYttFTVO
   2H4o3493FVHJPb4JWAotiTr/R6hZh5EdVxEgjoKfqJ7yMcgZigu1J0BO/
   VdM4jxpRENT6CSbEk8nwkHx+rhB0vyGgqYloM/SjqdW2c8vuntRl51sK8
   nA2OovAuc2Bz698GARByUVBBTo6K+liiS5ylJzsx6iBndJj0S70Y7HJ0e
   QaOck57eOpuUDf/bdLWElYQqNZXSuOTjEYIEsrb3sAutkmV7iym37WPzb
   YYxE19cSFITrfWayybOVzzmMmBmwcX3U/l55H1QhneXzZQHpTaMqFeMCO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256526213"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256526213"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:49:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="714584109"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:49:35 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 14:45:11 +0200
Date:   Wed, 16 Mar 2022 14:45:11 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjHb1xCx4UAmUjrR@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Mar 16, 2022 at 11:25:51AM +0000, Robin Murphy wrote:
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Furthermore, the presence or not of one firmware flag
> doesn't imply anything about the IOMMU driver's behaviour, which may
> still depend on other firmware properties and kernel options too. What
> actually matters is whether an IOMMU is enforcing protection for our
> device - regardless of whether that stemmed from firmware policy, kernel
> config, or user control - at the point we need to decide whether to
> authorise it. We can ascertain that generically by simply looking at
> whether we're currently attached to a translation domain or not.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> I don't have the means to test this, but I'm at least 80% confident
> in my unpicking of the structures to retrieve the correct device...
> 
>  drivers/thunderbolt/domain.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..5f5fc5f6a09b 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -257,13 +257,14 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> +	struct tb *tb = container_of(dev, struct tb, dev);
> +	struct iommu_domain *iod = iommu_get_domain_for_dev(&tb->nhi->pdev->dev);

I wonder if this is the correct "domain"? I mean it's typically no the
Thunderbolt controller (here tb->nhi->pdev->dev) that needs the
protection (although in discrete controllers it does get it too) but
it's the tunneled PCIe topology that we need to check here.

For instance in Intel with intergrated Thunderbolt we have topology like
this:

  Host bridge
      |
      +--- Tunneled PCIe root port #1
      +--- Tunneled PCIe root port #2
      +--- Thunderbolt host controller (the NHI above)
      +--- xHCI

and In case of discrete controllers it looks like this:

  Host bridge
      |
      +--- PCIe root port #x
                |
                |
           PCIe switch upstream port
                |
	        +--- Tunneled PCIe switch downstream port #1
	        +--- Tunneled PCIe switch downstream port #2
        	+--- Thunderbolt host controller (the NHI above)
        	+--- xHCI

What we want is to make sure the Tunneled PCIe ports get the full IOMMU
protection. In case of the discrete above it is also fine if all the
devices behind the PCIe root port get the full IOMMU protection. Note in
the integrated all the devices are "siblings".
