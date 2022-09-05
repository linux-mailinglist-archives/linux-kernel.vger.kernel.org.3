Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED55ADB5E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 00:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiIEWVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIEWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 18:21:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267266715F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662416460; x=1693952460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0KJ1X0d+ghH08Og6OhWwp+HwtemNrkvvpJiE5KXax78=;
  b=V2TOVQ6aL7Kz8iE48VVbEoNb9A2hWzjcTp+06YQ4DuHh0QaOmn+gBL8c
   kH3UObOelNdxMETTx2+mucLJngkJaCrCmEH2chPCUUPyQx1Zp4F6Q2k/c
   K3vJoScXPRqOrL51s+/8FGz0MErq9v7k6K2YMvsrYCzVDhMFvHzDwiOmq
   0RQm82LbmwuFFv4EFPS0+IO0I1Rs4jkx6JmduyBCRCi0ARlRk0MKuqAN6
   /yt8epjrUN78X6VkrqdWM8c+Wk85AJmROHDG/tiVc+k/liUBEKImEz186
   FJx4+PYoKWBgIlchRP0leJ28kVxM6P/rROhNa2BSubNShqghTt0SSHgse
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="279471807"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="279471807"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 15:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="591039129"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Sep 2022 15:20:56 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVKSe-0004Zx-0Q;
        Mon, 05 Sep 2022 22:20:56 +0000
Date:   Tue, 6 Sep 2022 06:20:38 +0800
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
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counter
Message-ID: <202209060655.H9CK1KgC-lkp@intel.com>
References: <20220905031012.4450-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905031012.4450-3-osalvador@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc4]
[cannot apply to akpm-mm/mm-everything next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/page_owner-print-stacks-and-their-counter/20220905-111139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e18e42e4b280c85b76967a9106a13ca61c16179
config: microblaze-randconfig-m041-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060655.H9CK1KgC-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
lib/stackdepot.c:586 stack_depot_print_stacks_threshold() warn: unsigned 'stack->size' is never less than zero.

vim +586 lib/stackdepot.c

   568	
   569	int stack_depot_print_stacks_threshold(char *buf, size_t size, loff_t *pos)
   570	{
   571		int i = *pos, ret = 0;
   572		struct stack_record **stacks, *stack;
   573		static struct stack_record *last = NULL;
   574		unsigned long stack_table_entries = stack_hash_mask + 1;
   575	
   576		/* Continue from the last stack if we have one */
   577		if (last) {
   578			stack = last->next;
   579		} else {
   580	new_table:
   581			stacks = &stack_table[i];
   582			stack = (struct stack_record *)stacks;
   583		}
   584	
   585		for (; stack; stack = stack->next) {
 > 586			if (!stack->size || stack->size < 0 ||

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
