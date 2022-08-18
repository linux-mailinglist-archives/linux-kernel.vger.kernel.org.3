Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3802597B15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiHRBb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiHRBbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:31:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C30A1A52
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:31:23 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M7S3w1xjzzGpgH;
        Thu, 18 Aug 2022 09:29:48 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:31:21 +0800
Subject: Re: [PATCH -next] mtd/ftl: Fix memleak in ftl_add_mtd()
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <gongruiqi1@huawei.com>, <wangweiyang2@huawei.com>
References: <20220715071105.2321311-1-cuigaosheng1@huawei.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <6733eee6-bfb6-7ee9-1331-2a739520fcd5@huawei.com>
Date:   Thu, 18 Aug 2022 09:31:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220715071105.2321311-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING

ÔÚ 2022/7/15 15:11, Gaosheng Cui Ð´µÀ:
> When add_mtd_blktrans_dev failed, partition's memory will be freed
> by kfree, but there are some structure members that are allocated
> for memory independently, such as partition->VirtualBlockMap,
> partition->EUNInfo, partition->ZferInfo, and partition->bam_cache,
> so kfree(partition) may cause memory leaks, using ftl_freepart(partition)
> will fix it.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>   drivers/mtd/ftl.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
> index f655d2905270..200271bdc7aa 100644
> --- a/drivers/mtd/ftl.c
> +++ b/drivers/mtd/ftl.c
> @@ -1031,6 +1031,7 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
>   		partition->mbd.devnum = -1;
>   		if (!add_mtd_blktrans_dev(&partition->mbd))
>   			return;
> +		ftl_freepart(partition);
>   	}
>   
>   	kfree(partition);
