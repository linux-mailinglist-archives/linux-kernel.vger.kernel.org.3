Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7365532857
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiEXK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiEXK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:56:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275B183BC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:56:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6rjd50SgzDqLZ;
        Tue, 24 May 2022 18:56:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 18:56:39 +0800
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-5-linmiaohe@huawei.com>
 <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
 <970aee34-c377-2b8c-c6bb-45e2a96e84b9@huawei.com>
 <20220522235326.GA713751@hori.linux.bs1.fc.nec.co.jp>
 <7269c0c4-7648-a9dc-10fa-3645da5be441@huawei.com>
 <139b521b-f477-d108-79ed-4ea2bd76bdf3@huawei.com>
 <20220524064416.GB774480@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f1af5390-70f1-a231-cc37-c1fc671729d8@huawei.com>
Date:   Tue, 24 May 2022 18:56:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220524064416.GB774480@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/24 14:44, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, May 23, 2022 at 07:23:53PM +0800, Miaohe Lin wrote:
> ...
>>>
>>> I reproduced the deadloop issues when swapin error occurs at swapoff time in my linux-next-next-20220520 env,
>>> and I found this patch could solve the issue now with the fix in my another email.
>>>
>>> BTW: When I use dm-dust to inject the swapin IO error, I don't see non-uptodate folio when shmem_swapin_folio
>>> and swapoff succeeds. There might be some issues around that module (so I resort to the another way to inject
>>> the swapin error), but the patch itself works anyway. ;)
>>
>> Sorry, the reason I don't see non-uptodate folio when shmem_swapin_folio is that all the shmem pages are still
>> in the swapcache. They're not read from disk so there is no really IO error. :) When they're indeed freed, the
>> deadloop issue occurs.
>>
>> I am thinking about extending the function of MADV_PAGEOUT to free the swapcache page. The page resides in the
>> swapcache does not save the system memory anyway. And this could help test the swapin behavior. But I'm not
>> sure whether it's needed.
> 
> The extension make MADV_PAGEOUT free swapcaches makes sense to me,
> so I'll support it if the original implementer agrees the change.

I'd like trying to do it when I have time. :) Thanks!

> 
> Thanks,
> Naoya Horiguchi
> 

