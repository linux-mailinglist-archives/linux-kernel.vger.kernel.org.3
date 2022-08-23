Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1908859E76D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbiHWQgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbiHWQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:36:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0EDDF4F2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:47:37 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBsS45vpGzkWV3;
        Tue, 23 Aug 2022 22:44:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 22:47:34 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 22:47:33 +0800
Message-ID: <16cf184f-95ec-a763-0606-7423db8dcb0f@huawei.com>
Date:   Tue, 23 Aug 2022 22:47:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: fix pgdat->kswap accessed concurrently
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>
CC:     Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220820032506.126860-1-wangkefeng.wang@huawei.com>
 <1E87F09C-4904-49E2-B45C-C408DD5F6F62@linux.dev>
 <20220820135955.1520aa480fe04ab31d4fce1f@linux-foundation.org>
 <abe568d8-2d48-7e73-fe66-822915c0bd74@huawei.com>
In-Reply-To: <abe568d8-2d48-7e73-fe66-822915c0bd74@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


On 2022/8/23 9:07, Kefeng Wang wrote:
>
> On 2022/8/21 4:59, Andrew Morton wrote:
>> On Sat, 20 Aug 2022 15:33:04 +0800 Muchun Song 
>> <muchun.song@linux.dev> wrote:
>>
>>>
>>>> +    if (IS_ERR(t)) {
>>>>         /* failure at boot is fatal */
>>>>         BUG_ON(system_state < SYSTEM_RUNNING);
>>>>         pr_err("Failed to start kswapd on node %d\n", nid);
>>>> -        pgdat->kswapd = NULL;
>>>> +        WRITE_ONCE(pgdat->kswapd, NULL);
>>>> +    } else {
>>>> +        WRITE_ONCE(pgdat->kswapd, t);
>>>>     }
>>>> }
>>> IIUC, the race is like the followings:
>>>
>>> CPU 0:                    CPU 1:
>>>
>>> kswapd_run()
>>>     pgdat->kswapd = kthread_run()
>>>     if (IS_ERR(pgdat->kswapd))
>>>                     kswapd_is_running
>>>                         // load pgdat->kswapd and it is NOT NULL.
>>>         pgdat->kswapd = NULL
>>>                         task_is_running(pgdat->kswapd); // NULL 
>>> pointer dereference
>>>
>> But don't we still have a bug?  Sure, kswapd_is_running() will no
>> longer deref a null pointer.  But it now runs kswapd_is_running()
>> against a task which has exited - a use-after-free?

The UAF is caused by race between kswapd_stop() and kcompactd(), right?

so  kcompactd() should be stop before kswapd_stop() to avoid the above UAF.

$ git diff
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fad6d1f2262a..2fd45ccbce45 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1940,8 +1940,8 @@ int __ref offline_pages(unsigned long start_pfn, 
unsigned long nr_pages,

         node_states_clear_node(node, &arg);
         if (arg.status_change_nid >= 0) {
-               kswapd_stop(node);
                 kcompactd_stop(node);
+               kswapd_stop(node);
         }

         writeback_set_ratelimit();

> we could add get/put_task_struct() to avoid the UAF， will update， 
> thanks.

sorry, the task refcount won't fix anything.


> .
