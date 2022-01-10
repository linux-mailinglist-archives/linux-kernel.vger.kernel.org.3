Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4730A489CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiAJPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:51:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:33728 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236445AbiAJPvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641829892; x=1673365892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qrH8YVp1hIa1Pztvnew32Jm4pQhvfr8+MWdiBJ4EiXw=;
  b=NTPLokimprDiesYfibiGw4Shf/9PhGLqkZzI7PJdSCyAcdGKd8Yk2wNi
   pGJjrw79wGG62xee2k161/JtAPf/VE8mFCZ8WfPm8z6zj++eQZLCMhLQP
   j5ucuYCtgXOe79+ja6FlUlhDyAiPC/kflv5mesw2TfWD+ttB/xk/tvphM
   1mcUSpZnueU+c5lwpCgnq+ISdnu3RJ1597AFOVxLAw8kuJU6vEoUsflgP
   GgrOw3xf4ZokMYsEUrx00/qB0X//BTnppnz8qQNzl5R5Ov4SiVQ9ankrA
   sTuPNxKfUaHArjcISgDTh9fKz0aAbqfeertEW7PCSlln25hYRUFvpWfC1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223234904"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="223234904"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:51:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="612886491"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 07:51:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n6wvy-008uxa-It;
        Mon, 10 Jan 2022 17:50:10 +0200
Date:   Mon, 10 Jan 2022 17:50:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: stm: don't always auto-enable I2C and SPI
 interface drivers
Message-ID: <YdxVsvWN7pOV/iLy@smile.fi.intel.com>
References: <20220109124326.3696775-1-nikita.yoush@cogentembedded.com>
 <Ydwlsr8WjdsSWvoZ@smile.fi.intel.com>
 <13907dd6-2a30-c6b1-fb71-e88dba98f5ca@cogentembedded.com>
 <YdxSZ53cBGcNjbvb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxSZ53cBGcNjbvb@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:36:08PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 10, 2022 at 03:30:08PM +0300, Nikita Yushchenko wrote:
> > > Just noticed, what stm supposed to mean? `git log` against those drivers
> > > suggests something else.
> > 
> > I copied it from git log, can't remember from where exactly.
> > Perhaps 'st_sensors' is better.
> 
> % git log --no-merges --oneline -- drivers/iio/common/st_sensors/ drivers/iio/*/st_* | cut -f2-4 -d' ' | grep -o "[ :]st[^:]\+:" | tr -d ':' | tr -d ' ' | sort | uniq -c | sort -n
>       1 st_accel_core
>       1 st_accel_i2c
>       1 st_gyro_spi
>       1 st_lsm9ds0
>       1 st_lsmdsx
>       1 st-magn
>       1 st_magn_core
>       1 st_pressure_core
>       1 stsensors
>       2 st_accel_i2c.c
>       2 st_magn_spi
>       2 st_press
>       2 st_pressure_spi
>       3 st-accel
>       4 st_accel_spi
>       4 st_uvis25
>       5 st-sensors
>      11 st_gyro
>      15 st_magn
>      21 st_pressure
>      27 st_accel
>      68 st_sensors
>     140 st_lsm6dsx
> 
> (Yes, I know that command line can be simplified :-)

Or full view (except single occurrences):

% git log --no-merges --oneline -- drivers/iio/common/st_sensors/ drivers/iio/*/st_* | sed -e 's,^[^ ]\+ \(.*\):[^:]\+$,\1,' | sort | uniq -c | sort -n | grep -v '^      1'
      2 iio: imu: st_lsm6dsx: st_lsm6dsx
      2 iio: light
      2 iio: lps331ap
      2 iio:magnetometer: st_magn
      2 iio: magnetometer: st_magn_spi
      2 iio: magn: st_magn
      2 iio: pressure: st_press
      2 IIO: st_accel_i2c.c
      2 iio: st_gyro
      2 iio: st_magn
      2 iio:st_magn
      2 iio:st_pressure:lps22hb
      2 iio: st_pressure: st_accel
      2 treewide
      3 iio: accel: st_sensors
      3 iio:imu
      3 iio: light: st_uvis25
      3 iio: magnetometer
      3 iio: st-accel
      3 iio: st_lsm6dsx
      4 iio: accel: st_accel_spi
      4 iio: common: st_sensors
      4 iio:magn
      4 iio: st_pressure
      5 iio: accel
      5 iio: pressure: st_pressure
      5 iio: st-sensors
      6 iio:magnetometer
      6 iio: pressure-core: st
      6 iio: sensors-core: st
      7 iio:accel
      7 iio:common
      7 iio: magnetometer: st_magn
      7 iio:st_sensors
      8 iio:gyro
      8 iio: gyro: st_gyro
      8 iio: st_accel
      8 iio:st_pressure
      9 iio:pressure
     14 iio
     16 iio: accel: st_accel
     52 iio: st_sensors
    133 iio: imu: st_lsm6dsx

-- 
With Best Regards,
Andy Shevchenko


