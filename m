Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9603255D636
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbiF1DBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiF1DBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:01:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866D4F7D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:01:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LX8Sq1HCczkWJn;
        Tue, 28 Jun 2022 10:59:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 11:01:12 +0800
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
 <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
 <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
 <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
 <YrYMS5sATPzEgUxb@monkey>
 <20220627060231.GA2159330@hori.linux.bs1.fc.nec.co.jp>
 <Yrnn+QS8JCMT/3JV@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <227ccd06-a945-e4c5-8cff-37817f777781@huawei.com>
Date:   Tue, 28 Jun 2022 11:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yrnn+QS8JCMT/3JV@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/6/28 1:25, Mike Kravetz wrote:
> On 06/27/22 06:02, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Fri, Jun 24, 2022 at 12:11:07PM -0700, Mike Kravetz wrote:
>>> On 06/24/22 08:34, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>> On Fri, Jun 24, 2022 at 04:15:19PM +0800, Miaohe Lin wrote:
>>>>> On 2022/6/24 16:03, Muchun Song wrote:
>>>>>> On Fri, Jun 24, 2022 at 10:25:48AM +0800, Miaohe Lin wrote:
>>>>>>> On 2022/6/24 7:51, Naoya Horiguchi wrote:
>>>>>>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>>>>
>>>>>>> IIUC it might be better to do the below check:
>>>>>>> 	/*
>>>>>>> 	 * Cannot return gigantic pages currently if runtime gigantic page
>>>>>>> 	 * allocation is not supported.
>>>>>>> 	 */
>>>>>>> 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>>>>>>> 		goto out;
>>>>>>>
>>>>>>
>>>>>> The change looks good to me. However, the comments above is unnecessary
>>>>>> since gigantic_page_runtime_supported() is straightforward.
>>>>>
>>>>> Agree. The comments can be removed.
>>>>
>>>> Thank you, both. Adding !gigantic_page_runtime_supported without comment
>>>> makes sense to me.
>>>
>>> The change above makes sense to me.  However, ...
>>>
>>> If we make the change above, will we have the same strange situation described
>>> in the commit message when !gigantic_page_runtime_supported() is true?
>>>
>>> IIUC, !gigantic_page_runtime_supported implies that gigantic hugetlb
>>> pages can not be allocated or freed at run time.  They can only be
>>> allocated at boot time.  So, there should NEVER be surplus gigantic
>>> pages if !gigantic_page_runtime_supported().
>>
>> I have the same understanding as the above.
>>
>>>  To avoid this situation,
>>> perhaps we should change set_max_huge_pages as follows (not tested)?
>>
>> The suggested diff looks clearer about what it does, so I'd like to take it
>> in the next version.  Then, what do we do on the "if (hstate_if_gigantic())"
>> check in return_unused_surplus_pages in the original suggestion?  Should it
>> be kept as is, or removed, or checked with !gigantic_page_runtime_supported()?
>> I guess that the new checks prevent calling return_unused_surplus_pages()
>> during pool shrinking, so the check seems not necessary any more.
> 
> My first thought was to keep the check in return_unused_surplus_pages() as it
> is called in other code paths.  However, it SHOULD only try to free surplus
> hugetlb pages.  With the modifications to set_max_huge_pages we will not
> have any surplus gigantic pages if !gigantic_page_runtime_supported, so
> the check can be removed.
> 
> Also note that we never try to dynamically allocate surplus gigantic pages.
> This also is left over from the time when we could not easily allocate a
> gigantic page at runtime.  It would not surprise me if someone found a use
> case to ease this restriction in the future.  Especially so if 1G THP support
> is ever added.  If this happens, the check would be necessary and I would
> guess that it would not be added.
> 
> Sorry for thinking our loud!!!  Although not necessary, it 'might' be a good
> idea to leave the check because it would be overlooked if dynamic allocation
> of gigantic surplus pages is ever added.  I do not have a strong opinion.
> 
> P.S. This also reminds me that a similar check should be added to the
> demote hugetlb code path.  It would be bad if !gigantic_page_runtime_supported
> and we demoted a gigantic page into numerous non-gigantic pages.  I will
> send a patch.

Out-of-topic
There're some places check "if (hstate_is_gigantic(h))" while others check
"if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())". Should
we make it explicit in some manner when gigantic_page_runtime_supported is
needed to make code easier to follow?

Just a trivial suggestion. Thanks!

> 
