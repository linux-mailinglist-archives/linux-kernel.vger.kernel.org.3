Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EB2569894
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiGGDIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiGGDIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:08:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD830F42
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:08:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LdhBJ1XdFzcmyV;
        Thu,  7 Jul 2022 11:06:00 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 11:08:02 +0800
Subject: Re: [mm-unstable PATCH v4 5/9] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-6-naoya.horiguchi@linux.dev>
 <9aba706c-b38f-f887-486e-b60c0025d9d8@huawei.com>
 <20220706230627.GB2560241@hori.linux.bs1.fc.nec.co.jp>
 <20220707013500.GA2578896@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <84243531-8c37-1bed-bfd9-36ed0ad0b809@huawei.com>
Date:   Thu, 7 Jul 2022 11:08:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220707013500.GA2578896@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/7/7 9:35, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Jul 06, 2022 at 11:06:28PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Wed, Jul 06, 2022 at 10:58:53AM +0800, Miaohe Lin wrote:
>>> On 2022/7/4 9:33, Naoya Horiguchi wrote:
>>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>
>>>> Raw error info list needs to be removed when hwpoisoned hugetlb is
>>>> unpoisoned.  And unpoison handler needs to know how many errors there
>>>> are in the target hugepage. So add them.
>>>>
>>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>> ---
>>>> @@ -2287,6 +2301,7 @@ int unpoison_memory(unsigned long pfn)
>>>
>>> Is it safe to unpoison hugepage when HPageRawHwpUnreliable? I'm afraid because
>>> some raw error info is missing..
>>
>> Ah, right. We need prevent it.  I'll fix it by inserting the check.
>>
>>  static inline long free_raw_hwp_pages(struct page *hpage, bool move_flag)
>>  {
>>          struct llist_head *head;
>>          struct llist_node *t, *tnode;
>>          long count = 0;
>>  
>> +        if (!HPageRawHwpUnreliable(hpage))
>> +                return 0;

IIUC, even if we return 0 here, the caller will still do TestClearPageHWPoison(please see below
code diff) and succeeds to unpoison the page. Or am I miss something?

@@ -2334,6 +2349,8 @@ int unpoison_memory(unsigned long pfn)

 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
+		if (PageHuge(p))
+			count = free_raw_hwp_pages(page, false);
 		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
 	} else if (ret < 0) {
 		if (ret == -EHWPOISON) {

> 
> No, I meant "if (HPageRawHwpUnreliable(hpage))", sorry for the noise :(

No, thanks for your hard work!

> 
> - Naoya Horiguchi

Thanks.

> 

