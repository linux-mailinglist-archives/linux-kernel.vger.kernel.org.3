Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943BC55D7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbiF1LZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiF1LZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:25:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193DA2CDF0;
        Tue, 28 Jun 2022 04:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656415508; x=1687951508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cV9gLh7/ksNfxbUkADTMFCNP+M9eg5dvTgDTdjYN6QQ=;
  b=nNKliq9m5ulO4VeKDs8Y8B+v6E9KznAj40C0ZwSmGFUa0REU757wjyBT
   9Uskplw3TRTdAmHicqmR5P5Llq/gNatfTM4/xvM+NRuPB613Cg7OVRqbp
   VHWEpp6uW0C3pxFfwH6sX9OvBwg85av/PzQtRac9UPvNGg2GAaK1Ek0E0
   T2K/5YwDg+ViBNvd8+cogSodQDfYI2VQgm8OR22QgW7CThkO2S6XKnCzb
   jpNKEcwWz2M9iNZtixhnmvUmfU4AsDu/8b0Zyk9ZUSv5OcdyKx4PXoneb
   L/EB62hE5QjbSKBRHYoc7aoad7eA540EADFHtRlwKRHElo2i+t65EjAVn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345710578"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345710578"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540458827"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2022 04:25:03 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o69L4-0009xs-QF;
        Tue, 28 Jun 2022 11:25:02 +0000
Date:   Tue, 28 Jun 2022 19:24:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v37 18/33] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <202206281923.PWn0D5ak-lkp@intel.com>
References: <20220628005611.13106-19-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628005611.13106-19-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on pcmoore-selinux/next linus/master v5.19-rc4 next-20220628]
[cannot apply to jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220628-095614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: x86_64-randconfig-a002-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281923.PWn0D5ak-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project df18167ac56d05f2ab55f9d874aee7ab6d5bc9a2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c930a07cebde69363d3633fba8bd4cac46dd1520
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220628-095614
        git checkout c930a07cebde69363d3633fba8bd4cac46dd1520
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/security.c:2319:24: error: use of undeclared identifier 'lsm_slotlist'; did you mean 'lsm_slot'?
                           if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
                                               ^~~~~~~~~~~~
                                               lsm_slot
   security/security.c:489:12: note: 'lsm_slot' declared here
   static int lsm_slot __lsm_ro_after_init;
              ^
>> security/security.c:2319:36: error: subscripted value is not an array, pointer, or vector
                           if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
                                               ~~~~~~~~~~~~^~~~~
   2 errors generated.


vim +2319 security/security.c

20510f2f4e2dab James Morris    2007-10-16  2266  
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2267  /**
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2268   * security_setprocattr - Set process attributes via /proc
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2269   * @lsm: name of module involved, or NULL
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2270   * @name: name of the attribute
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2271   * @value: value to set the attribute to
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2272   * @size: size of the value
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2273   *
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2274   * Set the process attribute for the specified security module
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2275   * to the specified value. Note that this can only be used to set
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2276   * the process attributes for the current, or "self" process.
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2277   * The /proc code has already done this check.
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2278   *
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2279   * Returns 0 on success, an appropriate code otherwise.
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2280   */
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2281  int security_setprocattr(const char *lsm, const char *name, void *value,
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2282  			 size_t size)
20510f2f4e2dab James Morris    2007-10-16  2283  {
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2284  	struct security_hook_list *hp;
c930a07cebde69 Casey Schaufler 2022-06-27  2285  	const char *slotname;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2286  	char *termed;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2287  	char *copy;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2288  	int *ilsm = current->security;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2289  	int rc = -EINVAL;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2290  	int slot = 0;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2291  
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2292  	if (!strcmp(name, "interface_lsm")) {
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2293  		/*
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2294  		 * Change the "interface_lsm" value only if all the security
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2295  		 * modules that support setting a procattr allow it.
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2296  		 * It is assumed that all such security modules will be
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2297  		 * cooperative.
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2298  		 */
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2299  		if (size == 0)
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2300  			return -EINVAL;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2301  
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2302  		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2303  				     list) {
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2304  			rc = hp->hook.setprocattr(name, value, size);
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2305  			if (rc < 0 && rc != LSM_RET_DEFAULT(setprocattr))
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2306  				return rc;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2307  		}
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2308  
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2309  		rc = -EINVAL;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2310  
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2311  		copy = kmemdup_nul(value, size, GFP_KERNEL);
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2312  		if (copy == NULL)
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2313  			return -ENOMEM;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2314  
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2315  		termed = strsep(&copy, " \n");
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2316  
c930a07cebde69 Casey Schaufler 2022-06-27  2317  		for (slot = 0; slot < lsm_slot; slot++) {
c930a07cebde69 Casey Schaufler 2022-06-27  2318  			slotname = lsm_slot_to_name(slot);
a87b0b9fe463f0 Casey Schaufler 2022-06-27 @2319  			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
c930a07cebde69 Casey Schaufler 2022-06-27  2320  				*ilsm = slot;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2321  				rc = size;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2322  				break;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2323  			}
c930a07cebde69 Casey Schaufler 2022-06-27  2324  		}
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2325  
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2326  		kfree(termed);
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2327  		return rc;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2328  	}
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2329  
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2330  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
ac35545bc102bf Casey Schaufler 2022-06-27  2331  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2332  			continue;
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2333  		if (lsm == NULL && *ilsm != LSMBLOB_INVALID &&
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2334  		    *ilsm != hp->lsmid->slot)
a87b0b9fe463f0 Casey Schaufler 2022-06-27  2335  			continue;
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2336  		return hp->hook.setprocattr(name, value, size);
6d9c939dbe4d0b Casey Schaufler 2018-09-21  2337  	}
98e828a0650f34 KP Singh        2020-03-29  2338  	return LSM_RET_DEFAULT(setprocattr);
20510f2f4e2dab James Morris    2007-10-16  2339  }
20510f2f4e2dab James Morris    2007-10-16  2340  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
