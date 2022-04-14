Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D45019B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiDNRNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbiDNRMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:12:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DE5DBD1A;
        Thu, 14 Apr 2022 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649955845; x=1681491845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lZrj1oBd0y7HooWyS6SxzdEPNlLGWptWv5QdmhowQ7U=;
  b=P+sfm98fWQch04JOMmWud8dkMiXG9hQGmuAIM2/Gl8JqfdU221tun8Bo
   slphqmLF8jSDK2ZOWKF0UrXwc0C1/m+mld7OsZn6LzEp6N4UMJHytM1Ii
   RXzuGa/07mG4bjuF8cpW3GdATSMBwnSRQKhFw/LZ0Hv1sgTbQ9c7lHXuF
   6JAgq1/7U5iL3PeLw7dS56Qs1MI/PYASdM2MCTvGSDzFksRLov8jkVy49
   V8VT2GlqfpM1doiYLXy8OTAlMyrYJaa4kSDEaZEwLSA4NrwCigdgKlSl6
   i4w8K5ntfvgxYGzotxfVP+XDdqovChjbvbiKBu4cFaneV8IJNIt3rVqIp
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="244865045"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="244865045"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:04:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="560269969"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 10:04:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nf2sy-002PZi-1C;
        Thu, 14 Apr 2022 20:04:00 +0300
Date:   Thu, 14 Apr 2022 20:03:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: afe: rescale: Make use of device properties
Message-ID: <YlhT/yiJSD7pFsF8@smile.fi.intel.com>
References: <20220413190117.29814-1-andriy.shevchenko@linux.intel.com>
 <Ylgwhu9zdmwwYnAq@shaak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylgwhu9zdmwwYnAq@shaak>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:32:38AM -0400, Liam Beguin wrote:
> Hi Andy,
> 
> On Wed, Apr 13, 2022 at 10:01:17PM +0300, Andy Shevchenko wrote:
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.

> > +#include <linux/mod_devicetable.h>
> 
> Is this really needed?

Yes.
This header is missed. I can split its addition to a separate patch.

> device_get_match_data() is already defined in <linux/property.h>

It's indirectly related (just like we do when we clean up of.h). Since
the original of.h is missed there is no header replacement, just adding.

-- 
With Best Regards,
Andy Shevchenko


