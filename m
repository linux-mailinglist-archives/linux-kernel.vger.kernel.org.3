Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260934B2064
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348082AbiBKImX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:42:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiBKImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:42:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BCFE63;
        Fri, 11 Feb 2022 00:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644568940; x=1676104940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PpMJMXS6WkF9+j6bW6+PmKvBInYfF2QiYeNr5pog1pM=;
  b=UHeDweiA8bMz7Zzzmy0DXXuU6pSoBEvH9uEElWpDX8VPrVCY3M3i3d6D
   7+mNDL6X0vz/bqJWtC3UVqPw2RdZ2iFZFBPojoYDymv1DxxQjEydmkNO0
   ti76qQUrD/2nk9xY5rRlNjqvsDYxhgKYrTp7zRz2pbV6MYYixq9kXnn46
   uayXsCZgzcz+QG5Hmreg0up9GkCO+tnd1naL9fV3D8n6Qsy8ZLRVzo9gC
   Nl/hweIO8RR1Qk4uUR9edvJrhViGacfAio0PL3zaNps7zO5LMAoHBLyDV
   NopAOforcub7+5jU9aubO2JlWvr5Mo4dzPFv6NVlVJZutU+JKy8dNCBkP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249636956"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="249636956"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="500708938"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:42:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIRUX-003N8F-Pg;
        Fri, 11 Feb 2022 10:41:21 +0200
Date:   Fri, 11 Feb 2022 10:41:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.co>
Subject: Re: [PATCH] ACPI: scan: Use ida_alloc() instead of ida_simple_get()
Message-ID: <YgYhMRS7cqal7/01@smile.fi.intel.com>
References: <2645186.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2645186.mvXUDI8C0e@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 09:05:33PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> As recommended in include/linux/idr.h, use ida_alloc() instead of
> ida_simple_get() for creating unique device object names and for
> symmetry replace ida_simple_remove() with ida_free() (and fix up
> the related overly long code line while at it).
> 
> Also drop the ACPI_MAX_DEVICE_INSTANCES limit that is not necessary
> any more and may not be sufficient for future platforms.

Makes sense,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/internal.h |    2 --
>  drivers/acpi/scan.c     |    5 +++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -96,8 +96,6 @@ void acpi_scan_table_notify(void);
>  
>  extern struct list_head acpi_bus_id_list;
>  
> -#define ACPI_MAX_DEVICE_INSTANCES	4096
> -
>  struct acpi_device_bus_id {
>  	const char *bus_id;
>  	struct ida instance_ida;
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -477,7 +477,8 @@ static void acpi_device_del(struct acpi_
>  	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
>  		if (!strcmp(acpi_device_bus_id->bus_id,
>  			    acpi_device_hid(device))) {
> -			ida_simple_remove(&acpi_device_bus_id->instance_ida, device->pnp.instance_no);
> +			ida_free(&acpi_device_bus_id->instance_ida,
> +				 device->pnp.instance_no);
>  			if (ida_is_empty(&acpi_device_bus_id->instance_ida)) {
>  				list_del(&acpi_device_bus_id->node);
>  				kfree_const(acpi_device_bus_id->bus_id);
> @@ -642,7 +643,7 @@ static int acpi_device_set_name(struct a
>  	struct ida *instance_ida = &acpi_device_bus_id->instance_ida;
>  	int result;
>  
> -	result = ida_simple_get(instance_ida, 0, ACPI_MAX_DEVICE_INSTANCES, GFP_KERNEL);
> +	result = ida_alloc(instance_ida, GFP_KERNEL);
>  	if (result < 0)
>  		return result;
>  
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


