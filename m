Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2D5AEFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiIFQEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiIFQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:04:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC7982D26;
        Tue,  6 Sep 2022 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662477999; x=1694013999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCGvO6ccyPPJxWuEZsuICJQLGQb8YbWmDASVlzIokmk=;
  b=dob+eM/lrLt3CeB8ToZ37H/xX+bfA9CW8cR2cLukjjPWI+nBuwN5/OHs
   nk/J6shPiq33tRjL7tG/jV5OTDTCTXruzjZiG+DCfegnJI9Fz6Sv6hrf1
   j/lmXs823TYs1Kp02//6glZKKxZlsvypXA15VVHpjF4kr3sraPLklQ/22
   R/p1WoHvabA5A+v4sCAUS4BqgPVo1xZVaLF5vwff2pE0/o3wsLXkoTuYc
   /8gHwzopjTg99MtFVDHKNX0mmrYS9oXFczSL2q9qekvnQ4SSxnOln30Hx
   LbEPq4X+jTAs4s0ScZvhIrrK8ZXpMyo1SYW3pmT8ApVegELVrVS15SIOB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360569124"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360569124"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682433423"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 08:26:33 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVaT5-0005Fd-2M;
        Tue, 06 Sep 2022 15:26:27 +0000
Date:   Tue, 6 Sep 2022 23:25:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH 1/8] memory: tegra: Add API for retrieving carveout bounds
Message-ID: <202209062313.buowJWo0-lkp@intel.com>
References: <20220906132823.2390953-2-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906132823.2390953-2-cyndis@kapsi.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikko,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next krzk-mem-ctrl/for-next pza/reset/next linus/master v6.0-rc4 next-20220906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikko-Perttunen/Support-for-NVDEC-on-Tegra234/20220906-215151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220906/202209062313.buowJWo0-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7e2bd1173420c8e09ec90e3322e059a7350482e3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mikko-Perttunen/Support-for-NVDEC-on-Tegra234/20220906-215151
        git checkout 7e2bd1173420c8e09ec90e3322e059a7350482e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/memory/tegra/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/memory/tegra/mc.c: In function 'tegra_mc_get_carveout_info':
>> drivers/memory/tegra/mc.c:124:83: warning: left shift count >= width of type [-Wshift-count-overflow]
     124 |         *base |= (phys_addr_t)mc_ch_readl(mc, MC_BROADCAST_CHANNEL, offset + 0x4) << 32;
         |                                                                                   ^~


vim +124 drivers/memory/tegra/mc.c

   109	
   110	int tegra_mc_get_carveout_info(struct tegra_mc *mc, unsigned int id,
   111	                               phys_addr_t *base, u64 *size)
   112	{
   113		u32 offset;
   114	
   115		if (id < 1 || id >= mc->soc->num_carveouts)
   116			return -EINVAL;
   117	
   118		if (id < 6)
   119			offset = 0xc0c + 0x50 * (id - 1);
   120		else
   121			offset = 0x2004 + 0x50 * (id - 6);
   122	
   123		*base = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, offset + 0x0);
 > 124		*base |= (phys_addr_t)mc_ch_readl(mc, MC_BROADCAST_CHANNEL, offset + 0x4) << 32;
   125	
   126		if (size)
   127			*size = mc_ch_readl(mc, MC_BROADCAST_CHANNEL, offset + 0x8) << 17;
   128	
   129		return 0;
   130	}
   131	EXPORT_SYMBOL_GPL(tegra_mc_get_carveout_info);
   132	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
