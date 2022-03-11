Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E745B4D6017
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbiCKKt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbiCKKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:49:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F412182BC0;
        Fri, 11 Mar 2022 02:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646995732; x=1678531732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3q2RXnw3ENJ9hR2e3HJcmwGSdFSeyoDplqjI07wWEkE=;
  b=EQY7RCxwaQog7FcOOxbg8aZEv8+Yt39ockNWxTPGLdZ5VNeREVHu/jz/
   6Mr/ZDdOKTw/a5Afxa0IgUr4CJMh0DQ5JysUz7ME9DgMGk1rJ/U2XMVsq
   uMTCKudBNhtuV+8jjDQqbPFCy2xMQOa8bAcfGNoY/RUtjAb4GMaqiG4/C
   Sz/GY7UYIyKy/8zg2pQV4DG876iFOzcxtrcSS68Jb/cQraaTlyDuu5Awg
   c9huEYq3U+JwfW7x3W6nhQvfIeGPGWFaOgl3WJUw7I1t6XlCie/EWH4tR
   /aRgq9OE8L/Q9bW3r0JuK32yS4wGKlwyr4LwYvpkwjmGVOLvZ+VEBjR+/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237723039"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="237723039"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="579251273"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 02:48:49 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nScpE-0006Gx-A9; Fri, 11 Mar 2022 10:48:48 +0000
Date:   Fri, 11 Mar 2022 18:48:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v33 01/29] integrity: disassociate ima_filter_rule from
 security_audit_rule
Message-ID: <202203111810.oPf2VNfH-lkp@intel.com>
References: <20220310234632.16194-2-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310234632.16194-2-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on pcmoore-selinux/next linus/master jmorris-security/next-testing v5.17-rc7 next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220311-084644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: arc-buildonly-randconfig-r006-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111810.oPf2VNfH-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2796a69611ebb559eacf03666a3ae2fbd48e0c12
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220311-084644
        git checkout 2796a69611ebb559eacf03666a3ae2fbd48e0c12
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/integrity/ima/ima_policy.c: In function 'ima_lsm_free_rule':
>> security/integrity/ima/ima_policy.c:360:17: error: implicit declaration of function 'ima_filter_rule_free'; did you mean 'ima_file_free'? [-Werror=implicit-function-declaration]
     360 |                 ima_filter_rule_free(entry->lsm[i].rule);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 ima_file_free
   security/integrity/ima/ima_policy.c: In function 'ima_lsm_copy_rule':
>> security/integrity/ima/ima_policy.c:409:17: error: implicit declaration of function 'ima_filter_rule_init' [-Werror=implicit-function-declaration]
     409 |                 ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
         |                 ^~~~~~~~~~~~~~~~~~~~
   security/integrity/ima/ima_policy.c: In function 'ima_match_rules':
>> security/integrity/ima/ima_policy.c:625:30: error: implicit declaration of function 'ima_filter_rule_match' [-Werror=implicit-function-declaration]
     625 |                         rc = ima_filter_rule_match(osid, rule->lsm[i].type,
         |                              ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +360 security/integrity/ima/ima_policy.c

176377d97d6a3f Tyler Hicks      2020-08-11  354  
b169424551930a Janne Karhunen   2019-06-14  355  static void ima_lsm_free_rule(struct ima_rule_entry *entry)
b169424551930a Janne Karhunen   2019-06-14  356  {
b169424551930a Janne Karhunen   2019-06-14  357  	int i;
b169424551930a Janne Karhunen   2019-06-14  358  
b169424551930a Janne Karhunen   2019-06-14  359  	for (i = 0; i < MAX_LSM_RULES; i++) {
b8867eedcf76ca Tyler Hicks      2020-07-10 @360  		ima_filter_rule_free(entry->lsm[i].rule);
b169424551930a Janne Karhunen   2019-06-14  361  		kfree(entry->lsm[i].args_p);
b169424551930a Janne Karhunen   2019-06-14  362  	}
465aee77aae857 Tyler Hicks      2020-07-09  363  }
465aee77aae857 Tyler Hicks      2020-07-09  364  
465aee77aae857 Tyler Hicks      2020-07-09  365  static void ima_free_rule(struct ima_rule_entry *entry)
465aee77aae857 Tyler Hicks      2020-07-09  366  {
465aee77aae857 Tyler Hicks      2020-07-09  367  	if (!entry)
465aee77aae857 Tyler Hicks      2020-07-09  368  		return;
465aee77aae857 Tyler Hicks      2020-07-09  369  
465aee77aae857 Tyler Hicks      2020-07-09  370  	/*
465aee77aae857 Tyler Hicks      2020-07-09  371  	 * entry->template->fields may be allocated in ima_parse_rule() but that
465aee77aae857 Tyler Hicks      2020-07-09  372  	 * reference is owned by the corresponding ima_template_desc element in
465aee77aae857 Tyler Hicks      2020-07-09  373  	 * the defined_templates list and cannot be freed here
465aee77aae857 Tyler Hicks      2020-07-09  374  	 */
465aee77aae857 Tyler Hicks      2020-07-09  375  	kfree(entry->fsname);
176377d97d6a3f Tyler Hicks      2020-08-11  376  	ima_free_rule_opt_list(entry->keyrings);
465aee77aae857 Tyler Hicks      2020-07-09  377  	ima_lsm_free_rule(entry);
b169424551930a Janne Karhunen   2019-06-14  378  	kfree(entry);
b169424551930a Janne Karhunen   2019-06-14  379  }
b169424551930a Janne Karhunen   2019-06-14  380  
b169424551930a Janne Karhunen   2019-06-14  381  static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
b169424551930a Janne Karhunen   2019-06-14  382  {
b169424551930a Janne Karhunen   2019-06-14  383  	struct ima_rule_entry *nentry;
483ec26eed42bf Janne Karhunen   2020-01-15  384  	int i;
b169424551930a Janne Karhunen   2019-06-14  385  
b169424551930a Janne Karhunen   2019-06-14  386  	/*
b169424551930a Janne Karhunen   2019-06-14  387  	 * Immutable elements are copied over as pointers and data; only
b169424551930a Janne Karhunen   2019-06-14  388  	 * lsm rules can change
b169424551930a Janne Karhunen   2019-06-14  389  	 */
f60c826d031817 Alex Dewar       2020-09-09  390  	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
f60c826d031817 Alex Dewar       2020-09-09  391  	if (!nentry)
f60c826d031817 Alex Dewar       2020-09-09  392  		return NULL;
f60c826d031817 Alex Dewar       2020-09-09  393  
c593642c8be046 Pankaj Bharadiya 2019-12-09  394  	memset(nentry->lsm, 0, sizeof_field(struct ima_rule_entry, lsm));
b169424551930a Janne Karhunen   2019-06-14  395  
b169424551930a Janne Karhunen   2019-06-14  396  	for (i = 0; i < MAX_LSM_RULES; i++) {
483ec26eed42bf Janne Karhunen   2020-01-15  397  		if (!entry->lsm[i].args_p)
b169424551930a Janne Karhunen   2019-06-14  398  			continue;
b169424551930a Janne Karhunen   2019-06-14  399  
b169424551930a Janne Karhunen   2019-06-14  400  		nentry->lsm[i].type = entry->lsm[i].type;
39e5993d0d452b Tyler Hicks      2020-07-09  401  		nentry->lsm[i].args_p = entry->lsm[i].args_p;
39e5993d0d452b Tyler Hicks      2020-07-09  402  		/*
39e5993d0d452b Tyler Hicks      2020-07-09  403  		 * Remove the reference from entry so that the associated
39e5993d0d452b Tyler Hicks      2020-07-09  404  		 * memory will not be freed during a later call to
39e5993d0d452b Tyler Hicks      2020-07-09  405  		 * ima_lsm_free_rule(entry).
39e5993d0d452b Tyler Hicks      2020-07-09  406  		 */
39e5993d0d452b Tyler Hicks      2020-07-09  407  		entry->lsm[i].args_p = NULL;
b169424551930a Janne Karhunen   2019-06-14  408  
b8867eedcf76ca Tyler Hicks      2020-07-10 @409  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
b169424551930a Janne Karhunen   2019-06-14  410  				     nentry->lsm[i].args_p,
b169424551930a Janne Karhunen   2019-06-14  411  				     &nentry->lsm[i].rule);
483ec26eed42bf Janne Karhunen   2020-01-15  412  		if (!nentry->lsm[i].rule)
483ec26eed42bf Janne Karhunen   2020-01-15  413  			pr_warn("rule for LSM \'%s\' is undefined\n",
aa0c0227d33171 Tyler Hicks      2020-07-09  414  				nentry->lsm[i].args_p);
b169424551930a Janne Karhunen   2019-06-14  415  	}
b169424551930a Janne Karhunen   2019-06-14  416  	return nentry;
b169424551930a Janne Karhunen   2019-06-14  417  }
b169424551930a Janne Karhunen   2019-06-14  418  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
