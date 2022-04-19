Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19F506403
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348708AbiDSFsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiDSFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:48:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6B7275D5;
        Mon, 18 Apr 2022 22:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650347131; x=1681883131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vev6gjgEbwCGFpCPTJ0Me7AodsncIvTd07Czu7YvlQ=;
  b=HOQHrNbXyy5a3csRDeLw69ZtDSsIBcCn6K3rLzNQn8gyf0tGnbCZqYg2
   wUgMo7j232W90FuNqU9EDoKRNpBM47nyoyDo6qN8Q+2BnwdUjfow+Zfxn
   TeLKyBSbiF5Wf/IXBYunbOjqHrPn9SYoiGzCAYSCcAVGvu6Nl8AL5zTtj
   JY+wACehM8o0G0Wqga06WwFs2vg7G0+myQl9FS9s77H10PRXGif0Jc3zl
   ptmVy9njwDBDnutJykYs9cOtkoFYdru6RWUks5aBSh8Hozq++XprtkSnu
   J1wD5IapX7vQWiSGJTslQHQfl+JwYV1rVl8rZMGygjIzuyHdCFuXmqyk+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261285285"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="261285285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="592654739"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2022 22:45:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nggg3-0005Ok-AS;
        Tue, 19 Apr 2022 05:45:27 +0000
Date:   Tue, 19 Apr 2022 13:45:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, list@opendingux.net,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/5] rtc: jz4740: Register clock provider for the CLK32K
 pin
Message-ID: <202204191348.uUoPjD9I-lkp@intel.com>
References: <20220418184933.13172-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418184933.13172-5-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Yet something to improve:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/rtc-ingenic-various-updates/20220419-025341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: hexagon-randconfig-r041-20220419 (https://download.01.org/0day-ci/archive/20220419/202204191348.uUoPjD9I-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a8eada718214bc34ea29f8ff353228abacc0bfb9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/rtc-ingenic-various-updates/20220419-025341
        git checkout a8eada718214bc34ea29f8ff353228abacc0bfb9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: devm_clk_hw_register
   >>> referenced by rtc-jz4740.c
   >>> rtc/rtc-jz4740.o:(jz4740_rtc_probe) in archive drivers/built-in.a
   >>> referenced by rtc-jz4740.c
   >>> rtc/rtc-jz4740.o:(jz4740_rtc_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: of_clk_hw_simple_get
   >>> referenced by rtc-jz4740.c
   >>> rtc/rtc-jz4740.o:(jz4740_rtc_probe) in archive drivers/built-in.a
   >>> referenced by rtc-jz4740.c
   >>> rtc/rtc-jz4740.o:(jz4740_rtc_probe) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: of_clk_add_hw_provider
   >>> referenced by rtc-jz4740.c
   >>> rtc/rtc-jz4740.o:(jz4740_rtc_probe) in archive drivers/built-in.a
   >>> referenced by rtc-jz4740.c
   >>> rtc/rtc-jz4740.o:(jz4740_rtc_probe) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
