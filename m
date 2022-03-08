Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E55F4D247D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbiCHWuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiCHWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:50:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130964EF44;
        Tue,  8 Mar 2022 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646779788; x=1678315788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+n/RZ+ZsI1FXtTahOLr2TYDxkaDcUckT809xviUSmTk=;
  b=gswRdk4OQpKW69ZII4YK+yGSafoWwdKxDMofSf3/hhvVqsPMAoXKR/H+
   X/z0ta1GaCO+HywE1u+rmMEUfQWWZA/q8MAqr3SvWsgLj2zXIFUYZ0PGz
   LoR4ivf7HyQT3QgwrkR/HoQZrE5hz8HQLmk++NDJlFHOwSVx19aPZuqpC
   cNjSxOQPFFyAfu61hHcWQwaRjHHaECa5FLPE4mgyB9db8GZSPWhRcDjOR
   nbu9W9xRibXynJ9sH8ZeBzLkFImj7YIim6PzsukeYa3sKc2OuN44Fkq5J
   sY3F714bICTMs5VBm+HUhqu0w9hhjdgMn0v7m47fprGMhOv0ON8Q0xalY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="318062340"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="318062340"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 14:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643824407"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 14:49:41 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRieC-00028O-SW; Tue, 08 Mar 2022 22:49:40 +0000
Date:   Wed, 9 Mar 2022 06:49:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     meenakshi.aggarwal@nxp.com, Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH] crypto: caam/rng: Add support for PRNG
Message-ID: <202203090603.qhbToPLJ-lkp@intel.com>
References: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master v5.17-rc7 next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/meenakshi-aggarwal-nxp-com/crypto-caam-rng-Add-support-for-PRNG/20220307-142401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: arm-multi_v7_defconfig (https://download.01.org/0day-ci/archive/20220309/202203090603.qhbToPLJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bc27c1a2748de5052fb4c042d90fa1e0e4132043
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review meenakshi-aggarwal-nxp-com/crypto-caam-rng-Add-support-for-PRNG/20220307-142401
        git checkout bc27c1a2748de5052fb4c042d90fa1e0e4132043
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/crypto/caam/ drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/crypto/caam/compat.h:18,
                    from drivers/crypto/caam/caamprng.c:11:
   drivers/crypto/caam/caamprng.c: In function 'caam_prng_seed':
>> drivers/crypto/caam/caamprng.c:156:46: warning: passing argument 2 of 'dma_map_single_attrs' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     156 |         seed_dma = dma_map_single(ctx.jrdev, seed, slen, DMA_FROM_DEVICE);
         |                                              ^~~~
   include/linux/dma-mapping.h:406:60: note: in definition of macro 'dma_map_single'
     406 | #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
         |                                                            ^
   include/linux/dma-mapping.h:322:73: note: expected 'void *' but argument is of type 'const u8 *' {aka 'const unsigned char *'}
     322 | static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
         |                                                                   ~~~~~~^~~


vim +156 drivers/crypto/caam/caamprng.c

  > 11	#include "compat.h"
    12	#include "regs.h"
    13	#include "intern.h"
    14	#include "desc_constr.h"
    15	#include "jr.h"
    16	#include "error.h"
    17	
    18	/*
    19	 * Length of used descriptors, see caam_init_desc()
    20	 */
    21	#define CAAM_PRNG_DESC_LEN (CAAM_CMD_SZ +				\
    22				    CAAM_CMD_SZ +				\
    23				    CAAM_CMD_SZ + CAAM_PTR_SZ_MAX)
    24	
    25	/* prng per-device context */
    26	struct caam_prng_ctx {
    27		struct device *jrdev;
    28		struct completion done;
    29	};
    30	
    31	struct caam_prng_alg {
    32		struct rng_alg rng;
    33		bool registered;
    34	};
    35	
    36	static void caam_prng_done(struct device *jrdev, u32 *desc, u32 err,
    37				  void *context)
    38	{
    39		struct caam_prng_ctx *jctx = context;
    40	
    41		if (err)
    42			caam_jr_strstatus(jrdev, err);
    43	
    44		complete(&jctx->done);
    45	}
    46	
    47	static u32 *caam_init_reseed_desc(u32 *desc, dma_addr_t seed_dma, u32 len)
    48	{
    49		init_job_desc(desc, 0);	/* + 1 cmd_sz */
    50		/* Generate random bytes: + 1 cmd_sz */
    51		append_operation(desc, OP_TYPE_CLASS1_ALG | OP_ALG_ALGSEL_RNG |
    52				OP_ALG_AS_FINALIZE | OP_ALG_AI_ON);
    53		/* Store bytes: + 1 cmd_sz + caam_ptr_sz  */
    54		append_load(desc, seed_dma, len, CLASS_1 | LDST_SRCDST_BYTE_CONTEXT);
    55	
    56		print_hex_dump_debug("prng reseed desc@: ", DUMP_PREFIX_ADDRESS,
    57				     16, 4, desc, desc_bytes(desc), 1);
    58	
    59		return desc;
    60	}
    61	
    62	static u32 *caam_init_prng_desc(u32 *desc, dma_addr_t dst_dma, u32 len)
    63	{
    64		init_job_desc(desc, 0);	/* + 1 cmd_sz */
    65		/* Generate random bytes: + 1 cmd_sz */
    66		append_operation(desc, OP_ALG_ALGSEL_RNG | OP_TYPE_CLASS1_ALG);
    67		/* Store bytes: + 1 cmd_sz + caam_ptr_sz  */
    68		append_fifo_store(desc, dst_dma,
    69				  len, FIFOST_TYPE_RNGSTORE);
    70	
    71		print_hex_dump_debug("prng job desc@: ", DUMP_PREFIX_ADDRESS,
    72				     16, 4, desc, desc_bytes(desc), 1);
    73	
    74		return desc;
    75	}
    76	
    77	static int caam_prng_generate(struct crypto_rng *tfm,
    78				     const u8 *src, unsigned int slen,
    79				     u8 *dst, unsigned int dlen)
    80	{
    81		struct caam_prng_ctx ctx;
    82		dma_addr_t dst_dma;
    83		u32 *desc;
    84		int ret;
    85	
    86		ctx.jrdev = caam_jr_alloc();
    87		ret = PTR_ERR_OR_ZERO(ctx.jrdev);
    88		if (ret) {
    89			pr_err("Job Ring Device allocation failed\n");
    90			return ret;
    91		}
    92	
    93		desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
    94		if (!desc) {
    95			caam_jr_free(ctx.jrdev);
    96			return -ENOMEM;
    97		}
    98	
    99		dst_dma = dma_map_single(ctx.jrdev, dst, dlen, DMA_FROM_DEVICE);
   100		if (dma_mapping_error(ctx.jrdev, dst_dma)) {
   101			dev_err(ctx.jrdev, "Failed to map destination buffer memory\n");
   102			ret = -ENOMEM;
   103			goto out;
   104		}
   105	
   106		init_completion(&ctx.done);
   107		ret = caam_jr_enqueue(ctx.jrdev,
   108				      caam_init_prng_desc(desc, dst_dma, dlen),
   109				      caam_prng_done, &ctx);
   110	
   111		if (ret == -EINPROGRESS) {
   112			wait_for_completion(&ctx.done);
   113			ret = 0;
   114		}
   115	
   116		dma_unmap_single(ctx.jrdev, dst_dma, dlen, DMA_FROM_DEVICE);
   117	
   118	out:
   119		kfree(desc);
   120		caam_jr_free(ctx.jrdev);
   121		return ret;
   122	}
   123	
   124	static void caam_prng_exit(struct crypto_tfm *tfm)
   125	{
   126	
   127		return;
   128	}
   129	
   130	static int caam_prng_init(struct crypto_tfm *tfm)
   131	{
   132		return 0;
   133	}
   134	
   135	static int caam_prng_seed(struct crypto_rng *tfm,
   136				 const u8 *seed, unsigned int slen)
   137	{
   138		struct caam_prng_ctx ctx;
   139		dma_addr_t seed_dma;
   140		u32 *desc;
   141		int ret;
   142	
   143		ctx.jrdev = caam_jr_alloc();
   144		ret = PTR_ERR_OR_ZERO(ctx.jrdev);
   145		if (ret) {
   146			pr_err("Job Ring Device allocation failed\n");
   147			return ret;
   148		}
   149	
   150		desc = kzalloc(CAAM_PRNG_DESC_LEN, GFP_KERNEL | GFP_DMA);
   151		if (!desc) {
   152			caam_jr_free(ctx.jrdev);
   153			return -ENOMEM;
   154		}
   155	
 > 156		seed_dma = dma_map_single(ctx.jrdev, seed, slen, DMA_FROM_DEVICE);
   157		if (dma_mapping_error(ctx.jrdev, seed_dma)) {
   158			dev_err(ctx.jrdev, "Failed to map destination buffer memory\n");
   159			ret = -ENOMEM;
   160			goto out;
   161		}
   162	
   163		init_completion(&ctx.done);
   164		ret = caam_jr_enqueue(ctx.jrdev,
   165				      caam_init_reseed_desc(desc, seed_dma, slen),
   166				      caam_prng_done, &ctx);
   167	
   168		if (ret == -EINPROGRESS) {
   169			wait_for_completion(&ctx.done);
   170			ret = 0;
   171		}
   172	
   173		dma_unmap_single(ctx.jrdev, seed_dma, slen, DMA_FROM_DEVICE);
   174	
   175	out:
   176		kfree(desc);
   177		caam_jr_free(ctx.jrdev);
   178		return ret;
   179	}
   180	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
