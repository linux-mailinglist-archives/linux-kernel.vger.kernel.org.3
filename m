Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAA252C93D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiESBf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiESBfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:35:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0139345D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652924123; x=1684460123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1fnNyfY+tpW2NgUz39MRpubIN14QdSxh7wgGvcGEjqs=;
  b=FGwN87dzVvpJT6P/98+1O1JgefkDddVgb9hOB8zSCD/ON+2bumfwZi1P
   TKUJO3AdBmA3FcMKuQe/6w0NebH+ghiFu4C1SOL03yQrkBt5604jUiq4O
   wjh13j5YZq/iQaAwTKhqrt3C9qkqRPgXwcaltiB0UlSG09S8l/SgF0ve+
   Ub45Oj2RUYjssotlrGUOG9lgmnjMADbHJjnamNpIG5NH9yW4C//UEXFtG
   bwbEAkiS1Pt9jt0tExovcWQSmVTWerRZ34Aft5HtUTfFd11VIgMGcZ9hY
   Y6Ke//AIlVIvNTbgpUf3ZRQpRel7O/C9qjDliP9Om3BCfWlPtuokzr4o8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="335017953"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="335017953"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 18:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="673749908"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2022 18:35:20 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrV4R-0002tL-ME;
        Thu, 19 May 2022 01:35:19 +0000
Date:   Thu, 19 May 2022 09:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        fmdefrancesco@gmail.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH 1/4] staging: r8188eu: add error handling of rtw_read8
Message-ID: <202205190916.GRvUby7c-lkp@intel.com>
References: <1a9834b705054dcd0b0be0d929084c44a224abaa.1652911343.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a9834b705054dcd0b0be0d929084c44a224abaa.1652911343.git.paskripkin@gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Skripkin/staging-r8188eu-add-error-handling-of-usb-read-errors/20220519-061342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git e41f7a5521d7f03dca99e3207633df71740569dd
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220519/202205190916.GRvUby7c-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8c9bd199a25d7a1d8f6fed1b0d5da9cec1f8faa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pavel-Skripkin/staging-r8188eu-add-error-handling-of-usb-read-errors/20220519-061342
        git checkout f8c9bd199a25d7a1d8f6fed1b0d5da9cec1f8faa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/r8188eu/hal/usb_halinit.c: In function '_InitBeaconParameters':
>> drivers/staging/r8188eu/hal/usb_halinit.c:465:13: warning: variable 'res' set but not used [-Wunused-but-set-variable]
     465 |         int res;
         |             ^~~
--
   drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function 'rtw_dbg_port':
>> drivers/staging/r8188eu/os_dep/ioctl_linux.c:3419:32: warning: variable 'res' set but not used [-Wunused-but-set-variable]
    3419 |                         int i, res;
         |                                ^~~


vim +/res +465 drivers/staging/r8188eu/hal/usb_halinit.c

   461	
   462	static void _InitBeaconParameters(struct adapter *Adapter)
   463	{
   464		struct hal_data_8188e *haldata = &Adapter->haldata;
 > 465		int res;
   466	
   467		rtw_write16(Adapter, REG_BCN_CTRL, 0x1010);
   468	
   469		/*  TODO: Remove these magic number */
   470		rtw_write16(Adapter, REG_TBTT_PROHIBIT, 0x6404);/*  ms */
   471		rtw_write8(Adapter, REG_DRVERLYINT, DRIVER_EARLY_INT_TIME);/*  5ms */
   472		rtw_write8(Adapter, REG_BCNDMATIM, BCN_DMA_ATIME_INT_TIME); /*  2ms */
   473	
   474		/*  Suggested by designer timchen. Change beacon AIFS to the largest number */
   475		/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
   476		rtw_write16(Adapter, REG_BCNTCFG, 0x660F);
   477	
   478		/* FIXME: return an error to caller */
   479		res = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2, &haldata->RegFwHwTxQCtrl);
   480		res = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2, &haldata->RegReg542);
   481		res = rtw_read8(Adapter, REG_CR + 1, &haldata->RegCR_1);
   482	}
   483	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
