Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52934FA5F9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiDII2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbiDII2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:28:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD46AFAEB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649492762; x=1681028762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z89rAS6nK8vPE6PqwXyApxLr8DEMMn6pGUFoYLv0L8I=;
  b=WhtmLDua3fGQ+w9lAwQ5XL30AV+fNX+hVG+h+6cU2T/WNtkndm0T9VGz
   HXRJvmeW/rkXwrEPSqfQO9EfZB+gEN4ROTN7hm3BBoCsB03mQdga5YfKa
   1yBcdi/7+cVq1jV2PIPHVeWwCUKBkdFSIu/ihkxKxs+tuCEIVRbVNe+Mr
   Z6oIVL41gb0N45GJ/61GWKh4m47sZWt0uYMfjTd0eyhXWBa9Y9Jyvtdj8
   Cu4gnFLQ7ZiQ7NX5Lrp80RXAhmmPVSj/cVByPbeL0fOhPQ8ZjOZoOGSMO
   FycRsZeJ2VVsHLLEIa8vZEISRxlgoznqFkJNoxwGrFB40mqw5EeAzBdy6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260621695"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="260621695"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 01:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="622019793"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 01:25:59 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd6Pv-00010d-9g;
        Sat, 09 Apr 2022 08:25:59 +0000
Date:   Sat, 9 Apr 2022 16:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     kbuild-all@lists.01.org, Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: separate ecc-mxic from nandcore
Message-ID: <202204091647.rave7jtW-lkp@intel.com>
References: <20220409052148.2159196-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409052148.2159196-1-gch981213@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mtd/nand/next]
[also build test ERROR on v5.18-rc1 next-20220408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuanhong-Guo/mtd-nand-separate-ecc-mxic-from-nandcore/20220409-132331
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
config: sh-randconfig-r013-20220408 (https://download.01.org/0day-ci/archive/20220409/202204091647.rave7jtW-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a96780fbe6f7bc76d07fd5a4ccc390e7fedcc8b5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chuanhong-Guo/mtd-nand-separate-ecc-mxic-from-nandcore/20220409-132331
        git checkout a96780fbe6f7bc76d07fd5a4ccc390e7fedcc8b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mxic_ecc_process_data_pipelined" [drivers/spi/spi-mxic.ko] undefined!
>> ERROR: modpost: "mxic_ecc_get_pipelined_engine" [drivers/spi/spi-mxic.ko] undefined!
>> ERROR: modpost: "mxic_ecc_get_pipelined_ops" [drivers/spi/spi-mxic.ko] undefined!
>> ERROR: modpost: "mxic_ecc_put_pipelined_engine" [drivers/spi/spi-mxic.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
