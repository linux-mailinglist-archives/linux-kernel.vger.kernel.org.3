Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF955E3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbiF1MuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiF1MuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:50:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA924F1A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:50:13 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXPXQ0mXMzkWkD;
        Tue, 28 Jun 2022 20:48:22 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 20:50:12 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 20:50:11 +0800
Subject: Re: [PATCH V13 01/13] APCI: irq: Add support for multiple GSI domains
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Huacai Chen" <chenhuacai@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
 <1656329997-20524-2-git-send-email-lvjianmin@loongson.cn>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a2251c18-790c-b1d2-e9cc-2d7bda2a20db@huawei.com>
Date:   Tue, 28 Jun 2022 20:50:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1656329997-20524-2-git-send-email-lvjianmin@loongson.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/27 19:39, Jianmin Lv wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In an unfortunate departure from the ACPI spec, the LoongArch
> architecture split its GSI space across multiple interrupt
> controllers.
> 
> In order to be able to reuse sthe core code and prevent

s/sthe/the

> architectures from reinventing an already square wheel, offer
> the arch code the ability to register a dispatcher function
> that will return the domain fwnode for a given GSI.
> 
> The ARM GIC drivers are updated to support this (with a single
> domain, as intended).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>   drivers/acpi/irq.c           | 40 +++++++++++++++++++++++++---------------
>   drivers/irqchip/irq-gic-v3.c | 18 ++++++++++++------
>   drivers/irqchip/irq-gic.c    | 18 ++++++++++++------
>   include/linux/acpi.h         |  2 +-

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

I tested this patch on a GICv3 based ARM64 server, no
regressions were found,

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
