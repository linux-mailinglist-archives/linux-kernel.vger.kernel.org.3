Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8FF549EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348827AbiFMUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiFMUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:16:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ECB2AE3C;
        Mon, 13 Jun 2022 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655146419; x=1686682419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/FooetRT0zhGj9JT4wTV9Q1LeNSCJr8h76SMTw5COE=;
  b=QHyD+zEUTks6H3km+26SNY3qIxehbSgv3Yp1iJt5Drm3t3a8Ni1bmJqC
   irggBQsXWq/5l3h22o5O+ZReLBZb/vBHcs5I5m6MKDg9wJbvXr2VCGy3P
   3tVz4zG5UjMzh9s1f3eBka7ylVtZy0dnF2vujqo3iYuKK7dt34Da5tW0P
   174mmabEEKj7kOGu9IDDW45ucz3dp9SL22PiAIv6WqyFf1cslmRX6UkDW
   f5L6YDjAp6KC3p2yQR/L8BUizcgune/C5bSG+RXocEygVMC3Sg3U8BVn6
   q2NUQz9tn6BCjYZHZuq9/YcCLmSu+US1215RmmrLFy5l7SoBO2FwXyxiE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="275909478"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="275909478"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:53:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="673448816"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:53:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o0pBt-000bIT-Rw;
        Mon, 13 Jun 2022 21:53:33 +0300
Date:   Mon, 13 Jun 2022 21:53:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 05/16] USB: ACPI: Replace usb_acpi_find_port() with
 acpi_find_child_by_adr()
Message-ID: <YqeHrRe/VFUpEJd6@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <23334378.ouqheUzb2q@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23334378.ouqheUzb2q@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:39:37PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly
> in order to find the child matching a given bus address, use
> acpi_find_child_by_adr() for this purpose.
> 
> Also notice that if acpi_find_child_by_adr() doesn't find a matching
> child, acpi_find_child_device() will not find it too, so directly
> replace usb_acpi_find_port() in usb_acpi_get_companion_for_port() with
> acpi_find_child_by_adr() and drop it entirely.
> 
> Apart from simplifying the code, this will help to eliminate the
> children list head from struct acpi_device as it is redundant and it
> is used in questionable ways in some places (in particular, locking is
> needed for walking the list pointed to it safely, but it is often
> missing).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>    * Drop usb_acpi_find_port() (Heikki, Andy).
>    * Change the subject accordingly.
> 
> ---
>  drivers/usb/core/usb-acpi.c |   18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/usb/core/usb-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/usb/core/usb-acpi.c
> +++ linux-pm/drivers/usb/core/usb-acpi.c
> @@ -124,22 +124,6 @@ out:
>   */
>  #define USB_ACPI_LOCATION_VALID (1 << 31)
>  
> -static struct acpi_device *usb_acpi_find_port(struct acpi_device *parent,
> -					      int raw)
> -{
> -	struct acpi_device *adev;
> -
> -	if (!parent)
> -		return NULL;
> -
> -	list_for_each_entry(adev, &parent->children, node) {
> -		if (acpi_device_adr(adev) == raw)
> -			return adev;
> -	}
> -
> -	return acpi_find_child_device(parent, raw, false);
> -}
> -
>  static struct acpi_device *
>  usb_acpi_get_companion_for_port(struct usb_port *port_dev)
>  {
> @@ -170,7 +154,7 @@ usb_acpi_get_companion_for_port(struct u
>  		port1 = port_dev->portnum;
>  	}
>  
> -	return usb_acpi_find_port(adev, port1);
> +	return acpi_find_child_by_adr(adev, port1);
>  }
>  
>  static struct acpi_device *
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


