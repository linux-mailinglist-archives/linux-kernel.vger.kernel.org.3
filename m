Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029EC574A81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbiGNKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiGNKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE1E52FFE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63BF861F03
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1055C34114;
        Thu, 14 Jul 2022 10:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657794066;
        bh=3dg23Jgtwukc/GCHd2LHRM+BYubgruVg6fjGLogiQYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NmhVa/CU3B8mmGtz8blBuT9rEZsK/OJdoesCxO2cjxthY1xO942wd66p37fSbaelT
         Oj6EbZzD6F3SUM2NLz90oYUAUabiX8aHhlgPMyDccX2NVDxtbXtKjuLA47o3oldpy2
         9CRxdQWRqHPUYKblXQ6pWg2n/cqsAKE+i3Irn9Fmbo+e4SU1Mt56P/5izRsy9TAQ1N
         cjV+bztsPj4So6psEXNeOht7ZKUsuEKiMqlWS90+1Iqr4hcLVlDKfb7JLL1FKikxGM
         bp3P+Rv+x6fGaN0VkH2IHgv3TSK3DTb6/hFlwqQuInOi6o1rqr1H2UiIan7AQf43nd
         dF5QaCRJ3uS7g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oBvxw-007QGu-EY;
        Thu, 14 Jul 2022 11:21:04 +0100
MIME-Version: 1.0
Date:   Thu, 14 Jul 2022 11:21:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V14 14/15] irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC
 for LoongArch
In-Reply-To: <bfbd08d6-6f09-3ddb-0fdf-8c459352cf0f@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <1656837932-18257-15-git-send-email-lvjianmin@loongson.cn>
 <87y1x5krjd.wl-maz@kernel.org>
 <f76927be-8c8c-5bbe-ef5c-a63f4a09b29c@loongson.cn>
 <bfbd08d6-6f09-3ddb-0fdf-8c459352cf0f@loongson.cn>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <22902b5c7616d47f6e48acc536a70da7@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lvjianmin@loongson.cn, tglx@linutronix.de, linux-kernel@vger.kernel.org, guohanjun@huawei.com, lorenzo.pieralisi@arm.com, jiaxun.yang@flygoat.com, chenhuacai@loongson.cn
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-14 11:02, Jianmin Lv wrote:
> On 2022/7/8 上午11:17, Jianmin Lv wrote:
>> 
>> 
>> On 2022/7/7 下午8:59, Marc Zyngier wrote:
>>> On Sun, 03 Jul 2022 09:45:31 +0100,
>>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>>> 
>>>> For LoongArch, ACPI_IRQ_MODEL_LPIC is introduced, and then the
>>>> callback acpi_get_gsi_domain_id and acpi_gsi_to_irq_fallback are
>>>> implemented.
>>>> 
>>>> The acpi_get_gsi_domain_id callback returns related fwnode handle
>>>> of irqdomain for different GSI range.
>>>> 
>>>> The acpi_gsi_to_irq_fallback will create new mapping for gsi when
>>>> the mapping of it is not found.
>>>> 
>>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>> ---
>>>>   drivers/acpi/bus.c                  |  3 +++
>>>>   drivers/irqchip/irq-loongarch-cpu.c | 37 
>>>> +++++++++++++++++++++++++++++++++++++
>>>>   include/linux/acpi.h                |  1 +
>>>>   3 files changed, 41 insertions(+)
>>>> 
>>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>>>> index 86fa61a..63fbf00 100644
>>>> --- a/drivers/acpi/bus.c
>>>> +++ b/drivers/acpi/bus.c
>>>> @@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
>>>>       case ACPI_IRQ_MODEL_PLATFORM:
>>>>           message = "platform specific model";
>>>>           break;
>>>> +    case ACPI_IRQ_MODEL_LPIC:
>>>> +        message = "LPIC";
>>>> +        break;
>>>>       default:
>>>>           pr_info("Unknown interrupt routing model\n");
>>>>           return -ENODEV;
>>>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c 
>>>> b/drivers/irqchip/irq-loongarch-cpu.c
>>>> index c2f7411..1b241d7 100644
>>>> --- a/drivers/irqchip/irq-loongarch-cpu.c
>>>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>>>> @@ -15,6 +15,41 @@
>>>>   static struct irq_domain *irq_domain;
>>>> +static int lpic_gsi_to_irq(u32 gsi)
>>>> +{
>>>> +    /* Only pch irqdomain transferring is required for LoongArch. 
>>>> */
>>>> +    if (gsi >= GSI_MIN_PCH_IRQ && gsi <= GSI_MAX_PCH_IRQ)
>>>> +        return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, 
>>>> ACPI_ACTIVE_HIGH);
>>>> +    return -1;
>>> 
>>> The expected return value on failure is 0 (which indicates that no
>>> interrupt was mapped). Here, things will break as acpi_gsi_to_irq()
>>> stores the result as unsigned, and compares the result to 0.
>>> 
>> 
>> Ok, thanks, I'll change the return value to 0 on failure and change 
>> return type to unsigned int.
>> 
>> 
> 
> Hi, Marc, if the return type is changed to unsigned int, the return
> type of the fallback handler in the patch:
> ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
> 
> should be changed to unsigned int too, yes?

Yes, of course.

         M.
-- 
Jazz is not dead. It just smells funny...
