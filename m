Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE8D46BC20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhLGNIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:08:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:40571 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232599AbhLGNI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:08:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237511617"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237511617"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 05:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="748772247"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 07 Dec 2021 05:04:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mua9P-000MaA-77; Tue, 07 Dec 2021 13:04:55 +0000
Date:   Tue, 7 Dec 2021 21:04:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        gregkh <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, quic_psodagud@quicinc.com
Subject: Re: [PATCHv5 1/4] arm64: io: Use asm-generic high level MMIO
 accessors
Message-ID: <202112072058.SZ9tPvIm-lkp@intel.com>
References: <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on rostedt-trace/for-next arnd-asm-generic/master arm-perf/for-next/perf v5.16-rc4 next-20211207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-r022-20211207 (https://download.01.org/0day-ci/archive/20211207/202112072058.SZ9tPvIm-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/0775ecf0f452d6b76b161d009dab52c90270755a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
        git checkout 0775ecf0f452d6b76b161d009dab52c90270755a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/meson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_viu.c:480:45: warning: implicit conversion from 'unsigned long' to 'u32' (aka 'unsigned int') changes value from 18446744071814774785 to 2400190465 [-Wconstant-conversion]
                                  VIU_OSD_BLEND_BLEN2_PREMULT_EN(1) |
                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   1 warning generated.


vim +480 drivers/gpu/drm/meson/meson_viu.c

1b85270ff156d56 Neil Armstrong      2019-10-21  413  
bbbe775ec5b5dac Neil Armstrong      2016-11-10  414  void meson_viu_init(struct meson_drm *priv)
bbbe775ec5b5dac Neil Armstrong      2016-11-10  415  {
bbbe775ec5b5dac Neil Armstrong      2016-11-10  416  	uint32_t reg;
bbbe775ec5b5dac Neil Armstrong      2016-11-10  417  
bbbe775ec5b5dac Neil Armstrong      2016-11-10  418  	/* Disable OSDs */
147ae1cbaa18429 Julien Masson       2019-06-24  419  	writel_bits_relaxed(VIU_OSD1_OSD_BLK_ENABLE | VIU_OSD1_OSD_ENABLE, 0,
bbbe775ec5b5dac Neil Armstrong      2016-11-10  420  			    priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
147ae1cbaa18429 Julien Masson       2019-06-24  421  	writel_bits_relaxed(VIU_OSD1_OSD_BLK_ENABLE | VIU_OSD1_OSD_ENABLE, 0,
bbbe775ec5b5dac Neil Armstrong      2016-11-10  422  			    priv->io_base + _REG(VIU_OSD2_CTRL_STAT));
bbbe775ec5b5dac Neil Armstrong      2016-11-10  423  
bbbe775ec5b5dac Neil Armstrong      2016-11-10  424  	/* On GXL/GXM, Use the 10bit HDR conversion matrix */
528a25d040bc212 Julien Masson       2019-08-22  425  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
528a25d040bc212 Julien Masson       2019-08-22  426  	    meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL))
bbbe775ec5b5dac Neil Armstrong      2016-11-10  427  		meson_viu_load_matrix(priv);
bf33677a3c394bb Christian Hewitt    2021-08-06  428  	else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
728883948b0d3c0 Neil Armstrong      2019-03-25  429  		meson_viu_set_g12a_osd1_matrix(priv, RGB709_to_YUV709l_coeff,
728883948b0d3c0 Neil Armstrong      2019-03-25  430  					       true);
bf33677a3c394bb Christian Hewitt    2021-08-06  431  		/* fix green/pink color distortion from vendor u-boot */
bf33677a3c394bb Christian Hewitt    2021-08-06  432  		writel_bits_relaxed(OSD1_HDR2_CTRL_REG_ONLY_MAT |
bf33677a3c394bb Christian Hewitt    2021-08-06  433  				OSD1_HDR2_CTRL_VDIN0_HDR2_TOP_EN, 0,
bf33677a3c394bb Christian Hewitt    2021-08-06  434  				priv->io_base + _REG(OSD1_HDR2_CTRL));
bf33677a3c394bb Christian Hewitt    2021-08-06  435  	}
bbbe775ec5b5dac Neil Armstrong      2016-11-10  436  
bbbe775ec5b5dac Neil Armstrong      2016-11-10  437  	/* Initialize OSD1 fifo control register */
147ae1cbaa18429 Julien Masson       2019-06-24  438  	reg = VIU_OSD_DDR_PRIORITY_URGENT |
24e0d4058eff7cd Neil Armstrong      2019-10-21  439  		VIU_OSD_HOLD_FIFO_LINES(31) |
147ae1cbaa18429 Julien Masson       2019-06-24  440  		VIU_OSD_FIFO_DEPTH_VAL(32) | /* fifo_depth_val: 32*8=256 */
147ae1cbaa18429 Julien Masson       2019-06-24  441  		VIU_OSD_WORDS_PER_BURST(4) | /* 4 words in 1 burst */
147ae1cbaa18429 Julien Masson       2019-06-24  442  		VIU_OSD_FIFO_LIMITS(2);      /* fifo_lim: 2*16=32 */
147ae1cbaa18429 Julien Masson       2019-06-24  443  
528a25d040bc212 Julien Masson       2019-08-22  444  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
17f64701ea6f541 Martin Blumenstingl 2020-06-20  445  		reg |= VIU_OSD_BURST_LENGTH_32;
728883948b0d3c0 Neil Armstrong      2019-03-25  446  	else
17f64701ea6f541 Martin Blumenstingl 2020-06-20  447  		reg |= VIU_OSD_BURST_LENGTH_64;
147ae1cbaa18429 Julien Masson       2019-06-24  448  
bbbe775ec5b5dac Neil Armstrong      2016-11-10  449  	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD1_FIFO_CTRL_STAT));
bbbe775ec5b5dac Neil Armstrong      2016-11-10  450  	writel_relaxed(reg, priv->io_base + _REG(VIU_OSD2_FIFO_CTRL_STAT));
bbbe775ec5b5dac Neil Armstrong      2016-11-10  451  
bbbe775ec5b5dac Neil Armstrong      2016-11-10  452  	/* Set OSD alpha replace value */
bbbe775ec5b5dac Neil Armstrong      2016-11-10  453  	writel_bits_relaxed(0xff << OSD_REPLACE_SHIFT,
bbbe775ec5b5dac Neil Armstrong      2016-11-10  454  			    0xff << OSD_REPLACE_SHIFT,
bbbe775ec5b5dac Neil Armstrong      2016-11-10  455  			    priv->io_base + _REG(VIU_OSD1_CTRL_STAT2));
bbbe775ec5b5dac Neil Armstrong      2016-11-10  456  	writel_bits_relaxed(0xff << OSD_REPLACE_SHIFT,
bbbe775ec5b5dac Neil Armstrong      2016-11-10  457  			    0xff << OSD_REPLACE_SHIFT,
bbbe775ec5b5dac Neil Armstrong      2016-11-10  458  			    priv->io_base + _REG(VIU_OSD2_CTRL_STAT2));
bbbe775ec5b5dac Neil Armstrong      2016-11-10  459  
f9a2348196d1ab9 Neil Armstrong      2018-11-06  460  	/* Disable VD1 AFBC */
147ae1cbaa18429 Julien Masson       2019-06-24  461  	/* di_mif0_en=0 mif0_to_vpp_en=0 di_mad_en=0 and afbc vd1 set=0*/
147ae1cbaa18429 Julien Masson       2019-06-24  462  	writel_bits_relaxed(VIU_CTRL0_VD1_AFBC_MASK, 0,
f9a2348196d1ab9 Neil Armstrong      2018-11-06  463  			    priv->io_base + _REG(VIU_MISC_CTRL0));
f9a2348196d1ab9 Neil Armstrong      2018-11-06  464  	writel_relaxed(0, priv->io_base + _REG(AFBC_ENABLE));
f9a2348196d1ab9 Neil Armstrong      2018-11-06  465  
f9a2348196d1ab9 Neil Armstrong      2018-11-06  466  	writel_relaxed(0x00FF00C0,
f9a2348196d1ab9 Neil Armstrong      2018-11-06  467  			priv->io_base + _REG(VD1_IF0_LUMA_FIFO_SIZE));
f9a2348196d1ab9 Neil Armstrong      2018-11-06  468  	writel_relaxed(0x00FF00C0,
f9a2348196d1ab9 Neil Armstrong      2018-11-06  469  			priv->io_base + _REG(VD2_IF0_LUMA_FIFO_SIZE));
f9a2348196d1ab9 Neil Armstrong      2018-11-06  470  
528a25d040bc212 Julien Masson       2019-08-22  471  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
147ae1cbaa18429 Julien Masson       2019-06-24  472  		writel_relaxed(VIU_OSD_BLEND_REORDER(0, 1) |
147ae1cbaa18429 Julien Masson       2019-06-24  473  			       VIU_OSD_BLEND_REORDER(1, 0) |
147ae1cbaa18429 Julien Masson       2019-06-24  474  			       VIU_OSD_BLEND_REORDER(2, 0) |
147ae1cbaa18429 Julien Masson       2019-06-24  475  			       VIU_OSD_BLEND_REORDER(3, 0) |
147ae1cbaa18429 Julien Masson       2019-06-24  476  			       VIU_OSD_BLEND_DIN_EN(1) |
147ae1cbaa18429 Julien Masson       2019-06-24  477  			       VIU_OSD_BLEND1_DIN3_BYPASS_TO_DOUT1 |
147ae1cbaa18429 Julien Masson       2019-06-24  478  			       VIU_OSD_BLEND1_DOUT_BYPASS_TO_BLEND2 |
147ae1cbaa18429 Julien Masson       2019-06-24  479  			       VIU_OSD_BLEND_DIN0_BYPASS_TO_DOUT0 |
147ae1cbaa18429 Julien Masson       2019-06-24 @480  			       VIU_OSD_BLEND_BLEN2_PREMULT_EN(1) |

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
