Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE474F96A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiDHN3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiDHN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:29:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14BAE;
        Fri,  8 Apr 2022 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649424451; x=1680960451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/HA1QiQ6H5p+tsSS3FpYA6QqwmIqKeG4+bzRgPHZynE=;
  b=QYfpu9yS0XGLYL+fF8SKmi+aEsYeSSmYuC0cDcvSobmjJfxj2y2E6Dji
   ggiP8IbPXlwHjGXW9nAvMqCZSsn+WtTp/pg52y+aog/Y153dIJ12Tz4IE
   1Qcgay6SF4dtyEaHXTTZsQsgn8LNw/sJYu0fMocHpSw9cOmLqPhQ1J5Pb
   X3g3UrF8XddXCNLju+ieI0nD1QJNyMarG722i/q7XLZxIXjoJlnPCiqH7
   ZbUfRMpCdKj2+3HTEfTHvNPkvumMJJp7Q1aDWiFTadPbdh+tDBC3Qhx6s
   X07CCJuTvKO/3NLxMIfrCgGmHkUhMni1hDpy+WFYwwD5xXDBhOn4AXimb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243724447"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="243724447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:27:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571487565"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:27:28 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 8EE0E201C0;
        Fri,  8 Apr 2022 16:27:26 +0300 (EEST)
Date:   Fri, 8 Apr 2022 16:27:26 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Walle <michael@walle.cc>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v5 1/4] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YlA4Pp11ZXG3eSX/@paasikivi.fi.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
 <df3a78036864716fbeecf3cd94dbcbbe@walle.cc>
 <Yk66wHWlMg3QLy6u@smile.fi.intel.com>
 <YlAuEzW0fUuuXTN6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlAuEzW0fUuuXTN6@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Apr 08, 2022 at 03:44:03PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 07, 2022 at 01:19:44PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 06, 2022 at 08:05:23PM +0200, Michael Walle wrote:
> 
> ...
> 
> > > > +	if (IS_ERR_OR_NULL(fwnode))
> > > > +		return -ENOENT;
> > > > +
> > > >  	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
> > > >  				 nargs, index, args);
> > > > +	if (ret == 0)
> > > > +		return ret;
> > > > 
> > > > -	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
> > > > -	    !IS_ERR_OR_NULL(fwnode->secondary))
> > > > -		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
> > > > -					 prop, nargs_prop, nargs, index, args);
> > > > +	if (IS_ERR_OR_NULL(fwnode->secondary))
> > > > +		return -ENOENT;
> > > 
> > > Doesn't this mean you overwrite any return code != 0 with -ENOENT?
> > > Is this intended?
> > 
> > Indeed, it would shadow the error code.
> 
> I was thinking more on this and am not sure about the best approach here.
> On one hand in the original code this returns the actual error code from
> the call against primary fwnode. But it can be at least -ENOENT or -EINVAL.
> 
> But when we check the secondary fwnode we want to have understanding that it's
> secondary fwnode which has not been found, but this requires to have a good
> distinguishing between error codes from the callback.
> 
> That said, the error codes convention of ->get_reference_args() simply
> sucks. Sakari, do you have it on your TODO to fix this mess out, if it's
> even feasible?

What would you expect to see compared to what it is now?

I guess the error code could be different for a missing property and a
property with invalid data, but I'm not sure any caller would be interested
in that.

> 
> To be on safest side, I will change as suggested in previous mail (see below)
> so it won't have impact on -EINVAL case.
> 
> > So, it should go with
> > 
> > 	if (IS_ERR_OR_NULL(fwnode->secondary))
> > 		return ret;
> > 
> > then.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Sakari Ailus
