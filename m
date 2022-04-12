Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5904FCEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbiDLFYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbiDLFYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:24:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABB923144;
        Mon, 11 Apr 2022 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649740957; x=1681276957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Ak0yzzMFBysS07NRECTZCivMfGlOFPSAH9j0twlQmA=;
  b=AAsye/O/2EQy1ohzSte/5bzYXJCdzo3bIl+0kT9P+dy8qqb3tMa4JYWM
   Sz8kSObCX9cnguLRf6YVMTql7cN8cYKsivhUqzJIZApsFQyG6lITbuuVZ
   S3K/FYZJaUa0MXIbmBj7egGSFqOL5CVkbpk/iPpX+MLOEUwfV5AAQHijv
   H+WDAHdDk1K4RJWGmhYuxEOjH1N+ftXUnmh5HSxS6rzKOlGvJGSSA6t8Z
   kXZTfB95HJb6CSRkNc1U5dQEBj+n8nnqRHsh2cIenfa8tsORtqefgjhjF
   dsVpQ/dPnP42IoZdhJ6/GM/5NwrYtAY+UXy7pqKUF8KGGBhAcppnalitL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348717191"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="348717191"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="699675293"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2022 22:22:35 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne8z4-0002XW-BP;
        Tue, 12 Apr 2022 05:22:34 +0000
Date:   Tue, 12 Apr 2022 13:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>, dan@dlrobertson.com,
        jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
Message-ID: <202204121327.f3Svxeg1-lkp@intel.com>
References: <20220411203133.19929-10-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411203133.19929-10-jagathjog1996@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagath,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220412-043436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: riscv-randconfig-c006-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121327.f3Svxeg1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/15ee6de45ed7a028569638c198e170bb98cef4ab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220412-043436
        git checkout 15ee6de45ed7a028569638c198e170bb98cef4ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/accel/bma400_core.c:1072:3: error: call to __compiletime_assert_272 declared with 'error' attribute: BUILD_BUG failed
                   set_mask_bits(&data->generic_event_en, msk, field_value);
                   ^
   include/linux/bitops.h:283:11: note: expanded from macro 'set_mask_bits'
           } while (cmpxchg(ptr, old__, new__) != old__);          \
                    ^
   include/linux/atomic/atomic-instrumented.h:1916:2: note: expanded from macro 'cmpxchg'
           arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
           ^
   arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from macro 'arch_cmpxchg'
           (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
                                ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:64:1: note: expanded from here
   __compiletime_assert_272
   ^
   1 error generated.


vim +/error +1072 drivers/iio/accel/bma400_core.c

   998	
   999	static int bma400_write_event_config(struct iio_dev *indio_dev,
  1000					     const struct iio_chan_spec *chan,
  1001					     enum iio_event_type type,
  1002					     enum iio_event_direction dir, int state)
  1003	{
  1004		int ret;
  1005		struct bma400_data *data = iio_priv(indio_dev);
  1006		int reg, msk, value, field_value;
  1007	
  1008		switch (chan->type) {
  1009		case IIO_ACCEL:
  1010			switch (dir) {
  1011			case IIO_EV_DIR_RISING:
  1012				reg = BMA400_GEN1INT_CONFIG0;
  1013				msk = BMA400_INT_GEN1_MSK;
  1014				value = 2;
  1015				field_value = FIELD_PREP(BMA400_INT_GEN1_MSK, state);
  1016				break;
  1017			case IIO_EV_DIR_FALLING:
  1018				reg = BMA400_GEN2INT_CONFIG0;
  1019				msk = BMA400_INT_GEN2_MSK;
  1020				value = 0;
  1021				field_value = FIELD_PREP(BMA400_INT_GEN2_MSK, state);
  1022				break;
  1023			default:
  1024				return -EINVAL;
  1025			}
  1026	
  1027			mutex_lock(&data->mutex);
  1028			/* Enabling all axis for interrupt evaluation */
  1029			ret = regmap_write(data->regmap, reg, 0xF8);
  1030			if (ret) {
  1031				mutex_unlock(&data->mutex);
  1032				return ret;
  1033			}
  1034	
  1035			/* OR combination of all axis for interrupt evaluation */
  1036			ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF,
  1037					   value);
  1038			if (ret) {
  1039				mutex_unlock(&data->mutex);
  1040				return ret;
  1041			}
  1042	
  1043			/* Initial value to avoid interrupts while enabling*/
  1044			ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF,
  1045					   0x0A);
  1046			if (ret) {
  1047				mutex_unlock(&data->mutex);
  1048				return ret;
  1049			}
  1050	
  1051			/* Initial duration value to avoid interrupts while enabling*/
  1052			ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF,
  1053					   0x0F);
  1054			if (ret) {
  1055				mutex_unlock(&data->mutex);
  1056				return ret;
  1057			}
  1058	
  1059			ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
  1060						 msk, field_value);
  1061			if (ret) {
  1062				mutex_unlock(&data->mutex);
  1063				return ret;
  1064			}
  1065	
  1066			ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
  1067						 msk, field_value);
  1068			mutex_unlock(&data->mutex);
  1069			if (ret)
  1070				return ret;
  1071	
> 1072			set_mask_bits(&data->generic_event_en, msk, field_value);
  1073			return 0;
  1074		case IIO_STEPS:
  1075			mutex_lock(&data->mutex);
  1076			if (!data->steps_enabled) {
  1077				ret = regmap_update_bits(data->regmap,
  1078							 BMA400_INT_CONFIG1_REG,
  1079							 BMA400_STEP_INT_MSK,
  1080							 FIELD_PREP(BMA400_STEP_INT_MSK,
  1081								    1));
  1082				if (ret) {
  1083					mutex_unlock(&data->mutex);
  1084					return ret;
  1085				}
  1086				data->steps_enabled = 1;
  1087			}
  1088	
  1089			ret = regmap_update_bits(data->regmap,
  1090						 BMA400_INT12_MAP_REG,
  1091						 BMA400_STEP_INT_MSK,
  1092						 FIELD_PREP(BMA400_STEP_INT_MSK,
  1093							    state));
  1094			mutex_unlock(&data->mutex);
  1095			if (ret)
  1096				return ret;
  1097			data->step_event_en = state;
  1098			return 0;
  1099		case IIO_ACTIVITY:
  1100			if (!data->step_event_en) {
  1101				mutex_lock(&data->mutex);
  1102				ret = regmap_update_bits(data->regmap,
  1103							 BMA400_INT_CONFIG1_REG,
  1104							 BMA400_STEP_INT_MSK,
  1105							 FIELD_PREP(BMA400_STEP_INT_MSK,
  1106								    1));
  1107				if (ret) {
  1108					mutex_unlock(&data->mutex);
  1109					return ret;
  1110				}
  1111				data->steps_enabled = 1;
  1112	
  1113				ret = regmap_update_bits(data->regmap,
  1114							 BMA400_INT12_MAP_REG,
  1115							 BMA400_STEP_INT_MSK,
  1116							 FIELD_PREP(BMA400_STEP_INT_MSK,
  1117								    1));
  1118				mutex_unlock(&data->mutex);
  1119				if (ret)
  1120					return ret;
  1121				data->step_event_en = 1;
  1122			}
  1123			data->activity_event_en = state;
  1124			return 0;
  1125		default:
  1126			return -EINVAL;
  1127		}
  1128	}
  1129	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
