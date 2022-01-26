Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684C49C7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiAZKtz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jan 2022 05:49:55 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46175 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiAZKty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:49:54 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 534D160005;
        Wed, 26 Jan 2022 10:49:50 +0000 (UTC)
Date:   Wed, 26 Jan 2022 11:49:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 14/16] drivers/mtd/nand/ecc-mxic.c:395
 mxic_ecc_data_xfer_wait_for_completion() error: uninitialized symbol 'val'.
Message-ID: <20220126114948.1dd9e6b9@xps13>
In-Reply-To: <202112271621.cNxEVvN6-lkp@intel.com>
References: <202112271621.cNxEVvN6-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

dan.carpenter@oracle.com wrote on Thu, 6 Jan 2022 11:54:51 +0300:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc
> head:   5966bd4f59edbbe5873b1b4637ed50f258ced0b2
> commit: b78baf1891f0b7c3f0e2e3e6022eab38ee6c871f [14/16] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
> config: i386-randconfig-m021-20211227 (https://download.01.org/0day-ci/archive/20211227/202112271621.cNxEVvN6-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/mtd/nand/ecc-mxic.c:395 mxic_ecc_data_xfer_wait_for_completion() error: uninitialized symbol 'val'.
> drivers/mtd/nand/ecc-mxic.c:548 mxic_ecc_prepare_io_req_external() error: uninitialized symbol 'ret'.
> 
> vim +/val +395 drivers/mtd/nand/ecc-mxic.c
> 
> b78baf1891f0b7 Miquel Raynal 2021-12-16  377  static int mxic_ecc_data_xfer_wait_for_completion(struct mxic_ecc_engine *mxic)
> b78baf1891f0b7 Miquel Raynal 2021-12-16  378  {
> b78baf1891f0b7 Miquel Raynal 2021-12-16  379  	u32 val;
> b78baf1891f0b7 Miquel Raynal 2021-12-16  380  	int ret;
> b78baf1891f0b7 Miquel Raynal 2021-12-16  381  
> b78baf1891f0b7 Miquel Raynal 2021-12-16  382  	if (mxic->irq) {
> b78baf1891f0b7 Miquel Raynal 2021-12-16  383  		reinit_completion(&mxic->complete);
> b78baf1891f0b7 Miquel Raynal 2021-12-16  384  		mxic_ecc_enable_int(mxic);
> b78baf1891f0b7 Miquel Raynal 2021-12-16  385  		ret = wait_for_completion_timeout(&mxic->complete,
> b78baf1891f0b7 Miquel Raynal 2021-12-16  386  						  msecs_to_jiffies(1000));
> b78baf1891f0b7 Miquel Raynal 2021-12-16  387  		mxic_ecc_disable_int(mxic);
> 
> "val" not set on this path.

Thanks for the report, I've fixed that inline.

> b78baf1891f0b7 Miquel Raynal 2021-12-16  388  	} else {
> b78baf1891f0b7 Miquel Raynal 2021-12-16  389  		ret = readl_poll_timeout(mxic->regs + INTRPT_STS, val,
> b78baf1891f0b7 Miquel Raynal 2021-12-16  390  					 val & TRANS_CMPLT, 10, USEC_PER_SEC);
> b78baf1891f0b7 Miquel Raynal 2021-12-16  391  		writel(val, mxic->regs + INTRPT_STS);
> b78baf1891f0b7 Miquel Raynal 2021-12-16  392  	}
> b78baf1891f0b7 Miquel Raynal 2021-12-16  393  
> b78baf1891f0b7 Miquel Raynal 2021-12-16  394  	if (ret) {
> b78baf1891f0b7 Miquel Raynal 2021-12-16 @395  		dev_err(mxic->dev, "Timeout on data xfer completion (sts 0x%08x)\n", val);
>                                                                                                                              ^^^
> 
> b78baf1891f0b7 Miquel Raynal 2021-12-16  396  		return -ETIMEDOUT;
> b78baf1891f0b7 Miquel Raynal 2021-12-16  397  	}
> b78baf1891f0b7 Miquel Raynal 2021-12-16  398  
> b78baf1891f0b7 Miquel Raynal 2021-12-16  399  	return 0;
> b78baf1891f0b7 Miquel Raynal 2021-12-16  400  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 


Thanks,
Miquèl
