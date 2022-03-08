Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850904D0D88
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiCHBcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiCHBci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:32:38 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70E387A7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:31:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V6b2FkD_1646703095;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6b2FkD_1646703095)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 09:31:36 +0800
Message-ID: <3d286f44-e91d-b68d-63f2-e66529e3fa54@linux.alibaba.com>
Date:   Tue, 8 Mar 2022 09:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 13/16] mm/migration: return errno when isolate_huge_page
 failed
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ying.huang@intel.com, ziy@nvidia.com, minchan@kernel.org,
        apopple@nvidia.com, ave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-14-linmiaohe@huawei.com>
 <c84c1a0a-66aa-915f-87d2-013ff0ac343c@linux.alibaba.com>
 <c6b117ba-948a-7f84-58f4-f0e3c5bd0a9c@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <c6b117ba-948a-7f84-58f4-f0e3c5bd0a9c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2022 8:20 PM, Miaohe Lin wrote:
> On 2022/3/7 10:14, Baolin Wang wrote:
>> Hi Miaohe,
>>
>> On 3/4/2022 5:34 PM, Miaohe Lin wrote:
>>> We should return errno (-EBUSY here) when failed to isolate the huge page
>>> rather than always return 1 which could confuse the user.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>    mm/migrate.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 6c2dfed2ddb8..279940c0c064 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1618,10 +1618,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>            goto out_putpage;
>>>          if (PageHuge(page)) {
>>> -        if (PageHead(page)) {
>>> -            isolate_huge_page(page, pagelist);
>>> -            err = 1;
>>> -        }
>>> +        if (PageHead(page))
>>> +            err = isolate_huge_page(page, pagelist) ? 1 : -EBUSY;
>>
>> Could you elaborate on which case the huge page isolation can be failed in this case? Or you met a real problem? Cause now we've got this head huge page refcnt, I can not see why we'll fail to isolate this huge page.
> 
> IIUC, this could happen when hugepage is under migration which cleared HPageMigratable. Page refcnt cannot
> prevent isolate_huge_page from happening. Or am I miss something?

Yes, that's possible. Thanks for your explanation. It will be better if 
you can copy the possible scenario description to the commit log to help 
other understand the issue.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
