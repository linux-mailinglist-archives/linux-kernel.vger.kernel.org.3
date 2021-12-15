Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D354E475F59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhLORar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:30:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:1275 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343539AbhLOR3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639589370; x=1671125370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/+kykrFi5tE8lT4IJWc0vDGuf0XL/PrAqltzuLLu8s=;
  b=DcNnW9+1GZ6kWuum3QG3ZOuS/qI0J0GkDN5DwbMLKqVfAjukzkatETTa
   L0xnpZBmS6rssMYrJNbjBeiUMZ+07NAVZWfYz5SY5Sv6fVHSDAK0e58rC
   I0TC/oCwi/h4PLseWPyW24WxPuE14hgIb6ncfp8hz7vKlKxB3RRxFOsdS
   0cswoHu8R4Ai+iKZ2GHdWVykx+HtFLCJt/CAtI4Fz62RWK72fHySMaUXR
   hpNEKWR4eWbEny6Mx3rTvVg9GGCR7Pndbot0mqT7aQ+fsPR6Xyqd7QK5V
   HqVea/Rt0u7Qhvc/i9JhuuMuJmmC8YAZdB0HVtNoVoAJgITTPPvpfECKP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238027370"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="238027370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 09:29:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="568000649"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2021 09:29:10 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxY5V-00027a-PA; Wed, 15 Dec 2021 17:29:09 +0000
Date:   Thu, 16 Dec 2021 01:28:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keno Fischer <keno@juliacomputing.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, gorcunov@openvz.org,
        khlebnikov@openvz.org, oleg@redhat.com, akpm@linux-foundation.org,
        keescook@chromium.org, tj@kernel.org, dbueso@suse.de,
        matthltc@us.ibm.com, kosaki.motohiro@jp.fujitsu.com
Subject: Re: [PATCH] c/r: prctl: Remove PR_SET_MM_EXE_FILE old file mapping
 restriction
Message-ID: <202112160112.oIvovVSv-lkp@intel.com>
References: <20211215062342.GA1548576@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215062342.GA1548576@juliacomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keno,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.16-rc5 next-20211214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Keno-Fischer/c-r-prctl-Remove-PR_SET_MM_EXE_FILE-old-file-mapping-restriction/20211215-142515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: arc-randconfig-s031-20211214 (https://download.01.org/0day-ci/archive/20211216/202112160112.oIvovVSv-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/08f30df401c936e27733e3b37765c2b7d35fe0e7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Keno-Fischer/c-r-prctl-Remove-PR_SET_MM_EXE_FILE-old-file-mapping-restriction/20211215-142515
        git checkout 08f30df401c936e27733e3b37765c2b7d35fe0e7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1215:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *_val_ @@     got struct file *new_exe_file @@
   kernel/fork.c:1215:24: sparse:     expected struct file [noderef] __rcu *_val_
   kernel/fork.c:1215:24: sparse:     got struct file *new_exe_file
>> kernel/fork.c:1215:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *old_exe_file @@     got struct file [noderef] __rcu *[assigned] _val_ @@
   kernel/fork.c:1215:22: sparse:     expected struct file *old_exe_file
   kernel/fork.c:1215:22: sparse:     got struct file [noderef] __rcu *[assigned] _val_
   kernel/fork.c:1572:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1572:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1572:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1581:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1581:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1581:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1582:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1582:36: sparse:     expected void const *
   kernel/fork.c:1582:36: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1583:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1583:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1583:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1995:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1995:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1995:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1999:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1999:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1999:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2304:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct *task @@
   kernel/fork.c:2304:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2304:32: sparse:     got struct task_struct *task
   kernel/fork.c:2313:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2313:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2313:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2362:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2362:54: sparse:     expected struct list_head *head
   kernel/fork.c:2362:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2383:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2383:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2383:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2401:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2401:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2401:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2428:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2428:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2428:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2456:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2456:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2456:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2458:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2458:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2458:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2867:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2867:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2867:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2948:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:2948:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:2948:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2039:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/arc/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:218:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:218:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:218:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:218:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:218:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:218:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2360:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2361:59: sparse: sparse: dereference of noderef expression

vim +1215 kernel/fork.c

3864601387cf41 Jiri Slaby        2011-05-26  1194  
35d7bdc86031a2 David Hildenbrand 2021-04-23  1195  /**
35d7bdc86031a2 David Hildenbrand 2021-04-23  1196   * replace_mm_exe_file - replace a reference to the mm's executable file
35d7bdc86031a2 David Hildenbrand 2021-04-23  1197   *
35d7bdc86031a2 David Hildenbrand 2021-04-23  1198   * This changes mm's executable file (shown as symlink /proc/[pid]/exe),
35d7bdc86031a2 David Hildenbrand 2021-04-23  1199   * dealing with concurrent invocation and without grabbing the mmap lock in
35d7bdc86031a2 David Hildenbrand 2021-04-23  1200   * write mode.
35d7bdc86031a2 David Hildenbrand 2021-04-23  1201   *
35d7bdc86031a2 David Hildenbrand 2021-04-23  1202   * Main user is sys_prctl(PR_SET_MM_MAP/EXE_FILE).
35d7bdc86031a2 David Hildenbrand 2021-04-23  1203   */
35d7bdc86031a2 David Hildenbrand 2021-04-23  1204  int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
35d7bdc86031a2 David Hildenbrand 2021-04-23  1205  {
35d7bdc86031a2 David Hildenbrand 2021-04-23  1206  	struct file *old_exe_file;
35d7bdc86031a2 David Hildenbrand 2021-04-23  1207  	int ret = 0;
35d7bdc86031a2 David Hildenbrand 2021-04-23  1208  
35d7bdc86031a2 David Hildenbrand 2021-04-23  1209  	/* set the new file, lockless */
fe69d560b5bd9e David Hildenbrand 2021-04-23  1210  	ret = deny_write_access(new_exe_file);
fe69d560b5bd9e David Hildenbrand 2021-04-23  1211  	if (ret)
fe69d560b5bd9e David Hildenbrand 2021-04-23  1212  		return -EACCES;
35d7bdc86031a2 David Hildenbrand 2021-04-23  1213  	get_file(new_exe_file);
fe69d560b5bd9e David Hildenbrand 2021-04-23  1214  
35d7bdc86031a2 David Hildenbrand 2021-04-23 @1215  	old_exe_file = xchg(&mm->exe_file, new_exe_file);
fe69d560b5bd9e David Hildenbrand 2021-04-23  1216  	if (old_exe_file) {
fe69d560b5bd9e David Hildenbrand 2021-04-23  1217  		/*
fe69d560b5bd9e David Hildenbrand 2021-04-23  1218  		 * Don't race with dup_mmap() getting the file and disallowing
fe69d560b5bd9e David Hildenbrand 2021-04-23  1219  		 * write access while someone might open the file writable.
fe69d560b5bd9e David Hildenbrand 2021-04-23  1220  		 */
fe69d560b5bd9e David Hildenbrand 2021-04-23  1221  		mmap_read_lock(mm);
fe69d560b5bd9e David Hildenbrand 2021-04-23  1222  		allow_write_access(old_exe_file);
35d7bdc86031a2 David Hildenbrand 2021-04-23  1223  		fput(old_exe_file);
fe69d560b5bd9e David Hildenbrand 2021-04-23  1224  		mmap_read_unlock(mm);
fe69d560b5bd9e David Hildenbrand 2021-04-23  1225  	}
35d7bdc86031a2 David Hildenbrand 2021-04-23  1226  	return 0;
35d7bdc86031a2 David Hildenbrand 2021-04-23  1227  }
3864601387cf41 Jiri Slaby        2011-05-26  1228  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
