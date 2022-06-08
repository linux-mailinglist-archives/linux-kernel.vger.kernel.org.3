Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20D5424EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiFHFen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiFHFd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:33:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C59261464
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 20:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654657218; x=1686193218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ckah9uOFCDFUelCaEvV/+QIv1I4STuicWWUVywSxw9Y=;
  b=DFovppuQgBMD0B49OhQ57qQcOu6onoJBFBLRF/YLdUtJvEycg7H3ak4W
   RhIpLrBviXe9tw+lVaoDQnbvPRll9yU16DHmlihAHKg0cVmXtJNofqYi2
   FFZgsH6C9A0L57pi/kwQHTyV7wgomaBJIThKhkdJvif7QO8bRIesVeIj/
   FdDNmrZECvpI/WP/i+vr4G/ctqS/GrKgT9JmgSurWhSHGaHHEPXAuPt2K
   XiCtU/j2Kgq2WDqPFT7Uhb5ezboU2nvDZ0TU4SmsQ2Ls34oQyrWe5euDC
   AEZM1XEMgubm5K+/gF9ywPpTGBP8Xzo0RPB4f/vLn3On6ReY33qU69LHM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257220173"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="257220173"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 20:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="555210754"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2022 20:00:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nylva-000ECJ-Nl;
        Wed, 08 Jun 2022 03:00:14 +0000
Date:   Wed, 8 Jun 2022 10:59:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kbuild-all@lists.01.org, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spi-nor: siliconkaiser: add support for sk25lp128
Message-ID: <202206081011.jPVWbSvo-lkp@intel.com>
References: <20220603135933.143372-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603135933.143372-1-tom@tom-fitzhenry.me.uk>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mtd/spi-nor/next]
[also build test ERROR on v5.19-rc1 next-20220607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Fitzhenry/mtd-spi-nor-siliconkaiser-add-support-for-sk25lp128/20220605-163120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: csky-randconfig-r024-20220607 (https://download.01.org/0day-ci/archive/20220608/202206081011.jPVWbSvo-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9ee4927880d43f8611d371e7cc7d8854a927de66
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tom-Fitzhenry/mtd-spi-nor-siliconkaiser-add-support-for-sk25lp128/20220605-163120
        git checkout 9ee4927880d43f8611d371e7cc7d8854a927de66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/spi-nor/siliconkaiser.c:8:18: error: implicit declaration of function 'SNOR_ID3' [-Werror=implicit-function-declaration]
       8 |   { "sk25lp128", SNOR_ID3(0x257018) },
         |                  ^~~~~~~~
>> drivers/mtd/spi-nor/siliconkaiser.c:8:18: error: initializer element is not constant
   drivers/mtd/spi-nor/siliconkaiser.c:8:18: note: (near initialization for 'siliconkaiser_nor_parts[0].id[0]')
   cc1: some warnings being treated as errors


vim +/SNOR_ID3 +8 drivers/mtd/spi-nor/siliconkaiser.c

     6	
     7	static const struct flash_info siliconkaiser_nor_parts[] = {
   > 8	  { "sk25lp128", SNOR_ID3(0x257018) },
     9	};
    10	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
