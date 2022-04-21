Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C71C50AC09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442601AbiDUXkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442595AbiDUXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:40:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF704704D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650584247; x=1682120247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hsiue63RkpFpSZcg8+e7rbdQ7Pu2T4IlMfL6usHCTU8=;
  b=CTic8GnU/PFPDkfpGSzOtM1RZwnLVgeyLq+fJePhAW3Lr770MjhtuAom
   JDo1p8wEd6z5KicppWy8uPeYre1aMFo4FQSlrRBSbQdnz690XQQLG06Px
   j8BD3EN7n0D/iYh7zIlRN5ovVEhOrfMlTHIabxYHv9n/6hoP0jgH2KsFV
   Apr3mlrCf8OoVjRV2nasMDT2RepLxjNRP+G0+oJD6mzjdf6veP+O+5XL6
   wDYVk6CDuyKu/pBMp00kWEcfL50PCGzXr+TVIYk+VKouyuSmKeXwUA8dx
   KjC99faCwmVBvAz7159T4bv9OmUKWpBYEhiBRRYvzjD8cNaJeQ4iYVjYu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245088313"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="245088313"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 16:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615150212"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 16:37:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhgMV-0008v8-SY;
        Thu, 21 Apr 2022 23:37:23 +0000
Date:   Fri, 22 Apr 2022 07:37:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [stable:linux-5.10.y 2705/5321] WARNING: modpost:
 vmlinux.o(.text+0x8cc4): Section mismatch in reference from the function
 __arm_ioremap_pfn_caller() to the function
 .meminit.text:memblock_is_map_memory()
Message-ID: <202204220723.zOZ7gZGT-lkp@intel.com>
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

Hi Mike,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
head:   1052f9bce62982023737a95b7ff1ad26a5149af6
commit: 8dd559d53b3b2de960ca1ec1359f5a9b4a12e181 [2705/5321] arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM
config: arm-hackkit_defconfig (https://download.01.org/0day-ci/archive/20220422/202204220723.zOZ7gZGT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=8dd559d53b3b2de960ca1ec1359f5a9b4a12e181
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.10.y
        git checkout 8dd559d53b3b2de960ca1ec1359f5a9b4a12e181
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x8cc4): Section mismatch in reference from the function __arm_ioremap_pfn_caller() to the function .meminit.text:memblock_is_map_memory()
The function __arm_ioremap_pfn_caller() references
the function __meminit memblock_is_map_memory().
This is often because __arm_ioremap_pfn_caller lacks a __meminit
annotation or the annotation of memblock_is_map_memory is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
