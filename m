Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A962546A40
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349085AbiFJQUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFJQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:20:18 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB621C389;
        Fri, 10 Jun 2022 09:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/N1tzV6olp9TxPX3D+gIZoBuoFdsZRYWFs4Q6cRHJ2aPt9fMr6NVLpxKwwzl8V2PeEqDFfl6H+EmCjcEzTM15D7sk4fCJsxSI7nyvoydPkcQlqA/kTHan9kdifg5pfbJRdFNYOT6HCk+FrDIsiyN+s2vtvJaTab7L2CiNm9VVUBTggSWE5mdudOsyH18oMk3iESMomdEPGqsMG+dMFElS7tg0UVSTdXz5B3qbTeXPv2tcgrmTd0ONZ7xoMQlADzXPoV1VqRN4gQkAYynSJYQiNtHj4VcT1k9IVm+kTmG2PtAbgnXpQZuSR5PeG5wmUvi2rgb/1r+otAJMC+7RClQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX49xX3/BLUjRnDleJdUm1mkUGkQg3S18U+lqDF6olQ=;
 b=HMbQybjRrg+X7SzCzfZXsmlLxEYd/1Am6crD/A/n1sZ0d0BB9rY1Jcwj13FiXLI8K4cBVMbzaKORK3O+pJIR3NrAJBs8sNo7+lk+xYDf+r/aezUCfS82zHAShOTGCqwn2bvLsJ1wrNFqMXLy4fqQ5N2uiQRiIo6tNEXO5FwJgKgvuTgs0HhZtfxS7ynPAbOqwkpMy1t1U/wQwQLu5tVNomjm/DQF2I2g82AL7AjKcCwzHsAU4itG6jyE/9wBHVBioOTLgQBaAqlGcDdhQC6ioG3tiMJp5PsmcnKV39YGCLGgc3rHIjErEesW0AoJpE196k4zZq+xKIR37qAgdHAsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX49xX3/BLUjRnDleJdUm1mkUGkQg3S18U+lqDF6olQ=;
 b=HBo34lcvL33js9YBHMNQoTNwwzBLXq/cXyxvta+Ze2sKIM80X83SqYcgWlO4F2yR5YUVEUAcgrYngk3K8wOmdbutLPaPE6TEv9HSDlHfSx6lVruEjqFytW6Kkj6rDh072nvpo/iWe49fdCAdIWM9HC0nnZWDbpAmjQ3aLJHN9K8=
Received: from SN2PR01CA0042.prod.exchangelabs.com (2603:10b6:804:2::52) by
 DM6PR02MB6732.namprd02.prod.outlook.com (2603:10b6:5:219::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Fri, 10 Jun 2022 16:18:13 +0000
Received: from SN1NAM02FT0049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::f7) by SN2PR01CA0042.outlook.office365.com
 (2603:10b6:804:2::52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Fri, 10 Jun 2022 16:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0049.mail.protection.outlook.com (10.97.5.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 16:18:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Jun 2022 09:18:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 10 Jun 2022 09:18:12 -0700
Envelope-to: robh@kernel.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [10.23.123.85] (port=54254)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nzhKu-000DiR-1H; Fri, 10 Jun 2022 09:18:12 -0700
Message-ID: <e7e4ee5c-5593-3bce-af82-850d12e1b037@xilinx.com>
Date:   Fri, 10 Jun 2022 09:18:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzk+dt@kernel.org>, <michal.simek@xilinx.com>,
        <ben.levinsky@xilinx.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-2-tanmay.shah@xilinx.com>
 <9722112e-770f-53dd-4b28-48be696c0d12@xilinx.com>
 <20220609173337.GA3996953-robh@kernel.org>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20220609173337.GA3996953-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 768ae8e1-2ba2-4f92-15b8-08da4afcd156
X-MS-TrafficTypeDiagnostic: DM6PR02MB6732:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB6732BCA2199348236E24BD97CAA69@DM6PR02MB6732.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5Ghw8U/gfhyVj65GdZWbgCz5vD5fkewTxhWGegNINjdf3zrSZbeMpYZjZrNn6QHqxQOYNna1X9GnwncaIF8fv1ooL+gjgR0M/5ktF0qLOvU1JN3IvjC+gQJfEfAL3fpn76OeNo23GmnjvGVKfoHHufz6Ff/UKWqebpsOHSE95hZH7KPu7G8db96buoD+XK7W7/OQnDsy+wbZeQPgHckUKIC/wpvExllmWhkW22EvTL7qjfpUjqRMAekZwWgudK0wjVyZiPueL33PlqhJPvTNw8g5zaKKcO7uKt9OGVPMVjHMhnIyywtthceq+qVPK7SEdDnGngqRrm7Oq83qHw5CuQGa8RZSuBz1WZ914GEY1x3ITMtq237fEkvlAqSxLTawEc+e+fAjuyLgGEGo179p/gPuA3QQrlX3K4D11ilVzd9eT3TuFAJUJSpwX2NN+iZDTGMgnD5o2v+G47L1s6GDDcwMKBRR6EsFj9DcCDHW8w/gGPz70DWTHeuYw3jBQBc5qCGd+PK4JbdfuectnPZnkbL0hDc4WAeFsKUkLFMFY/o6gfznvcAoxxP2HJ2DIoNczNFKZ/tX+R8K7PbVh5z2pQUcj45xZdQXUPfGWnzSY1W1S6OA2fXzFJExg0GWb0VBhfGhsrmthASnWSDKL8iglesEzAX5CzSXQdnZs14ue1+FRZzAkIVn10LmrLkJOLdydIRRJLVfFvtlwZSjZp5hiy2c0gL7YgDl9HmBhaVl7bKcgQ1YCrOrk90azI6g1SpjBkMcPO2dZq0dMa4JbPYZpNrlfJKZeJ+QdIYJJyWMwh6To7/fb8ZcsMIawiitryw
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7636003)(82310400005)(8936002)(356005)(36756003)(5660300002)(9786002)(44832011)(4744005)(31686004)(4326008)(8676002)(70586007)(54906003)(40460700003)(6916009)(316002)(508600001)(26005)(53546011)(966005)(2616005)(31696002)(186003)(70206006)(2906002)(47076005)(336012)(426003)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:18:12.9859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768ae8e1-2ba2-4f92-15b8-08da4afcd156
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6732
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/22 10:33 AM, Rob Herring wrote:
> On Tue, Jun 07, 2022 at 10:32:48AM -0700, Tanmay Shah wrote:
>> Hi Rob,
>>
>> Ping for reviews.
> No need to ping me. You can check status of your patch here:
>
> https://patchwork.ozlabs.org/project/devicetree-bindings/list/
>
> If it is listed, Krzysztof or I will get to it.

Thanks for the link. This is good to know.

> Rob
