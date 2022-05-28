Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1C536DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiE1QFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiE1QFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 12:05:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66D186FC
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653753944; x=1685289944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=41f6nQqX5SfJr8qZx9k03+3R+1jTiVNNGqfIrJHosSU=;
  b=YZEmIleGuy8NWvSr5yTtuRDiIZ9xtx2Qs+xixV/wg84PUO7Z8RB4wxkh
   zvsdYu3qQJ+g5JMxzY8/MAJyBc2DiroI5t5FeM50YjFljYkR31rWkUWQr
   eBaXbSifnabt1aoXrCk1AGcl1Gf4MY9iz2xuQvHP/GSBT9xQ1+GE0nFwE
   eHH+76hZnc//erD7+7RpCiPZyQ1ki2kqn1PoXBIWww0lwpWTrohTN/fr/
   2jyFjBJmYxq3KyMBP+VcL3VU0qGL+ubK2oPS22SGg66lceYMZQaUCbYu0
   3E3Q72bFLO++VR1Aif1O2yOao40nT2iqTfmJyHbFcJISxUmOC8RsXUyr3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="272258835"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="272258835"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 09:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="705582803"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2022 09:05:42 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuywf-0000Jg-FX;
        Sat, 28 May 2022 16:05:41 +0000
Date:   Sun, 29 May 2022 00:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: llvm-objcopy: error: invalid output format: 'elf64-s390'
Message-ID: <202205290045.gOvUOkt3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
commit: adda746629b4a3950f313bc645fa0e54daee871c s390/purgatory: workaround llvm's IAS limitations
date:   11 days ago
config: s390-randconfig-c005-20220527 (https://download.01.org/0day-ci/archive/20220529/202205290045.gOvUOkt3-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adda746629b4a3950f313bc645fa0e54daee871c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout adda746629b4a3950f313bc645fa0e54daee871c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> llvm-objcopy: error: invalid output format: 'elf64-s390'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
