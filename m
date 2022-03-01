Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C84C8230
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiCAEUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiCAEUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:20:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED02CCAE;
        Mon, 28 Feb 2022 20:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108390; x=1677644390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OdBHJiSxsaP3KdGJd9Gtst2fhK8G33ye+cSYy98JHtg=;
  b=FTRnGuspVaff1/27JEGaz5kLs6nd/lo8UpraEEX1pSHqZz8Tk7UhOcSp
   IFe4fTHfEwgmz6QqedC+/ESc6yg0a3eni4J+mKU0uRMdbSFRnt+eF43FC
   95RlqQVQQ/M9ww/ubbSIalG0Ri1A1DBgD7nw0VmNqG180v9bWKzTj3fl6
   WIDmotdT+gdQZwsj1ykTjjmcU8LtmRGhU1xKwwwxabLaO3eufPcRHrswU
   aV523qGH9n2wesadP0QP2DBlW2u5X1xIKx51yoERLHP46AfqG8XZeUNZj
   MAWKcNF7O00oxh3vM8whLRygoKYKjxdEThqZP9V8zTsCy7XaYfGciiRSa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233669497"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="233669497"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:19:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="593466286"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Feb 2022 20:19:47 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOtzG-00086a-M5; Tue, 01 Mar 2022 04:19:46 +0000
Date:   Tue, 1 Mar 2022 12:18:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzysztof.kozlowski@canonical.com,
        robh+dt@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH 13/16] crypto: rockchip: rewrite type
Message-ID: <202203011017.qqb0tTar-lkp@intel.com>
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
config: arm64-randconfig-r006-20220228 (https://download.01.org/0day-ci/archive/20220301/202203011017.qqb0tTar-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/03fb353165f76dc7c5ed7c27401537552070406b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Corentin-Labbe/crypto-rockchip-permit-to-pass-self-tests/20220301-035430
        git checkout 03fb353165f76dc7c5ed7c27401537552070406b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/crypto/rockchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/crypto/rockchip/rk3288_crypto.c:101:6: warning: data argument not used by format string [-Wformat-extra-args]
                                    rk_cipher_algs[i]->alg.skcipher.base.cra_driver_name);
                                    ^
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^
   1 warning generated.


vim +101 drivers/crypto/rockchip/rk3288_crypto.c

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
    99				dev_info(crypto_info->dev, "Register %s as\n",
   100					 rk_cipher_algs[i]->alg.skcipher.base.cra_name,
 > 101					 rk_cipher_algs[i]->alg.skcipher.base.cra_driver_name);
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
