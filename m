Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35154BE267
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358873AbiBUNT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:19:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358867AbiBUNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:19:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D831EEDA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:19:32 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K2NCc5QY4zdZPp;
        Mon, 21 Feb 2022 21:18:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 21:19:30 +0800
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
To:     Oscar Salvador <osalvador@suse.de>
CC:     Rik van Riel <riel@surriel.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220212213740.423efcea@imladris.surriel.com>
 <Yguh5JUGHln/iRJ8@localhost.localdomain>
 <e6eeb84f-cf1d-493e-ce8e-fea6f3679a9e@huawei.com>
 <YhOLmvLKOCO0qDIe@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <80df0575-6f61-ccad-833a-b4f5b3d42628@huawei.com>
Date:   Mon, 21 Feb 2022 21:19:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YhOLmvLKOCO0qDIe@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/2/21 20:54, Oscar Salvador wrote:
> On Wed, Feb 16, 2022 at 10:13:14AM +0800, Miaohe Lin wrote:
>> IIUC, this could not happen when soft-offlining a pagecache page. They're either
>> invalidated or migrated away and then we set PageHWPoison.
>> I think this may happen on a clean pagecache page when it's isolated. So it's !PageLRU.
>> And identify_page_state treats it as me_unknown because it's non reserved, slab, swapcache
>> and so on ...(see error_states for details). Or am I miss anything?
> 
> But the path you are talking about is when we do have a non-recoverable
> error, so memory_failure() path.
> AFAIU, Rik talks about pages with corrected errors, and that is
> soft_offline().

Oh, yes, Rik talks about pages with corrected errors. My mistake. Then I really
want to understand how we got there too. :)

Thanks.

> 

