Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00D5395C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbiEaR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346765AbiEaR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:59:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0EF8AE62;
        Tue, 31 May 2022 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654019963; x=1685555963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b6mwshQJi0+lvKDxPFp5xJiYo27cGUYqQ874eJ6J3JA=;
  b=KJq+hDlCO1ErmqqM7W9sgA/oSl7Fz98cUVF7U4WEeMbxJwDh/sfzJKPF
   CYlJELH1bnGIfQRWey+bfl5CJ6zAl3B+3r2j6j/Zm/vksQEQt0iD+EH+9
   cwFwsPtV2DFchWCij2rEkPEYTMNl0ne0fHryXpCYrKIezDeWmKYbKeRJu
   nftB2dSYxkJ7zQq02X7sUVmQA1kv/5GRKT/CIHAZhWHAwRfSKaI+zkijE
   ELP0H0YRZtlWEDCBj5P33ovF+39LreZTNgtd+BcvtQo6C2glix4wNI39y
   K+WGBFwNJAZDkEy3biB/k8QkIrwUrh1e74yoErKzFjr+KTiTd/fSZsIO2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255208930"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="255208930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="605802463"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 May 2022 10:59:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw69H-0002w6-VR;
        Tue, 31 May 2022 17:59:19 +0000
Date:   Wed, 1 Jun 2022 01:58:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH 4/4] serial: max310x: implement I2C support
Message-ID: <202206010102.px37QPmH-lkp@intel.com>
References: <20220530221429.1248083-4-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530221429.1248083-4-demonsingur@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cosmin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on usb/usb-testing v5.18 next-20220531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmin-Tanislav/serial-max310x-use-regmap-methods-for-SPI-batch-operations/20220531-061619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220601/202206010102.px37QPmH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/6c293b95fc5654df5353ba273a9bbd08f1cd3f3a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cosmin-Tanislav/serial-max310x-use-regmap-methods-for-SPI-batch-operations/20220531-061619
        git checkout 6c293b95fc5654df5353ba273a9bbd08f1cd3f3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/max310x.c:1658:1: warning: unused label 'err_i2c_register' [-Wunused-label]
   err_i2c_register:
   ^~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/err_i2c_register +1658 drivers/tty/serial/max310x.c

  1652	
  1653		return 0;
  1654	
  1655	err_spi_register:
  1656		spi_unregister_driver(&max310x_spi_driver);
  1657	
> 1658	err_i2c_register:
  1659		uart_unregister_driver(&max310x_uart);
  1660	
  1661		return ret;
  1662	}
  1663	module_init(max310x_uart_init);
  1664	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
