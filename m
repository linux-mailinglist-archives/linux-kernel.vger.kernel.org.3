Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4145150C55A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiDWABb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiDWABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:01:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC71E3DFB;
        Fri, 22 Apr 2022 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650671909; x=1682207909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e3FLOi/+v6B4A3waN/i8lUdjtDM+G0jjnajfyZctWxo=;
  b=SDp6R0Jq6rA76nJhR1qd9Krc7/kuPoIlPu8AjtGHYzEzBm5dyZlnpVd3
   M5EZx+mIZASwD4AOe+UneOSJ8JAOBaST/lsxK9qAApO8Lci8zaLAzsYyX
   ELSN3rsYBU+I9vYYQoCkfizxbxeh3oFWhCHJIWh631avjW7SecqkC4jbz
   eIUE5vKHqtfFPnoDd7gIAFDLip8uiRTkDs5Aqt8IQqz2c2RDQ2aLPd9PF
   Rm1ExLPCq4FNiJck2gLEq0IhfTY1DZo2SJoQMArZePDpF4xRVbG3GlGRJ
   bSu7NY+tWLKy8Ed29vyuouhuZK9JOy5FJD7hSSWPtONMheDI/tLKS/+Sr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264306798"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264306798"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:58:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="659264395"
Received: from hltravis-mobl1.amr.corp.intel.com (HELO localhost) ([10.213.166.215])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:58:28 -0700
Date:   Fri, 22 Apr 2022 16:58:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] cxl/acpi: Add root device lockdep validation
Message-ID: <YmNBJBTxUCvDHMbw@iweiny-desk3>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:33:18AM -0700, Dan Williams wrote:
> The CXL "root" device, ACPI0017, is an attach point for coordinating
> platform level CXL resources and is the parent device for a CXL port
> topology tree. As such it has distinct locking rules relative to other
> CXL subsystem objects, but because it is an ACPI device the lock class
> is established well before it is given to the cxl_acpi driver.
 
This final sentence gave me pause because it implied that the device lock class
was set to something other than no validate.  But I don't see that anywhere in
the acpi code.  So given that it looks to me like ACPI is just using the
default no validate class...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> However, the lockdep API does support changing the lock class "live" for
> situations like this. Add a device_lock_set_class() helper that a driver
> can use in ->probe() to set a custom lock class, and
> device_lock_reset_class() to return to the default "no validate" class
> before the custom lock class key goes out of scope after ->remove().
> 
> Note the helpers are all macros to support dead code elimination in the
> CONFIG_PROVE_LOCKING=n case.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c     |   15 +++++++++++++++
>  include/linux/device.h |   25 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d15a6aec0331..e19cea27387e 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -275,6 +275,15 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  	return 1;
>  }
>  
> +static struct lock_class_key cxl_root_key;
> +
> +static void cxl_acpi_lock_reset_class(void *_dev)
> +{
> +	struct device *dev = _dev;
> +
> +	device_lock_reset_class(dev);
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc;
> @@ -283,6 +292,12 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *adev = ACPI_COMPANION(host);
>  	struct cxl_cfmws_context ctx;
>  
> +	device_lock_set_class(&pdev->dev, &cxl_root_key);
> +	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
> +				      &pdev->dev);
> +	if (rc)
> +		return rc;
> +
>  	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>  	if (IS_ERR(root_port))
>  		return PTR_ERR(root_port);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 93459724dcde..82c9d307e7bd 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -850,6 +850,31 @@ static inline bool device_supports_offline(struct device *dev)
>  	return dev->bus && dev->bus->offline && dev->bus->online;
>  }
>  
> +#define __device_lock_set_class(dev, name, key) \
> +	lock_set_class(&(dev)->mutex.dep_map, name, key, 0, _THIS_IP_)
> +
> +/**
> + * device_lock_set_class - Specify a temporary lock class while a device
> + *			   is attached to a driver
> + * @dev: device to modify
> + * @key: lock class key data
> + *
> + * This must be called with the device_lock() already held, for example
> + * from driver ->probe().
> + */
> +#define device_lock_set_class(dev, key)				\
> +	__device_lock_set_class(dev, #key, key)
> +
> +/**
> + * device_lock_reset_class - Return a device to the default lockdep novalidate state
> + * @dev: device to modify
> + *
> + * This must be called with the device_lock() already held, for example
> + * from driver ->remove().
> + */
> +#define device_lock_reset_class(dev) \
> +	device_lock_set_class(dev, &__lockdep_no_validate__)
> +
>  void lock_device_hotplug(void);
>  void unlock_device_hotplug(void);
>  int lock_device_hotplug_sysfs(void);
> 
