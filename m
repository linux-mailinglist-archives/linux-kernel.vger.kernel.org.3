Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0496458B9EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiHGG4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHGG42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:56:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89F9584
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 23:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659855386; x=1691391386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CynN6IOdEbyT0dDFxsN4TGiUIgQcvn6n6Iz55HRlDAw=;
  b=RF6YPJ6QMdBTrBvAY76D2XZh7FNdkVWMd1VIQowMt3vO78cCbeZ2MeKv
   RIIeM0wX2YcZ0RabBhiNnRPAG6afpCg1hdFXyF7SZktyFbVu4/hs9A8sB
   hl9lMe68/opbIOt1BWCWczOOrqAkEGYXrsQxeKTaAOYbMJnAVIjKwK0KM
   /Cz6YpFm34Mhm+ehKOUdB9OeqIqzuj4LhrR3TzqxXh6Zirxh/SmHi/DUu
   tUw3L7sYehHeKVPKizitJa0fFdbsAEXURstOc9VBRpr5keRz59m/+CTFg
   lBysUz+YZD+y4jkrlg4AWYmhzIERlkC1PGcYnATfWLSL58N9YRks1T71m
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="273464917"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="273464917"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 23:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="672124238"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2022 23:56:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKaD1-000L4b-1q;
        Sun, 07 Aug 2022 06:56:23 +0000
Date:   Sun, 7 Aug 2022 14:55:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     alexlzhu@fb.com, linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexander Zhu <alexlzhu@fb.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Message-ID: <202208071415.Aav6LUtf-lkp@intel.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805184016.2926168-1-alexlzhu@fb.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19]
[cannot apply to akpm-mm/mm-everything next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alexlzhu-fb-com/mm-add-thp_utilization-metrics-to-proc-thp_utilization/20220806-024150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9e2f40233670c70c25e0681cb66d50d1e2742829
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220807/202208071415.Aav6LUtf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c3896ed4c7d2319ac0880860a6bfc98e6eed3d66
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review alexlzhu-fb-com/mm-add-thp_utilization-metrics-to-proc-thp_utilization/20220806-024150
        git checkout c3896ed4c7d2319ac0880860a6bfc98e6eed3d66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/huge_memory.c:601:6: warning: no previous prototype for function 'is_anon_transparent_hugepage' [-Wmissing-prototypes]
   bool is_anon_transparent_hugepage(struct page *page)
        ^
   mm/huge_memory.c:601:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool is_anon_transparent_hugepage(struct page *page)
   ^
   static 
   mm/huge_memory.c:3300:22: warning: variable 'head' set but not used [-Wunused-but-set-variable]
           struct page *page, *head = NULL;
                               ^
   2 warnings generated.


vim +/is_anon_transparent_hugepage +601 mm/huge_memory.c

   600	
 > 601	bool is_anon_transparent_hugepage(struct page *page)
   602	{
   603		return PageAnon(page) && is_transparent_hugepage(page);
   604	}
   605	EXPORT_SYMBOL_GPL(is_anon_transparent_hugepage);
   606	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
