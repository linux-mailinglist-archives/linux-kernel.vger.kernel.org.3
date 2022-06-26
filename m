Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2555D55B456
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiFZWfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFZWe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:34:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F82DDE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656282895; x=1687818895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VuQ8SAN2v4p+N7GX5Ni+shsp+WCkuv4B5DPGkSSD/jY=;
  b=WjjHX/7QRv+MbYfXmgt0kBENO6xRW91iBAK2gZENkC3Iw/msjnlpF7G0
   CBfGpvp1MW3sNohL2zwxLL+qjh8dRzS02xhBkTvNm70UCZFuq2gpZjpcN
   gO/3asWrW5stjbDpZlrY6GPDm+6bnXXjWe3X2xjtDAvz1Z828vVCnpeFZ
   0VWe7cXWbeHbGQTr9HO0ZOdHvWanHQPnH0QNFE5IYaDTh4va+WHZsUOj5
   okcWlJK4z7TkZiQ4yYo3oGCsRNNCWhKKypX9Vaq45YgeXnArKlH3uxB5D
   qjQ8u531foeR3oIPFrN1Oiq1GPfAAVx4b1qHtNbomYhi8UWVYNzFuZbWT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="367631479"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="367631479"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 15:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="732060615"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2022 15:34:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5aqA-0007u6-UB;
        Sun, 26 Jun 2022 22:34:50 +0000
Date:   Mon, 27 Jun 2022 06:34:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <202206270617.4pI23V1L-lkp@intel.com>
References: <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Eric,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v5.19-rc3]
[cannot apply to linux/master next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-W-Biederman/kthread-Remove-the-flags-argument-from-kernel_thread/20220627-041557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: x86_64-randconfig-a012
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b0d6dd3905db145853c7c744ac92d49b00b1fa20)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/950f4922fa2aef3d2e68b4b2ab728c6945830991
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-W-Biederman/kthread-Remove-the-flags-argument-from-kernel_thread/20220627-041557
        git checkout 950f4922fa2aef3d2e68b4b2ab728c6945830991
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "wake_up_new_task" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "wake_up_new_task" [fs/nfs/nfsv4.ko] undefined!
>> ERROR: modpost: "wake_up_new_task" [fs/ext4/ext4.ko] undefined!
>> ERROR: modpost: "wake_up_new_task" [fs/jbd2/jbd2.ko] undefined!
>> ERROR: modpost: "wake_up_new_task" [fs/ecryptfs/ecryptfs.ko] undefined!
ERROR: modpost: "wake_up_new_task" [fs/cifs/cifs.ko] undefined!
>> ERROR: modpost: "wake_up_new_task" [fs/nilfs2/nilfs2.ko] undefined!
>> ERROR: modpost: "wake_up_new_task" [fs/gfs2/gfs2.ko] undefined!
>> ERROR: modpost: "wake_up_new_task" [fs/f2fs/f2fs.ko] undefined!
>> ERROR: modpost: "wake_up_new_task" [drivers/char/ipmi/ipmi_si.ko] undefined!
WARNING: modpost: suppressed 30 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
