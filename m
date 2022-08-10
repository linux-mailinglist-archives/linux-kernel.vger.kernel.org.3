Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056DB58F3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiHJVyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHJVyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:54:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192F80507;
        Wed, 10 Aug 2022 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660168451; x=1691704451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DBd6Xw4ZxzcA53CQMZccIUfpCOANfwB8yn17vPxFfec=;
  b=avsK4Xo6w/xJCITu1wUYQpg+9oSZMPVCkNUJV48QmZVUbTXINFiQ4kvS
   8PWV+RYhtpL4sjmBxSjyQ+L2n6kOI/Yk4JOxdjq3KjkPFHTRyhlc2+l9F
   o/hk4b24YpTLnpvWHFpjgWrYEzt/fev38iObyW5ytnqhKOWT1Q0K/DLi0
   uQutc67mjrNYeJniOp9XYBwjWhGIh6oRGec5X0FkkunEEB7yrEHUzyo/7
   Yz+1JhbHNpeWVNGe0kbeUhL8c4hvbatpCAFQcdze/KLCew2z+ANbTw4uP
   ZCGckrit4zPEkyI22n2mCR/sz9E/NaUXrcYf7Hp0Pz6v9LDfwuyLwwONB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="317159294"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="317159294"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 14:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="605311355"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2022 14:54:08 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLteR-0000lh-2u;
        Wed, 10 Aug 2022 21:54:07 +0000
Date:   Thu, 11 Aug 2022 05:54:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] capabilities: new kernel.ns_modules_allowed sysctl
Message-ID: <202208110524.fN5PNDSo-lkp@intel.com>
References: <20220809185229.28417-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809185229.28417-1-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vegard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on v5.19]
[cannot apply to linus/master next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vegard-Nossum/capabilities-new-kernel-ns_modules_allowed-sysctl/20220810-031142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: arm64-buildonly-randconfig-r006-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110524.fN5PNDSo-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/bd78b69455d4b3cac70812bf23a27de310e813cd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vegard-Nossum/capabilities-new-kernel-ns_modules_allowed-sysctl/20220810-031142
        git checkout bd78b69455d4b3cac70812bf23a27de310e813cd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/kmod.c:213:2: error: call to undeclared function 'register_sysctl_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           register_sysctl_init("kernel", kmod_sysctl_table);
           ^
   1 error generated.


vim +/register_sysctl_init +213 kernel/kmod.c

   210	
   211	static int __init kmod_sysctl_init(void)
   212	{
 > 213		register_sysctl_init("kernel", kmod_sysctl_table);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
