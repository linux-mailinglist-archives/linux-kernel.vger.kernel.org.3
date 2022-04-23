Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1950C707
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiDWDuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiDWDtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:49:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B417E18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650685605; x=1682221605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CpwUEPhvROzXnQPbUtKRRdh+SpyfvXHZowOEY+MMlYc=;
  b=Fqx6duZG13Pq1/uFqCQVC/8H0GFZNmzVAWNC8tRW9MdVAh62Vpoa9ueO
   Q2GeIr8H+mUZaj3XIIEp5Z13Vo8NjRgRBX0q8SO/DRMC9qtJanEcXFN6a
   llX1pu+ziNeHjFQUkC/EJ1cnU7wuKmijSRVOa4lTZtA6wEQRmESfif3TH
   7NIZnI/gFxTJtv9wPil7R3lRF4aR5qAALuihKax39AMM74x+VKItu6INB
   HoJVbpL2gJETebJuGuRvb91xo7033LI1jhEMBN99SCf18eF8gc1pEd1Zg
   nuFUfMZEBAduRAjjYHYcWK2xWiCLce/a3UvdNdLximbUBahKfJFEDIX6c
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327756776"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="327756776"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 20:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="648897786"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2022 20:46:42 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni6jJ-000AyR-W1;
        Sat, 23 Apr 2022 03:46:42 +0000
Date:   Sat, 23 Apr 2022 11:45:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] soc: rockchip: Fix compile-testing SoC drivers
Message-ID: <202204231158.8u0SOzm6-lkp@intel.com>
References: <20220422111914.1.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422111914.1.Id5f16dec920f620120c0a143a97a12e16d401760@changeid>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

I love your patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on soc/for-next linus/master v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Norris/soc-rockchip-Fix-compile-testing-SoC-drivers/20220423-022353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220423/202204231158.8u0SOzm6-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bb37a0dd33d08baf273f38dbea4951d50f020588
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Brian-Norris/soc-rockchip-Fix-compile-testing-SoC-drivers/20220423-022353
        git checkout bb37a0dd33d08baf273f38dbea4951d50f020588
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/rockchip/pm_domains.c: In function 'rockchip_pmu_set_idle_request':
>> drivers/soc/rockchip/pm_domains.c:181:9: error: implicit declaration of function 'dsb' [-Werror=implicit-function-declaration]
     181 |         dsb(sy);
         |         ^~~
>> drivers/soc/rockchip/pm_domains.c:181:13: error: 'sy' undeclared (first use in this function); did you mean 's8'?
     181 |         dsb(sy);
         |             ^~
         |             s8
   drivers/soc/rockchip/pm_domains.c:181:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/soc/rockchip/pm_domains.c: In function 'rockchip_do_pmu_set_power_domain':
   drivers/soc/rockchip/pm_domains.c:288:13: error: 'sy' undeclared (first use in this function); did you mean 's8'?
     288 |         dsb(sy);
         |             ^~
         |             s8
   cc1: some warnings being treated as errors


vim +/dsb +181 drivers/soc/rockchip/pm_domains.c

e4c8cd82d5e114 Caesar Wang  2016-10-13  159  
7c696693a4f54d Caesar Wang  2015-09-08  160  static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
7c696693a4f54d Caesar Wang  2015-09-08  161  					 bool idle)
7c696693a4f54d Caesar Wang  2015-09-08  162  {
7c696693a4f54d Caesar Wang  2015-09-08  163  	const struct rockchip_domain_info *pd_info = pd->info;
e4c8cd82d5e114 Caesar Wang  2016-10-13  164  	struct generic_pm_domain *genpd = &pd->genpd;
7c696693a4f54d Caesar Wang  2015-09-08  165  	struct rockchip_pmu *pmu = pd->pmu;
e4c8cd82d5e114 Caesar Wang  2016-10-13  166  	unsigned int target_ack;
7c696693a4f54d Caesar Wang  2015-09-08  167  	unsigned int val;
e4c8cd82d5e114 Caesar Wang  2016-10-13  168  	bool is_idle;
e4c8cd82d5e114 Caesar Wang  2016-10-13  169  	int ret;
7c696693a4f54d Caesar Wang  2015-09-08  170  
6aa841c8097fee Elaine Zhang 2016-03-10  171  	if (pd_info->req_mask == 0)
6aa841c8097fee Elaine Zhang 2016-03-10  172  		return 0;
79bb17ce8edb31 Elaine Zhang 2016-12-23  173  	else if (pd_info->req_w_mask)
79bb17ce8edb31 Elaine Zhang 2016-12-23  174  		regmap_write(pmu->regmap, pmu->info->req_offset,
79bb17ce8edb31 Elaine Zhang 2016-12-23  175  			     idle ? (pd_info->req_mask | pd_info->req_w_mask) :
79bb17ce8edb31 Elaine Zhang 2016-12-23  176  			     pd_info->req_w_mask);
79bb17ce8edb31 Elaine Zhang 2016-12-23  177  	else
7c696693a4f54d Caesar Wang  2015-09-08  178  		regmap_update_bits(pmu->regmap, pmu->info->req_offset,
7c696693a4f54d Caesar Wang  2015-09-08  179  				   pd_info->req_mask, idle ? -1U : 0);
7c696693a4f54d Caesar Wang  2015-09-08  180  
7c696693a4f54d Caesar Wang  2015-09-08 @181  	dsb(sy);
7c696693a4f54d Caesar Wang  2015-09-08  182  
e4c8cd82d5e114 Caesar Wang  2016-10-13  183  	/* Wait util idle_ack = 1 */
e4c8cd82d5e114 Caesar Wang  2016-10-13  184  	target_ack = idle ? pd_info->ack_mask : 0;
e4c8cd82d5e114 Caesar Wang  2016-10-13  185  	ret = readx_poll_timeout_atomic(rockchip_pmu_read_ack, pmu, val,
e4c8cd82d5e114 Caesar Wang  2016-10-13  186  					(val & pd_info->ack_mask) == target_ack,
e4c8cd82d5e114 Caesar Wang  2016-10-13  187  					0, 10000);
e4c8cd82d5e114 Caesar Wang  2016-10-13  188  	if (ret) {
e4c8cd82d5e114 Caesar Wang  2016-10-13  189  		dev_err(pmu->dev,
e4c8cd82d5e114 Caesar Wang  2016-10-13  190  			"failed to get ack on domain '%s', val=0x%x\n",
e4c8cd82d5e114 Caesar Wang  2016-10-13  191  			genpd->name, val);
e4c8cd82d5e114 Caesar Wang  2016-10-13  192  		return ret;
e4c8cd82d5e114 Caesar Wang  2016-10-13  193  	}
7c696693a4f54d Caesar Wang  2015-09-08  194  
e4c8cd82d5e114 Caesar Wang  2016-10-13  195  	ret = readx_poll_timeout_atomic(rockchip_pmu_domain_is_idle, pd,
e4c8cd82d5e114 Caesar Wang  2016-10-13  196  					is_idle, is_idle == idle, 0, 10000);
e4c8cd82d5e114 Caesar Wang  2016-10-13  197  	if (ret) {
e4c8cd82d5e114 Caesar Wang  2016-10-13  198  		dev_err(pmu->dev,
e4c8cd82d5e114 Caesar Wang  2016-10-13  199  			"failed to set idle on domain '%s', val=%d\n",
e4c8cd82d5e114 Caesar Wang  2016-10-13  200  			genpd->name, is_idle);
e4c8cd82d5e114 Caesar Wang  2016-10-13  201  		return ret;
e4c8cd82d5e114 Caesar Wang  2016-10-13  202  	}
7c696693a4f54d Caesar Wang  2015-09-08  203  
7c696693a4f54d Caesar Wang  2015-09-08  204  	return 0;
7c696693a4f54d Caesar Wang  2015-09-08  205  }
7c696693a4f54d Caesar Wang  2015-09-08  206  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
