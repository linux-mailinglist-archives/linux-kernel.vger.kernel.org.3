Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD7E4E3688
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiCVCTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiCVCTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:19:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EBE31371
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:16:24 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KMw6f1gFxzfZW2;
        Tue, 22 Mar 2022 10:14:50 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 10:16:22 +0800
Subject: Re: [PATCH v2] mm/mempolicy: fix mpol_new leak in
 shared_policy_replace
To:     kernel test robot <lkp@intel.com>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <kosaki.motohiro@jp.fujitsu.com>, <mgorman@suse.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220322083456.16563-1-linmiaohe@huawei.com>
 <202203220336.VpfVL4ng-lkp@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1c2b6285-1404-4a80-73ec-4949f4eef09e@huawei.com>
Date:   Tue, 22 Mar 2022 10:16:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202203220336.VpfVL4ng-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/22 4:01, kernel test robot wrote:
> Hi Miaohe,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linux/master]
> [also build test ERROR on linus/master v5.17]
> [cannot apply to hnaz-mm/master next-20220321]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Miaohe-Lin/mm-mempolicy-fix-mpol_new-leak-in-shared_policy_replace/20220321-200100
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
> config: x86_64-randconfig-a002-20220321 (https://download.01.org/0day-ci/archive/20220322/202203220336.VpfVL4ng-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/9a91a8a7964a3af0b60f08dc38b7815e5118206a
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Miaohe-Lin/mm-mempolicy-fix-mpol_new-leak-in-shared_policy_replace/20220321-200100
>         git checkout 9a91a8a7964a3af0b60f08dc38b7815e5118206a
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> mm/mempolicy.c:2745:15: error: incompatible pointer types passing 'atomic_t *' to parameter of type 'refcount_t *' (aka 'struct refcount_struct *') [-Werror,-Wincompatible-pointer-types]
>            refcount_set(&mpol_new->refcnt, 1);
>                         ^~~~~~~~~~~~~~~~~
>    include/linux/refcount.h:134:45: note: passing argument to parameter 'r' here
>    static inline void refcount_set(refcount_t *r, int n)
>                                                ^
>    1 error generated.
> 

Many thanks for report. Commit 4fbd79de2889 ("mm/mempolicy: convert from atomic_t to refcount_t on mempolicy->refcnt") has
changed mpol_new->refcnt from atomic_t to refcount_t. So we should use refcount_set instead of atomic_set here.

Thanks.

> 
> vim +2745 mm/mempolicy.c
> 
>   2681	
>   2682	/* Replace a policy range. */
>   2683	static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>   2684					 unsigned long end, struct sp_node *new)
>   2685	{
>   2686		struct sp_node *n;
>   2687		struct sp_node *n_new = NULL;
>   2688		struct mempolicy *mpol_new = NULL;
>   2689		int ret = 0;
>   2690	
>   2691	restart:
>   2692		write_lock(&sp->lock);
>   2693		n = sp_lookup(sp, start, end);
>   2694		/* Take care of old policies in the same range. */
>   2695		while (n && n->start < end) {
>   2696			struct rb_node *next = rb_next(&n->nd);
>   2697			if (n->start >= start) {
>   2698				if (n->end <= end)
>   2699					sp_delete(sp, n);
>   2700				else
>   2701					n->start = end;
>   2702			} else {
>   2703				/* Old policy spanning whole new range. */
>   2704				if (n->end > end) {
>   2705					if (!n_new)
>   2706						goto alloc_new;
>   2707	
>   2708					*mpol_new = *n->policy;
>   2709					atomic_set(&mpol_new->refcnt, 1);
>   2710					sp_node_init(n_new, end, n->end, mpol_new);
>   2711					n->end = start;
>   2712					sp_insert(sp, n_new);
>   2713					n_new = NULL;
>   2714					mpol_new = NULL;
>   2715					break;
>   2716				} else
>   2717					n->end = start;
>   2718			}
>   2719			if (!next)
>   2720				break;
>   2721			n = rb_entry(next, struct sp_node, nd);
>   2722		}
>   2723		if (new)
>   2724			sp_insert(sp, new);
>   2725		write_unlock(&sp->lock);
>   2726		ret = 0;
>   2727	
>   2728	err_out:
>   2729		if (mpol_new)
>   2730			mpol_put(mpol_new);
>   2731		if (n_new)
>   2732			kmem_cache_free(sn_cache, n_new);
>   2733	
>   2734		return ret;
>   2735	
>   2736	alloc_new:
>   2737		write_unlock(&sp->lock);
>   2738		ret = -ENOMEM;
>   2739		n_new = kmem_cache_alloc(sn_cache, GFP_KERNEL);
>   2740		if (!n_new)
>   2741			goto err_out;
>   2742		mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>   2743		if (!mpol_new)
>   2744			goto err_out;
>> 2745		refcount_set(&mpol_new->refcnt, 1);
>   2746		goto restart;
>   2747	}
>   2748	
> 

