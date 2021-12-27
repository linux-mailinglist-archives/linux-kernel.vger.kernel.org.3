Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA83D47F9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhL0Ddx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:33:53 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34847 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhL0Ddw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:33:52 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JMjtX425Wzcc5l;
        Mon, 27 Dec 2021 11:33:24 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 27 Dec 2021 11:33:51 +0800
Subject: Re: [PATCH] powerpc/sysdev/of_rtc: Fix possible memory leak in
 of_instantiate_rtc
From:   He Ying <heying24@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20211103014717.162886-1-heying24@huawei.com>
Message-ID: <be9e4adc-748b-cada-54df-a8d52515c3a8@huawei.com>
Date:   Mon, 27 Dec 2021 11:33:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211103014717.162886-1-heying24@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Any ideas about this patch?

ÔÚ 2021/11/3 9:47, He Ying Ð´µÀ:
> If of_address_to_resource() in of_instantiate_rtc() fails, previously
> allocated memory res is not freed. Add missing kfree() for it.
>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>   arch/powerpc/sysdev/of_rtc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/sysdev/of_rtc.c b/arch/powerpc/sysdev/of_rtc.c
> index 1f408d34a6a7..23b896996c2f 100644
> --- a/arch/powerpc/sysdev/of_rtc.c
> +++ b/arch/powerpc/sysdev/of_rtc.c
> @@ -44,6 +44,7 @@ void __init of_instantiate_rtc(void)
>   				printk(KERN_ERR "OF RTC: Error "
>   				       "translating resources for %pOF\n",
>   				       node);
> +				kfree(res);
>   				continue;
>   			}
>   
