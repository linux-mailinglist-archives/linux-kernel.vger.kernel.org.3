Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA74688CE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 02:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhLEBFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 20:05:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:58442 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhLEBFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 20:05:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="235889501"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="235889501"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 17:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="562160145"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2021 17:02:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtfuo-000Jdh-D2; Sun, 05 Dec 2021 01:02:06 +0000
Date:   Sun, 5 Dec 2021 09:02:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>
Subject: security/landlock/syscalls.c:150:1: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202112050805.TutbZVeE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23b55d673d7527b093cd97b7c217c82e70cd1af0
commit: 265885daf3e5082eb9f6e2a23bdbf9ba4456a21b landlock: Add syscall implementations
date:   8 months ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211205/202112050805.TutbZVeE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=265885daf3e5082eb9f6e2a23bdbf9ba4456a21b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 265885daf3e5082eb9f6e2a23bdbf9ba4456a21b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> security/landlock/syscalls.c:150:1: sparse: sparse: Using plain integer as NULL pointer
>> security/landlock/syscalls.c:150:1: sparse: sparse: Using plain integer as NULL pointer
   security/landlock/syscalls.c:295:1: sparse: sparse: Using plain integer as NULL pointer
   security/landlock/syscalls.c:295:1: sparse: sparse: Using plain integer as NULL pointer

vim +150 security/landlock/syscalls.c

   130	
   131	/**
   132	 * sys_landlock_create_ruleset - Create a new ruleset
   133	 *
   134	 * @attr: Pointer to a &struct landlock_ruleset_attr identifying the scope of
   135	 *        the new ruleset.
   136	 * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
   137	 *        backward and forward compatibility).
   138	 * @flags: Must be 0.
   139	 *
   140	 * This system call enables to create a new Landlock ruleset, and returns the
   141	 * related file descriptor on success.
   142	 *
   143	 * Possible returned errors are:
   144	 *
   145	 * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
   146	 * - EINVAL: @flags is not 0, or unknown access, or too small @size;
   147	 * - E2BIG or EFAULT: @attr or @size inconsistencies;
   148	 * - ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
   149	 */
 > 150	SYSCALL_DEFINE3(landlock_create_ruleset,
   151			const struct landlock_ruleset_attr __user *const, attr,
   152			const size_t, size, const __u32, flags)
   153	{
   154		struct landlock_ruleset_attr ruleset_attr;
   155		struct landlock_ruleset *ruleset;
   156		int err, ruleset_fd;
   157	
   158		/* Build-time checks. */
   159		build_check_abi();
   160	
   161		if (!landlock_initialized)
   162			return -EOPNOTSUPP;
   163	
   164		/* No flag for now. */
   165		if (flags)
   166			return -EINVAL;
   167	
   168		/* Copies raw user space buffer. */
   169		err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
   170				offsetofend(typeof(ruleset_attr), handled_access_fs),
   171				attr, size);
   172		if (err)
   173			return err;
   174	
   175		/* Checks content (and 32-bits cast). */
   176		if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
   177				LANDLOCK_MASK_ACCESS_FS)
   178			return -EINVAL;
   179	
   180		/* Checks arguments and transforms to kernel struct. */
   181		ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs);
   182		if (IS_ERR(ruleset))
   183			return PTR_ERR(ruleset);
   184	
   185		/* Creates anonymous FD referring to the ruleset. */
   186		ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
   187				ruleset, O_RDWR | O_CLOEXEC);
   188		if (ruleset_fd < 0)
   189			landlock_put_ruleset(ruleset);
   190		return ruleset_fd;
   191	}
   192	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
