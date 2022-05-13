Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604A6525924
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359849AbiEMBAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359829AbiEMBAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:00:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA1111;
        Thu, 12 May 2022 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652403640; x=1683939640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a+1Fqogl6MRxCjd5uyzI3/s5nb7F3MKz0w+tdYBiDPk=;
  b=OmX+wI+5AJDMrbystAAwy0A1NGM7/L9FcFjZf+Q+YyA4CdyDO7DoiIZX
   IjJOX7o8QGDWa2uqO/fR3Oz8iZpXXvyzjUe1VFSUbc5lJyMP+GZi2QYnv
   efI+y21O77sLU9OdAZ34EcPbtRjYTtKY9qcXo50ikd1MZBdCoHIjxwh7F
   B4hQ0p5pKIIvUmVUEv/K8a/dRz+54bqhiS+vGogQWZE+lVC0YhCvHgn81
   scXzbv45z3PdliTPWbqq4TqVmJsP/pCqO/O+Vi56MG1DxEM/Z1+afxJRJ
   grR4KeHPe1Hexjf6x5HJfMJMoDbz2h8z6xfcMsxQ46TRgawTklNXdCP8m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="269014047"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="269014047"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="603623377"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2022 18:00:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npJfH-000L7m-5u;
        Fri, 13 May 2022 01:00:19 +0000
Date:   Fri, 13 May 2022 09:00:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH V5 3/5] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <202205130824.ObRAkagG-lkp@intel.com>
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
[also build test WARNING on v5.18-rc6 next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/LI-Qingwu/iio-accel-sca3300-add-compatible-for-scl3300/20220513-000857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: hexagon-randconfig-r041-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130824.ObRAkagG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/15579266e58d7cdf4ff8e7ad7a4fa30a0bd3a589
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review LI-Qingwu/iio-accel-sca3300-add-compatible-for-scl3300/20220513-000857
        git checkout 15579266e58d7cdf4ff8e7ad7a4fa30a0bd3a589
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/sca3300.c:288:54: warning: & has lower precedence than ==; == will be evaluated first [-Wparentheses]
                   if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   drivers/iio/accel/sca3300.c:288:54: note: place parentheses around the '==' expression to silence this warning
                   if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
                                                                      ^
                       (                                              )
   drivers/iio/accel/sca3300.c:288:54: note: place parentheses around the & expression to evaluate it first
                   if (sca_data->chip->avail_modes_table[i] == reg_val&0x03)
                                                                      ^
                                                               (           )
   1 warning generated.


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
