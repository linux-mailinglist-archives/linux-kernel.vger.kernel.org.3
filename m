Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A453D873
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiFDTnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiFDTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:43:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E62CC9C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654371832; x=1685907832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5wwe7msksOb8eGwfgGpFMTlpDtxWcUTXNlZi75NphNM=;
  b=KSWV7gyHZy8sMkeBfMvp+faXOkUI/tsZq9oWC0Oied5D80nF1mJQGifi
   HEBz8e2VxoXsjWM04U4boq+NjeiJr+Atxst7wZnMrWhZl/26Ut/mWjW6a
   KNzPp2Zo18Ztfqz4G0Qfmcd66BpCO0UoDyXiucJHZdQEWQtZXXUEPs+On
   34uXRsUxXZ/YViWMrP5HHusszf0EHyO2T6SS1X9tkC83ansY6d/nsczP+
   gyBObdCFRZ2KGa13WhXDPJB+vuQZOHdbvvt+7x2NsjbxvAvUKijTs0pXu
   sYMk1A/qF0SHOZ3J3P2fikwOL42UiEG3plQvDhC858ksCk98s0kpm16fx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="362833940"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="362833940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 12:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="668916486"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2022 12:43:51 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxZgc-000BAH-UK;
        Sat, 04 Jun 2022 19:43:50 +0000
Date:   Sun, 5 Jun 2022 03:43:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x4f50): Section mismatch
 in reference from the function trace_define_generic_fields() to the variable
 .init.data:initcall_level_names
Message-ID: <202206050340.YtS1dk5y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
date:   6 months ago
config: xtensa-randconfig-r021-20220604 (https://download.01.org/0day-ci/archive/20220605/202206050340.YtS1dk5y-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a55f224ff5f238013de8762c4287117e47b86e22
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a55f224ff5f238013de8762c4287117e47b86e22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x4c10): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x4f50): Section mismatch in reference from the function trace_define_generic_fields() to the variable .init.data:initcall_level_names
The function trace_define_generic_fields() references
the variable __initdata initcall_level_names.
This is often because trace_define_generic_fields lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
