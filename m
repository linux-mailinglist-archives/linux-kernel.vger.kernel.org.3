Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D49597B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiHRBcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiHRBcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:32:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8971A1D17
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:32:16 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7S1t222PzXdjM;
        Thu, 18 Aug 2022 09:28:02 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 09:32:14 +0800
Subject: Re: [PATCH -next] mtd/ftl: Fix uaf in ftl_remove_dev()
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <gongruiqi1@huawei.com>, <wangweiyang2@huawei.com>
References: <20220715071119.2321463-1-cuigaosheng1@huawei.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <a2b4dccd-0942-69ff-39ac-a9313f41fed1@huawei.com>
Date:   Thu, 18 Aug 2022 09:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220715071119.2321463-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
> del_mtd_blktrans_dev will reclaim the resources of mtd_blktrans_dev,
> and call kfree(dev) in blktrans_dev_put to release the memory of
> mtd_blktrans_dev, so when ftl_freepart reclaims the memory of other
> member pointers of the partition_t, it will trigger the uaf problem,
> Fix it by moving ftl_freepart in front of del_mtd_blktrans_dev.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>   drivers/mtd/ftl.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
> index 200271bdc7aa..bec56070039d 100644
> --- a/drivers/mtd/ftl.c
> +++ b/drivers/mtd/ftl.c
> @@ -1039,8 +1039,12 @@ static void ftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
>   
>   static void ftl_remove_dev(struct mtd_blktrans_dev *dev)
>   {
> +	struct partition_t *partition;
> +
> +	partition = container_of(dev, struct partition_t, mbd);
> +
> +	ftl_freepart(partition);
>   	del_mtd_blktrans_dev(dev);
> -	ftl_freepart((partition_t *)dev);
>   }
>   
>   static struct mtd_blktrans_ops ftl_tr = {
