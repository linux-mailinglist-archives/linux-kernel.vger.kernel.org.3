Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1354AABC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354722AbiFNHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiFNHgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:36:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD83DA70;
        Tue, 14 Jun 2022 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655192171; x=1686728171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bMs/9D+S33oJTwrcpL/K+zJElMRWgWh3nH1VpfsRUBo=;
  b=agvGbtTH/W9qQatP05JR26bOybHb5nKPbmhT1d+U3YVnDsAO1U1zrLZf
   +CXVHurmiPpM7K96NPyDGOZvZKOdal3i66YODpHvHs8Zxqs5d+6I6/NVr
   1dfqCD10ln52D5o54KAkMi0eTRj7T9zBZq/wXKFCCrPOhpRdZfKypo4hm
   moVJscWZI+G6SnM4K5T3T/N/v+sVA+UgoBhycn2mgAVCBkyiMiic0jujn
   3yY5aLhMZs3zwyMT1rdliNdXRLn6qWTamX6jIUfNclpDN3fUZzA6bLb0R
   L5RS5CknZKTQKXLaUy8kDsYqdUNdlRAT06OU4LVIhCUcdBCYhE695di8s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="342505514"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="342505514"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:36:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="726692745"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2022 00:36:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Jun 2022 10:36:05 +0300
Date:   Tue, 14 Jun 2022 10:36:05 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 04/16] thunderbolt: ACPI: Replace tb_acpi_find_port()
 with acpi_find_child_by_adr()
Message-ID: <Yqg6ZSWpxc7T5Ynn@kuha.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <2851774.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2851774.e9J7NaK4W3@kreacher>
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
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

-- 
heikki
