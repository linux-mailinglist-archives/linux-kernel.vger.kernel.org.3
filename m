Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406FE54DD8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376644AbiFPIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376460AbiFPIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:50:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0300410D3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655369335; x=1686905335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J1gdiJA41T2Z2wOi3LUY95qiuypvu+H6Osn9BPErGMQ=;
  b=ZJdzKlLf3CS01SZJzSTuwRbWEVJ0QZ/nmC3CPMhGWZX/pPcW8PbLiPbq
   vf0skAbDOu8hfeLmg44Vt6i6fKL9FaGf6a6ormHxYF7ZbKlvpd92O9ouM
   hXL38TOK+MBzkV7T8geZKKm+3AVbXns8QYS18FGawY6RH/sMbsEj7w1AZ
   Pbek7jrhu0BbgoMhBf5IiQlmac6/G7IRPpXS813od2n2DOnEA8hcWYyqZ
   f7su7ygUC2GZWxIGYm6oxxwTmnUznBR346zeAi6CJcjAxFJC5l9uzZYOL
   F+6taJ9/faEg4BLqSkAmgQ7OKWuO/JBM2mITl/dqZuvrGkgmzjmrdA6KV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280235693"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="280235693"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 01:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="559661238"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2022 01:48:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1lBM-000ODb-AZ;
        Thu, 16 Jun 2022 08:48:52 +0000
Date:   Thu, 16 Jun 2022 16:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        mike.kravetz@oracle.com
Cc:     kbuild-all@lists.01.org, songmuchun@bytedance.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, anshuman.khandual@arm.com,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] arm64/hugetlb: Implement arm64 specific
 hugetlb_mask_last_hp
Message-ID: <202206161633.yB7NR9sh-lkp@intel.com>
References: <7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/arm64-hugetlb-Implement-arm64-specific-hugetlb_mask_last_hp/20220616-113640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206161633.yB7NR9sh-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f1309dfbc2b70ec5dd72ac38e95a49b7be42b9b6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baolin-Wang/arm64-hugetlb-Implement-arm64-specific-hugetlb_mask_last_hp/20220616-113640
        git checkout f1309dfbc2b70ec5dd72ac38e95a49b7be42b9b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/mm/hugetlbpage.c:371:15: warning: no previous prototype for 'hugetlb_mask_last_hp' [-Wmissing-prototypes]
     371 | unsigned long hugetlb_mask_last_hp(struct hstate *h)
         |               ^~~~~~~~~~~~~~~~~~~~


vim +/hugetlb_mask_last_hp +371 arch/arm64/mm/hugetlbpage.c

   370	
 > 371	unsigned long hugetlb_mask_last_hp(struct hstate *h)
   372	{
   373		unsigned long hp_size = huge_page_size(h);
   374	
   375		switch (hp_size) {
   376		case PUD_SIZE:
   377			return PGDIR_SIZE - PUD_SIZE;
   378		case CONT_PMD_SIZE:
   379			return PUD_SIZE - CONT_PMD_SIZE;
   380		case PMD_SIZE:
   381			return PUD_SIZE - PMD_SIZE;
   382		case CONT_PTE_SIZE:
   383			return PMD_SIZE - CONT_PTE_SIZE;
   384		default:
   385			break;
   386		}
   387	
   388		return ~0UL;
   389	}
   390	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
