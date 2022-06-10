Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26B1545A55
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbiFJDGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:06:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C077ED6808;
        Thu,  9 Jun 2022 20:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654830364; x=1686366364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gRcy7BQKK63352f1zmSLdIX3MvUmuKXHb1hOn5O+pkI=;
  b=FN6dLAt3XGILEbRSw87CM50q70z/t1qErlu3FTuOL0ieZu+gVPnFdrM/
   QRvrAnzNOjrtNGMh6jrC/6PqwwMF2Tmn7laDoch0Ytgd/E6oFjA69LNol
   t5Ic8zGZNfDAIhj6U2TLpBsG9NsUDr3f2MgqAmWwMDV3dbi19vnLY0Htc
   j4glyVkCBvWkJM2X3TV3CETkz3CXRT3Un4CVLu4IpKgf152CnqUK1NGWQ
   7mWolRRbjHmHSEGgxd80ayVPO3n1bsMf1M5DooRl8HcSKBpgBuI4aqn4t
   2JyGUW8M7Yf+O6p23i3NAYmVjBu3ackrYs2aj9kDhSaOBaDh2TThbaFHQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257924957"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="257924957"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 20:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="908673308"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2022 20:05:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzUyE-000Ge6-HS;
        Fri, 10 Jun 2022 03:05:58 +0000
Date:   Fri, 10 Jun 2022 11:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v36 18/33] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <202206101053.7FemxCmO-lkp@intel.com>
References: <20220609230146.319210-19-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609230146.319210-19-casey@schaufler-ca.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on pcmoore-selinux/next linus/master]
[cannot apply to jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220610-080129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: s390-randconfig-r044-20220608 (https://download.01.org/0day-ci/archive/20220610/202206101053.7FemxCmO-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/86d33e271bed739fe32367e703b054ea253bb471
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220610-080129
        git checkout 86d33e271bed739fe32367e703b054ea253bb471
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash fs/fuse/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/fuse/fuse_i.h:17,
                    from fs/fuse/dir.c:9:
   fs/fuse/dir.c: In function 'get_security_context.constprop':
>> include/linux/compiler.h:70:46: warning: 'lsmctx.len' is used uninitialized [-Wuninitialized]
      70 |                 (__if_trace.miss_hit[1]++,1) :          \
         |                                              ^
   fs/fuse/dir.c:467:27: note: 'lsmctx.len' was declared here
     467 |         struct lsmcontext lsmctx;
         |                           ^~~~~~


vim +70 include/linux/compiler.h

a15fd609ad53a6 Linus Torvalds 2019-03-20  59  
a15fd609ad53a6 Linus Torvalds 2019-03-20  60  #define __trace_if_value(cond) ({			\
2bcd521a684cc9 Steven Rostedt 2008-11-21  61  	static struct ftrace_branch_data		\
e04462fb82f8dd Miguel Ojeda   2018-09-03  62  		__aligned(4)				\
33def8498fdde1 Joe Perches    2020-10-21  63  		__section("_ftrace_branch")		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  64  		__if_trace = {				\
2bcd521a684cc9 Steven Rostedt 2008-11-21  65  			.func = __func__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  66  			.file = __FILE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  67  			.line = __LINE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  68  		};					\
a15fd609ad53a6 Linus Torvalds 2019-03-20  69  	(cond) ?					\
a15fd609ad53a6 Linus Torvalds 2019-03-20 @70  		(__if_trace.miss_hit[1]++,1) :		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  71  		(__if_trace.miss_hit[0]++,0);		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  72  })
a15fd609ad53a6 Linus Torvalds 2019-03-20  73  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
