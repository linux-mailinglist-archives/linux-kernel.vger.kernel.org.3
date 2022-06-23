Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72855750C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiFWIKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiFWIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:10:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282AB47566;
        Thu, 23 Jun 2022 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655971827; x=1687507827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QcYh2jZjsF9QfkU41AW34wJJx148DZOcArwuObfigGo=;
  b=b8fPrHXWC73WaTZHhKjS9EIlbsxvgIk+uMySQwFMlkpAIK0bsbm8+EWV
   KlN9Xqi7v7d+OCMcPRy4kkjE/nzQeNSgqZ1LbvqKKNQB1UUAdFaH82tPG
   c9mh4hwuAV5Sfea/fjSt/gyg/vSat4n8ohfXOlsrQJ+djduAOpXgiOT6d
   LV+OzhsrEAAfPSp5Q28OXLmKPP3s2nIhuk6lR6qVqE/RbPf6+vMXVnKnb
   tktqj1xBsnPSZbOrTYyoKF2C5B9TO6j68omGFbgNE/AR/qimMMkG9ygzw
   sENwu1rC4pFFOSp2re5I+lmJZquKBF/4dVBDUR1wyaj88CNSEBBfkJTRK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280704808"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="280704808"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="586071816"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Jun 2022 01:10:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Hux-0000vd-HU;
        Thu, 23 Jun 2022 08:10:23 +0000
Date:   Thu, 23 Jun 2022 16:10:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Message-ID: <202206231529.kLjzriV0-lkp@intel.com>
References: <20220622225102.2112026-8-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-8-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Joel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc3 next-20220622]
[cannot apply to paulmck-rcu/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220623-065447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git de5c208d533a46a074eb46ea17f672cc005a7269
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220623/202206231529.kLjzriV0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/intel-lab-lkp/linux/commit/6c59cb940f39b882c20e6858c41df7c1470b930a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220623-065447
        git checkout 6c59cb940f39b882c20e6858c41df7c1470b930a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/rcu/rcuscale.c:663:6: sparse: sparse: symbol 'kfree_rcu_lazy' was not declared. Should it be static?
>> kernel/rcu/rcuscale.c:786:15: sparse: sparse: symbol 'jiffies_at_lazy_cb' was not declared. Should it be static?
>> kernel/rcu/rcuscale.c:787:17: sparse: sparse: symbol 'lazy_test1_rh' was not declared. Should it be static?
>> kernel/rcu/rcuscale.c:788:5: sparse: sparse: symbol 'rcu_lazy_test1_cb_called' was not declared. Should it be static?
>> kernel/rcu/rcuscale.c:789:6: sparse: sparse: symbol 'call_rcu_lazy_test1' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
