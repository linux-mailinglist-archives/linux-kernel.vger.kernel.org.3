Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180515AFA99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIGD3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGD30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:29:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FF1F9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:29:22 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMnjf4yKFznWK2;
        Wed,  7 Sep 2022 11:26:46 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 11:29:20 +0800
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 11:29:19 +0800
Message-ID: <f54bdd79-b78e-470d-7048-8dee0ee39a1f@huawei.com>
Date:   Wed, 7 Sep 2022 11:29:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <npiggin@suse.de>, <ying.huang@intel.com>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>, <mgorman@suse.de>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <osalvador@suse.de>, <surenb@google.com>, <rppt@kernel.org>,
        <charante@codeaurora.org>, <jsavitz@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <lkp@intel.com>
Subject: Re: [PATCH -next v3 2/2] mm: sysctl: Introduce per zone
 watermark_scale_factor
Content-Language: en-US
To:     <mcgrof@kernel.org>
References: <20220905032858.1462927-1-mawupeng1@huawei.com>
 <20220905032858.1462927-3-mawupeng1@huawei.com>
 <YxeQB2jawNwpOB5y@bombadil.infradead.org>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <YxeQB2jawNwpOB5y@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/7 2:23, Luis Chamberlain wrote:
> On Mon, Sep 05, 2022 at 11:28:58AM +0800, Wupeng Ma wrote:
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 205d605cacc5..d16d06c71e5a 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2251,8 +2251,6 @@ static struct ctl_table vm_table[] = {
>>  		.maxlen		= sizeof(watermark_scale_factor),
>>  		.mode		= 0644,
>>  		.proc_handler	= watermark_scale_factor_sysctl_handler,
>> -		.extra1		= SYSCTL_ONE,
>> -		.extra2		= SYSCTL_THREE_THOUSAND,
>>  	},
>>  	{
>>  		.procname	= "percpu_pagelist_high_fraction",
> 
> Please move the sysctl from kernel/sysctl.c to mm/page_alloc.c while
> at it, you can git log the kernel/sysctl.c for prior moves and for
> the motivations. No need to keep expanding on the existing table.
> 
>   Luis

Ok.

I will move this sysctl to mm/page_alloc.c next version.
