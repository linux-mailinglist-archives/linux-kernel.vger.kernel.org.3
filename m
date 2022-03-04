Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CB4CCF4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbiCDHw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiCDHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:52:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E6192E29
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cycH4Yvum8O6tG1+ER1Rpy1rhf8MBZMBnX9Heeb/6uVMMHPWPtJ4urSZyHtPZjnOjFxCy5J4ehubRmesMgI9nWdI38oR1yHS2E+UMMEalGpQzkQqhWPm9hvHfvVxlw35E5vI9zBqvzqAAprXKgh/14ELMxyAu7dBq4uB21/HSBPaA6ljrGBq5xQa7n7f8gJwlCgbI1VzVwAjYbAwk9VMjq1S38MUdnFesemrldxGMJjva39OkWvQ1BgEZKYHWeXqif1/hD7GyEo/lnZb/194q4/DF5aTeSSMcWn9RtmjoV5vWgRcu1uh4XNKi556NY8oJaX0pGibvE9SSpLlE5aOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjubeD8bdohl6dgh+ppMMpj9rg1jxqtGowvtyT1PI0w=;
 b=SLQDyxUiu7oE0TQH2dSea40cd3TUBAMFzaRalDHzysDTzJF8sB/S0QjKiCpUUTCRKOAdd3yfRcQrDC341FAAyXxWha/yBYPVAdnLqmBpl0dEaBs+rcq8Os9cGLD2VjonzOqBBdHPViyCJ0ctprkcfHfujGv/YwIigwEbtTyWzNF8A3Vj6oj6Xk/th6JOiVoGaD7xbJ1IDBsKVgR8CT3Ax4r2zOtTdkTIO3TX7bFhCFmimopPHQiFoSi1NRoS8D5m385ifE2qUnBKYq4sw1nxgZ81ObFZxMwo4ppc7t7t+Fg8Mio2HShAEzOvU9CUTSZ2ixn2Yh8CvZnRNGYkKBRYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjubeD8bdohl6dgh+ppMMpj9rg1jxqtGowvtyT1PI0w=;
 b=P2LWu8b0baygvl1lJ9KvC+nYAM4pvfHMxg7XciUdgXKdt69ztDon3c/AUOSqOgC77kG8KwYhpTlqOjuAEhrWyUgrdkkBe3n/Eb5Nmyqh9tS/NTHzh25rvle5i+afwDlqqNMKGxWp1O4obtHuaa0+dTIQwu1W5tBeZhIXdiBvf88=
Received: from DM6PR14CA0049.namprd14.prod.outlook.com (2603:10b6:5:18f::26)
 by SJ0PR02MB8594.namprd02.prod.outlook.com (2603:10b6:a03:3fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 07:52:02 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::bb) by DM6PR14CA0049.outlook.office365.com
 (2603:10b6:5:18f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Fri, 4 Mar 2022 07:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 07:52:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 3 Mar 2022 23:52:00 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 3 Mar 2022 23:52:00 -0800
Envelope-to: git@xilinx.com,
 maz@kernel.org,
 linux-kernel@vger.kernel.org,
 monstr@monstr.eu,
 robert.hancock@calian.com,
 tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Received: from [10.254.241.50] (port=42458)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nQ2jH-000AqM-Uh; Thu, 03 Mar 2022 23:52:00 -0800
Message-ID: <88f39791-2154-8df4-c95e-f416f83c20fb@xilinx.com>
Date:   Fri, 4 Mar 2022 08:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] irqchip: xilinx: Enable generic irq multi handler
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Robert Hancock <robert.hancock@calian.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <2a08d6c33e95d5da5d564ed3fbddc835983ef355.1646323896.git.michal.simek@xilinx.com>
 <87sfrz0x1p.wl-maz@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <87sfrz0x1p.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86091d1b-1ebf-4695-05ac-08d9fdb3de2f
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8594:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8594629A3A342630B715EB0DC6059@SJ0PR02MB8594.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 474Fj+Zch7FC1TRY/B8pEVK1/zGHsioZykLVlMeSxeWebf+8VbUNzgmzOuHE6VJhfmZWJuK2zOnhjpYQtmB6INxbI/cwleTjCCjC1YkHCybCoqziGdIICjfTBEOEJozhAm78N0QOMdG1+gPcBck+6wI7EuUxFAiBIvkZUZuVpFTuyqBA0v7gH/LGPqPIh02sPJBp6tZEaZXfO5iI8zBt34z0x210M4/FrAa/rYrOHX3cP1s5ZGZIgzqh12h2808iyMMx9q3lTXs0P34p3/AOV0zodzUJO4lY5EdRAvMlhwC8XrsfXIkCM8TmRUituwU0PMvkP0X5ZckuBgRkWbKf26Wi3T3dywfPbxpS0c1e0+TGORQR6ZmetDJegQKlnDlvw7yFz5FQ4AbksGOoVzyY5JBuS68cI4aj6yPjJ4s80GqViC8KFJ8bUR2GJtUkBuymjknXEA+qGt0r2ilXCo9vpdMLsd5JBeFkgqT5SRbpg9u2WrdnpiVyF7xuGsAQ4L7rll0vb5bB7l/u3Fy+udtP98/+1rQ8cAIIoLNxHqZu28dC71MjkCA3b0oPyA+Di8GCU1B1Be213+uoQ/Cygb61oaMO8Yu9TzI5ga0lOQUrJBy6Y/KbAbh10F7xkZ6CUuNDU5Z91TZBmnk7w5vOhwMgdXVgr/+sVN6IVR0+4baM5FvmOD+BUuqifnt7aHuZjsjpMkpDnOH6lnH4zCYQWiYkUiEddv/KG1mDp1ypmUydtgPPu+CINzpb+NBHF2E2JhVQc5VnC23d/R+4eFxahu8xWA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(336012)(426003)(44832011)(5660300002)(2616005)(36860700001)(9786002)(356005)(31686004)(36756003)(186003)(8676002)(4326008)(7636003)(2906002)(70206006)(26005)(70586007)(6666004)(83380400001)(53546011)(31696002)(316002)(54906003)(47076005)(110136005)(82310400004)(40460700003)(508600001)(50156003)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 07:52:01.7295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86091d1b-1ebf-4695-05ac-08d9fdb3de2f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8594
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/22 18:24, Marc Zyngier wrote:
> On Thu, 03 Mar 2022 16:11:39 +0000,
> Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Register default arch handler via driver instead of directly pointing to
>> xilinx intc controller. This patch makes architecture code more generic.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>> ---
>>
>>   arch/microblaze/Kconfig           |  2 ++
>>   arch/microblaze/include/asm/irq.h |  3 ---
>>   arch/microblaze/kernel/irq.c      | 16 +---------------
>>   drivers/irqchip/irq-xilinx-intc.c | 22 +++++++++++++++++++++-
>>   4 files changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>> index 59798e43cdb0..da568e981604 100644
>> --- a/arch/microblaze/Kconfig
>> +++ b/arch/microblaze/Kconfig
>> @@ -45,6 +45,8 @@ config MICROBLAZE
>>   	select SET_FS
>>   	select ZONE_DMA
>>   	select TRACE_IRQFLAGS_SUPPORT
>> +	select GENERIC_IRQ_MULTI_HANDLER
>> +	select HANDLE_DOMAIN_IRQ
>>   
>>   # Endianness selection
>>   choice
>> diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
>> index 0a28e80bbab0..cb6ab55d1d01 100644
>> --- a/arch/microblaze/include/asm/irq.h
>> +++ b/arch/microblaze/include/asm/irq.h
>> @@ -11,7 +11,4 @@
>>   struct pt_regs;
>>   extern void do_IRQ(struct pt_regs *regs);
>>   
>> -/* should be defined in each interrupt controller driver */
>> -extern unsigned int xintc_get_irq(void);
>> -
>>   #endif /* _ASM_MICROBLAZE_IRQ_H */
>> diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
>> index 903dad822fad..1f8cb4c4f74f 100644
>> --- a/arch/microblaze/kernel/irq.c
>> +++ b/arch/microblaze/kernel/irq.c
>> @@ -20,27 +20,13 @@
>>   #include <linux/irqchip.h>
>>   #include <linux/of_irq.h>
>>   
>> -static u32 concurrent_irq;
>> -
>>   void __irq_entry do_IRQ(struct pt_regs *regs)
>>   {
>> -	unsigned int irq;
>>   	struct pt_regs *old_regs = set_irq_regs(regs);
>>   	trace_hardirqs_off();
>>   
>>   	irq_enter();
>> -	irq = xintc_get_irq();
>> -next_irq:
>> -	BUG_ON(!irq);
>> -	generic_handle_irq(irq);
>> -
>> -	irq = xintc_get_irq();
>> -	if (irq != -1U) {
>> -		pr_debug("next irq: %d\n", irq);
>> -		++concurrent_irq;
>> -		goto next_irq;
>> -	}
>> -
>> +	handle_arch_irq(regs);
>>   	irq_exit();
>>   	set_irq_regs(old_regs);
>>   	trace_hardirqs_on();
>> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
>> index 356a59755d63..c6710190c152 100644
>> --- a/drivers/irqchip/irq-xilinx-intc.c
>> +++ b/drivers/irqchip/irq-xilinx-intc.c
>> @@ -110,7 +110,7 @@ static struct irq_chip intc_dev = {
>>   	.irq_mask_ack = intc_mask_ack,
>>   };
>>   
>> -unsigned int xintc_get_irq(void)
>> +static unsigned int xintc_get_irq(void)
>>   {
>>   	unsigned int irq = -1;
>>   	u32 hwirq;
>> @@ -164,6 +164,25 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
>>   	chained_irq_exit(chip, desc);
>>   }
>>   
>> +static u32 concurrent_irq;
> 
> Please kill this. It serves no purpose at all.
> 
>> +
>> +static void xil_intc_handle_irq(struct pt_regs *regs)
>> +{
>> +	unsigned int irq;
>> +
>> +	irq = xintc_get_irq();
>> +next_irq:
>> +	BUG_ON(!irq);
>> +	generic_handle_irq(irq);
>> +
>> +	irq = xintc_get_irq();
>> +	if (irq != -1U) {
>> +		pr_debug("next irq: %d\n", irq);
>> +		++concurrent_irq;
>> +		goto next_irq;
>> +	}
> 
> How about writing this in (basic) C code, and use the exiting APIs?
> 
> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
> index 356a59755d63..18125bb841b2 100644
> --- a/drivers/irqchip/irq-xilinx-intc.c
> +++ b/drivers/irqchip/irq-xilinx-intc.c
> @@ -110,18 +110,19 @@ static struct irq_chip intc_dev = {
>   	.irq_mask_ack = intc_mask_ack,
>   };
>   
> -unsigned int xintc_get_irq(void)
> +#define SPURIOUS_IRQ	(-1U)
> +
> +static void xil_intc_handle_irq(struct pt_regs *regs)
>   {
> -	unsigned int irq = -1;
>   	u32 hwirq;
>   
> -	hwirq = xintc_read(primary_intc, IVR);
> -	if (hwirq != -1U)
> -		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
> -
> -	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
> +	do {
> +		hwirq = xintc_read(primary_intc, IVR);
> +		if (unlikely(hwirq == SPURIOUS_IRQ))
> +			break;
>   
> -	return irq;
> +		generic_handle_domain_irq(primary_intc->root_domain, hwirq);
> +	} while (true);
>   }
>   
>   static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> 
> 	M.
> 

That works. Sent v2.

Thanks,
Michal
