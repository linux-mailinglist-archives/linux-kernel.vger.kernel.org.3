Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B57A5AA4B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiIBA5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiIBA5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:57:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7230A346B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662080231; x=1693616231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sqI32UP29Yc5IxqawJxrzwP7cjo3i7gGmmmLnqaDDZc=;
  b=K7vGXk4ZENhaPJ2NchDXmfRM11Z9a8br89JI7nDcG2baSxkh3SfoT2bU
   fJYjliYHLQ4mZs50j4TGkefZ4c6bp1AP6P/y1w0wX8OwCp72BJkqurPP1
   4HJSboWLK1FNgsFEbEgB62nWF6l6LNBgfgPfGLL5QFZ6prvkaH+I0UuuU
   RgWZzsFmtHvuZW3vupADX7vjxtTjd42vWP5Z1n6j8NleBYI1KKj1wNSDb
   ol0I3c1mknC5B2lVCFpa0/jGmOXWNY6ma4goksw243dAef9hKJyEyUwf5
   dbNr8RLmT/dZJvWGx0XUlvkGQxm+P9Tuyv2i5l8EeN8du8BQJEp8XgmA4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282849829"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="282849829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563733999"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 17:57:08 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTuzc-0000xG-0s;
        Fri, 02 Sep 2022 00:57:08 +0000
Date:   Fri, 2 Sep 2022 08:56:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/3] mm, page_owner: Add page_owner_stacks file to print
 out only stacks and their counter
Message-ID: <202209020818.s1RIxKyP-lkp@intel.com>
References: <20220901044249.4624-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901044249.4624-3-osalvador@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc3]
[cannot apply to akpm-mm/mm-everything next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/page_owner-print-stacks-and-their-counter/20220901-124408
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c5e4d5e99162ba8025d58a3af7ad103f155d2df7
config: arc-randconfig-r043-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020818.s1RIxKyP-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/18d3054fb57a70676be763adab8c8881a1baa504
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Oscar-Salvador/page_owner-print-stacks-and-their-counter/20220901-124408
        git checkout 18d3054fb57a70676be763adab8c8881a1baa504
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/stackdepot.c: In function 'stack_depot_print_stacks_threshold':
>> lib/stackdepot.c:603:17: error: 'STACK_HASH_SIZE' undeclared (first use in this function); did you mean 'STACK_HASH_SEED'?
     603 |         if (i < STACK_HASH_SIZE)
         |                 ^~~~~~~~~~~~~~~
         |                 STACK_HASH_SEED
   lib/stackdepot.c:603:17: note: each undeclared identifier is reported only once for each function it appears in


vim +603 lib/stackdepot.c

   568	
   569	int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos,
   570					       unsigned long *last_stack)
   571	{
   572		struct stack_record *stack = NULL, *last;
   573		struct stack_record **stacks;
   574		int i = *pos, ret = 0;
   575	
   576		/* Continue from the last week if we have one */
   577		if (*last_stack) {
   578			last = (struct stack_record *)*last_stack;
   579			stack = last->next;
   580		} else {
   581	new_table:
   582			stacks = &stack_table[i];
   583			stack = (struct stack_record *)stacks;
   584		}
   585	
   586		for (; stack; stack = stack->next) {
   587			if (!stack->size || stack->size < 0 ||
   588			    stack->size > size || stack->handle.valid != 1 ||
   589			    refcount_read(&stack->count) < 1)
   590				continue;
   591	
   592			ret += stack_trace_snprint(buf, size, stack->entries, stack->size, 0);
   593			ret += scnprintf(buf + ret, size - ret, "stack count: %d\n\n",
   594					 refcount_read(&stack->count));
   595			*last_stack = (unsigned long)stack;
   596			return ret;
   597		}
   598	
   599		i++;
   600		*pos = i;
   601	
   602		/* Keep looking all tables for valid stacks */
 > 603		if (i < STACK_HASH_SIZE)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
