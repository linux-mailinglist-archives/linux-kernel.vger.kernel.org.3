Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705604D8AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbiCNRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiCNRgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:36:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257CA1A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647279314; x=1678815314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jPaWQzoMtyMcrbezoCVNRD7YiuzxuZs8L8nT/etgwJc=;
  b=d/9ZIEXlc25IiaigSyK3RZcTJrgM/1/jE+Na7IKMj8mKUZOqEfHQAj17
   SMXbzk6v/pWpRSNIPZPBKjBbHxR1rnqmP0NxL5NK40KbVh+OHBSwyr9Gr
   lfnmlEN0mkXLNpibWGTzQ5zt5KOKQ7Ac7C/TNaaVYD3IAHzl7Zddh6rcT
   WEgm/iA9+grNK7ydElugL0AB+dPhmCfbT6pT5/zu9Fhnpgd+UP6eC0Sjh
   Wv4VCfKA4iNzBai9wQuGBska6t48JujOu34x+KiQviiD5J5TQem0udrAx
   NQKKV8/+pD29ecQk9wybHSDdJLnGS/fewwsQKnO4vI8QTi8fJo+aWQSx1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="256046719"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="256046719"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 10:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="689900708"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2022 10:35:10 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTob8-000A4o-40; Mon, 14 Mar 2022 17:35:10 +0000
Date:   Tue, 15 Mar 2022 01:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH linux-next] ksm: Count ksm-merging pages for each process
Message-ID: <202203150131.oDjproo7-lkp@intel.com>
References: <20220314015355.2111696-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314015355.2111696-1-xu.xin16@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220310]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/ksm-Count-ksm-merging-pages-for-each-process/20220314-095633
base:    71941773e143369a73c9c4a3b62fbb60736a1182
config: s390-randconfig-s031-20220313 (https://download.01.org/0day-ci/archive/20220315/202203150131.oDjproo7-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/64577121c010929e9f2604053f4b96402d3089a8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/ksm-Count-ksm-merging-pages-for-each-process/20220314-095633
        git checkout 64577121c010929e9f2604053f4b96402d3089a8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/ksm.c:647:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *owner @@     got struct task_struct [noderef] __rcu *owner @@
   mm/ksm.c:647:23: sparse:     expected struct task_struct *owner
   mm/ksm.c:647:23: sparse:     got struct task_struct [noderef] __rcu *owner
   mm/ksm.c:805:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *owner @@     got struct task_struct [noderef] __rcu *owner @@
   mm/ksm.c:805:23: sparse:     expected struct task_struct *owner
   mm/ksm.c:805:23: sparse:     got struct task_struct [noderef] __rcu *owner
   mm/ksm.c:2038:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *owner @@     got struct task_struct [noderef] __rcu *owner @@
   mm/ksm.c:2038:15: sparse:     expected struct task_struct *owner
   mm/ksm.c:2038:15: sparse:     got struct task_struct [noderef] __rcu *owner
   mm/ksm.c: note: in included file:
   include/linux/rmap.h:248:28: sparse: sparse: context imbalance in 'write_protect_page' - unexpected unlock

vim +647 mm/ksm.c

   635	
   636		/* check it's not STABLE_NODE_CHAIN or negative */
   637		BUG_ON(stable_node->rmap_hlist_len < 0);
   638	
   639		hlist_for_each_entry(rmap_item, &stable_node->hlist, hlist) {
   640			if (rmap_item->hlist.next)
   641				ksm_pages_sharing--;
   642			else
   643				ksm_pages_shared--;
   644	
   645	#ifdef CONFIG_MEMCG /*Condition of mm_struct with owner*/
   646			BUG_ON(rmap_item->mm == NULL);
 > 647			owner = rmap_item->mm->owner;
   648			/* In case that the process of mm may be killed or exit */
   649			if (owner)
   650				owner->ksm_merging_pages--;
   651	#endif
   652			VM_BUG_ON(stable_node->rmap_hlist_len <= 0);
   653			stable_node->rmap_hlist_len--;
   654			put_anon_vma(rmap_item->anon_vma);
   655			rmap_item->address &= PAGE_MASK;
   656			cond_resched();
   657		}
   658	
   659		/*
   660		 * We need the second aligned pointer of the migrate_nodes
   661		 * list_head to stay clear from the rb_parent_color union
   662		 * (aligned and different than any node) and also different
   663		 * from &migrate_nodes. This will verify that future list.h changes
   664		 * don't break STABLE_NODE_DUP_HEAD. Only recent gcc can handle it.
   665		 */
   666		BUILD_BUG_ON(STABLE_NODE_DUP_HEAD <= &migrate_nodes);
   667		BUILD_BUG_ON(STABLE_NODE_DUP_HEAD >= &migrate_nodes + 1);
   668	
   669		if (stable_node->head == &migrate_nodes)
   670			list_del(&stable_node->list);
   671		else
   672			stable_node_dup_del(stable_node);
   673		free_stable_node(stable_node);
   674	}
   675	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
