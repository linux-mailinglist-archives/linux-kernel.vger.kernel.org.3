Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B858356CFF5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiGJQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:08:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902A5F7D;
        Sun, 10 Jul 2022 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657469302; x=1689005302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2rFHyjk0IO1Axsj1F5yVAJwDZ/wJ5mGUuZgurI+KIg=;
  b=buQ8/caL7jTGu4FjzP0NkIza9BlrMtN0FJWhqCASxD+RVGChK40/u48x
   5qC9WxLasQQngqea7CuqRy6wpd5bKmG3mJOyAW5BsJ0khfHKGORhqUDhY
   rCPQqdw45UieT2dAOEHHsFIwTtJ+9iCA0dHD3s2xsDHsINRp99ND3FM2i
   rH7GHyp6MHedaLrZNlN+oOm0WuVppf/Dy8rYSsewXRfN7BDA3PXAs166N
   cywqFAexndrKjse6Cdm1KQbD/I97Sih3JsMsdZoDZlIkHOrQQMSOjEQNz
   bFShTJyaZqHtzW/t06G+xPlT7qsLqYe9KVU89OaYCVyl9Y50vIBztAkMg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282073003"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="282073003"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 09:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="662291019"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2022 09:08:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAZTl-000Pzi-Cs;
        Sun, 10 Jul 2022 16:08:17 +0000
Date:   Mon, 11 Jul 2022 00:07:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v3 3/8] serial: core, 8250: set RS485 termination gpio in
 serial core
Message-ID: <202207102355.Y27cvu6y-lkp@intel.com>
References: <20220710150322.2846170-4-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710150322.2846170-4-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lino,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 7e5b4322cde067e1d0f1bf8f490e93f664a7c843]

url:    https://github.com/intel-lab-lkp/linux/commits/Lino-Sanfilippo/Fixes-and-cleanup-for-RS485/20220710-230624
base:   7e5b4322cde067e1d0f1bf8f490e93f664a7c843
config: hexagon-randconfig-r041-20220710 (https://download.01.org/0day-ci/archive/20220710/202207102355.Y27cvu6y-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6ce63e267aab79ca87bf63453d34dd3909ab978d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/846f02e6da9692810ed632dd72f45af667c3cc67
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lino-Sanfilippo/Fixes-and-cleanup-for-RS485/20220710-230624
        git checkout 846f02e6da9692810ed632dd72f45af667c3cc67
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/serial_core.c:1364:6: warning: logical not is only applied to the left hand side of this bitwise operator [-Wlogical-not-parentheses]
           if (!rs485->flags & SER_RS485_ENABLED)
               ^             ~
   drivers/tty/serial/serial_core.c:1364:6: note: add parentheses after the '!' to evaluate the bitwise operator first
           if (!rs485->flags & SER_RS485_ENABLED)
               ^
                (                               )
   drivers/tty/serial/serial_core.c:1364:6: note: add parentheses around left hand side expression to silence this warning
           if (!rs485->flags & SER_RS485_ENABLED)
               ^
               (            )
   1 warning generated.


vim +1364 drivers/tty/serial/serial_core.c

  1360	
  1361	static void uart_set_rs485_termination(struct uart_port *port,
  1362					       const struct serial_rs485 *rs485)
  1363	{
> 1364		if (!rs485->flags & SER_RS485_ENABLED)
  1365			return;
  1366	
  1367		gpiod_set_value_cansleep(port->rs485_term_gpio,
  1368					 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
  1369	}
  1370	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
