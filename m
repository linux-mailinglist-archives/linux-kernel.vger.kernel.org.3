Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25832508156
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350525AbiDTGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiDTGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:44:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10E3340DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650436900; x=1681972900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vxykZxzH8oZ0y8aC/wNv+t6K1cQ/j1YSAfUR65oTco4=;
  b=HLq6OvgqjO7zXhtQCR0koptqKHiTn3Pmbkh8ok0bp2vNytJlFoSDHk/R
   bzR7h/O/Eu8hmR+bw3l6FWmoaM7QMDieaG6ANC0keeyFshwkS8PIVgjX3
   hTxe2tj6JKYW12Bd9ABYYG+zkWP7CkZoY18jvN+8HLPEqR2O44vifj/MT
   ZomwyWfoqAef8FQbL9wlyzsKvCsoATX2IT91DrkhnjKOI5WY7W9WGma1Q
   YkGb2hrcO61JXBsOiGkyhrtqbZXlcEvj3CX1hGYUPDR59Q9JgQyzsmlEB
   TL7UEs9kguPWZc3LNO34UI/QdupI49K/z8HtTbcw7/r0EOc8wEUs+Kroc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263417181"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="263417181"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:41:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="576448341"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:41:35 -0700
Date:   Wed, 20 Apr 2022 14:39:38 +0800
From:   Philip Li <philip.li@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     kernel test robot <lkp@intel.com>, Peter Xu <peterx@redhat.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        apopple@nvidia.com, surenb@google.com, minchan@kernel.org,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: [PATCH] mm/swap: Fix lost swap bits in
 unuse_pte()
Message-ID: <Yl+qqmH19VxwgK4C@rli9-dbox>
References: <Yl8rZkhU/B0iE2ob@xz-m1.local>
 <202204201313.QYiDBRbL-lkp@intel.com>
 <c14c0865-867c-ca14-8b2c-7e6e94ee7c85@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14c0865-867c-ca14-8b2c-7e6e94ee7c85@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:23:27PM +0800, Miaohe Lin wrote:
> On 2022/4/20 13:56, kernel test robot wrote:
> > Hi Peter,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on hnaz-mm/master]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-swap-Fix-lost-swap-bits-in-unuse_pte/20220420-053845
> > base:   https://github.com/hnaz/linux-mm master
> > config: s390-randconfig-r023-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201313.QYiDBRbL-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install s390 cross compiling tool for clang build
> >         # apt-get install binutils-s390x-linux-gnu
> >         # https://github.com/intel-lab-lkp/linux/commit/355ac3eb45402f7aab25b76af029d4390af05238
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Peter-Xu/mm-swap-Fix-lost-swap-bits-in-unuse_pte/20220420-053845
> >         git checkout 355ac3eb45402f7aab25b76af029d4390af05238
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> 
> The variable name is newpte. But it's written as new_pte latter. Many thanks for report!
> 
> BTW: Since this is not a formal patch (no compile tested). Is Reported-by tag still needed?

thanks, this is not needed. It mostly needed for already upstreamed one
and actually not mandatory from 0-day ci perspective.

> 
> Thanks!
> 
> > All errors (new ones prefixed by >>):
> > 
> >>> mm/swapfile.c:1824:2: error: use of undeclared identifier 'new_pte'; did you mean 'newpte'?
> >            new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
> >            ^~~~~~~
> >            newpte
> >    mm/swapfile.c:1786:14: note: 'newpte' declared here
> >            pte_t *pte, newpte;
> >                        ^
> >    mm/swapfile.c:1826:26: error: use of undeclared identifier 'new_pte'
> >                    pte = pte_mksoft_dirty(new_pte);
> >                                           ^
> >    mm/swapfile.c:1828:23: error: use of undeclared identifier 'new_pte'
> >                    pte = pte_mkuffd_wp(new_pte);
> >                                        ^
> >    mm/swapfile.c:1829:36: error: use of undeclared identifier 'new_pte'; did you mean 'newpte'?
> >            set_pte_at(vma->vm_mm, addr, pte, new_pte);
> >                                              ^~~~~~~
> >                                              newpte
> >    mm/swapfile.c:1786:14: note: 'newpte' declared here
> >            pte_t *pte, newpte;
> >                        ^
> >    4 errors generated.
> ...
> >   1839	
> > 
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
