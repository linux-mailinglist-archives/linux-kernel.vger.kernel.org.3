Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71A53A5B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353154AbiFANPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353201AbiFANPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:15:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F23D491;
        Wed,  1 Jun 2022 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654089307; x=1685625307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u7ZLlN9ab0mHsIRqx2mjBaMaUlNGl85e+RLEouUCsbM=;
  b=DXOBvjMofAJgjYBTectnfjtdPPCoXsdS7yGTXd5pB8VFI36O5DXyZ+aF
   N5cU8v3E90nd+sFkDV4PtROfcdSjsu0ONoxrwFSSzMnIcEFf9sA0Z6fpe
   091WKidcAF6/oetMfNSZRWmtAQnE8obi8tIwdGWr+Wyf4VRBDwHplQcBS
   xNwcjzz32lmNo3nHQt0zAgUoZIlK9vkSBf4I790KXwyIZ9mBnKnXJZLB+
   QIBqsOlMLN7Rvx9R9lgmgnyN8Q0EhQJeMDMgV1n/n7IZcVcBSeYNu0954
   JUXvzO7Wa3BPBE6RpYjSBPuDN5ID7CcHaNemNn55pvh+AUmTg++YcRN/e
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="273151672"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="273151672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="581576162"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2022 06:15:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwOBi-00040M-5B;
        Wed, 01 Jun 2022 13:15:02 +0000
Date:   Wed, 1 Jun 2022 21:15:00 +0800
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
Message-ID: <202206012137.3VySlLwf-lkp@intel.com>
References: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601094156.3388454-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220601/202206012137.3VySlLwf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/23ecbba75b21962f25975cb014cf981a0420dae1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/interconnect-support-i-MX8MP/20220601-174431
        git checkout 23ecbba75b21962f25975cb014cf981a0420dae1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/opp/cpu.o: in function `devm_of_icc_bulk_get':
>> cpu.c:(.text+0x2ad): multiple definition of `devm_of_icc_bulk_get'; drivers/opp/core.o:core.c:(.text+0xa4a): first defined here
   ld: drivers/opp/debugfs.o: in function `devm_of_icc_bulk_get':
   debugfs.c:(.text+0x13c): multiple definition of `devm_of_icc_bulk_get'; drivers/opp/core.o:core.c:(.text+0xa4a): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
