Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48849D992
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 05:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiA0ERs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 23:17:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:39099 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbiA0ERr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 23:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643257067; x=1674793067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Azjd8x6g9/a16YpaGEdSzffzRXf3wRzqIxBh/or1f/I=;
  b=brmFHkGCiiwXkV+DNh+vOX3SxzvrB8GPQFmmYWMPORxDTEFenP2/xIUA
   VtZeenKDLeVr/2Cwpk3Qpbk8KxbujaF1X9L1S43/C+egTpvSZeBajoKTu
   wjHvC4yNRB41YHwhKoBMyGSoGeg8+AHW91R9YQ+Aw9ZKO90cUUtRUPW1h
   SyYiyvrXFJybFETwBhoaUmLMCiCBKUNW0G3htpM6XgJPIHiwFWsD4qN1A
   B4bgZNDE+Epv7kXLFY3khIgwDb3URrGRIgAN/Z/IbUTGU3Tik4ZftGDkG
   dN34XjQsn8FIE9tm59wjD8jNmtwiVf5UnrPn5RUNWAInkp+t2MAfA5o7/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245582595"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="245582595"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 20:17:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="581338482"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2022 20:17:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCwE7-000M5q-Vw; Thu, 27 Jan 2022 04:17:39 +0000
Date:   Thu, 27 Jan 2022 12:17:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        mripard@kernel.org, wens@csie.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/8] crypto: sun8i-ce: do not allocate memory when
 handling requests
Message-ID: <202201271243.hLjdr8IB-lkp@intel.com>
References: <20220126210441.3661782-2-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126210441.3661782-2-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on sunxi/sunxi/for-next]
[also build test WARNING on herbert-cryptodev-2.6/master herbert-crypto-2.6/master v5.17-rc1 next-20220125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Corentin-Labbe/crypto-allwinner-various-improvments/20220127-050556
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220127/202201271243.hLjdr8IB-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/d0b880af8c99abcd0f36463b82c92d71024408de
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Corentin-Labbe/crypto-allwinner-various-improvments/20220127-050556
        git checkout d0b880af8c99abcd0f36463b82c92d71024408de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/crypto/allwinner/sun8i-ce/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c:258:1: warning: unused label 'theend_key' [-Wunused-label]
   theend_key:
   ^~~~~~~~~~~
   1 warning generated.


vim +/theend_key +258 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c

06f751b613296cc Corentin Labbe 2019-10-23  108  
06f751b613296cc Corentin Labbe 2019-10-23  109  	flow = rctx->flow;
06f751b613296cc Corentin Labbe 2019-10-23  110  
06f751b613296cc Corentin Labbe 2019-10-23  111  	chan = &ce->chanlist[flow];
06f751b613296cc Corentin Labbe 2019-10-23  112  
06f751b613296cc Corentin Labbe 2019-10-23  113  	cet = chan->tl;
06f751b613296cc Corentin Labbe 2019-10-23  114  	memset(cet, 0, sizeof(struct ce_task));
06f751b613296cc Corentin Labbe 2019-10-23  115  
93c7f4d357de68f Corentin Labbe 2019-11-17  116  	cet->t_id = cpu_to_le32(flow);
93c7f4d357de68f Corentin Labbe 2019-11-17  117  	common = ce->variant->alg_cipher[algt->ce_algo_id];
93c7f4d357de68f Corentin Labbe 2019-11-17  118  	common |= rctx->op_dir | CE_COMM_INT;
93c7f4d357de68f Corentin Labbe 2019-11-17  119  	cet->t_common_ctl = cpu_to_le32(common);
06f751b613296cc Corentin Labbe 2019-10-23  120  	/* CTS and recent CE (H6) need length in bytes, in word otherwise */
6b4f76c2cd9e6c3 Corentin Labbe 2020-09-18  121  	if (ce->variant->cipher_t_dlen_in_bytes)
93c7f4d357de68f Corentin Labbe 2019-11-17  122  		cet->t_dlen = cpu_to_le32(areq->cryptlen);
93c7f4d357de68f Corentin Labbe 2019-11-17  123  	else
93c7f4d357de68f Corentin Labbe 2019-11-17  124  		cet->t_dlen = cpu_to_le32(areq->cryptlen / 4);
06f751b613296cc Corentin Labbe 2019-10-23  125  
93c7f4d357de68f Corentin Labbe 2019-11-17  126  	sym = ce->variant->op_mode[algt->ce_blockmode];
06f751b613296cc Corentin Labbe 2019-10-23  127  	len = op->keylen;
06f751b613296cc Corentin Labbe 2019-10-23  128  	switch (len) {
06f751b613296cc Corentin Labbe 2019-10-23  129  	case 128 / 8:
93c7f4d357de68f Corentin Labbe 2019-11-17  130  		sym |= CE_AES_128BITS;
06f751b613296cc Corentin Labbe 2019-10-23  131  		break;
06f751b613296cc Corentin Labbe 2019-10-23  132  	case 192 / 8:
93c7f4d357de68f Corentin Labbe 2019-11-17  133  		sym |= CE_AES_192BITS;
06f751b613296cc Corentin Labbe 2019-10-23  134  		break;
06f751b613296cc Corentin Labbe 2019-10-23  135  	case 256 / 8:
93c7f4d357de68f Corentin Labbe 2019-11-17  136  		sym |= CE_AES_256BITS;
06f751b613296cc Corentin Labbe 2019-10-23  137  		break;
06f751b613296cc Corentin Labbe 2019-10-23  138  	}
06f751b613296cc Corentin Labbe 2019-10-23  139  
93c7f4d357de68f Corentin Labbe 2019-11-17  140  	cet->t_sym_ctl = cpu_to_le32(sym);
06f751b613296cc Corentin Labbe 2019-10-23  141  	cet->t_asym_ctl = 0;
06f751b613296cc Corentin Labbe 2019-10-23  142  
0605fa0f78266cc Corentin Labbe 2020-09-18  143  	rctx->addr_key = dma_map_single(ce->dev, op->key, op->keylen, DMA_TO_DEVICE);
0605fa0f78266cc Corentin Labbe 2020-09-18  144  	if (dma_mapping_error(ce->dev, rctx->addr_key)) {
06f751b613296cc Corentin Labbe 2019-10-23  145  		dev_err(ce->dev, "Cannot DMA MAP KEY\n");
06f751b613296cc Corentin Labbe 2019-10-23  146  		err = -EFAULT;
06f751b613296cc Corentin Labbe 2019-10-23  147  		goto theend;
06f751b613296cc Corentin Labbe 2019-10-23  148  	}
0605fa0f78266cc Corentin Labbe 2020-09-18  149  	cet->t_key = cpu_to_le32(rctx->addr_key);
06f751b613296cc Corentin Labbe 2019-10-23  150  
06f751b613296cc Corentin Labbe 2019-10-23  151  	ivsize = crypto_skcipher_ivsize(tfm);
06f751b613296cc Corentin Labbe 2019-10-23  152  	if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
a216f8d540cf132 Corentin Labbe 2020-09-18  153  		rctx->ivlen = ivsize;
06f751b613296cc Corentin Labbe 2019-10-23  154  		if (rctx->op_dir & CE_DECRYPTION) {
06f751b613296cc Corentin Labbe 2019-10-23  155  			offset = areq->cryptlen - ivsize;
d0b880af8c99abc Corentin Labbe 2022-01-26  156  			scatterwalk_map_and_copy(chan->backup_iv, areq->src,
a216f8d540cf132 Corentin Labbe 2020-09-18  157  						 offset, ivsize, 0);
06f751b613296cc Corentin Labbe 2019-10-23  158  		}
d0b880af8c99abc Corentin Labbe 2022-01-26  159  		memcpy(chan->bounce_iv, areq->iv, ivsize);
d0b880af8c99abc Corentin Labbe 2022-01-26  160  		rctx->addr_iv = dma_map_single(ce->dev, chan->bounce_iv, rctx->ivlen,
93c7f4d357de68f Corentin Labbe 2019-11-17  161  					       DMA_TO_DEVICE);
0605fa0f78266cc Corentin Labbe 2020-09-18  162  		if (dma_mapping_error(ce->dev, rctx->addr_iv)) {
06f751b613296cc Corentin Labbe 2019-10-23  163  			dev_err(ce->dev, "Cannot DMA MAP IV\n");
06f751b613296cc Corentin Labbe 2019-10-23  164  			err = -ENOMEM;
06f751b613296cc Corentin Labbe 2019-10-23  165  			goto theend_iv;
06f751b613296cc Corentin Labbe 2019-10-23  166  		}
0605fa0f78266cc Corentin Labbe 2020-09-18  167  		cet->t_iv = cpu_to_le32(rctx->addr_iv);
06f751b613296cc Corentin Labbe 2019-10-23  168  	}
06f751b613296cc Corentin Labbe 2019-10-23  169  
06f751b613296cc Corentin Labbe 2019-10-23  170  	if (areq->src == areq->dst) {
06f751b613296cc Corentin Labbe 2019-10-23  171  		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
06f751b613296cc Corentin Labbe 2019-10-23  172  				    DMA_BIDIRECTIONAL);
06f751b613296cc Corentin Labbe 2019-10-23  173  		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
06f751b613296cc Corentin Labbe 2019-10-23  174  			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
06f751b613296cc Corentin Labbe 2019-10-23  175  			err = -EINVAL;
06f751b613296cc Corentin Labbe 2019-10-23  176  			goto theend_iv;
06f751b613296cc Corentin Labbe 2019-10-23  177  		}
06f751b613296cc Corentin Labbe 2019-10-23  178  		nr_sgd = nr_sgs;
06f751b613296cc Corentin Labbe 2019-10-23  179  	} else {
06f751b613296cc Corentin Labbe 2019-10-23  180  		nr_sgs = dma_map_sg(ce->dev, areq->src, sg_nents(areq->src),
06f751b613296cc Corentin Labbe 2019-10-23  181  				    DMA_TO_DEVICE);
06f751b613296cc Corentin Labbe 2019-10-23  182  		if (nr_sgs <= 0 || nr_sgs > MAX_SG) {
06f751b613296cc Corentin Labbe 2019-10-23  183  			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgs);
06f751b613296cc Corentin Labbe 2019-10-23  184  			err = -EINVAL;
06f751b613296cc Corentin Labbe 2019-10-23  185  			goto theend_iv;
06f751b613296cc Corentin Labbe 2019-10-23  186  		}
06f751b613296cc Corentin Labbe 2019-10-23  187  		nr_sgd = dma_map_sg(ce->dev, areq->dst, sg_nents(areq->dst),
06f751b613296cc Corentin Labbe 2019-10-23  188  				    DMA_FROM_DEVICE);
06f751b613296cc Corentin Labbe 2019-10-23  189  		if (nr_sgd <= 0 || nr_sgd > MAX_SG) {
06f751b613296cc Corentin Labbe 2019-10-23  190  			dev_err(ce->dev, "Invalid sg number %d\n", nr_sgd);
06f751b613296cc Corentin Labbe 2019-10-23  191  			err = -EINVAL;
06f751b613296cc Corentin Labbe 2019-10-23  192  			goto theend_sgs;
06f751b613296cc Corentin Labbe 2019-10-23  193  		}
06f751b613296cc Corentin Labbe 2019-10-23  194  	}
06f751b613296cc Corentin Labbe 2019-10-23  195  
06f751b613296cc Corentin Labbe 2019-10-23  196  	len = areq->cryptlen;
06f751b613296cc Corentin Labbe 2019-10-23  197  	for_each_sg(areq->src, sg, nr_sgs, i) {
93c7f4d357de68f Corentin Labbe 2019-11-17  198  		cet->t_src[i].addr = cpu_to_le32(sg_dma_address(sg));
06f751b613296cc Corentin Labbe 2019-10-23  199  		todo = min(len, sg_dma_len(sg));
93c7f4d357de68f Corentin Labbe 2019-11-17  200  		cet->t_src[i].len = cpu_to_le32(todo / 4);
06f751b613296cc Corentin Labbe 2019-10-23  201  		dev_dbg(ce->dev, "%s total=%u SG(%d %u off=%d) todo=%u\n", __func__,
06f751b613296cc Corentin Labbe 2019-10-23  202  			areq->cryptlen, i, cet->t_src[i].len, sg->offset, todo);
06f751b613296cc Corentin Labbe 2019-10-23  203  		len -= todo;
06f751b613296cc Corentin Labbe 2019-10-23  204  	}
06f751b613296cc Corentin Labbe 2019-10-23  205  	if (len > 0) {
06f751b613296cc Corentin Labbe 2019-10-23  206  		dev_err(ce->dev, "remaining len %d\n", len);
06f751b613296cc Corentin Labbe 2019-10-23  207  		err = -EINVAL;
06f751b613296cc Corentin Labbe 2019-10-23  208  		goto theend_sgs;
06f751b613296cc Corentin Labbe 2019-10-23  209  	}
06f751b613296cc Corentin Labbe 2019-10-23  210  
06f751b613296cc Corentin Labbe 2019-10-23  211  	len = areq->cryptlen;
06f751b613296cc Corentin Labbe 2019-10-23  212  	for_each_sg(areq->dst, sg, nr_sgd, i) {
93c7f4d357de68f Corentin Labbe 2019-11-17  213  		cet->t_dst[i].addr = cpu_to_le32(sg_dma_address(sg));
06f751b613296cc Corentin Labbe 2019-10-23  214  		todo = min(len, sg_dma_len(sg));
93c7f4d357de68f Corentin Labbe 2019-11-17  215  		cet->t_dst[i].len = cpu_to_le32(todo / 4);
06f751b613296cc Corentin Labbe 2019-10-23  216  		dev_dbg(ce->dev, "%s total=%u SG(%d %u off=%d) todo=%u\n", __func__,
06f751b613296cc Corentin Labbe 2019-10-23  217  			areq->cryptlen, i, cet->t_dst[i].len, sg->offset, todo);
06f751b613296cc Corentin Labbe 2019-10-23  218  		len -= todo;
06f751b613296cc Corentin Labbe 2019-10-23  219  	}
06f751b613296cc Corentin Labbe 2019-10-23  220  	if (len > 0) {
06f751b613296cc Corentin Labbe 2019-10-23  221  		dev_err(ce->dev, "remaining len %d\n", len);
06f751b613296cc Corentin Labbe 2019-10-23  222  		err = -EINVAL;
06f751b613296cc Corentin Labbe 2019-10-23  223  		goto theend_sgs;
06f751b613296cc Corentin Labbe 2019-10-23  224  	}
06f751b613296cc Corentin Labbe 2019-10-23  225  
06f751b613296cc Corentin Labbe 2019-10-23  226  	chan->timeout = areq->cryptlen;
0605fa0f78266cc Corentin Labbe 2020-09-18  227  	rctx->nr_sgs = nr_sgs;
0605fa0f78266cc Corentin Labbe 2020-09-18  228  	rctx->nr_sgd = nr_sgd;
0605fa0f78266cc Corentin Labbe 2020-09-18  229  	return 0;
06f751b613296cc Corentin Labbe 2019-10-23  230  
06f751b613296cc Corentin Labbe 2019-10-23  231  theend_sgs:
06f751b613296cc Corentin Labbe 2019-10-23  232  	if (areq->src == areq->dst) {
884b93c51025026 Xiang Chen     2021-03-16  233  		dma_unmap_sg(ce->dev, areq->src, sg_nents(areq->src),
884b93c51025026 Xiang Chen     2021-03-16  234  			     DMA_BIDIRECTIONAL);
06f751b613296cc Corentin Labbe 2019-10-23  235  	} else {
06f751b613296cc Corentin Labbe 2019-10-23  236  		if (nr_sgs > 0)
884b93c51025026 Xiang Chen     2021-03-16  237  			dma_unmap_sg(ce->dev, areq->src, sg_nents(areq->src),
884b93c51025026 Xiang Chen     2021-03-16  238  				     DMA_TO_DEVICE);
884b93c51025026 Xiang Chen     2021-03-16  239  		dma_unmap_sg(ce->dev, areq->dst, sg_nents(areq->dst),
884b93c51025026 Xiang Chen     2021-03-16  240  			     DMA_FROM_DEVICE);
06f751b613296cc Corentin Labbe 2019-10-23  241  	}
06f751b613296cc Corentin Labbe 2019-10-23  242  
06f751b613296cc Corentin Labbe 2019-10-23  243  theend_iv:
06f751b613296cc Corentin Labbe 2019-10-23  244  	if (areq->iv && ivsize > 0) {
0605fa0f78266cc Corentin Labbe 2020-09-18  245  		if (rctx->addr_iv)
0605fa0f78266cc Corentin Labbe 2020-09-18  246  			dma_unmap_single(ce->dev, rctx->addr_iv, rctx->ivlen, DMA_TO_DEVICE);
06f751b613296cc Corentin Labbe 2019-10-23  247  		offset = areq->cryptlen - ivsize;
06f751b613296cc Corentin Labbe 2019-10-23  248  		if (rctx->op_dir & CE_DECRYPTION) {
d0b880af8c99abc Corentin Labbe 2022-01-26  249  			memcpy(areq->iv, chan->backup_iv, ivsize);
d0b880af8c99abc Corentin Labbe 2022-01-26  250  			memzero_explicit(chan->backup_iv, ivsize);
06f751b613296cc Corentin Labbe 2019-10-23  251  		} else {
06f751b613296cc Corentin Labbe 2019-10-23  252  			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
06f751b613296cc Corentin Labbe 2019-10-23  253  						 ivsize, 0);
06f751b613296cc Corentin Labbe 2019-10-23  254  		}
d0b880af8c99abc Corentin Labbe 2022-01-26  255  		memzero_explicit(chan->bounce_iv, ivsize);
06f751b613296cc Corentin Labbe 2019-10-23  256  	}
06f751b613296cc Corentin Labbe 2019-10-23  257  
06f751b613296cc Corentin Labbe 2019-10-23 @258  theend_key:
0605fa0f78266cc Corentin Labbe 2020-09-18  259  	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
06f751b613296cc Corentin Labbe 2019-10-23  260  
06f751b613296cc Corentin Labbe 2019-10-23  261  theend:
06f751b613296cc Corentin Labbe 2019-10-23  262  	return err;
06f751b613296cc Corentin Labbe 2019-10-23  263  }
06f751b613296cc Corentin Labbe 2019-10-23  264  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
