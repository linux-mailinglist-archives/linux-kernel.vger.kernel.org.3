Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E7489F88
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiAJStG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:49:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:44428 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241634AbiAJStF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641840545; x=1673376545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kJR2yg22myL6ML4Xc2QvmpKpufnRhYemZbmvBGy7u/I=;
  b=S8hOiLfgIDed14fY6I+n62Dpq2xdsXdHnEs2xsj1Fy/YEYwnNH8RTr2K
   cGGMx8b+7AqtHI5VbLasGJoH8WRDTcgV0t/dCMb5Ve+51PyXGdJB1LsNu
   ntcwNrDe0QKK1EJD31lL1wZasATSvuHqnv8cGTWl40qUuL0bIC8quEboq
   BATWgtmssdsWPr1k4kxlWrdgODWcbz/KOkdTG3l2jEvqrSVKlSnXVjZJn
   o9Y8EJF8ZwHLQS8ZjQvu2fEZPIDGAUugNAHv3b8W+v6NLfPQVKwped1oP
   B7K4+2r/ahjirfMdtwoFOlhlPlBphe9dHlSvKQnmqdnA3DiXYplf+M8bg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="223993243"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="223993243"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:48:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="558079445"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:48:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n6zhZ-008z3k-PR;
        Mon, 10 Jan 2022 20:47:29 +0200
Date:   Mon, 10 Jan 2022 20:47:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: st_sensors: don't always auto-enable I2C and SPI
 interface drivers
Message-ID: <Ydx/Qam3mCl416JP@smile.fi.intel.com>
References: <20220110152432.3799227-1-nikita.yoush@cogentembedded.com>
 <YdxWZEz1GXXxQ+7h@smile.fi.intel.com>
 <0f7d5c44-2119-97ba-5a3e-7f0f40d41605@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7d5c44-2119-97ba-5a3e-7f0f40d41605@cogentembedded.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 08:04:35PM +0300, Nikita Yushchenko wrote:
> 10.01.2022 18:53, Andy Shevchenko wrote:
> > On Mon, Jan 10, 2022 at 06:24:32PM +0300, Nikita Yushchenko wrote:

...

> > The same question as per v2.
> > 
> > > +	default I2C && IIO_ST_ACCEL_3AXIS
> > 
> > What will be the results when I2C=y and the second ones =m?
> 
> $ grep CONFIG_I2C= .config
> CONFIG_I2C=y
> $ grep IIO_ST_ACCEL .config
> CONFIG_IIO_ST_ACCEL_3AXIS=m
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
> # CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set
> 
> $ vim .config
> <remove CONFIG_IIO_ST_ACCEL_I2C_3AXIS line>
> $ grep IIO_ST_ACCEL .config
> CONFIG_IIO_ST_ACCEL_3AXIS=m
> # CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set
> 
> $ make menuconfig
> <immediately exit>
> 
> $ grep IIO_ST_ACCEL .config
> CONFIG_IIO_ST_ACCEL_3AXIS=m
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
> # CONFIG_IIO_ST_ACCEL_SPI_3AXIS is not set
> 
> CONFIG_IIO_ST_ACCEL_I2C_3AXIS was set to =m by default. I believe this is correct behavior.

Yes, thanks for confirming.

-- 
With Best Regards,
Andy Shevchenko


