Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE5A4CF2C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiCGHnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiCGHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:43:50 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F1FDC5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646638976; x=1678174976;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=xGo0CJRvzx+mTrNlJbZeUJJRYAUz9l3q4pCLsrKvBig=;
  b=W7gI3CAzGHcElDiD/4U307vRhU0xGvhK4AHPOnIvwd0qyrys2XSwfvUT
   SY2MsTRCATWNnJKCiBScybnLeU1tWh/UvhmNSkydAchboRNR4VdFx/izu
   gj+hf3/bzhWjX/S/mQOVITI5eeUIMkplJ3jx+c0OP4jwj04/7gXlnY348
   9C9VbVuqi70EbkFc8sqQZXQdCKhMAx64rLETc2YLonBuXZWqy8mBmGFH+
   NoSYcHQ9nq/rvYAoDbEAg++NAjxhcKfMGhPEQf9fEEfElByni82iQajP5
   6mFp745ZxQEEH8xWdfCb/23meyXMQBVZCghPfDuUvkfIGzTgKidu4/1X9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254516282"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="254516282"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 23:42:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="494970498"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 23:42:50 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        ave.hansen@linux.intel.com, o451686892@gmail.com,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggA==?=
         =?utf-8?B?5Y+jIOebtOS5nyk=?= <naoya.horiguchi@nec.com>,
        Michal Hocko <mhocko@suse.com>, riel@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 15/16] mm/migration: fix possible do_pages_stat_array
 racing with memory offline
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-16-linmiaohe@huawei.com>
        <875yoq5od4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAMZfGtXKa73ZVLtJeE5O40rOgn7oZkxP5CB+q5t--ihUerfKew@mail.gmail.com>
Date:   Mon, 07 Mar 2022 15:42:43 +0800
In-Reply-To: <CAMZfGtXKa73ZVLtJeE5O40rOgn7oZkxP5CB+q5t--ihUerfKew@mail.gmail.com>
        (Muchun Song's message of "Mon, 7 Mar 2022 15:01:12 +0800")
Message-ID: <87r17emcng.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song <songmuchun@bytedance.com> writes:

> On Mon, Mar 7, 2022 at 1:22 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>
>> > When follow_page peeks a page, the page could be reclaimed under heavy
>> > memory pressure
>>
>> I don't think that memory pressure and reclaiming will be an issue.
>
> I think he means a page first to be reclaimed then to be offline
> could encounter this issue and reclaiming is a precondition.

I don't think reclaiming is a precondition.  It seems possible that the
virtual page is migrated, then the physical page is offlined.

Best Regards,
Huang, Ying

> Thanks.
>
>>
>> > and thus be offlined while it's still being used by the
>> > do_pages_stat_array().
>>
>> "offline" seems a possible problem.
