Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC12A5AF998
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIGCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIGB7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:59:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128340BF2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:59:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MMlht6bQvz1P702;
        Wed,  7 Sep 2022 09:55:58 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 09:59:46 +0800
Subject: Re: [PATCH -next] mm/hwpoison: add __init/__exit annotations to
 module init/exit funcs
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>
References: <20220906093530.243262-1-xiujianfeng@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dca9a2ea-1d7d-7a9a-a7d7-6782d589a432@huawei.com>
Date:   Wed, 7 Sep 2022 09:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220906093530.243262-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/6 17:35, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

> ---
>  mm/hwpoison-inject.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 65e242b5a432..d0548e382b6b 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -63,13 +63,13 @@ static int hwpoison_unpoison(void *data, u64 val)
>  DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
>  DEFINE_DEBUGFS_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
>  
> -static void pfn_inject_exit(void)
> +static void __exit pfn_inject_exit(void)
>  {
>  	hwpoison_filter_enable = 0;
>  	debugfs_remove_recursive(hwpoison_dir);
>  }
>  
> -static int pfn_inject_init(void)
> +static int __init pfn_inject_init(void)
>  {
>  	hwpoison_dir = debugfs_create_dir("hwpoison", NULL);
>  
> 

