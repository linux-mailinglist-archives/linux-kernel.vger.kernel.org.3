Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A724ED808
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiCaK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiCaK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:58:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259E1E5A66
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:56:28 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KTgFz2MNRzdZLs;
        Thu, 31 Mar 2022 18:56:07 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 18:56:26 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 18:56:26 +0800
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Liu Shixin <liushixin2@huawei.com>
CC:     <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question about hwpoison handling of 1GB hugepage
Message-ID: <0af88a11-4dfe-9a4e-7b94-08f12caafcf3@huawei.com>
Date:   Thu, 31 Mar 2022 18:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently, I found a problem with hwpoison 1GB hugepage.
I created a process and mapped 1GB hugepage. This process will then fork a
child process and write/read this 1GB hugepage. Then I inject hwpoison into
this 1GB hugepage. The child process triggers the memory failure and is
being killed as expected. After this, the parent process will try to fork a
new child process and do the same thing. It is killed again and finally it
goes into such an infinite loop. I found this was caused by
commit 31286a8484a8 ("mm: hwpoison: disable memory error handling on 1GB hugepage")

It looks like there is a bug for hwpoison 1GB hugepage so I try to reproduce
the bug described. After trying to revert the patch in an earlier version of
the kernel, I reproduce the bug described. Then I try to revert the patch in
latest version, and find the bug is no longer reproduced.

I compare the code paths of 1 GB hugepage and 2 MB hugepage for second madvise(MADV_HWPOISON),
and find that the problem is caused because in gup_pud_range(), pud_none() and
pud_huge() both return false and then trigger the bug. But in gup_pmd_range(),
the pmd_none() is modified to pmd_present() which will make code return directly.
The I find that it is commit 15494520b776 ("mm: fix gup_pud_range") which
cause latest version not reproduced. I backport commit 15494520b776 in
earlier version and find the bug is no longer reproduced either.

So I'd like to consult that is it the time to revert commit 31286a8484a8?
Or if we modify pud_huge to be similar with pmd_huge, is it sufficient?

I also noticed there is a TODO comment in memory_failure_hugetlb():
    - conversion of a pud that maps an error hugetlb into hwpoison
      entry properly works, and
    - other mm code walking over page table is aware of pud-aligned
      hwpoison entries. 

I'm not sure whether the above fix are sufficient, so is there anything else need
to analysis that I haven't considered?

Thanks,

