Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FC5A33C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiH0CSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiH0CSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:18:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E71E3E0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:18:46 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MF0hF1rX6zGpHJ;
        Sat, 27 Aug 2022 10:17:01 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 10:18:43 +0800
Subject: Re: [PATCH 08/10] hugetlb: remove unneeded SetHPageVmemmapOptimized()
To:     Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-9-linmiaohe@huawei.com>
 <A1ED2200-136D-477E-B1EC-E61E6B75931B@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e367da7d-7964-7531-3dcb-0ad7964ffdaa@huawei.com>
Date:   Sat, 27 Aug 2022 10:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <A1ED2200-136D-477E-B1EC-E61E6B75931B@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 2022/8/27 9:35, Muchun Song wrote:
> 
> 
>> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> If code reaches here, it's guaranteed that HPageVmemmapOptimized is set
>> for the hugetlb page (or VM_BUG_ON_PAGE() will complain about it). It's
> 
> Hi Miaohe,
> 
> Right.
> 
>> unnecessary to set it again.
> 
> No, I suppose you didn’t test this patch since it does not work. The
> HPageVmemmapOptimized is cleared in the above code of line
> (set_page_private(page, 0)). So NAck.

Sorry, I missed that and thanks for pointing this out. Does this code deserves a
comment like below?

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d64d718..3374c1d2b52e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1522,6 +1522,10 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,

        set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
        set_page_private(page, 0);
+       /*
+        * We have to set HPageVmemmapOptimized again as above
+        * set_page_private(page, 0) cleared it.
+        */
        SetHPageVmemmapOptimized(page);

        /*


Thanks,
Miaohe Lin
