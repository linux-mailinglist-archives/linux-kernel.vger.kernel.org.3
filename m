Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C285B00A0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIGJhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiIGJhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:37:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF56B24A0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662543454; x=1694079454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qwrRz2PJoIrSfdeLL29HsQpHE+uDy/qPi96IHS2C6DI=;
  b=L+iQ7AYUMbdQUd78os49tMtxn/8qMkzVTKHD+7MyJMOtNK/CwtJgWgfl
   LQhUmxoqpVgpBecGxWYn52KT9GiWq+0NgNjwC8YlClt3vgQYmWbnr+Jrr
   lndISwll07VLLnRi3y3fn6zGptGct49bp0LMyKlhK5xypjXvHbiI2v5Ar
   kPTVF50qjoRciUyXJOWfJYyuG6UwP2WrEeNkZh3bpz5GOGKCPx8otl/gU
   HJHgP97Bku82xLD0ZWnuwrgJVrkqr1pMSgUFCTb+pnP7SreBOtkFUN4UK
   1R8f/LzSD+eyjxNM472fAFUsxq+z1ymbIAsV+196NZkb9k72xsRjlNHqi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358542983"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="358542983"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="565440392"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 02:37:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVrUb-0006P3-1r;
        Wed, 07 Sep 2022 09:37:09 +0000
Date:   Wed, 7 Sep 2022 17:36:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>, ojeda@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: Re: [PATCH] auxdisplay: hd44780: Fix potential memory leak in
 hd44780_remove()
Message-ID: <202209071724.9KXWPPZ7-lkp@intel.com>
References: <20220907070735.56488-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907070735.56488-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianglei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc4 next-20220906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianglei-Nie/auxdisplay-hd44780-Fix-potential-memory-leak-in-hd44780_remove/20220907-151008
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0066f1b0e27556381402db3ff31f85d2a2265858
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220907/202209071724.9KXWPPZ7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bef273823cd1f11736f4e0ce7fcf5d4ac2e1b972
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jianglei-Nie/auxdisplay-hd44780-Fix-potential-memory-leak-in-hd44780_remove/20220907-151008
        git checkout bef273823cd1f11736f4e0ce7fcf5d4ac2e1b972
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/auxdisplay/hd44780.c: In function 'hd44780_remove':
>> drivers/auxdisplay/hd44780.c:327:27: warning: dereferencing 'void *' pointer
     327 |         kfree(lcd->drvdata->hd44780);
         |                           ^~
   drivers/auxdisplay/hd44780.c:327:27: error: request for member 'hd44780' in something not a structure or union


vim +327 drivers/auxdisplay/hd44780.c

   321	
   322	static int hd44780_remove(struct platform_device *pdev)
   323	{
   324		struct charlcd *lcd = platform_get_drvdata(pdev);
   325	
   326		charlcd_unregister(lcd);
 > 327		kfree(lcd->drvdata->hd44780);
   328		kfree(lcd->drvdata);
   329	
   330		kfree(lcd);
   331		return 0;
   332	}
   333	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
