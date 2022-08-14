Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D045920CF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiHNPbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHNP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 11:29:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A334B1EA;
        Sun, 14 Aug 2022 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660490950; x=1692026950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3SfdfjNGmlnbCkTHslz5z06m4uI/TDvjfqYOq7HY/3c=;
  b=NCa8ULDxA/GR12M8xm2SOQHh10PfhPTCEc5Yy89brWF3bkoO+FsT9aU3
   j+A4gbygYeCLLq1scz42u0D6JBRP25C05nJLJiGgGF6A1CWvy6w3YUxZZ
   UuhNuX68PGzxPPGLra4+rbQfb0R4/8gEkzuvHjtbYoAY4sVxHpU24nk+p
   755gKuSebQjp3jYvY8BXYl+YekYsBQizg8A5IRVN0yK/ZlSadYpD8sqKK
   XmjenapGZ8DES0PMZ5M1fAM3nGkRZ2GavsS1kcYljAHwzUjd183LM2lYt
   HmxLPEaH+uOQ3gFaqE0uUxyHTDRDVmC5IfKPpp2ajPC8NrJf7xoeYebUc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="378122492"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="378122492"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 08:29:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="582611215"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2022 08:29:02 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNFXx-0000EG-1v;
        Sun, 14 Aug 2022 15:29:01 +0000
Date:   Sun, 14 Aug 2022 23:28:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 07/12] clk: imx: Update pllv3 to support i.MXRT1170
Message-ID: <202208142303.ZxW0QfM2-lkp@intel.com>
References: <20220723160513.271692-8-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723160513.271692-8-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on abelvesa/clk/imx v5.19]
[cannot apply to soc/for-next linus/master next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/Add-support-for-the-i-MXRT1170-evk/20220724-000710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220814/202208142303.ZxW0QfM2-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/96413cc0300321ec18d27ca9983f349a41f99706
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jesse-Taube/Add-support-for-the-i-MXRT1170-evk/20220724-000710
        git checkout 96413cc0300321ec18d27ca9983f349a41f99706
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-pllv3.c:14:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
>> drivers/clk/imx/clk-pllv3.c:445:16: warning: no previous prototype for '__imx_clk_hw_pllv3' [-Wmissing-prototypes]
     445 | struct clk_hw *__imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
         |                ^~~~~~~~~~~~~~~~~~


vim +/__imx_clk_hw_pllv3 +445 drivers/clk/imx/clk-pllv3.c

   444	
 > 445	struct clk_hw *__imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
