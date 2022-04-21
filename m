Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B023F509838
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385101AbiDUGsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385406AbiDUGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0173C5F94
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523494; x=1682059494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kc6s8dd1+HLB+KL8Kkrto9nNijww6qnyOdaCsWjKnao=;
  b=SihQndiqRo4GkB5etcvqXBqUWDeoM1dAUSd/MN58KTMvWo4qN0z69G1a
   zWARCpNLIluhZTSlRyfgBptq9M22okmSmnGUh2kGP8iKla2mkzino3sXu
   s7XzC+ewUj5gW4yFrVM30YLjLLPT4zUtwUEGxkWJIrxJmXJdOIMPCuIs9
   KiQ/m4gCq+uMmaA02l/H5YglRzC2HROy31M6XNng0zS+ZhDT4O00aQwBO
   l19CKssigH9bTlQvqwPdXuIPCgST6xFalo5UX9u2XazM6PT+cmhqa7xcX
   NQyF7wyQXOiRgrKT0R0P89X4MrVUEqTMjAdsb7EMQlMNGtK9JrpQUN0Gc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="261857752"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="261857752"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="626388019"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-00081h-CV;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:44:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.data+0x2577cc): Section mismatch in
 reference from the variable sensor_dev_attr_pwm1_auto_point1_pwm to the
 function .init.text:set_reset_devices()
Message-ID: <202204211056.HP6rQw0u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: f334f5668bedf7307f6df1d98b14f55902931926 ilog2: force inlining of __ilog2_u32() and __ilog2_u64()
date:   4 weeks ago
config: riscv-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220421/202204211056.HP6rQw0u-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f334f5668bedf7307f6df1d98b14f55902931926
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f334f5668bedf7307f6df1d98b14f55902931926
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.data+0x2577cc): Section mismatch in reference from the variable sensor_dev_attr_pwm1_auto_point1_pwm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_pwm1_auto_point1_pwm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x25782c): Section mismatch in reference from the variable sensor_dev_attr_pwm1_auto_point2_pwm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_pwm1_auto_point2_pwm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x25788c): Section mismatch in reference from the variable sensor_dev_attr_pwm1_auto_point3_pwm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_pwm1_auto_point3_pwm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x2578ec): Section mismatch in reference from the variable sensor_dev_attr_pwm1_auto_point4_pwm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_pwm1_auto_point4_pwm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x2a05dc): Section mismatch in reference from the variable dev_attr_active to the function .init.text:set_reset_devices()
The variable dev_attr_active references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x2a80b8): Section mismatch in reference from the variable vlan_ioctl_mutex to the function .init.text:loglevel()
The variable vlan_ioctl_mutex references
the function __init loglevel()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x2a80c0): Section mismatch in reference from the variable vlan_ioctl_mutex to the function .init.text:set_reset_devices()
The variable vlan_ioctl_mutex references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x24042c): Section mismatch in reference from the variable sensor_dev_attr_fan3_beep to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_fan3_beep references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x240488): Section mismatch in reference from the variable sensor_dev_attr_temp3_max_hyst to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_temp3_max_hyst references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x2404cc): Section mismatch in reference from the variable sensor_dev_attr_temp3_beep to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_temp3_beep references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x2407f8): Section mismatch in reference from the variable sensor_dev_attr_in2_beep to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_in2_beep references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x21db7c): Section mismatch in reference from the variable sony_btf_mpx_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x225a30): Section mismatch in reference from the variable trace_event_fields_v4l2_event_class to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x24183c): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:loglevel()
<< WARNING: modpost: vmlinux.o(.data+0x241844): Section mismatch in reference from the variable watchdog_data_mutex to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2447c0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB6_6
<< WARNING: modpost: vmlinux.o(.data+0x2447e0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x244820): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_range()
<< WARNING: modpost: vmlinux.o(.data+0x2449c0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_isolate_range()
<< WARNING: modpost: vmlinux.o(.data+0x244ac0): Section mismatch in reference from the variable w83795_in to the function .meminit.text:memblock_remove_region()
<< WARNING: modpost: vmlinux.o(.data+0x244de0): Section mismatch in reference from the variable w83795_in to the variable .meminit.text:.LBB9_3

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
