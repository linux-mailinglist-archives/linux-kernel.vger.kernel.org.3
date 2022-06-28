Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B802D55E47D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346310AbiF1N2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346554AbiF1N1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCC6EB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:26:40 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LXQLS3b5VzkWcd;
        Tue, 28 Jun 2022 21:24:48 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 21:26:38 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 21:26:38 +0800
Subject: Re: [PATCH V13 02/13] ACPI: irq: Allow acpi_gsi_to_irq() to have an
 arch-specific fallback
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Huacai Chen" <chenhuacai@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
 <1656329997-20524-3-git-send-email-lvjianmin@loongson.cn>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b7b61ba7-74e4-b436-814e-61a8e595bacd@huawei.com>
Date:   Tue, 28 Jun 2022 21:26:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1656329997-20524-3-git-send-email-lvjianmin@loongson.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
> It appears that the generic version of acpi_gsi_to_irq() doesn't
> fallback to establishing a mapping if there is no pre-existing
> one while the x86 version does.
> 
> While arm64 seems unaffected by it, LoongArch is relying on the x86
> behaviour. In an effort to prevent new architectures from reinventing
> the proverbial wheel, provide an optional callback that the arch code
> can set to restore the x86 behaviour.
> 
> Hopefully we can eventually get rid of this in the future once
> the expected behaviour has been clarified.
> 
> Reported-by: Jianmin Lv <lvjianmin@loongson.cn>

Why do we need the Reported-by tag here?

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>   drivers/acpi/irq.c   | 18 ++++++++++++++++--
>   include/linux/acpi.h |  1 +
>   2 files changed, 17 insertions(+), 2 deletions(-)

The rest is looking good to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
