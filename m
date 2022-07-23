Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCB57F1BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiGWV3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGWV3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:29:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F619024
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658611793; x=1690147793;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zgM+lhuBjoJ4r+JAvRf5ba81EGwGo6n9AFaZE5Nm1rA=;
  b=KN4XLHLxhM6vM7MhRk//kl+Qdc8A7KlyWWuPEMspzBQPy/DlxgXvT+gT
   mYSy/UvnRBsZx7KE1LkQzNoyYBbgKoIQcrd5uZDTTyYUzIiMIbASiydCC
   d689Ni2KeG9w465c0lLFwP6K36xD6FdBQXGrZC2BNu7dHfGRnCvW+d6Ty
   pvpOc4kj0gj2CN6LMgNOEJ2CA54UqCrORHRNuuICzkATb9B9L86gtU7KE
   Oe6p54BvoWKCV6KHHxKZLDpaHJXeCjNqv3pUjBJBSjFTf+WaRjmHFTnm9
   VpnYGpGj4Q0DMtaC5DkSb4iNvx5Sa2xfsQ7TPLgKg3l7Tp//w6FIYATgE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288675066"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="288675066"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 14:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="549540281"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Jul 2022 14:29:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFMh5-000393-10;
        Sat, 23 Jul 2022 21:29:51 +0000
Date:   Sun, 24 Jul 2022 05:29:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x1998): Section mismatch
 in reference from the function trace_define_generic_fields.isra.0() to the
 variable .init.data:initcall_level_names
Message-ID: <202207240538.J7vypIlv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
date:   8 months ago
config: xtensa-randconfig-c023-20220722 (https://download.01.org/0day-ci/archive/20220724/202207240538.J7vypIlv-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a55f224ff5f238013de8762c4287117e47b86e22
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a55f224ff5f238013de8762c4287117e47b86e22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x17c8): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x1998): Section mismatch in reference from the function trace_define_generic_fields.isra.0() to the variable .init.data:initcall_level_names
The function trace_define_generic_fields.isra.0() references
the variable __initdata initcall_level_names.
This is often because trace_define_generic_fields.isra.0 lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
