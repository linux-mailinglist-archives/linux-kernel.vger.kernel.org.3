Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0350C766
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 06:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiDWEbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 00:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiDWEbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 00:31:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A7C20F218;
        Fri, 22 Apr 2022 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650688096; x=1682224096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/pCa7WN3eGgIJ33K3BJpDxfTsLs/mkxhcUUi+OzYWV4=;
  b=VdgcL0bnziPFdoqtKptKeQV+M8pCg/Mw51e3B2Nq81AUtdAjZrCwSwFo
   nZ5NS5Csor1fk1okhy+HYDCV0878IyGZGAn7MnVS841DcMN8LiciBlkg5
   44ri6frRhexr1M7fGFbSlY3A1FcCUVtw7jkLERmUIuERPucmaPQdZJgUU
   hItGXekgSUtUESwfEA+rQgYT/88ZihUgrR9zEKxt046zLkXuSc3lp2xEd
   xu++CY/dwaGrftXPh1Z8HYbRR81R1cK6UJBFnygCVQI/f6h+Cgo2ka9cr
   nNs3X+OW5wbMpkcjYnKaYAloem1B1pGGaSi6wvSl8nNIhi2N1bTQl8lGL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289976033"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="289976033"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:28:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="534932278"
Received: from hltravis-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.166.215])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:28:15 -0700
Date:   Fri, 22 Apr 2022 21:28:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, peterz@infradead.org,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] nvdimm: Fix firmware activation deadlock scenarios
Message-ID: <YmOAXqOIW7DE0nMR@iweiny-desk3>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055523099.3745911.9091010720291846249.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165055523099.3745911.9091010720291846249.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:33:51AM -0700, Dan Williams wrote:
> Lockdep reports the following deadlock scenarios for CXL root device
> power-management, device_prepare(), operations, and device_shutdown()
> operations for 'nd_region' devices:
> 
> ---
>  Chain exists of:
>    &nvdimm_region_key --> &nvdimm_bus->reconfig_mutex --> system_transition_mutex
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(system_transition_mutex);
>                                 lock(&nvdimm_bus->reconfig_mutex);
>                                 lock(system_transition_mutex);
>    lock(&nvdimm_region_key);
> 
> --
> 
>  Chain exists of:
>    &cxl_nvdimm_bridge_key --> acpi_scan_lock --> &cxl_root_key
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&cxl_root_key);
>                                 lock(acpi_scan_lock);
>                                 lock(&cxl_root_key);
>    lock(&cxl_nvdimm_bridge_key);
> 
> ---
> 
> These stem from holding nvdimm_bus_lock() over hibernate_quiet_exec()
> which walks the entire system device topology taking device_lock() along
> the way. The nvdimm_bus_lock() is protecting against unregistration,
> multiple simultaneous ops callers, and preventing activate_show() from
> racing activate_store(). For the first 2, the lock is redundant.
> Unregistration already flushes all ops users, and sysfs already prevents
> multiple threads to be active in an ops handler at the same time. For
> the last userspace should already be waiting for its last
> activate_store() to complete, and does not need activate_show() to flush
> the write side, so this lock usage can be deleted in these attributes.
>

I'm sorry if this is obvious but why can't the locking be removed from
capability_show() and nvdimm_bus_firmware_visible() as well?

Effectively it sounds like we don't care if the cap read is racing any state
change?  And we know the device can't go away while sysfs is calling those
functions.

Ira

> 
> Fixes: 48001ea50d17 ("PM, libnvdimm: Add runtime firmware activation support")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/core.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
> index 144926b7451c..7c7f4a43fd4f 100644
> --- a/drivers/nvdimm/core.c
> +++ b/drivers/nvdimm/core.c
> @@ -395,10 +395,8 @@ static ssize_t activate_show(struct device *dev,
>  	if (!nd_desc->fw_ops)
>  		return -EOPNOTSUPP;
>  
> -	nvdimm_bus_lock(dev);
>  	cap = nd_desc->fw_ops->capability(nd_desc);
>  	state = nd_desc->fw_ops->activate_state(nd_desc);
> -	nvdimm_bus_unlock(dev);
>  
>  	if (cap < NVDIMM_FWA_CAP_QUIESCE)
>  		return -EOPNOTSUPP;
> @@ -443,7 +441,6 @@ static ssize_t activate_store(struct device *dev,
>  	else
>  		return -EINVAL;
>  
> -	nvdimm_bus_lock(dev);
>  	state = nd_desc->fw_ops->activate_state(nd_desc);
>  
>  	switch (state) {
> @@ -461,7 +458,6 @@ static ssize_t activate_store(struct device *dev,
>  	default:
>  		rc = -ENXIO;
>  	}
> -	nvdimm_bus_unlock(dev);
>  
>  	if (rc == 0)
>  		rc = len;
> 
> 
