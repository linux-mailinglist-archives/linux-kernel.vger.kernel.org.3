Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9274FCFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349476AbiDLGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349211AbiDLGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:35:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA0B35A9B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649745207; x=1681281207;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPoxUfoq82bRd76a0An8mZp+NU2ywgcrUAbvXHKu904=;
  b=drHiUilVHAF9KpdZd3HDS2Ch9M6WCyxORQlmWvpvcLYFdDyL03L37jaP
   CZnzTTG3WtgR24caTMTgmoUQ69Gnj4KPpcs/L5Hjvr5UHbuaQyQbxa5/3
   tZFfEE/TDyv2nmLrnEwRSmiMdHrMXSnxAWp2juFKnEGsUWGvMsr+Aj0UL
   inKcQ9vXU0FKkzTvO+9/zrYWWaYyaB1x/TmQK73B9Z9uQOfUw6ftzKbOg
   QEqA8UmSqL64drzPf0XaEsxcR+0jIy7Qx9aC1f4GOaj+kf6IsaaUfDJE1
   z+XBkwoCTOhyZA+pHXam9tUtloKjyJ7jKmAFCD8XtQA5zhpigzpDQ//C7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322733851"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="322733851"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:33:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724308355"
Received: from joliu-mobl2.ccr.corp.intel.com ([10.254.214.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:33:21 -0700
Message-ID: <e1356503b9d434ebedf209ad8a0038b8d2f99f20.camel@intel.com>
Subject: Re: [PATCH 0/4] A few cleanup and fixup patches for migration
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ziy@nvidia.com, minchan@kernel.org, apopple@nvidia.com,
        dave.hansen@linux.intel.com, o451686892@gmail.com,
        jhubbard@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, osalvador@suse.de,
        david@redhat.com, sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 12 Apr 2022 14:33:13 +0800
In-Reply-To: <880376f0-f480-979b-261f-72cf9475474c@huawei.com>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
         <e268117b314817ecd4c07ac48b0a6dcaf680ed69.camel@intel.com>
         <880376f0-f480-979b-261f-72cf9475474c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 11:29 +0800, Miaohe Lin wrote:
> On 2022/4/12 10:25, ying.huang@intel.com wrote:
> > On Sat, 2022-04-09 at 15:38 +0800, Miaohe Lin wrote:
> > > Hi everyone,
> > > This series contains a few patches to remove unneeded lock page and
> > > PageMovable check, reduce the rcu lock duration. Also we fix potential
> > > pte_unmap on an not mapped pte. More details can be found in the
> > > respective changelogs. Thanks!
> > 
> > It appears that you ignored my comments for the previous version.  Can
> > you check it?
> 
> I do remember [1] and I tried to make isolate_huge_page consistent with isolate_lru_page.
> But their return value conventions are different. isolate_huge_page return 0 when
> success while isolate_huge_page returns true in this case. So make them consistent
> would lead to many code change. I should have added this in my changelog.

If you found new problem, you can reply to the original email.  Just
don't ignore the comments.

Best Regards,
Huang, Ying

> Thanks.
> 
> [1] https://lore.kernel.org/linux-mm/8735jsgctq.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 
> 
> > 
> > Best Regards,
> > Huang, Ying
> > 
> > > ---
> > > v1:
> > >   rebase [1] on mainline.
> > > 
> > > [1] https://lore.kernel.org/lkml/20220304093409.25829-2-linmiaohe@huawei.com/T/
> > > ---
> > > Miaohe Lin (4):
> > >   mm/migration: reduce the rcu lock duration
> > >   mm/migration: remove unneeded lock page and PageMovable check
> > >   mm/migration: return errno when isolate_huge_page failed
> > >   mm/migration: fix potential pte_unmap on an not mapped pte
> > > 
> > >  include/linux/migrate.h |  2 +-
> > >  include/linux/swapops.h |  4 ++--
> > >  mm/filemap.c            | 10 +++++-----
> > >  mm/hugetlb.c            |  2 +-
> > >  mm/migrate.c            | 31 +++++++++++++------------------
> > >  5 files changed, 22 insertions(+), 27 deletions(-)
> > > 
> > 
> > 
> > 
> > .
> > 
> 


