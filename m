Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4454AAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbiFNHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354869AbiFNHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:37:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F142717;
        Tue, 14 Jun 2022 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655192254; x=1686728254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dyN3zaVaPY7LOQzAZ95JAuA51qyiKN7Sxmvx6fs7h3A=;
  b=Rj6gpTCcd/1p85QyKP+XnlFjYTtSl57p5t/db+ZvbGNIq7CeucGpp0py
   wqsy7/6cEuMIYZOrnJW4uPKBcA1DoFYDp5aK0+HB/EalSyJ5feIYBb0Q9
   buGPZY5Cq22vJZzG1kA/p6x2B8YQSbm5NZkwtrSWWtc/f4KZslFZj29UE
   AGB34SGL8gWCG3tVMK/KoJinCUGMsysLP3ZQytOcb3iQ1q4PQwwYXWXlK
   bQ2VesiSrfIGyvFG6asJNNFnIt1xUDtd6X9Bt0D+qv88Nq8m0gvUxwl5d
   lCWduJZWsQGmRyi5h8bGBlsSzx1/Yl6X58IgOZO/2j699R19/ScBawHik
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267226793"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="267226793"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="726693022"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2022 00:37:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Jun 2022 10:37:29 +0300
Date:   Tue, 14 Jun 2022 10:37:29 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 05/16] USB: ACPI: Replace usb_acpi_find_port() with
 acpi_find_child_by_adr()
Message-ID: <Yqg6ucjdBITYkMeS@kuha.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <23334378.ouqheUzb2q@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23334378.ouqheUzb2q@kreacher>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

-- 
heikki
