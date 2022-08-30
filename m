Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3915A714F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiH3XBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiH3XAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:00:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43F9675D;
        Tue, 30 Aug 2022 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661900441; x=1693436441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u24qmCxu/nmcxL/d7ko8eIbijaFgPKTEjucw9W1Ntz0=;
  b=OYLR/1pJxRRuiN70byetv/jQlKVfyviU6k3Ff1U/RweAJITAWYH6j++1
   SL86kR1FKZpb0F6l2KGS2ta+0egMpqKzPD27CR6QwfIrp22ipzKmscLwE
   4d0lHWcojLAdbS3ZWcGT/2q6YezWFrbAm55UUmpS0J3W1qcXgQy997dlm
   ETkuMqo7BGvQxB3z08YlUndDGpjjEkA4nVqzM73wtnDtpgFwNq+bQ6IHK
   wasX++4zH2ClfZ8iDJRuhFb5+3bzr7zmUs2tHql74yS/zhhMnQkvAw4qR
   cIp9c0EW//A3VqmQp9NfgvNTiPxtZvSbFWL7TGFaB6vuu4TI3n+t5cTw1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381622037"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="381622037"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 16:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="715497511"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2022 16:00:36 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTADj-0000iJ-28;
        Tue, 30 Aug 2022 23:00:35 +0000
Date:   Wed, 31 Aug 2022 07:00:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, lukas@wunner.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's  quad-uart driver.
Message-ID: <202208310603.ea8ISalW-lkp@intel.com>
References: <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumaravel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumaravel-Thiagarajan/8250-microchip-pci1xxxx-Add-driver-for-the-pci1xxxx-s-quad-uart-function/20220831-020314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220831/202208310603.ea8ISalW-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a994946078a1bca8361d4f3245ad306515291b6e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kumaravel-Thiagarajan/8250-microchip-pci1xxxx-Add-driver-for-the-pci1xxxx-s-quad-uart-function/20220831-020314
        git checkout a994946078a1bca8361d4f3245ad306515291b6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_pci1xxxx.c: In function 'mchp_pci1xxxx_setup':
   drivers/tty/serial/8250/8250_pci1xxxx.c:293:32: error: assignment to 'void (*)(struct uart_port *, struct ktermios *, const struct ktermios *)' from incompatible pointer type 'void (*)(struct uart_port *, struct ktermios *, struct ktermios *)' [-Werror=incompatible-pointer-types]
     293 |         port->port.set_termios = mchp_pci1xxxx_set_termios;
         |                                ^
   drivers/tty/serial/8250/8250_pci1xxxx.c: At top level:
   drivers/tty/serial/8250/8250_pci1xxxx.c:305:6: warning: no previous prototype for 'mchp_pci1xxxx_irq_assign' [-Wmissing-prototypes]
     305 | void mchp_pci1xxxx_irq_assign(struct pci1xxxx_8250 *priv,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_pci1xxxx.c:475:6: warning: no previous prototype for 'pci1xxxx_port_resume' [-Wmissing-prototypes]
     475 | void pci1xxxx_port_resume(int line)
         |      ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pci1xxxx_port_resume +475 drivers/tty/serial/8250/8250_pci1xxxx.c

   474	
 > 475	void pci1xxxx_port_resume(int line)
   476	{
   477		struct uart_8250_port *up = serial8250_get_port(line);
   478		struct uart_port *port = &up->port;
   479		unsigned long flags;
   480	
   481		writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
   482	
   483		if (port->suspended == 0) {
   484			spin_lock_irqsave(&port->lock, flags);
   485			port->mctrl |= TIOCM_OUT2;
   486			port->ops->set_mctrl(port, port->mctrl);
   487			spin_unlock_irqrestore(&port->lock, flags);
   488		}
   489	}
   490	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
