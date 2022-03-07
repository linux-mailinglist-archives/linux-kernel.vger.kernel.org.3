Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B834CF084
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiCGDpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiCGDpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:45:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74F05D5CE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:44:23 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KBknJ70F0zdZwS;
        Mon,  7 Mar 2022 11:43:00 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 11:44:21 +0800
Subject: Re: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-2-linmiaohe@huawei.com>
 <20220304082624.GA3778609@hori.linux.bs1.fc.nec.co.jp>
 <79f79813-bb9a-bfff-0837-a24d14da0b19@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <999a0f88-9465-0c93-e922-8aa80fa64f81@huawei.com>
Date:   Mon, 7 Mar 2022 11:44:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <79f79813-bb9a-bfff-0837-a24d14da0b19@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/5 3:32, Mike Kravetz wrote:
> On 3/4/22 00:26, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Mon, Feb 28, 2022 at 10:02:42PM +0800, Miaohe Lin wrote:
>>> There is a race window where we got the compound_head, the hugetlb page
>>> could be freed to buddy, or even changed to another compound page just
>>> before we try to get hwpoison page. If this happens, just bail out.
>>
>> I think that when some hugetlb page is about to change into other type/size
>> of compound page, it has to go through buddy allocator because hugetlb pages
>> are maintained in separate memory allocator and they never change into other
>> normal state directly.  memory_failure_hugetlb() takes refcount before
>> lock_page(), so the hugetlb page seems not change between get_hwpoison_page()
>> and lock_page(). So it this new check really necessary?
> 
> A hugetlb page could change size without going through buddy via the new
> demote functionality [1].  Only hugetlb pages on the hugetlb free list can
> be demoted.  
> 
> We should not demote a page if poison is set.  However, there is no check in
> the demote code.  IIUC, poison is set early in the memory error handling
> process, even before taking ref on page.  Demote code needs to be fixed so
> that poisoned pages are not demoted.  I can do that.
> 
> With this change in place, then I think Naoya's statement that hugetlb pages
> can not change state is correct and this patch is not necessary.
> 

Sorry for my confusing commit words. What I mean to tell is indeed the below race:
  CPU 1							CPU 2
  memory_failure_hugetlb
  struct page *head = compound_head(p);
							hugetlb page is freed to buddy, or
							even changed to another compound page
							as we haven't held the page refcnt now
  get_hwpoison_page -- page is not what we want now...

Does this make sense for both of you? Many thanks for comment and reply! :)

> Does that sound reasonable?
> 
> [1] https://lore.kernel.org/linux-mm/20211007181918.136982-1-mike.kravetz@oracle.com/

This is really a nice feature. Thanks.

> 
