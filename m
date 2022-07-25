Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55757F9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiGYHBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiGYHBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:01:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36EA2DED;
        Mon, 25 Jul 2022 00:01:01 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LrrSg5n8Hz9268;
        Mon, 25 Jul 2022 14:57:07 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 15:00:59 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Jul
 2022 15:00:59 +0800
Message-ID: <f565a5b5-8ba2-adbb-8093-6d60b2159222@huawei.com>
Date:   Mon, 25 Jul 2022 15:00:58 +0800
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20220704025632.235968-1-renzhijie2@huawei.com>
 <CAK8P3a07jGCuAVQAZgpENRP_xFLiogU9W1Uze+n21h7TdOZhog@mail.gmail.com>
 <df9909dc-3303-808e-575a-47190f636279@huawei.com>
 <CAK8P3a3SA9zvVu0i1m0kqbemLd4WfTMGfpc8VwhsmJOBgZHvsA@mail.gmail.com>
 <af043109-c101-a147-707b-82e79469ae73@huawei.com>
 <CAK8P3a0LCaMoWArcQNY5qayUABgRXWEogrtQQ-sbR+zY6n=O4w@mail.gmail.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <CAK8P3a0LCaMoWArcQNY5qayUABgRXWEogrtQQ-sbR+zY6n=O4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


在 2022/7/25 14:34, Arnd Bergmann 写道:
> On Mon, Jul 25, 2022 at 5:38 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
>> 在 2022/7/13 16:48, Arnd Bergmann 写道:
>>
>> I try to use the new marcos SYSTEM_SLEEP_PM_OPS and RUNTIME_PM_OPS to
>> replace the old ones, and remove #ifdef around the declarations in the
>> header, my local changes attach below.
>>
>> But it seems  that doesn't work, which has ld errors:
>>
>> aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
>> aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
>> drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_resume':
>> ufs-mediatek.c:(.text+0x1d0c): undefined reference to
>> `ufshcd_runtime_resume'
>> drivers/ufs/host/ufs-mediatek.o: In function `ufs_mtk_runtime_suspend':
>> ufs-mediatek.c:(.text+0x1d64): undefined reference to
>> `ufshcd_runtime_suspend'
>> Makefile:1255: recipe for target 'vmlinux' failed
>> make: *** [vmlinux] Error 1
>>
>> (CONFIG_PM and CONFIG_PM_SLEEP are both not set, and
>>
> It appears that there is a mistake in the RUNTIME_PM_OPS()
> macro definition, can you try this patch on top?

Hi Arnd,


I apply this patch and it worked.

When will this patch be merged?


Thanks,

Ren

>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 871c9c49ec9d..84592229d754 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -334,9 +334,9 @@ struct dev_pm_ops {
>          .restore_noirq = pm_sleep_ptr(resume_fn),
>
>   #define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> -       .runtime_suspend = suspend_fn, \
> -       .runtime_resume = resume_fn, \
> -       .runtime_idle = idle_fn,
> +       .runtime_suspend = pm_ptr(suspend_fn), \
> +       .runtime_resume = pm_ptr(resume_fn), \
> +       .runtime_idle = pm_ptr(idle_fn),
>
>   #ifdef CONFIG_PM_SLEEP
>   #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>
> Commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate
> old ones") introduced all the macros with the intent of using pm_ptr()
> and pm_sleep_ptr() in them, and I think Paul accidentally forgot to add
> those in this instance.
>
>         Arnd
>
> .

