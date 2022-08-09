Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7187B58D569
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiHIIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbiHIIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:32:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E54205F9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:32:49 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M25qm4dsvzmVJS;
        Tue,  9 Aug 2022 16:30:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 16:32:47 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 16:32:47 +0800
Message-ID: <abe62159-c218-2fb5-e096-3c71c10c28e1@huawei.com>
Date:   Tue, 9 Aug 2022 16:32:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mm: add warning if __vm_enough_memory fails
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     David Hildenbrand <david@redhat.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
References: <20220726145428.8030-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220726145428.8030-1-wangkefeng.wang@huawei.com>
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

Hi maintainer, any comments, thanks

On 2022/7/26 22:54, Kefeng Wang wrote:
> If a process has no enough memory to allocate a new virtual mapping, we
> may meet kinds of error, eg, fork cannot allocate memory, SIGBUS error
> in shmem, but it is difficult to confirm them, let's add some debug
> information to easy to check this scenario if __vm_enough_memory fails.
>
> Reported-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: use pr_warn_ratelimited, suggested by David Hildenbrand
>
>   mm/util.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/mm/util.c b/mm/util.c
> index 1266a33a49ea..c786e21c6051 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1020,6 +1020,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>   	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
>   		return 0;
>   error:
> +	pr_warn_ratelimited("%s: pid: %d, comm: %s, no enough memory for the allocation\n",
> +			    __func__, current->pid, current->comm);
>   	vm_unacct_memory(pages);
>   
>   	return -ENOMEM;
