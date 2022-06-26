Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0283855B44B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiFZWO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFZWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:14:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075A32DD1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656281694; x=1687817694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wLccQMLwY2fB0SXu3qL5u/32rkaqJ+CtYrHznQZNvRo=;
  b=H86qkqOp24r14ZaXT0UYj/fHRRPV1Ncgmr9XYgTIJfhZXB370KfPxflQ
   uaOyl84kJUv5zwycsEXLTqoMMnmOjDAoTXzXE2+ns6MVZ++LjfYAo9ahO
   dwfJPg+U097xbXSnfmsc6WTSG/ZgTvPiycekPzeZVYnabmWUxYA0/n1Oa
   ELSj4PK/pyoMQczCDgFTjQnWQo8kr6zuNKJ4Z8uwyd9h84JTfHjRwQzP+
   1rAvQUjq2Jv7MJ28/k1o0Ha9yMglH6C1ZQIKcdAaYrYFQDlhl7OAgs3t+
   SPqSEjpk8CF04lFfPkQKgU3IAMVVgMR8UjAS4VsD81tg0/tuA1BddtyCE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="280076992"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="280076992"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 15:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="594037869"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2022 15:14:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5aWn-0007sz-U5;
        Sun, 26 Jun 2022 22:14:49 +0000
Date:   Mon, 27 Jun 2022 06:14:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <202206270616.HYV83sCN-lkp@intel.com>
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
config: x86_64-randconfig-a013
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/950f4922fa2aef3d2e68b4b2ab728c6945830991
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eric-W-Biederman/kthread-Remove-the-flags-argument-from-kernel_thread/20220627-041557
        git checkout 950f4922fa2aef3d2e68b4b2ab728c6945830991
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "wake_up_new_task" [kernel/rcu/rcutorture.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
