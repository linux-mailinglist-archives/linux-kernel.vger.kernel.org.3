Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E84D1656
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbiCHLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiCHLen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:34:43 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF093BA47
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:33:46 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KCY4S2c82z1GBw6;
        Tue,  8 Mar 2022 19:28:56 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:33:43 +0800
Subject: Re: [PATCH 15/16] mm/migration: fix possible do_pages_stat_array
 racing with memory offline
To:     "Huang, Ying" <ying.huang@intel.com>,
        Muchun Song <songmuchun@bytedance.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        Mina Almasry <almasrymina@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Michal Hocko <mhocko@suse.com>,
        <riel@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-16-linmiaohe@huawei.com>
 <875yoq5od4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMZfGtXKa73ZVLtJeE5O40rOgn7oZkxP5CB+q5t--ihUerfKew@mail.gmail.com>
 <87r17emcng.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <05c39882-0d61-92cb-9c63-479ea6dffb63@huawei.com>
Date:   Tue, 8 Mar 2022 19:33:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87r17emcng.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 15:42, Huang, Ying wrote:
> Muchun Song <songmuchun@bytedance.com> writes:
> 
>> On Mon, Mar 7, 2022 at 1:22 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> When follow_page peeks a page, the page could be reclaimed under heavy
>>>> memory pressure
>>>
>>> I don't think that memory pressure and reclaiming will be an issue.
>>
>> I think he means a page first to be reclaimed then to be offline
>> could encounter this issue and reclaiming is a precondition.
> 
> I don't think reclaiming is a precondition.  It seems possible that the
> virtual page is migrated, then the physical page is offlined.
> 

What I indeed mean is a page could first be reclaimed, migrated and so on.
And then be offlined. Sorry for confusing.

Thanks both of you.

> Best Regards,
> Huang, Ying
> 
>> Thanks.
>>
>>>
>>>> and thus be offlined while it's still being used by the
>>>> do_pages_stat_array().
>>>
>>> "offline" seems a possible problem.
> .
> 

