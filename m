Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FB56D2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiGKBzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKBzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:55:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A316428
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 18:55:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lh6My3bpyzhXYL;
        Mon, 11 Jul 2022 09:52:46 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 09:55:17 +0800
Subject: Re: [mm-unstable PATCH v5 1/8] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
 <20220708053653.964464-2-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b991a6ee-a075-a38b-3e53-3b4b51d0543c@huawei.com>
Date:   Mon, 11 Jul 2022 09:55:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220708053653.964464-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/7/8 13:36, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> I found a weird state of 1GB hugepage pool, caused by the following
> procedure:
> 
>   - run a process reserving all free 1GB hugepages,
>   - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
>     /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
>   - kill the reserving process.
> 
> , then all the hugepages are free *and* surplus at the same time.
> 
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   3
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
>   3
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
>   0
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
>   3
> 
> This state is resolved by reserving and allocating the pages then
> freeing them again, so this seems not to result in serious problem.
> But it's a little surprising (shrinking pool suddenly fails).
> 
> This behavior is caused by hstate_is_gigantic() check in
> return_unused_surplus_pages(). This was introduced so long ago in 2008
> by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
> at that time the gigantic pages were not supposed to be allocated/freed
> at run-time.  Now kernel can support runtime allocation/free, so let's
> check gigantic_page_runtime_supported() together.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
