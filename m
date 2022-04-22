Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E6550ACA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442815AbiDVAL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiDVALW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:11:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2E36E36
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650586110; x=1682122110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vKQKRGNX/LjG7VONiUEUdfNSavJK5wTiNpc5+4uauOI=;
  b=gwjiNhIPNY1hRVfcud2c4AYLQiDVeG++0DnpNrjtPvhRCvh5lfCaO7J9
   ixCRSC5xEFVak600bGsYtQT4faLDcKgifjuketNoBWMKi/YdZrwN3ciJ9
   Uz4/K7ZDglI7Twwh6CZmRTpF5m1KVVJSTFNIWX/pEZKW7d/blPzcZdpkg
   ak+iklgD4UjPH1XjIqX1ZHY+Qcm7Aruj2/FkR3EYgJwDBZEVueZohhLbp
   qBBjsQ6OJXxhhpHwmyJ1syDABqztwRD/J7jrX7mllPPg6zJaoPFnLTIJP
   mbQ7mY7w2yngqJsJTjNwA1HiSGEx/j1cZKYk5XGvtyPnvvxLaXVM0CSy6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264686770"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264686770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="562808264"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2022 17:08:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhgqZ-0008zc-Hz;
        Fri, 22 Apr 2022 00:08:27 +0000
Date:   Fri, 22 Apr 2022 08:07:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH v2] firmware: arm_scmi: support optee shared memory in
 optee transport
Message-ID: <202204220711.5cl9KJrB-lkp@intel.com>
References: <20220421074935.7549-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421074935.7549-1-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v5.18-rc3 next-20220421]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Etienne-Carriere/firmware-arm_scmi-support-optee-shared-memory-in-optee-transport/20220421-155132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm64-randconfig-r034-20220421 (https://download.01.org/0day-ci/archive/20220422/202204220711.5cl9KJrB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/8baa12e16d3e48bce0e6d86e8c7d0415439b7c98
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Etienne-Carriere/firmware-arm_scmi-support-optee-shared-memory-in-optee-transport/20220421-155132
        git checkout 8baa12e16d3e48bce0e6d86e8c7d0415439b7c98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: msg_tx_prepare
   >>> referenced by optee.c
   >>> firmware/arm_scmi/optee.o:(scmi_optee_send_message) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: msg_command_size
   >>> referenced by optee.c
   >>> firmware/arm_scmi/optee.o:(scmi_optee_send_message) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: msg_fetch_response
   >>> referenced by optee.c
   >>> firmware/arm_scmi/optee.o:(scmi_optee_fetch_response) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
