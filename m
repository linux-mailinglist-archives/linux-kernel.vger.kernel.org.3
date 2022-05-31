Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1695D539337
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbiEaOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiEaOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:37:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B921E12
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654007837; x=1685543837;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y3T67bfAQbnZiZb2PCR9IrVytbv/b6C8m2GiQK7Xh+s=;
  b=TI2kldCZzvmr8y5NSI/QrA61Fx09Hjc1fSVKoAkOD1T5vmDP2paHpm6g
   OnQZ3cykDr2GyROvNY3N8zH31KP2Ajag/ZWrdCWvPyPV6cNMQKdU5jwfY
   M98f0DoJthMvOi5WQB3oP8Rp39+Hjn5fdZq69SklOWuxjsF5ZC/0NxhG5
   qok+IryvalOCAMtv1TjWK2YrEaAiQKSYONkMaTyg74qOsaG8lj2NzY7Xt
   6+5hpb6UliGosHGVxasvm4KX56WAHv8zBFKaDtjjqKPfYBEiMZVSMtWRG
   bkGgwzgpFTurZk67KE8QE4CIIaBMXZP74IZeimgMtG5H3girZQILMr+rv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="274995960"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="274995960"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="529604918"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2022 07:37:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw2zi-0002mo-7f;
        Tue, 31 May 2022 14:37:14 +0000
Date:   Tue, 31 May 2022 22:36:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangrui Song <maskray@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: ld.lld: error: undefined symbol: .early_setup
Message-ID: <202205312222.XiSqyPc4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fangrui,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
commit: 0355785313e2191be4e1108cdbda94ddb0238c48 powerpc: Add "-z notext" flag to disable diagnostic
date:   10 months ago
config: powerpc64-randconfig-r023-20220530 (https://download.01.org/0day-ci/archive/20220531/202205312222.XiSqyPc4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0776c48f9b7e69fa447bee57c7c0985caa856be9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0355785313e2191be4e1108cdbda94ddb0238c48
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0355785313e2191be4e1108cdbda94ddb0238c48
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: .early_setup
   >>> referenced by arch/powerpc/kernel/head_64.o:(.ref.text+0xAE)
   >>> did you mean: early_setup
   >>> defined in: arch/powerpc/built-in.a(kernel/setup_64.o)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
