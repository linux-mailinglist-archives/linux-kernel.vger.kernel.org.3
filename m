Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B6D521C59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiEJOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbiEJOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:09:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F794120A3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652190244; x=1683726244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FkqIWOn01JAdtmaPe+QtKrSJzpCaZU32POU9YFGl9Go=;
  b=KbJEHrj61aOkSOlox54UEIXS4n3gXfTJTTJAFYGb4SWXYBJ3UZEy5gpx
   jzFUD5vsQdaMM9ClIj8KCfByCJ1V1kYzO/3HUt829rkyU+MGM88XchwHr
   rA/QlOIQmsijipqudcfF9qmRgZIfsbTbjY4txYbsr9uQvxKGnOYfvkC5A
   O6V3rfLY1O4nQljoFIg3/hYXenT95ETUioyGJmyAq38XfQoLvR/Y/bVoE
   saULeiZf7lqKRpaTePx+Py9Eq66+fNKUla5X6hFZsue8Z7ecfd6BD27Ni
   wnfoiQ3bkzBp9mlBvSxJHHT/2kfsum7V6gKNzc0RZ095Z02lRTOnZONTU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268215350"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="268215350"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 06:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="623466839"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2022 06:43:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noQ9V-000HxO-G3;
        Tue, 10 May 2022 13:43:49 +0000
Date:   Tue, 10 May 2022 21:43:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi Yang <yiyang13@huawei.com>, chris@zankel.net,
        jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk
Cc:     kbuild-all@lists.01.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next] xtensa/simdisk: fix error handling in
 proc_read_simdisk()
Message-ID: <202205102144.vmTlPCDp-lkp@intel.com>
References: <20220510080533.51032-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510080533.51032-1-yiyang13@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220509]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Yang/xtensa-simdisk-fix-error-handling-in-proc_read_simdisk/20220510-161001
base:    ab38272e99730375c5db3db1c4cebf691a0550ab
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220510/202205102144.vmTlPCDp-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/62cd9e58ed970829827bd2bfb24f2515a08fd921
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yi-Yang/xtensa-simdisk-fix-error-handling-in-proc_read_simdisk/20220510-161001
        git checkout 62cd9e58ed970829827bd2bfb24f2515a08fd921
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash arch/xtensa/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/xtensa/platforms/iss/simdisk.c: In function 'proc_read_simdisk':
>> arch/xtensa/platforms/iss/simdisk.c:223:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     223 |                 ssize_t n = simple_read_from_buffer(buf, size, ppos,
         |                 ^~~~~~~


vim +223 arch/xtensa/platforms/iss/simdisk.c

b6c7e873daf765 Victor Prupis      2008-05-19  207  
a69755b187749e Al Viro            2013-03-31  208  static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
a69755b187749e Al Viro            2013-03-31  209  			size_t size, loff_t *ppos)
b6c7e873daf765 Victor Prupis      2008-05-19  210  {
359745d78351c6 Muchun Song        2022-01-21  211  	struct simdisk *dev = pde_data(file_inode(file));
0757f6159f13dc Geert Uytterhoeven 2013-05-09  212  	const char *s = dev->filename;
62cd9e58ed9708 Yi Yang            2022-05-10  213  	char *temp;
62cd9e58ed9708 Yi Yang            2022-05-10  214  
a69755b187749e Al Viro            2013-03-31  215  	if (s) {
62cd9e58ed9708 Yi Yang            2022-05-10  216  		ssize_t len = strlen(s);
62cd9e58ed9708 Yi Yang            2022-05-10  217  
62cd9e58ed9708 Yi Yang            2022-05-10  218  		temp = kmalloc(len + 2, GFP_KERNEL);
62cd9e58ed9708 Yi Yang            2022-05-10  219  		if (!temp)
62cd9e58ed9708 Yi Yang            2022-05-10  220  			return -ENOMEM;
62cd9e58ed9708 Yi Yang            2022-05-10  221  
62cd9e58ed9708 Yi Yang            2022-05-10  222  		scnprintf(temp, len + 2, "%s\n", s);
a69755b187749e Al Viro            2013-03-31 @223  		ssize_t n = simple_read_from_buffer(buf, size, ppos,
62cd9e58ed9708 Yi Yang            2022-05-10  224  							temp, strlen(temp));
62cd9e58ed9708 Yi Yang            2022-05-10  225  
62cd9e58ed9708 Yi Yang            2022-05-10  226  		kfree(temp);
a69755b187749e Al Viro            2013-03-31  227  		return n;
a69755b187749e Al Viro            2013-03-31  228  	}
a69755b187749e Al Viro            2013-03-31  229  	return simple_read_from_buffer(buf, size, ppos, "\n", 1);
b6c7e873daf765 Victor Prupis      2008-05-19  230  }
b6c7e873daf765 Victor Prupis      2008-05-19  231  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
