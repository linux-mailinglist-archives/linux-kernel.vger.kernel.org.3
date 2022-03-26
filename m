Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24F4E7FDE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 08:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiCZH47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCZH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:56:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663111DDFE1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 00:55:20 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KQWRq1QLKzfZQg;
        Sat, 26 Mar 2022 15:53:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 15:55:18 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 15:55:18 +0800
Message-ID: <b2ff771c-01ef-3f14-f22d-9248735fdc77@huawei.com>
Date:   Sat, 26 Mar 2022 15:55:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 1/2] Revert "powerpc: Set max_mapnr correctly"
Content-Language: en-US
To:     <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.or>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <songyuanzheng@huawei.com>
References: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220216121109.157605-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainers，

I saw the patches has been reviewed[1], could they be merged?

Many thanks.

[1] https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=286464

On 2022/2/16 20:11, Kefeng Wang wrote:
> This reverts commit 602946ec2f90d5bd965857753880db29d2d9a1e9.
>
> If CONFIG_HIGHMEM enabled, highmem will be disappeared with max_mapnr
> set to max_low_pfn, see mem_init(),
>
>    for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
>          ...
> 	free_highmem_page();
>    }
>
> Revert it and will fix virt_addr_valid() check in the next patch.
>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Fixes: 602946ec2f90 ("powerpc: Set max_mapnr correctly")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v4:
> - new patch
>   arch/powerpc/mm/mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 8e301cd8925b..4d221d033804 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -255,7 +255,7 @@ void __init mem_init(void)
>   #endif
>   
>   	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
> -	set_max_mapnr(max_low_pfn);
> +	set_max_mapnr(max_pfn);
>   
>   	kasan_late_init();
>   
