Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AD485263
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiAEMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:24:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:6697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbiAEMYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641385481; x=1672921481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SlgaR6uzmEBK8uFF5uCky/iCc0048T/UdOFjxlvuZG4=;
  b=CkCSGe8/iGYCCyZeZnNroj1Kog2iHLyBpLdeJY1KqXDEtiA6IK6fcqpD
   1T9bRA/SccSiuhmAy3gxy1Af0B9Gp/iBlplQFQuXjaY5pLHvywzLBtDuU
   wzi8ctpCqEON/EvCnA+Pm/DZe1DIhX6lt08jnGdgpcS72UPYYlYHeA9hp
   iQW3ACDHMakGs6Bdhcx+9qWLTCm38tvAUePQceCltfl/JASQzxBMC8u47
   91CchnH2vfzAft06k0LJX6ukjkPmiImukRLwbI+8c27KsXjd4I3joPGF0
   LPsgYNGNAIp2qvqHT7fycYu50m9FtoTqoHQfh0OX2PbXJz6rYT+DbjUTp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242225532"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="242225532"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="574371101"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jan 2022 04:24:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n55LK-000GaY-53; Wed, 05 Jan 2022 12:24:38 +0000
Date:   Wed, 5 Jan 2022 20:24:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 3/3] nvmem: add driver handling U-Boot environment
 variables
Message-ID: <202201052036.kcalPY98-lkp@intel.com>
References: <20211230090449.11808-3-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211230090449.11808-3-zajec5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Rafał,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on mtd/mtd/next mtd/mtd/fixes linus/master v5.16-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Rafa-Mi-ecki/mtd-core-call-devm_of_platform_populate-for-MTD-devices/20211230-170531
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r003-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052036.kcalPY98-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/52f6be4712d04b927cd356dd95940bd76f1f5b97
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rafa-Mi-ecki/mtd-core-call-devm_of_platform_populate-for-MTD-devices/20211230-170531
        git checkout 52f6be4712d04b927cd356dd95940bd76f1f5b97
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/nvmem/u-boot-env.o: in function `u_boot_env_read':
>> u-boot-env.c:(.text+0x4c): undefined reference to `mtd_read'
   aarch64-linux-ld: drivers/nvmem/u-boot-env.o: in function `u_boot_env_probe':
>> u-boot-env.c:(.text+0x3e0): undefined reference to `get_mtd_device_nm'
>> aarch64-linux-ld: u-boot-env.c:(.text+0x428): undefined reference to `mtd_read'
   aarch64-linux-ld: u-boot-env.c:(.text+0x494): undefined reference to `mtd_read'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
