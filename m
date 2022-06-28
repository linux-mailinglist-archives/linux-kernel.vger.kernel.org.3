Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9D55F0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiF1WBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF1WA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:00:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736472251A;
        Tue, 28 Jun 2022 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656453658; x=1687989658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VyNhPycHnj1hw+SAQsHLxaZt3LLJYpzQwob4bA5V5ck=;
  b=C+2y5r1/RgRPKsaLuG4Dl8Y0+WVZhw9c/PDtaGTJ69Gvu/Hv7WFNu6sA
   IwsGW+/1FIi/mksslNY+w8MciNqbV+0rtZJuZrvojfRcuX51Nsx/czoz9
   xeMV0rG+wviu3/HHeHkAI+Gi4KQYJce1NMXO19SlmdZzcm9a0kBSApqIN
   nub9/lqyWwZ9hfRqOSlayn9+RJat6vOc8S9vnXyM0ROe3mU6XH8XVq9UY
   pD4dff1PGTAHz3jIo6eXGwRzBkgkjUNc7pksRa5gkMSCDTxzBm7pvKxaL
   gem1/SHTmSZXiNdPpzOMzCgyHWnfggxfAHCSU2oFCRdH9UazDiFAYXEXQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281893507"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="281893507"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:00:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="680223763"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:00:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6JGP-000xC3-Iy;
        Wed, 29 Jun 2022 01:00:53 +0300
Date:   Wed, 29 Jun 2022 01:00:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] iio: proximity: sx_common: Don't use IIO device
 for properties
Message-ID: <Yrt6FVHilUuoPrnL@smile.fi.intel.com>
References: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:47:45PM +0300, Andy Shevchenko wrote:
> It's not correct to use artificial device created by IIO core to
> retrieve device properties. Even ->get_default_reg() callback
> takes a simple struct device pointer which suggests it wants to
> operate on the real device.
> 
> Correct this by replacing pointer to IIO device by a real device
> pointer in the caller of ->get_default_reg().

Gwendal, any comments on this version?

-- 
With Best Regards,
Andy Shevchenko


