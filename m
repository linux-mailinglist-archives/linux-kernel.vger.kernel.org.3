Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB3545CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346264AbiFJHIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiFJHIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:08:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7039B9A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:08:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKBmQ4XzSzRhX2;
        Fri, 10 Jun 2022 15:04:54 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 15:08:08 +0800
Subject: Re: [mm-unstable v3 PATCH 0/7] Cleanup transhuge_xxx helpers
To:     Yang Shi <shy828301@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <vbabka@suse.cz>, <kirill.shutemov@linux.intel.com>,
        <willy@infradead.org>, <akpm@linux-foundation.org>
References: <20220606214414.736109-1-shy828301@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8ca53494-090f-a415-86cb-c942edfb89af@huawei.com>
Date:   Fri, 10 Jun 2022 15:08:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220606214414.736109-1-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/7 5:44, Yang Shi wrote:
> 
> v3: * Fixed the comment from Willy
> v2: * Rebased to the latest mm-unstable
>     * Fixed potential regression for smaps's THPeligible
> 
> This series is the follow-up of the discussion about cleaning up transhuge_xxx
> helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.
> 
> THP has a bunch of helpers that do VMA sanity check for different paths, they
> do the similar checks for the most callsites and have a lot duplicate codes.
> And it is confusing what helpers should be used at what conditions.

Yes, these helpers really confused me when I read the code. Thanks for doing this!

> 
> This series reorganized and cleaned up the code so that we could consolidate
> all the checks into hugepage_vma_check().
> 
> The transhuge_vma_enabled(), transparent_hugepage_active() and
> __transparent_hugepage_enabled() are killed by this series.
> 
> Added transhuge_vma_size_ok() helper to remove some duplicate code.
> 
> 
> Yang Shi (7):
>       mm: khugepaged: check THP flag in hugepage_vma_check()
>       mm: thp: introduce transhuge_vma_size_ok() helper
>       mm: khugepaged: remove the redundant anon vma check
>       mm: khugepaged: use transhuge_vma_suitable replace open-code
>       mm: thp: kill transparent_hugepage_active()
>       mm: thp: kill __transhuge_page_enabled()
>       mm: khugepaged: reorg some khugepaged helpers
> 
>  fs/proc/task_mmu.c         |  2 +-
>  include/linux/huge_mm.h    | 84 ++++++++++++++++++++++++++++------------------------------------------
>  include/linux/khugepaged.h | 21 ++----------------
>  mm/huge_memory.c           | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>  mm/khugepaged.c            | 78 +++++++++++++++--------------------------------------------------
>  mm/memory.c                |  7 ++++--
>  6 files changed, 114 insertions(+), 142 deletions(-)
> 
> 
> 
> .
> 

