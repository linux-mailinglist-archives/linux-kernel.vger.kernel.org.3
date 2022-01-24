Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D09C49826D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiAXObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:31:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:21700 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240012AbiAXOav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643034651; x=1674570651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nudg5qbTtQViKGAxaUznleByO69cHvoMReft5UXdhmA=;
  b=W7K7P8eptrfPDFyiu734J+CUUAjS4b/ASe/bY2veyy+OQBGsu+XxPuTK
   MlQMxJMQux8GCSOuxK+63y9OrUE4A1uDgPLduiQgbyhlXWmC+ICB33CwQ
   pSf8vSijdfedijKzRGVEm7HCEVLz47MH1UITEU8forbQOGgEbq75GcEMa
   F4q4FqQUV5UZiS3LMT/iv08w0S3ku6xMuCXyGPTB7rIC5P5XZAvs14cjL
   NveulgO/sbSTGo674Ye2DmW2zCF6/mQ3EDR2F1bHzdjMnsivtVlEngKea
   3qzRDjDJZ3R4KX5COBozCPDZABIYzYdJ1l9n3T/IOos9c3asvuPUQKMa9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245837641"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245837641"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="494635334"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Jan 2022 06:30:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC0Mm-000ISe-7v; Mon, 24 Jan 2022 14:30:44 +0000
Date:   Mon, 24 Jan 2022 22:30:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan@kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 10/11] serial: make uart_console_write->putchar()'s
 character a char
Message-ID: <202201242255.WTSwb6EN-lkp@intel.com>
References: <20220124071430.14907-11-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124071430.14907-11-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v5.17-rc1 next-20220124]
[cannot apply to shawnguo/for-next davem-sparc/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jiri-Slaby/TTY-patches-for-5-18/20220124-151758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: microblaze-randconfig-r006-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242255.WTSwb6EN-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/45520d4f6db241db0b77f41162adba4a9977956c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiri-Slaby/TTY-patches-for-5-18/20220124-151758
        git checkout 45520d4f6db241db0b77f41162adba4a9977956c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/sprd_serial.c: In function 'sprd_console_write':
>> drivers/tty/serial/sprd_serial.c:1007:44: error: passing argument 4 of 'uart_console_write' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1007 |         uart_console_write(port, s, count, sprd_console_putchar);
         |                                            ^~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            void (*)(struct uart_port *, int)
   In file included from drivers/tty/serial/sprd_serial.c:18:
   include/linux/serial_core.h:402:32: note: expected 'void (*)(struct uart_port *, char)' but argument is of type 'void (*)(struct uart_port *, int)'
     402 |                         void (*putchar)(struct uart_port *, char));
         |                         ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/uart_console_write +1007 drivers/tty/serial/sprd_serial.c

b7396a38fb28db Chunyan Zhang 2015-01-28   992  
b7396a38fb28db Chunyan Zhang 2015-01-28   993  static void sprd_console_write(struct console *co, const char *s,
b7396a38fb28db Chunyan Zhang 2015-01-28   994  			       unsigned int count)
b7396a38fb28db Chunyan Zhang 2015-01-28   995  {
b7396a38fb28db Chunyan Zhang 2015-01-28   996  	struct uart_port *port = &sprd_port[co->index]->port;
b7396a38fb28db Chunyan Zhang 2015-01-28   997  	int locked = 1;
b7396a38fb28db Chunyan Zhang 2015-01-28   998  	unsigned long flags;
b7396a38fb28db Chunyan Zhang 2015-01-28   999  
b7396a38fb28db Chunyan Zhang 2015-01-28  1000  	if (port->sysrq)
b7396a38fb28db Chunyan Zhang 2015-01-28  1001  		locked = 0;
b7396a38fb28db Chunyan Zhang 2015-01-28  1002  	else if (oops_in_progress)
b7396a38fb28db Chunyan Zhang 2015-01-28  1003  		locked = spin_trylock_irqsave(&port->lock, flags);
b7396a38fb28db Chunyan Zhang 2015-01-28  1004  	else
b7396a38fb28db Chunyan Zhang 2015-01-28  1005  		spin_lock_irqsave(&port->lock, flags);
b7396a38fb28db Chunyan Zhang 2015-01-28  1006  
b7396a38fb28db Chunyan Zhang 2015-01-28 @1007  	uart_console_write(port, s, count, sprd_console_putchar);
b7396a38fb28db Chunyan Zhang 2015-01-28  1008  
b7396a38fb28db Chunyan Zhang 2015-01-28  1009  	/* wait for transmitter to become empty */
b7396a38fb28db Chunyan Zhang 2015-01-28  1010  	wait_for_xmitr(port);
b7396a38fb28db Chunyan Zhang 2015-01-28  1011  
b7396a38fb28db Chunyan Zhang 2015-01-28  1012  	if (locked)
b7396a38fb28db Chunyan Zhang 2015-01-28  1013  		spin_unlock_irqrestore(&port->lock, flags);
b7396a38fb28db Chunyan Zhang 2015-01-28  1014  }
b7396a38fb28db Chunyan Zhang 2015-01-28  1015  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
