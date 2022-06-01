Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C21953A97A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbiFAO7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiFAO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:59:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636FD6C56D;
        Wed,  1 Jun 2022 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654095551; x=1685631551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t02FFnqc6Y8S/GCyagVu8pZZE5QyASWhUXTr1q1i5K0=;
  b=dZFHALMHQZWIULn2c5ezCZoB+LG8nRa+KA7LMkqzBQ1xC7XWMQObp909
   RQZ2lViECiYmMdpFEUJz7gaYXGJIu892Oolk3IYwsugz3F05TzR3ioSid
   sC31lxxkm9oTJo5EN/DaThlPUKAGS5jP+jxyjwgXnhnBAXpkulu44juK+
   H8WPo8RQATXv+mc3lQ48KHpxJ3fTE8fqqG2ibuwK1B31HA0JoPjws6wov
   OkAvJZ0CAVT3HKtyLKX8l6FDe1hqykgYCuTGtDdcUpjFkHx/UaeXWRHMr
   235Tp9GXMwxhOxsd/6aGydM6e3lMC2427ZnZAA13oqNxkTF6v4H4DQAdy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275625370"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275625370"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 07:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="606308020"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Jun 2022 07:59:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwPoP-00045W-6Q;
        Wed, 01 Jun 2022 14:59:05 +0000
Date:   Wed, 1 Jun 2022 22:58:56 +0800
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
Message-ID: <202206012228.VPwcFQ5b-lkp@intel.com>
References: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on robh/for-next linus/master v5.18 next-20220601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/interconnect-support-i-MX8MP/20220601-174431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: parisc-randconfig-r014-20220531 (https://download.01.org/0day-ci/archive/20220601/202206012228.VPwcFQ5b-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/23ecbba75b21962f25975cb014cf981a0420dae1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/interconnect-support-i-MX8MP/20220601-174431
        git checkout 23ecbba75b21962f25975cb014cf981a0420dae1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/opp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/opp/opp.h:15,
                    from drivers/opp/core.c:22:
>> include/linux/interconnect.h:120:5: warning: no previous prototype for 'devm_of_icc_bulk_get' [-Wmissing-prototypes]
     120 | int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/devm_of_icc_bulk_get +120 include/linux/interconnect.h

   119	
 > 120	int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths)
   121	{
   122		return 0;
   123	}
   124	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
