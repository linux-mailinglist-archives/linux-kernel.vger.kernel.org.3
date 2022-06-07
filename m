Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C457753F5D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiFGGDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFGGDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:03:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBA114036;
        Mon,  6 Jun 2022 23:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654581829; x=1686117829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PQaqbgfR6maW5C0u78E1636zbiBJai++mqzEJ4Xc1gc=;
  b=TDNs6XKEtY0SNP8FI/cnl54/2/Fb/bDRq40XMtI3tYGjcqVUKGs2p6o8
   V4b5KKNfLhoo/vA72SW+ebXXyRrTTJQ/8tUjCi3FLv/armWVa3actiyTw
   RRETEcwvxwT3RSxcyfu2lwIXlMKR9eVWnbjso2tgp1n8/s2Q2HfsPiK86
   v34aXjD/MuDPBg5c/hsLJzY74R4/rLlcSst1o6DK5BYp3m2VxANsB7CAl
   1Jt8SWufuh88QuIP2p/Kg5PvlOoqs1g+eYfdcqtNU1dHMUH6253fnJ0v2
   5yyxE74Wmnz3j8pY1O2cCiAye2HIPClv3galZZBLBEIYk887jC7l49Ga4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="257151664"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="257151664"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 23:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="579469046"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2022 23:03:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nySJb-000DPp-S8;
        Tue, 07 Jun 2022 06:03:43 +0000
Date:   Tue, 7 Jun 2022 14:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/msm: Expose client engine utilization via
 fdinfo
Message-ID: <202206071325.FWDwmg2D-lkp@intel.com>
References: <20220606195432.1888346-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606195432.1888346-2-robdclark@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-intel/for-linux-next drm-tip/drm-tip v5.19-rc1 next-20220607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Clark/drm-Add-DRM_GEM_FOPS/20220607-035529
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: s390-buildonly-randconfig-r008-20220605 (https://download.01.org/0day-ci/archive/20220607/202206071325.FWDwmg2D-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/09342d3c56fa77dacb235908515f0a44ac2fc9c2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rob-Clark/drm-Add-DRM_GEM_FOPS/20220607-035529
        git checkout 09342d3c56fa77dacb235908515f0a44ac2fc9c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/msm_gpu.c:9:
   In file included from drivers/gpu/drm/msm/msm_gpu.h:10:
   In file included from include/linux/adreno-smmu-priv.h:9:
   In file included from include/linux/io-pgtable.h:6:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/gpu/drm/msm/msm_gpu.c:9:
   In file included from drivers/gpu/drm/msm/msm_gpu.h:10:
   In file included from include/linux/adreno-smmu-priv.h:9:
   In file included from include/linux/io-pgtable.h:6:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/gpu/drm/msm/msm_gpu.c:9:
   In file included from drivers/gpu/drm/msm/msm_gpu.h:10:
   In file included from include/linux/adreno-smmu-priv.h:9:
   In file included from include/linux/io-pgtable.h:6:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/gpu/drm/msm/msm_gpu.c:158:46: warning: format specifies type 'unsigned long' but the argument has type 'uint32_t' (aka 'unsigned int') [-Wformat]
           drm_printf(p, "drm-maxfreq-gpu:\t%lu Hz\n", gpu->fast_rate);
                                            ~~~        ^~~~~~~~~~~~~~
                                            %u
   In file included from drivers/gpu/drm/msm/msm_gpu.c:7:
   In file included from include/drm/drm_drv.h:33:
   In file included from include/drm/drm_device.h:5:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:118:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \
            ^
   <inline asm>:5:5: note: instantiated into assembly here
   .if 6651b-6641b > 254
       ^
   In file included from drivers/gpu/drm/msm/msm_gpu.c:7:
   In file included from include/drm/drm_drv.h:33:
   In file included from include/drm/drm_device.h:5:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:118:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:63:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives does not support instructions "    \
            ^
   <inline asm>:6:2: note: instantiated into assembly here
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   In file included from drivers/gpu/drm/msm/msm_gpu.c:7:
   In file included from include/drm/drm_drv.h:33:
   In file included from include/drm/drm_device.h:5:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:118:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:66:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if (" len ") %% 2\n"                                          \
            ^
   <inline asm>:8:5: note: instantiated into assembly here
   .if (6651b-6641b) % 2
       ^
   In file included from drivers/gpu/drm/msm/msm_gpu.c:7:
   In file included from include/drm/drm_drv.h:33:
   In file included from include/drm/drm_device.h:5:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: cpu alternatives instructions length is odd
                   ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:118:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:67:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives instructions length is odd\"\n"    \
            ^
   <inline asm>:9:2: note: instantiated into assembly here
           .error "cpu alternatives instructions length is odd"
           ^
   In file included from drivers/gpu/drm/msm/msm_gpu.c:7:
   In file included from include/drm/drm_drv.h:33:
   In file included from include/drm/drm_device.h:5:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:120:2: note: expanded from macro 'ALTERNATIVE'
           OLDINSTR(oldinstr, 1)                                           \
           ^
   arch/s390/include/asm/alternative.h:90:2: note: expanded from macro 'OLDINSTR'
           OLDINSTR_PADDING(oldinstr, num)                                 \
           ^
   arch/s390/include/asm/alternative.h:71:3: note: expanded from macro 'OLDINSTR_PADDING'
           ".if " oldinstr_pad_len(num) " > 6\n"                           \
            ^


vim +158 drivers/gpu/drm/msm/msm_gpu.c

   150	
   151	void msm_gpu_show_fdinfo(struct msm_gpu *gpu, struct msm_file_private *ctx,
   152				 struct drm_printer *p)
   153	{
   154		drm_printf(p, "drm-driver:\t%s\n", gpu->dev->driver->name);
   155		drm_printf(p, "drm-client-id:\t%u\n", ctx->seqno);
   156		drm_printf(p, "drm-engine-gpu:\t%llu ns\n", ctx->elapsed_ns);
   157		drm_printf(p, "drm-cycles-gpu:\t%llu\n", ctx->cycles);
 > 158		drm_printf(p, "drm-maxfreq-gpu:\t%lu Hz\n", gpu->fast_rate);
   159	}
   160	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
