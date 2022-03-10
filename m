Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54344D3E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiCJAgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbiCJAgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:36:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EABFFDFA6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646872553; x=1678408553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4c5cbHZGG2HhzXo93CXNIjzewjIojCUGpdScSsBCp3w=;
  b=Yzy0ZvLz/ysAbkddyQgy0jCsJIsd8w9aMm6sMTRgslcZz/hzZLkmo4oM
   KbTYxfowOpfK6tmPq8sKckw3W7qgyFB/kxYJbfua+mxV5qxCl1qkbxqFM
   4/g9TGXpMkCICq+e8VJlYDwad+qIXto/Xc+vRflI/3mq03O9SvSOTlu92
   uVlgEkaCy/18NpJ3zo/2cfZSeWe67Tvt4BW3haLCBb1bto8BFOaGbicnX
   6oJ1C1grePJwdZsf7HZaT3yw0I9DPXql37mIovTg/ssd5bUPUvZSJjtlc
   MWBpDsA82uDcIDi8ARuQB3Y2B1EaA9lht7YMZDi5C4ugYB5/ynV8IzJVb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242568522"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="242568522"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:35:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="513757226"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 16:35:50 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS6mU-00043Y-5Z; Thu, 10 Mar 2022 00:35:50 +0000
Date:   Thu, 10 Mar 2022 08:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: <instantiation>:4:2: error: invalid fixup for movz/movk instruction
Message-ID: <202203100800.57nn24sm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 558c303c9734af5a813739cd284879227f7297d2 arm64: Mitigate spectre style branch history side channels
date:   13 days ago
config: arm64-randconfig-r013-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100800.57nn24sm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=558c303c9734af5a813739cd284879227f7297d2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 558c303c9734af5a813739cd284879227f7297d2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^
>> <instantiation>:4:2: error: invalid fixup for movz/movk instruction
    mov w0, #ARM_SMCCC_ARCH_WORKAROUND_3
    ^

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
