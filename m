Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10004F7CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbiDGKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244186AbiDGKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:23:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187941AB9FE;
        Thu,  7 Apr 2022 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649326902; x=1680862902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=14uR+X8D1hFafUVEmn6fSTwQ5pea2ecTUrj5n9ZrzLQ=;
  b=lSVOjOVSyIDMpxpVb+NikGKkdpG14vXVIfX4V47zzxc/kBUU5Wcdhclo
   HSkg8qNaoGvKy1L5rqgHhETS9JMPxyyTLIpkuIKuAYv0VeZJ7q4sBD57D
   CHsxB5odDR8Y1aD8mljOzV3UKT6FxoocWmnn26mWSclkbeUkTwlBEVDgm
   usqXlO90hwXJdlCXVZ9vxgO0kAyHGlOCVhbQNbbY6oFN09Z/lHghiPbtl
   t+MDrg2h2RYZZk4FQbilPmkv4QeYWt6mVVZ8+sgiNvulivCeed2YB0KIM
   qK1IMAkqOHbV4ct4LZSNwP1GOc77198KEVCBkhl8MqNC4xcKGqNA2NjGi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248809078"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="248809078"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 03:21:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="722903528"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 03:21:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncPEu-000KjM-I7;
        Thu, 07 Apr 2022 13:19:44 +0300
Date:   Thu, 7 Apr 2022 13:19:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v5 1/4] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <Yk66wHWlMg3QLy6u@smile.fi.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
 <df3a78036864716fbeecf3cd94dbcbbe@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3a78036864716fbeecf3cd94dbcbbe@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 08:05:23PM +0200, Michael Walle wrote:

...

> > +	if (IS_ERR_OR_NULL(fwnode))
> > +		return -ENOENT;
> > +
> >  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
> >  				 nargs, index, args);
> > +	if (ret == 0)
> > +		return ret;
> > 
> > -	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
> > -	    !IS_ERR_OR_NULL(fwnode->secondary))
> > -		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
> > -					 prop, nargs_prop, nargs, index, args);
> > +	if (IS_ERR_OR_NULL(fwnode->secondary))
> > +		return -ENOENT;
> 
> Doesn't this mean you overwrite any return code != 0 with -ENOENT?
> Is this intended?

Indeed, it would shadow the error code.
So, it should go with

	if (IS_ERR_OR_NULL(fwnode->secondary))
		return ret;

then.

> In any case:
> Tested-by: Michael Walle <michael@walle.cc>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


