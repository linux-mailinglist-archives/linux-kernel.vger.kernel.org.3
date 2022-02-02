Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678A54A77A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiBBSPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:15:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:53222 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbiBBSPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643825732; x=1675361732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5L2IGhFElsUioIEHW2pw7wMqbxrTXBoGVWymIBIhZSQ=;
  b=cSkmO79RYRgu8rtPbSZ1JIQkpw7zmXshRQWfjrH5x/XqILJNEOf0n/Jh
   kycQPgRy50Ul9q3oykcOy6CAaaXZfN69FWcJtD+gBCH54xKbrcT1N00pO
   lms+1lGpUP29Kg9jg1KL9my2PURVvsAsiHX7U4IzTK+HCbkfek9zTxZck
   vyUic+9WuPD2D2MkfTDV/K+LXIB26ZAiRJo9i+yptKWnidLeIa10GPcEi
   9or1cFC+fRX/jW8H85Q6gZREwAHJi6BWlcuZTKXaAhRc9TFGEGUOJ9r2f
   LNoRuXDRiYrbPJljSzf5vf47OSQpMOW77mszo084vZ8LtqU474id4f+q2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245587196"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="245587196"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="676528121"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2022 10:15:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFK9z-000Uwe-A4; Wed, 02 Feb 2022 18:15:15 +0000
Date:   Thu, 3 Feb 2022 02:15:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 12/14] mtd: spi-nor: move all spansion specifics into
 spansion.c
Message-ID: <202202030228.8WUETAc8-lkp@intel.com>
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
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220203/202202030228.8WUETAc8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/01f9808a20c96553c43f929e10f3fb448cd8bd93
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Walle/mtd-spi-nor-move-vendor-specific-code-into-vendor-modules/20220202-230139
        git checkout 01f9808a20c96553c43f929e10f3fb448cd8bd93
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/spi-nor/spansion.c:332:5: warning: no previous prototype for 'spi_nor_sr_ready_and_clear' [-Wmissing-prototypes]
     332 | int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


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
