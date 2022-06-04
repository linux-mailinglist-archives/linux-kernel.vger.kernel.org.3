Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C453D81B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiFDScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiFDSci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 14:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DD6DFE4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 11:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76045B8013B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 18:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E605FC385B8;
        Sat,  4 Jun 2022 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654367555;
        bh=ysqPwP/wqkdmiymo7y3Y0C2os7PDLtfEfzoXPROtBOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GdSlIPd5ooj+owxk+noEMsEWzCN8SmMmgIlbA/avre5Goc1/E+v+IdcMO0St95jiU
         SG52OypF6Z4K7sDBbvnsnuKdcMoOoyrijj6nHUYmOg+EMYyDDoiFcI9FebLHImY0qm
         Yjcbyh2WA9F9PP67ZgZHJojSRG8BKzzJO6T4UdlI=
Date:   Sat, 4 Jun 2022 11:32:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [akpm-mm:mm-unstable 168/180] mm/memory-failure.c:1740:7:
 error: call to undeclared function 'mf_generic_kill_procs'; ISO C99 and
 later do not support implicit function declarations
Message-Id: <20220604113234.6b5cd3cd12335acc5e450286@linux-foundation.org>
In-Reply-To: <202206042127.sGqAcR3f-lkp@intel.com>
References: <202206042127.sGqAcR3f-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022 21:55:44 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   f06e3c5104126b9a6660b58f29619b53bfa33b2b
> commit: 92eb33ec5ea377357ff8087197209cbfbf40dbf9 [168/180] mm: factor helpers for memory_failure_dev_pagemap
> config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220604/202206042127.sGqAcR3f-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=92eb33ec5ea377357ff8087197209cbfbf40dbf9
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch --no-tags akpm-mm mm-unstable
>         git checkout 92eb33ec5ea377357ff8087197209cbfbf40dbf9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/memory-failure.c:1740:7: error: call to undeclared function 'mf_generic_kill_procs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            rc = mf_generic_kill_procs(pfn, flags, pgmap);
>                 ^
>    1 error generated.

Thanks, I did this:

--- a/mm/memory-failure.c~mm-factor-helpers-for-memory_failure_dev_pagemap-fix
+++ a/mm/memory-failure.c
@@ -1714,12 +1714,21 @@ out:
 	unlock_page(head);
 	return res;
 }
+
 #else
+
+static inline int mf_generic_kill_procs(unsigned long long pfn, int flags,
+					struct dev_pagemap *pgmap)
+{
+	return 0;
+}
+
 static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
 {
 	return 0;
 }
-#endif
+
+#endif	/* CONFIG_HUGETLB_PAGE */
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
_

