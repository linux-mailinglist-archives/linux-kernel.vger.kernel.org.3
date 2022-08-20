Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF659AE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345660AbiHTNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHTNws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:52:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75EAE71
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661003567; x=1692539567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z+LRbWEptXOas6C5pGSIG0LEFok4zlBYqdcM/3t8qRo=;
  b=dG2pVx+GnYbL1+zdsk5KSM27xNEeh0oqj0x3qDa8Gh7HS719GWkqbqlP
   BPSkPj75789swKNlthuhr1L+RmJcx55M4dLZ+GnmR8ojDzGlOgzCCirqV
   Rb5dgGPJgBJOZ1p/+MYbYYTShpvCGrAKJB+I/F4i6p59D9W3cE2Xhmi7p
   OuPm6R9t1Di2X7dB+VAtYTHp5avVWnzgq5qAyOpJADq8J7uq1w1MF3DOb
   HJ8AeNGFg4Cw0a1U6u3PnrevKOYbZSLnhiE+0pIkCeNGC6C/8oMLtMl/n
   5wqMyvNjyysF4goDHr2xms3D3oDKWs98pVwwwLWn4kIXTzibJ5OyLMD7H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="293962401"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="293962401"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 06:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637602877"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2022 06:52:46 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPOu5-0002kV-2W;
        Sat, 20 Aug 2022 13:52:45 +0000
Date:   Sat, 20 Aug 2022 21:52:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!
Message-ID: <202208202148.h0tHkBcn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50cd95ac46548429e5bba7ca75cc97d11a697947
commit: ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f PHY: Ingenic: fix unconditional build of phy-ingenic-usb
date:   1 year, 8 months ago
config: s390-randconfig-m031-20220820 (https://download.01.org/0day-ci/archive/20220820/202208202148.h0tHkBcn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!
ERROR: modpost: "iounmap" [drivers/pcmcia/pcmcia.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
