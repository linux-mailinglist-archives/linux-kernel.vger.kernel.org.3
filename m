Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9544901F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiAQG3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:29:49 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31095 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiAQG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:29:48 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jchk40xD1z1FCjZ;
        Mon, 17 Jan 2022 14:26:04 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 14:29:46 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 14:29:46 +0800
Message-ID: <be27d5e3-43e6-a627-06a4-1e2c7580ecaf@huawei.com>
Date:   Mon, 17 Jan 2022 14:29:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/page_isolation: unset migratetype directly for non
 Buddy page
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>,
        "kernelci@groups.io" <kernelci@groups.io>
References: <20211229033649.2760586-1-chenwandun@huawei.com>
 <a47126ee-ba7c-30b5-836a-f4a9f098fcb1@collabora.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <a47126ee-ba7c-30b5-836a-f4a9f098fcb1@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/1/15 4:50, Guillaume Tucker 写道:
> Hi Chen,
>
> Please see the bisection report below about a boot failure on
> Meson arm64 platforms as well as QEMU when enabling 64K pages.
>
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
>
> Some more details can be found here:
>
>    QEMU: https://linux.kernelci.org/test/case/id/61dfcaa1dee57d03ffef673e/
>    ODROID-N2: https://linux.kernelci.org/test/case/id/61dfc93ac88e282ca8ef676b/
>
> Here's a sample log showing some OOM errors before hitting a
> kernel panic:
>
>    https://storage.kernelci.org/next/master/next-20220113/arm64/defconfig+config_arm64_64k_pages=y/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2.html
>
> <4>[   24.666707] Out of memory and no killable processes...
> <0>[   24.672056] Kernel panic - not syncing: System is deadlocked on memory
>
> Please let us know if you need any help to debug this issue or if
> you have a fix to try.
>
> Best wishes,
> Guillaume
>
>
> GitHub: https://github.com/kernelci/kernelci-project/issues/91
>
> -------------------------------------------------------------------------------
>
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> next/master bisection: baseline.login on meson-g12b-odroid-n2
>
> Summary:
>    Start:      27c9d5b3c24a Add linux-next specific files for 20220113
>    Plain log:  https://storage.kernelci.org/next/master/next-20220113/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2.txt
>    HTML log:   https://storage.kernelci.org/next/master/next-20220113/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2.html
>    Result:     075782149abf mm/page_isolation: unset migratetype directly for non Buddy page
>
> Checks:
>    revert:     PASS
>    verify:     PASS
>
> Parameters:
>    Tree:       next
>    URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>    Branch:     master
>    Target:     meson-g12b-odroid-n2
>    CPU arch:   arm64
>    Lab:        lab-baylibre
>    Compiler:   gcc-10
>    Config:     defconfig+CONFIG_ARM64_64K_PAGES=y
>    Test case:  baseline.login
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit 075782149abff45ee22f27315eced44d02b96779
> Author: Chen Wandun <chenwandun@huawei.com>
> Date:   Thu Dec 30 20:28:40 2021 +1100
>
>      mm/page_isolation: unset migratetype directly for non Buddy page
>
> On 29/12/2021 03:36, Chen Wandun wrote:
>> There is no need to try to move_freepages_block for pages that is not
>> in buddy in function unset_migratetype_isolate, it can directly set
>> migrate type.
>>
>> It will save a few cpu cycles for some situations such as cma and
>> hugetlb when allocating continue pages, in these situation function
>> alloc_contig_pages will be called.
>>
>> alloc_contig_pages
>> 	__alloc_contig_migrate_range
>> 	isolate_freepages_range ==> pages has been remove from buddy
>> 	undo_isolate_page_range
>> 		unset_migratetype_isolate ==> can directly set migratetype
>>
>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   mm/page_isolation.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index f67c4c70f17f..6a0ddda6b3c5 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>   	 * onlining - just onlined memory won't immediately be considered for
>>   	 * allocation.
>>   	 */
>> -	if (!isolated_page) {
>> +	if (!isolated_page && PageBuddy(page)) {
>>   		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>>   		__mod_zone_freepage_state(zone, nr_pages, migratetype);
>>   	}
This patch should be reverted, It has some difference compared with 
original logic，and
will result  memory that should in buddy disappear by mistake.

Thanks  Guillaume
>
> Git bisection log:
>
> -------------------------------------------------------------------------------
> git bisect start
> # good: [81ff0be4b9e3bcfee022d71cf89d72f7e2ed41ba] Merge tag 'spdx-5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx
> git bisect good 81ff0be4b9e3bcfee022d71cf89d72f7e2ed41ba
> # bad: [27c9d5b3c24af29de643533984f1ba3e650c7c78] Add linux-next specific files for 20220113
> git bisect bad 27c9d5b3c24af29de643533984f1ba3e650c7c78
> # good: [cf9e126911a1438ff36588f548a4137fe149d86c] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
> git bisect good cf9e126911a1438ff36588f548a4137fe149d86c
> # good: [05333947ad98119466c1bba228de30ab30aefa3f] Merge branch 'char-misc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> git bisect good 05333947ad98119466c1bba228de30ab30aefa3f
> # good: [2f978ceb8fee3221c479d0caffcd296ff58f058d] Merge branch 'hyperv-next' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> git bisect good 2f978ceb8fee3221c479d0caffcd296ff58f058d
> # bad: [d2bcbbe9073423477e7552a440e46f29a2ba0c55] panic: Remove oops_id.
> git bisect bad d2bcbbe9073423477e7552a440e46f29a2ba0c55
> # good: [fd4eb4516f5a2cc80d9ccff05900a3ff29bf4515] selftests/uffd: allow EINTR/EAGAIN
> git bisect good fd4eb4516f5a2cc80d9ccff05900a3ff29bf4515
> # bad: [98f4df2922a74f2369cf86b2df0375994766cdfe] mm/damon/reclaim: provide reclamation statistics
> git bisect bad 98f4df2922a74f2369cf86b2df0375994766cdfe
> # bad: [0212633f011d67bc1afe1b3611d9f61e4709c5b8] zsmalloc: introduce obj_allocated
> git bisect bad 0212633f011d67bc1afe1b3611d9f61e4709c5b8
> # bad: [34db36a7fab0af966a28cca95f2e08e89b33e700] mm/migrate: move node demotion code to near its user
> git bisect bad 34db36a7fab0af966a28cca95f2e08e89b33e700
> # bad: [a85e687fe7e5932b641d3abf99f66f3d57023850] mm/mempolicy: fix all kernel-doc warnings
> git bisect bad a85e687fe7e5932b641d3abf99f66f3d57023850
> # bad: [ed68b8bb2a653a1bedc8e1607a050e4200a75ebc] mm/mempolicy: add set_mempolicy_home_node syscall
> git bisect bad ed68b8bb2a653a1bedc8e1607a050e4200a75ebc
> # bad: [075782149abff45ee22f27315eced44d02b96779] mm/page_isolation: unset migratetype directly for non Buddy page
> git bisect bad 075782149abff45ee22f27315eced44d02b96779
> # good: [918650729924a97d11b38a38199c6ef96bcf9a73] vmscan: make drop_slab_node static
> git bisect good 918650729924a97d11b38a38199c6ef96bcf9a73
> # first bad commit: [075782149abff45ee22f27315eced44d02b96779] mm/page_isolation: unset migratetype directly for non Buddy page
> -------------------------------------------------------------------------------
> .

