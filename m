Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C494C8057
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiCAB1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiCAB1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:27:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788BCF5;
        Mon, 28 Feb 2022 17:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646098003; x=1677634003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W0/EHxfz/6Tlchl0IZZvUXnUObXdh0ufI9V1QGUN19E=;
  b=RPcXNOszFI+ClTsZPv7FWhtTDCehO424FF/RxxNehn44VWz6Mz94jTgs
   te5MQUjra1CEJ2Rjxr66dUdpLPCp0po9dUni+Wu7xMWuRFWCTNgkqa0DY
   e4dvuXjJPArq75xwBrBTLDOZrS+z4LulXfSrUEejhwcDm7vyB26kLqPUK
   eB7DOCEp/1ZGYceSKRIu9sESfi9jB3TSilESC0gs3x1iia/Y5yaKKGEh3
   U3krI/UAzELv7Bzp+RhFrq01EstgOmnZijTfGewYiRy6FSI3IWZFUfOKi
   KVQ8/ya/x9hzWiN++5ubG/u8gSyau3rfkkE2e/1TDSznBUPUucYcDvtJs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253221374"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="253221374"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 17:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="492931197"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2022 17:26:40 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOrHj-0007yk-Fs; Tue, 01 Mar 2022 01:26:39 +0000
Date:   Tue, 1 Mar 2022 09:26:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzysztof.kozlowski@canonical.com,
        robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH 10/16] crypto: rockchip: rework by using crypto_engine
Message-ID: <202203010927.TpnG5TzB-lkp@intel.com>
References: <20220228194037.1600509-11-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228194037.1600509-11-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220301/202203010927.TpnG5TzB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7e5f8e4a5f09473643937e0ecff342bf336793fb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Corentin-Labbe/crypto-rockchip-permit-to-pass-self-tests/20220301-035430
        git checkout 7e5f8e4a5f09473643937e0ecff342bf336793fb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/crypto/rockchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/crypto/rockchip/rk3288_crypto_skcipher.c:11:
   drivers/crypto/rockchip/rk3288_crypto_skcipher.c: In function 'rk_cipher_run':
>> drivers/crypto/rockchip/rk3288_crypto_skcipher.c:383:40: warning: format '%x' expects argument of type 'unsigned int', but argument 12 has type 'long unsigned int' [-Wformat=]
     383 |                 dev_dbg(ctx->dev->dev, "LEN=%d/%d/%u ivsize=%d mode=%x n=%d BI=%d todo=%u way=%x\n",
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                             ^~~~~~~
   drivers/crypto/rockchip/rk3288_crypto_skcipher.c:383:17: note: in expansion of macro 'dev_dbg'
     383 |                 dev_dbg(ctx->dev->dev, "LEN=%d/%d/%u ivsize=%d mode=%x n=%d BI=%d todo=%u way=%x\n",
         |                 ^~~~~~~
   drivers/crypto/rockchip/rk3288_crypto_skcipher.c:383:96: note: format string is defined here
     383 |                 dev_dbg(ctx->dev->dev, "LEN=%d/%d/%u ivsize=%d mode=%x n=%d BI=%d todo=%u way=%x\n",
         |                                                                                               ~^
         |                                                                                                |
         |                                                                                                unsigned int
         |                                                                                               %lx
   drivers/crypto/rockchip/rk3288_crypto_skcipher.c: In function 'rk_ablk_exit_tfm':
   drivers/crypto/rockchip/rk3288_crypto_skcipher.c:474:31: warning: unused variable 'ctx' [-Wunused-variable]
     474 |         struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
         |                               ^~~


vim +383 drivers/crypto/rockchip/rk3288_crypto_skcipher.c

   311	
   312	static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
   313	{
   314		struct skcipher_request *areq = container_of(async_req, struct skcipher_request, base);
   315		struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
   316		struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
   317		struct rk_cipher_rctx *rctx = skcipher_request_ctx(areq);
   318		struct scatterlist *sgs, *sgd;
   319		int err = 0;
   320		int n = 0;
   321		int ivsize = crypto_skcipher_ivsize(tfm);
   322		int offset;
   323		u8 iv[AES_BLOCK_SIZE];
   324		u8 biv[AES_BLOCK_SIZE];
   325		u8 *ivtouse = areq->iv;
   326		unsigned int len = areq->cryptlen;
   327		unsigned int todo;
   328	
   329		ivsize = crypto_skcipher_ivsize(tfm);
   330		if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
   331			if (rctx->mode & RK_CRYPTO_DEC) {
   332				offset = areq->cryptlen - ivsize;
   333				scatterwalk_map_and_copy(rctx->backup_iv, areq->src,
   334							 offset, ivsize, 0);
   335			}
   336		}
   337	
   338		sgs = areq->src;
   339		sgd = areq->dst;
   340	
   341		while (sgs && sgd && len) {
   342			if (!sgs->length) {
   343				sgs = sg_next(sgs);
   344				sgd = sg_next(sgd);
   345				continue;
   346			}
   347			if (rctx->mode & RK_CRYPTO_DEC) {
   348				/* we backup last block of source to be used as IV at next step */
   349				offset = sgs->length - ivsize;
   350				scatterwalk_map_and_copy(biv, sgs, offset, ivsize, 0);
   351			}
   352			if (sgs == sgd) {
   353				err = dma_map_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
   354				if (err <= 0) {
   355					err = -EINVAL;
   356					goto theend_iv;
   357				}
   358			} else {
   359				err = dma_map_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
   360				if (err <= 0) {
   361					err = -EINVAL;
   362					goto theend_iv;
   363				}
   364				err = dma_map_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
   365				if (err <= 0) {
   366					err = -EINVAL;
   367					goto theend_sgs;
   368				}
   369			}
   370			err = 0;
   371			rk_ablk_hw_init(ctx->dev, areq);
   372			if (ivsize) {
   373				if (ivsize == DES_BLOCK_SIZE)
   374					memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_IV_0, ivtouse, ivsize);
   375				else
   376					memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_IV_0, ivtouse, ivsize);
   377			}
   378			reinit_completion(&ctx->dev->complete);
   379			ctx->dev->status = 0;
   380	
   381			todo = min(sg_dma_len(sgs), len);
   382			len -= todo;
 > 383			dev_dbg(ctx->dev->dev, "LEN=%d/%d/%u ivsize=%d mode=%x n=%d BI=%d todo=%u way=%x\n",
   384				sg_dma_len(sgs), sg_dma_len(sgd), areq->cryptlen,
   385				ivsize, rctx->mode, n, sgs == sgd,
   386				todo, rctx->mode & RK_CRYPTO_DEC);
   387			crypto_dma_start(ctx->dev, sgs, sgd, todo / 4);
   388			wait_for_completion_interruptible_timeout(&ctx->dev->complete,
   389								  msecs_to_jiffies(2000));
   390			if (!ctx->dev->status) {
   391				dev_err(ctx->dev->dev, "DMA timeout\n");
   392				err = -EFAULT;
   393				goto theend;
   394			}
   395			if (sgs == sgd) {
   396				dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
   397			} else {
   398				dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
   399				dma_unmap_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
   400			}
   401			if (rctx->mode & RK_CRYPTO_DEC) {
   402				memcpy(iv, biv, ivsize);
   403				ivtouse = iv;
   404			} else {
   405				offset = sgd->length - ivsize;
   406				scatterwalk_map_and_copy(iv, sgd, offset, ivsize, 0);
   407				ivtouse = iv;
   408			}
   409			sgs = sg_next(sgs);
   410			sgd = sg_next(sgd);
   411			n++;
   412		}
   413	
   414		if (areq->iv && ivsize > 0) {
   415			offset = areq->cryptlen - ivsize;
   416			if (rctx->mode & RK_CRYPTO_DEC) {
   417				memcpy(areq->iv, rctx->backup_iv, ivsize);
   418				memzero_explicit(rctx->backup_iv, ivsize);
   419			} else {
   420				scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
   421							 ivsize, 0);
   422			}
   423		}
   424	
   425	theend:
   426		local_bh_disable();
   427		crypto_finalize_skcipher_request(engine, areq, err);
   428		local_bh_enable();
   429		return 0;
   430	
   431	theend_sgs:
   432		if (sgs == sgd) {
   433			dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
   434		} else {
   435			dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
   436			dma_unmap_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
   437		}
   438	theend_iv:
   439		return err;
   440	}
   441	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
