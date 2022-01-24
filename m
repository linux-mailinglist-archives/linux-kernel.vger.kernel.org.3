Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0594F4984AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbiAXQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:25:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:21201 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241078AbiAXQZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643041513; x=1674577513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r+zZ2dRQMqn/zhn532Bp1lCp8yNVug+JyWdiOLLqqHE=;
  b=ky6KA3GMNCT9KsCqBWNJ/S9WjbNTFGPnBRcpzIRRANLCqSBFcjw8hlh3
   sKH/TPFH7wolg51IlomwFoHpM5ctDJ+liJMuPNY2muZPFTsiULC5tBen+
   2k20j9rp4J/fgmZWGYZhFxAlmdPXqvD+JJ7jsRHLHHaD/pV1Ym2xUNJbo
   jU+B5XShhSIzNCDPqNWkduNzlb+2gTYtkJWnkqAWrqDMsEo1M+l0TTmqM
   ZK2x9sjwn2U63efuhXjt9opa8BBg4v8MF8uyx7z5A+SRa+V3jhkUaOJCs
   YRH789/ZNadmkeSBVYM/SQfPXwsyujLo+OreYqdqPKx6CUGDEATTwNbm8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243681574"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243681574"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:24:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596833173"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 08:24:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC29G-000IbC-Kj; Mon, 24 Jan 2022 16:24:54 +0000
Date:   Tue, 25 Jan 2022 00:23:52 +0800
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
Message-ID: <202201250004.SHBbOjs3-lkp@intel.com>
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
config: arc-randconfig-r043-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250004.SHBbOjs3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/45520d4f6db241db0b77f41162adba4a9977956c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiri-Slaby/TTY-patches-for-5-18/20220124-151758
        git checkout 45520d4f6db241db0b77f41162adba4a9977956c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/omap-serial.c: In function 'serial_omap_console_write':
>> drivers/tty/serial/omap-serial.c:1272:49: error: passing argument 4 of 'uart_console_write' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1272 |         uart_console_write(&up->port, s, count, serial_omap_console_putchar);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 void (*)(struct uart_port *, int)
   In file included from drivers/tty/serial/omap-serial.c:30:
   include/linux/serial_core.h:402:32: note: expected 'void (*)(struct uart_port *, char)' but argument is of type 'void (*)(struct uart_port *, int)'
     402 |                         void (*putchar)(struct uart_port *, char));
         |                         ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/uart_console_write +1272 drivers/tty/serial/omap-serial.c

b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1248  
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1249  static void
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1250  serial_omap_console_write(struct console *co, const char *s,
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1251  		unsigned int count)
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1252  {
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1253  	struct uart_omap_port *up = serial_omap_console_ports[co->index];
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1254  	unsigned long flags;
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1255  	unsigned int ier;
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1256  	int locked = 1;
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1257  
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1258  	local_irq_save(flags);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1259  	if (up->port.sysrq)
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1260  		locked = 0;
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1261  	else if (oops_in_progress)
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1262  		locked = spin_trylock(&up->port.lock);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1263  	else
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1264  		spin_lock(&up->port.lock);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1265  
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1266  	/*
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1267  	 * First save the IER then disable the interrupts
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1268  	 */
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1269  	ier = serial_in(up, UART_IER);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1270  	serial_out(up, UART_IER, 0);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1271  
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27 @1272  	uart_console_write(&up->port, s, count, serial_omap_console_putchar);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1273  
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1274  	/*
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1275  	 * Finally, wait for transmitter to become empty
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1276  	 * and restore the IER
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1277  	 */
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1278  	wait_for_xmitr(up);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1279  	serial_out(up, UART_IER, ier);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1280  	/*
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1281  	 * The receive handling will happen properly because the
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1282  	 * receive ready bit will still be set; it is not cleared
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1283  	 * on read.  However, modem control will not, we must
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1284  	 * call it if we have saved something in the saved flags
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1285  	 * while processing with interrupts off.
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1286  	 */
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1287  	if (up->msr_saved_flags)
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1288  		check_modem_status(up);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1289  
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1290  	if (locked)
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1291  		spin_unlock(&up->port.lock);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1292  	local_irq_restore(flags);
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1293  }
b612633b592807 drivers/serial/omap-serial.c Govindraj.R 2010-09-27  1294  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
