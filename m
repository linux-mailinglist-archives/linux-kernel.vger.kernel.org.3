Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBA518C49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiECS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiECS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:27:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1903EF2A;
        Tue,  3 May 2022 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651602263; x=1683138263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iLOTQX/JYHzV3TJpVrXnL+ONHto5A4z1JeCFYGTCYV8=;
  b=YDqE/GThIi7EReJoJwI1VElBD7ElgMVb3YFwvIkfV9Efo0LV60m0cdgE
   /8BOwl8lpKcyLgax9cZSNkE4uhB3kpKCzBSZUh3iZH5ZJRmpIFgRXDuLR
   sQv96S+GkM5AzE3X17jslg+IesbUjQopLPFyv3Y/o4BggLBgMWHLn+J+Z
   KuafXe6kDrYveRZ5jcZg2MxSe32Q9By9KIKQVGnGC4tQWhErvmoQKqLCh
   LElyQJvNlzFaiLdfd8aJDiGFaswH4VWq0sJ+fU3NYNWGDukAmphVsGCjg
   uVPb0pPDboJeK/eIYXM7yJPzJknozPbSoLXRL/1D+fAfZlbe3OvlVkwqN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266397226"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="266397226"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="620451429"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 May 2022 11:24:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlxC8-000Ahg-Th;
        Tue, 03 May 2022 18:24:20 +0000
Date:   Wed, 4 May 2022 02:24:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH v1 1/1] bcma: gpio: Switch to use fwnode instead of
 of_node
Message-ID: <202205040233.5yHZrUIm-lkp@intel.com>
References: <20220503151246.58725-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503151246.58725-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless/main]
[also build test ERROR on wireless-next/main linus/master linux/master v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/bcma-gpio-Switch-to-use-fwnode-instead-of-of_node/20220503-231650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: hexagon-randconfig-r045-20220501 (https://download.01.org/0day-ci/archive/20220504/202205040233.5yHZrUIm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46c0f361f2b8880eb16d176051b977c31978920a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/bcma-gpio-Switch-to-use-fwnode-instead-of-of_node/20220503-231650
        git checkout 46c0f361f2b8880eb16d176051b977c31978920a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/bcma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/bcma/driver_gpio.c:14:10: fatal error: 'linux/poperty.h' file not found
   #include <linux/poperty.h>
            ^~~~~~~~~~~~~~~~~
   1 error generated.


vim +14 drivers/bcma/driver_gpio.c

  > 14	#include <linux/poperty.h>
    15	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
