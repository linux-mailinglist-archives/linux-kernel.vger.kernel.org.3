Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC956B51B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbiGHJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:07:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459B722BF5;
        Fri,  8 Jul 2022 02:07:48 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LfS6Q2vNtz1L8tg;
        Fri,  8 Jul 2022 17:05:18 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 17:07:46 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 17:07:45 +0800
Subject: Re: [PATCH] ubi: fastmap: Use the bitmap API to allocate bitmaps
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <64cde893efca8f4dc381184cd7f6e5a54cd000f9.1656960335.git.christophe.jaillet@wanadoo.fr>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <16e6eef2-bf83-f5c1-6543-8c49a70c7d85@huawei.com>
Date:   Fri, 8 Jul 2022 17:07:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <64cde893efca8f4dc381184cd7f6e5a54cd000f9.1656960335.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/7/5 2:46, Christophe JAILLET Ð´µÀ:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/mtd/ubi/fastmap.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
> index 6e95c4b1473e..ca2d9efe62c3 100644
> --- a/drivers/mtd/ubi/fastmap.c
> +++ b/drivers/mtd/ubi/fastmap.c
> @@ -20,8 +20,7 @@ static inline unsigned long *init_seen(struct ubi_device *ubi)
>   	if (!ubi_dbg_chk_fastmap(ubi))
>   		return NULL;
>   
> -	ret = kcalloc(BITS_TO_LONGS(ubi->peb_count), sizeof(unsigned long),
> -		      GFP_KERNEL);
> +	ret = bitmap_zalloc(ubi->peb_count, GFP_KERNEL);
>   	if (!ret)
>   		return ERR_PTR(-ENOMEM);
>   
> @@ -34,7 +33,7 @@ static inline unsigned long *init_seen(struct ubi_device *ubi)
>    */
>   static inline void free_seen(unsigned long *seen)
>   {
> -	kfree(seen);
> +	bitmap_free(seen);
>   }
>   
>   /**
> @@ -1108,8 +1107,7 @@ int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
>   	if (!ubi->fast_attach)
>   		return 0;
>   
> -	vol->checkmap = kcalloc(BITS_TO_LONGS(leb_count), sizeof(unsigned long),
> -				GFP_KERNEL);
> +	vol->checkmap = bitmap_zalloc(leb_count, GFP_KERNEL);
>   	if (!vol->checkmap)
>   		return -ENOMEM;
>   
> @@ -1118,7 +1116,7 @@ int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
>   
>   void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol)
>   {
> -	kfree(vol->checkmap);
> +	bitmap_free(vol->checkmap);
>   }
>   
>   /**
> 
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
