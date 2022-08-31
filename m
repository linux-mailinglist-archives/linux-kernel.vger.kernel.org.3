Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA985A8804
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiHaVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiHaVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:23:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2528BA7AA8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661981010; x=1693517010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+xXkWuuCi6rF4D2yXyu4H40LQSFIn3eOKHFcrv/pTU=;
  b=Le9Dh+GKOFj2Lw3bf/UALXN6TwAYOfQGVKCyHNoSafvzR/Euhf/ilF9W
   JO/aBSZSoxACylBQ/eAV1VJIscdyGoNWGEk8fzBqhuUuXKIHsud+z0xqN
   v835949qvLhH4/WA3b2m3QrHidH5Y7IZ006UWAAKT7u7BwInK+vRw8ErA
   03G+7j/iKcw2O2InL5FmVBZp2ijaO+UIDz48xcDALvYAdrdhL/XSk22rw
   +hdDNpViD2ZQXO7idftrQKBtIDZKL8KCvJYjVzGmIvlVO70kVMjqkHdCI
   GpdzpcsRwTxqPEYJPdfVubUYcO3L0LUg7EEILvRp5BqV7EQPeilteip/n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275295985"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275295985"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="680577062"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2022 14:23:28 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTVBH-0000if-1W;
        Wed, 31 Aug 2022 21:23:27 +0000
Date:   Thu, 1 Sep 2022 05:22:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/3] regmap: spi-avmm: Use swabXX_array() helpers
Message-ID: <202209010548.ZC5MnsXX-lkp@intel.com>
References: <20220831145407.78166-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831145407.78166-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-regmap/for-next]
[also build test ERROR on next-20220831]
[cannot apply to linus/master v6.0-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/swab-Add-array-operations/20220831-225514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220901/202209010548.ZC5MnsXX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/783618682b27b5d06605086a386d64d355914b38
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/swab-Add-array-operations/20220831-225514
        git checkout 783618682b27b5d06605086a386d64d355914b38
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/regmap/regmap-spi-avmm.c: In function 'br_swap_words_32':
>> drivers/base/regmap/regmap-spi-avmm.c:171:22: error: passing argument 1 of 'swab32_array' from incompatible pointer type [-Werror=incompatible-pointer-types]
     171 |         swab32_array(buf, len / 4);
         |                      ^~~
         |                      |
         |                      char *
   In file included from include/uapi/linux/byteorder/little_endian.h:14,
                    from include/linux/byteorder/little_endian.h:5,
                    from arch/x86/include/uapi/asm/byteorder.h:5,
                    from arch/x86/include/asm/orc_types.h:43,
                    from arch/x86/include/asm/unwind_hints.h:6,
                    from arch/x86/include/asm/nospec-branch.h:13,
                    from arch/x86/include/asm/paravirt_types.h:40,
                    from arch/x86/include/asm/ptrace.h:97,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/base/regmap/regmap-spi-avmm.c:7:
   include/linux/swab.h:32:38: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'char *'
      32 | static inline void swab32_array(u32 *buf, unsigned int words)
         |                                 ~~~~~^~~
   cc1: some warnings being treated as errors


vim +/swab32_array +171 drivers/base/regmap/regmap-spi-avmm.c

   168	
   169	static void br_swap_words_32(char *buf, unsigned int len)
   170	{
 > 171		swab32_array(buf, len / 4);
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
