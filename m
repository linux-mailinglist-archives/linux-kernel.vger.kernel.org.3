Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51524842FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiADOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:04:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:27591 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234024AbiADOEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641305095; x=1672841095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kz7IcHrhqo9rldSGc7LBV2XjV9nYo5yyK6exP5BDRE0=;
  b=GFBUUUgm9ePMcmRVNpsueiYVOOSZNk+2v/PrDpLyDRM/2bmfxONeG1iU
   wZDjbxuMymHZgTYvhHf0wXbg/1AcpIDQoIwNksWgdoF6zIBE41sr4LBSE
   WKeylub+CA4PhJH4co1HJhrteeZjyeNevivak4S9yJ5S+C2sb3x4JE8Eh
   iY/lxItS59RB0m3ecOJB0D+QveDF0MJmHbCjvBYVw0PYax6kW6a9oBqhq
   8K5hifNbLowXAIZs5vI+9iliiGBLMPAgWjY5ppGcEkjRVWawGV71Nppz+
   wyK4P6nwgWfkEPUBz4/gfd8Nje7VjIb+dRr2VyCV02mCUO8UOFdgmWIC2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="305580345"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="305580345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 06:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="472076487"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2022 06:04:53 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4kQm-000FRQ-CH; Tue, 04 Jan 2022 14:04:52 +0000
Date:   Tue, 4 Jan 2022 22:04:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: drivers/rtc/rtc-mxc.c:315:19: warning: cast to smaller integer type
 'enum imx_rtc_type' from 'const void *'
Message-ID: <202201042126.pU52WJi5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
commit: 0020868f2a7037e87d6b3b196526de2fb885830d rtc: mxc{,_v2}: enable COMPILE_TEST
date:   1 year, 1 month ago
config: arm64-randconfig-r005-20210928 (https://download.01.org/0day-ci/archive/20220104/202201042126.pU52WJi5-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0020868f2a7037e87d6b3b196526de2fb885830d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0020868f2a7037e87d6b3b196526de2fb885830d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/ drivers/gpu/drm/radeon/ drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/rtc/rtc-mxc.c:315:19: warning: cast to smaller integer type 'enum imx_rtc_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           pdata->devtype = (enum imx_rtc_type)of_device_get_match_data(&pdev->dev);
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +315 drivers/rtc/rtc-mxc.c

fdc9f0eace99b2 Anson Huang         2020-03-16  302  
5a167f4543e45d Greg Kroah-Hartman  2012-12-21  303  static int mxc_rtc_probe(struct platform_device *pdev)
d00ed3cf6e5431 Daniel Mack         2009-09-22  304  {
d00ed3cf6e5431 Daniel Mack         2009-09-22  305  	struct rtc_device *rtc;
d00ed3cf6e5431 Daniel Mack         2009-09-22  306  	struct rtc_plat_data *pdata = NULL;
d00ed3cf6e5431 Daniel Mack         2009-09-22  307  	u32 reg;
c783a29efcbc90 Vladimir Zapolskiy  2010-04-06  308  	unsigned long rate;
c783a29efcbc90 Vladimir Zapolskiy  2010-04-06  309  	int ret;
d00ed3cf6e5431 Daniel Mack         2009-09-22  310  
c783a29efcbc90 Vladimir Zapolskiy  2010-04-06  311  	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
d00ed3cf6e5431 Daniel Mack         2009-09-22  312  	if (!pdata)
d00ed3cf6e5431 Daniel Mack         2009-09-22  313  		return -ENOMEM;
d00ed3cf6e5431 Daniel Mack         2009-09-22  314  
ba7aa63000f26c Alexandre Belloni   2020-11-17 @315  	pdata->devtype = (enum imx_rtc_type)of_device_get_match_data(&pdev->dev);
bb1d34a20d537e Shawn Guo           2012-09-15  316  
cf37fa79a76170 Anson Huang         2019-04-01  317  	pdata->ioaddr = devm_platform_ioremap_resource(pdev, 0);
7c1d69ee11b898 Julia Lawall        2013-09-11  318  	if (IS_ERR(pdata->ioaddr))
7c1d69ee11b898 Julia Lawall        2013-09-11  319  		return PTR_ERR(pdata->ioaddr);
d00ed3cf6e5431 Daniel Mack         2009-09-22  320  
ebc2ec4ecf1893 Alexandre Belloni   2019-04-16  321  	rtc = devm_rtc_allocate_device(&pdev->dev);
ebc2ec4ecf1893 Alexandre Belloni   2019-04-16  322  	if (IS_ERR(rtc))
ebc2ec4ecf1893 Alexandre Belloni   2019-04-16  323  		return PTR_ERR(rtc);
ebc2ec4ecf1893 Alexandre Belloni   2019-04-16  324  
ebc2ec4ecf1893 Alexandre Belloni   2019-04-16  325  	pdata->rtc = rtc;
ebc2ec4ecf1893 Alexandre Belloni   2019-04-16  326  	rtc->ops = &mxc_rtc_ops;
83888df4b882d1 Alexandre Belloni   2019-04-16  327  	if (is_imx1_rtc(pdata)) {
83888df4b882d1 Alexandre Belloni   2019-04-16  328  		struct rtc_time tm;
83888df4b882d1 Alexandre Belloni   2019-04-16  329  
83888df4b882d1 Alexandre Belloni   2019-04-16  330  		/* 9bit days + hours minutes seconds */
83888df4b882d1 Alexandre Belloni   2019-04-16  331  		rtc->range_max = (1 << 9) * 86400 - 1;
83888df4b882d1 Alexandre Belloni   2019-04-16  332  
83888df4b882d1 Alexandre Belloni   2019-04-16  333  		/*
83888df4b882d1 Alexandre Belloni   2019-04-16  334  		 * Set the start date as beginning of the current year. This can
83888df4b882d1 Alexandre Belloni   2019-04-16  335  		 * be overridden using device tree.
83888df4b882d1 Alexandre Belloni   2019-04-16  336  		 */
83888df4b882d1 Alexandre Belloni   2019-04-16  337  		rtc_time64_to_tm(ktime_get_real_seconds(), &tm);
83888df4b882d1 Alexandre Belloni   2019-04-16  338  		rtc->start_secs =  mktime64(tm.tm_year, 1, 1, 0, 0, 0);
83888df4b882d1 Alexandre Belloni   2019-04-16  339  		rtc->set_start_time = true;
83888df4b882d1 Alexandre Belloni   2019-04-16  340  	} else {
83888df4b882d1 Alexandre Belloni   2019-04-16  341  		/* 16bit days + hours minutes seconds */
83888df4b882d1 Alexandre Belloni   2019-04-16  342  		rtc->range_max = (1 << 16) * 86400ULL - 1;
83888df4b882d1 Alexandre Belloni   2019-04-16  343  	}
ebc2ec4ecf1893 Alexandre Belloni   2019-04-16  344  
8f5fe77828e16e Philippe Reynes     2015-07-26  345  	pdata->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
8f5fe77828e16e Philippe Reynes     2015-07-26  346  	if (IS_ERR(pdata->clk_ipg)) {
8f5fe77828e16e Philippe Reynes     2015-07-26  347  		dev_err(&pdev->dev, "unable to get ipg clock!\n");
8f5fe77828e16e Philippe Reynes     2015-07-26  348  		return PTR_ERR(pdata->clk_ipg);
49908e739e23e2 Alexander Beregalov 2010-03-05  349  	}
d00ed3cf6e5431 Daniel Mack         2009-09-22  350  
8f5fe77828e16e Philippe Reynes     2015-07-26  351  	ret = clk_prepare_enable(pdata->clk_ipg);
1b3d2243d049e0 Fabio Estevam       2014-01-23  352  	if (ret)
1b3d2243d049e0 Fabio Estevam       2014-01-23  353  		return ret;
1b3d2243d049e0 Fabio Estevam       2014-01-23  354  
8f5fe77828e16e Philippe Reynes     2015-07-26  355  	pdata->clk_ref = devm_clk_get(&pdev->dev, "ref");
8f5fe77828e16e Philippe Reynes     2015-07-26  356  	if (IS_ERR(pdata->clk_ref)) {
fdc9f0eace99b2 Anson Huang         2020-03-16  357  		clk_disable_unprepare(pdata->clk_ipg);
8f5fe77828e16e Philippe Reynes     2015-07-26  358  		dev_err(&pdev->dev, "unable to get ref clock!\n");
fdc9f0eace99b2 Anson Huang         2020-03-16  359  		return PTR_ERR(pdata->clk_ref);
8f5fe77828e16e Philippe Reynes     2015-07-26  360  	}
8f5fe77828e16e Philippe Reynes     2015-07-26  361  
8f5fe77828e16e Philippe Reynes     2015-07-26  362  	ret = clk_prepare_enable(pdata->clk_ref);
fdc9f0eace99b2 Anson Huang         2020-03-16  363  	if (ret) {
fdc9f0eace99b2 Anson Huang         2020-03-16  364  		clk_disable_unprepare(pdata->clk_ipg);
fdc9f0eace99b2 Anson Huang         2020-03-16  365  		return ret;
fdc9f0eace99b2 Anson Huang         2020-03-16  366  	}
fdc9f0eace99b2 Anson Huang         2020-03-16  367  
fdc9f0eace99b2 Anson Huang         2020-03-16  368  	ret = devm_add_action_or_reset(&pdev->dev, mxc_rtc_action, pdata);
8f5fe77828e16e Philippe Reynes     2015-07-26  369  	if (ret)
fdc9f0eace99b2 Anson Huang         2020-03-16  370  		return ret;
8f5fe77828e16e Philippe Reynes     2015-07-26  371  
8f5fe77828e16e Philippe Reynes     2015-07-26  372  	rate = clk_get_rate(pdata->clk_ref);
d00ed3cf6e5431 Daniel Mack         2009-09-22  373  
d00ed3cf6e5431 Daniel Mack         2009-09-22  374  	if (rate == 32768)
d00ed3cf6e5431 Daniel Mack         2009-09-22  375  		reg = RTC_INPUT_CLK_32768HZ;
d00ed3cf6e5431 Daniel Mack         2009-09-22  376  	else if (rate == 32000)
d00ed3cf6e5431 Daniel Mack         2009-09-22  377  		reg = RTC_INPUT_CLK_32000HZ;
d00ed3cf6e5431 Daniel Mack         2009-09-22  378  	else if (rate == 38400)
d00ed3cf6e5431 Daniel Mack         2009-09-22  379  		reg = RTC_INPUT_CLK_38400HZ;
d00ed3cf6e5431 Daniel Mack         2009-09-22  380  	else {
c783a29efcbc90 Vladimir Zapolskiy  2010-04-06  381  		dev_err(&pdev->dev, "rtc clock is not valid (%lu)\n", rate);
fdc9f0eace99b2 Anson Huang         2020-03-16  382  		return -EINVAL;
d00ed3cf6e5431 Daniel Mack         2009-09-22  383  	}
d00ed3cf6e5431 Daniel Mack         2009-09-22  384  
d00ed3cf6e5431 Daniel Mack         2009-09-22  385  	reg |= RTC_ENABLE_BIT;
d00ed3cf6e5431 Daniel Mack         2009-09-22  386  	writew(reg, (pdata->ioaddr + RTC_RTCCTL));
d00ed3cf6e5431 Daniel Mack         2009-09-22  387  	if (((readw(pdata->ioaddr + RTC_RTCCTL)) & RTC_ENABLE_BIT) == 0) {
d00ed3cf6e5431 Daniel Mack         2009-09-22  388  		dev_err(&pdev->dev, "hardware module can't be enabled!\n");
fdc9f0eace99b2 Anson Huang         2020-03-16  389  		return -EIO;
d00ed3cf6e5431 Daniel Mack         2009-09-22  390  	}
d00ed3cf6e5431 Daniel Mack         2009-09-22  391  
d00ed3cf6e5431 Daniel Mack         2009-09-22  392  	platform_set_drvdata(pdev, pdata);
d00ed3cf6e5431 Daniel Mack         2009-09-22  393  
d00ed3cf6e5431 Daniel Mack         2009-09-22  394  	/* Configure and enable the RTC */
d00ed3cf6e5431 Daniel Mack         2009-09-22  395  	pdata->irq = platform_get_irq(pdev, 0);
d00ed3cf6e5431 Daniel Mack         2009-09-22  396  
d00ed3cf6e5431 Daniel Mack         2009-09-22  397  	if (pdata->irq >= 0 &&
c783a29efcbc90 Vladimir Zapolskiy  2010-04-06  398  	    devm_request_irq(&pdev->dev, pdata->irq, mxc_rtc_interrupt,
c783a29efcbc90 Vladimir Zapolskiy  2010-04-06  399  			     IRQF_SHARED, pdev->name, pdev) < 0) {
d00ed3cf6e5431 Daniel Mack         2009-09-22  400  		dev_warn(&pdev->dev, "interrupt not available.\n");
d00ed3cf6e5431 Daniel Mack         2009-09-22  401  		pdata->irq = -1;
d00ed3cf6e5431 Daniel Mack         2009-09-22  402  	}
d00ed3cf6e5431 Daniel Mack         2009-09-22  403  
bc0e731fc2893f Anson Huang         2019-04-11  404  	if (pdata->irq >= 0) {
c92182ee0b5a33 Yauhen Kharuzhy     2012-01-10  405  		device_init_wakeup(&pdev->dev, 1);
bc0e731fc2893f Anson Huang         2019-04-11  406  		ret = dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
bc0e731fc2893f Anson Huang         2019-04-11  407  		if (ret)
bc0e731fc2893f Anson Huang         2019-04-11  408  			dev_err(&pdev->dev, "failed to enable irq wake\n");
bc0e731fc2893f Anson Huang         2019-04-11  409  	}
c92182ee0b5a33 Yauhen Kharuzhy     2012-01-10  410  
fdcfd854333be5 Bartosz Golaszewski 2020-11-09  411  	ret = devm_rtc_register_device(rtc);
d00ed3cf6e5431 Daniel Mack         2009-09-22  412  
d00ed3cf6e5431 Daniel Mack         2009-09-22  413  	return ret;
d00ed3cf6e5431 Daniel Mack         2009-09-22  414  }
d00ed3cf6e5431 Daniel Mack         2009-09-22  415  

:::::: The code at line 315 was first introduced by commit
:::::: ba7aa63000f26c5a2c87d5a716601499a02a3156 rtc: mxc: use of_device_get_match_data

:::::: TO: Alexandre Belloni <alexandre.belloni@bootlin.com>
:::::: CC: Alexandre Belloni <alexandre.belloni@bootlin.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
