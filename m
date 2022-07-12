Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502A8571C32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiGLOSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiGLORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:17:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E681A2E74;
        Tue, 12 Jul 2022 07:17:48 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lj2p76HlXz1L8sb;
        Tue, 12 Jul 2022 22:15:11 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 22:17:45 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Jul 2022 22:17:44 +0800
Message-ID: <4b5f52c3-00ea-0aac-ff05-a25741f3f0e3@huawei.com>
Date:   Tue, 12 Jul 2022 22:17:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] zram: fix unused 'zram_wb_devops' warning
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
CC:     <linux-block@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20220608072534.68850-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220608072534.68850-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

+mm,  kindly ping...

On 2022/6/8 15:25, Kefeng Wang wrote:
> drivers/block/zram/zram_drv.c:55:45: warning: 'zram_wb_devops' defined but not used [-Wunused-const-variable=]
>
> Fix the above warning if CONFIG_ZRAM_WRITEBACK not enabled.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   drivers/block/zram/zram_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 39cd1397ed3b..fff5eb4d3f20 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -52,7 +52,9 @@ static unsigned int num_devices = 1;
>   static size_t huge_class_size;
>   
>   static const struct block_device_operations zram_devops;
> +#ifdef CONFIG_ZRAM_WRITEBACK
>   static const struct block_device_operations zram_wb_devops;
> +#endif
>   
>   static void zram_free_page(struct zram *zram, size_t index);
>   static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
