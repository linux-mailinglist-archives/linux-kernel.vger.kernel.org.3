Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0352258BBDF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiHGQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiHGQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:42:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAC2BD2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659890565; x=1691426565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m7UDkbcSJofd2FzwIFR35QKztaXGo8SNOzvGgY8tgg4=;
  b=bKXaZDfTHOIIVCufO4QPcFDJ3efM+lKS25ueG2xhtrNta6vm2d8QjoDr
   pXqXms1UKJBm/B7w1BjcOjy44A81zkXj1yLsRyfb5WrYwDOrCsuSfLOE6
   HzPNmi5gbwzJeyy3xHZMHPP+6oWSeHn4DNw4dVaSYkVwawA3Rr3LdE5ME
   PKi+3AG7leEG851o/BFvfcHzAqQ8AfHFI/kHwLaKUqxnZbxTG9a84kVW1
   d8/9aDWbh5DEHFZ4qzVfjIceiGZTkfEYC4tDNLYyKXhZgiVYBvcnMzH+T
   pKVBA5qbze7dxqA7NVl21JqdPDHCVWwhK7B4Kfsz47kC7jn3p+/UdcAqa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="270835801"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="270835801"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 09:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="707165521"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2022 09:42:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKjMP-000LTg-2a;
        Sun, 07 Aug 2022 16:42:41 +0000
Date:   Mon, 8 Aug 2022 00:42:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 26/28] mfd: stmpe: Remove #ifdef guards for PM related
 functions
Message-ID: <202208080002.oJGJBzP5-lkp@intel.com>
References: <20220807145247.46107-27-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807145247.46107-27-paul@crapouillou.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v5.19]
[cannot apply to lee-mfd/for-mfd-next linus/master next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
config: openrisc-randconfig-r015-20220807 (https://download.01.org/0day-ci/archive/20220808/202208080002.oJGJBzP5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e94df3ff809e588320625b95a2ef6485965ddc02
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paul-Cercueil/mfd-Remove-ifdef-guards-for-PM-functions/20220807-225947
        git checkout e94df3ff809e588320625b95a2ef6485965ddc02
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/mfd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mfd/stmpe.c:1531:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
    1531 | const EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmpe_dev_pm_ops,
         | ^~~~~


vim +/static +1531 drivers/mfd/stmpe.c

  1530	
> 1531	const EXPORT_GPL_SIMPLE_DEV_PM_OPS(stmpe_dev_pm_ops,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
