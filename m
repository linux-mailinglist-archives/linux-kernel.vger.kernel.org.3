Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610AE54A938
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245391AbiFNGHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiFNGHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:07:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01E289A6;
        Mon, 13 Jun 2022 23:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655186840; x=1686722840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2NWYmtMEaCkUXhMiKQjXaIsRAgALzNDrpI2EiI+D+g0=;
  b=LD982nblU/vX5fu0pO9U200jSAeNxcDNPDwa9bJBCkpOaLZCNZ4ZY+EW
   iorb13L4XoJfbnXm6IPnLdsr8bdYwBg9y32CG9bSquOI5MX5FKCr/w/Y3
   j/RfaWCZMzpudPQ8VqNHvm1GCILsOxlgCuQddlUUvGmKB1ZWpfctaNdh0
   jsVlHg+9n05CxkOzbWgLnft6v/Kn/TFUpGFh0s40xu2QDVp+6IpK2bgrf
   CAYwTu0AVythN9sPmq+sp9XSAtmKaI66DW9zrzny6tgNrPZiZTfXt55ON
   /ZXmVfl+3tJ4FXaFVS7DeHBsPmU+rluwW5Rgm/qdpYyRFrGLZRiIiyB6G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261550457"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261550457"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:07:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="588242200"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:07:15 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 14 Jun 2022 09:07:13 +0300
Date:   Tue, 14 Jun 2022 09:07:13 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 04/16] thunderbolt: ACPI: Replace tb_acpi_find_port()
 with acpi_find_child_by_adr()
Message-ID: <YqglkQZxAagb8ln/@lahna>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <2851774.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2851774.e9J7NaK4W3@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

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
> 
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

Can you move the above comment here too?

Otherwise looks good to me,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> +		return acpi_find_child_by_adr(ACPI_COMPANION(dev->parent),
> +					      tb_to_usb4_port_device(dev)->port->port);
>  	return NULL;
>  }
>  
> 
> 
