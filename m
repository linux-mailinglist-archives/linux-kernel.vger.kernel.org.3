Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A99483BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiADF2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:28:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:20066 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbiADF2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641274114; x=1672810114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jR4G5QiHtyexyPM04IhixjSfmbgt0+Tr4sLEcSX7iq0=;
  b=PHIj3oTFk9ptH76/AYcJ5ZdiwYyjRDrzRvcSYoiWXTKCPeIeky7PM6p8
   1hWYxVBkSwEOxqyScvyog7/7uRmcmCf1FKiQy/jvsHET76S3qJJ4bwb+6
   pO7vSzfXSU67aGopxrhlWjyk6iVFvaly7X+UqC+BTvbg5NJDWlU4RLyz+
   6dq1VsvVFGEuA7VEIlYzuDl0gNtfWcIJt/trzOToqrqKjd3HsQRFfhjcU
   C2LyHJH28idlL0HejMq+g3/J4SDnOvRjR5S86eMbElJnmica/1kIKUiXr
   wpuuqhn9EJrh9/AFlsG3FKFLw7vOq852sMNT7EpUzwEAWayHHoZfSLq7O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242114612"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="242114612"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 21:28:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="470042545"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2022 21:28:28 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4cN1-000Enk-CQ; Tue, 04 Jan 2022 05:28:27 +0000
Date:   Tue, 4 Jan 2022 13:28:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     kbuild-all@lists.01.org,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH v1] ipc: Store mqueue sysctls in the ipc namespace
Message-ID: <202201041311.fGbv03Y7-lkp@intel.com>
References: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on hnaz-mm/master linus/master v5.16-rc8 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alexey-Gladkov/ipc-Store-mqueue-sysctls-in-the-ipc-namespace/20220104-000523
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 136057256686de39cc3a07c2e39ef6bc43003ff6
config: microblaze-buildonly-randconfig-r003-20220103 (https://download.01.org/0day-ci/archive/20220104/202201041311.fGbv03Y7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/637324916f39ec562ac383bfbc22ee9fcbfcb1c0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alexey-Gladkov/ipc-Store-mqueue-sysctls-in-the-ipc-namespace/20220104-000523
        git checkout 637324916f39ec562ac383bfbc22ee9fcbfcb1c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: ipc/mqueue.o: in function `init_mqueue_fs':
>> (.init.text+0x4c): undefined reference to `setup_mq_sysctls'
   microblaze-linux-ld: ipc/namespace.o: in function `free_ipc':
>> (.text+0x294): undefined reference to `retire_mq_sysctls'
   microblaze-linux-ld: ipc/namespace.o: in function `copy_ipcs':
>> (.text+0x1114): undefined reference to `setup_mq_sysctls'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
