Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179284C822F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiCAEU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiCAEUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:20:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595972D1C6;
        Mon, 28 Feb 2022 20:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108390; x=1677644390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vYBNAlp/fbezUdL30BdHV5afm3jG+W6zRpPec4mqI+U=;
  b=TARKmK+C8wGtIfcetHoJKdtgw14lUmyVMDkQJU2MS5ak0oSokFQolWPi
   5CtpbztLORW3iIIWDiMZX+0INpfg/xXG8jLN0myavmAdJtrMHT3CugE/w
   RP64R/rRT9q8zeTXtHN4NEWyqee4UXbjJnLnpNGe76TLw2dvGD6mRgzbg
   z88cjT8BhHW+ryrpD8HA60/3/1UqFH5twT8uE9AeoIb02LnkDxO99yVfu
   5k0JE73Ck+c++Gl21XV+fCnMZxiqWZLi+ptspq1675PJnDOoxGTK0dlfq
   r93/9yCcT0nGqE4a7axImOCEUSdLUHLIczLWCYi6yAW+hu5gg6sdztpzC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251883872"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251883872"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:19:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="608682706"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2022 20:19:47 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOtzG-00086Y-LT; Tue, 01 Mar 2022 04:19:46 +0000
Date:   Tue, 1 Mar 2022 12:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzysztof.kozlowski@canonical.com,
        robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH 13/16] crypto: rockchip: rewrite type
Message-ID: <202203011055.8Y6mA9xW-lkp@intel.com>
References: <20220228194037.1600509-14-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228194037.1600509-14-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on herbert-cryptodev-2.6/master herbert-crypto-2.6/master v5.17-rc6 next-20220228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Corentin-Labbe/crypto-rockchip-permit-to-pass-self-tests/20220301-035430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220301/202203011055.8Y6mA9xW-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/03fb353165f76dc7c5ed7c27401537552070406b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Corentin-Labbe/crypto-rockchip-permit-to-pass-self-tests/20220301-035430
        git checkout 03fb353165f76dc7c5ed7c27401537552070406b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/crypto/rockchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/crypto/rockchip/rk3288_crypto.h:8,
                    from drivers/crypto/rockchip/rk3288_crypto.c:12:
   drivers/crypto/rockchip/rk3288_crypto.c: In function 'rk_crypto_register':
>> drivers/crypto/rockchip/rk3288_crypto.c:99:52: warning: too many arguments for format [-Wformat-extra-args]
      99 |                         dev_info(crypto_info->dev, "Register %s as\n",
         |                                                    ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/crypto/rockchip/rk3288_crypto.c:99:25: note: in expansion of macro 'dev_info'
      99 |                         dev_info(crypto_info->dev, "Register %s as\n",
         |                         ^~~~~~~~


vim +99 drivers/crypto/rockchip/rk3288_crypto.c

  > 12	#include "rk3288_crypto.h"
    13	#include <linux/dma-mapping.h>
    14	#include <linux/module.h>
    15	#include <linux/platform_device.h>
    16	#include <linux/of.h>
    17	#include <linux/clk.h>
    18	#include <linux/crypto.h>
    19	#include <linux/reset.h>
    20	
    21	static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
    22	{
    23		int err;
    24	
    25		err = clk_prepare_enable(dev->sclk);
    26		if (err) {
    27			dev_err(dev->dev, "[%s:%d], Couldn't enable clock sclk\n",
    28				__func__, __LINE__);
    29			goto err_return;
    30		}
    31		err = clk_prepare_enable(dev->aclk);
    32		if (err) {
    33			dev_err(dev->dev, "[%s:%d], Couldn't enable clock aclk\n",
    34				__func__, __LINE__);
    35			goto err_aclk;
    36		}
    37		err = clk_prepare_enable(dev->hclk);
    38		if (err) {
    39			dev_err(dev->dev, "[%s:%d], Couldn't enable clock hclk\n",
    40				__func__, __LINE__);
    41			goto err_hclk;
    42		}
    43	
    44		return err;
    45	err_hclk:
    46		clk_disable_unprepare(dev->aclk);
    47	err_aclk:
    48		clk_disable_unprepare(dev->sclk);
    49	err_return:
    50		return err;
    51	}
    52	
    53	static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
    54	{
    55		clk_disable_unprepare(dev->hclk);
    56		clk_disable_unprepare(dev->aclk);
    57		clk_disable_unprepare(dev->sclk);
    58	}
    59	
    60	static irqreturn_t rk_crypto_irq_handle(int irq, void *dev_id)
    61	{
    62		struct rk_crypto_info *dev  = platform_get_drvdata(dev_id);
    63		u32 interrupt_status;
    64	
    65		interrupt_status = CRYPTO_READ(dev, RK_CRYPTO_INTSTS);
    66		CRYPTO_WRITE(dev, RK_CRYPTO_INTSTS, interrupt_status);
    67	
    68		dev->status = 1;
    69		if (interrupt_status & 0x0a) {
    70			dev_warn(dev->dev, "DMA Error\n");
    71			dev->status = 0;
    72		}
    73		complete(&dev->complete);
    74	
    75		return IRQ_HANDLED;
    76	}
    77	
    78	static struct rk_crypto_tmp *rk_cipher_algs[] = {
    79		&rk_ecb_aes_alg,
    80		&rk_cbc_aes_alg,
    81		&rk_ecb_des_alg,
    82		&rk_cbc_des_alg,
    83		&rk_ecb_des3_ede_alg,
    84		&rk_cbc_des3_ede_alg,
    85		&rk_ahash_sha1,
    86		&rk_ahash_sha256,
    87		&rk_ahash_md5,
    88	};
    89	
    90	static int rk_crypto_register(struct rk_crypto_info *crypto_info)
    91	{
    92		unsigned int i, k;
    93		int err = 0;
    94	
    95		for (i = 0; i < ARRAY_SIZE(rk_cipher_algs); i++) {
    96			rk_cipher_algs[i]->dev = crypto_info;
    97			switch (rk_cipher_algs[i]->type) {
    98			case CRYPTO_ALG_TYPE_SKCIPHER:
  > 99				dev_info(crypto_info->dev, "Register %s as\n",
   100					 rk_cipher_algs[i]->alg.skcipher.base.cra_name,
   101					 rk_cipher_algs[i]->alg.skcipher.base.cra_driver_name);
   102				err = crypto_register_skcipher(&rk_cipher_algs[i]->alg.skcipher);
   103				break;
   104			case CRYPTO_ALG_TYPE_AHASH:
   105				dev_info(crypto_info->dev, "Register %s as %s\n",
   106					 rk_cipher_algs[i]->alg.hash.halg.base.cra_name,
   107					 rk_cipher_algs[i]->alg.hash.halg.base.cra_driver_name);
   108				err = crypto_register_ahash(&rk_cipher_algs[i]->alg.hash);
   109				break;
   110			default:
   111				dev_err(crypto_info->dev, "unknown algorithm\n");
   112			}
   113			if (err)
   114				goto err_cipher_algs;
   115		}
   116		return 0;
   117	
   118	err_cipher_algs:
   119		for (k = 0; k < i; k++) {
   120			if (rk_cipher_algs[i]->type == CRYPTO_ALG_TYPE_SKCIPHER)
   121				crypto_unregister_skcipher(&rk_cipher_algs[k]->alg.skcipher);
   122			else
   123				crypto_unregister_ahash(&rk_cipher_algs[i]->alg.hash);
   124		}
   125		return err;
   126	}
   127	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
