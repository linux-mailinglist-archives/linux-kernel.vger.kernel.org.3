Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD75B073F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIGOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIGOll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:41:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBE95E6F;
        Wed,  7 Sep 2022 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662561696; x=1694097696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z9h3cJwwlZiWP6oD1YHdghLTTAjUFezmqOkQ9iG3Wo4=;
  b=Uch9xVj0hiL4w/YqrK8kmFo948zGiuyQ29oDxHxrnXmv6TweHAn8falc
   wIQmZI3VGOX6SMpXsAUxfruzSnGBtyCGyBzK+A5Q2Y6SYek5Rt4jEu+AS
   aEkm+GrFwukuRyuWe95iVDzx07B4dYTZV55MQvFYK5bfLIEKeVxS5stF6
   4FBlE6GgIhewfB1zYPzcU7NRiXbONOBJWX2HFAgdC7H4XRkun3WRBmGbV
   9c11CerJuSY1EZNWuzDi9biueyrDQ5aJ0Z0TjAM1GzP2XkfcASakvEqNc
   6jcNdPvGKgv9HyGX5CVkr5gZyCdSbThC90W9nLu3R+OCjEQS3O1DrkoTU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="323078779"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="323078779"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:41:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="703621083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 07:41:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVwF8-009gdV-1c;
        Wed, 07 Sep 2022 17:41:30 +0300
Date:   Wed, 7 Sep 2022 17:41:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v4 06/21] hwmon: (mr75203) fix multi-channel voltage
 reading
Message-ID: <Yxitmkw4sNx3328k@smile.fi.intel.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-7-farbere@amazon.com>
 <YxdU6hiwblhT2I5u@smile.fi.intel.com>
 <229f0e46-0123-3ffb-d737-0749ffba4e13@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <229f0e46-0123-3ffb-d737-0749ffba4e13@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 08:15:36AM +0300, Farber, Eliav wrote:
> On 9/6/2022 5:10 PM, Andy Shevchenko wrote:
> > On Tue, Sep 06, 2022 at 08:33:41AM +0000, Eliav Farber wrote:

...

> > > +             total_ch = ch_num * vm_num;
> > > +             in_config = devm_kcalloc(dev, total_ch + 1,
> > >                                        sizeof(*in_config), GFP_KERNEL);
> > 
> > Strictly speaking this should be `size_add(size_mul(...) ...)`
> > construction
> > from overflow.h.
> > 
> >                total_ch = size_mul(ch_num, vm_num);
> >                in_config = devm_kcalloc(dev, size_add(total_ch, 1),
> >                                         sizeof(*in_config), GFP_KERNEL);
> > 
> > Alternatively before doing all these, add a check
> > 
> >                if (array3_size(ch_num, vm_num, sizeof(*in_config)) <
> > SIZE_MAX - sizeof(*in_config))
> >                        return -EOVERFLOW;
> > 
> > But this is a bit monstrous. Seems like the above looks and feels better.
> > 
> > Also for backporting purposes perhaps it's fine to do without using
> > those macro
> > helpers.
> According to the driver code total_ch is a u32 variable while vm_num
> and ch_num are both limited to a value of 31:
> 
> #define VM_NUM_MSK GENMASK(20, 16)
> #define VM_NUM_SFT 16
> #define CH_NUM_MSK GENMASK(31, 24)
> #define CH_NUM_SFT 24
> 
> In addition the PVT Controller Series 3+ Specification mentions that
> the actual maximum values are even smaller – 8 for vm_num and 16 for
> ch_num.
> Therefore we are very far from a scenario of an overflow.
> Do you still think overflow protection in necessary?

Like I said "Strictly..." Means it's up to you, but allocations are
usually be protected against the overflows.

-- 
With Best Regards,
Andy Shevchenko


