Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EAA56D685
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiGKHPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiGKHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:15:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD221C119
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:14:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhFQW61LGzTgY0;
        Mon, 11 Jul 2022 15:10:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 15:14:07 +0800
Subject: Re: [mm-unstable PATCH v5 3/8] mm, hwpoison, hugetlb: support saving
 mechanism of raw error pages
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
References: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
 <20220708053653.964464-4-naoya.horiguchi@linux.dev>
 <b8f3f0a5-7a3b-1afb-ca1e-73ab384797b7@huawei.com>
 <20220711055047.GA2731632@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9bea0112-0e4f-fde7-411a-243b53c34b91@huawei.com>
Date:   Mon, 11 Jul 2022 15:14:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220711055047.GA2731632@hori.linux.bs1.fc.nec.co.jp>
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

On 2022/7/11 13:51, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Jul 11, 2022 at 11:26:34AM +0800, Miaohe Lin wrote:
>> On 2022/7/8 13:36, Naoya Horiguchi wrote:

<snip>

>> This patch looks good to me with below several possible problems:
>>
>> Should "nr_huge_pages" and "nr_huge_pages_node" be adjusted too? If it's called from dissolve_free_huge_page
>> and hugetlb_vmemmap_restore fails, add_hugetlb_page will be called:
>>
>> add_hugetlb_page:
>> 	...
>> 	h->nr_huge_pages++;
>> 	h->nr_huge_pages_node[nid]++;
>> 	   ^^^^^^^^1. the "nr_huge_pages" and "nr_huge_pages_node" might be incorrect?
>> 	...
>> 	zeroed = put_page_testzero(page);
>> 		 ^^^^^^^^2. VM_BUG_ON_PAGE(page_ref_count(page) == 0, page); will be triggered?
>>
>> Or am I miss something?
> 
> No, this code breaks the specific case, so I'd like to simply drop this if.
> HPageRawHwpUnreliable hugepage should be very rare, and calling page_mapped()
> for such a leaked page should be less common, so the impact of the slowdown
> should be minimal.

It makes sense for me to drop this if block.

Thanks.

> 
> Thanks,
> Naoya Horiguchi
> 

