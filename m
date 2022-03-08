Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491424D1FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbiCHSFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCHSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:05:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AED369F5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646762651; x=1678298651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SHpKuGI9oHFfctlODTuptb1JZ19Bc9t1iU7ejKEcWwY=;
  b=YkMMiSi1P4lkJK3isTb8H3uywSGtPTeGpvjV+eFbOEpBI81QfdD/4d0P
   NA+pgEAw0GC3Km9lhyYTEB9eih57Mxf1VxRcxqEp7RSUAcpKLbIQs7PJJ
   xbPOhT87pL1ZlMKVFVrS/XkXn9Shx0mV+Dxzi7CYt53aWqBVwsdxi4POW
   wIHvjMdsRCtiG58CXYUsMSGHqVlMi6Yt/P2AjkrPrxleXOgJ2wDXkg72n
   1q43jrzQIgrhfZ1c0LwWjrOavKOoRLAhbjY+hOWXF5hgmf6U5N6CApax7
   DyP7LlM+ArnigrwB1NXCu26zMuekr+I6dCSeL1d7ccSytxRg6VCoNArmd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254959795"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254959795"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 10:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="513208708"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2022 10:03:34 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nReBJ-0001nC-U1; Tue, 08 Mar 2022 18:03:33 +0000
Date:   Wed, 9 Mar 2022 02:03:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: pcie.c:undefined reference to `pci_remap_iospace'
Message-ID: <202203090147.24cUL0De-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ea4424be16887a37735d6550cfd0611528dbe5d9
commit: 6198461ef509356e7f0fe5b04e88009aa698a065 arm: ioremap: Replace pci_ioremap_io() usage by pci_remap_iospace()
date:   3 months ago
config: arm-randconfig-r033-20220308 (https://download.01.org/0day-ci/archive/20220309/202203090147.24cUL0De-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6198461ef509356e7f0fe5b04e88009aa698a065
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6198461ef509356e7f0fe5b04e88009aa698a065
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mach-dove/pcie.o: in function `dove_pcie_setup':
>> pcie.c:(.init.text+0xd4): undefined reference to `pci_remap_iospace'
   arm-linux-gnueabi-ld: drivers/pci/pci.o: in function `devm_pci_remap_iospace':
   (.text+0x1372): undefined reference to `pci_remap_iospace'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
