Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF04A5258F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359726AbiEMAaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiEMAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:30:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495B27735B;
        Thu, 12 May 2022 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652401811; x=1683937811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LYjnCj+smhmp4FhFlGE7I7bNwE9bmKNwBEG9Xyxqcg=;
  b=b4uwFfeo4cOPms8onhGBHZ9Srmd+0rzD+6+isWmpaTTsi2UCZSd7xDb2
   /okGyzPaF5H9PlgJozLPUbLkt6UiKyibRWXO5awqSo4fNgRuy4obXSSlb
   1WfJLQrSMo79AJf0pZVOShWNzTWJ8qkWfLwpRL6ZJ3YtgXG1oSNgav3A7
   SmUOjuuoLaD3frQy5BDFfMFyqzZGZAy4/8uHSrKYThFsaYWjrDXzWz0eG
   aOXQd28252+6ixY7yT7LLvqLrWajdpDH0GyfrfaW4fe/S9n7DQ5DImmJH
   VCIp7YWg7to1MaoQ+7vOvg6tNh2NOGY2TEpNNzHDqYc+QsgQmzOZAxhMt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269008779"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269008779"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="566946556"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2022 17:30:08 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npJC3-000L6M-EN;
        Fri, 13 May 2022 00:30:07 +0000
Date:   Fri, 13 May 2022 08:29:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH V5 3/5] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <202205130756.Q7e8x6jf-lkp@intel.com>
References: <20220512160312.3880433-4-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512160312.3880433-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LI,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/LI-Qingwu/iio-accel-sca3300-add-compatible-for-scl3300/20220513-000857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: arm-randconfig-c002-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130756.Q7e8x6jf-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/15579266e58d7cdf4ff8e7ad7a4fa30a0bd3a589
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review LI-Qingwu/iio-accel-sca3300-add-compatible-for-scl3300/20220513-000857
        git checkout 15579266e58d7cdf4ff8e7ad7a4fa30a0bd3a589
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/accel/sca3300.c: In function 'sca3300_get_op_mode':
>> drivers/iio/accel/sca3300.c:288:58: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     288 |                 if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~


vim +288 drivers/iio/accel/sca3300.c

   276	
   277	static int sca3300_get_op_mode(struct sca3300_data *sca_data, int *index)
   278	{
   279		int reg_val;
   280		int ret;
   281		int i;
   282	
   283		ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
   284		if (ret)
   285			return ret;
   286	
   287		for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
 > 288			if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
   289				break;
   290		}
   291	
   292		if (i >= sca_data->chip->num_avail_modes)
   293			return -EINVAL;
   294	
   295		*index = i;
   296		return 0;
   297	}
   298	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
