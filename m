Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A3E46BD17
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhLGOCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:02:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:49680 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232830AbhLGOCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:02:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="236314854"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="236314854"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 05:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="679449341"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2021 05:58:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muazg-000Mdz-NQ; Tue, 07 Dec 2021 13:58:56 +0000
Date:   Tue, 7 Dec 2021 21:58:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 1/2] kobject: don't delay to cleanup module kobject
Message-ID: <202112072131.XiIJR8RS-lkp@intel.com>
References: <20211129034509.2646872-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129034509.2646872-2-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on v5.16-rc4 next-20211207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lei/kobject-avoid-to-cleanup-kobject-after-module-is-unloaded/20211129-114940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 2043727c2882928a10161ddee52b196b7db402fd
config: s390-randconfig-r033-20211207 (https://download.01.org/0day-ci/archive/20211207/202112072131.XiIJR8RS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/39e48129051282ab6eff0746002e84cf56218bd7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ming-Lei/kobject-avoid-to-cleanup-kobject-after-module-is-unloaded/20211129-114940
        git checkout 39e48129051282ab6eff0746002e84cf56218bd7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/kobject.c: In function 'kobject_release':
>> lib/kobject.c:741:29: error: 'module_ktype' undeclared (first use in this function); did you mean 'module_state'?
     741 |         if (kobj->ktype == &module_ktype)
         |                             ^~~~~~~~~~~~
         |                             module_state
   lib/kobject.c:741:29: note: each undeclared identifier is reported only once for each function it appears in


vim +741 lib/kobject.c

   725	
   726	static void kobject_release(struct kref *kref)
   727	{
   728		struct kobject *kobj = container_of(kref, struct kobject, kref);
   729	#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
   730		unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
   731	
   732		/*
   733		 * Don't delay to release module kobject so that we can detect late
   734		 * kobject release more effectively because module unloading waits
   735		 * for completion of module kobject release, see mod_kobject_put.
   736		 *
   737		 * Meantime mod_kobject_put() always waits for completion of module
   738		 * kobject's release, CONFIG_DEBUG_KOBJECT_RELEASE is basically
   739		 * useless for debugging module kobject's release.
   740		 */
 > 741		if (kobj->ktype == &module_ktype)
   742			delay = 0;
   743	
   744		pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
   745			 kobject_name(kobj), kobj, __func__, kobj->parent, delay);
   746		INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
   747	
   748		schedule_delayed_work(&kobj->release, delay);
   749	#else
   750		kobject_cleanup(kobj);
   751	#endif
   752	}
   753	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
