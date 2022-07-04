Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E24565F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiGDWdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 18:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGDWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 18:33:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61B5F4C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 15:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656973983; x=1688509983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RyqhGxxSoSHVqs37oh38pEe204DIZNPq7agVLq/Xp9c=;
  b=JNQkSoR7RceD5pz4MtYmRM3BPZQOdyDwz3oEoXbneDZlA3I7rO6aHQAK
   Q3kOZP3S36RuQDBPW5rBzSRhVK/ZRat9wg2QGee6C6n9pPye/5J+mrTq4
   5EXzjWbnlscChNGPCDk55GU0RjBpjFpmyQJEuGinBgf6VDu/GSPkH61ze
   QUIyim6Imk6+C6kS8HWzWpqFW1YqztD8eAoV7dRJD6WA/B8TAGPsNuCkJ
   YXrhiSzqnOcP0pYwCZW62a1ZtJ+twpWJel4THhhy7vHvgLec+/qhyM5Fo
   w2byO4yM3G2Ch6h8TLHPrM7LHqdGlHpmKhR3mYHOuat1ZztxsCXHYqtqX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="271979547"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="271979547"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:33:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="567353349"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jul 2022 15:33:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Ucm-000ILy-PT;
        Mon, 04 Jul 2022 22:33:00 +0000
Date:   Tue, 5 Jul 2022 06:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [esmil:visionfive 2/49] string.c:undefined reference to `_mcount'
Message-ID: <202207050658.KhrLDT6s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   575362a88f9e6ef14a1a35eb7bd1593745cf019e
commit: 6a48862f530a593cadaab50ae4006b3a70a112e6 [2/49] riscv: optimized memcpy
config: riscv-buildonly-randconfig-r001-20220703 (https://download.01.org/0day-ci/archive/20220705/202207050658.KhrLDT6s-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/6a48862f530a593cadaab50ae4006b3a70a112e6
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 6a48862f530a593cadaab50ae4006b3a70a112e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/purgatory/purgatory.ro: in function `.L355':
>> string.c:(.text+0x20e0): undefined reference to `_mcount'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
