Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831054FCE73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347434AbiDLFFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiDLFEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:04:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B3E344EF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649739758; x=1681275758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15fDRfdM1HQDD3vhfb95CPUbHMkDSQ2QlfPPGarHgpc=;
  b=bARGnJSJuTDp4AdIHlgTPM/iY/b8Slqtxw+W7WsK16PH2i7d8/+pRsPn
   FDX7TVnFrZcRmrj5P4i+XFnYTk+3jgg1nMkhb/4xV2nyh+rC8L2O8eQul
   2I5gkRtSLZkaQP06cJfN/zBOMlbb4XlzK7Y6Vk3p8td+CoYAbdjmjyWyJ
   KgwQuKgRcOTe3UuelkSCEB53vurfSawkhJHM6x3QNwGCBQI1nPi2jgfbu
   BS/g90jIQZuy7XH/EPSHaRZT7DMys00qDx8CTjkzCUkPzvbSUpo2p7D/H
   8ImYutBXl+b+CInNo6tQmWtY+NMioaWCFAQaTASgXvzFYkTmrScB78iMt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322721825"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="322721825"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="623114876"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2022 22:02:34 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne8fh-0002Wq-UY;
        Tue, 12 Apr 2022 05:02:33 +0000
Date:   Tue, 12 Apr 2022 13:01:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH] mtd: rawnand: Fix return value check of
 wait_for_completion_timeout
Message-ID: <202204121253.NcZifMQi-lkp@intel.com>
References: <20220412020834.7161-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412020834.7161-1-linmq006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linus/master linux/master v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaoqian-Lin/mtd-rawnand-Fix-return-value-check-of-wait_for_completion_timeout/20220412-101006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
config: hexagon-randconfig-r045-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121253.NcZifMQi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3de25b46a3f73a3e0031e5186eb4e2afa9098b46
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Miaoqian-Lin/mtd-rawnand-Fix-return-value-check-of-wait_for_completion_timeout/20220412-101006
        git checkout 3de25b46a3f73a3e0031e5186eb4e2afa9098b46
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/sh_flctl.c:433:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (time_left == 0) {
               ^~~~~~~~~~~~~~
   drivers/mtd/nand/raw/sh_flctl.c:447:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/mtd/nand/raw/sh_flctl.c:433:2: note: remove the 'if' if its condition is always true
           if (time_left == 0) {
           ^~~~~~~~~~~~~~~~~~~~
   drivers/mtd/nand/raw/sh_flctl.c:387:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +433 drivers/mtd/nand/raw/sh_flctl.c

   377	
   378	static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
   379						int len, enum dma_data_direction dir)
   380	{
   381		struct dma_async_tx_descriptor *desc = NULL;
   382		struct dma_chan *chan;
   383		enum dma_transfer_direction tr_dir;
   384		dma_addr_t dma_addr;
   385		dma_cookie_t cookie;
   386		uint32_t reg;
   387		int ret;
   388		unsigned long time_left;
   389	
   390		if (dir == DMA_FROM_DEVICE) {
   391			chan = flctl->chan_fifo0_rx;
   392			tr_dir = DMA_DEV_TO_MEM;
   393		} else {
   394			chan = flctl->chan_fifo0_tx;
   395			tr_dir = DMA_MEM_TO_DEV;
   396		}
   397	
   398		dma_addr = dma_map_single(chan->device->dev, buf, len, dir);
   399	
   400		if (!dma_mapping_error(chan->device->dev, dma_addr))
   401			desc = dmaengine_prep_slave_single(chan, dma_addr, len,
   402				tr_dir, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
   403	
   404		if (desc) {
   405			reg = readl(FLINTDMACR(flctl));
   406			reg |= DREQ0EN;
   407			writel(reg, FLINTDMACR(flctl));
   408	
   409			desc->callback = flctl_dma_complete;
   410			desc->callback_param = flctl;
   411			cookie = dmaengine_submit(desc);
   412			if (dma_submit_error(cookie)) {
   413				ret = dma_submit_error(cookie);
   414				dev_warn(&flctl->pdev->dev,
   415					 "DMA submit failed, falling back to PIO\n");
   416				goto out;
   417			}
   418	
   419			dma_async_issue_pending(chan);
   420		} else {
   421			/* DMA failed, fall back to PIO */
   422			flctl_release_dma(flctl);
   423			dev_warn(&flctl->pdev->dev,
   424				 "DMA failed, falling back to PIO\n");
   425			ret = -EIO;
   426			goto out;
   427		}
   428	
   429		time_left =
   430		wait_for_completion_timeout(&flctl->dma_complete,
   431					msecs_to_jiffies(3000));
   432	
 > 433		if (time_left == 0) {
   434			dmaengine_terminate_all(chan);
   435			dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
   436			ret = -ETIMEDOUT;
   437		}
   438	
   439	out:
   440		reg = readl(FLINTDMACR(flctl));
   441		reg &= ~DREQ0EN;
   442		writel(reg, FLINTDMACR(flctl));
   443	
   444		dma_unmap_single(chan->device->dev, dma_addr, len, dir);
   445	
   446		/* ret > 0 is success */
   447		return ret;
   448	}
   449	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
