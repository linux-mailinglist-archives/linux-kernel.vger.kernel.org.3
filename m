Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA456D279
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGKBXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKBXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:23:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CDD6170;
        Sun, 10 Jul 2022 18:23:43 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lh5gT6Jy9z1L8vj;
        Mon, 11 Jul 2022 09:21:09 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 09:23:41 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Jul
 2022 09:23:41 +0800
Message-ID: <d1474fc0-3eba-f1c3-6e63-0db8ce4ab07f@huawei.com>
Date:   Mon, 11 Jul 2022 09:23:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
To:     <stanley.chu@mediatek.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220704025632.235968-1-renzhijie2@huawei.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <20220704025632.235968-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
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

Just friendly ping...

在 2022/7/4 10:56, Ren Zhijie 写道:
> If CONFIG_PM is not set,
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-, will be failed, like this:
> drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_suspend’:
> drivers/ufs/host/ufs-mediatek.c:1435:8: error: implicit declaration of function ‘ufshcd_runtime_suspend’; did you mean ‘ufs_mtk_runtime_suspend’? [-Werror=implicit-function-declaration]
>    ret = ufshcd_runtime_suspend(dev);
>          ^~~~~~~~~~~~~~~~~~~~~~
>          ufs_mtk_runtime_suspend
> drivers/ufs/host/ufs-mediatek.c: In function ‘ufs_mtk_runtime_resume’:
> drivers/ufs/host/ufs-mediatek.c:1450:9: error: implicit declaration of function ‘ufshcd_runtime_resume’; did you mean ‘ufs_mtk_runtime_resume’? [-Werror=implicit-function-declaration]
>    return ufshcd_runtime_resume(dev);
>           ^~~~~~~~~~~~~~~~~~~~~
>           ufs_mtk_runtime_resume
> At top level:
> drivers/ufs/host/ufs-mediatek.c:1444:12: error: ‘ufs_mtk_runtime_resume’ defined but not used [-Werror=unused-function]
>   static int ufs_mtk_runtime_resume(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~~~~~
> drivers/ufs/host/ufs-mediatek.c:1430:12: error: ‘ufs_mtk_runtime_suspend’ defined but not used [-Werror=unused-function]
>   static int ufs_mtk_runtime_suspend(struct device *dev)
>              ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> The declarations of func "ufshcd_runtime_suspend()" and "ufshcd_runtime_resume()" depended on CONFIG_PM, so the function wrappers "ufs_mtk_runtime_suspend()" and "ufs_mtk_runtime_resume()"  both should warpped by CONFIG_PM too.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e7bf1d50063c ("scsi: ufs: ufs-mediatek: Fix build warnings")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>   drivers/ufs/host/ufs-mediatek.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
> index c958279bdd8f..e006c2528a3a 100644
> --- a/drivers/ufs/host/ufs-mediatek.c
> +++ b/drivers/ufs/host/ufs-mediatek.c
> @@ -1427,6 +1427,7 @@ static int ufs_mtk_system_resume(struct device *dev)
>   }
>   #endif
>   
> +#ifdef CONFIG_PM
>   static int ufs_mtk_runtime_suspend(struct device *dev)
>   {
>   	struct ufs_hba *hba = dev_get_drvdata(dev);
> @@ -1449,6 +1450,7 @@ static int ufs_mtk_runtime_resume(struct device *dev)
>   
>   	return ufshcd_runtime_resume(dev);
>   }
> +#endif
>   
>   static const struct dev_pm_ops ufs_mtk_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,

