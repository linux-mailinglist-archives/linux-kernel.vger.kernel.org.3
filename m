Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76E55204C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiEISzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbiEISyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:54:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A9A22BCB;
        Mon,  9 May 2022 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652122256; x=1683658256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bPFox0Qva+4I21dxyRS/dYCprSTnwFX2nf6DY0aKm+8=;
  b=L+t/YLX4gyNcB48V1udakINjYeJjUWDjT8Av/OKdmx7wikCYtUQxG61Y
   pYQ6QZzFi7N+RUiLtCSQX5T2zj/jJ7MfiAfHUimBLERgwjl6blLfwJPa2
   mD5r7p1irtR+QslKO1YspmcnT/Zs75Wvzz2Ho/yPxJopFGQQySRl14HWD
   Us5SQiPpbe0y9kyUeAtl+xqmUhl4zaaQNDWHjuqFgwL2qhFAMbIJqhv1o
   UBDh1c2GSVi6bnyDOuhcWDb/TD6xtQ1OQycoI32IMR8IH9um0trIIW8yQ
   Y0zbFktkJCdqB2L3DU7NfAUutNjTSYLT6t8eZB4uvkS6SPs9ErOza9/bU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249042684"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="249042684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 11:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="519367514"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 May 2022 11:50:52 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no8T6-000GnE-3P;
        Mon, 09 May 2022 18:50:52 +0000
Date:   Tue, 10 May 2022 02:50:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH V1 4/5] iio: accel: bmi088: Make it possible to config
 scales.
Message-ID: <202205100238.ZzT44bv1-lkp@intel.com>
References: <20220509134629.440965-5-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509134629.440965-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LI,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/LI-Qingwu/iio-accel-bmi088-support-BMI085-BMI090L/20220509-215750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-randconfig-a003-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100238.ZzT44bv1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/70883e96ff4d7433fa8974815aba932f8bb2e8e7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review LI-Qingwu/iio-accel-bmi088-support-BMI085-BMI090L/20220509-215750
        git checkout 70883e96ff4d7433fa8974815aba932f8bb2e8e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/bmi088-accel-core.c:243:6: warning: unused variable 'ret' [-Wunused-variable]
           int ret;
               ^
>> drivers/iio/accel/bmi088-accel-core.c:244:6: warning: unused variable 'reg' [-Wunused-variable]
           int reg;
               ^
   2 warnings generated.


vim +/ret +243 drivers/iio/accel/bmi088-accel-core.c

   239	
   240	static int bmi088_accel_set_scale(struct bmi088_accel_data *data, int val, int val2)
   241	{
   242		unsigned int i;
 > 243		int ret;
 > 244		int reg;
   245	
   246		for (i = 0; i < 4; i++)
   247			if (val == data->chip_info->scale_table[i][0] &&
   248			    val2 == data->chip_info->scale_table[i][1])
   249				break;
   250	
   251		if (i >= 4)
   252			return -EINVAL;
   253	
   254		return regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE, i);
   255	}
   256	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
