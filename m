Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309FA590F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbiHLK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiHLK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:27:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E638A7A87
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660300061; x=1691836061;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Vda0yhnea5C2mVxpxl36PlL59vFRbSrHJsTEocXjquM=;
  b=VnTlHYLgfde1SR90GQpK55Elv5liVq33x+bXNqj7Vamz9xbjqNXrxdjj
   5LTN5TT79n2e1Nzq3OEvAU0v0rfBl9turFCYw12xe1tDLfY7amM8TOZEz
   q0eYWIRTSOvLCfeRLH9FvEOSuE5JUBqnJzfiaHRNsQlwpBynJntF71fdR
   2/yg3Ex7YamJWV8o0JKQJk69IGB7yWhTq6AdlkSorAoz/97kDW1ZqlWFX
   /EVXjH7dm3afx++yCVZ834rmgQE5PVW+rDIzmERvH5Nful4CuCdJqpJPn
   CCUuQ3CQhm84ZKpZ+fYkLgXgbA8uLDBZeytJ+0Wxu04dZVX/BDtLUCsss
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292363698"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292363698"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 03:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556474209"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2022 03:27:39 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMRtC-0000QX-2W;
        Fri, 12 Aug 2022 10:27:38 +0000
Date:   Fri, 12 Aug 2022 18:27:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/pci/controller/pci-mvebu.c:437:17: sparse: sparse:
 restricted __le16 degrades to integer
Message-ID: <202208121820.xIY9r04c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ebfc85e2cd7b08f518b526173e9a33b56b3913b
commit: 0746ae1be12177ebda0666eefa82583cbaeeefd6 PCI: mvebu: Add support for compiling driver as module
date:   7 months ago
config: arm-randconfig-s051-20220811 (https://download.01.org/0day-ci/archive/20220812/202208121820.xIY9r04c-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0746ae1be12177ebda0666eefa82583cbaeeefd6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0746ae1be12177ebda0666eefa82583cbaeeefd6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-mvebu/ drivers/pci/controller/ drivers/soc/bcm/brcmstb/pm/ drivers/soc/ti/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/pci-mvebu.c:437:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:437:38: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:455:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:458:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:472:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:472:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:482:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:483:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:727:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] vendor @@     got int @@
   drivers/pci/controller/pci-mvebu.c:727:29: sparse:     expected restricted __le16 [usertype] vendor
   drivers/pci/controller/pci-mvebu.c:727:29: sparse:     got int
   drivers/pci/controller/pci-mvebu.c:728:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] device @@     got unsigned int @@
   drivers/pci/controller/pci-mvebu.c:728:29: sparse:     expected restricted __le16 [usertype] device
   drivers/pci/controller/pci-mvebu.c:728:29: sparse:     got unsigned int
   drivers/pci/controller/pci-mvebu.c:729:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] class_revision @@     got unsigned int @@
   drivers/pci/controller/pci-mvebu.c:729:37: sparse:     expected restricted __le32 [usertype] class_revision
   drivers/pci/controller/pci-mvebu.c:729:37: sparse:     got unsigned int

vim +437 drivers/pci/controller/pci-mvebu.c

d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  429  
e7a01876729c3e drivers/pci/controller/pci-mvebu.c Pali Rohár       2021-11-25  430  static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  431  {
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  432  	struct mvebu_pcie_window desired = {};
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  433  	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  434  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  435  	/* Are the new iobase/iolimit values invalid? */
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  436  	if (conf->iolimit < conf->iobase ||
e7a01876729c3e drivers/pci/controller/pci-mvebu.c Pali Rohár       2021-11-25 @437  	    conf->iolimitupper < conf->iobaseupper)
e7a01876729c3e drivers/pci/controller/pci-mvebu.c Pali Rohár       2021-11-25  438  		return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  439  					     &desired, &port->iowin);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  440  
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  441  	if (!mvebu_has_ioport(port)) {
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  442  		dev_WARN(&port->pcie->pdev->dev,
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  443  			 "Attempt to set IO when IO is disabled\n");
e7a01876729c3e drivers/pci/controller/pci-mvebu.c Pali Rohár       2021-11-25  444  		return -EOPNOTSUPP;
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  445  	}
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  446  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  447  	/*
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  448  	 * We read the PCI-to-PCI bridge emulated registers, and
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  449  	 * calculate the base address and size of the address decoding
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  450  	 * window to setup, according to the PCI-to-PCI bridge
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  451  	 * specifications. iobase is the bus address, port->iowin_base
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  452  	 * is the CPU address.
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  453  	 */
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  454  	desired.remap = ((conf->iobase & 0xF0) << 8) |
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  455  			(conf->iobaseupper << 16);
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  456  	desired.base = port->pcie->io.start + desired.remap;
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  457  	desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  458  			 (conf->iolimitupper << 16)) -
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  459  			desired.remap) +
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  460  		       1;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  461  
e7a01876729c3e drivers/pci/controller/pci-mvebu.c Pali Rohár       2021-11-25  462  	return mvebu_pcie_set_window(port, port->io_target, port->io_attr, &desired,
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  463  				     &port->iowin);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  464  }
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  465  

:::::: The code at line 437 was first introduced by commit
:::::: e7a01876729c3e650c5f6ee446b71a309d1c55ab PCI: mvebu: Propagate errors when updating PCI_IO_BASE and PCI_MEM_BASE registers

:::::: TO: Pali Rohár <pali@kernel.org>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
