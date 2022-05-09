Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6951F268
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiEIBbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiEIA3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:29:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6AA38BB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652055942; x=1683591942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OUEknFDLJeAvSeW9n8FIyps4Ij7FIBWP60EB+06gXqY=;
  b=F7A9HHNUfnPQ3S7e8TYAr3Am9mzW1z0MO0BrFntUUrD8IoamtyBM5JIc
   Fp+ClLQacTFzDm6MFihUz753j2VK/Z3lj2EVXZVQ3vpGOz0LkERaPFV/m
   uk7Iclhz89akA0g5PAXnpNWmIKBLXhWwN90Hu4t1viHe73HoBcIint/rR
   yHvL90QR8w9MMp0uraJwZaIeWlyaZltY5NFHmBqO5jRUwnWxvPpzQhixt
   ktiAWjXnJZA+vt52Iqk7QCKJ+ZEnfySKPw5V8PuYcFAqmKvuypsvc2ucH
   tnNVLTHHthVhD49LDAyAtDUOCK62ZcOlxBnUm/uBYjD7lq2iBLo1M52un
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="331922839"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="331922839"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 17:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="655810063"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2022 17:25:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnrDY-000Fyo-4c;
        Mon, 09 May 2022 00:25:40 +0000
Date:   Mon, 9 May 2022 08:25:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <202205090835.NEUQ3VKB-lkp@intel.com>
References: <20220508200755.24586-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508200755.24586-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Fabio,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/fs-ufs-Replace-kmap-with-kmap_local_page/20220509-040920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e3de3a1cda5fdc3ac42cb0d45321fb254500595f
config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205090835.NEUQ3VKB-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e73d9919e2725b216318d5d02b8a184876ab3b11
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Fabio-M-De-Francesco/fs-ufs-Replace-kmap-with-kmap_local_page/20220509-040920
        git checkout e73d9919e2725b216318d5d02b8a184876ab3b11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xa76c20): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.LVL13
The function rtc_update_irq() references
the variable __init .LVL13.
This is often because rtc_update_irq lacks a __init
annotation or the annotation of .LVL13 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xb35ab4): Section mismatch in reference from the function btintel_send_intel_reset() to the variable .init.text:.LBE19058
The function btintel_send_intel_reset() references
the variable __init .LBE19058.
This is often because btintel_send_intel_reset lacks a __init
annotation or the annotation of .LBE19058 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xc53984): Section mismatch in reference from the function neigh_table_clear() to the variable .init.text:$x
The function neigh_table_clear() references
the variable __init $x.
This is often because neigh_table_clear lacks a __init
annotation or the annotation of $x is wrong.
--
>> WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF936
FATAL: modpost: extable_entry size hasn't been discovered!

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in reference from the function rproc_exit_sysfs() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1567
<< WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in reference from the function rtc_get_dev_attribute_groups() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in reference from the function ir_raw_get_allowed_protocols() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in reference from the function ir_raw_event_prepare() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in reference from the function ir_raw_event_free() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in reference from the function ir_raw_event_unregister() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB19521
<< WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in reference from the function rproc_exit_sysfs() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1567
<< WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in reference from the function rtc_get_dev_attribute_groups() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in reference from the function ir_raw_get_allowed_protocols() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in reference from the function ir_raw_event_prepare() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in reference from the function ir_raw_event_free() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in reference from the function ir_raw_event_unregister() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB19521
<< WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in reference from the function rproc_exit_sysfs() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1567
<< WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in reference from the function rtc_get_dev_attribute_groups() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in reference from the function ir_raw_get_allowed_protocols() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in reference from the function ir_raw_event_prepare() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in reference from the function ir_raw_event_free() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in reference from the function ir_raw_event_unregister() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB19521
<< WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in reference from the function rproc_exit_sysfs() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1567
<< WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in reference from the function rtc_get_dev_attribute_groups() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in reference from the function ir_raw_get_allowed_protocols() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in reference from the function ir_raw_event_prepare() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in reference from the function ir_raw_event_free() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in reference from the function ir_raw_event_unregister() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB19521

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
