Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3960F46780F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380508AbhLCNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:22:57 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:46784
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380256AbhLCNWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:22:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7fAprcAD72eKYeHNXbtA6MUWviZqGB1PqFodYCwmuvXCD0BCYHA6jDVIwO0iJqWnKxU5C9bA0jYW5hfzYy3I6SM6e0ay6lQGeyrbZ9kCl6qa1A1arxymjVQuUY8uh6RW6/kDeTRMYbd5tZ8CRwCba7KYuBdYd5HYz2r65rw+MvDyjWEY6hzqoMnMzRMUP697hyFz6zTv4Frtamzy0SC2lqrtoejBGOSzTwwBaHJwxdkS+HIQJJmmAzqTmkwQ3E6lwxyy2uaWd6yeeAYwcTYlOaujR5Uf6yEo51US/WHSTfCjr0F8AkuUJQ4T9aEWMmzlfwZmxcpTzu/4dSXFzFlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkDJN9ra02SH5AQHWPW8KVl8VqzKXn10DI9C59e3VgA=;
 b=FMgBob69o3pM3JBt/fFbiJ2SAxH6p4wk/xEOmy1RqLNxVpyHnPyt8SRWtbe9FUCbEEUdyOevfTHQRwKbwPiuY811g9MXaRmONeUkUJqiD/uWffuKnCdG+DACFFHpIQ7uOAnC2ZCF1QdrToAJplylpYhfWABoYQwCARlGazHemb3ZyO4suJFFEZYn/pRT7npzKwRFEo9xU0vFf+rogDfyDDjogQ5Q6Vix7XLkiGyLZ5rO3+U898c/pMFUuZiTmz82iJgFlVskDpa0PxV9L0SsIJXyE0Lqpef3ZcF8IcF5C2kD3tYastflcN/4jg2smtIy3sIjGIVYsf3HtWaikwTLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkDJN9ra02SH5AQHWPW8KVl8VqzKXn10DI9C59e3VgA=;
 b=MHTZCzn6C8fuQCPFVb9wjoVEUERDcSxpk0Ov+hvfVhjVqr5ZnyxFFRK3PxcsGFfUlskgizjU+2Q8pPc80QJd3Z6CLZmAbTjomaKC8GwK04n7NimINLIjx26UQXknKzla8kSWxyotN1Kke4qiHplZ7+U4Rg81hobJvg8HWXoi2QA=
Received: from BN6PR20CA0054.namprd20.prod.outlook.com (2603:10b6:404:151::16)
 by MW4PR02MB7220.namprd02.prod.outlook.com (2603:10b6:303:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 13:19:22 +0000
Received: from BN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::b9) by BN6PR20CA0054.outlook.office365.com
 (2603:10b6:404:151::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 13:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT034.mail.protection.outlook.com (10.13.2.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 13:19:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 05:19:20 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 05:19:20 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.254.241.49] (port=40986)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mt8TA-000FT0-4L; Fri, 03 Dec 2021 05:19:20 -0800
Message-ID: <4fcdf420-be35-392e-0216-8cf162c93873@xilinx.com>
Date:   Fri, 3 Dec 2021 14:19:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 1/6] drivers: crypto: Updated Makefile for xilinx
 subdirectory
Content-Language: en-US
To:     Harsha <harsha.harsha@xilinx.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>
References: <1638213623-32613-1-git-send-email-harsha.harsha@xilinx.com>
 <1638213623-32613-2-git-send-email-harsha.harsha@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <1638213623-32613-2-git-send-email-harsha.harsha@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d555f0c-acaf-4e5e-71b9-08d9b65f8492
X-MS-TrafficTypeDiagnostic: MW4PR02MB7220:
X-Microsoft-Antispam-PRVS: <MW4PR02MB72203D0F554A26478CB9D427C66A9@MW4PR02MB7220.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8I230IAaYbZiam/enpYTMv4gPDIgMpdio8+kRRghP88M3tprkuXtw5xQchwAGLh9l6eb/hknfe5afGUCHTG1Omfxh++3bwOyvJ5aIc5nvh/Xh8xvvoAxxDB0jIYV2h44DJrPtkldv4luRJIndr71qSO4EkGW0Lzk3aejUaeIiqBul+PuQ7twwNaLsEL9okJ8bNiu6dfn1QrezSBmdWmitXzY+7IbURrZjDHquKGhJ8plMjWwshRA4HbblrfoESp97F1YqzvQhGWczdX5v1Bl2jhDSHwCQ+5mA0dYQ1CMuI9+DqoyNusdPcJaZn7IR0SwloAaXCfcQtCixHu9RFzW6Sv2v991rC9IFVmmvH7pSGItRyDjXHWAPUyC4pRNK82d149+nkUGtcVMVwyRRK1QHiWq2EO/MgfHw1MwNK6V4Bdf9ncxXmvuHmFiFUhRB92qvBc89PxyQqD7I4rzQhxH7fIiG15HmSUWVVO6aIFsDBHXGra9k4PGcmr/B8KFUdgoFeOTgt0IQIE/E8LfLljLs+B8BLS+psuzhfz9T5tzwkb/Ay1TbW1lFKyLe0IE5SVQ7mX4wFJ2TPB5XZ4BqADphyMdBcZoLd0Pgz3COLHZNGHfVpRTsqWfO94Vl7z9JcGhWw21xVWKSnXckXmrHl7Bydb2HZ47UIQOW7Ubzl2RcZfso3ZEi6U+HGQqa5nmnLNNRyx9Io87mFLUjRkJ+BvebxZQR1fOb6krZ4WvYdIcWNnPeh76HFYbM349lAnbxNgp4TH330XTOP5ukDXjHr7rrAq4nUU+ZKTIN1NggD6NUg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(186003)(7636003)(107886003)(2906002)(316002)(356005)(508600001)(4326008)(31686004)(15650500001)(8676002)(110136005)(6666004)(26005)(8936002)(5660300002)(70206006)(426003)(82310400004)(70586007)(31696002)(336012)(9786002)(2616005)(44832011)(83380400001)(47076005)(53546011)(36860700001)(54906003)(36756003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 13:19:21.0567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d555f0c-acaf-4e5e-71b9-08d9b65f8492
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/21 20:20, Harsha wrote:
> This patch updates the Makefile for xilinx subdirectory.
> Currently the xilinx subdirectory includes only zynqmp-aes-gcm.c.
> Since this patch series adds zynqmp-sha.c in the xilinx subdirectory,
> so the Makefile needs to be updated.

You should change this description.

CONFIG_CRYPTO_DEV_ZYNQMP_AES protects zynqmp-aes-gcm.o and it is used 
twice and it is enough to use it once.

> 
> Signed-off-by: Harsha <harsha.harsha@xilinx.com>
> ---
>   drivers/crypto/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index 1fe5120..0a4fff2 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -47,7 +47,7 @@ obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
>   obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
>   obj-$(CONFIG_CRYPTO_DEV_SAFEXCEL) += inside-secure/
>   obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
> -obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += xilinx/
> +obj-y += xilinx/
>   obj-y += hisilicon/
>   obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
>   obj-y += keembay/
> 

This should be regular patch not just RFC.  When this is fixed feel free 
to add my

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
