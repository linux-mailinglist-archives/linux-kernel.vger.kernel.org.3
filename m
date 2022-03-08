Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B04D172E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbiCHMYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346785AbiCHMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:23:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BDD3A5D4;
        Tue,  8 Mar 2022 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646742173; x=1678278173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1t2XizitfaB4uMPTTPoQH/R4rBfgRMQMND9uM6rWnHc=;
  b=naEmr/76iul9yOsCW7wuj4uOKfeoOlGNacDQgsTEINfrouvqEqwgC87z
   5ipRNYzOg4PQcW8Djqal/IllHtrrEJnYuJIyKXzrfWwWjg200hkYRApss
   WrgLlIyRTGY4IiMvFoAYHQw6Bv0+1SPpMdfhkRA44TYBL8kUdOV91uGOn
   4cEJzuXg27WGZQkdr0ddr7fKMuEuA7SIzhx38K8iLr8pNldtG5yiFSb3/
   KbHco50hUOSN5vQQNxkIqNkyBh/FwIcabzGuOG65iqdnxMBuLibrjj8+b
   H53XXqLZ8YddFmmsHsEHtvVPop82VX4LrOcGlnyumwU0f8axZEgQHcmM0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279384013"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="279384013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:22:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="632215878"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:22:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRYqs-00DLqR-NQ;
        Tue, 08 Mar 2022 14:22:06 +0200
Date:   Tue, 8 Mar 2022 14:22:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YidKbrRq16NV+zNl@smile.fi.intel.com>
References: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
 <Yic6yr6aycu7IHHh@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yic6yr6aycu7IHHh@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:15:22PM +0200, Sakari Ailus wrote:
> Hi Andy,
> 
> This makes secondary handling quite a big nicer, thanks!

You are welcome!

> A few comments below. Apart from that,
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks!

...

> On Mon, Mar 07, 2022 at 10:29:49PM +0200, Andy Shevchenko wrote:

> >  #include <linux/acpi.h>
> >  #include <linux/export.h>
> > +#include <linux/fwnode.h>
> 
> Is this intended? linux/property.h already includes linux/fwnode.h.
> 
> >  #include <linux/kernel.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>

Yeah, this is a bit messy in the headers. I will drop the inclusion,
but in the future it would be good to reshuffle property.h, fwnode.h,
and perhaps extract swnode.h.

...

> >  	bool ret;
> >  
> > +	if (IS_ERR_OR_NULL(fwnode))
> > +		return false;

> > +	if (ret == true)
> 
> It's already bool. I'd instead use:
> 
> 	if (ret)

Right, will amend this.

> > +		return ret;

-- 
With Best Regards,
Andy Shevchenko


