Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A7853F70A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiFGHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiFGHSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:18:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872505DD13
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RviGHrreQ2jouI6e4AHkAT61i3Q7fAhjRhxAYqAuhuazYvhHmXMzlqGO61GodAxNdwR+5aj9NQEAMUEMk7juCmms0prNF7LTz7N3grBR5L4hssKJCoofM5wPXYyYLLJnqjyR/5jL0FcaMTZMnq9fCkDydWcGr4iUSBDpBYTEYS05AIFJ2X/H6/90CwyySGLlzUsFUQt6eKyD+ci9Ahm0norbalUudyW7dj9BqVAuoHfjNUgOJfV41feaqk890u508H/Ap7N2Jd86kH/raf/1Iigx1ErjEqNU9kIRZmz34fhtS6BVzdSdWLpNYcmPjpDXi9AnP9yu/UECQixQhbtslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ+0Vk/D0LOUg1ZZbntdk7X/3lBi9ox7hcf0PK5UBRk=;
 b=Bu6hfklynRSd6D3fuZnXXPOWXqO8RYSxO8uQ3bwRAKJtg2eRnx9k5tsbKRwqGzS/ra0re/7jKgFGXo2aqNKLW7WEVxK639HikiivBccPRqdEBtDGXP2QGv+W0ZJ/M8Nr46Ob8mNnn4dqy6S5enN3hWx8wxw2QAxGuGdWRoK+sW8Zi44DlEw/2rQkHB5KwmZMZCe0dLD42hbO0smMEZxGmQDdI6qZowJW04dKYUlnorH69qaBPQBZ7FYM5TqhiL6uhpbgvt7vITYUh2gMIgskGJmXGRhh8Nkb02pw8Hd6EWGUKuLqo9NdAOzgJbdrpZ4Vd3f1m9gIabokcAgMwXsZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=jamieiles.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ+0Vk/D0LOUg1ZZbntdk7X/3lBi9ox7hcf0PK5UBRk=;
 b=khqeSvWyqhltG5wEDRBOJAqX8FTsHh6n8TbU4zXSz2NpjRPGKC56nQj3hdZKU7WJnw9A0KtPaITcp3N+93JDm/S1Cl6Of6QcdlXxdlCv0pdtle6G+jn9hCHTuvFs7yw9i0zOxdwjsURTuTCuOz0SOxWtKcgQnkqxBp2JQGa8d+o=
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by SN6PR02MB4622.namprd02.prod.outlook.com (2603:10b6:805:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Tue, 7 Jun
 2022 07:18:42 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::e2) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 7 Jun 2022 07:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 07:18:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Jun 2022 00:18:41 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 7 Jun 2022 00:18:41 -0700
Envelope-to: jamie@jamieiles.com,
 linux-kernel@vger.kernel.org,
 tglx@linutronix.de,
 maz@kernel.org
Received: from [10.254.241.50] (port=42540)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nyTU9-00028s-5y; Tue, 07 Jun 2022 00:18:41 -0700
Message-ID: <207ba1c4-03fb-0f9e-19d5-dde1c430c13b@xilinx.com>
Date:   Tue, 7 Jun 2022 09:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] irqchip/xilinx: remove microblaze+zynq dependency
Content-Language: en-US
To:     Jamie Iles <jamie@jamieiles.com>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>
CC:     <michal.simek@xilinx.com>
References: <20220606213952.298686-1-jamie@jamieiles.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220606213952.298686-1-jamie@jamieiles.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79132424-c5e2-42a2-cbec-08da4855f391
X-MS-TrafficTypeDiagnostic: SN6PR02MB4622:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB4622D7450277E1F108BC7419C6A59@SN6PR02MB4622.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHJu8oEJEWPQas5Ujh9pn788Tte3w+NoCJlO+voykz7293wIaYxPKJnHl1iwyZgIjYG4Y9jecmdV5d8E4LiQx6mZ2U6bgqzg8tLiJbUWOGsWvrMkWf+3xVzfwMQ3atuCjKbU/hGS/lcLxEqPdjjW3VvhN8OuoaWzpp/I8TuXo+8ne7vH64ZbrSAL1QevDEUntAKoaVvgYmChKEcgeZLCMQV8SSdZlj2wlWeMJOT3XuKpXfwgITwen1ZempgCoTDwqFukOqO6eqZJu0VzMiwNxYfAldtLXc6qP1IPPlelUe6U2qpEhiZFzJh8aXwCWj/gzxxP8nSdLR8oBqykOftaxVfMnEmH16NWV/izj/SBXa3W0cORw7hkTKKr3PfOcf54LV0YgV200izbhhKYQnq+NMovOmZIe+tqUs+a0/T9lsZZI5FRgA7AqyEtQRolasoaNvRshFYHhOX7kFvh8jOdNyZTI7yNPGVIgcOlERSOuQctkh+17htXQLUpkWA4YJatrLt6L+QqCJ1CT7BuLZM971gJr3lnltLxDxI1etOh40jAMJTz9X3Fz+Z/G0//c5tM8muJqy73k7o1mjXtBuB+nN2x3oqI6+qerIHKqChnBBfrYBGUuldy6KVg7KBP7JkElFQdsJ0+uGN+FTj5PK5mKVe4QUOFYpGgOsF766g0id+DjHkMCLuT2dIMjy2VUFM/J+5A87L0wSQe4TgNZ+req0DgBRZ8hUFpdcMLaH73hOY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4744005)(36756003)(44832011)(107886003)(47076005)(82310400005)(186003)(31696002)(426003)(70206006)(4326008)(8676002)(70586007)(2906002)(2616005)(26005)(336012)(5660300002)(110136005)(31686004)(40460700003)(36860700001)(356005)(83380400001)(7636003)(53546011)(508600001)(8936002)(9786002)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 07:18:42.1247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79132424-c5e2-42a2-cbec-08da4855f391
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4622
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/22 23:39, Jamie Iles wrote:
> The Xilinx IRQ controller doesn't really have any architecture
> dependencies - it's a generic AXI component that can be used for any
> FPGA core from Zynq hard processor systems to microblaze+riscv soft
> cores and more.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>   drivers/irqchip/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 15edb9a6fcae..a81d57677a39 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -286,7 +286,7 @@ config XTENSA_MX
>   
>   config XILINX_INTC
>   	bool "Xilinx Interrupt Controller IP"
> -	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
> +	depends on OF
>   	select IRQ_DOMAIN
>   	help
>   	  Support for the Xilinx Interrupt Controller IP core.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
