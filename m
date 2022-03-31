Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF844ED51F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiCaIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiCaIER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:04:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B03DAFCB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648713748; x=1680249748;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=eBg9UJ10yPGgoudu4x1qv1vFubx6B7Wlrl2Xo90m9tQ=;
  b=POuEHMnf9nANeHNdiGo483aVSZBsoZr9zgkTLQSsuKQP74J4APOfZl6u
   espyahYu5sI4N+I5Nd4N1C5ceWfYEpq9+jQ4dF3zA6WkcA5R3aRj4rslU
   qEzvKMXpf6WQ8nEYoKUOI7UCdOphhxweHXRfM1Qn/MqlwLamfwTTn5VYT
   7Z/crVdGFj5nG8OGXzaziMobkgenSxaCgpPG9lL1fZelr1bkLjic7kz8n
   WUdxBo4XyvBOOAv6OsEEyS9kilv8WdFO8cbZ/4WDW31/eIn+6HLTr5sOU
   L8JC2W9FnsCAOJRQjzk71FqfbJPh6+FjnIc/8hvI0AxKnch5lQ0HBcXqY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259726383"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="259726383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:02:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="547211378"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:02:26 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/8] mm/vmscan: remove redundant folio_test_swapbacked
 check when folio is file lru
References: <20220329132619.18689-1-linmiaohe@huawei.com>
        <20220329132619.18689-2-linmiaohe@huawei.com>
        <CAMZfGtUPQvgaxG_6A0n6HwD9VjqbQUbnF99Ei9WpMZbTbnz4zg@mail.gmail.com>
        <87lewqbpad.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <7c8d06f6-ac41-d3d7-f6b6-20a06e56dc61@huawei.com>
Date:   Thu, 31 Mar 2022 16:02:24 +0800
In-Reply-To: <7c8d06f6-ac41-d3d7-f6b6-20a06e56dc61@huawei.com> (Miaohe Lin's
        message of "Thu, 31 Mar 2022 15:44:03 +0800")
Message-ID: <87czi2bldb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/3/31 14:37, Huang, Ying wrote:
>> Muchun Song <songmuchun@bytedance.com> writes:
>> 
>>> On Tue, Mar 29, 2022 at 9:26 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> When folio is file lru, folio_test_swapbacked is guaranteed to be true. So
>>>> it's unnecessary to check it here again. No functional change intended.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/vmscan.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 1678802e03e7..7c1a9713bfc9 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1434,8 +1434,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>>>>          * Anonymous pages are not handled by flushers and must be written
>>>>          * from reclaim context. Do not stall reclaim based on them
>>>>          */
>>>> -       if (!folio_is_file_lru(folio) ||
>>>> -           (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
>>>> +       if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
>>>
>>> At least your login is no problem since folio_is_file_lru() is equal to
>>> !folio_test_swapbacked().  But the new code is not clear to me.
>>> The old code is easy to understand, e.g. folio_test_anon(folio) &&
>>> !folio_test_swapbacked(folio) tells us that the anon pages which
>>> do not need to be swapped should be skipped.
>> 
>> That is for MADV_FREE pages.  The code is introduced in commit
>> 802a3a92ad7a ("mm: reclaim MADV_FREE pages").
>> 
>> So I think the original code is better.  It's an implementation detail
>> that folio_is_file_lru() equals !folio_test_swapbacked().  It may be
>> better to add some comments here for MADV_FREE pages.
>> 
>
> Do you tend to drop this patch or adding a comment with the change in this patch or something else?

I suggest to drop the code change and add a comment about MADV_FREE.

Best Regards,
Huang, Ying

> Thanks.
>
>>> So I'm neutral on the patch.
>> 
>> Best Regards,
>> Huang, Ying
>> .
>> 
