Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA05D520E60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiEJHe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiEJHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:02:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F67485B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:58:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ky84M29fVzhZ3M;
        Tue, 10 May 2022 14:57:39 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 14:58:05 +0800
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
 <20220510061712.GA162496@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2a95aebe-3a00-4699-12d4-fc5d934dde2c@huawei.com>
Date:   Tue, 10 May 2022 14:58:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220510061712.GA162496@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 14:17, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sun, Apr 24, 2022 at 05:11:03PM +0800, Miaohe Lin wrote:
>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>> page filled with random data is mapped into user address space.  In case
>> of error, a special swap entry indicating swap read fails is set to the
>> page table.  So the swapcache page can be freed and the user won't end up
>> with a permanently mounted swap because a sector is bad.  And if the page
>> is accessed later, the user process will be killed so that corrupted data
>> is never consumed.  On the other hand, if the page is never accessed, the
>> user won't even notice it.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> When I reproduced the issue (generated read error with dm-dust), I saw
> infinite loop in the while loop in shmem_unuse_inode() (and this happens
> even with this patch). I confirmed that shmem_swapin_page() returns -EIO,
> but shmem_unuse_swap_entries() does not return the error to the callers,
> so the while loop in shmem_unuse_inode() seems not break.
> 

Many thanks for your report! I didn't test the shmem case because I saw -EIO
is returned. So I just focus on the normal page case. Sorry about it. :(

> So maybe you need more code around shmem_unuse_inode() to handle the error?

I will try to reproduce it and come up a fixup patch asap! And if you like, you
can kindly solve this issue too. ;)

Thanks a lot!

> 
> Thanks,
> Naoya Horiguchi
> 

