Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D065588DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiHCNzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiHCNy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:54:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D63244B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659534852; x=1691070852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MLrIfpI5RraAgqV61fjWw/Y1o9kcXkLebaVGggDYQVw=;
  b=SJdcGGOSSdzShs8cuFximTYE4DXwGLCsk8NZRgXM9wOuI0y3aAyR/hJX
   TsKuK4lNioFL/YdVLDQe/GOCBLUxl1GokrxvaMf5yyxbYPBsG0hDayHqQ
   IlwOkqS86X04Y2DktBcVTzpRkpHVQiDD8BfbV3d57g4JPr5vGFePQB2iz
   +E+VugxwNwoasfFJTvu7cmoHBPQOgMVqCzIBEQAPdXZGnmiwuqlELJpSw
   tIGWiQJQD0LEakVb0atKP/djYJ7cd31c5a+dNp2KRaE7Am6gCS8/AZO/k
   /YNk2wISet5LvWhfVi7rpSJy3hcBPM35lFr77eO4e8oCBsxjfLc1kYOek
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="375975396"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="375975396"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 06:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="848585936"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2022 06:54:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJEp6-000HL1-2N;
        Wed, 03 Aug 2022 13:54:08 +0000
Date:   Wed, 3 Aug 2022 21:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
Message-ID: <202208032100.RedT7779-lkp@intel.com>
References: <20220803012159.36551-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803012159.36551-3-peterx@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-Remember-young-bit-for-migration-entries/20220803-092311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arc-randconfig-r043-20220803 (https://download.01.org/0day-ci/archive/20220803/202208032100.RedT7779-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2fca6cb25745d1404fc34e0ec2ea89b6195a8c27
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/mm-Remember-young-bit-for-migration-entries/20220803-092311
        git checkout 2fca6cb25745d1404fc34e0ec2ea89b6195a8c27
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: mm/rmap.o: in function `migration_entry_supports_young':
   include/linux/swapops.h:288: undefined reference to `max_swapfile_size'
>> arc-elf-ld: include/linux/swapops.h:288: undefined reference to `max_swapfile_size'
   arc-elf-ld: mm/migrate.o: in function `migration_entry_supports_young':
   include/linux/swapops.h:288: undefined reference to `max_swapfile_size'
>> arc-elf-ld: include/linux/swapops.h:288: undefined reference to `max_swapfile_size'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
