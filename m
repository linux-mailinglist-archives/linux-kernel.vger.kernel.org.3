Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854AB596351
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiHPTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiHPTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:45:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3074BBD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660679103; x=1692215103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nqrSTdVvzNmXAvAgkzU2Qsd76Iso3sArnsdPL1zaa5k=;
  b=d5KrZeT2zXcUYaNDL3wSvnqATlABSATuwTA9WaXKuUlPj3ptgVHDJc8w
   tXxZyWtK65hVVH/BRHp/CJb3qJMznszsHBhvQxTb/pwhojnuCXU1zvIeO
   mQ61PY0tyCRWd4PCzfK5glf/jZzTjMIa4W9xgpaj4Rq80jN4If6suOq4M
   mjGxF/T+umfTc5S46pf0D1MpLqvJYrWVdEbWvpLR+6e35FEebbPAmbWg6
   d35Ii2MABImNkbO4cOc8U1a7V2BzDZ9sx+KgL7cklTM6g0dQXKazhfksE
   p28mV9McvCqEzyA6xv3ppWEDtsvB0H0iZY84nXJX+hVRZkpRzn+UNhUHs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289885899"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="289885899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 12:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="636036417"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2022 12:45:00 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO2Um-0000Bk-0F;
        Tue, 16 Aug 2022 19:45:00 +0000
Date:   Wed, 17 Aug 2022 03:44:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v3] regmap: mmio: Support accelerared noinc operations
Message-ID: <202208170316.UKonQfhi-lkp@intel.com>
References: <20220816130823.97903-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816130823.97903-2-linus.walleij@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I love your patch! Yet something to improve:

[auto build test ERROR on v6.0-rc1]
[also build test ERROR on linus/master]
[cannot apply to broonie-regmap/for-next next-20220816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-Walleij/regmap-Support-accelerated-noinc-operations/20220816-211403
base:    568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: hexagon-randconfig-r045-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170316.UKonQfhi-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8ab63711dfb48f91d79fff115511f7895ca39180
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Linus-Walleij/regmap-Support-accelerated-noinc-operations/20220816-211403
        git checkout 8ab63711dfb48f91d79fff115511f7895ca39180
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/base/regmap/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/regmap/regmap-mmio.c:212:3: error: call to undeclared function 'writesb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   writesb(ctx->regs + reg, (const u8 *)val, val_count);
                   ^
   drivers/base/regmap/regmap-mmio.c:212:3: note: did you mean 'writeb'?
   arch/hexagon/include/asm/io.h:122:20: note: 'writeb' declared here
   static inline void writeb(u8 data, volatile void __iomem *addr)
                      ^
>> drivers/base/regmap/regmap-mmio.c:366:3: error: call to undeclared function 'readsb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   readsb(ctx->regs + reg, (u8 *)val, val_count);
                   ^
   drivers/base/regmap/regmap-mmio.c:366:3: note: did you mean 'readb'?
   arch/hexagon/include/asm/io.h:83:18: note: 'readb' declared here
   static inline u8 readb(const volatile void __iomem *addr)
                    ^
   2 errors generated.


vim +/writesb +212 drivers/base/regmap/regmap-mmio.c

   163	
   164	static int regmap_mmio_noinc_write(void *context, unsigned int reg,
   165					   const void *val, size_t val_count)
   166	{
   167		struct regmap_mmio_context *ctx = context;
   168		int ret = 0;
   169		int i;
   170	
   171		if (!IS_ERR(ctx->clk)) {
   172			ret = clk_enable(ctx->clk);
   173			if (ret < 0)
   174				return ret;
   175		}
   176	
   177		/*
   178		 * There are no native, assembly-optimized write single register
   179		 * operations for big endian, so fall back to emulation if this
   180		 * is needed. (Single bytes are fine, they are not affected by
   181		 * endianness.)
   182		 */
   183		if (ctx->big_endian && (ctx->val_bytes > 1)) {
   184			switch (ctx->val_bytes) {
   185			case 2:
   186			{
   187				const u16 *valp = (const u16 *)val;
   188				for (i = 0; i < val_count; i++)
   189					iowrite16be(valp[i], ctx->regs + reg);
   190				break;
   191			}
   192			case 4:
   193			{
   194				const u32 *valp = (const u32 *)val;
   195				for (i = 0; i < val_count; i++)
   196					iowrite32be(valp[i], ctx->regs + reg);
   197				break;
   198			}
   199	#ifdef CONFIG_64BIT
   200			case 8:
   201				/* This is just too esoteric */
   202				fallthrough;
   203	#endif
   204			default:
   205				ret = -EINVAL;
   206				goto out_clk;
   207			}
   208		}
   209	
   210		switch (ctx->val_bytes) {
   211		case 1:
 > 212			writesb(ctx->regs + reg, (const u8 *)val, val_count);
   213			break;
   214		case 2:
   215			writesw(ctx->regs + reg, (const u16 *)val, val_count);
   216			break;
   217		case 4:
   218			writesl(ctx->regs + reg, (const u32 *)val, val_count);
   219			break;
   220	#ifdef CONFIG_64BIT
   221		case 8:
   222			writesq(ctx->regs + reg, (const u64 *)val, val_count);
   223			break;
   224	#endif
   225		default:
   226			ret = -EINVAL;
   227			break;
   228		}
   229	
   230	out_clk:
   231		if (!IS_ERR(ctx->clk))
   232			clk_disable(ctx->clk);
   233	
   234		return ret;
   235	}
   236	
   237	static unsigned int regmap_mmio_read8(struct regmap_mmio_context *ctx,
   238					      unsigned int reg)
   239	{
   240		return readb(ctx->regs + reg);
   241	}
   242	
   243	static unsigned int regmap_mmio_read8_relaxed(struct regmap_mmio_context *ctx,
   244					      unsigned int reg)
   245	{
   246		return readb_relaxed(ctx->regs + reg);
   247	}
   248	
   249	static unsigned int regmap_mmio_read16le(struct regmap_mmio_context *ctx,
   250					         unsigned int reg)
   251	{
   252		return readw(ctx->regs + reg);
   253	}
   254	
   255	static unsigned int regmap_mmio_read16le_relaxed(struct regmap_mmio_context *ctx,
   256							 unsigned int reg)
   257	{
   258		return readw_relaxed(ctx->regs + reg);
   259	}
   260	
   261	static unsigned int regmap_mmio_read16be(struct regmap_mmio_context *ctx,
   262					         unsigned int reg)
   263	{
   264		return ioread16be(ctx->regs + reg);
   265	}
   266	
   267	static unsigned int regmap_mmio_read32le(struct regmap_mmio_context *ctx,
   268					         unsigned int reg)
   269	{
   270		return readl(ctx->regs + reg);
   271	}
   272	
   273	static unsigned int regmap_mmio_read32le_relaxed(struct regmap_mmio_context *ctx,
   274							 unsigned int reg)
   275	{
   276		return readl_relaxed(ctx->regs + reg);
   277	}
   278	
   279	static unsigned int regmap_mmio_read32be(struct regmap_mmio_context *ctx,
   280					         unsigned int reg)
   281	{
   282		return ioread32be(ctx->regs + reg);
   283	}
   284	
   285	#ifdef CONFIG_64BIT
   286	static unsigned int regmap_mmio_read64le(struct regmap_mmio_context *ctx,
   287					         unsigned int reg)
   288	{
   289		return readq(ctx->regs + reg);
   290	}
   291	
   292	static unsigned int regmap_mmio_read64le_relaxed(struct regmap_mmio_context *ctx,
   293							 unsigned int reg)
   294	{
   295		return readq_relaxed(ctx->regs + reg);
   296	}
   297	#endif
   298	
   299	static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
   300	{
   301		struct regmap_mmio_context *ctx = context;
   302		int ret;
   303	
   304		if (!IS_ERR(ctx->clk)) {
   305			ret = clk_enable(ctx->clk);
   306			if (ret < 0)
   307				return ret;
   308		}
   309	
   310		*val = ctx->reg_read(ctx, reg);
   311	
   312		if (!IS_ERR(ctx->clk))
   313			clk_disable(ctx->clk);
   314	
   315		return 0;
   316	}
   317	
   318	static int regmap_mmio_noinc_read(void *context, unsigned int reg,
   319					  void *val, size_t val_count)
   320	{
   321		struct regmap_mmio_context *ctx = context;
   322		int ret = 0;
   323		int i;
   324	
   325		if (!IS_ERR(ctx->clk)) {
   326			ret = clk_enable(ctx->clk);
   327			if (ret < 0)
   328				return ret;
   329		}
   330	
   331		/*
   332		 * There are no native, assembly-optimized write single register
   333		 * operations for big endian, so fall back to emulation if this
   334		 * is needed. (Single bytes are fine, they are not affected by
   335		 * endianness.)
   336		 */
   337		if (ctx->big_endian && (ctx->val_bytes > 1)) {
   338			switch (ctx->val_bytes) {
   339			case 2:
   340			{
   341				u16 *valp = (u16 *)val;
   342				for (i = 0; i < val_count; i++)
   343					valp[i] = ioread16be(ctx->regs + reg);
   344				break;
   345			}
   346			case 4:
   347			{
   348				u32 *valp = (u32 *)val;
   349				for (i = 0; i < val_count; i++)
   350					valp[i] = ioread32be(ctx->regs + reg);
   351				break;
   352			}
   353	#ifdef CONFIG_64BIT
   354			case 8:
   355				/* This is just too esoteric */
   356				fallthrough;
   357	#endif
   358			default:
   359				ret = -EINVAL;
   360				goto out_clk;
   361			}
   362		}
   363	
   364		switch (ctx->val_bytes) {
   365		case 1:
 > 366			readsb(ctx->regs + reg, (u8 *)val, val_count);
   367			break;
   368		case 2:
   369			readsw(ctx->regs + reg, (u16 *)val, val_count);
   370			break;
   371		case 4:
   372			readsl(ctx->regs + reg, (u32 *)val, val_count);
   373			break;
   374	#ifdef CONFIG_64BIT
   375		case 8:
   376			readsq(ctx->regs + reg, (u64 *)val, val_count);
   377			break;
   378	#endif
   379		default:
   380			ret = -EINVAL;
   381			break;
   382		}
   383	
   384	out_clk:
   385		if (!IS_ERR(ctx->clk))
   386			clk_disable(ctx->clk);
   387	
   388		return ret;
   389	
   390		return 0;
   391	}
   392	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
