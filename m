Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E174A7932
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbiBBUH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:07:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:46579 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbiBBUHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643832445; x=1675368445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OKoapjEKq1E7eFux5LUXJp/W1HMiW7UHxnLJfV3whXI=;
  b=nUuNLu4Ljbsj8VmtDIZOcQG+MgrRMfqvFkWg939Nabej314/zELF8RQr
   cotlZ8nFTyjs9lnkzrdDgsaf7nuMYwJN09R1L3UkLWUv+WpcjZVTppYVJ
   k4LECMF/MKQrKlsBPREGcK8tg/7Ea0EVzwtZxnzu6Y40OqbVqjiTBbU26
   5pJt+oTd5NYMrqMbAM6efdAbhcqQlfkgrSMJyqcA+lsGzCCtY5en9qgGe
   iyZYgRJlsVBxS+cc3W9e/C2f0p55BrV/86W3XLotXud2U4wNt2lYeiFFn
   AI1NY7vQnFkU1boIP9Hy4sB/mJ3qnMaltMVItvwlbIU5UO5qwcBDo0kSg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272499503"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="272499503"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="771555789"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Feb 2022 12:07:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFLuU-000V43-LN; Wed, 02 Feb 2022 20:07:22 +0000
Date:   Thu, 3 Feb 2022 04:07:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 12/14] mtd: spi-nor: move all spansion specifics into
 spansion.c
Message-ID: <202202030449.IQfj2Y5O-lkp@intel.com>
References: <20220202145853.4187726-13-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-13-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mtd/spi-nor/next]
[also build test WARNING on linux/master linus/master v5.17-rc2 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220202-230139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220203/202202030449.IQfj2Y5O-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/01f9808a20c96553c43f929e10f3fb448cd8bd93
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220202-230139
        git checkout 01f9808a20c96553c43f929e10f3fb448cd8bd93
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/spansion.c:332:5: warning: no previous prototype for function 'spi_nor_sr_ready_and_clear' [-Wmissing-prototypes]
   int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
       ^
   drivers/mtd/spi-nor/spansion.c:332:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
   ^
   static 
   1 warning generated.


vim +/spi_nor_sr_ready_and_clear +332 drivers/mtd/spi-nor/spansion.c

   324	
   325	/**
   326	 * spi_nor_sr_ready_and_clear() - Query the Status Register to see if the flash
   327	 * is ready for new commands and clear it.
   328	 * @nor:	pointer to 'struct spi_nor'.
   329	 *
   330	 * Return: 1 if ready, 0 if not ready, -errno on errors.
   331	 */
 > 332	int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
   333	{
   334		int ret;
   335	
   336		ret = spi_nor_read_sr(nor, nor->bouncebuf);
   337		if (ret)
   338			return ret;
   339	
   340		if (nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
   341			if (nor->bouncebuf[0] & SR_E_ERR)
   342				dev_err(nor->dev, "Erase Error occurred\n");
   343			else
   344				dev_err(nor->dev, "Programming Error occurred\n");
   345	
   346			spi_nor_clear_sr(nor);
   347	
   348			/*
   349			 * WEL bit remains set to one when an erase or page program
   350			 * error occurs. Issue a Write Disable command to protect
   351			 * against inadvertent writes that can possibly corrupt the
   352			 * contents of the memory.
   353			 */
   354			ret = spi_nor_write_disable(nor);
   355			if (ret)
   356				return ret;
   357	
   358			return -EIO;
   359		}
   360	
   361		return !(nor->bouncebuf[0] & SR_WIP);
   362	}
   363	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
