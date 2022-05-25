Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665FD53364B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbiEYE6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiEYE6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:58:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA836C567
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 21:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653454723; x=1684990723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lOGX5VEv5nSr4EzohX9ltE+U91lw+VsFXzW7yOO7l9A=;
  b=aOtjL7XPHXacrCllvs+NqAFbmlzRovGoptN8+6NC/kLTpmQlb38nNLmj
   uGj010ocMJrx5wPdYrTyjRe3DQbgqKY6N0zQVi3hZqSgY4AOtP6ZsQny5
   8UaAdIqSjYlwp1wqFoxgFdifkZ4RI4BNkkNBBNgsfagPGNKdMc9m9Vh2y
   W6Vb6FJXc9ji5gkWkaUH8mNRWnaZzN5OUkmrsYEAAgydnXovPD+Me3sPd
   XVpBFygx+5CzXBA6Y2u8fRl7t7+QsvEpxuWqJVyL8A7frnGgJvHl0rMRb
   RJhdYRbt9Osa4Z1p4wky1VLlUOTkBnOuG+oqECCguQZoCHFWYRiLXWG41
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="253590991"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="253590991"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="642224215"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2022 21:58:41 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntj6X-0002ja-2p;
        Wed, 25 May 2022 04:58:41 +0000
Date:   Wed, 25 May 2022 12:58:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: ld.lld: error: undefined symbol: pci_remap_iospace
Message-ID: <202205251247.nQ5cxSV6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fdaf9a5840acaab18694a19e0eb0aa51162eeeed
commit: 09d97da660ff77df20984496aa0abcd6b88819f2 MIPS: Only define pci_remap_iospace() for Ralink
date:   6 months ago
config: mips-randconfig-r022-20220524 (https://download.01.org/0day-ci/archive/20220525/202205251247.nQ5cxSV6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09d97da660ff77df20984496aa0abcd6b88819f2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09d97da660ff77df20984496aa0abcd6b88819f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pci_remap_iospace
   >>> referenced by pci.c
   >>>               pci/pci.o:(devm_pci_remap_iospace) in archive drivers/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
