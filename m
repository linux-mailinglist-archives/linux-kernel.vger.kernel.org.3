Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E13543F32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiFHWcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiFHWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:32:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AFC4F1F9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654727528; x=1686263528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=966GUEbD5OvXnC97fGhpX+8W+lw90GLIkOWwiYAP2Jk=;
  b=Vbny7OyQwDQzNYrWjrFKWDYeGVEl50wxuSrnmZ3yWTwsnkbM5Qu8OQd9
   3Bm+ZmyljW83q9gglb6m9f2mEuLQ5Um+Jw6B191YkhftnMlPRRdJ4NloK
   kmC/dKe+4skFVpezHXjvsAwNs7/StB6CkZ/xu6EVb5X+v+U58UhKWnpSV
   4SGg7HFiIF0SFB61iXs6tM05ybLoYHy6CZrCO5vyZCji0FKwgFvSOdVer
   kkFltz4w1DJUrJexYqFeN+0Js9xkUdNwr4Y68Z59RaugDVRM9qgEZWjOf
   fxmvj8Jb5RB2b4HqKfgKDCac8aoTH8C3jR5t6ZqEKd4KJ/tCevhR9pOAD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="260207766"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="260207766"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 15:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="615592598"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2022 15:32:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz4Dc-000FB1-CP;
        Wed, 08 Jun 2022 22:32:04 +0000
Date:   Thu, 9 Jun 2022 06:31:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spi-nor: siliconkaiser: add support for sk25lp128
Message-ID: <202206090649.QxcEHXEj-lkp@intel.com>
References: <20220603135933.143372-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603135933.143372-1-tom@tom-fitzhenry.me.uk>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mtd/spi-nor/next]
[also build test ERROR on v5.19-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Fitzhenry/mtd-spi-nor-siliconkaiser-add-support-for-sk25lp128/20220605-163120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: arm-randconfig-c002-20220607 (https://download.01.org/0day-ci/archive/20220609/202206090649.QxcEHXEj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/9ee4927880d43f8611d371e7cc7d8854a927de66
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tom-Fitzhenry/mtd-spi-nor-siliconkaiser-add-support-for-sk25lp128/20220605-163120
        git checkout 9ee4927880d43f8611d371e7cc7d8854a927de66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/mtd/ drivers/nfc/ fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/spi-nor/siliconkaiser.c:8:18: error: call to undeclared function 'SNOR_ID3'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     { "sk25lp128", SNOR_ID3(0x257018) },
                    ^
   drivers/mtd/spi-nor/siliconkaiser.c:8:18: warning: suggest braces around initialization of subobject [-Wmissing-braces]
     { "sk25lp128", SNOR_ID3(0x257018) },
                    ^~~~~~~~~~~~~~~~~~
                    {                 }
>> drivers/mtd/spi-nor/siliconkaiser.c:8:18: error: initializer element is not a compile-time constant
     { "sk25lp128", SNOR_ID3(0x257018) },
                    ^~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +/SNOR_ID3 +8 drivers/mtd/spi-nor/siliconkaiser.c

     6	
     7	static const struct flash_info siliconkaiser_nor_parts[] = {
   > 8	  { "sk25lp128", SNOR_ID3(0x257018) },
     9	};
    10	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
