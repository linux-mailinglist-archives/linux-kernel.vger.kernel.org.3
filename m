Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9450CE12
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 02:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiDXAED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 20:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiDXAEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 20:04:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE724979
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650758461; x=1682294461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0vV2vCN2rMFvugaf0x3OEAD+At1B20d2LF2+PMimzUE=;
  b=Ct6Hga85abQqfTkztO7aeCsze0ktGS0iw+TjHcuD5arJdptN72zIO+kR
   Zvnnv3HpyIvJVq7yW5NfqaDCTt3OVbD3bCgEuoslxo7C+eDR5JZ1BNHAU
   Lja7xFHcuARdIHytotweHJqIC3qiqJnTHp3T5TYY7ENLpYB17DSNIP3Xy
   9Eu7MbqzMJ8WRrbUeDvazYyfvNuXoDJBG1KNc7nS6I/7ppeLpBDlwYfRL
   XgsIzDF1iAlU8AfS+xqbchUNuSRFR2oR5+lWRh7oPJpcfv6V6izyhRNkR
   FFyRJefD+kBbV7RpjZkE5IvLEfieUBsupBaF0Ndmatk6ZN6/bJC7hCr2T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="265136059"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="265136059"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 17:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="563563630"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Apr 2022 17:01:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niPgR-0000k1-UH;
        Sun, 24 Apr 2022 00:00:59 +0000
Date:   Sun, 24 Apr 2022 08:00:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x1338): Section mismatch
 in reference from the function trace_define_generic_fields.isra.0() to the
 variable .init.data:initcall_level_names
Message-ID: <202204240728.DzSAdKzG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13bc32bad7059d6c5671e9d037e6e3ed001cc0f4
commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
date:   5 months ago
config: xtensa-randconfig-r002-20220424 (https://download.01.org/0day-ci/archive/20220424/202204240728.DzSAdKzG-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a55f224ff5f238013de8762c4287117e47b86e22
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a55f224ff5f238013de8762c4287117e47b86e22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x1198): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x1338): Section mismatch in reference from the function trace_define_generic_fields.isra.0() to the variable .init.data:initcall_level_names
The function trace_define_generic_fields.isra.0() references
the variable __initdata initcall_level_names.
This is often because trace_define_generic_fields.isra.0 lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
