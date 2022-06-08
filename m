Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92D543EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiFHVjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFHVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:39:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C991994A6;
        Wed,  8 Jun 2022 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654724354; x=1686260354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZL7ybA8BtvQeDTMpYsQ1NWYM8x+gXwRC8Bzu84QZ/MA=;
  b=RNk+tJqrirSTHHZ5tCaln1r3b0HKsewd9hu/cgGYLE9zzQe6oipqFc1P
   g+6jXhBS/WGXEHQzelJXpoJci+P1dnpCU6VV3yr8lzJC2sdcFSQVt4Ann
   oRjbXoZsalGQYKQwMzpN07DfkAbX7zpMW4KGtBwOwX8XfZCQsOyHeMH+W
   Aj4YVhItYDeRXuJDimluaXjAx0tBIQk2/XOxzg/yawx9oajwnsogJVIwD
   +FDsGMRlQNQq+BlvGAxpAMpAbHVllpnv3GkCXLgxmvFki+YM3XC81sbx2
   l9YGkOOBOxM9joajk2SXkaevEPZemyw/Uz9WVfe3NHu6G7qeb9MBwNoPc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277881865"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="277881865"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 14:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="637078029"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2022 14:39:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz3OG-000F2j-Rj;
        Wed, 08 Jun 2022 21:39:00 +0000
Date:   Thu, 9 Jun 2022 05:38:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Replace match_true() by device_match_any()
Message-ID: <202206090508.laygQP9P-lkp@intel.com>
References: <20220607190601.47363-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190601.47363-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on v5.19-rc1 next-20220608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/spi-Replace-match_true-by-device_match_any/20220608-091910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220609/202206090508.laygQP9P-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bbdbed23cc6f2f8e7c9d8da3bb6c78fe488747f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/spi-Replace-match_true-by-device_match_any/20220608-091910
        git checkout bbdbed23cc6f2f8e7c9d8da3bb6c78fe488747f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/spi/spi.c:2670:46: error: incompatible function pointer types passing 'int (struct device *, const void *)' to parameter of type 'int (*)(struct device *, void *)' [-Werror,-Wincompatible-function-pointer-types]
           child = device_find_child(&ctlr->dev, NULL, device_match_any);
                                                       ^~~~~~~~~~~~~~~~
   include/linux/device.h:905:12: note: passing argument to parameter 'match' here
                                    int (*match)(struct device *dev, void *data));
                                          ^
   drivers/spi/spi.c:2689:46: error: incompatible function pointer types passing 'int (struct device *, const void *)' to parameter of type 'int (*)(struct device *, void *)' [-Werror,-Wincompatible-function-pointer-types]
           child = device_find_child(&ctlr->dev, NULL, device_match_any);
                                                       ^~~~~~~~~~~~~~~~
   include/linux/device.h:905:12: note: passing argument to parameter 'match' here
                                    int (*match)(struct device *dev, void *data));
                                          ^
   2 errors generated.


vim +2670 drivers/spi/spi.c

  2662	
  2663	static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
  2664				  char *buf)
  2665	{
  2666		struct spi_controller *ctlr = container_of(dev, struct spi_controller,
  2667							   dev);
  2668		struct device *child;
  2669	
> 2670		child = device_find_child(&ctlr->dev, NULL, device_match_any);
  2671		return sprintf(buf, "%s\n",
  2672			       child ? to_spi_device(child)->modalias : NULL);
  2673	}
  2674	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
