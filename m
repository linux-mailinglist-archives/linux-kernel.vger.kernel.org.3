Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51A545C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346591AbiFJGrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346578AbiFJGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:47:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2563BD6;
        Thu,  9 Jun 2022 23:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654843659; x=1686379659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gdZIHA1wyCczBRKn7aGbyGkKbJ8yyoLB/kKHMoVwUgo=;
  b=H2REd8vvOrtv9iIowuAZDjFSXNBCsFDdvwt0CeInumQxc6zbH3/Sxi5Z
   HdC2e8rHjo1zsFtoyKV4RKHPTUve30gokGQjMf+ydFMrx38F7JG+QQeza
   BVDM/vYcbpRbvCe65v3z4LVr7mo1Mp31Za6GGI+12ShpL0VaZE4Y+0mAv
   vRr2kvxRLo4Se+Kof/PCHjo3GtZOy3xqQxb0r1+t2VXvYHLYeQqOnHbA7
   E7TJf5hvU8S5ktZS+i/xLXrIHJaDCQCNo1cLrWYZA022clgzp79NjpXTy
   vIUCMw2hqhs3/VKPetH6w37F307lIt7KqexOq3ZitWVS2V6pnEUMa90Ps
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363864975"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363864975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="724822524"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Jun 2022 23:47:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 10 Jun 2022 09:47:34 +0300
Date:   Fri, 10 Jun 2022 09:47:34 +0300
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
Subject: Re: [PATCH v1 05/16] USB: ACPI: Use acpi_find_child_by_adr()
Message-ID: <YqLpBp0NYhOCCd2X@kuha.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <3459925.iIbC2pHGDl@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3459925.iIbC2pHGDl@kreacher>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:56:42PM +0200, Rafael J. Wysocki wrote:
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
>  drivers/usb/core/usb-acpi.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/usb/core/usb-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/usb/core/usb-acpi.c
> +++ linux-pm/drivers/usb/core/usb-acpi.c
> @@ -127,17 +127,10 @@ out:
>  static struct acpi_device *usb_acpi_find_port(struct acpi_device *parent,
>  					      int raw)
>  {
> -	struct acpi_device *adev;
> -
>  	if (!parent)
>  		return NULL;
>  
> -	list_for_each_entry(adev, &parent->children, node) {
> -		if (acpi_device_adr(adev) == raw)
> -			return adev;
> -	}
> -
> -	return acpi_find_child_device(parent, raw, false);
> +	return acpi_find_child_by_adr(parent, raw);
>  }
>  
>  static struct acpi_device *

I think usb_acpi_find_port() can also be dropped now.

thanks,

-- 
heikki
