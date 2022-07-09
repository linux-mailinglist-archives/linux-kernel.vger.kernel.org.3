Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF356CB78
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 22:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGIU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 16:58:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527C2655D;
        Sat,  9 Jul 2022 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657400295; x=1688936295;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DS7D/v/J9oCK3O5LcSqfTjUGDnZGc2qX4cJPUYDpDR0=;
  b=ZtczWKYmYmgy4uw89i8s1C3x9r8mB+yl6lRctbAlXulALzSkXEcA02G6
   b4k8qkJaOeoiEH+wu2BKPd62PGaSyfCdOfzmVuh/TXzJ3IrAhIw8tP+Cf
   5MCel0PtbealYJxmcNPsWoA8Uba50ktzW41+k55n4eRBCLrSuOutLgMQg
   pD+rDvz9yrd8Cd79Z2HLpuEMGcM0U/jDtJndl7rq+Ss+xk11TUupMO3EZ
   25XCJrbzTD4lqjEzBYtlqoTWBpJY1BGamhT1PoFD/42yzXDgK1liQwLIB
   EFHwSIYnbmr/NmaqMmn7iANi7q4/Qho2wY99es9XodXxRo9XuDFo7+UQM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="283214315"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="283214315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 13:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="651961099"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2022 13:58:13 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAHWn-000P5Q-3N;
        Sat, 09 Jul 2022 20:58:13 +0000
Date:   Sun, 10 Jul 2022 04:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/common/saa7146/saa7146_hlp.c:648:5: warning: stack
 frame size (1072) exceeds limit (1024) in 'saa7146_enable_overlay'
Message-ID: <202207100428.3iF2MNHQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b1c428b6c3684ee8ddf4137d68b3e8d51d2a700f
commit: 989cf18ed08f8b6efd1d1592d1d0108fa09b98f5 media: av7110: move driver to staging
date:   1 year, 1 month ago
config: powerpc-randconfig-r031-20220710 (https://download.01.org/0day-ci/archive/20220710/202207100428.3iF2MNHQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 77a38f6839980bfac61babb40d83772c51427011)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=989cf18ed08f8b6efd1d1592d1d0108fa09b98f5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 989cf18ed08f8b6efd1d1592d1d0108fa09b98f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/media/common/saa7146/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/common/saa7146/saa7146_hlp.c:4:
   In file included from include/linux/kernel.h:12:
   In file included from include/linux/bitops.h:32:
   In file included from arch/powerpc/include/asm/bitops.h:62:
   arch/powerpc/include/asm/barrier.h:49:9: warning: '__lwsync' macro redefined [-Wmacro-redefined]
   #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
           ^
   <built-in>:323:9: note: previous definition is here
   #define __lwsync __builtin_ppc_lwsync
           ^
>> drivers/media/common/saa7146/saa7146_hlp.c:648:5: warning: stack frame size (1072) exceeds limit (1024) in 'saa7146_enable_overlay' [-Wframe-larger-than]
   int saa7146_enable_overlay(struct saa7146_fh *fh)
       ^
   2 warnings generated.


vim +/saa7146_enable_overlay +648 drivers/media/common/saa7146/saa7146_hlp.c

^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  647  
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16 @648  int saa7146_enable_overlay(struct saa7146_fh *fh)
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  649  {
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  650  	struct saa7146_dev *dev = fh->dev;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  651  	struct saa7146_vv *vv = dev->vv_data;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  652  
5da545ad08a3c6 drivers/media/common/saa7146_hlp.c Hans Verkuil   2012-05-01  653  	saa7146_set_window(dev, vv->ov.win.w.width, vv->ov.win.w.height, vv->ov.win.field);
5da545ad08a3c6 drivers/media/common/saa7146_hlp.c Hans Verkuil   2012-05-01  654  	saa7146_set_position(dev, vv->ov.win.w.left, vv->ov.win.w.top, vv->ov.win.w.height, vv->ov.win.field, vv->ov_fmt->pixelformat);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  655  	saa7146_set_output_format(dev, vv->ov_fmt->trans);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  656  	saa7146_set_clipping_rect(fh);
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  657  
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  658  	/* enable video dma1 */
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  659  	saa7146_write(dev, MC1, (MASK_06 | MASK_22));
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  660  	return 0;
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  661  }
^1da177e4c3f41 drivers/media/common/saa7146_hlp.c Linus Torvalds 2005-04-16  662  

:::::: The code at line 648 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
