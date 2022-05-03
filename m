Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9A51860E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiECOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiECOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:08:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD9D1EADD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651586687; x=1683122687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfu2gyz8tsmL8KmzuHOs9Hvc3SiLM/mU0vR0bwAU/nM=;
  b=NRaWtn3ipqyfv9k2C105D4w6FSzuaeVc5r1F/UH1jIsmcCzRlz/SHXdZ
   HB1Ibiw0FTJ5rMyFUR97iAGQy5v5bTvIW9H/fiRUgfifOXZVtBDQGiomL
   g0PKaRzyQDWEb+dQnx5Z88h2rlLCtdDdVq+UIx220GafFO7i+XWlpT+ka
   vmEqzZHUvBo/fakxonfj8f/kpwsVxJLpUGho9m8U3SXjFnJlYcLNg5jte
   PPAEHDtnCeXCXOKkOn8K6CRueuVBKhBi4HWjP5phnqi6hB9VVilEsl01K
   9LNo2CTm6YTPJceAFrB9ev6p+DR26FyEFyq3eBULrz6kslo71qkcW4PKn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353922919"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="353922919"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 07:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="692202842"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2022 07:04:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlt8u-000AWV-LM;
        Tue, 03 May 2022 14:04:44 +0000
Date:   Tue, 3 May 2022 22:04:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] audit: add call argument to socketcall auditing
Message-ID: <202205032153.9OyzkwPS-lkp@intel.com>
References: <20220503090212.1322050-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503090212.1322050-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on pcmoore-audit/next v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sven-Schnelle/audit-add-call-argument-to-socketcall-auditing/20220503-170442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9050ba3a61a4b5bd84c2cde092a100404f814f31
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220503/202205032153.9OyzkwPS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b89caaec1c1bd3382c6cef08d08beadbaf808513
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sven-Schnelle/audit-add-call-argument-to-socketcall-auditing/20220503-170442
        git checkout b89caaec1c1bd3382c6cef08d08beadbaf808513
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   net/compat.c: In function '__do_compat_sys_socketcall':
>> net/compat.c:440:49: warning: passing argument 2 of 'audit_socketcall_compat' makes pointer from integer without a cast [-Wint-conversion]
     440 |         ret = audit_socketcall_compat(call, len / sizeof(a[0]), a);
         |                                             ~~~~^~~~~~~~~~~~~~
         |                                                 |
         |                                                 long unsigned int
   In file included from net/compat.c:26:
   include/linux/audit.h:648:59: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'long unsigned int'
     648 | static inline int audit_socketcall_compat(int nargs, u32 *args)
         |                                                      ~~~~~^~~~
>> net/compat.c:440:15: error: too many arguments to function 'audit_socketcall_compat'
     440 |         ret = audit_socketcall_compat(call, len / sizeof(a[0]), a);
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/compat.c:26:
   include/linux/audit.h:648:19: note: declared here
     648 | static inline int audit_socketcall_compat(int nargs, u32 *args)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~


vim +/audit_socketcall_compat +440 net/compat.c

   423	
   424	COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
   425	{
   426		u32 a[AUDITSC_ARGS];
   427		unsigned int len;
   428		u32 a0, a1;
   429		int ret;
   430	
   431		if (call < SYS_SOCKET || call > SYS_SENDMMSG)
   432			return -EINVAL;
   433		len = nas[call];
   434		if (len > sizeof(a))
   435			return -EINVAL;
   436	
   437		if (copy_from_user(a, args, len))
   438			return -EFAULT;
   439	
 > 440		ret = audit_socketcall_compat(call, len / sizeof(a[0]), a);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
