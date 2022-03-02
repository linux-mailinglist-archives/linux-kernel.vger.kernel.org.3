Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343D34CA37E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiCBLWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiCBLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:22:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C079555B9;
        Wed,  2 Mar 2022 03:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646220113; x=1677756113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Htwp0cn4iD5IqoVEZ/IBuMOc0hHGYYNClu//F4PQ/o=;
  b=ZJFwG1MvaxZmk7M7JlkSt07QQ1VQ3/aXV3+HL5yrc2G1Pq7o43H694uP
   JdZtO1+0ivbWaKKEPfI8mMZl4Q7HxWe3CtsBAkvK+gry4pEJTJHS2fEke
   TRTlxc/trSYz4D5PZZLU+mtP6RpeCqLVmWFHnVhZRRrpxoLubydWBpIko
   3v3gB8+habxpeZvzFaHTLs6spLakHBwr2CMkXKM35663eAMCtTAvuiui8
   NYOSQxbo67fq1oxJIbO52c7a+jBRuxi3XXd6wO9bbqrb4ASb+OuEO9VLg
   +TFbjTXoTVILHqev0wVl51Y+hFrQYOK49T6aI0F2HU/yE9pTyY++9eia6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="240790596"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="240790596"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="686106327"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2022 03:21:50 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 02 Mar 2022 13:21:49 +0200
Date:   Wed, 2 Mar 2022 13:21:49 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: bus: Introduce acpi_bus_for_each_dev()
Message-ID: <Yh9TTb6rBeTAw0iB@kuha.fi.intel.com>
References: <11943345.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11943345.O9o76ZdvQC@kreacher>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:51:42PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to avoid exposing acpi_bus_type to modules, introduce an
> acpi_bus_for_each_dev() helper for iterating over all ACPI device
> objects and make typec_link_ports() use it instead of the raw
> bus_for_each_dev() along with acpi_bus_type.
> 
> Having done that, drop the acpi_bus_type export.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/acpi/bus.c              |    7 ++++++-
>  drivers/usb/typec/port-mapper.c |    2 +-
>  include/acpi/acpi_bus.h         |    2 ++
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -1043,7 +1043,12 @@ struct bus_type acpi_bus_type = {
>  	.remove		= acpi_device_remove,
>  	.uevent		= acpi_device_uevent,
>  };
> -EXPORT_SYMBOL_GPL(acpi_bus_type);
> +
> +int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data)
> +{
> +	return bus_for_each_dev(&acpi_bus_type, NULL, data, fn);
> +}
> +EXPORT_SYMBOL_GPL(acpi_bus_for_each_dev);
>  
>  /* --------------------------------------------------------------------------
>                               Initialization/Cleanup
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -480,6 +480,8 @@ void acpi_initialize_hp_context(struct a
>  /* acpi_device.dev.bus == &acpi_bus_type */
>  extern struct bus_type acpi_bus_type;
>  
> +int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data);
> +
>  /*
>   * Events
>   * ------
> Index: linux-pm/drivers/usb/typec/port-mapper.c
> ===================================================================
> --- linux-pm.orig/drivers/usb/typec/port-mapper.c
> +++ linux-pm/drivers/usb/typec/port-mapper.c
> @@ -59,7 +59,7 @@ int typec_link_ports(struct typec_port *
>  	if (!has_acpi_companion(&con->dev))
>  		return 0;
>  
> -	bus_for_each_dev(&acpi_bus_type, NULL, &arg, typec_port_match);
> +	acpi_bus_for_each_dev(typec_port_match, &arg);
>  	if (!arg.match)
>  		return 0;
>  
> 
> 

-- 
heikki
