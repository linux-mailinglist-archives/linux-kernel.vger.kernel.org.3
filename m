Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829664AAB06
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380999AbiBESqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:46:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:60901 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239028AbiBESqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644086763; x=1675622763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJyhXHdlSmLbpIh8XLE/wYlidLOXJRLVWt/xTeQrWio=;
  b=Kbf29i9J0c7K3HZO82x50+Js8sh7S6KzkykT4JyfVvtLi7ZB9TCsWYXI
   v71+TtAG6Q+kQfxe3MOn1YOeM3RcS7O/Fw51UmB8+JcdGJqx/zccnpO9W
   STnZYTPnbQunLkWDXk/h5hoPqPf0SKvGvIMCK/yYUOkxir1gAi24Nr13D
   pxQ1irXBhxMY2PrBp9FOi1IJxVGI4cMBoQBTFE5dBUlwv7i128pJOdruC
   xmUd8KCuBLJS20p6jsicQGX3Re+S7pYg71wRFjklE9lvB4uRcAArNXu97
   st5M/QLgA0wNCpwGvKlH03vjPyq3+Nbfcq2gFObhdMiX3YXUYXtDu/4hr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="273040915"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="273040915"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:46:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="524665214"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:46:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nGQ3R-001Ley-My;
        Sat, 05 Feb 2022 20:45:01 +0200
Date:   Sat, 5 Feb 2022 20:45:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/3] iio: imu: inv_mpu6050: Drop wrong use of
 ACPI_PTR()
Message-ID: <Yf7FrU3z7jgyv04f@smile.fi.intel.com>
References: <20220203155920.18586-1-andriy.shevchenko@linux.intel.com>
 <20220205164535.763feeea@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205164535.763feeea@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 04:45:35PM +0000, Jonathan Cameron wrote:
> On Thu,  3 Feb 2022 17:59:18 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > ACPI_PTR() is more harmful than helpful. For example, in this case
> > if CONFIG_ACPI=n, the ID table left unused which is not what we want.
> > 
> > Instead of adding ifdeffery or attribute here and there, drop ACPI_PTR().
> > 
> > Fixes: 3b3870646642 ("iio: imu: inv_mpu6050: Mark acpi match table as maybe unused")
> > Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hi Andy,
> 
> Whilst I fully support tidying this up, what is 'fixing' as such?
> Will get rid of an unused warning for the spi case but that sort
> of things doesn't always get fixes tags.

True, however I can find a handful examples when this kind of patches were backported.

> They tend to result
> in backports and I wouldn't think it was worth backporting this
> unless I'm missing something...

It's not critical, so can you drop the tags when applying, if you think that's
okay?

-- 
With Best Regards,
Andy Shevchenko


