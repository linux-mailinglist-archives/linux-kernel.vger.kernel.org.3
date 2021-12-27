Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DD947F9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 03:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhL0B4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 20:56:50 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29290 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhL0B4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 20:56:49 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JMgkY15x0zbjdq;
        Mon, 27 Dec 2021 09:56:21 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 27 Dec 2021 09:56:48 +0800
Subject: Re: [PATCH] arm: Show real address of stack limit in __die()
From:   He Ying <heying24@huawei.com>
To:     <rmk+kernel@armlinux.org.uk>, <arnd@arndb.de>, <ardb@kernel.org>,
        <akpm@linux-foundation.org>, <maninder1.s@samsung.com>,
        <wangkefeng.wang@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211202061916.204718-1-heying24@huawei.com>
Message-ID: <3df20137-3a0e-e22b-fccb-4dc7409406ec@huawei.com>
Date:   Mon, 27 Dec 2021 09:56:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211202061916.204718-1-heying24@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Any ideas about this patch?

ÔÚ 2021/12/2 14:19, He Ying Ð´µÀ:
> Printing real address of stack limit makes debug easier.
> And system is dying, there is no security risk to show real
> address.
>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>   arch/arm/kernel/traps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 195dff58bafc..7d7c86d00482 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -273,7 +273,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
>   	print_modules();
>   	__show_regs(regs);
>   	__show_regs_alloc_free(regs);
> -	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
> +	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%px)\n",
>   		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
>   
>   	if (!user_mode(regs) || in_interrupt()) {
