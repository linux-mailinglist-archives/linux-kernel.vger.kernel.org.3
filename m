Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C32E4DA2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351176AbiCOSyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351164AbiCOSyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:54:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C52DD7B;
        Tue, 15 Mar 2022 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647370420; x=1678906420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m3cKAwOJqOsA7eAOkUV4eguAJkZnzQNcLpMZ96NtvPk=;
  b=XMx5IBbe+W1MRVCJJN1smoN4sp/VP69GmCt/jPRTIYUAWzT7j1/Qmfyc
   INiuPNHIrwp8MHzCuqi4njGQHQhmHcOsV6b9i2boaykQiybgpB4RdKTvA
   JgcTK1ts34W5skmYrHJxjNC/Zng5qLfuBz0x00jWPDtP296ZClL5qHxEd
   0ga4xZg9Fpv8iyvMSwaxEmodhA1pN1mTr6++3oNyd7Ma6yxWGBKXJCc42
   02IDIWHNML7tnoiNIAl6SY2kA+u41f7aVtYEs+yaoC3keBZaIsFFE5uNX
   4hJUKdNuCJJbgL7aGxq1VhYXOAtXUWP0SUzGdwzgC9ZgaJqYEsvpKuL+i
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319620075"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="319620075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 11:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="690312679"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2022 11:53:37 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUCIa-000BNG-Gw; Tue, 15 Mar 2022 18:53:36 +0000
Date:   Wed, 16 Mar 2022 02:52:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, krisman@collabora.com,
        andy.shevchenko@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: [PATCH v2] gpio: Restrict usage of gc irq members before
 initialization
Message-ID: <202203160247.JiwK1pqP-lkp@intel.com>
References: <20220315103813.84407-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315103813.84407-1-shreeya.patel@collabora.com>
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

Hi Shreeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linusw-gpio/for-next]
[also build test ERROR on v5.17-rc8 next-20220315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shreeya-Patel/gpio-Restrict-usage-of-gc-irq-members-before-initialization/20220315-183950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
config: arm-palmz72_defconfig (https://download.01.org/0day-ci/archive/20220316/202203160247.JiwK1pqP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/9f566a088a6f5fcb8830b07020294835072d516c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shreeya-Patel/gpio-Restrict-usage-of-gc-irq-members-before-initialization/20220315-183950
        git checkout 9f566a088a6f5fcb8830b07020294835072d516c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpio/gpiolib.c:3068:24: error: no member named 'irq' in 'struct gpio_chip'
           if (gc->to_irq && gc->irq.gc_irq_initialized) {
                             ~~  ^
   1 error generated.


vim +3068 drivers/gpio/gpiolib.c

  3045	
  3046	/**
  3047	 * gpiod_to_irq() - return the IRQ corresponding to a GPIO
  3048	 * @desc: gpio whose IRQ will be returned (already requested)
  3049	 *
  3050	 * Return the IRQ corresponding to the passed GPIO, or an error code in case of
  3051	 * error.
  3052	 */
  3053	int gpiod_to_irq(const struct gpio_desc *desc)
  3054	{
  3055		struct gpio_chip *gc;
  3056		int offset;
  3057	
  3058		/*
  3059		 * Cannot VALIDATE_DESC() here as gpiod_to_irq() consumer semantics
  3060		 * requires this function to not return zero on an invalid descriptor
  3061		 * but rather a negative error number.
  3062		 */
  3063		if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip)
  3064			return -EINVAL;
  3065	
  3066		gc = desc->gdev->chip;
  3067		offset = gpio_chip_hwgpio(desc);
> 3068		if (gc->to_irq && gc->irq.gc_irq_initialized) {
  3069			int retirq = gc->to_irq(gc, offset);
  3070	
  3071			/* Zero means NO_IRQ */
  3072			if (!retirq)
  3073				return -ENXIO;
  3074	
  3075			return retirq;
  3076		}
  3077		return -ENXIO;
  3078	}
  3079	EXPORT_SYMBOL_GPL(gpiod_to_irq);
  3080	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
