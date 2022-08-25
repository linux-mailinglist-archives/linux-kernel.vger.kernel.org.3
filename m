Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F75A1667
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiHYQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiHYQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E117B115D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D83A61ADA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC67DC433C1;
        Thu, 25 Aug 2022 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661443809;
        bh=YeZpqXiWIj2UfGQAr0U2HYO2aQK9k8WY7/sp89p4GTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aaMwx8JKmkkb6t5r8pvyF2YpWKpX4SjF9KqZKXHKxAL2bkLj59sosnMbT7KLDUXeC
         MuZWH6jEnAENICgMXZmj9CyIeWZ+czj2hzTq+ho/6licNb3A79kj1ztNs829U+02RU
         8EP7yZJje2Ytht8AmmDi0pymRSWyH8oBa0sKGWHEODAaouA1/NuEvpUbZL2Lqg0iDx
         cgW2AjPInr+1TzJpqxo+ByAWUS0UB7hrTOBH8Eyt3bTQib9A/pAbTq+UycoR7NWyIR
         FD4f9HKnND++p5ItBYfnfD+z28AEdJcFaONZgYX4lKwG+PkJgLKel3wDhWV0ERgRBK
         DfrtefSXYKcuQ==
Date:   Thu, 25 Aug 2022 09:10:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Houghton <jthoughton@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Mina Almasry <almasrymina@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        llvm@lists.linux.dev
Subject: Re: [next] x86: fs/hugetlbfs/inode.c:673:16: error: variable
 'm_index' is uninitialized when used here [-Werror,-Wuninitialized]
Message-ID: <Ywee393cssPJ07Gr@dev-arch.thelio-3990X>
References: <CA+G9fYsHVdu0toduQqk6vsR8Z8mOVzZ9-_p3O5fjQ5mOpSxsDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsHVdu0toduQqk6vsR8Z8mOVzZ9-_p3O5fjQ5mOpSxsDA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Thu, Aug 25, 2022 at 04:13:30PM +0530, Naresh Kamboju wrote:
> The x86_64 and i386 clang builds failed due to these warnings / errors
> on Linux next-20220825.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> fs/hugetlbfs/inode.c:673:16: error: variable 'm_index' is
> uninitialized when used here [-Werror,-Wuninitialized]
>                                                 m_start, m_index, truncate_op);
>                                                          ^~~~~~~
> fs/hugetlbfs/inode.c:651:26: note: initialize the variable 'm_index'
> to silence this warning
>         pgoff_t m_start, m_index;
>                                 ^
>                                  = 0
> 1 error generated.

Thank you for the report! Commit fcc0d3d00d74 ("hugetlb: handle truncate
racing with page faults") introduced this warning; the Intel folks
caught this as well:

https://lore.kernel.org/202208251012.g1mOhhxy-lkp@intel.com/

As an aside, can you please update your contact for our mailing list to
llvm@lists.linux.dev? We do not use the Google Groups list anymore.

Cheers,
Nathan
