Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638A555CB00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiF1FhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiF1FhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:37:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4361038;
        Mon, 27 Jun 2022 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656394630; x=1687930630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7T7FJrtCC3P5TrugT3Ay6zs4Fa9Jjw9Do/eWpS0gNG4=;
  b=iLW8tmvf1m0HdiDria9Byr9dwJmeVwO8JcYcfhhjiru2JXuqWJIFhYUJ
   c/xvoY9aT1NjOt/OTlgRisYAPqoISlAyvvKWok/MA51yiI66fThXiMqgu
   nWKpiE7o1nPBwDtla1n9InZTiiD0Lc/ZSa+3vQvLKvPFx4+UoP0yJhm+S
   i7dd0PuhfjqfpdGklspveNUqQnG/NVm4BPWqfz88i79jF8W/NoV65Qo9h
   QntV75uugncZi/xFsqn1n4EhB0Yd4HluIqqbtsIlA1isX5KWY4Z/crwwd
   i2VsfeRCX1pZK8vFsbJP38t/y/wKNUerSczPxhfz+kJV0nqXP8zuW+yCM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343327822"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343327822"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540368709"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2022 22:37:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o63uM-0009YY-Dj;
        Tue, 28 Jun 2022 05:37:06 +0000
Date:   Tue, 28 Jun 2022 13:36:55 +0800
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
Message-ID: <202206281302.ApiPUdom-lkp@intel.com>
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on pcmoore-selinux/next linus/master v5.19-rc4 next-20220627]
[cannot apply to jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220628-095614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220628/202206281302.ApiPUdom-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c930a07cebde69363d3633fba8bd4cac46dd1520
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220628-095614
        git checkout c930a07cebde69363d3633fba8bd4cac46dd1520
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   security/security.c: In function 'security_setprocattr':
>> security/security.c:2285:21: warning: variable 'slotname' set but not used [-Wunused-but-set-variable]
    2285 |         const char *slotname;
         |                     ^~~~~~~~


vim +/slotname +2285 security/security.c

  2266	
  2267	/**
  2268	 * security_setprocattr - Set process attributes via /proc
  2269	 * @lsm: name of module involved, or NULL
  2270	 * @name: name of the attribute
  2271	 * @value: value to set the attribute to
  2272	 * @size: size of the value
  2273	 *
  2274	 * Set the process attribute for the specified security module
  2275	 * to the specified value. Note that this can only be used to set
  2276	 * the process attributes for the current, or "self" process.
  2277	 * The /proc code has already done this check.
  2278	 *
  2279	 * Returns 0 on success, an appropriate code otherwise.
  2280	 */
  2281	int security_setprocattr(const char *lsm, const char *name, void *value,
  2282				 size_t size)
  2283	{
  2284		struct security_hook_list *hp;
> 2285		const char *slotname;
  2286		char *termed;
  2287		char *copy;
  2288		int *ilsm = current->security;
  2289		int rc = -EINVAL;
  2290		int slot = 0;
  2291	
  2292		if (!strcmp(name, "interface_lsm")) {
  2293			/*
  2294			 * Change the "interface_lsm" value only if all the security
  2295			 * modules that support setting a procattr allow it.
  2296			 * It is assumed that all such security modules will be
  2297			 * cooperative.
  2298			 */
  2299			if (size == 0)
  2300				return -EINVAL;
  2301	
  2302			hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
  2303					     list) {
  2304				rc = hp->hook.setprocattr(name, value, size);
  2305				if (rc < 0 && rc != LSM_RET_DEFAULT(setprocattr))
  2306					return rc;
  2307			}
  2308	
  2309			rc = -EINVAL;
  2310	
  2311			copy = kmemdup_nul(value, size, GFP_KERNEL);
  2312			if (copy == NULL)
  2313				return -ENOMEM;
  2314	
  2315			termed = strsep(&copy, " \n");
  2316	
  2317			for (slot = 0; slot < lsm_slot; slot++) {
  2318				slotname = lsm_slot_to_name(slot);
  2319				if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
  2320					*ilsm = slot;
  2321					rc = size;
  2322					break;
  2323				}
  2324			}
  2325	
  2326			kfree(termed);
  2327			return rc;
  2328		}
  2329	
  2330		hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
  2331			if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
  2332				continue;
  2333			if (lsm == NULL && *ilsm != LSMBLOB_INVALID &&
  2334			    *ilsm != hp->lsmid->slot)
  2335				continue;
  2336			return hp->hook.setprocattr(name, value, size);
  2337		}
  2338		return LSM_RET_DEFAULT(setprocattr);
  2339	}
  2340	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
