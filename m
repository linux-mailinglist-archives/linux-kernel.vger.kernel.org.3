Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E746F7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhLJAEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:04:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:16520 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhLJAEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639094462; x=1670630462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eb/4cViKituIHR/DMC2dgTFKhqJBwaxip/BgKslpnk0=;
  b=djfwMNO1i4S1fz9r3shXote+w3FuqC4jwf2lMXNeL6A/VXKLPsFOOFT+
   tXZsSex5em/Jw+nzcMJ1u8s03C4F/XtT4ffLcVlM0v7S8Crfvx2DkLqu3
   LpE18pyhuPgCrRXIyHzTNSc+lP2UtNxB57umh5wT+L5dpIrwVeVpWXw7S
   e0zMqfrYzTQuWPIEMrddQrJkjSf4HUtRn5x+Hon8NZ3SBaJw4nvoqE+lg
   bys9TYQaozzhXAn0x38WD+uGHzvOV0sAuPBUOTnBTCfTYx5e136VCij+Q
   vcMvortcjRQCdb1/37DVuuB/yYx33YnFwHWCG4CGzjW6Ut4NXsUlFkYBL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="299022778"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="299022778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 16:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="564999247"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2021 16:00:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvTLC-0002Wf-RO; Fri, 10 Dec 2021 00:00:46 +0000
Date:   Fri, 10 Dec 2021 07:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest 36/144] arch/x86/mm/mem_encrypt_common.c:14:6:
 warning: no previous prototype for 'force_dma_unencrypted'
Message-ID: <202112100722.xdCK1rLH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   41fe88a1b3c28543f49fa6ed9e0e9b6650ed7614
commit: e6712c98ae60430d8f0d207fa3352e408a56c69f [36/144] x86/mm: Move force_dma_unencrypted() to common code
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211210/202112100722.xdCK1rLH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/e6712c98ae60430d8f0d207fa3352e408a56c69f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout e6712c98ae60430d8f0d207fa3352e408a56c69f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/mem_encrypt_common.c:14:6: warning: no previous prototype for 'force_dma_unencrypted' [-Wmissing-prototypes]
      14 | bool force_dma_unencrypted(struct device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/force_dma_unencrypted +14 arch/x86/mm/mem_encrypt_common.c

    12	
    13	/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
  > 14	bool force_dma_unencrypted(struct device *dev)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
