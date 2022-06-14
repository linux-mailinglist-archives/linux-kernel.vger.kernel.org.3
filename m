Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17554A835
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351396AbiFNEgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiFNEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:36:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA402E9E1;
        Mon, 13 Jun 2022 21:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655181376; x=1686717376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Ot4topfx5yxNsrBgGLnNX047qT6axEWuCSJUvYIVWM=;
  b=Am33z/OfTEMD6ZEUcJL61ecqVdewqyC7W0Xs9bhjmm5iHQxPElU6qoOe
   vsrJoZGx3DclmrKkUthNOmu2pgGU4D5EEu9QUMZAzgyCrWkSubWZnDHi0
   SZYrikhay2HhgBKo20QvVn/6AgvERBLnVGfyReLUu7ZJqSqIheooJDchM
   +zQaWtyIklqix2FVrNGzZPmfWR/Ozj37h7vDBTgw0wvdPNXpXmmbMlsDH
   7LYdgk/g/x8Axkn012fyAS7eaEcOMa8reiV6Uj4wLMaPlI2iOc0yg71l9
   xbjwe6JalUECfGSbA2B2fWsqm5Wr+bRSOnXKyCaQE8Xn/eMwu6HuPOrlX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303906186"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="303906186"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="830176512"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 21:36:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0yHl-000LTl-Bg;
        Tue, 14 Jun 2022 04:36:13 +0000
Date:   Tue, 14 Jun 2022 12:35:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org
Cc:     kbuild-all@lists.01.org, keescook@chromium.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org,
        Micah Morton <mortonm@chromium.org>
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy
 handling
Message-ID: <202206141217.8YUKCl5p-lkp@intel.com>
References: <20220613202852.447738-1-mortonm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613202852.447738-1-mortonm@chromium.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arc-randconfig-r043-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141217.8YUKCl5p-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/248aa1aeef5c49d4af78b9c3d09e896413258c76
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Micah-Morton/security-Add-LSM-hook-to-setgroups-syscall/20220614-050341
        git checkout 248aa1aeef5c49d4af78b9c3d09e896413258c76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/safesetid/lsm.c: In function 'safesetid_task_fix_setgroups':
>> security/safesetid/lsm.c:248:64: error: 'group_info' undeclared (first use in this function)
     248 |                 if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
         |                                                                ^~~~~~~~~~
   security/safesetid/lsm.c:248:64: note: each undeclared identifier is reported only once for each function it appears in


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
