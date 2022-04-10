Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58334FAFE9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiDJTyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiDJTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:54:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA649F2F;
        Sun, 10 Apr 2022 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649620344; x=1681156344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EF5s5J7GPdqeiz1pEHQ/PowHu/TjKguTo2H6OD1EN7Q=;
  b=bhO3jBMoQBJj79oZoo3KxdtcY/2c2NeEmQeGhvDmg7ODQ23i15dVKVIY
   jAZopaVTOo8joH5bLaBCDl5IO2p4H5DGz7JpZVNWmBQ+Zw3y/P5CRztDy
   oocY+rjaHz7WNjW67PAomN5AbaovM4U2cfAZyVKJPuNJRjDCKCvZrYIPv
   sB4Cm1miAUQAdjGCVr5WgA82vhAhq9FiSXtSwkNN+2hU5A2yOP7mvi1nB
   ybqoTEzLsE9hrsz3yKleuhmGbiG5yMvIOtYrJQs/t1rj6rxbirVeM2q0h
   TCyXDhc//rkx/FjkilPJdV4o0naS4SsLxRl5A7VrHMEKUknxXqnGIxw4t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="261430993"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="261430993"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 12:52:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="571814308"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 12:52:21 -0700
Date:   Sun, 10 Apr 2022 20:52:14 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - stop using iommu_present()
Message-ID: <YlM1bmo8M80Wjnov@silpixa00400314>
References: <ef01fbd7d2c60d56a0b8e8847a08ccb3ee5132af.1649161511.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef01fbd7d2c60d56a0b8e8847a08ccb3ee5132af.1649161511.git.robin.murphy@arm.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:25:11PM +0100, Robin Murphy wrote:
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Replace iommu_present() with a more appropriate check.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/crypto/qat/qat_common/adf_sriov.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
> index b960bca1f9d2..7f9c18dc4540 100644
> --- a/drivers/crypto/qat/qat_common/adf_sriov.c
> +++ b/drivers/crypto/qat/qat_common/adf_sriov.c
> @@ -3,7 +3,6 @@
>  #include <linux/workqueue.h>
>  #include <linux/pci.h>
>  #include <linux/device.h>
> -#include <linux/iommu.h>
>  #include "adf_common_drv.h"
>  #include "adf_cfg.h"
>  #include "adf_pfvf_pf_msg.h"
> @@ -176,7 +175,7 @@ int adf_sriov_configure(struct pci_dev *pdev, int numvfs)
>  		return -EFAULT;
>  	}
>  
> -	if (!iommu_present(&pci_bus_type))
> +	if (!device_iommu_mapped(&pdev->dev))
>  		dev_warn(&pdev->dev, "IOMMU should be enabled for SR-IOV to work correctly\n");
>  
>  	if (accel_dev->pf.vf_info) {
> -- 
> 2.28.0.dirty
> 
I tried this patch and it appears to work as expected.

Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

-- 
Giovanni
