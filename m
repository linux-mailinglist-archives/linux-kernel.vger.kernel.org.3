Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B04C8C02
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiCAMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiCAMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:52:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06CB986CB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646139122; x=1677675122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aADtTnJWVHxwFknU/D5Y7CVuuTsMmlWwrD2vCLZByJQ=;
  b=N9MHml9oqJqPHeChqK0N/+EWnvUsCgo8AVKeE6oIZ9NXX1ARUkC1nfaC
   jSDnt/CfYdDshfiZzH4MhWv5PZYd/i+PpfetHuojjxbRgM8/CL/0ZpzB9
   Nr/YG5rqOSvkk/baRTIQm9LVYD4/0gK/qbXOnCUhPljutJ4yXp/ImQGZr
   K0fddllIAemq66cSUeiisL7CoY9Jj53DivR4a4JUOzLGkJghZvayULfRx
   G9cEasgGyJTKToG/J47tHMWjEUDD/wqRI4ayDIe9MMdGWqiAxGxjpP3An
   UGZgIJ+rcUK0erFRxv/oXY7lFj06h53PkZKG9/RgiFx02df5FsA/JgAmk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233094165"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233094165"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 04:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="593583167"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2022 04:52:01 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP1yy-0000QV-I6; Tue, 01 Mar 2022 12:52:00 +0000
Date:   Tue, 1 Mar 2022 20:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0xeee4): Section mismatch
 in reference from the variable $c to the variable .init.data:bitmap
Message-ID: <202203012055.IdfbEDXo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   719fce7539cd3e186598e2aed36325fe892150cf
commit: 9248e52fec9536590852844b0634b5d20483c1ab locking/atomic: simplify non-atomic wrappers
date:   7 months ago
config: nds32-randconfig-r001-20220301 (https://download.01.org/0day-ci/archive/20220301/202203012055.IdfbEDXo-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9248e52fec9536590852844b0634b5d20483c1ab
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9248e52fec9536590852844b0634b5d20483c1ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text.unlikely+0xeee4): Section mismatch in reference from the variable $c to the variable .init.data:bitmap
The function $c() references
the variable __initdata bitmap.
This is often because $c lacks a __initdata
annotation or the annotation of bitmap is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
