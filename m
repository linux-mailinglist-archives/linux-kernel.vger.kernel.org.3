Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A1C5AB449
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiIBOwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiIBOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6B260;
        Fri,  2 Sep 2022 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662128109; x=1693664109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c6y+jVROuQJauil5q7w8LAFf1FLBa2IkXRbAj2IPLiE=;
  b=c9KAZNsf/IbNGUQxTcwnA6fwrdxzdR9wgA63FwTRTFFF+v7FLaTDVXTk
   GRPBuwx2DSGR8inX+S3XnIlXg7n4lSaUGS5qljTzBeEzSaxDNlHtJnl1S
   Q4zYOFwe6bkGG47gezp+tfkcIrQMeYF7Ct/idIJRyjbR1uWj9Hip7jZ//
   XtIaT2J3rMrQI+a/PVgSeos8wcKQU/S8Ll3jU6JJpfTJyduVgpCIs6W8x
   +2W7tqUplYrsihU3NPMPaqLoycGqIl9/H3OEUtlJFdvFpvHd6jVDUFSXM
   G9Gc9BlmAdrGMJDdft23LpFSUCV5UgIL/8p2C7sbgxak129mqGvNq3qT1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294727926"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="294727926"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:15:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="755273094"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:15:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oU7Rl-007Q5R-1P;
        Fri, 02 Sep 2022 17:15:01 +0300
Date:   Fri, 2 Sep 2022 17:15:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel, vm-map" not defined
Message-ID: <YxIP5aZv16WFPC4P@smile.fi.intel.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
 <Yw8sHt0WLsEpL4bY@smile.fi.intel.com>
 <30729f4c-895f-235a-3342-93669160201c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30729f4c-895f-235a-3342-93669160201c@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:08:41PM +0300, Farber, Eliav wrote:
> On 8/31/2022 12:38 PM, Andy Shevchenko wrote:
> > On Tue, Aug 30, 2022 at 07:21:55PM +0000, Eliav Farber wrote:
> > > Bug fix - in case "intel,vm-map" is missing in device-tree ,'num' is set
> > > to 0, and no voltage channel infos are allocated.
> > 
> > Care to provide a Fixes tag for all fixes in your series. Also don't
> > forget to
> > start series with fixes followed by cleanups and new features..
> For v4 I provided a Fixes tag where it was relevant.

Thanks!

> I also changed the order of some patches so that all fixes will be first.

Note, fixes should prepend the other patches in the series.

-- 
With Best Regards,
Andy Shevchenko


