Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44E8514190
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiD2EwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiD2EwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:52:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E762316F;
        Thu, 28 Apr 2022 21:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651207737; x=1682743737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Jj2HJdFD+WzFuEtVuuAOpTSCLb1M1zXw4IDK1AusbpA=;
  b=eos+kAtnWd41KOe5P6ZuMlzTGAunnKNn83LMFVoA9TtTNpGnofKSouJd
   aqJDzU4gzmfzpLF8NREMeZVTzlKA3Bml4AlQb7M//NzoerBSA/mA6p9Kd
   068xxInQ5Y/JoEo982dOA7JmpgiDRy60yjhtveh0mmbCkf1w9sHcRJq7F
   jCQbu7ZfIheo35JJb0JL92hN+4Pb4Z3rnl7o1h8H2B5jRfAC77mFWit6H
   10astohG7J9GwCRSxtBdDDQQGflMRfLGCwGtMR7gXSvBk5jux9XFXTv2X
   x8+tTpnYvxl6KEwl4WLPgv5cyaC11Wfgg94Abi4dEg2hmihUgKDvDA5T3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="352960684"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="352960684"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 21:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="542062208"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 21:48:54 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkIYn-0005zX-Fj;
        Fri, 29 Apr 2022 04:48:53 +0000
Date:   Fri, 29 Apr 2022 12:48:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        s.nawrocki@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: s5c73m3: replace legacy gpio interface for
 gpiod
Message-ID: <202204291212.g99NfHX0-lkp@intel.com>
References: <YmsuDHwjUwxtjiyq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmsuDHwjUwxtjiyq@fedora>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Maíra,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on v5.18-rc4 next-20220428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-ra-Canal/media-s5c73m3-replace-legacy-gpio-interface-for-gpiod/20220429-081656
base:   git://linuxtv.org/media_tree.git master
config: arm64-randconfig-r022-20220428 (https://download.01.org/0day-ci/archive/20220429/202204291212.g99NfHX0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/427ae1b9cae644d199f9ffc260480dd1c32ec9d6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ma-ra-Canal/media-s5c73m3-replace-legacy-gpio-interface-for-gpiod/20220429-081656
        git checkout 427ae1b9cae644d199f9ffc260480dd1c32ec9d6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/media/i2c/s5c73m3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/i2c/s5c73m3/s5c73m3-core.c:1359:32: error: too few arguments to function call, expected 2, have 1
           int val = gpiod_set_value(gpio);
                     ~~~~~~~~~~~~~~~     ^
   include/linux/gpio/consumer.h:119:6: note: 'gpiod_set_value' declared here
   void gpiod_set_value(struct gpio_desc *desc, int value);
        ^
   drivers/media/i2c/s5c73m3/s5c73m3-core.c:1366:32: error: too few arguments to function call, expected 2, have 1
           int val = gpiod_set_value(gpio);
                     ~~~~~~~~~~~~~~~     ^
   include/linux/gpio/consumer.h:119:6: note: 'gpiod_set_value' declared here
   void gpiod_set_value(struct gpio_desc *desc, int value);
        ^
   2 errors generated.


vim +1359 drivers/media/i2c/s5c73m3/s5c73m3-core.c

  1356	
  1357	static int s5c73m3_gpio_assert(struct gpio_desc *gpio)
  1358	{
> 1359		int val = gpiod_set_value(gpio);
  1360	
  1361		return s5c73m3_gpio_set_value(gpio, val);
  1362	}
  1363	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
