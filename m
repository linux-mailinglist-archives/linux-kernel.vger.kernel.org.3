Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3594A59F14C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiHXCLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiHXCLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:11:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE15722D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:11:43 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MC8cX1RDvzXdpf;
        Wed, 24 Aug 2022 10:07:24 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 10:11:41 +0800
Message-ID: <0dc95a9a-e801-aa7e-9075-4017a9cbb122@huawei.com>
Date:   Wed, 24 Aug 2022 10:11:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next] genirq: Change irq_can_set_affinity() return value
 type to bool
To:     <tglx@linutronix.de>, <peterz@infradead.org>,
        <frederic@kernel.org>, <tannerlove@google.com>,
        <edumazet@google.com>, <bigeasy@linutronix.de>,
        <zouyipeng@huawei.com>, <liaochang1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20220809124009.543646-1-chris.zjh@huawei.com>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <20220809124009.543646-1-chris.zjh@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping

在 2022/8/9 20:40, Zhang Jianhua 写道:
> The function irq_can_set_affinity() return from __irq_can_set_affinity()
> directly, whose return value type is bool, so make irq_can_set_affinity()
> return bool too.
>
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> ---
>   include/linux/interrupt.h | 2 +-
>   kernel/irq/manage.c       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index a92bce40b04b..29de49af6dea 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -308,7 +308,7 @@ extern cpumask_var_t irq_default_affinity;
>   extern int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask);
>   extern int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask);
>   
> -extern int irq_can_set_affinity(unsigned int irq);
> +extern bool irq_can_set_affinity(unsigned int irq);
>   extern int irq_select_affinity(unsigned int irq);
>   
>   extern int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 40fe7806cc8c..dd9aeef68834 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -156,7 +156,7 @@ static bool __irq_can_set_affinity(struct irq_desc *desc)
>    *	@irq:		Interrupt to check
>    *
>    */
> -int irq_can_set_affinity(unsigned int irq)
> +bool irq_can_set_affinity(unsigned int irq)
>   {
>   	return __irq_can_set_affinity(irq_to_desc(irq));
>   }
