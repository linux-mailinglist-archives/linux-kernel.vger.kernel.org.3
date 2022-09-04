Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847825AC641
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiIDUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDUDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 16:03:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136328E01
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662321794; x=1693857794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jQb8mUvTMPfMjPqfrEWEt7duRWsNrq5v55Flbe+Luz4=;
  b=NBao/ALidKNEBfTDkptRLftYnFB8+GpH5eEIse7bltqro2UD/lB5Mnps
   +C0UH15fMA7s+FtVebxfFdDqOJ5h/F5K1+/Y47sqfYc2WakMx8rZjV7+m
   2l4Ivx0NcKubxqyH0mvGGnNGu39CPOclkxqa3ZVeIcMn8+iZ2ZnZ7oxkV
   FvVCGep79P8caOU1xUM17ULqoXfcWw1GlOdoDzN0JWleLSv56h6wqA1yy
   mSVB4oyBMnef1faevBnFKPQDNMEcuNauB6sdq80gfcP7KcxQmb88ZhWtR
   ymSoOMW93qjvj3fAFrYDD+58TMX9+NmLhvvQXzumwq8Kv4PPzjNbBw+1r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="357981765"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="357981765"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 13:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="590677233"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2022 13:03:13 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUvpo-0003Kf-1U;
        Sun, 04 Sep 2022 20:03:12 +0000
Date:   Mon, 5 Sep 2022 04:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 13/17]
 mapping.c:(.rodata.cst4+0x158): undefined reference to `dax_flush'
Message-ID: <202209050355.CsrTeF0B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   28533c3555d9f4cc074eb01189343adbaa47b6f5
commit: 1ea5502b1e98f725dfb7d47839ea6ab6dc201e9f [13/17] devdax: Move address_space helpers to the DAX core
config: parisc-randconfig-r004-20220904 (https://download.01.org/0day-ci/archive/20220905/202209050355.CsrTeF0B-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=1ea5502b1e98f725dfb7d47839ea6ab6dc201e9f
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout 1ea5502b1e98f725dfb7d47839ea6ab6dc201e9f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/dax/mapping.o: in function `.LC303':
>> mapping.c:(.rodata.cst4+0x158): undefined reference to `dax_flush'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
