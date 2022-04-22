Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523150BBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449450AbiDVPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354037AbiDVPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:30:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FB5D5C2;
        Fri, 22 Apr 2022 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650641247; x=1682177247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e11uwC3A+RGrIWC3PPNgkM7p6epgPs6roRgaCbYnPFA=;
  b=TIHxAMM/gjGQfiaTKF++EngJfK8zLucvnn5wfcvdJPNUELyj8xblte4j
   XRqfp384GBgMDuviILnOq9SwozLyifDjptiRcUkKHfjXA9yNGpuQykue9
   hP+JMBxCcQ1Jk9Lxgq3wOsBZLmxfu0OBjixu9+YR2sIfeg9vQm7nKdJpA
   Qdqhbxx0Ex+gAcl69Nn3LK8eznyF8399qYYluWBsDsFnwKrFVUp9wPnSb
   cpevJZfASNWa8lUhCv0PCMC6aG7F8RXZJDm9FYrq1Q0dD5nUbQpoH+bkz
   BXATvqJt9v1jdIkbq/KHeGXWg5ck1XzTlJ2bb491UEzPDmJj7x/Me6pU3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245272949"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="245272949"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 08:27:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577948682"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 08:27:24 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Apr 2022 18:26:10 +0300
Date:   Fri, 22 Apr 2022 18:26:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] ACPI: bus: Avoid non-ACPI device objects in walks over
 children
Message-ID: <YmLJEtDFhc3HFg3/@lahna>
References: <11974495.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11974495.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Fri, Apr 22, 2022 at 05:13:48PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When walking the children of an ACPI device, take extra care to avoid
> using to_acpi_device() on the ones that are not ACPI devices, because
> that may lead to out-of-bounds access and memory corruption.
> 
> While at it, make the function passed to acpi_dev_for_each_child()
> take a struct acpi_device pointer argument (instead of a struct device
> one), so it is more straightforward to use.
> 
> Fixes: b7dd6298db81 ("ACPI: PM: Introduce acpi_dev_power_up_children_with_adr()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> BugLink: https://lore.kernel.org/lkml/20220420064725.GB16310@xsang-OptiPlex-9020/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The commit being fixed is present in linux-next.
> 
> ---
>  drivers/acpi/bus.c       |   24 ++++++++++++++++++++++--
>  drivers/acpi/device_pm.c |    5 +----
>  include/acpi/acpi_bus.h  |    2 +-
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -1070,10 +1070,30 @@ int acpi_bus_for_each_dev(int (*fn)(stru
>  }
>  EXPORT_SYMBOL_GPL(acpi_bus_for_each_dev);
>  
> +struct acpi_dev_walk_context {
> +	int (*fn)(struct acpi_device *, void *);
> +	void *data;
> +};
> +
> +static int acpi_dev_for_one_check(struct device *dev, void *context)
> +{
> +	struct acpi_dev_walk_context *adwc = context;
> +
> +	if (dev->bus != &acpi_bus_type)
> +		return 0;

I wonder if it make sense to add dev_is_acpi() that does the above
analoguos to dev_is_pci()?

Regardless of that,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
