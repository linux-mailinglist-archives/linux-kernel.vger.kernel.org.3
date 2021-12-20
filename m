Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39AF47B345
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhLTSzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:55:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:15151 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhLTSzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640026519; x=1671562519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TmqgGeucLGZnyhqVlqCwWmUp6vjmwJf9wJg2gbgOpjI=;
  b=LBwYZscD2+6oirdn5KrR94DKthFUKjL4r0VNKu8we592XbSYJPs6SGxr
   O/LYb4OSBhq6yXm51bVR8A2rreffWc0fvbGdU2qDaTiibiC2vIzm8tCSz
   rN+GV2DZ7p13j2+8j6+Vxpp2o4iGO3UCoaii5C/jEqMWXF32khYmyiwC+
   4eFve74oUaQuHGA6id3SMeRulJ3epwa0P35j/3e67lsZwV3fSzx/EjOTo
   xNwAXW34PMgL4Ec4MRNEdkTt10kXISYXYIdw2/hfAiALaXUaPq9bodSq6
   K1JDIErtXkOE/Y+A3FES1HHA5fKfdPL+/ul9Pg4rkwUFryju0cQZJEaFf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="220925047"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="220925047"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 10:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="467503582"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2021 10:55:16 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzNoa-00087P-0h; Mon, 20 Dec 2021 18:55:16 +0000
Date:   Tue, 21 Dec 2021 02:54:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Nyekjaer <sean@geanix.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Sean Nyekjaer <sean@geanix.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: protect access to rawnand devices while in
 suspend
Message-ID: <202112210255.fmm6tiKT-lkp@intel.com>
References: <20211220130015.3630975-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220130015.3630975-1-sean@geanix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linux/master linus/master v5.16-rc6 next-20211220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sean-Nyekjaer/mtd-rawnand-protect-access-to-rawnand-devices-while-in-suspend/20211220-210300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
config: mips-randconfig-r002-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210255.fmm6tiKT-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 555eacf75f21cd1dfc6363d73ad187b730349543)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/4820bae9bf9bca82933f29066b18ea85f8c06178
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sean-Nyekjaer/mtd-rawnand-protect-access-to-rawnand-devices-while-in-suspend/20211220-210300
        git checkout 4820bae9bf9bca82933f29066b18ea85f8c06178
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/nand_base.c:4426:2: warning: variable 'ret' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
           default:
           ^~~~~~~
   drivers/mtd/nand/raw/nand_base.c:4437:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/mtd/nand/raw/nand_base.c:4414:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +/ret +4426 drivers/mtd/nand/raw/nand_base.c

2af7c653993199 drivers/mtd/nand/nand_base.c     Simon Kagstrom  2009-10-05  4403  
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4404  /**
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4405   * nand_write_oob - [MTD Interface] NAND write data and/or out-of-band
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4406   * @mtd: MTD device structure
844d3b427ef1a4 drivers/mtd/nand/nand_base.c     Randy Dunlap    2006-06-28  4407   * @to: offset to write to
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4408   * @ops: oob operation description structure
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4409   */
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4410  static int nand_write_oob(struct mtd_info *mtd, loff_t to,
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4411  			  struct mtd_oob_ops *ops)
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4412  {
0813621ba898aa drivers/mtd/nand/raw/nand_base.c Boris Brezillon 2018-11-11  4413  	struct nand_chip *chip = mtd_to_nand(mtd);
80107e764846a6 drivers/mtd/nand/raw/nand_base.c Colin Ian King  2019-07-31  4414  	int ret;
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4415  
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4416  	ops->retlen = 0;
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4417  
4820bae9bf9bca drivers/mtd/nand/raw/nand_base.c Sean Nyekjaer   2021-12-20  4418  	nand_get_device(chip);
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4419  
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4420  	switch (ops->mode) {
0612b9ddc2eeda drivers/mtd/nand/nand_base.c     Brian Norris    2011-08-30  4421  	case MTD_OPS_PLACE_OOB:
0612b9ddc2eeda drivers/mtd/nand/nand_base.c     Brian Norris    2011-08-30  4422  	case MTD_OPS_AUTO_OOB:
0612b9ddc2eeda drivers/mtd/nand/nand_base.c     Brian Norris    2011-08-30  4423  	case MTD_OPS_RAW:
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4424  		break;
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4425  
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29 @4426  	default:
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4427  		goto out;
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4428  	}
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4429  
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4430  	if (!ops->datbuf)
0813621ba898aa drivers/mtd/nand/raw/nand_base.c Boris Brezillon 2018-11-11  4431  		ret = nand_do_write_oob(chip, to, ops);
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4432  	else
0813621ba898aa drivers/mtd/nand/raw/nand_base.c Boris Brezillon 2018-11-11  4433  		ret = nand_do_write_ops(chip, to, ops);
8593fbc68b0df1 drivers/mtd/nand/nand_base.c     Thomas Gleixner 2006-05-29  4434  
^1da177e4c3f41 drivers/mtd/nand/nand_base.c     Linus Torvalds  2005-04-16  4435  out:
0813621ba898aa drivers/mtd/nand/raw/nand_base.c Boris Brezillon 2018-11-11  4436  	nand_release_device(chip);
^1da177e4c3f41 drivers/mtd/nand/nand_base.c     Linus Torvalds  2005-04-16  4437  	return ret;
^1da177e4c3f41 drivers/mtd/nand/nand_base.c     Linus Torvalds  2005-04-16  4438  }
^1da177e4c3f41 drivers/mtd/nand/nand_base.c     Linus Torvalds  2005-04-16  4439  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
