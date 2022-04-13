Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9B4FFBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiDMRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDMRE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:04:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C7396AB;
        Wed, 13 Apr 2022 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649869326; x=1681405326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Il36FEwbXetKsbGfnwONK2IyZ0R2zJKhtZ0T5GseMSU=;
  b=AC/6fRsTrbM2tSxhG8QDvApWYskNPsk23M6BY3Vc2J9R07rs5H/K4Eti
   V7/yC6O50rShTJvSjJmD+MH9saCgVkgWriYT03OigernDh0J1thxsYesu
   2tr6ep8PA+qTOcX2wX3Gcn+4dS/iUC+/7hnbzUxwzC2sn77UJeXl4vneb
   D4J5xhksMIL7pUoG85GcVjw2cRY7FeHlhyRlX/vGFTRHKKqwknESzJz28
   RIxlu3b9erfHi5BvJyeaTS4R+GBrjxagoVCx3sYQ3OSoMorzzZIgu35JS
   kBRDa9elrg/HqOIh+3Via+IYN/ezbaxDafgbP7QwP4vmC6KtD5ge1aNpG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="242655962"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="242655962"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:02:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="552284265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:02:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1negK0-001w5g-Rk;
        Wed, 13 Apr 2022 19:58:24 +0300
Date:   Wed, 13 Apr 2022 19:58:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 3/3] iio: imu: adis16480: Fix getting the optional
 clocks
Message-ID: <YlcBMGkdmGTq/mnr@smile.fi.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
 <20220413144124.72537-3-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB67865D24BB7546CAF805D7BE99EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB67865D24BB7546CAF805D7BE99EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:38:47PM +0000, Sa, Nuno wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, April 13, 2022 4:41 PM

> > The extended clocks are optional and may not be present for some
> > SoCs
> > supported by this driver. Nevertheless, in case the clock is provided
> > but some error happens during its getting, that error should be
> > handled
> > properly. Use devm_clk_get_optional() API for that. Also report
> > possible
> > errors using dev_err_probe() to handle properly -EPROBE_DEFER
> > error.

> This is a nice cleanup patch... But the subject might be a bit
> misleading as it says "Fix". So I would expect a Fixes tag which
> I'm not sure it's really worth it here. Yes, the code was pretty much
> doing clk_get_optional() "by hand" but I think it was still functional.
> So to me, this is more an improvement rather than a fix...

Actually it is a fix, but not critical since no-one complains aloud so far.
The problematic part is logs exhausting if repetitive deferred probe happens.

> Anyways,
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


