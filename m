Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F8B545C96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbiFJGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiFJGqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:46:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377235A5BC;
        Thu,  9 Jun 2022 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654843592; x=1686379592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bak+PaguLlGs0EMkmOjZv7d+/b+qyh+9qIl37rSGwWQ=;
  b=n5n/0j+QM4D+bU9C+wo+Nhrvo/4md9X+DLqor+o1kRt+3DVxNYDMfj8y
   TyMwNs2N52NnLJ9AUhQoUmAoLi6BWoX7ri7HcKv0hh3etgE0PsCPef2hT
   iecNbJO+Wr5cbLrKMUsaYXnTWUkhqinbx4gTVt8r+tp7YwlEZZOY7AEUO
   jqDix+Xdq70/2c+v8qzUWFOpap/uAtECC3e25psmnd2/WGx5d0AdnhOOn
   NYTJsR//i9cX0CiR+GcCno0UdToKa6XhLtndVt2a9fleIWR7BNKBR1r5E
   HiFUNfGmv2QssCOEJegwz3fqSYGhWiZzkta16vSf11ELW2+vF3nyHILqp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339289554"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="339289554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:46:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="724822105"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Jun 2022 23:46:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 10 Jun 2022 09:46:26 +0300
Date:   Fri, 10 Jun 2022 09:46:26 +0300
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
Subject: Re: [PATCH v1 04/16] thunderbolt: ACPI: Use acpi_find_child_by_adr()
Message-ID: <YqLowrkmibyh56T+@kuha.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <7414189.EvYhyI6sBW@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7414189.EvYhyI6sBW@kreacher>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:54:40PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly
> in order to find the child matching a given bus address, use
> acpi_find_child_by_adr() for this purpose.
> 
> Apart from simplifying the code, this will help to eliminate the
> children list head from struct acpi_device as it is redundant and it
> is used in questionable ways in some places (in particular, locking is
> needed for walking the list pointed to it safely, but it is often
> missing).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thunderbolt/acpi.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thunderbolt/acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/thunderbolt/acpi.c
> +++ linux-pm/drivers/thunderbolt/acpi.c
> @@ -304,8 +304,6 @@ static bool tb_acpi_bus_match(struct dev
>  static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
>  					     const struct tb_port *port)
>  {
> -	struct acpi_device *port_adev;
> -
>  	if (!adev)
>  		return NULL;
>  
> @@ -313,12 +311,7 @@ static struct acpi_device *tb_acpi_find_
>  	 * Device routers exists under the downstream facing USB4 port
>  	 * of the parent router. Their _ADR is always 0.
>  	 */
> -	list_for_each_entry(port_adev, &adev->children, node) {
> -		if (acpi_device_adr(port_adev) == port->port)
> -			return port_adev;
> -	}
> -
> -	return NULL;
> +	return acpi_find_child_by_adr(adev, port->port);
>  }
>  
>  static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)

I don't think you need tb_acpi_find_port() anymore. You can just call
acpi_find_child_by_ard(ACPI_COMPANION(...), port->port) directly, no?

thanks,

-- 
heikki
