Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8212A4CCE28
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiCDG7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiCDG7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:59:13 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B811C19
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM9Y84pXPsTTDSiLtL9fNi6gJ8SAO6b/RQ3KifAj91y8aT7gN1NE1QZ2j0EwcSH1WD54RBow9ND+EDVd43ahekhJgRQJ1B8/oOsxvq1Zz9YuSFMqKvwkVU4/lYJw7494DnHtGTJmtb8UvIoUybKgpOQiqOqKeFaNnbfMBUmsHo5ux9iAxge76gvzkY07FIrMACa45BiuFYzkbWaIlu3mHcD4Hdz+0kOovR75zjtvikXbbqs1K/uLHGhihupTDQoXgwrhLJfEFAH0L5Qku90n7w3WuNoeu7PCkgIX+2Oo9AQ3FA7oZMkElxOp6ShPl0TqR2dfg2Ultu7kkHpOvOvbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhKNB0d4qhNVDlloqR17pXrHMcaTsC4G5jtwh5NnqbM=;
 b=jlBF3iQdLRT+PN84RK/YjjVTy91xeJwcuWHPws0u3aa3gFotExGFwEzK//KhjTVCezh4++1ABg/DxcZcowBmmdnzztbKtIl3Wtk27W4EhxbEfPkfnms9ybuYeuFMSebWq/R1ieUdAiZSQBBgytxDqXhXcN2k5mQhG4NWSw4booaofvdfKZrVtXeAwocN/SXuBPZ2H0OhUaLURttwtfiuxMHFUqojNoDM8Ofh+u7cGEwf8FEz7NIZ8uxs0juK246k5LTXQtjSM6eXSnnk4BJDF0XMiVtQLWmSZAd5av+TsfVl6bZfgCMUr+iWTs5YRlah5bfmy0AHxpHmZgRnbVAkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=calian.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhKNB0d4qhNVDlloqR17pXrHMcaTsC4G5jtwh5NnqbM=;
 b=GN6F+QWLC6djk/BZUscIWOucgPGCdl8VjwK25WlbQthpPDHH5kMSIn9WlcmqfC9LprFN05Swg5NIXxKGA5zKzqvf+kQ8q3oVtF0s1gzYG+6onm9e7pAnUVPARwAuneizXwpBUh8DZ7vmfGoWHnecl+Iglg0MVAdZEwvMsjSY1fc=
Received: from DM6PR21CA0014.namprd21.prod.outlook.com (2603:10b6:5:174::24)
 by CY4PR02MB2823.namprd02.prod.outlook.com (2603:10b6:903:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 06:58:22 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::3f) by DM6PR21CA0014.outlook.office365.com
 (2603:10b6:5:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8 via Frontend
 Transport; Fri, 4 Mar 2022 06:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 06:58:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 3 Mar 2022 22:58:20 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 3 Mar 2022 22:58:20 -0800
Envelope-to: git@xilinx.com,
 robert.hancock@calian.com,
 linux-kernel@vger.kernel.org,
 monstr@monstr.eu,
 maz@kernel.org,
 tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Received: from [10.254.241.50] (port=37780)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nQ1tM-0006Em-60; Thu, 03 Mar 2022 22:58:20 -0800
Message-ID: <92ca12e2-9efd-702e-6940-7fcdc873da7b@xilinx.com>
Date:   Fri, 4 Mar 2022 07:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] irqchip: xilinx: Enable generic irq multi handler
Content-Language: en-US
To:     Robert Hancock <robert.hancock@calian.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "stefan.asserhall@xilinx.com" <stefan.asserhall@xilinx.com>
References: <2a08d6c33e95d5da5d564ed3fbddc835983ef355.1646323896.git.michal.simek@xilinx.com>
 <32881b5e94487845874b78dd36bbb5edec683e75.camel@calian.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <32881b5e94487845874b78dd36bbb5edec683e75.camel@calian.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e98936-1a20-48e1-85da-08d9fdac5f09
X-MS-TrafficTypeDiagnostic: CY4PR02MB2823:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB282359F2E7CE7D5D570D95F4C6059@CY4PR02MB2823.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TA/L7BB47XHWd1bfgLIOHkfXzPjExFmTAYfWmRq/+exrtNiaKGPsuGCsv/wtMR8GvOklaECrL8+pVv4d0C6Ef5yhvXB/DZIOahPvEBTShcgt4Gsy4D6EXkzK8vuy6Zs23R35iz5DWnPfKWGZ6ulfhj7FOpOgZPBPyf/tnFgeMYL6B3fzuRvDavlr/VilY7Xb7rvG6SoYQLPhubkxKatG/VRbOiJ6u4rEC2n5Zz9aqBy5jqu+8/om57cj3BxNrDKkWaU0f65gmcKOcKSqrowx+zLIoNVu0eOgfpCRy0LaSTI5vzYnqjSv3Yw0LsxHbqC9l8TKcDGE7ZP3Xe3QIFkG7leFdCD5J7oM/Bq4hfLah2wgjsEQ2tVFdmze9qwL2UHiTok/lLIJA0lVBpBrtGa5WDhrGiyNHCR8kc2QyWA6PU4ldHiSNPNj/nkT1Ycw5m3PMzx78DqL3DjZ4XZdeedN87YO0OXAngleG6/srMPBneukImQQqHlkReVrOhDaQQqpCVQXnZ7Tla+NxCr6jrcS6kP4pWQ3o79vjAHecmAwbgISVG0blriHxKDYZZEODdV9oNH7LgdcG0aYE/n0h+VSk9I/PzCoqDJEARtu2sOphUIXZOUNYi0b2BSvXFofyqZlEIDwORmvz9uvv64VOU33WzcdkIfqxoT923LA/mN/qgRL2ybj4PMfNgiR4+3ght4wgl95kHz5iRf8F93uH3Wrp80WKvKZZYkV6ty25dVcr2dEmv+830Vjm1//e5C0/skU+1WR4jbwUzWhY/0HmfgmMA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(9786002)(5660300002)(316002)(54906003)(31696002)(44832011)(8676002)(82310400004)(70206006)(70586007)(2906002)(2616005)(186003)(26005)(4326008)(107886003)(53546011)(36756003)(356005)(7636003)(6666004)(508600001)(426003)(336012)(110136005)(83380400001)(36860700001)(8936002)(47076005)(40460700003)(31686004)(41533002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:58:21.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e98936-1a20-48e1-85da-08d9fdac5f09
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2823
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/22 18:01, Robert Hancock wrote:
> On Thu, 2022-03-03 at 17:11 +0100, Michal Simek wrote:
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
>> diff --git a/arch/microblaze/include/asm/irq.h
>> b/arch/microblaze/include/asm/irq.h
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
>> diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-
>> intc.c
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
> Not sure what this variable is for? It seems to be incremented, but never read.

I used this when I was checking how irqs are working and how many concurrent_irq 
I am getting. It was read via debugger not via any linux interface.

Thanks,
Michal

