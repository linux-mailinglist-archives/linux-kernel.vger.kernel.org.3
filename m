Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6DF4EFFAD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243719AbiDBIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiDBIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:25:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF14F460;
        Sat,  2 Apr 2022 01:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648887833; x=1680423833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gnc7Vq8A0AMWRP1SecSxWIcpYauRkoVdUdGm+VQNnk4=;
  b=IX/G6zEz1qzhXNMY22Xpsdpu2uU0a48uSYEQ3oELiDYmDqplvsdN2ib+
   UgOOimYRSItO9PRLZQLeOQGE9x5OTse6SKsvIJ+G6+UN+bkTMsq95kZDG
   MNSPk/IihmpNOMFo5csCeAy1rqbUL+I0CYDouBrORFzhTIgYqEez4jFAS
   KwV/mGnyqP00/k6zmVm/8yCtOuOrykdZufWTVs+O4nqyozQ+Ln4zISNAG
   eQRENExaXXJlSBUIwocO9O1bpmIpSGS149APlcp3qFkynHqXtJpcgF9nc
   JMaIaDxQtuNgIuydGWHYJwRCJBoCVOxwlpPgp5RJ2lkix2tgVrebzrldr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240225766"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="240225766"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 01:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="587101927"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Apr 2022 01:23:50 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naZ2z-00025L-9v;
        Sat, 02 Apr 2022 08:23:49 +0000
Date:   Sat, 2 Apr 2022 16:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzk+dt@kernel.org, robh+dt@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v4 10/33] crypto: rockchip: rework by using crypto_engine
Message-ID: <202204021634.IhyHrjoT-lkp@intel.com>
References: <20220401201804.2867154-11-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401201804.2867154-11-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20220331]
[also build test WARNING on v5.17]
[cannot apply to rockchip/for-next herbert-cryptodev-2.6/master herbert-crypto-2.6/master v5.17 v5.17-rc8 v5.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Corentin-Labbe/crypto-rockchip-permit-to-pass-self-tests/20220402-042221
base:    fdcbcd1348f4ef713668bae1b0fa9774e1811205
config: arm64-buildonly-randconfig-r001-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021634.IhyHrjoT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/be381eb03ba20a6e06f0e880a9929d14a1e13064
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Corentin-Labbe/crypto-rockchip-permit-to-pass-self-tests/20220402-042221
        git checkout be381eb03ba20a6e06f0e880a9929d14a1e13064
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/crypto/rockchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/crypto/rockchip/rk3288_crypto_skcipher.c:21:46: error: use of undeclared identifier 'tfm'
           unsigned int bs = crypto_skcipher_blocksize(tfm);
                                                       ^
>> drivers/crypto/rockchip/rk3288_crypto_skcipher.c:328:6: warning: variable 'n' set but not used [-Wunused-but-set-variable]
           int n = 0;
               ^
   1 warning and 1 error generated.


vim +/n +328 drivers/crypto/rockchip/rk3288_crypto_skcipher.c

   319	
   320	static int rk_cipher_run(struct crypto_engine *engine, void *async_req)
   321	{
   322		struct skcipher_request *areq = container_of(async_req, struct skcipher_request, base);
   323		struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
   324		struct rk_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
   325		struct rk_cipher_rctx *rctx = skcipher_request_ctx(areq);
   326		struct scatterlist *sgs, *sgd;
   327		int err = 0;
 > 328		int n = 0;
   329		int ivsize = crypto_skcipher_ivsize(tfm);
   330		int offset;
   331		u8 iv[AES_BLOCK_SIZE];
   332		u8 biv[AES_BLOCK_SIZE];
   333		u8 *ivtouse = areq->iv;
   334		unsigned int len = areq->cryptlen;
   335		unsigned int todo;
   336	
   337		ivsize = crypto_skcipher_ivsize(tfm);
   338		if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
   339			if (rctx->mode & RK_CRYPTO_DEC) {
   340				offset = areq->cryptlen - ivsize;
   341				scatterwalk_map_and_copy(rctx->backup_iv, areq->src,
   342							 offset, ivsize, 0);
   343			}
   344		}
   345	
   346		sgs = areq->src;
   347		sgd = areq->dst;
   348	
   349		while (sgs && sgd && len) {
   350			if (!sgs->length) {
   351				sgs = sg_next(sgs);
   352				sgd = sg_next(sgd);
   353				continue;
   354			}
   355			if (rctx->mode & RK_CRYPTO_DEC) {
   356				/* we backup last block of source to be used as IV at next step */
   357				offset = sgs->length - ivsize;
   358				scatterwalk_map_and_copy(biv, sgs, offset, ivsize, 0);
   359			}
   360			if (sgs == sgd) {
   361				err = dma_map_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
   362				if (err <= 0) {
   363					err = -EINVAL;
   364					goto theend_iv;
   365				}
   366			} else {
   367				err = dma_map_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
   368				if (err <= 0) {
   369					err = -EINVAL;
   370					goto theend_iv;
   371				}
   372				err = dma_map_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
   373				if (err <= 0) {
   374					err = -EINVAL;
   375					goto theend_sgs;
   376				}
   377			}
   378			err = 0;
   379			rk_ablk_hw_init(ctx->dev, areq);
   380			if (ivsize) {
   381				if (ivsize == DES_BLOCK_SIZE)
   382					memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_IV_0, ivtouse, ivsize);
   383				else
   384					memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_IV_0, ivtouse, ivsize);
   385			}
   386			reinit_completion(&ctx->dev->complete);
   387			ctx->dev->status = 0;
   388	
   389			todo = min(sg_dma_len(sgs), len);
   390			len -= todo;
   391			crypto_dma_start(ctx->dev, sgs, sgd, todo / 4);
   392			wait_for_completion_interruptible_timeout(&ctx->dev->complete,
   393								  msecs_to_jiffies(2000));
   394			if (!ctx->dev->status) {
   395				dev_err(ctx->dev->dev, "DMA timeout\n");
   396				err = -EFAULT;
   397				goto theend;
   398			}
   399			if (sgs == sgd) {
   400				dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
   401			} else {
   402				dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
   403				dma_unmap_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
   404			}
   405			if (rctx->mode & RK_CRYPTO_DEC) {
   406				memcpy(iv, biv, ivsize);
   407				ivtouse = iv;
   408			} else {
   409				offset = sgd->length - ivsize;
   410				scatterwalk_map_and_copy(iv, sgd, offset, ivsize, 0);
   411				ivtouse = iv;
   412			}
   413			sgs = sg_next(sgs);
   414			sgd = sg_next(sgd);
   415			n++;
   416		}
   417	
   418		if (areq->iv && ivsize > 0) {
   419			offset = areq->cryptlen - ivsize;
   420			if (rctx->mode & RK_CRYPTO_DEC) {
   421				memcpy(areq->iv, rctx->backup_iv, ivsize);
   422				memzero_explicit(rctx->backup_iv, ivsize);
   423			} else {
   424				scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
   425							 ivsize, 0);
   426			}
   427		}
   428	
   429	theend:
   430		local_bh_disable();
   431		crypto_finalize_skcipher_request(engine, areq, err);
   432		local_bh_enable();
   433		return 0;
   434	
   435	theend_sgs:
   436		if (sgs == sgd) {
   437			dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_BIDIRECTIONAL);
   438		} else {
   439			dma_unmap_sg(ctx->dev->dev, sgs, 1, DMA_TO_DEVICE);
   440			dma_unmap_sg(ctx->dev->dev, sgd, 1, DMA_FROM_DEVICE);
   441		}
   442	theend_iv:
   443		return err;
   444	}
   445	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
