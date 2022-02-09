Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF44AF0CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiBIMHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiBIMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D0DC094C96;
        Wed,  9 Feb 2022 03:26:34 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtyGy1t4wzbk7K;
        Wed,  9 Feb 2022 19:25:30 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 19:26:31 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 19:26:30 +0800
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <frederic@kernel.org>, <tglx@linutronix.de>, <mtosatti@redhat.com>,
        <mgorman@suse.de>, <linux-rt-users@vger.kernel.org>,
        <vbabka@suse.cz>, <cl@linux.com>, <paulmck@kernel.org>,
        <willy@infradead.org>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
 <7c87f388-cc50-e9a1-17a7-802bb42656e4@huawei.com>
 <b5363ced8e17d07d41554da8fde06c410e6688e0.camel@redhat.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <b2e7ea31-0a56-6415-474b-a952fb1d36ef@huawei.com>
Date:   Wed, 9 Feb 2022 19:26:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b5363ced8e17d07d41554da8fde06c410e6688e0.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/2/9 17:45, Nicolas Saenz Julienne wrote:
> Hi Xiongfeng, thanks for taking the time to look at this.
> 
> On Wed, 2022-02-09 at 16:55 +0800, Xiongfeng Wang wrote:
>> Hi Nicolas，
>>
>> When I applied the patchset on the following commit and tested on QEMU, I came
>> accross the following CallTrace.
>>   commit dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
>>
>> I wrote a userspace application to consume the memory. When the memory is used
>> out, the OOM killer is triggered and the following Calltrace is printed. I am
>> not sure if it is related to this patchset. But when I reverted this patchset,
>> the 'NULL pointer' Calltrace didn't show.
> 
> It's a silly mistake on my part, while cleaning up the code I messed up one of
> the 'struct per_cpu_pages' accessors. This should fix it:
> 
> ------------------------->8-------------------------
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0caa7155ca34..e65b991c3dc8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3279,7 +3279,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
>                                 has_pcps = true;
>                 } else {
>                         for_each_populated_zone(z) {
> -                               pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> +                               pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
>                                 lp = rcu_dereference_protected(pcp->lp,
>                                                 mutex_is_locked(&pcpu_drain_mutex));
>                                 if (lp->count) {

I have tested it. It works well. No more 'NULL pointer' Calltrace.

Thanks,
Xiongfeng

> ------------------------->8-------------------------
> 
> Thanks!
> 
