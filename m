Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4E500E15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiDNMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiDNMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:51:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F891561;
        Thu, 14 Apr 2022 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649940527; x=1681476527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SgLVRDBqczKO7rzZuzFIJrMMz6BRkjMeSLeIPTgHVFI=;
  b=Ze+XFFFiVeBZgTMTzdzgpqON6CzpzZ7z6CGcXKOrlZR2lC10dJwJ9k9P
   ZWNdpaX+ioM0tgvkfXmcLLzccmnuhYVnR+ZEeXAdhc9Ewlg/9EGW6JilL
   9HSlgyteiUI7mGmproeryuRnCklyJsrIwPkKzg3+c82QC64KzfqP/wFeV
   DaW8LzhUMrEjTvcPMwBg4NhjiK9m5/2eqwf6rWoY5Nx6IOPELB5Hoe7Fd
   lpt9Jhff4Oarad1cnFCx88DnzeQ4ItOPz6pSSCGxCmFnukUO853riphrX
   R2eKEy4BTnXXvzXpSseQgYybU5P55wnmLcgLrauuewK+BQFf6N3Um8cMk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262364871"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="262364871"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:48:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="655998175"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:48:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1neytu-002Jwx-Lt;
        Thu, 14 Apr 2022 15:48:42 +0300
Date:   Thu, 14 Apr 2022 15:48:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 3/3] iio: imu: adis16480: Fix getting the optional
 clocks
Message-ID: <YlgYKu6t8BIdVW9Y@smile.fi.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
 <20220413144124.72537-3-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB67865D24BB7546CAF805D7BE99EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YlcBMGkdmGTq/mnr@smile.fi.intel.com>
 <03fa4823b820b3eb2499a002a7570e79641b4a78.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03fa4823b820b3eb2499a002a7570e79641b4a78.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 09:07:29AM +0200, Nuno Sá wrote:
> On Wed, 2022-04-13 at 19:58 +0300, Andy Shevchenko wrote:
> > On Wed, Apr 13, 2022 at 03:38:47PM +0000, Sa, Nuno wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Wednesday, April 13, 2022 4:41 PM
> > 
> > > > The extended clocks are optional and may not be present for some
> > > > SoCs
> > > > supported by this driver. Nevertheless, in case the clock is
> > > > provided
> > > > but some error happens during its getting, that error should be
> > > > handled
> > > > properly. Use devm_clk_get_optional() API for that. Also report
> > > > possible
> > > > errors using dev_err_probe() to handle properly -EPROBE_DEFER
> > > > error.
> > 
> > > This is a nice cleanup patch... But the subject might be a bit
> > > misleading as it says "Fix". So I would expect a Fixes tag which
> > > I'm not sure it's really worth it here. Yes, the code was pretty
> > > much
> > > doing clk_get_optional() "by hand" but I think it was still
> > > functional.
> > > So to me, this is more an improvement rather than a fix...
> > 
> > Actually it is a fix, but not critical since no-one complains aloud
> > so far.
> > The problematic part is logs exhausting if repetitive deferred probe
> > happens.
> 
> Still not really agree with it... In the commit message you state that
> errors are not properly handled and so let's use
> 'devm_clk_get_optional()'. I don't think that is true because If im not
> missing nothing there's no fundamental change between the previous code
> and using 'devm_clk_get_optional()'. So to me this is an enhancement
> because we were doing something "by hand" when we have an API for it.
> 
> That said, introducing dev_err_probe() indeed stops possibly annoying
> error messages for EPROBE_DEFER (and that could be seen as a fix, not
> really devm_clk_get_optional()). I honestly still don't see it as fix
> but we are also not adding a Fixes tag so I don't really care :).
> 
> (But I still think the commit message is a bit misleading)

Yes, the commit message can be amended. I won't split these two since
the fix part is not critical (nobody so far complained aloud about it).
That's why I prefer to set the main point of the change as switching to
devm_clk_get_optional() than deferred probe messages.

-- 
With Best Regards,
Andy Shevchenko


