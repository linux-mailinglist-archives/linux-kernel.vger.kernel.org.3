Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6C4F00F5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354620AbiDBLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiDBLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:08:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254C1A2A3C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648897608; x=1680433608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTrwRC9CVEj2XQ9MRG+jq1Dx8X22KCSb9lse/9+ObOo=;
  b=FeWPDkMqg0fsSi2TRhuFW12bUUpOo6edYr3vWwPOE+aTV7Jjnybcd1rp
   j+Ih+Tm44DAI4GtraGyJuWyDkJszJmTl+Yd5JQEP5Ocvznxzs5LanqTwc
   OHKI5LHQD3pNxgQHIGyWkVb6qksEc19VbyR1by/wxPywrzPV+eMwermy7
   Td/RnP7BBfZsQhCaPYN7kuagiWoV6/hTNh+DheSP/HtUUrD8lQ4Ws54Si
   5GTFehLILzOfGfTpGqfdHIBf0tTp5umWsCJXU4uEFbr6UMmWUxE+Zb7V7
   wWoKy9RXRC2SGjUbBbJTjnj3bj00sm9waW0en17YB6cILOuzduJXLC/Rn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240232984"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="240232984"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 04:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="504438268"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2022 04:06:46 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nabaf-00003j-Lj;
        Sat, 02 Apr 2022 11:06:45 +0000
Date:   Sat, 2 Apr 2022 19:05:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 7/7] staging: vt6655: Convert macro PCAvDelayByIO to
 function
Message-ID: <202204021811.0EJtWYxo-lkp@intel.com>
References: <b7551e92f42d60ff3bb74b5e28467f09781e3d06.1648882847.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7551e92f42d60ff3bb74b5e28467f09781e3d06.1648882847.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Hortmann/staging-vt6655-Fix-CamelCase-in-upc-h-and-started-in-mac-h/20220402-153118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git b22c721c4f3fd4608da059c56fbe7a0cc598fb6a
config: parisc-buildonly-randconfig-r006-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021811.0EJtWYxo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/87b8c1713c4ec7a743b07417150821e2c83dd49d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-vt6655-Fix-CamelCase-in-upc-h-and-started-in-mac-h/20220402-153118
        git checkout 87b8c1713c4ec7a743b07417150821e2c83dd49d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/staging/vt6655/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/vt6655/srom.c: In function 'PCAvDelayByIO':
>> drivers/staging/vt6655/srom.c:145:23: warning: variable 'data' set but not used [-Wunused-but-set-variable]
     145 |         unsigned char data;
         |                       ^~~~


vim +/data +145 drivers/staging/vt6655/srom.c

   142	
   143	void PCAvDelayByIO(unsigned char u_delay_unit)
   144	{
 > 145		unsigned char data;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
