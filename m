Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06353EBFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiFFKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiFFKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:14:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393A14916F;
        Mon,  6 Jun 2022 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654510268; x=1686046268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZSzdjIX2BvSWabQuJE5Re9N3GWxjm5jrXSz5gYEGxg=;
  b=Zwfyzh/T/yhXsyFOn6JB9NXLQAywJF5oZTITpCrfr5si3w5SVjoutPAV
   omgXqm4l90KZw+Xe6lmeVD10up3AbTIe11Md8X12TfFztxVjC3rcW4tkc
   cF2jaM2JoTf6DaNsZvextQiahkVJZhDQxycpPHr5nOH/m0XM9Si56Z25v
   9W//CnTf2jhkwxJ2WdjfsU8DOwIPtfkunne8l0tUi1M+HpBlyKM5G//BK
   EolscztBam/3HOK2RTOy2DozprCku7RQ0w6f1/kfF/a4xRb9L66zhLM8n
   S3LFiwwrU9YsSCyHG/ZsrnVbKwIyO97dQUAFYs3k49BQxAmRR2O0iQBCH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276877483"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276877483"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:10:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="722737822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:10:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ny9h7-000UXR-Gu;
        Mon, 06 Jun 2022 13:10:45 +0300
Date:   Mon, 6 Jun 2022 13:10:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [RFC PATCH v3 6/6] iio: adc: meson_saradc: Use
 regmap_read_poll_timeout() for busy wait
Message-ID: <Yp3SpRIUFBBbNOQn@smile.fi.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
 <20220603100004.70336-6-andriy.shevchenko@linux.intel.com>
 <CAFBinCD1cn19uf0pyUF-Af7_thP81Ehih+X4F9+rO8tzeUm+Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCD1cn19uf0pyUF-Af7_thP81Ehih+X4F9+rO8tzeUm+Ow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 11:59:53PM +0200, Martin Blumenstingl wrote:
> On Fri, Jun 3, 2022 at 12:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Simplify busy wait stages by using regmap_read_poll_timeout().
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> > v3: new patch, but RFC, not always the read_poll_timeout() can be used, would
> >     be nice to have it tested.
> and also:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # GXM VIM2

Thanks for testing!

-- 
With Best Regards,
Andy Shevchenko


