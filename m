Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADD4D8E07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiCNUTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244620AbiCNUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:19:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A41D1D0C2;
        Mon, 14 Mar 2022 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647289115; x=1678825115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NAa8WzCFegUUAnaXqtDjfGBu7TYOp0KsT946yJHSmFU=;
  b=CV4ryyowrknaosVxwQ/UPqo7K2vWkY90VMJYyOozVoh55NogE9YCUeMP
   +Ubp3jEIc6zzG0vmBnf4qpscvKzGzJZ8CiZ/8TMpgtQrZm3GuQAbnF1QG
   ke0dVQorIYfducINiRrDXxG5oCx4MPoAfWQ0oKZrHw1wDdkSXMyj0TPBo
   TYNo1kVdSe7ke+2f6Zz3Hk3CN1N2XoXgg1hgEB868JC+BOqCdezY7Ocq5
   O9KNFLqy5FZOqaYVRC4nrGVRDIEh57VMHiWyo6MJ8iELsCtHuRZYYJRti
   A3zWWnKcgWftdgcG2hhBMTUsixoMA5h6RMnuu7sO2hVsWfxasKKUkfLvC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253699670"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="253699670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 13:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="512354795"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Mar 2022 13:18:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTr9C-000ACa-Kq; Mon, 14 Mar 2022 20:18:30 +0000
Date:   Tue, 15 Mar 2022 04:18:04 +0800
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
Message-ID: <202203150412.8mywn4YP-lkp@intel.com>
References: <20220314030937.22762-1-frank@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314030937.22762-1-frank@zago.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220315/202203150412.8mywn4YP-lkp@intel.com/config)
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

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x238): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x258): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_get':
>> gpio-stmpe.c:(.text.stmpe_gpio_get+0x44): undefined reference to `stmpe_reg_read'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_get_direction':
>> gpio-stmpe.c:(.text.stmpe_gpio_get_direction+0x48): undefined reference to `stmpe_reg_read'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_irq_sync_unlock':
>> gpio-stmpe.c:(.text.stmpe_gpio_irq_sync_unlock+0x98): undefined reference to `stmpe_reg_read'
>> mips-linux-ld: gpio-stmpe.c:(.text.stmpe_gpio_irq_sync_unlock+0xa8): undefined reference to `stmpe_reg_read'
>> mips-linux-ld: gpio-stmpe.c:(.text.stmpe_gpio_irq_sync_unlock+0x288): undefined reference to `stmpe_reg_write'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_irq':
>> gpio-stmpe.c:(.text.stmpe_gpio_irq+0xd4): undefined reference to `stmpe_block_read'
>> mips-linux-ld: gpio-stmpe.c:(.text.stmpe_gpio_irq+0x328): undefined reference to `stmpe_reg_write'
   mips-linux-ld: gpio-stmpe.c:(.text.stmpe_gpio_irq+0x35c): undefined reference to `stmpe_reg_write'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_disable':
>> gpio-stmpe.c:(.text.stmpe_gpio_disable+0x2c): undefined reference to `stmpe_disable'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_dbg_show_one':
>> gpio-stmpe.c:(.text.stmpe_dbg_show_one+0x90): undefined reference to `stmpe_reg_read'
>> mips-linux-ld: gpio-stmpe.c:(.text.stmpe_dbg_show_one+0x1b0): undefined reference to `stmpe_reg_read'
   mips-linux-ld: gpio-stmpe.c:(.text.stmpe_dbg_show_one+0x204): undefined reference to `stmpe_reg_read'
   mips-linux-ld: gpio-stmpe.c:(.text.stmpe_dbg_show_one+0x230): undefined reference to `stmpe_reg_read'
   mips-linux-ld: gpio-stmpe.c:(.text.stmpe_dbg_show_one+0x2b0): undefined reference to `stmpe_reg_read'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_set':
>> gpio-stmpe.c:(.text.stmpe_gpio_set+0x90): undefined reference to `stmpe_set_bits'
>> mips-linux-ld: gpio-stmpe.c:(.text.stmpe_gpio_set+0xb0): undefined reference to `stmpe_reg_write'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_direction_output':
>> gpio-stmpe.c:(.text.stmpe_gpio_direction_output+0x98): undefined reference to `stmpe_set_bits'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_direction_input':
>> gpio-stmpe.c:(.text.stmpe_gpio_direction_input+0x60): undefined reference to `stmpe_set_bits'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_request':
>> gpio-stmpe.c:(.text.stmpe_gpio_request+0xcc): undefined reference to `stmpe_set_altfunc'
   mips-linux-ld: drivers/gpio/gpio-stmpe.o: in function `stmpe_gpio_probe':
>> gpio-stmpe.c:(.text.stmpe_gpio_probe+0x1b8): undefined reference to `stmpe_enable'
>> mips-linux-ld: gpio-stmpe.c:(.text.stmpe_gpio_probe+0x218): undefined reference to `stmpe_disable'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_irq':
>> gpio-tc3589x.c:(.text.tc3589x_gpio_irq+0x6c): undefined reference to `tc3589x_block_read'
>> mips-linux-ld: gpio-tc3589x.c:(.text.tc3589x_gpio_irq+0x1c4): undefined reference to `tc3589x_reg_write'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_set_config':
>> gpio-tc3589x.c:(.text.tc3589x_gpio_set_config+0xe0): undefined reference to `tc3589x_set_bits'
   mips-linux-ld: gpio-tc3589x.c:(.text.tc3589x_gpio_set_config+0x114): undefined reference to `tc3589x_set_bits'
   mips-linux-ld: gpio-tc3589x.c:(.text.tc3589x_gpio_set_config+0x140): undefined reference to `tc3589x_set_bits'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_direction_input':
   gpio-tc3589x.c:(.text.tc3589x_gpio_direction_input+0x5c): undefined reference to `tc3589x_set_bits'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_irq_sync_unlock':
   gpio-tc3589x.c:(.text.tc3589x_gpio_irq_sync_unlock+0x138): undefined reference to `tc3589x_reg_write'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_set':
   gpio-tc3589x.c:(.text.tc3589x_gpio_set+0xa4): undefined reference to `tc3589x_block_write'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_direction_output':
   gpio-tc3589x.c:(.text.tc3589x_gpio_direction_output+0x7c): undefined reference to `tc3589x_set_bits'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_get':
   gpio-tc3589x.c:(.text.tc3589x_gpio_get+0x44): undefined reference to `tc3589x_reg_read'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_get_direction':
   gpio-tc3589x.c:(.text.tc3589x_gpio_get_direction+0x40): undefined reference to `tc3589x_reg_read'
   mips-linux-ld: drivers/gpio/gpio-tc3589x.o: in function `tc3589x_gpio_probe':
   gpio-tc3589x.c:(.text.tc3589x_gpio_probe+0x184): undefined reference to `tc3589x_set_bits'
   mips-linux-ld: gpio-tc3589x.c:(.text.tc3589x_gpio_probe+0x1b4): undefined reference to `tc3589x_reg_write'
   mips-linux-ld: drivers/gpio/gpio-wm831x.o: in function `wm831x_set_config':
   gpio-wm831x.c:(.text.wm831x_set_config+0xa0): undefined reference to `wm831x_set_bits'
   mips-linux-ld: gpio-wm831x.c:(.text.wm831x_set_config+0xbc): undefined reference to `wm831x_reg_read'
   mips-linux-ld: gpio-wm831x.c:(.text.wm831x_set_config+0x150): undefined reference to `wm831x_set_bits'
   mips-linux-ld: drivers/gpio/gpio-wm831x.o: in function `wm831x_gpio_direction_in':
   gpio-wm831x.c:(.text.wm831x_gpio_direction_in+0x88): undefined reference to `wm831x_set_bits'
   mips-linux-ld: drivers/gpio/gpio-wm831x.o: in function `wm831x_gpio_set':
   gpio-wm831x.c:(.text.wm831x_gpio_set+0xc4): undefined reference to `wm831x_set_bits'
   mips-linux-ld: drivers/gpio/gpio-wm831x.o: in function `wm831x_gpio_direction_out':
   gpio-wm831x.c:(.text.wm831x_gpio_direction_out+0x68): undefined reference to `wm831x_set_bits'
   mips-linux-ld: drivers/gpio/gpio-wm831x.o: in function `wm831x_gpio_get':
   gpio-wm831x.c:(.text.wm831x_gpio_get+0x38): undefined reference to `wm831x_reg_read'
   mips-linux-ld: drivers/gpio/gpio-wm831x.o: in function `wm831x_gpio_dbg_show':
   gpio-wm831x.c:(.text.wm831x_gpio_dbg_show+0x124): undefined reference to `wm831x_reg_read'
   mips-linux-ld: drivers/gpio/gpio-wm8350.o: in function `wm8350_gpio_direction_in':
   gpio-wm8350.c:(.text.wm8350_gpio_direction_in+0x94): undefined reference to `wm8350_set_bits'
   mips-linux-ld: drivers/gpio/gpio-wm8350.o: in function `wm8350_gpio_set':
   gpio-wm8350.c:(.text.wm8350_gpio_set+0xa8): undefined reference to `wm8350_set_bits'
   mips-linux-ld: gpio-wm8350.c:(.text.wm8350_gpio_set+0x10c): undefined reference to `wm8350_clear_bits'
   mips-linux-ld: drivers/gpio/gpio-wm8350.o: in function `wm8350_gpio_direction_out':
   gpio-wm8350.c:(.text.wm8350_gpio_direction_out+0x90): undefined reference to `wm8350_clear_bits'
   mips-linux-ld: drivers/gpio/gpio-wm8350.o: in function `wm8350_gpio_get':
   gpio-wm8350.c:(.text.wm8350_gpio_get+0x38): undefined reference to `wm8350_reg_read'
   mips-linux-ld: drivers/pwm/pwm-stmpe.o: in function `stmpe_pwm_probe':
   pwm-stmpe.c:(.init.text+0x174): undefined reference to `stmpe_enable'
   mips-linux-ld: pwm-stmpe.c:(.init.text+0x250): undefined reference to `stmpe_disable'
   mips-linux-ld: drivers/pwm/pwm-stmpe.o: in function `stmpe_24xx_pwm_disable':
   pwm-stmpe.c:(.text.stmpe_24xx_pwm_disable+0x38): undefined reference to `stmpe_reg_read'
   mips-linux-ld: pwm-stmpe.c:(.text.stmpe_24xx_pwm_disable+0xdc): undefined reference to `stmpe_reg_write'
   mips-linux-ld: drivers/pwm/pwm-stmpe.o: in function `stmpe_24xx_pwm_enable':
   pwm-stmpe.c:(.text.stmpe_24xx_pwm_enable+0x38): undefined reference to `stmpe_reg_read'
   mips-linux-ld: pwm-stmpe.c:(.text.stmpe_24xx_pwm_enable+0xd8): undefined reference to `stmpe_reg_write'
   mips-linux-ld: drivers/pwm/pwm-stmpe.o: in function `stmpe_24xx_pwm_config':
   pwm-stmpe.c:(.text.stmpe_24xx_pwm_config+0x15c): undefined reference to `stmpe_set_altfunc'
   mips-linux-ld: pwm-stmpe.c:(.text.stmpe_24xx_pwm_config+0x548): undefined reference to `stmpe_reg_write'
   mips-linux-ld: pwm-stmpe.c:(.text.stmpe_24xx_pwm_config+0x58c): undefined reference to `stmpe_reg_write'
   mips-linux-ld: drivers/video/backlight/88pm860x_bl.o: in function `pm860x_backlight_get_brightness':
   88pm860x_bl.c:(.text.pm860x_backlight_get_brightness+0x38): undefined reference to `pm860x_reg_read'
   mips-linux-ld: drivers/video/backlight/88pm860x_bl.o: in function `pm860x_backlight_set':
   88pm860x_bl.c:(.text.pm860x_backlight_set+0xb0): undefined reference to `pm8606_osc_enable'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0xcc): undefined reference to `pm8606_osc_enable'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0xe8): undefined reference to `pm8606_osc_enable'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x100): undefined reference to `pm860x_reg_write'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x1b8): undefined reference to `pm860x_set_bits'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x21c): undefined reference to `pm860x_set_bits'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x278): undefined reference to `pm860x_set_bits'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x2b4): undefined reference to `pm860x_set_bits'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x338): undefined reference to `pm8606_osc_disable'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x354): undefined reference to `pm8606_osc_disable'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x370): undefined reference to `pm8606_osc_disable'
   mips-linux-ld: 88pm860x_bl.c:(.text.pm860x_backlight_set+0x458): undefined reference to `pm860x_set_bits'
   mips-linux-ld: drivers/video/backlight/wm831x_bl.o: in function `wm831x_backlight_set':
   wm831x_bl.c:(.text.wm831x_backlight_set+0xbc): undefined reference to `wm831x_set_bits'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_set+0xf0): undefined reference to `wm831x_set_bits'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_set+0x12c): undefined reference to `wm831x_set_bits'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_set+0x160): undefined reference to `wm831x_set_bits'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_set+0x1c8): undefined reference to `wm831x_set_bits'
   mips-linux-ld: drivers/video/backlight/wm831x_bl.o:wm831x_bl.c:(.text.wm831x_backlight_set+0x204): more undefined references to `wm831x_set_bits' follow
   mips-linux-ld: drivers/video/backlight/wm831x_bl.o: in function `wm831x_backlight_probe':
   wm831x_bl.c:(.text.wm831x_backlight_probe+0x8c): undefined reference to `wm831x_isinkv_values'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_probe+0xb4): undefined reference to `wm831x_isinkv_values'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_probe+0x260): undefined reference to `wm831x_reg_unlock'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_probe+0x294): undefined reference to `wm831x_set_bits'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_probe+0x2a0): undefined reference to `wm831x_reg_lock'
   mips-linux-ld: wm831x_bl.c:(.text.wm831x_backlight_probe+0x394): undefined reference to `wm831x_set_bits'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_stop':
   sm501fb.c:(.text.sm501fb_stop+0x34): undefined reference to `sm501_unit_power'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_suspend':
   sm501fb.c:(.text.sm501fb_suspend+0x68): undefined reference to `sm501_unit_power'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_resume':
   sm501fb.c:(.text.sm501fb_resume+0x38): undefined reference to `sm501_unit_power'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_blank_crt':
   sm501fb.c:(.text.sm501fb_blank_crt+0x100): undefined reference to `sm501_misc_control'
   mips-linux-ld: sm501fb.c:(.text.sm501fb_blank_crt+0x138): undefined reference to `sm501_misc_control'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_set_par_common':
   sm501fb.c:(.text.sm501fb_set_par_common+0x2bc): undefined reference to `sm501_set_clock'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_set_par_crt':
   sm501fb.c:(.text.sm501fb_set_par_crt+0xa0): undefined reference to `sm501_misc_control'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_start':
   sm501fb.c:(.text.sm501fb_start+0x398): undefined reference to `sm501_unit_power'
   mips-linux-ld: sm501fb.c:(.text.sm501fb_start+0x3a8): undefined reference to `sm501_unit_power'
   mips-linux-ld: drivers/video/fbdev/sm501fb.o: in function `sm501fb_set_par_pnl':
   sm501fb.c:(.text.sm501fb_set_par_pnl+0x28c): undefined reference to `sm501_modify_reg'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
