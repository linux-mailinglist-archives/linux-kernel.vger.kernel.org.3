Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C458B335
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 03:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbiHFB2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 21:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiHFB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 21:28:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354F07D1C4;
        Fri,  5 Aug 2022 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659749321; x=1691285321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ye8NVzvzBvcHA9s6ReUJQafmZ0O34T0PcCGjPKSAx8w=;
  b=esaU8RKe4gcVy5C2OvDN4xIZKN8l0bNEcoo52Oe3tAvnGyiV8LauybDQ
   hF0PBQgviLsaCfvtw3PyDQ6OCkokDglzgN2Kr3sFMa1ElFTZG75UDPrhy
   ZTExLHAY57ZRkNF+P0emM4trsD189amIUDb6eN5zEFLN5Tu96qr0SlqKu
   SqQZ+GSooKKT7KFoNQa/5EE6JBayB5a+dQ0jIqa/kP1aVG5a5pivq+tyY
   q4xsTU/fE2Dm40rg0zSBQeNo1oXC/wUDnvmvlU29vYr7Lb1meP5FlagCp
   wnMdl5f9r7/+QwEODmyC/R9WYGakTi/9jqabS1c20RicypolAWsOAFUfo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="290334363"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="290334363"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 18:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="693181583"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Aug 2022 18:28:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK8cI-000Jtw-0C;
        Sat, 06 Aug 2022 01:28:38 +0000
Date:   Sat, 6 Aug 2022 09:27:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     kbuild-all@lists.01.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 05/26] thermal/drivers/tegra: Use generic
 thermal_zone_get_trip() function
Message-ID: <202208060952.zqreQz9o-lkp@intel.com>
References: <20220805145729.2491611-6-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805145729.2491611-6-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220804]
[cannot apply to rafael-pm/thermal tegra/for-next linus/master v5.19 v5.19-rc8 v5.19-rc7 v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/Rework-the-trip-points-creation/20220805-230055
base:    899926f2ccb4453c51943f6738a71b2c5ad98b71
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220806/202208060952.zqreQz9o-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/17490c33351b77ce054a22f2e41306ca6c18cd99
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/Rework-the-trip-points-creation/20220805-230055
        git checkout 17490c33351b77ce054a22f2e41306ca6c18cd99
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "thermal_zone_get_trip" [drivers/thermal/tegra/tegra-soctherm.ko] undefined!
>> ERROR: modpost: "thermal_zone_get_trip" [drivers/thermal/tegra/tegra30-tsensor.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
