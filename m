Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073594ED3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiCaGjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCaGjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:39:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1D103DBA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648708670; x=1680244670;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MiCqQF7S4WcgWnmHfvAOH9kXcPnWEw2B7ho8mOJRjfk=;
  b=CbKNgb4FQ7jhr2ALttF4srvb4xECe7l/IEDWaf0YlkQeO/APYCmPCtJN
   cKHZOyyXBSoYerSRDioerEZJJHixR4Zvx1byWiZDMV9OSpOnvSvlPI1V2
   s4rq5zdZgwQu9emZgKNYscARfez8XGv2E0VTsn10dO8cI7zmKyRqcWol+
   CheoAuUDFptOAScVsnIz2sMArivV0Z+7UMIjnlOdpQlTulQOVqLi8S6ss
   SHx+opNfIKvzPenWjcuyVs2417DlLG6UqEXmqaUrXzeY12r6LI6ROehf9
   6Y7tYIQlTVp89NJMr3d9zD0+4ta0wBFP49A+VoxfpXvCz3tZYWjYqNs5b
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239661723"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="239661723"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:37:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="547182921"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:37:48 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] mm/vmscan: remove redundant folio_test_swapbacked
 check when folio is file lru
References: <20220329132619.18689-1-linmiaohe@huawei.com>
        <20220329132619.18689-2-linmiaohe@huawei.com>
        <CAMZfGtUPQvgaxG_6A0n6HwD9VjqbQUbnF99Ei9WpMZbTbnz4zg@mail.gmail.com>
Date:   Thu, 31 Mar 2022 14:37:46 +0800
In-Reply-To: <CAMZfGtUPQvgaxG_6A0n6HwD9VjqbQUbnF99Ei9WpMZbTbnz4zg@mail.gmail.com>
        (Muchun Song's message of "Wed, 30 Mar 2022 16:13:06 +0800")
Message-ID: <87lewqbpad.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song <songmuchun@bytedance.com> writes:

> On Tue, Mar 29, 2022 at 9:26 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> When folio is file lru, folio_test_swapbacked is guaranteed to be true. So
>> it's unnecessary to check it here again. No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 1678802e03e7..7c1a9713bfc9 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1434,8 +1434,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>>          * Anonymous pages are not handled by flushers and must be written
>>          * from reclaim context. Do not stall reclaim based on them
>>          */
>> -       if (!folio_is_file_lru(folio) ||
>> -           (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
>> +       if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
>
> At least your login is no problem since folio_is_file_lru() is equal to
> !folio_test_swapbacked().  But the new code is not clear to me.
> The old code is easy to understand, e.g. folio_test_anon(folio) &&
> !folio_test_swapbacked(folio) tells us that the anon pages which
> do not need to be swapped should be skipped.

That is for MADV_FREE pages.  The code is introduced in commit
802a3a92ad7a ("mm: reclaim MADV_FREE pages").

So I think the original code is better.  It's an implementation detail
that folio_is_file_lru() equals !folio_test_swapbacked().  It may be
better to add some comments here for MADV_FREE pages.

> So I'm neutral on the patch.

Best Regards,
Huang, Ying
