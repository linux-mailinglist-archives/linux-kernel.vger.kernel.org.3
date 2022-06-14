Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EB554A732
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiFNC5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354906AbiFNC5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:57:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2F3F30F;
        Mon, 13 Jun 2022 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655174892; x=1686710892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+StXMWyCAAfWauzjypvDNrcBxLtK9qkd7YfDFZsNWE=;
  b=Yf7u7lUlKYwFqfXWS8xWFHP//kh9jd0wRw+tO4IueSpzLIKJOaXgr5Mc
   VBI+9Ek873tHQ+sT9mKYKH+VXvhM7FZ7bN/3CYankQUxqZpb36G4G34cS
   kQ3iMhlOZkXx9kYuVOABAByXMXBB/RMMDFusJfRpD/bw1x5CCFPhADFwP
   qG47ZIlU8VowSZ6h9yNxLTmJUK6fRTMO0VfdbKcgSad1fbdAe9AfHPncE
   7C9RCjXy1VQbdpoNc5lQJCnmL/CYOAE0BcdwYC6x+mOmTTUMekJ/g57af
   OeDuFpjnyDxe3z201rC9FNHTV9FpYuZSXRnCIc3IiRnibfeC3aIoNF6My
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340151200"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="340151200"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="673618649"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2022 19:48:10 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0wbB-000LNr-JZ;
        Tue, 14 Jun 2022 02:48:09 +0000
Date:   Tue, 14 Jun 2022 10:48:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org
Cc:     kbuild-all@lists.01.org, keescook@chromium.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org,
        Micah Morton <mortonm@chromium.org>
Subject: Re: [PATCH 1/2] security: Add LSM hook to setgroups() syscall
Message-ID: <202206141053.xW4ze6oP-lkp@intel.com>
References: <20220613202807.447694-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613202807.447694-1-mortonm@chromium.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micah,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on jmorris-security/next-testing kees/for-next/pstore v5.19-rc2 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Micah-Morton/security-Add-LSM-hook-to-setgroups-syscall/20220614-050341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220614/202206141053.xW4ze6oP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b21cba6f759a2a60439de4d0f85323ed745b3ade
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Micah-Morton/security-Add-LSM-hook-to-setgroups-syscall/20220614-050341
        git checkout b21cba6f759a2a60439de4d0f85323ed745b3ade
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   kernel/groups.c: In function 'set_current_groups':
>> kernel/groups.c:143:13: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     143 |         old = current_cred();
         |             ^
>> kernel/groups.c:147:9: error: 'retval' undeclared (first use in this function)
     147 |         retval = security_task_fix_setgroups(new, old);
         |         ^~~~~~
   kernel/groups.c:147:9: note: each undeclared identifier is reported only once for each function it appears in


vim +/retval +147 kernel/groups.c

   126	
   127	/**
   128	 * set_current_groups - Change current's group subscription
   129	 * @group_info: The group list to impose
   130	 *
   131	 * Validate a group subscription and, if valid, impose it upon current's task
   132	 * security record.
   133	 */
   134	int set_current_groups(struct group_info *group_info)
   135	{
   136		struct cred *new;
   137		struct cred *old;
   138	
   139		new = prepare_creds();
   140		if (!new)
   141			return -ENOMEM;
   142	
 > 143		old = current_cred();
   144	
   145		set_groups(new, group_info);
   146	
 > 147		retval = security_task_fix_setgroups(new, old);
   148		if (retval < 0)
   149			goto error;
   150	
   151		return commit_creds(new);
   152	
   153	error:
   154		abort_creds(new);
   155		return retval;
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
