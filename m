Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8B50DE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbiDYLMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbiDYLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:12:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082B612A94
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650884976; x=1682420976;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aVfklPl8F97C3QlZfb1wntXnrbpkkWL2ySVlme3e6Wk=;
  b=hhSxbYipdmY5GSHeVUIoE0ivb0zrsN6Fef9euvLKebq9aeR35NoIPcyz
   hXqu/CCtigo/V8wTo4UrQvI9BbyBLy+1DpjYbRWdO/hHRffog0vQMXz3B
   Cv3cTvmwq3MpLL+oTBR/Yz1RoTWpW5W+5ND1P9u54gY5QfsNiZHsricb0
   yB1rrxCUdarvNIyKTYiJr4yC/kBHM3QEaeq22xWkifzermwFD+VhbPszC
   ke5Msh1XbNrUSN9Vd3Y4bGUgn+56Do/jCXELzJCFdEmsHFAf64zc7yPNo
   kzN/WG1gXk56B4Kn1GEjZB0L7S+qvplJh81b1mjBHawG/8BJ6rPk72z6r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="245784775"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="245784775"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="595193811"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2022 04:09:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niwaz-0002RM-9J;
        Mon, 25 Apr 2022 11:09:33 +0000
Date:   Mon, 25 Apr 2022 19:09:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [rppt:fixes/arm-ioremap-pfn-valid-v2 1/1] ld.lld: error: undefined
 symbol: arch_memremap_can_ram_remap
Message-ID: <202204251950.LxDogI1Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git fixes/arm-ioremap-pfn-valid-v2
head:   7c4b7785fd9fb0564245417bbca100f3e88e48a9
commit: 7c4b7785fd9fb0564245417bbca100f3e88e48a9 [1/1] arm[64]/memremap: don't abuse pfn_valid() to ensure presence of linear map
config: arm-buildonly-randconfig-r006-20220425 (https://download.01.org/0day-ci/archive/20220425/202204251950.LxDogI1Q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=7c4b7785fd9fb0564245417bbca100f3e88e48a9
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt fixes/arm-ioremap-pfn-valid-v2
        git checkout 7c4b7785fd9fb0564245417bbca100f3e88e48a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: arch_memremap_can_ram_remap
   >>> referenced by iomem.c
   >>>               iomem.o:(memremap) in archive kernel/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
