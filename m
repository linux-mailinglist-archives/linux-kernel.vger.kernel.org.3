Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C4056487C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiGCPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:45:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F8638B;
        Sun,  3 Jul 2022 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656863150; x=1688399150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=apgC17l+bElvtDW+BBq+d+ubtn4llDYJ+AzNexCs37g=;
  b=QObx8YSueTogzI4P9A/mvO4gHCiHYcGnVK5tL4kw1ab3k0zok8sk5AFr
   sd222SY0+P/tqIi1hYyeGI8HMExWvFWohJ1wrP8BhgFqh5kr6ww8gEdEx
   3QLuljcSwRHl1jCAV6NhI47CPi1Waw+UgeIpXnBtpFmN6SSqvDGfj1LK9
   asRmZnp5ktnEThDfFp/PZW8lckEONwRic0G+QJ/6RKE9oee7qjJue9vqS
   ZWdayFlbtylBd9zyX8x1i6mB5tE59jBqOR58yv3octnroiz79N4m23bGD
   Gwv6V8bkr37arsOpiwvxCPppCYVB/4dFO+T+lrYtz8t7ynHrCcC+0vWaK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="263362707"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="263362707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 08:45:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="542258697"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 08:45:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o81n7-0014R5-0X;
        Sun, 03 Jul 2022 18:45:45 +0300
Date:   Sun, 3 Jul 2022 18:45:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] iio: proximity: sx_common: Allow IIO core to take
 care of firmware node
Message-ID: <YsG5qCQMXKHm3DWm@smile.fi.intel.com>
References: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
 <20220615114746.2767-2-andriy.shevchenko@linux.intel.com>
 <CAPUE2use-nt7LRQ0g_L7EW7wWfPQ-c7LinRoyx_WeMzLfdWOag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUE2use-nt7LRQ0g_L7EW7wWfPQ-c7LinRoyx_WeMzLfdWOag@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 10:07:40AM -0700, Gwendal Grignou wrote:
> On Wed, Jun 15, 2022 at 4:47 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > IIO core correctly will take care of firmware node if it's not set in
> > the driver. Drop ACPI and OF specifics from the driver and allow IIO
> > core to handle this.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

Thanks!

Jonathan, I guess we are ready with this series. What do you think?

-- 
With Best Regards,
Andy Shevchenko


