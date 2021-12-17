Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1590478D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhLQOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:07:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:48436 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232823AbhLQOHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639750038; x=1671286038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Tr3Rfy4DHDjc7WiTpOq+P1aPRKZ4mJe5JHJHgReMOE=;
  b=YEzyGT+tefUj7JmoOp98lgfzbv3criP97KApuUHartantg2V0Y+3J0by
   x3zSI4xIhh7i2526ziZATgA3Fss5f2xZdXmDpS19MMmtJAf+bnp1A+0Ws
   o7wsXl+L3sqvPjGN9QIF/l+xBuS5TU9lsx4I0MRBpPG3y+2SZqotgqKcS
   eYQVpjcG8N5fx3fKjvdrsQN1onrmpQUnPU6IqQJk2/7L8t655wLwcajov
   MMCPxPeMC+cLyUFr+KGxCUGAdBbdAB8SJXhk+7hCerGXqnf6i5/Kqekcp
   RCecX1RGXaDY6pY8yIf6Faf7Om5qdWynq0jlF62td0GfcIPWkGUqVnS0w
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263934257"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="263934257"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 06:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466519954"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2021 06:07:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myDtB-0004nD-Ce; Fri, 17 Dec 2021 14:07:13 +0000
Date:   Fri, 17 Dec 2021 22:06:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] isoc: mediatek: potential use of error pointer
Message-ID: <202112172128.4DTbSyzc-lkp@intel.com>
References: <20211217120845.628024-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217120845.628024-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on broonie-spi/for-next linus/master mbgg-mediatek/for-next v5.16-rc5 next-20211216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiasheng-Jiang/isoc-mediatek-potential-use-of-error-pointer/20211217-201022
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211217/202112172128.4DTbSyzc-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1b5bac7d5052521b10c6c7ab2279cbd8c31cd458
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiasheng-Jiang/isoc-mediatek-potential-use-of-error-pointer/20211217-201022
        git checkout 1b5bac7d5052521b10c6c7ab2279cbd8c31cd458
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/soc/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/mediatek/mtk-scpsys.c: In function 'init_clks':
>> drivers/soc/mediatek/mtk-scpsys.c:421:32: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
     421 |                         return ERR_PTR(-ENOMEM);
         |                                ^~~~~~~~~~~~~~~~


vim +421 drivers/soc/mediatek/mtk-scpsys.c

   413	
   414	static int init_clks(struct platform_device *pdev, struct clk **clk)
   415	{
   416		int i;
   417	
   418		for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
   419			clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
   420			if (!clk[i])
 > 421				return ERR_PTR(-ENOMEM);
   422		}
   423		return 0;
   424	}
   425	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
