Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D84A3552
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiA3JYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiA3JYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:24:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED76C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 01:24:51 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nE6Rv-0001Py-Tf; Sun, 30 Jan 2022 10:24:44 +0100
Message-ID: <338bde65-5e1c-4e23-b4f2-671819c637cc@leemhuis.info>
Date:   Sun, 30 Jan 2022 10:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Chen Wandun <chenwandun@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        guillaume.tucker@collabora.com
Cc:     regressions@lists.linux.dev, Oscar Salvador <osalvador@suse.de>
References: <20220117142712.3967624-1-chenwandun@huawei.com>
 <b1966d11-e874-c71e-d14f-c0c88ace297e@suse.cz>
 <c0b74f54-c39a-51f7-08f8-701e9af94e56@huawei.com>
Content-Language: en-BS
Subject: Re: [PATCH] Revert "mm/page_isolation: unset migratetype directly for
 non Buddy page"
In-Reply-To: <c0b74f54-c39a-51f7-08f8-701e9af94e56@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643534691;6f0e646c;
X-HE-SMSGID: 1nE6Rv-0001Py-Tf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 26.01.22 03:18, Chen Wandun wrote:
> 在 2022/1/26 0:40, Vlastimil Babka 写道:
>> On 1/17/22 15:27, Chen Wandun wrote:
>>> This reverts commit 075782149abff45ee22f27315eced44d02b96779.
>>>
>>> commit 075782149abf ("mm/page_isolation: unset migratetype directly for
>> That's an old -next commit id, it went to mainline as 721fb891ad0b
>> ("mm/page_isolation: unset migratetype directly for non Buddy page")
>>
>>> non Buddy page") will result memory that should in buddy disappear by
>>> mistake. move_freepages_block move all pages in pageblock instead of
>>> pages indicated by input parameter, so if input pages is not in buddy
>>> but other pages in pageblock is in buddy, it will result in page out of
>>> control.
>>>
>>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> #regzbot ^introduced: 721fb891ad0b

Thx for getting regzbot involved, much appreciated.

>> There should better be also:
>>
>> Fixes: 721fb891ad0b ("mm/page_isolation: unset migratetype directly
>> for non
>> Buddy page")
>>
>> Especially as that commit had a (inadequate, IMHO, for an optimization)
>> Fixes: tag and could end up being backported somewhere without the
>> followup
>> fix/revert.
>
> thanks, I will send v2

Just wondering:

Andrew, I don't see this patch in the list of changes you sent to Linus
yesterday. Shouldn't it be in there due to above reason alone? And there
is another reason: it seems to be an issue people actually hit, as
Guenter mentioned in this thread. It thus complicates things for those
that want to help testing pre-releases.

Or am I missing something/asking too much in this case?

BTW, let's tell regzbot about v2:

#regzbot monitor:
https://lore.kernel.org/all/20220126024436.13921-1-chenwandun@huawei.com/

Ciao, Thorsten

>>> ---
>>>   mm/page_isolation.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index 6a0ddda6b3c5..f67c4c70f17f 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page
>>> *page, unsigned migratetype)
>>>        * onlining - just onlined memory won't immediately be
>>> considered for
>>>        * allocation.
>>>        */
>>> -    if (!isolated_page && PageBuddy(page)) {
>>> +    if (!isolated_page) {
>>>           nr_pages = move_freepages_block(zone, page, migratetype,
>>> NULL);
>>>           __mod_zone_freepage_state(zone, nr_pages, migratetype);
>>>       }
>> .
> 
> 
> 

