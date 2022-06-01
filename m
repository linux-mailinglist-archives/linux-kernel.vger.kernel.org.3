Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2653A296
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352055AbiFAKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350236AbiFAKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:30:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE56E56769;
        Wed,  1 Jun 2022 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654079437; x=1685615437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qD5rv9i5Du7irA/swnuN3jwbdILA1dofh7zhQ5sAHp8=;
  b=PNGe5sU+fW4qZsgPwB/w23r//14zsGfqk8+hpkCgle3R5aoUkE0VXTCK
   yD75S09mgRDw9gKrqYDNo/zBQUe+5mfksnJoUVz+ZjZ2UwdgTRi2za/Fd
   Xu5SfDsuDs1qOaKD0KR2B3t3I2cw7RAddSkX3CnqJxdITZoiQDEGd9r4X
   76Xn5Itj+8dnTwAg0ax4/fGej44TggPYScBQalJxS9LgcJzlitRW1nVGg
   glnGUkw4lxt8noUUyQbAAPWm9xVssZjDl0UVVFLa5mRwDWatjpiunqpoz
   Ti3/YycWYyaBPyjLzkZsz+SMZUrm+AxIfHJtT20GA0NsIg+Ubr/njmddP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361917350"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="361917350"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:30:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="530002767"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:30:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwLcV-000QYP-MW;
        Wed, 01 Jun 2022 13:30:31 +0300
Date:   Wed, 1 Jun 2022 13:30:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v1 3/3] iio: adc: meson_saradc: Use temporary variable
 for struct device
Message-ID: <Ypc/x2G+jgHvBjLY@smile.fi.intel.com>
References: <20220531211842.71998-1-andriy.shevchenko@linux.intel.com>
 <20220531211842.71998-3-andriy.shevchenko@linux.intel.com>
 <CAFBinCDf4UfEPFV4_Qf3m16DE-NzNUk_ZVcHZhgxVvn_pokdgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCDf4UfEPFV4_Qf3m16DE-NzNUk_ZVcHZhgxVvn_pokdgw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 11:47:50PM +0200, Martin Blumenstingl wrote:
> On Tue, May 31, 2022 at 11:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> [...]
> > @@ -650,11 +648,12 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
> >                                   void __iomem *base)
> >  {
> >         struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> > +       struct device *idev = &indio_dev->dev;
> > +       struct device *dev = dev->parent;
> It looks like this should read:
>     struct device *dev = idev->parent;

Oops, indeed.

> That said, I think this kind of typo is very easy with the current
> naming schema.
> It's been a while since I looked at other drivers but maybe the IIO
> maintainers have some recommendations for us (which would apply to
> multiple IIO drivers, not just meson_saradc).
> For example: I am not sure if iio_{err,warn} functions (which take a
> struct iio_dev pointer) have been proposed/discussed before. I think
> they could be useful for other drivers as well.

Looking deeper into this example, I think the IIO dev usage might be wrong
in the first place, but since there are managed resources attached, I dunno
if it's the way to go. Let's wait for maintainers to chime in.


-- 
With Best Regards,
Andy Shevchenko


