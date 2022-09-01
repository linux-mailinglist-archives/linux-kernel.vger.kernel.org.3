Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F475AA0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiIAULJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiIAUK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:10:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FA969F7C;
        Thu,  1 Sep 2022 13:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662063057; x=1693599057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yh2FNOyc0UXHkef9LUAUICcRZEZhVKgffrZApOd/DcY=;
  b=RPQBc0RgwmPUGD5Bw2y1m2YBSlAyLvwB0aBrS8GhB9zgKKHSWzMeIrF/
   J4LrUYZ+y2FnB1EKLUXuRc1p1QSLaTjbg/QTwlIeYWrCBnwApUyHyGz9d
   yuxq3llC0/NK/6O3MfbQDAdTHrYxUFruuLomFEKAFZYoi8W/3CIjl3m0U
   F1KGySRCfuk1ql2+0LzudJqYUQOS7wEtKi+OvV1Z+1ueH4Oc8aaCQlB6l
   Emm6ELmYDeCCh1p1h2qmGFj0ifJ0wcLDx4p7uSE7phDs1PB9kvmDE8RTU
   y/j1RuAY1LHZJvOxvBMdfCnpdIaX7mGEGGYishBb1y4Hm8PYkRusI4Ru8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296600811"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296600811"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="645828086"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Sep 2022 13:10:54 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTqWb-0000jN-36;
        Thu, 01 Sep 2022 20:10:53 +0000
Date:   Fri, 2 Sep 2022 04:10:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Message-ID: <202209020413.akDnDcLc-lkp@intel.com>
References: <20220901121700.1325733-4-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901121700.1325733-4-ciprian.regus@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ciprian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ciprian-Regus/dt-bindings-iio-adc-Add-docs-for-LTC2499/20220901-202115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220902/202209020413.akDnDcLc-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/08ff9ae09bfde86fc512e13a4ea2af894e4aa442
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ciprian-Regus/dt-bindings-iio-adc-Add-docs-for-LTC2499/20220901-202115
        git checkout 08ff9ae09bfde86fc512e13a4ea2af894e4aa442
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ltc2497.c:60:12: error: implicit declaration of function 'get_unaligned_be24' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           *val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
                                   ^
   drivers/iio/adc/ltc2497.c:122:4: error: field designator 'name' does not refer to any field in type 'const struct ltc2497_chip_info'
                   .name = NULL,
                    ^
   drivers/iio/adc/ltc2497.c:126:4: error: field designator 'name' does not refer to any field in type 'const struct ltc2497_chip_info'
                   .name = "ltc2499",
                    ^
   3 errors generated.


vim +/get_unaligned_be24 +60 drivers/iio/adc/ltc2497.c

    34	
    35	static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
    36					      u8 address, int *val)
    37	{
    38		struct ltc2497_driverdata *st =
    39			container_of(ddata, struct ltc2497_driverdata, common_ddata);
    40		int ret;
    41	
    42		if (val) {
    43			if (st->recv_size == 3)
    44				ret = i2c_master_recv(st->client, (char *)&st->data.d8, st->recv_size);
    45			else
    46				ret = i2c_master_recv(st->client, (char *)&st->data.d32, st->recv_size);
    47	
    48			if (ret < 0) {
    49				dev_err(&st->client->dev, "i2c_master_recv failed\n");
    50				return ret;
    51			}
    52	
    53			/*
    54			 * The data format is 16/24 bit 2s complement, but with an upper sign bit on the
    55			 * resolution + 1 position, which is set for positive values only. Given this
    56			 * bit's value, subtracting BIT(resolution + 1) from the ADC's result is
    57			 * equivalent to a sign extension.
    58			 */
    59			if (st->recv_size == 3) {
  > 60				*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
    61					- BIT(ddata->chip_info->resolution + 1);
    62			} else {
    63				*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
    64					- BIT(ddata->chip_info->resolution + 1);
    65			}
    66		}
    67	
    68		ret = i2c_smbus_write_byte(st->client,
    69					   LTC2497_ENABLE | address);
    70		if (ret)
    71			dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
    72				ERR_PTR(ret));
    73		return ret;
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
