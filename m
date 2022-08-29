Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91B75A5474
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiH2TXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiH2TXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:23:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B2587094;
        Mon, 29 Aug 2022 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661800988; x=1693336988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eq6QU+bV4AEJdkrAkD7NtxB2iucXOSQ9z1L/6a5MV/8=;
  b=dWzPdzMr2IQbc9+RANW8VHOOrkJzMCKWor6c/oeMKmYN6tfVl88F3nKB
   MGAAUXqhbfpc/M7sknf/+rimOhk2vVUQyy4kwxfHEdzSHpIhzMejWyAs0
   kOGEMy3QZWYelbLwGHxhMMXJTInYioGh1uOj6ie9Nrf3IKMW8k5hbKXIC
   xA0NOKILZgLieZ1gHHZ2sgMDxfUZNVKJnJ0i471JYl6+6Vh7GnB4G0Xjh
   vdGJPHphrJ5THl3RFNzaZhq/RJr5qHGWnCn3ze5DEUp4AWaSfL111s/Kh
   TVHvR4QXudHdXvg++aV9VyVvUuMrk0TtSgxE6Q6iccfwEoZIOpkubw9m4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381278641"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="381278641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 12:23:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="753743366"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 12:23:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oSkLe-005emK-3C;
        Mon, 29 Aug 2022 22:23:02 +0300
Date:   Mon, 29 Aug 2022 22:23:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/4] iio: magnetometer: yamaha-yas530: Use pointers as
 driver data
Message-ID: <Yw0SFjnUwcjs/DDE@smile.fi.intel.com>
References: <20220829112407.74917-1-andriy.shevchenko@linux.intel.com>
 <20220829180022.18dac46a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829180022.18dac46a@jic23-huawei>
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

On Mon, Aug 29, 2022 at 06:00:22PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Aug 2022 14:24:04 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > -	yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];
> > -	ci = yas5xx->chip_info;
> > +	ci = device_get_match_data(dev);
> > +	yas5xx->chip_info = ci;
> 
> Am I missing a path by which device_get_match_data() can use the i2c_device_id values?
> I'd expect to see a fallback to that if ci == NULL to cover the non firmware causes
> of probe().  I've seen a few patches without that fallback path recently so wondering
> if some magic has gotten hooked up and I've missed it (something to push that via
> a swnode perhaps?)

No, there is no such magic behind. The idea is that we use DT / ACPI overlays when
device needs to be established. But I have got your point.


-- 
With Best Regards,
Andy Shevchenko


