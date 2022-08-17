Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE93359674C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 04:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiHQCMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiHQCMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:12:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E999247
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:12:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M6s0t1R5czmVqw;
        Wed, 17 Aug 2022 10:10:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 10:12:17 +0800
Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
To:     Haiyue Wang <haiyue.wang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <apopple@nvidia.com>, <ying.huang@intel.com>,
        <songmuchun@bytedance.com>, <naoya.horiguchi@linux.dev>,
        <alex.sierra@amd.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-2-haiyue.wang@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5392ee32-e814-3f7c-a360-722ff5656cc7@huawei.com>
Date:   Wed, 17 Aug 2022 10:12:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220816022102.582865-2-haiyue.wang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/8/16 10:21, Haiyue Wang wrote:
> Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> will fail to get the page node information for some huge pages.
> 
> Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
> return NULL page for FOLL_GET when calling move_pages() syscall with the
> NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
> 
> Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
>       Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev
> 
> But these huge page APIs don't support FOLL_GET:
>   1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
>   2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
>      It will cause WARN_ON_ONCE for FOLL_GET.
>   3. follow_huge_pgd() in mm/hugetlb.c
> 
> This is an temporary solution to mitigate the side effect of the race
> condition fix by calling follow_page() with FOLL_GET set for huge pages.
> 
> After supporting follow huge page by FOLL_GET is done, this fix can be
> reverted safely.
> 
> Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array racing with memory offline")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

LGTM. Many thanks for fixing this.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin


