Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192065A684C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiH3QW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiH3QWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:22:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC911C162;
        Tue, 30 Aug 2022 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661876498; x=1693412498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nnWF+9w2MbX2jrfsvicDgIyVdRkAskBaSpy/X9zQ7Ow=;
  b=J3hu3Pnm3Z3usPYUf2ZWkvr0KzJn3C57/rEN/GGqQrajrlaMeaeHKa/q
   H/Q3wTnKlafVY596NL0A0P0GiI6F4RgBeSIMlODTrPGsaVx8e6iVBkMtJ
   wiNq541ggU9LvlaRIp2CXwBlg6o11nrwj1WmV88s8igEAZhoBBeIBcdwC
   q92y8QNDnoLAvs1oWrfU8jYsH6WBetv2/6Xxw5Exs2t/V7ZtqOlBddsKh
   WMn3cgQufR+8zYxuvtOT7B1RPz4XulVMDXwKLHnXLr5/oJQqUNmY+6kyI
   YqL2QKhCWYgfSAAdUZHlwXpKN6UAIXootRld8b1ZRNA+IYvMwI3eV2nrw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321354498"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="321354498"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 09:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562702511"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 09:11:23 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT3pj-0000ON-0v;
        Tue, 30 Aug 2022 16:11:23 +0000
Date:   Wed, 31 Aug 2022 00:10:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/2] ACPI: PMIC: Replace open coded be16_to_cpu()
Message-ID: <202208310028.KhBuk6ZD-lkp@intel.com>
References: <20220830135532.28992-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830135532.28992-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI-PMIC-Use-sizeof-instead-of-hard-coded-value/20220830-215815
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220831/202208310028.KhBuk6ZD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2ca842435092e0995ac8c691cfdc7971ab091d78
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ACPI-PMIC-Use-sizeof-instead-of-hard-coded-value/20220830-215815
        git checkout 2ca842435092e0995ac8c691cfdc7971ab091d78
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/acpi/pmic/intel_pmic_chtdc_ti.c: In function 'chtdc_ti_pmic_get_raw_temp':
>> drivers/acpi/pmic/intel_pmic_chtdc_ti.c:96:43: warning: passing argument 3 of 'regmap_bulk_read' makes pointer from integer without a cast [-Wint-conversion]
      96 |         if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
         |                                           ^~~
         |                                           |
         |                                           __be16 {aka short unsigned int}
   In file included from include/linux/mfd/intel_soc_pmic.h:14,
                    from drivers/acpi/pmic/intel_pmic_chtdc_ti.c:13:
   include/linux/regmap.h:1167:66: note: expected 'void *' but argument is of type '__be16' {aka 'short unsigned int'}
    1167 | int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
         |                                                            ~~~~~~^~~
   drivers/acpi/pmic/intel_pmic_chtdc_ti.c:99:35: error: macro "GENMASK" requires 2 arguments, but only 1 given
      99 |         return be16_to_cpu(buf) & PMIC_REG_MASK;
         |                                   ^~~~~~~~~~~~~
   In file included from include/linux/ioport.h:13,
                    from include/linux/acpi.h:12,
                    from drivers/acpi/pmic/intel_pmic_chtdc_ti.c:10:
   include/linux/bits.h:37: note: macro "GENMASK" defined here
      37 | #define GENMASK(h, l) \
         | 
   drivers/acpi/pmic/intel_pmic_chtdc_ti.c:21:33: error: 'GENMASK' undeclared (first use in this function)
      21 | #define PMIC_REG_MASK           GENMASK(9. 0)
         |                                 ^~~~~~~
   drivers/acpi/pmic/intel_pmic_chtdc_ti.c:99:35: note: in expansion of macro 'PMIC_REG_MASK'
      99 |         return be16_to_cpu(buf) & PMIC_REG_MASK;
         |                                   ^~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic_chtdc_ti.c:21:33: note: each undeclared identifier is reported only once for each function it appears in
      21 | #define PMIC_REG_MASK           GENMASK(9. 0)
         |                                 ^~~~~~~
   drivers/acpi/pmic/intel_pmic_chtdc_ti.c:99:35: note: in expansion of macro 'PMIC_REG_MASK'
      99 |         return be16_to_cpu(buf) & PMIC_REG_MASK;
         |                                   ^~~~~~~~~~~~~
   drivers/acpi/pmic/intel_pmic_chtdc_ti.c:100:1: error: control reaches end of non-void function [-Werror=return-type]
     100 | }
         | ^
   cc1: some warnings being treated as errors


vim +/regmap_bulk_read +96 drivers/acpi/pmic/intel_pmic_chtdc_ti.c

31374972321d16 Takashi Iwai    2017-09-04   91  
31374972321d16 Takashi Iwai    2017-09-04   92  static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
31374972321d16 Takashi Iwai    2017-09-04   93  {
2ca842435092e0 Andy Shevchenko 2022-08-30   94  	__be16 buf;
31374972321d16 Takashi Iwai    2017-09-04   95  
20ea3e58eac77b Andy Shevchenko 2022-08-30  @96  	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
31374972321d16 Takashi Iwai    2017-09-04   97  		return -EIO;
31374972321d16 Takashi Iwai    2017-09-04   98  
2ca842435092e0 Andy Shevchenko 2022-08-30   99  	return be16_to_cpu(buf) & PMIC_REG_MASK;
31374972321d16 Takashi Iwai    2017-09-04  100  }
31374972321d16 Takashi Iwai    2017-09-04  101  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
