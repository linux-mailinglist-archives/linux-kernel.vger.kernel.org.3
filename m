Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2259F18D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiHXC5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHXC5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:57:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4D7D7AC;
        Tue, 23 Aug 2022 19:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661309839; x=1692845839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jy6uHgqMUfjwvrFCqsckoPadRCKuYpnXSLFD6tiP3I0=;
  b=npxwTA/EKED1rzNAWLSBGUd7A4JqneayEA75qvJGdo5FeyQiOdeBZ98s
   3i1MvxtA89BacIcMkYGU3iu4nA1kAIaXjRXBVNJWEJucDPawOgLnKwl6a
   lByCKWbDJiC1q9+YxOZWXJ+F+4OnH7KcjtTwXA2nxSf8xVeAU3WrELPXP
   VdiisgDEvE+3Y+LqzwfheejavYssnZH1x+8btujcQfBszUpELn2E+YefS
   6OV6U3ug13wZqbOdxQZMyOl28wtQY9VN77NJtrC75jkvAipiDnKNfFVKJ
   GyhMboN5ZPZ3XQxYf4OPzp5gDlKe7QlnXew5XhB0UgOpZ3QZGeJPJ2lCW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="291415128"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="291415128"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 19:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="937723909"
Received: from lkp-server02.sh.intel.com (HELO 9bbcefcddf9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2022 19:57:15 -0700
Received: from kbuild by 9bbcefcddf9f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQgZv-0000tf-0o;
        Wed, 24 Aug 2022 02:57:15 +0000
Date:   Wed, 24 Aug 2022 10:57:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <parent.f@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v4 4/4] clk: mediatek: add driver for MT8365 SoC
Message-ID: <202208241051.Xi9D8DaW-lkp@intel.com>
References: <20220822152652.3499972-5-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822152652.3499972-5-msp@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next linus/master v6.0-rc2 next-20220823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/clk-mediatek-Add-mt8365-support/20220822-233030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220824/202208241051.Xi9D8DaW-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/51c1bac1ab0d284ab6c444966eee437c23095a85
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Markus-Schneider-Pargmann/clk-mediatek-Add-mt8365-support/20220822-233030
        git checkout 51c1bac1ab0d284ab6c444966eee437c23095a85
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mtk_clk_register_gates_with_dev" [drivers/clk/mediatek/clk-mt8365-mm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
