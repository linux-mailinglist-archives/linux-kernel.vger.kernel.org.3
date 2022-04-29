Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344395158E3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381719AbiD2XTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357449AbiD2XTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:19:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BF6ABF5D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651274189; x=1682810189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SkoKmM0MKCxM4R400j5vwKOc0q/BGdAfbOI57vblFHY=;
  b=fzpYnK0hf5xs+ZebanX5zQx4M5hnbL2xnaJvwip+wyGPEoX8zAN46sWk
   zYVujAM3e4ZjnBPsPvJQeqh1a20aEQuvQ7luLs2VkTe6P7txQThAMG9YT
   GEL8B2rRiNpdXdQVC0ISPF9iOmYlBa/+QhLI4UpDXAFVqgGjQ7C6FIpuv
   L/ZAwV4+KRwBbvAgrdlBP0maQKe8jHBT5/LYoyzy2t+ZdAQQZMtV4/1gm
   AU7XMemCvhugJxCRpsHCnyKhMMMugy+/b0wEAkiG9sXj7t61UxyBtpkqP
   J+uVM4XTDui3h61kLtqctxWSbLxkjs8BXajJSQC/CV1fU5pHrCjSpKq90
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266340812"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="266340812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 16:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="662580069"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2022 16:16:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkZqb-0006g0-EW;
        Fri, 29 Apr 2022 23:16:25 +0000
Date:   Sat, 30 Apr 2022 07:15:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 280/410] lib/maple_tree.c:4207:20: warning: stack
 frame size (1088) exceeds limit (1024) in 'mas_wr_modify'
Message-ID: <202204300731.xnlH7nv1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   bf4803abaa3e9d2fa207c0675a2d2abf0fd44f66
commit: c11c433e3be4e5bef47f0a62a72064e18708e952 [280/410] Maple Tree: add new data structure
config: arm-moxart_defconfig (https://download.01.org/0day-ci/archive/20220430/202204300731.xnlH7nv1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/hnaz/linux-mm/commit/c11c433e3be4e5bef47f0a62a72064e18708e952
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout c11c433e3be4e5bef47f0a62a72064e18708e952
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/maple_tree.c:324:20: warning: unused function 'mte_set_full' [-Wunused-function]
   static inline void mte_set_full(const struct maple_enode *node)
                      ^
   lib/maple_tree.c:329:20: warning: unused function 'mte_clear_full' [-Wunused-function]
   static inline void mte_clear_full(const struct maple_enode *node)
                      ^
>> lib/maple_tree.c:4207:20: warning: stack frame size (1088) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
   static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
                      ^
   3 warnings generated.


vim +/mas_wr_modify +4207 lib/maple_tree.c

  4206	
> 4207	static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
  4208	{
  4209		unsigned char node_slots;
  4210		unsigned char node_size;
  4211		struct ma_state *mas = wr_mas->mas;
  4212		struct maple_big_node b_node;
  4213	
  4214		/* Direct replacement */
  4215		if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
  4216			rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
  4217			if (!!wr_mas->entry ^ !!wr_mas->content)
  4218				mas_update_gap(mas);
  4219			return;
  4220		}
  4221	
  4222		/* Attempt to append */
  4223		node_slots = mt_slots[wr_mas->type];
  4224		node_size = wr_mas->node_end - wr_mas->offset_end + mas->offset + 2;
  4225		if (mas->max == ULONG_MAX)
  4226			node_size++;
  4227	
  4228		/* slot and node store will not fit, go to the slow path */
  4229		if (unlikely(node_size >= node_slots))
  4230			goto slow_path;
  4231	
  4232		if (wr_mas->entry && (wr_mas->node_end < node_slots - 1) &&
  4233		    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
  4234				if (!wr_mas->content || !wr_mas->entry)
  4235					mas_update_gap(mas);
  4236				return;
  4237		}
  4238	
  4239		if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
  4240			return;
  4241		else if (mas_wr_node_store(wr_mas))
  4242			return;
  4243	
  4244		if (mas_is_err(mas))
  4245			return;
  4246	
  4247	slow_path:
  4248		memset(&b_node, 0, sizeof(struct maple_big_node));
  4249		mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
  4250		trace_ma_write(__func__, mas, 0, wr_mas->entry);
  4251		mas_commit_b_node(wr_mas, &b_node, wr_mas->node_end);
  4252	}
  4253	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
