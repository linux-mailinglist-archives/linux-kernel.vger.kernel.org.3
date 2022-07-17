Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8965774D3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 08:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiGQGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 02:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiGQGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 02:54:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410F95B4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658040860; x=1689576860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YU6597KnKjZBoIFs0e8ZFRsZnAWj174Ss7PFQNdbZsU=;
  b=Oyg8Cl/nDS0QAxMscXPHRM9cfHJW6Bt+CFPCOl8m1SHtd/ZdK8FDLOw+
   OTJ9FI04UM0KReSrqdculiSALV4iMb6/41UcLmJjBonlFM6NUi3yJleVY
   gU1Ug4OhNoSrpr63W2u7WVo7IGiOuNbSpsNSjnhrSL3OfhUN6pRxgrIm4
   SOCKha+m/f5xs7dG10FS5v7so5c19JJkELQjxAJNofixvOy8KM4PSTy+x
   zzyskHSXKUKaCpaLkPqfMRfZ2O3fRoG3pkpLEzW8rZuGOudpQLHpD4XFc
   sHKNnusgqfJBTaxH74+M7oq0Qvt0zZyPJMg8t3U1WM/ku/Nrcl+ljr9UJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="372345373"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="372345373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 23:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="664654034"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2022 23:54:18 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCyAT-0002se-Ur;
        Sun, 17 Jul 2022 06:54:17 +0000
Date:   Sun, 17 Jul 2022 14:53:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wojciech Bartczak <wbartczak@marvell.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, wbartczak@gmail.com,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Piyush Malgujar <pmalgujar@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH 2/2] mailbox: mvl_mhu: Add support for Marvell Message
 Handling Unit
Message-ID: <202207171422.pEzwmwkV-lkp@intel.com>
References: <20220714121215.22931-3-wbartczak@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714121215.22931-3-wbartczak@marvell.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wojciech,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on fujitsu-integration/mailbox-for-next linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wojciech-Bartczak/Add-support-for-Marvell-MHU-on-CN9x-and-CN10x-SoC/20220714-201522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220717/202207171422.pEzwmwkV-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f04835250e257b46acead49e6233aa6857e159df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wojciech-Bartczak/Add-support-for-Marvell-MHU-on-CN9x-and-CN10x-SoC/20220714-201522
        git checkout f04835250e257b46acead49e6233aa6857e159df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/mailbox/ drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/mailbox/mvl_mhu.c: In function 'mhu_pci_setup_irq':
>> drivers/mailbox/mvl_mhu.c:331:29: warning: variable 'np' set but not used [-Wunused-but-set-variable]
     331 |         struct device_node *np;
         |                             ^~


vim +/np +331 drivers/mailbox/mvl_mhu.c

   325	
   326	/* PCI interface in case of LPI based configuration */
   327	static int mhu_pci_setup_irq(struct pci_dev *pdev)
   328	{
   329		struct device *dev;
   330		struct mhu *mhu;
 > 331		struct device_node *np;
   332		int irq, ret, nvec;
   333	
   334		mhu = pci_get_drvdata(pdev);
   335		dev = &pdev->dev;
   336		np = dev->of_node;
   337	
   338		nvec = pci_alloc_irq_vectors(pdev, 0, 3, PCI_IRQ_MSIX);
   339		if (nvec < 0)
   340			return nvec;
   341	
   342		irq = pci_irq_vector(pdev, SCP_TO_AP_INTERRUPT);
   343		if (irq < 0) {
   344			ret = irq;
   345			goto irq_err;
   346		}
   347	
   348		ret = devm_request_threaded_irq(dev, irq, mhu_rx_interrupt,
   349						mhu_rx_interrupt_thread, 0,
   350						"mvl-mhu", mhu);
   351		if (ret)
   352			goto irq_err;
   353	
   354		return 0;
   355	
   356	irq_err:
   357		pci_free_irq_vectors(pdev);
   358	
   359		return ret;
   360	}
   361	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
