Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093A346A026
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386973AbhLFP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:58:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:6476 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1389662AbhLFPkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:40:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237279939"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="237279939"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 07:37:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="611276566"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2021 07:37:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muG3C-000LPW-8u; Mon, 06 Dec 2021 15:37:10 +0000
Date:   Mon, 6 Dec 2021 23:36:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, gregkh <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, quic_psodagud@quicinc.com
Subject: Re: [PATCHv5 1/4] arm64: io: Use asm-generic high level MMIO
 accessors
Message-ID: <202112062304.8qIQUQyF-lkp@intel.com>
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
[also build test WARNING on rostedt-trace/for-next arnd-asm-generic/master arm-perf/for-next/perf v5.16-rc4 next-20211206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-r014-20211206 (https://download.01.org/0day-ci/archive/20211206/202112062304.8qIQUQyF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0775ecf0f452d6b76b161d009dab52c90270755a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sai-Prakash-Ranjan/tracing-rwmmio-arm64-Add-support-to-trace-register-reads-writes/20211206-163212
        git checkout 0775ecf0f452d6b76b161d009dab52c90270755a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/meson/meson_viu.c:16:
   drivers/gpu/drm/meson/meson_viu.c: In function 'meson_viu_init':
>> drivers/gpu/drm/meson/meson_registers.h:1826:55: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744071814774785' to '2400190465' [-Woverflow]
    1826 | #define         VIU_OSD_BLEND_REORDER(dest, src)      ((src) << (dest * 4))
         |                                                       ^
   drivers/gpu/drm/meson/meson_viu.c:472:32: note: in expansion of macro 'VIU_OSD_BLEND_REORDER'
     472 |                 writel_relaxed(VIU_OSD_BLEND_REORDER(0, 1) |
         |                                ^~~~~~~~~~~~~~~~~~~~~


vim +1826 drivers/gpu/drm/meson/meson_registers.h

b93a66faeea9ddf Neil Armstrong 2019-03-25  1824  
b93a66faeea9ddf Neil Armstrong 2019-03-25  1825  #define VIU_OSD_BLEND_CTRL 0x39b0
147ae1cbaa18429 Julien Masson  2019-06-24 @1826  #define		VIU_OSD_BLEND_REORDER(dest, src)      ((src) << (dest * 4))
147ae1cbaa18429 Julien Masson  2019-06-24  1827  #define		VIU_OSD_BLEND_DIN_EN(bits)            ((bits & 0xf) << 20)
147ae1cbaa18429 Julien Masson  2019-06-24  1828  #define		VIU_OSD_BLEND1_DIN3_BYPASS_TO_DOUT1   BIT(24)
147ae1cbaa18429 Julien Masson  2019-06-24  1829  #define		VIU_OSD_BLEND1_DOUT_BYPASS_TO_BLEND2  BIT(25)
147ae1cbaa18429 Julien Masson  2019-06-24  1830  #define		VIU_OSD_BLEND_DIN0_BYPASS_TO_DOUT0    BIT(26)
147ae1cbaa18429 Julien Masson  2019-06-24  1831  #define		VIU_OSD_BLEND_BLEN2_PREMULT_EN(input) ((input & 0x3) << 27)
147ae1cbaa18429 Julien Masson  2019-06-24  1832  #define		VIU_OSD_BLEND_HOLD_LINES(lines)       ((lines & 0x7) << 29)
b93a66faeea9ddf Neil Armstrong 2019-03-25  1833  #define VIU_OSD_BLEND_CTRL1 0x39c0
b93a66faeea9ddf Neil Armstrong 2019-03-25  1834  #define VIU_OSD_BLEND_DIN0_SCOPE_H 0x39b1
b93a66faeea9ddf Neil Armstrong 2019-03-25  1835  #define VIU_OSD_BLEND_DIN0_SCOPE_V 0x39b2
b93a66faeea9ddf Neil Armstrong 2019-03-25  1836  #define VIU_OSD_BLEND_DIN1_SCOPE_H 0x39b3
b93a66faeea9ddf Neil Armstrong 2019-03-25  1837  #define VIU_OSD_BLEND_DIN1_SCOPE_V 0x39b4
b93a66faeea9ddf Neil Armstrong 2019-03-25  1838  #define VIU_OSD_BLEND_DIN2_SCOPE_H 0x39b5
b93a66faeea9ddf Neil Armstrong 2019-03-25  1839  #define VIU_OSD_BLEND_DIN2_SCOPE_V 0x39b6
b93a66faeea9ddf Neil Armstrong 2019-03-25  1840  #define VIU_OSD_BLEND_DIN3_SCOPE_H 0x39b7
b93a66faeea9ddf Neil Armstrong 2019-03-25  1841  #define VIU_OSD_BLEND_DIN3_SCOPE_V 0x39b8
b93a66faeea9ddf Neil Armstrong 2019-03-25  1842  #define VIU_OSD_BLEND_DUMMY_DATA0 0x39b9
b93a66faeea9ddf Neil Armstrong 2019-03-25  1843  #define VIU_OSD_BLEND_DUMMY_ALPHA 0x39ba
b93a66faeea9ddf Neil Armstrong 2019-03-25  1844  #define VIU_OSD_BLEND_BLEND0_SIZE 0x39bb
b93a66faeea9ddf Neil Armstrong 2019-03-25  1845  #define VIU_OSD_BLEND_BLEND1_SIZE 0x39bc
b93a66faeea9ddf Neil Armstrong 2019-03-25  1846  #define VIU_OSD_BLEND_RO_CURRENT_XY 0x39bf
b93a66faeea9ddf Neil Armstrong 2019-03-25  1847  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
