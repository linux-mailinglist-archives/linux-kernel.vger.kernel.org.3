Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076A34F9D80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiDHTKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiDHTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:10:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1878FE423
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649444906; x=1680980906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=znhKL3Np2Txi+lNnuICW7jz1pW5PKDP4WnnE1v7Bjw4=;
  b=EKNH2mze9fEO2vo9Dq96ma8L8jfqdGAA5/YvWRpG3N3Ja06Cs+oeTVYd
   3C54/2JzDLqNvFBHEkrU+WoQRdGP0wPxRNP0N00RUQmd0bZkcMPplxIPb
   Nvfv7ud8KFWj0ZJdWDLvCua9pPVTtJws+wSJooWtaIjeyREKvmWj0CaO1
   bWCBdZCszARtlLBMfipKtGn8bvDa4MhJZ25xPUZhzlvrPeKXzts6CFLuv
   NuXNmm8paLZLM+KMuSeplR1UgIFilbNdb8JDCTlTMG6HHlAP9Uyiex3DY
   aWXoDTYPXdHKF9fu3n0+nAdrtqXigNMgSIORTRrjeuiqwIeC2OZ0KgZYN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="243801153"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="243801153"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="723496490"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2022 12:08:17 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nctxj-0000Yf-BA;
        Fri, 08 Apr 2022 19:08:03 +0000
Date:   Sat, 9 Apr 2022 03:07:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [l1k:smsc95xx_5.17 16/201] drivers/tty/serial/8250/8250_fsl.c:59:17:
 warning: Local variable 'flags' shadows outer variable [shadowVariable]
Message-ID: <202204090358.ACVmMjhI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 02cdb90be8f210b57f5068d5e73aeb71e74a9380 [16/201] serial: 8250: implement write_atomic
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 02cdb90be8f210b57f5068d5e73aeb71e74a9380
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/tty/serial/8250/8250_fsl.c:59:17: warning: Local variable 'flags' shadows outer variable [shadowVariable]
     unsigned long flags;
                   ^
   drivers/tty/serial/8250/8250_fsl.c:29:16: note: Shadowed declaration
    unsigned long flags;
                  ^
   drivers/tty/serial/8250/8250_fsl.c:59:17: note: Shadow variable
     unsigned long flags;
                   ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   drivers/tty/serial/serial_mctrl_gpio.h:102:70: warning: Parameter 'mctrl' can be declared with const [constParameter]
   unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
                                                                        ^
   drivers/tty/serial/serial_mctrl_gpio.h:108:65: warning: Parameter 'mctrl' can be declared with const [constParameter]
   mctrl_gpio_get_outputs(struct mctrl_gpios *gpios, unsigned int *mctrl)
                                                                   ^

vim +/flags +59 drivers/tty/serial/8250/8250_fsl.c

    25	
    26	int fsl8250_handle_irq(struct uart_port *port)
    27	{
    28		unsigned char lsr, orig_lsr;
    29		unsigned long flags;
    30		unsigned int iir;
    31		struct uart_8250_port *up = up_to_u8250p(port);
    32	
    33		spin_lock_irqsave(&up->port.lock, flags);
    34	
    35		iir = port->serial_in(port, UART_IIR);
    36		if (iir & UART_IIR_NO_INT) {
    37			spin_unlock(&up->port.lock);
    38			return 0;
    39		}
    40	
    41		/* This is the WAR; if last event was BRK, then read and return */
    42		if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
    43			up->lsr_saved_flags &= ~UART_LSR_BI;
    44			port->serial_in(port, UART_RX);
    45			spin_unlock(&up->port.lock);
    46			return 1;
    47		}
    48	
    49		lsr = orig_lsr = up->port.serial_in(&up->port, UART_LSR);
    50	
    51		/* Process incoming characters first */
    52		if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&
    53		    (up->ier & (UART_IER_RLSI | UART_IER_RDI))) {
    54			lsr = serial8250_rx_chars(up, lsr);
    55		}
    56	
    57		/* Stop processing interrupts on input overrun */
    58		if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
  > 59			unsigned long flags;
    60			unsigned long delay;
    61			bool is_console;
    62	
    63			is_console = uart_console(port);
    64	
    65			if (is_console)
    66				printk_cpu_sync_get_irqsave(flags);
    67			up->ier = port->serial_in(port, UART_IER);
    68			if (is_console)
    69				printk_cpu_sync_put_irqrestore(flags);
    70	
    71			if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
    72				port->ops->stop_rx(port);
    73			} else {
    74				/* Keep restarting the timer until
    75				 * the input overrun subsides.
    76				 */
    77				cancel_delayed_work(&up->overrun_backoff);
    78			}
    79	
    80			delay = msecs_to_jiffies(up->overrun_backoff_time_ms);
    81			schedule_delayed_work(&up->overrun_backoff, delay);
    82		}
    83	
    84		serial8250_modem_status(up);
    85	
    86		if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
    87			serial8250_tx_chars(up);
    88	
    89		up->lsr_saved_flags = orig_lsr;
    90	
    91		uart_unlock_and_check_sysrq_irqrestore(&up->port, flags);
    92	
    93		return 1;
    94	}
    95	EXPORT_SYMBOL_GPL(fsl8250_handle_irq);
    96	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
