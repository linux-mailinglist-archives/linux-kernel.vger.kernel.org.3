Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA54AC733
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiBGRW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbiBGRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:22:27 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04EBC0401D5;
        Mon,  7 Feb 2022 09:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644254547; x=1675790547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Cowf7J9LryTk5PzMkLkhfkff1e0+oXlLWDASRWsqFs=;
  b=VSEEQJbvPYneVjTIzM5cWHXF6w85fHpjLTEm3S10ZyqGjfKhS3RPNlQo
   ByCluDmG+AzplMMxV2W+fxQlaXk8rms0+5b5io4lQAV8K1z12TKl9M6yf
   aIHyuW+Zd7KAdyiLapuu5m/YIkGqn1pKX0FT3qNTXo9hyTp5LpZSGyXXL
   STpF3Tg5m7lMWQq3EK78+TherR7xBhH9jSz40bRHfr/rNBwWIuZHUrMM1
   blBe4XPV8Sk5IcLn3AopAxkzikFBNH0WWv0pkj4gF+5uQMbIzD+NjGb5G
   wPSz5XLHPHN3rGJ+qyJcOjMYdgD/NXureKNw0YCsES3f94snduwAjpUUC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="309509447"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="309509447"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 09:22:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="484492252"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 09:22:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH7hd-001ybo-I0;
        Mon, 07 Feb 2022 19:21:25 +0200
Date:   Mon, 7 Feb 2022 19:21:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Message-ID: <YgFVFceYQtWq4Hww@smile.fi.intel.com>
References: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
 <fdb3056dcaf9dd113049adebbc3fcd74de2b3028.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdb3056dcaf9dd113049adebbc3fcd74de2b3028.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:37:55AM -0800, Joe Perches wrote:
> On Mon, 2022-02-07 at 12:48 +0200, Andy Shevchenko wrote:
> > In a couple of messages the constants, which have their definitions,
> > are hard coded into the message text. Unhardcode them.
> 
> Found by inspection or tool?

Does it matter? No, a side effect of the following patch.

...

> > +		dev_err(dev, "Steinhart sensors size(%zu) must be %d", new_custom->size,
> > +			LTC2983_CUSTOM_STEINHART_SIZE);
> 
> probably better using "%u" and not "%d"
> 
> and better with a \n termination too.

I think it would be a separate change if we wish so. Let Jonathan to tell what
to do here.

-- 
With Best Regards,
Andy Shevchenko


