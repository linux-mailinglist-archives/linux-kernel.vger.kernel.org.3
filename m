Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C0E591628
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 22:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiHLUCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 16:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiHLUB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 16:01:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E260D5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660334517; x=1691870517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rObx9CQiZ9p/Xt7cKP+MPNTbdMgI9rNEvHssjBplX/w=;
  b=hSgApss3UIQEuJcRJ1hfWw7m/3fKqWONx/nNkaufQwqsP2ufPV/1nuMF
   K28hTkeQwSeOX6tiE/hrKRfS8bNpExt5VFpu3frWe03G7GvWAedso6tDV
   OH1L7lj/pSB4eFi0FhKgPEqGe7NFKseGuzFEUC995SHG31se2OEC8RKLA
   p9KHFglgDQiSjlwFzZQRTCLnsbHFe8gw8A8k7RYF8Uoijmf31uJ20h626
   bMXKqKyFea39n1gLjNMUSxZONQMXTBe/EYHykGUeOFOWSgFhbjP+XzGak
   QMLMtJ4ls5t8F2TCnTLkI4Ul9U20usdYLf5K8P/CoiGZ1rYGZ0DUDpUm3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355684506"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355684506"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 13:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782069924"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 13:01:54 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMaqv-0000sm-1J;
        Fri, 12 Aug 2022 20:01:53 +0000
Date:   Sat, 13 Aug 2022 04:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhenneng Li <lizhenneng@kylinos.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Jack Xiao <Jack.Xiao@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Zhenneng Li <lizhenneng@kylinos.cn>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use native mode for dp aux transfer
Message-ID: <202208130320.NDvnbeVL-lkp@intel.com>
References: <20220811072012.962460-1-lizhenneng@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811072012.962460-1-lizhenneng@kylinos.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhenneng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhenneng-Li/drm-amdgpu-use-native-mode-for-dp-aux-transfer/20220811-193443
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
config: s390-randconfig-r034-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130320.NDvnbeVL-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/1098c6fecb4292d634dbdccff9e720400dc7138d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zhenneng-Li/drm-amdgpu-use-native-mode-for-dp-aux-transfer/20220811-193443
        git checkout 1098c6fecb4292d634dbdccff9e720400dc7138d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:25:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:25:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:25:
   In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:52:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
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
>> drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:73:10: warning: no previous prototype for function 'venus_mm_rreg_slow' [-Wmissing-prototypes]
   uint32_t venus_mm_rreg_slow(struct amdgpu_device *adev, uint32_t reg)
            ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:73:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   uint32_t venus_mm_rreg_slow(struct amdgpu_device *adev, uint32_t reg)
   ^
   static 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:84:6: warning: no previous prototype for function 'venus_mm_wreg_slow' [-Wmissing-prototypes]
   void venus_mm_wreg_slow(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
        ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c:84:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void venus_mm_wreg_slow(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
   ^
   static 
   14 warnings generated.


vim +/venus_mm_rreg_slow +73 drivers/gpu/drm/amd/amdgpu/amdgpu_dp_auxch.c

    69	
    70	#define R100_MM_INDEX                   0x0000
    71	#define R100_MM_DATA                      0x0004
    72	#define AMDGPU_MIN_MMIO_SIZE 0x10000
  > 73	uint32_t venus_mm_rreg_slow(struct amdgpu_device *adev, uint32_t reg)
    74	{
    75	        unsigned long flags;
    76	        uint32_t ret;
    77	
    78	        spin_lock_irqsave(&adev->mmio_idx_lock, flags);
    79	        writel(reg, ((void __iomem *)adev->rmmio) + R100_MM_INDEX);
    80	        ret = readl(((void __iomem *)adev->rmmio) + R100_MM_DATA);
    81	        spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
    82	        return ret;
    83	}
  > 84	void venus_mm_wreg_slow(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
    85	{
    86	        unsigned long flags;
    87	
    88	        spin_lock_irqsave(&adev->mmio_idx_lock, flags);
    89	        writel(reg, ((void __iomem *)adev->rmmio) + R100_MM_INDEX);
    90	        writel(v, ((void __iomem *)adev->rmmio) + R100_MM_DATA);
    91	        spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
    92	}
    93	static inline uint32_t venus_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
    94	                                    bool always_indirect)
    95	{
    96	        /* The mmio size is 64kb at minimum. Allows the if to be optimized out. */
    97	        if ((reg < adev->rmmio_size || reg < AMDGPU_MIN_MMIO_SIZE) && !always_indirect)
    98	                return readl(((void __iomem *)adev->rmmio) + reg);
    99	        else
   100	                return venus_mm_rreg_slow(adev, reg);
   101	}
   102	static inline void venus_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
   103	                                bool always_indirect)
   104	{
   105	        if ((reg < adev->rmmio_size || reg < AMDGPU_MIN_MMIO_SIZE) && !always_indirect)
   106	                writel(v, ((void __iomem *)adev->rmmio) + reg);
   107	        else
   108	                venus_mm_wreg_slow(adev, reg, v);
   109	}
   110	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
