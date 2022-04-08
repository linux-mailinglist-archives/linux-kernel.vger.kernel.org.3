Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042AF4F9613
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiDHMtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiDHMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:49:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B2EE4F5;
        Fri,  8 Apr 2022 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649422068; x=1680958068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GieTI1WB4H2GA1M0xA2lOtUkaNXzhrdcKPpmxIylHsc=;
  b=iOkPcVNZmtIITC2baZk5TmkHUabZrFr+kd84u5Xir98KB8oHlJhmWGnF
   jDMpa7ZhrPnUFj+PhmaaSq2Yu5P7flQBcN7LywS/hv4EUgcKoh/U5SKHx
   chh3qbZVtmgIdsShhCPlAZeC4paomStfa4c52eH5FgNeXuX2f9BNwwYcD
   bhzYd+53vSkGDCBaEFKlJMSBtuKeHBetMeuETu0ySFBlkrmxBU5j70esu
   yh+PLBGUvUMlX8SEc6VPsiVE1DY6P2kTIbGag4/sYws0ULPQGhsLmFfFl
   XJTbeGywshSpF0cgVIIbsWHAVVKu7VhHNhDnFX6wiVTwMQRegKqfsQKQp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="260418310"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260418310"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:47:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525364161"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:47:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncny7-000Hsh-SI;
        Fri, 08 Apr 2022 15:44:03 +0300
Date:   Fri, 8 Apr 2022 15:44:03 +0300
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
Message-ID: <YlAuEzW0fUuuXTN6@smile.fi.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
 <df3a78036864716fbeecf3cd94dbcbbe@walle.cc>
 <Yk66wHWlMg3QLy6u@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk66wHWlMg3QLy6u@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 01:19:44PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 06, 2022 at 08:05:23PM +0200, Michael Walle wrote:

...

> > > +	if (IS_ERR_OR_NULL(fwnode))
> > > +		return -ENOENT;
> > > +
> > >  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
> > >  				 nargs, index, args);
> > > +	if (ret == 0)
> > > +		return ret;
> > > 
> > > -	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
> > > -	    !IS_ERR_OR_NULL(fwnode->secondary))
> > > -		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
> > > -					 prop, nargs_prop, nargs, index, args);
> > > +	if (IS_ERR_OR_NULL(fwnode->secondary))
> > > +		return -ENOENT;
> > 
> > Doesn't this mean you overwrite any return code != 0 with -ENOENT?
> > Is this intended?
> 
> Indeed, it would shadow the error code.

I was thinking more on this and am not sure about the best approach here.
On one hand in the original code this returns the actual error code from
the call against primary fwnode. But it can be at least -ENOENT or -EINVAL.

But when we check the secondary fwnode we want to have understanding that it's
secondary fwnode which has not been found, but this requires to have a good
distinguishing between error codes from the callback.

That said, the error codes convention of ->get_reference_args() simply
sucks. Sakari, do you have it on your TODO to fix this mess out, if it's
even feasible?

To be on safest side, I will change as suggested in previous mail (see below)
so it won't have impact on -EINVAL case.

> So, it should go with
> 
> 	if (IS_ERR_OR_NULL(fwnode->secondary))
> 		return ret;
> 
> then.

-- 
With Best Regards,
Andy Shevchenko


