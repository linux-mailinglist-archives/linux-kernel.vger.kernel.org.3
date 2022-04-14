Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5A500E65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbiDNNO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiDNNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:14:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1550F8BF34;
        Thu, 14 Apr 2022 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649941917; x=1681477917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Rth1ilqw2lJonZwF4fGONQs8He2Eo1fqnNtw84ypeRs=;
  b=ewUeJPKCCjgSD5GbulMpZP/kVkHKlnp0LkRjTzr/eYH2nSOxkcvaretp
   wVfnEDrsFHWTLxNJOjrxDnHRgTaYNUrd3jMP+hOOqTR7pVvnfQP8OO7fm
   O4joANIZ1g2ACqLpWjxwQORi6N+UJDy803ZY+oCfuv8DZeTpFhw1E2ujn
   iXuYmdznYbYYq98P/G7Es8NRgW4PG92tygceOVVaafb902XkbopgV0JFB
   VVMWAblmWrgBKm1iv29QnjC75gzf83+7IH3bjY2ZmqemmfRPOdHGnQP+2
   2UO9sOmd3moJOesVTgJmt93Jam49+BIxftakCajoEYCVr8QyLeMOYEK3O
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323369780"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="323369780"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:11:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="645618549"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:11:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nezGJ-002KN7-RN;
        Thu, 14 Apr 2022 16:11:51 +0300
Date:   Thu, 14 Apr 2022 16:11:51 +0300
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
Message-ID: <Ylgdl67AtvDOUpFd@smile.fi.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
 <20220413144124.72537-3-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB67865D24BB7546CAF805D7BE99EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YlcBMGkdmGTq/mnr@smile.fi.intel.com>
 <03fa4823b820b3eb2499a002a7570e79641b4a78.camel@gmail.com>
 <YlgYKu6t8BIdVW9Y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlgYKu6t8BIdVW9Y@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:48:42PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 14, 2022 at 09:07:29AM +0200, Nuno Sá wrote:
> > On Wed, 2022-04-13 at 19:58 +0300, Andy Shevchenko wrote:

...

> > (But I still think the commit message is a bit misleading)
> 
> Yes, the commit message can be amended. I won't split these two since
> the fix part is not critical (nobody so far complained aloud about it).
> That's why I prefer to set the main point of the change as switching to
> devm_clk_get_optional() than deferred probe messages.

That said, I will amend it for v2.
Thank you for review!

-- 
With Best Regards,
Andy Shevchenko


