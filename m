Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91735450CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbiFIP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344502AbiFIP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:27:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981CC4BBBF;
        Thu,  9 Jun 2022 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654788462; x=1686324462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6oG0RDL23b0HBnQM7v3r1dtxBOZ1/OfrXUIIgw7Fvg=;
  b=mpd97mMn4i31fe+E8e25t7eomK0tt1urt2TYC9J8qHY2vELCMSJ4Q0mY
   6wy1Wy97NuMLVBllhWL6bYh4udsOI8BYzk9emt21oUBfuKKl5hZW1U22d
   jQj9i9T78pNn6jndJfluOgGudjPKOwiy6ceNFycAg8UOf9Bg6ZN+lrf7c
   cFMoOztVrPBEjKPlrqH0OyEDMqS5DjN2bUc8Su3gMRKDp58AbGrlSd/zg
   Sh99g2k3wLHZbC2lJTydTG7Jp9gwaX87lUoRac7279ZnDyZN/BzntjsRW
   RPMQ0hpzSGSRrIZsYtBAJpQ4c0DIvhtYSQeqPpBj/2cDgePI9bRhT1/Fm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339078738"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="339078738"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:27:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="533647304"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:27:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nzK4O-000XyF-Go;
        Thu, 09 Jun 2022 18:27:36 +0300
Date:   Thu, 9 Jun 2022 18:27:36 +0300
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
Subject: Re: [PATCH v1 05/16] USB: ACPI: Use acpi_find_child_by_adr()
Message-ID: <YqIRaLdifSnEUN7H@smile.fi.intel.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <3459925.iIbC2pHGDl@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3459925.iIbC2pHGDl@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

...

>  	if (!parent)
>  		return NULL;

Can be removed because it's embedded in the call below, no?

> +	return acpi_find_child_by_adr(parent, raw);

-- 
With Best Regards,
Andy Shevchenko


