Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD347B1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhLTRNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:13:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:22718 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233139AbhLTRNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640020395; x=1671556395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vToeTI38IdDhGDgTMTpVNHax1R+3ZoTBWmBgfGy3dMg=;
  b=ToTHt42ATTCa/AClIQSIy5x7D0VgITaN/5LAMYBm6eUW8yhQXDKzVr9n
   peEdgdDvnU4s8S/X88yAGQrYpEn8DTdtEO1T/H9exi/4yTZ5XkdJZfjTP
   70MPABiYeaRn5hGTH82jaET72P9H4ccubJy/feJg/RdFUhBpyRaNQ9B/S
   +I75QRJebZGbf45jxkg6E5sikPfz+/qUWJyZOSw6QMOsJCiMFehJ28Ypi
   m5LvPqGuhZ+dov04CLPzEp18RagBjXSwQ7mm+j+x3lVVcnZT1MZBFaSMa
   iktO+iGIZlA94eRU9Cu5jaLw3rCrmG6vTAm3h7ldDoEJgqu9P04BQie2F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="264411595"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="264411595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 09:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="467468280"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2021 09:13:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzMDp-00081p-Hh; Mon, 20 Dec 2021 17:13:13 +0000
Date:   Tue, 21 Dec 2021 01:12:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x2c44): Section mismatch
 in reference from the function trace_define_generic_fields() to the variable
 .init.data:initcall_level_names
Message-ID: <202112210114.CFpCHRci-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a7904a538933c525096ca2ccde1e60d0ee62c08e
commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
date:   3 weeks ago
config: xtensa-randconfig-r005-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210114.CFpCHRci-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a55f224ff5f238013de8762c4287117e47b86e22
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a55f224ff5f238013de8762c4287117e47b86e22
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text.unlikely+0x2c44): Section mismatch in reference from the function trace_define_generic_fields() to the variable .init.data:initcall_level_names
The function trace_define_generic_fields() references
the variable __initdata initcall_level_names.
This is often because trace_define_generic_fields lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xb451e8): Section mismatch in reference from the function sonic_get_stats() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0xb4524e): Section mismatch in reference from the function xtsonic_probe() to the function .init.text:sonic_probe1()
<< WARNING: modpost: vmlinux.o(.text.unlikely+0x2a8c): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
