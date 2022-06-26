Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFE55ADF0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 03:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiFZBYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 21:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFZBYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 21:24:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99AAB84E;
        Sat, 25 Jun 2022 18:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656206684; x=1687742684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zxt7FTKnL1KnGMwsPjwbDJvrp8p26gSFYjDhU/sSKpU=;
  b=PN1xdBiFI3LnJz0+6+xGwFE2OVRdB2XSgfruez5q119VjwyyQacbp8e6
   Ti7e8P3R53SFMeqS9CFnk1ggGUDuKhrfctDHsvX+rPJTdBjSWkR/5YvKa
   DPTixyqBYLw69ZMgMB37Bng12kiEuBaCWUl6C8eHIpUYrkuSujFifHCj7
   jF88AvNMik3lmwq1YojEkj+odo7jnlJeJ5xhfz0AzQ/f5+F78s4ZuHLba
   FXHquL7Ii3Hjey4mMtgeDiJ+edQXrY+uHDqo6laU0AxHiuc9X/XsKGGtH
   E1ezfLO78e/O9Ch0ymcF/ZDmEf7lMhqoxxc6ZqT97nrp006x07jonJ1Iq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="345237201"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="345237201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="587008609"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 18:24:42 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5H0z-0006Xb-Fs;
        Sun, 26 Jun 2022 01:24:41 +0000
Date:   Sun, 26 Jun 2022 09:24:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     kbuild-all@lists.01.org, Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: bmp280: Add support for BMP380 sensor
 family
Message-ID: <202206260908.STsTkCPR-lkp@intel.com>
References: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-s001
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/intel-lab-lkp/linux/commit/56e3f8aecddacdbe204fbe5e28032ef2befae647
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
        git checkout 56e3f8aecddacdbe204fbe5e28032ef2befae647
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/iio/pressure/bmp280-core.c:928:21: sparse: sparse: cast to restricted __le16
>> drivers/iio/pressure/bmp280-core.c:928:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:928:21: sparse: sparse: cast to restricted __le16
>> drivers/iio/pressure/bmp280-core.c:928:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:928:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:929:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:929:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:929:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:929:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:929:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:931:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:931:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:931:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:931:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:931:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:932:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:932:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:932:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:932:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:932:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:935:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:935:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:935:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:935:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:935:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:936:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:936:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:936:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:936:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:936:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:939:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:939:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:939:21: sparse: sparse: cast to restricted __le16
   drivers/iio/pressure/bmp280-core.c:939:21: sparse: sparse: restricted __le16 degrades to integer
   drivers/iio/pressure/bmp280-core.c:939:21: sparse: sparse: cast to restricted __le16

vim +928 drivers/iio/pressure/bmp280-core.c

   908	
   909	static int bmp380_read_calib(struct bmp280_data *data,
   910				     struct bmp380_calib *calib, unsigned int chip)
   911	{
   912		int ret;
   913		u8 buf[BMP380_CALIB_REG_COUNT];
   914	
   915		/* Read temperature calibration values. */
   916		ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START, buf,
   917				       BMP380_CALIB_REG_COUNT);
   918		if (ret < 0) {
   919			dev_err(data->dev,
   920				"failed to read temperature calibration parameters\n");
   921			return ret;
   922		}
   923	
   924		/* Toss the temperature calibration data into the entropy pool */
   925		add_device_randomness(buf, sizeof(buf));
   926	
   927		/* Parse calibration data */
 > 928		calib->T1 = le16_from_bytes(buf[BMP380_T1], buf[BMP380_T1 + 1]);
   929		calib->T2 = le16_from_bytes(buf[BMP380_T2], buf[BMP380_T2 + 1]);
   930		calib->T3 = buf[BMP380_T3];
   931		calib->P1 = le16_from_bytes(buf[BMP380_P1], buf[BMP380_P1 + 1]);
   932		calib->P2 = le16_from_bytes(buf[BMP380_P2], buf[BMP380_P2 + 1]);
   933		calib->P3 = buf[BMP380_P3];
   934		calib->P4 = buf[BMP380_P4];
   935		calib->P5 = le16_from_bytes(buf[BMP380_P5], buf[BMP380_P5 + 1]);
   936		calib->P6 = le16_from_bytes(buf[BMP380_P6], buf[BMP380_P6 + 1]);
   937		calib->P7 = buf[BMP380_P7];
   938		calib->P8 = buf[BMP380_P8];
   939		calib->P9 = le16_from_bytes(buf[BMP380_P9], buf[BMP380_P9 + 1]);
   940		calib->P10 = buf[BMP380_P10];
   941		calib->P11 = buf[BMP380_P11];
   942	
   943		return 0;
   944	}
   945	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
