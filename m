Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26DC50C5AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiDWAYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiDWAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:24:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E409817C52F;
        Fri, 22 Apr 2022 17:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650673306; x=1682209306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r7gJUwx/VAz07zgYuQQBCxDe1i9e9dna/I1EfI931GA=;
  b=mWvtNVD9bN9/VDe7Ba6BZQPlIV1S4L2Ee+f13uycCS6gjT/3iKgszbTQ
   8E0y81aobfmDu30gTGBzkUwJfP5iV5lPI63qcBSp9jnE0t/gdpFDY8k95
   MhTS1dXvcg2gDxruIbL/Cw+5JkN7yln4GWOsCwzGiANPC1ySPNhFCRpWY
   IFzU2ahvPXDKPzosQr06G9JvqVPJ5El/SDrkxuDcCziVPyTZiaebmQ2ml
   hFPRPLNvm4BNY/32xgKAMTXei1hGc8RcENRxqQ6hty4pnUiTo3i0JJggC
   7X56nUgesA3C76W9KJxgjp5UP4xIvIArgKJAdWDppgHggWC/twtCpHld1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289952194"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289952194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 17:21:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="534712143"
Received: from hltravis-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.166.215])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 17:21:45 -0700
Date:   Fri, 22 Apr 2022 17:21:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, peterz@infradead.org,
        alison.schofield@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] ACPI: NFIT: Drop nfit_device_lock()
Message-ID: <YmNGmSZ/YVsEQfyc@iweiny-desk3>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055521409.3745911.8085645201146909612.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165055521409.3745911.8085645201146909612.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:33:34AM -0700, Dan Williams wrote:
> The nfit_device_lock() helper was added to provide lockdep coverage for
> the NFIT driver's usage of device_lock() on the nvdimm_bus object. Now
> that nvdimm_bus objects have their own lock class this wrapper can be
> dropped.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/acpi/nfit/core.c |   30 +++++++++++++++---------------
>  drivers/acpi/nfit/nfit.h |   24 ------------------------
>  2 files changed, 15 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index fe61f617a943..ae5f4acf2675 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1230,7 +1230,7 @@ static ssize_t hw_error_scrub_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	nfit_device_lock(dev);
> +	device_lock(dev);
>  	nd_desc = dev_get_drvdata(dev);
>  	if (nd_desc) {
>  		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> @@ -1247,7 +1247,7 @@ static ssize_t hw_error_scrub_store(struct device *dev,
>  			break;
>  		}
>  	}
> -	nfit_device_unlock(dev);
> +	device_unlock(dev);
>  	if (rc)
>  		return rc;
>  	return size;
> @@ -1267,10 +1267,10 @@ static ssize_t scrub_show(struct device *dev,
>  	ssize_t rc = -ENXIO;
>  	bool busy;
>  
> -	nfit_device_lock(dev);
> +	device_lock(dev);
>  	nd_desc = dev_get_drvdata(dev);
>  	if (!nd_desc) {
> -		nfit_device_unlock(dev);
> +		device_unlock(dev);
>  		return rc;
>  	}
>  	acpi_desc = to_acpi_desc(nd_desc);
> @@ -1287,7 +1287,7 @@ static ssize_t scrub_show(struct device *dev,
>  	}
>  
>  	mutex_unlock(&acpi_desc->init_mutex);
> -	nfit_device_unlock(dev);
> +	device_unlock(dev);
>  	return rc;
>  }
>  
> @@ -1304,14 +1304,14 @@ static ssize_t scrub_store(struct device *dev,
>  	if (val != 1)
>  		return -EINVAL;
>  
> -	nfit_device_lock(dev);
> +	device_lock(dev);
>  	nd_desc = dev_get_drvdata(dev);
>  	if (nd_desc) {
>  		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>  
>  		rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
>  	}
> -	nfit_device_unlock(dev);
> +	device_unlock(dev);
>  	if (rc)
>  		return rc;
>  	return size;
> @@ -1697,9 +1697,9 @@ static void acpi_nvdimm_notify(acpi_handle handle, u32 event, void *data)
>  	struct acpi_device *adev = data;
>  	struct device *dev = &adev->dev;
>  
> -	nfit_device_lock(dev->parent);
> +	device_lock(dev->parent);
>  	__acpi_nvdimm_notify(dev, event);
> -	nfit_device_unlock(dev->parent);
> +	device_unlock(dev->parent);
>  }
>  
>  static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
> @@ -3152,8 +3152,8 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
>  	struct device *dev = acpi_desc->dev;
>  
>  	/* Bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
> -	nfit_device_lock(dev);
> -	nfit_device_unlock(dev);
> +	device_lock(dev);
> +	device_unlock(dev);
>  
>  	/* Bounce the init_mutex to complete initial registration */
>  	mutex_lock(&acpi_desc->init_mutex);
> @@ -3305,8 +3305,8 @@ void acpi_nfit_shutdown(void *data)
>  	 * acpi_nfit_ars_rescan() submissions have had a chance to
>  	 * either submit or see ->cancel set.
>  	 */
> -	nfit_device_lock(bus_dev);
> -	nfit_device_unlock(bus_dev);
> +	device_lock(bus_dev);
> +	device_unlock(bus_dev);
>  
>  	flush_workqueue(nfit_wq);
>  }
> @@ -3449,9 +3449,9 @@ EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>  
>  static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>  {
> -	nfit_device_lock(&adev->dev);
> +	device_lock(&adev->dev);
>  	__acpi_nfit_notify(&adev->dev, adev->handle, event);
> -	nfit_device_unlock(&adev->dev);
> +	device_unlock(&adev->dev);
>  }
>  
>  static const struct acpi_device_id acpi_nfit_ids[] = {
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index 50882bdbeb96..6023ad61831a 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -337,30 +337,6 @@ static inline struct acpi_nfit_desc *to_acpi_desc(
>  	return container_of(nd_desc, struct acpi_nfit_desc, nd_desc);
>  }
>  
> -#ifdef CONFIG_PROVE_LOCKING
> -static inline void nfit_device_lock(struct device *dev)
> -{
> -	device_lock(dev);
> -	mutex_lock(&dev->lockdep_mutex);
> -}
> -
> -static inline void nfit_device_unlock(struct device *dev)
> -{
> -	mutex_unlock(&dev->lockdep_mutex);
> -	device_unlock(dev);
> -}
> -#else
> -static inline void nfit_device_lock(struct device *dev)
> -{
> -	device_lock(dev);
> -}
> -
> -static inline void nfit_device_unlock(struct device *dev)
> -{
> -	device_unlock(dev);
> -}
> -#endif
> -
>  const guid_t *to_nfit_uuid(enum nfit_uuids id);
>  int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *nfit, acpi_size sz);
>  void acpi_nfit_shutdown(void *data);
> 
