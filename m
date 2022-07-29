Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6009584987
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiG2CDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiG2CD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:03:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201179695
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:03:26 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lv9hY1tzszjXLj;
        Fri, 29 Jul 2022 10:00:29 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 10:03:24 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 10:03:24 +0800
Message-ID: <dda75772-78d7-758c-b020-87ac776fbd9e@huawei.com>
Date:   Fri, 29 Jul 2022 10:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mm: memory-failure: convert to pr_fmt()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220727032511.145506-1-wangkefeng.wang@huawei.com>
 <20220728183759.6a3eaab13b1b122a5810af58@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220728183759.6a3eaab13b1b122a5810af58@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/29 9:37, Andrew Morton wrote:
> On Wed, 27 Jul 2022 11:25:11 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Use pr_fmt to prefix all pr_<level> output, but unpoison_memory()
>> and soft_offline_page() are used by error injection, which have
>> own prefixes like "Unpoison:" and "soft offline:", meanwhile,
>> soft_offline_page() could be used by memory hotremove, so undef
>> pr_fmt before unpoison_pr_info definition to keep the original
>> output for them.
>>
>> ...
>>
>> @@ -2289,6 +2285,7 @@ static int __init memory_failure_init(void)
>>   }
>>   core_initcall(memory_failure_init);
>>   
>> +#undef pr_fmt
>>   #define unpoison_pr_info(fmt, pfn, rs)			\
>>   ({							\
>>   	if (__ratelimit(rs))				\
> This change makes the build fail.

sorry, should be

+#undef pr_fmt
+#define pr_fmt(fmt)     "" fmt

will update in v3

>
> In file included from ./include/linux/kernel.h:29,
>                   from mm/memory-failure.c:39:
> mm/memory-failure.c: In function 'unpoison_memory':
> ./include/linux/printk.h:537:26: error: expected ')' before 'pr_fmt'
>    537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>        |                          ^~~~~~
> ./include/linux/printk.h:388:42: note: in definition of macro '__printk_index_emit'
>    388 |                 if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
>        |                                          ^~~~
> ./include/linux/printk.h:464:26: note: in expansion of macro 'printk_index_wrap'
>    464 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>        |                          ^~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:537:9: note: in expansion of macro 'printk'
>    537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>        |         ^~~~~~
> mm/memory-failure.c:2292:17: note: in expansion of macro 'pr_info'
>   2292 |                 pr_info(fmt, pfn);                      \
>        |                 ^~~~~~~
> mm/memory-failure.c:2326:17: note: in expansion of macro 'unpoison_pr_info'
>   2326 |                 unpoison_pr_info("Unpoison: Disabled after HW memory failure %#lx\n",
>        |                 ^~~~~~~~~~~~~~~~
>
> [1500 lines of the same]
> .
