Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4247B549ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347352AbiFMURk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiFMURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:17:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E61AC1EC3;
        Mon, 13 Jun 2022 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655146513; x=1686682513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=inO0kVsYPwubIHU/Lc+8Us9pBNkjnlVt647PW9FkfD4=;
  b=kFiYvfYDma04KuneN9hDic1XXd7P53w9a44kXJg8uWxmzXAl2iALK5JB
   wYDh1Ic4HJJZdifqcKAUzdFGQUOtTW1Enz2FwTAvE71f/3RtTbcALJh7I
   qzxBRwDa5UHTddW93rfF4Rj+4iVKtKGDv8ZSFKokpq8xvXv7iNNpDrh2p
   FjlXhf7VmzluBCSVNdiDu58+GJSQlM+LYxLH3/Amkk+nMvBAV/0LK1gPn
   pTe3H51ieyPnGT3aymq9HDQSEKbmKraGYfr3CNgkIx1eMKNGao0wrGAoW
   5XlXQQPL/luQwnvKeUTim4z+O8CpkrXlAnKPTZgggDq/HNsXoSUjGGQUs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="279425921"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="279425921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:55:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="568796226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:55:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o0pDP-000bIi-4d;
        Mon, 13 Jun 2022 21:55:07 +0300
Date:   Mon, 13 Jun 2022 21:55:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 04/16] thunderbolt: ACPI: Replace tb_acpi_find_port()
 with acpi_find_child_by_adr()
Message-ID: <YqeICh2mrZP1LX9n@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <2851774.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2851774.e9J7NaK4W3@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:11:36PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use acpi_find_child_by_adr() to find the child matching a given bus
> address instead of tb_acpi_find_port() that walks the list of children
> of an ACPI device directly for this purpose and drop the latter.
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
>    * Drop tb_acpi_find_port() (Heikki, Andy).
>    * Change the subject accordingly
> 
> ---
>  drivers/thunderbolt/acpi.c |   27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> Index: linux-pm/drivers/thunderbolt/acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/thunderbolt/acpi.c
> +++ linux-pm/drivers/thunderbolt/acpi.c
> @@ -301,26 +301,6 @@ static bool tb_acpi_bus_match(struct dev
>  	return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
>  }
>  
> -static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
> -					     const struct tb_port *port)
> -{
> -	struct acpi_device *port_adev;
> -
> -	if (!adev)
> -		return NULL;
> -
> -	/*
> -	 * Device routers exists under the downstream facing USB4 port
> -	 * of the parent router. Their _ADR is always 0.
> -	 */
> -	list_for_each_entry(port_adev, &adev->children, node) {
> -		if (acpi_device_adr(port_adev) == port->port)
> -			return port_adev;
> -	}
> -
> -	return NULL;
> -}
> -
>  static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
>  {
>  	struct acpi_device *adev = NULL;
> @@ -331,7 +311,8 @@ static struct acpi_device *tb_acpi_switc
>  		struct tb_port *port = tb_port_at(tb_route(sw), parent_sw);
>  		struct acpi_device *port_adev;
>  
> -		port_adev = tb_acpi_find_port(ACPI_COMPANION(&parent_sw->dev), port);
> +		port_adev = acpi_find_child_by_adr(ACPI_COMPANION(&parent_sw->dev),
> +						   port->port);
>  		if (port_adev)
>  			adev = acpi_find_child_device(port_adev, 0, false);
>  	} else {
> @@ -364,8 +345,8 @@ static struct acpi_device *tb_acpi_find_
>  	if (tb_is_switch(dev))
>  		return tb_acpi_switch_find_companion(tb_to_switch(dev));
>  	else if (tb_is_usb4_port_device(dev))
> -		return tb_acpi_find_port(ACPI_COMPANION(dev->parent),
> -					 tb_to_usb4_port_device(dev)->port);
> +		return acpi_find_child_by_adr(ACPI_COMPANION(dev->parent),
> +					      tb_to_usb4_port_device(dev)->port->port);
>  	return NULL;
>  }
>  
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


