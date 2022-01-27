Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B165449D823
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiA0CoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:44:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:30268 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbiA0CoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643251454; x=1674787454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zwYSbiY3geyZli3ikJr11I2AkTl4uyLHUiDrCysk3U4=;
  b=QOzn8H+yUAnae64GgHc3QQJFfFfjDGh+OF7mgxuxOIu+sUEC8ZwOOMDV
   X1t0SVkzleu8k6lwzWF4I+XHCtgeUMuVHWVB/HBcFJ+hgijsvBNsgg6q5
   JPLYkz3TN2wXYT6pqHfRGNVFMvHvbwkMDaho4RTuBB/tjIZl680UHxTjw
   RrZrl29kJLDBIrpdZ/l4VNXmSHNcqR6vcCqqLEzUwlretavIvL0KgYiiP
   8AdQBBGzF3bqrqNqSfM1830poXWC0lz1jt7vOMCCJ/0kCDwj5gRo5Tiiq
   +E6HU/kfPAPV6gw/BU+AKWL2uiOQ+ektuUJCsFyJUq1tgAvkDdr7fpTKN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307443070"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="307443070"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 18:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="696468504"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2022 18:43:33 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCul3-000Lzq-1S; Thu, 27 Jan 2022 02:43:33 +0000
Date:   Thu, 27 Jan 2022 10:42:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm32-ftrace-fixes 41/50] WARNING: modpost:
 vmlinux.o(.text+0x3aec0): Section mismatch in reference from the function
 ftrace_make_call() to the function .init.text:ftrace_caller_from_init()
Message-ID: <202201271012.knG6huUI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm32-ftrace-fixes
head:   db81a4be9a228c6d728b5e10ada88553cc72a001
commit: 3266348765f2d19ca7605c25f50ee04fd4a5decf [41/50] ARM: ftrace: use trampolines to keep .init.text in branching range
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201271012.knG6huUI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=3266348765f2d19ca7605c25f50ee04fd4a5decf
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm32-ftrace-fixes
        git checkout 3266348765f2d19ca7605c25f50ee04fd4a5decf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x3aec0): Section mismatch in reference from the function ftrace_make_call() to the function .init.text:ftrace_caller_from_init()
The function ftrace_make_call() references
the function __init ftrace_caller_from_init().
This is often because ftrace_make_call lacks a __init
annotation or the annotation of ftrace_caller_from_init is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3aec4): Section mismatch in reference from the function ftrace_make_call() to the function .init.text:ftrace_regs_caller_from_init()
The function ftrace_make_call() references
the function __init ftrace_regs_caller_from_init().
This is often because ftrace_make_call lacks a __init
annotation or the annotation of ftrace_regs_caller_from_init is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3b178): Section mismatch in reference from the function ftrace_modify_call() to the function .init.text:ftrace_caller_from_init()
The function ftrace_modify_call() references
the function __init ftrace_caller_from_init().
This is often because ftrace_modify_call lacks a __init
annotation or the annotation of ftrace_caller_from_init is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3b17c): Section mismatch in reference from the function ftrace_modify_call() to the function .init.text:ftrace_regs_caller_from_init()
The function ftrace_modify_call() references
the function __init ftrace_regs_caller_from_init().
This is often because ftrace_modify_call lacks a __init
annotation or the annotation of ftrace_regs_caller_from_init is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3b484): Section mismatch in reference from the function ftrace_make_nop() to the function .init.text:ftrace_caller_from_init()
The function ftrace_make_nop() references
the function __init ftrace_caller_from_init().
This is often because ftrace_make_nop lacks a __init
annotation or the annotation of ftrace_caller_from_init is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3b488): Section mismatch in reference from the function ftrace_make_nop() to the function .init.text:ftrace_regs_caller_from_init()
The function ftrace_make_nop() references
the function __init ftrace_regs_caller_from_init().
This is often because ftrace_make_nop lacks a __init
annotation or the annotation of ftrace_regs_caller_from_init is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
