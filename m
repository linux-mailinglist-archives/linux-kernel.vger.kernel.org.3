Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37551535765
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiE0BsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiE0BsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:48:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71513702C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:48:02 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L8SP73f2NzDqND;
        Fri, 27 May 2022 09:47:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 09:48:00 +0800
Subject: Re: [PATCH] mm: use PAGE_ALIGNED instead of IS_ALIGNED
To:     <bh1scw@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220526140257.1568744-1-bh1scw@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f65a79ca-0cf8-91e1-ecd3-24ede70858ae@huawei.com>
Date:   Fri, 27 May 2022 09:48:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220526140257.1568744-1-bh1scw@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/26 22:02, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
> 
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

> ---
>  mm/sparse-vmemmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index f4fa61dbbee3..49cb15cbe590 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -200,8 +200,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>  	unsigned long next;
>  	pgd_t *pgd;
>  
> -	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> -	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +	VM_BUG_ON(!PAGE_ALIGNED(start));
> +	VM_BUG_ON(!PAGE_ALIGNED(end));
>  
>  	pgd = pgd_offset_k(addr);
>  	do {
> 

