Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7654B3443
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiBLKkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:40:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiBLKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:39:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D308026544;
        Sat, 12 Feb 2022 02:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644662384; x=1676198384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i2kFxobRZrFp47lN9RhnaWjJfWwlZNp7bRVEfKX/jtc=;
  b=PS4K/jQwCHvEqVr5CpG0IF0yxBkIk9S6Y+cP4vClYcK/8dNpB58ZSvBB
   K+HypB7nFCF7YLXTndJRCmR+Oyuz6lZNzGDUReQC3da0Ye4eiMbq8C7eq
   0I/Jrm+umoXksFUbHG2ceueaMjKNVsDwaj1csP67vdq9hx+rRwH7WH8VD
   9AYwcDzP6ibw+y1lFkL+SLG8/IOXje+irBquo4GnfpTW59C542zIQjrN3
   jgr5d7IOGBH3c6e5hY+ucluDE240qu6rGSpmhxsGqxww/B76tjzrt0Geq
   a3SiUK8qbNaRDPIDPI+OEkKEGQieLXscUtZkMNgXeZ94Nih7kqHlY0v8/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="230511977"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="230511977"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 02:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="623458386"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Feb 2022 02:39:41 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIpob-00061O-1i; Sat, 12 Feb 2022 10:39:41 +0000
Date:   Sat, 12 Feb 2022 18:39:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Report which option to enable for
 blacklisted PCI devices
Message-ID: <202202121734.Zc1GlUwC-lkp@intel.com>
References: <alpine.DEB.2.21.2202062133570.34636@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202062133570.34636@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Maciej,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on usb/usb-testing v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maciej-W-Rozycki/serial-8250-Correct-basic-issues-with-the-PCI-blacklist/20220212-164230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220212/202202121734.Zc1GlUwC-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/aa68e36c332457acb464b083c920d10f0e5a9865
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maciej-W-Rozycki/serial-8250-Correct-basic-issues-with-the-PCI-blacklist/20220212-164230
        git checkout aa68e36c332457acb464b083c920d10f0e5a9865
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_pci.c:3522:9: error: initializer element is not computable at load time
    3522 |         (IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
         |         ^
   drivers/tty/serial/8250/8250_pci.c:3535:39: note: in expansion of macro 'REPORT_CONFIG'
    3535 |         { PCI_DEVICE(0x4348, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
         |                                       ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_pci.c:3522:9: note: (near initialization for 'blacklist[3].class')
    3522 |         (IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
         |         ^
   drivers/tty/serial/8250/8250_pci.c:3535:39: note: in expansion of macro 'REPORT_CONFIG'
    3535 |         { PCI_DEVICE(0x4348, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
         |                                       ^~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_pci.c:3522:9: error: initializer element is not computable at load time
    3522 |         (IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
         |         ^
   drivers/tty/serial/8250/8250_pci.c:3537:39: note: in expansion of macro 'REPORT_CONFIG'
    3537 |         { PCI_DEVICE(0x4348, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
         |                                       ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_pci.c:3522:9: note: (near initialization for 'blacklist[4].class')
    3522 |         (IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
         |         ^
   drivers/tty/serial/8250/8250_pci.c:3537:39: note: in expansion of macro 'REPORT_CONFIG'
    3537 |         { PCI_DEVICE(0x4348, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
         |                                       ^~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_pci.c:3522:9: error: initializer element is not computable at load time
    3522 |         (IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
         |         ^
   drivers/tty/serial/8250/8250_pci.c:3539:39: note: in expansion of macro 'REPORT_CONFIG'
    3539 |         { PCI_DEVICE(0x1c00, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
         |                                       ^~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_pci.c:3522:9: note: (near initialization for 'blacklist[5].class')
    3522 |         (IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
         |         ^
   drivers/tty/serial/8250/8250_pci.c:3539:39: note: in expansion of macro 'REPORT_CONFIG'
    3539 |         { PCI_DEVICE(0x1c00, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
         |                                       ^~~~~~~~~~~~~


vim +3522 drivers/tty/serial/8250/8250_pci.c

  3520	
  3521	#define REPORT_CONFIG(option) \
> 3522		(IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
  3523	#define REPORT_8250_CONFIG(option) \
  3524		(IS_ENABLED(CONFIG_SERIAL_8250_##option) ? \
  3525		 0 : (kernel_ulong_t)&"SERIAL_8250_"#option)
  3526	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
