Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B21D55D9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbiF1IqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbiF1Ipu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:45:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC742DD59;
        Tue, 28 Jun 2022 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656405923; x=1687941923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bo/E4btYumeo3V4vdBSaofslPgRUpYOLcJoSzJYvuOw=;
  b=mO+UnOxjweyJOku9mOjjaQz5ktbSwuUX3XYnQskfurZBDaZ63xHXPZzb
   A0GohAg28UJt3VmDOEf6NfdVg9slENEyKcnKRSQ0W2tAaBXZPN6tb06qZ
   lWd6Fr3APjb8ICiuBxELxW1ryk5W6LGVAQBb8QfUt2hOMcDvPkWe1UvaT
   yPZVx6rdaEpGyYxIncspuX1noAMwGhnVoKHHyVvv8TRGfVvJcO8FFmcqo
   ELTHCvX4Kx5NBrFkY4JK+G8ELzhOtORgEURR+Qbx1UFl85+4gey7oEURZ
   Hl2r3xVZ2KAA/PZPgQ+K4L75/nNPryXNBlbA4HTA049iRNcV+dinv5Qox
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270426298"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270426298"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540417688"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2022 01:45:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o66qV-0009mQ-8m;
        Tue, 28 Jun 2022 08:45:19 +0000
Date:   Tue, 28 Jun 2022 16:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v37 18/33] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <202206281633.LuFVQ9tq-lkp@intel.com>
References: <20220628005611.13106-19-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628005611.13106-19-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on pcmoore-selinux/next linus/master v5.19-rc4 next-20220627]
[cannot apply to jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220628-095614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: x86_64-randconfig-r022-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281633.LuFVQ9tq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c930a07cebde69363d3633fba8bd4cac46dd1520
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220628-095614
        git checkout c930a07cebde69363d3633fba8bd4cac46dd1520
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/security.c: In function 'security_setprocattr':
>> security/security.c:2319:45: error: 'lsm_slotlist' undeclared (first use in this function); did you mean 'lsm_slot'?
    2319 |                         if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
         |                                             ^~~~~~~~~~~~
         |                                             lsm_slot
   security/security.c:2319:45: note: each undeclared identifier is reported only once for each function it appears in
   security/security.c:2285:21: warning: variable 'slotname' set but not used [-Wunused-but-set-variable]
    2285 |         const char *slotname;
         |                     ^~~~~~~~
   At top level:
   security/security.c:763:12: warning: 'lsm_sock_alloc' defined but not used [-Wunused-function]
     763 | static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
         |            ^~~~~~~~~~~~~~


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
