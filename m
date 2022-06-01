Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEA53A607
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353309AbiFANi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353299AbiFANiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:38:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42345F8EB;
        Wed,  1 Jun 2022 06:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654090693; x=1685626693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LY/jDnHvBdo9PvVaRUZPxc5ZeLVIfMPgbA4VYWa03gs=;
  b=Ox3soQNPTCXwO6a4Q1w+VgU4jAVKMWewIKikWTT8teYBOgx67exl0scH
   +AHE7QdqP92EIqDAzsuj9FYFd2EcgrnxZL/nJKG47ldVuvTFRQRt8ONtu
   TtCTIz2TCn2QZyqkgd6gTskB4ByW6ZKeY2NKkkkZA3h7RFC8ceIu0cVHp
   QS47nDeuPVtB0/yTaBzIW8rj4LWajgwCTudWz8eTDH5lxiMoeHWTy4UgL
   oOGGikqeDHylKUCemI5OfCNCbUxEMQFpbQVBWnM0pj7LfglA6PXqw3oCM
   3Q+X82pfwz5EyH7S4Gm9yFkbiqkd2Q7UpvvwaiiSypr46KbtUZpDhApBy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275313304"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275313304"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:38:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="530061782"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2022 06:38:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwOXz-00041w-0f;
        Wed, 01 Jun 2022 13:38:03 +0000
Date:   Wed, 1 Jun 2022 21:37:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/8] interconnect: add device managed bulk API
Message-ID: <202206012118.zBGUugaB-lkp@intel.com>
References: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on robh/for-next linus/master v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/interconnect-support-i-MX8MP/20220601-174431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: riscv-randconfig-r042-20220531 (https://download.01.org/0day-ci/archive/20220601/202206012118.zBGUugaB-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/23ecbba75b21962f25975cb014cf981a0420dae1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/interconnect-support-i-MX8MP/20220601-174431
        git checkout 23ecbba75b21962f25975cb014cf981a0420dae1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/opp/core.o: in function `devm_of_icc_bulk_get':
>> include/linux/interconnect.h:121: multiple definition of `devm_of_icc_bulk_get'; drivers/usb/dwc3/dwc3-qcom.o:include/linux/interconnect.h:121: first defined here
   riscv64-linux-ld: drivers/opp/cpu.o: in function `devm_of_icc_bulk_get':
>> include/linux/interconnect.h:121: multiple definition of `devm_of_icc_bulk_get'; drivers/usb/dwc3/dwc3-qcom.o:include/linux/interconnect.h:121: first defined here
   riscv64-linux-ld: drivers/opp/of.o: in function `devm_of_icc_bulk_get':
>> include/linux/interconnect.h:121: multiple definition of `devm_of_icc_bulk_get'; drivers/usb/dwc3/dwc3-qcom.o:include/linux/interconnect.h:121: first defined here
   riscv64-linux-ld: drivers/opp/debugfs.o: in function `devm_of_icc_bulk_get':
>> include/linux/interconnect.h:121: multiple definition of `devm_of_icc_bulk_get'; drivers/usb/dwc3/dwc3-qcom.o:include/linux/interconnect.h:121: first defined here

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +121 include/linux/interconnect.h

   119	
   120	int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
 > 121	{
   122		return 0;
   123	}
   124	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
