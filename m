Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59E4D8894
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbiCNPyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiCNPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:54:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224313D57;
        Mon, 14 Mar 2022 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647273171; x=1678809171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yJxxA91uWOhzYlVJp4lXDa6RpvyMWHjr+Q1DevJB14=;
  b=YhA2cr2fuhLmFzn55e/fQYghb8jMgYZ+T2BtZzZNAfFIneSWGh7KpjuM
   f7tWgi7NmXXN8CnCHQzCFtr/lfEnbiZpKGZWuzzJTEOnGBoNjurRw3N2A
   CiPjjQhhxqOnY/AQbivCYxQ5pBeU7v6DOx8zhntIwTkIwWnf5RC0M0l4Y
   84okfsfNflazpyI44lDWF2enQhIg65NRLMHGyiPmr0CL6Em3upFenYN3M
   FYnm8AaKiWrikjmgJ8KOmTJyJxnvYYm6AKfSKy18m2LlTso05aHEEM568
   N8y3jHS/U5X2m5jCWJ68g0M6hv0I/DaBVRVTBSiQuNr+fordPtfceJ+7O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="319289816"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="319289816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 08:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="612936984"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Mar 2022 08:52:47 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTn02-0009zN-IK; Mon, 14 Mar 2022 15:52:46 +0000
Date:   Mon, 14 Mar 2022 23:52:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     frank zago <frank@zago.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        gunar@schorcht.net, Lee Jones <lee.jones@linaro.org>
Cc:     kbuild-all@lists.01.org, frank zago <frank@zago.net>
Subject: Re: [PATCH v3] mfd: ch341: add driver for the WCH CH341 in I2C/GPIO
 mode
Message-ID: <202203142302.5s8nv83m-lkp@intel.com>
References: <20220314030937.22762-1-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314030937.22762-1-frank@zago.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi frank,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on linux/master linus/master v5.17-rc8 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/frank-zago/mfd-ch341-add-driver-for-the-WCH-CH341-in-I2C-GPIO-mode/20220314-111158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220314/202203142302.5s8nv83m-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bba0dbb56cafdad51de5ccb8ab6714d5b14d0782
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review frank-zago/mfd-ch341-add-driver-for-the-WCH-CH341-in-I2C-GPIO-mode/20220314-111158
        git checkout bba0dbb56cafdad51de5ccb8ab6714d5b14d0782
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "arizona_request_irq" [sound/soc/codecs/snd-soc-wm5110.ko] undefined!
>> ERROR: modpost: "arizona_free_irq" [sound/soc/codecs/snd-soc-wm5110.ko] undefined!
>> ERROR: modpost: "arizona_set_irq_wake" [sound/soc/codecs/snd-soc-wm5110.ko] undefined!
>> ERROR: modpost: "arizona_request_irq" [sound/soc/codecs/snd-soc-wm5102.ko] undefined!
>> ERROR: modpost: "arizona_free_irq" [sound/soc/codecs/snd-soc-wm5102.ko] undefined!
>> ERROR: modpost: "arizona_set_irq_wake" [sound/soc/codecs/snd-soc-wm5102.ko] undefined!
>> ERROR: modpost: "arizona_request_irq" [sound/soc/codecs/snd-soc-cs47l24.ko] undefined!
>> ERROR: modpost: "arizona_free_irq" [sound/soc/codecs/snd-soc-cs47l24.ko] undefined!
>> ERROR: modpost: "arizona_set_irq_wake" [sound/soc/codecs/snd-soc-cs47l24.ko] undefined!
>> ERROR: modpost: "arizona_request_irq" [sound/soc/codecs/snd-soc-arizona.ko] undefined!
WARNING: modpost: suppressed 16 unresolved symbol warnings because there were too many)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
