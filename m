Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0949C5A40BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 03:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiH2BiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 21:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2BiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:38:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF93A4BD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 18:38:14 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGCgm3gwVznTW1;
        Mon, 29 Aug 2022 09:35:48 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:38:12 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:38:12 +0800
Message-ID: <271c1983-9f84-46ee-4c9f-beb1aa3a681f@huawei.com>
Date:   Mon, 29 Aug 2022 09:38:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mm: fix null-ptr-deref in kswapd_is_running()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>
References: <20220827111959.186838-1-wangkefeng.wang@huawei.com>
 <20220827150855.b8885a5c4f09df712d619760@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220827150855.b8885a5c4f09df712d619760@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/28 6:08, Andrew Morton wrote:
> On Sat, 27 Aug 2022 19:19:59 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> The kswapd_run/stop() will set pgdat->kswapd to NULL, which
>> could race with kswapd_is_running() in kcompactd(),
>>
>> kswapd_run/stop()                       kcompactd()
>>                                            kswapd_is_running()
>>    pgdat->kswapd // error or nomal ptr
>>                                            verify pgdat->kswapd
>>                                              // load non-NULL
>> pgdat->kswapd
>>    pgdat->kswapd = NULL
>>                                            task_is_running(pgdat->kswapd)
>>                                              // Null pointer derefence
>>
>> The KASAN report the null-ptr-deref shown below,
>>
>>    vmscan: Failed to start kswapd on node 0
>>    ...
>>    BUG: KASAN: null-ptr-deref in kcompactd+0x440/0x504
>>    Read of size 8 at addr 0000000000000024 by task kcompactd0/37
>>
>>    CPU: 0 PID: 37 Comm: kcompactd0 Kdump: loaded Tainted: G           OE     5.10.60 #1
>>    Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>    Call trace:
>>     dump_backtrace+0x0/0x394
>>     show_stack+0x34/0x4c
>>     dump_stack+0x158/0x1e4
>>     __kasan_report+0x138/0x140
>>     kasan_report+0x44/0xdc
>>     __asan_load8+0x94/0xd0
>>     kcompactd+0x440/0x504
>>     kthread+0x1a4/0x1f0
>>     ret_from_fork+0x10/0x18
>>
>> For now, kswapd/kcompactd_run() and kswapd/kcompactd_stop() protected
>> by mem_hotplug_begin/done(), but without kcompactd(). It is no need to
>> involve memory hotplug lock in kcompactd(), so let's add new mutex to
>> protect pgdat->kswapd accessed concurrently, also because kcompactd task
>> will check the state of kswapd task, it's better to call kcompactd_stop()
>> before kswapd_stop() to reduce lock conflicts.
>>
> Looks right to me.
>
> I think the below will make the code a little more maintainable?
Thanks Andrew, it's better.
>
> --- a/include/linux/memory_hotplug.h~mm-fix-null-ptr-deref-in-kswapd_is_running-fix
> +++ a/include/linux/memory_hotplug.h
> @@ -215,6 +215,7 @@ void put_online_mems(void);
>   void mem_hotplug_begin(void);
>   void mem_hotplug_done(void);
>   
> +/* See kswapd_is_running() */
>   static inline void pgdat_kswapd_lock(pg_data_t *pgdat)
>   {
>   	mutex_lock(&pgdat->kswapd_lock);
> --- a/mm/compaction.c~mm-fix-null-ptr-deref-in-kswapd_is_running-fix
> +++ a/mm/compaction.c
> @@ -1980,6 +1980,12 @@ static inline bool is_via_compact_memory
>   	return order == -1;
>   }
>   
> +/*
> + * Determine whether kswapd is (or recently was!) running on this node.
> + *
> + * pgdat_kswapd_lock() pins pgdat->kswapd, so a concurrent kswapd_stop() can't
> + * zero it.
> + */
>   static bool kswapd_is_running(pg_data_t *pgdat)
>   {
>   	bool running;
> _
>
> .
