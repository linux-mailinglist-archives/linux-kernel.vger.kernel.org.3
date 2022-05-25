Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEDD53428C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiEYRyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiEYRyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:54:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9F2E021;
        Wed, 25 May 2022 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653501288; x=1685037288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgc3MtIflvORaob8lTqi592HZbL+t/hdZbXZ66gIvX8=;
  b=j8tnqwWgoth3orU5N9AdlwvCH+wkXlQtflOmQ9o5KPDSfdby1pUFzFiU
   4LVYiQx+4W1PEYT09l9ElXlIe+sTRI/ao8Nk/XKyqDfPK4WqqbNUD7nrf
   8xIdqn2pzQGuagshZ/tiIeu8iTqdL7RvSJRAS2/osq46jgdlAzcshy/Zg
   6qvqipkO97JEo6F4knBQlqG0TXtsSu3mWi0F+/a3cQ+ckWFiyfMCHr1g5
   eECvVRJ7zHJ/RKZoTo9OhfBxqKFo24l4VfN5R7t3F/F3fSlrBVjtImjDD
   GDdinyEw+YcXZtr2OR5rzZPzwHJf6ia4/TGYUd6UH02MQW+bUX5zkzWwq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="336943018"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336943018"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 10:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="630460953"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 May 2022 10:53:04 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntvBv-0003DF-Dh;
        Wed, 25 May 2022 17:53:03 +0000
Date:   Thu, 26 May 2022 01:53:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        thomas.haemmerle@leica-geosystems.com
Subject: Re: [PATCH V4 1/6] iio: accel: bmi088: Modified the scale calculate
Message-ID: <202205260151.TTnXYfeD-lkp@intel.com>
References: <20220525130828.2394919-2-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525130828.2394919-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LI,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.18 next-20220525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/LI-Qingwu/iio-accel-bmi088-support-BMI085-BMI090L/20220525-211157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220526/202205260151.TTnXYfeD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d52a6e75b0c402c7f3b42a2b1b2873f151220947)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/71cdfb0a9a6ddbf8737a46bc6161fb921b1ac2f4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review LI-Qingwu/iio-accel-bmi088-support-BMI085-BMI090L/20220525-211157
        git checkout 71cdfb0a9a6ddbf8737a46bc6161fb921b1ac2f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/accel/bmi088-accel-core.c:341:10: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           reg = FIELD_GET(BMIO088_ACCEL_ACC_RANGE_MSK, reg);
                                 ^
   1 error generated.


vim +/FIELD_GET +341 drivers/iio/accel/bmi088-accel-core.c

   278	
   279	static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
   280					 struct iio_chan_spec const *chan,
   281					 int *val, int *val2, long mask)
   282	{
   283		struct bmi088_accel_data *data = iio_priv(indio_dev);
   284		struct device *dev = regmap_get_device(data->regmap);
   285		int ret;
   286		int reg;
   287	
   288		switch (mask) {
   289		case IIO_CHAN_INFO_RAW:
   290			switch (chan->type) {
   291			case IIO_TEMP:
   292				ret = pm_runtime_resume_and_get(dev);
   293				if (ret)
   294					return ret;
   295	
   296				ret = bmi088_accel_get_temp(data, val);
   297				goto out_read_raw_pm_put;
   298			case IIO_ACCEL:
   299				ret = pm_runtime_resume_and_get(dev);
   300				if (ret)
   301					return ret;
   302	
   303				ret = iio_device_claim_direct_mode(indio_dev);
   304				if (ret)
   305					goto out_read_raw_pm_put;
   306	
   307				ret = bmi088_accel_get_axis(data, chan, val);
   308				iio_device_release_direct_mode(indio_dev);
   309				if (!ret)
   310					ret = IIO_VAL_INT;
   311	
   312				goto out_read_raw_pm_put;
   313			default:
   314				return -EINVAL;
   315			}
   316		case IIO_CHAN_INFO_OFFSET:
   317			switch (chan->type) {
   318			case IIO_TEMP:
   319				/* Offset applies before scale */
   320				*val = BMI088_ACCEL_TEMP_OFFSET/BMI088_ACCEL_TEMP_UNIT;
   321				return IIO_VAL_INT;
   322			default:
   323				return -EINVAL;
   324			}
   325		case IIO_CHAN_INFO_SCALE:
   326			switch (chan->type) {
   327			case IIO_TEMP:
   328				/* 0.125 degrees per LSB */
   329				*val = BMI088_ACCEL_TEMP_UNIT;
   330				return IIO_VAL_INT;
   331			case IIO_ACCEL:
   332				ret = pm_runtime_resume_and_get(dev);
   333				if (ret)
   334					return ret;
   335	
   336				ret = regmap_read(data->regmap,
   337						  BMI088_ACCEL_REG_ACC_RANGE, &reg);
   338				if (ret)
   339					goto out_read_raw_pm_put;
   340	
 > 341				reg = FIELD_GET(BMIO088_ACCEL_ACC_RANGE_MSK, reg);
   342				*val  = data->chip_info->scale_table[reg][0];
   343				*val2 = data->chip_info->scale_table[reg][1];
   344				ret = IIO_VAL_INT_PLUS_MICRO;
   345	
   346				goto out_read_raw_pm_put;
   347			default:
   348				return -EINVAL;
   349			}
   350		case IIO_CHAN_INFO_SAMP_FREQ:
   351			ret = pm_runtime_resume_and_get(dev);
   352			if (ret)
   353				return ret;
   354	
   355			ret = bmi088_accel_get_sample_freq(data, val, val2);
   356			goto out_read_raw_pm_put;
   357		default:
   358			break;
   359		}
   360	
   361		return -EINVAL;
   362	
   363	out_read_raw_pm_put:
   364		pm_runtime_mark_last_busy(dev);
   365		pm_runtime_put_autosuspend(dev);
   366	
   367		return ret;
   368	}
   369	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
