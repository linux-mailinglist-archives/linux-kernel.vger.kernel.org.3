Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89C157F880
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 05:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiGYDiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 23:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGYDiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 23:38:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D2E030;
        Sun, 24 Jul 2022 20:38:07 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lrlzl2xdMz1M8Df;
        Mon, 25 Jul 2022 11:35:15 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 11:38:05 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Jul
 2022 11:38:05 +0800
Message-ID: <af043109-c101-a147-707b-82e79469ae73@huawei.com>
Date:   Mon, 25 Jul 2022 11:38:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Fix build error
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20220704025632.235968-1-renzhijie2@huawei.com>
 <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com>
 <df9909dc-3303-808e-575a-47190f636279@huawei.com>
 <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/7/13 16:48, Arnd Bergmann 写道:
> On Wed, Jul 13, 2022 at 3:44 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
>> 在 2022/7/12 16:27, Arnd Bergmann 写道:
>>
>> Thanks for your suggestion.
>>
>> How does it to fix the implicit-function-declaration error?
>>
> I missed that part at first. I would say the #ifdef around the
> declarations in the
> header should be removed here, it serves no purpose, and it is safe to rely
> on the compiler to perform dead code elimination so this does not lead to
> a link error even if a dead function references another function that is not
> reachable.
>
>          Arnd

Hi Arnd,

I try to use the new marcos SYSTEM_SLEEP_PM_OPS and RUNTIME_PM_OPS to 
replace the old ones, and remove #ifdef around the declarations in the 
header, my local changes attach below.

But it seems  that doesn't work, which has ld errors:

aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_resume':
ufs-mediatek.c:(.text+0x1d0c): undefined reference to 
`ufshcd_runtime_resume'
drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_suspend':
ufs-mediatek.c:(.text+0x1d64): undefined reference to 
`ufshcd_runtime_suspend'
Makefile:1255: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

(CONFIG_PM and CONFIG_PM_SLEEP are both not set, and

run cmd: make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-)

Thanks,

Ren Zhijie

--

diff --git a/drivers/ufs/host/ufs-mediatek.c 
b/drivers/ufs/host/ufs-mediatek.c
index c958279bdd8f..8c0c6f04eed1 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1402,7 +1402,6 @@ static int ufs_mtk_remove(struct platform_device 
*pdev)
         return 0;
  }

-#ifdef CONFIG_PM_SLEEP
  static int ufs_mtk_system_suspend(struct device *dev)
  {
         struct ufs_hba *hba = dev_get_drvdata(dev);
@@ -1425,7 +1424,6 @@ static int ufs_mtk_system_resume(struct device *dev)

         return ufshcd_system_resume(dev);
  }
-#endif

  static int ufs_mtk_runtime_suspend(struct device *dev)
  {
@@ -1451,9 +1449,9 @@ static int ufs_mtk_runtime_resume(struct device *dev)
  }

  static const struct dev_pm_ops ufs_mtk_pm_ops = {
-       SET_SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,
+       SYSTEM_SLEEP_PM_OPS(ufs_mtk_system_suspend,
                                 ufs_mtk_system_resume)
-       SET_RUNTIME_PM_OPS(ufs_mtk_runtime_suspend,
+       RUNTIME_PM_OPS(ufs_mtk_runtime_suspend,
                            ufs_mtk_runtime_resume, NULL)
         .prepare         = ufshcd_suspend_prepare,
         .complete        = ufshcd_resume_complete,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7fe1a926cd99..17ec18d55470 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1081,14 +1081,10 @@ static inline void *ufshcd_get_variant(struct 
ufs_hba *hba)
         return hba->priv;
  }

-#ifdef CONFIG_PM
  extern int ufshcd_runtime_suspend(struct device *dev);
  extern int ufshcd_runtime_resume(struct device *dev);
-#endif
-#ifdef CONFIG_PM_SLEEP
  extern int ufshcd_system_suspend(struct device *dev);
  extern int ufshcd_system_resume(struct device *dev);
-#endif
  extern int ufshcd_shutdown(struct ufs_hba *hba);
  extern int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
                                       int agreed_gear,

> .

