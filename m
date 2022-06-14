Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E154AB30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353391AbiFNHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355423AbiFNHwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:52:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66B41F9E;
        Tue, 14 Jun 2022 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655193089; x=1686729089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJhpZ3HQ+EYM455wRZmEEJVkLQgK5F2p4nazZFlQj4I=;
  b=TLcfRD2gfrVOyq5yBbZoJW6fJ4nuRA8Cab4GAOqil1cCwn6EzfIeAe9W
   Mp6CQN57s88QTZ9Vj5tr8+dADF802/j+KS8PlIe0INuk/XOQPYw5M9bfZ
   55jB7X7WURHPubK16BNnWMXARQaFm4p7UZqZTNAOztD7RwpESx/u2L1HP
   //DxgFk3W6CbuVSDiXYP1DYSzsd3P3HWDg9oOaTPUQiMukoQO/hfRVaDj
   zLnJjVeBT9VLZTzxnjcneBqnMbXpmCwy/SyBSF0epvCYS1D6MG2HuMG67
   1wTwU+rOqSEI6YlPswSkGqIfZQjXDcSi1eMxFkSBg8edEEdUJszpbp2/F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267229655"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="267229655"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="673745017"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 00:51:20 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o11KZ-000LdF-Kk;
        Tue, 14 Jun 2022 07:51:19 +0000
Date:   Tue, 14 Jun 2022 15:50:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy
 handling
Message-ID: <202206141555.zswTLROZ-lkp@intel.com>
References: <20220613202852.447738-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613202852.447738-1-mortonm@chromium.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a001-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141555.zswTLROZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/248aa1aeef5c49d4af78b9c3d09e896413258c76
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Micah-Morton/security-Add-LSM-hook-to-setgroups-syscall/20220614-050341
        git checkout 248aa1aeef5c49d4af78b9c3d09e896413258c76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/safesetid/lsm.c:248:50: error: use of undeclared identifier 'group_info'
                   if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
                                                                  ^
   1 error generated.


vim +/group_info +248 security/safesetid/lsm.c

   237	
   238	static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
   239	{
   240		int i;
   241	
   242		/* Do nothing if there are no setgid restrictions for our old RGID. */
   243		if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
   244			return 0;
   245	
   246		get_group_info(new->group_info);
   247		for (i = 0; i < new->group_info->ngroups; i++) {
 > 248			if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
   249				put_group_info(new->group_info);
   250				/*
   251				 * Kill this process to avoid potential security vulnerabilities
   252				 * that could arise from a missing allowlist entry preventing a
   253				 * privileged process from dropping to a lesser-privileged one.
   254				 */
   255				force_sig(SIGKILL);
   256				return -EACCES;
   257			}
   258		}
   259	
   260		put_group_info(new->group_info);
   261		return 0;
   262	}
   263	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
