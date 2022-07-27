Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5675827A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiG0NZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiG0NZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:25:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F39EE2E;
        Wed, 27 Jul 2022 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658928329; x=1690464329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yNoz6gUDdCaF3+5NR4n7n9yqzCM4pJ5iaqzLtMQ2SD4=;
  b=FpreTkAsOMdPjK7luCmJXdk9UuqlXwaYsrbk2rJflWb1Z+nSrr//xJj3
   7k27dvBnbiot6WGI3PQFT4J8wP+2lguvM8QySB/7HF9wWHDz8aa6ohbFE
   2rh4VfI33w2EOs12AufgPy41sp5qNdrKPB7PRPlYRrAwB0k9jnkZhrEBb
   bBWaaj4Aoj8oJBMmPCwnqaSAXU2Bi3meV0JrRIyS5e9yvAbyoU0SEUdrA
   EwVYd0JFJ+JOt7eNiEeTvhcccCzd+380fSDziIW3mR1QEJqTioNvK1OL+
   eORab60fYLv+n4Fhh5czQ/s78HCSlCeR8JBTVGBzJTmnQYfNr6e/II8X1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="275106290"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="275106290"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 06:25:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="668331743"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2022 06:25:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGh2R-0008k2-0b;
        Wed, 27 Jul 2022 13:25:23 +0000
Date:   Wed, 27 Jul 2022 21:24:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>
Subject: Re: [PATCH v2 1/4] perf/amlogic: Add support for Amlogic meson G12
 SoC DDR PMU driver
Message-ID: <202207272141.rn8Zx4Az-lkp@intel.com>
References: <20220726230329.2844101-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726230329.2844101-1-jiucheng.xu@amlogic.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiucheng,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core clk/clk-next soc/for-next linus/master v5.19-rc8 next-20220726]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiucheng-Xu/perf-amlogic-Add-support-for-Amlogic-meson-G12-SoC-DDR-PMU-driver/20220727-070511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220727/202207272141.rn8Zx4Az-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/be1236818a5d0ad61b0f9ecbe5f03b9e63f99365
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jiucheng-Xu/perf-amlogic-Add-support-for-Amlogic-meson-G12-SoC-DDR-PMU-driver/20220727-070511
        git checkout be1236818a5d0ad61b0f9ecbe5f03b9e63f99365
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/perf/amlogic/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/perf/amlogic/aml_ddr_pmu_core.c: In function 'event_show_unit':
>> drivers/perf/amlogic/aml_ddr_pmu_core.c:208:38: warning: variable 'pmu_attr' set but not used [-Wunused-but-set-variable]
     208 |         struct perf_pmu_events_attr *pmu_attr;
         |                                      ^~~~~~~~
   drivers/perf/amlogic/aml_ddr_pmu_core.c: In function 'event_show_scale':
   drivers/perf/amlogic/aml_ddr_pmu_core.c:218:38: warning: variable 'pmu_attr' set but not used [-Wunused-but-set-variable]
     218 |         struct perf_pmu_events_attr *pmu_attr;
         |                                      ^~~~~~~~


vim +/pmu_attr +208 drivers/perf/amlogic/aml_ddr_pmu_core.c

   203	
   204	static ssize_t
   205	event_show_unit(struct device *dev, struct device_attribute *attr,
   206			char *page)
   207	{
 > 208		struct perf_pmu_events_attr *pmu_attr;
   209	
   210		pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
   211		return sysfs_emit(page, "MB\n");
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
