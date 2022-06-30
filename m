Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D954561A65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiF3Mdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 08:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiF3Mde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:33:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6699334659
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr96v5DDg9m/j1DjquhUnEAzSLCczA/AIABX4ulVUf0+Ye11nurwJYGR+1KfJ73fSvNn49YMkCrtV8aM4/osPReC7W7RHuTPdkmecTbkkYnIZf3V0xDnGODOk4PKbnqMlSZLgNCqE8D/hrn1M2Jat1la9kXw8LgvEZxM0GrU9JBsIx7Od4Kh8KSHC6YcMQSvDkEhGX+S6XMMwhr9CGYHAGw5pfO14JJeHKPKp4q5rqPdL1bCWC23p3x4qDzpGlkFzgFyLtnBjwHfsroINDTMuJxWlgt389WvFhS1zcFXafekIlxTT8CFS5QvTXFNqAKDCJZJQSf6pW+o/01qjEpxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoCiU2oSV6UW528B3KQNZ4Xv095zacIgD10RvQ4/3G8=;
 b=Wm5joNbcNnP9VoJgRhk/j1bwq4xI6Cie/zjm/6zzxMtIuhQqh3luMUOp4ea3urvXDdC75V9d3WT0rvSaV8dtlTWiljXqKACyGVE+sSfjjvePS2PaNEtGAWzJyQ1x30JgRbth40GjZsWOxiRk1hbiTRzggzW/d43QljgjUhLVUx7GQIjfJ7DCISj84Pwp98CHvl51peeHW03b6cHqyIj3cQasYQLaFxkB6dTjCQAYMgorGrZiIg00bEccYoEvH6u7PYJatc8vR7sFyJHIpalDXwdPY1jG6dLP1zpzRSgWnlvu5iYgmyeoJhGGV1pxGYx4uDiR5Wc7A+k4a0E2pFs+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=jamieiles.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoCiU2oSV6UW528B3KQNZ4Xv095zacIgD10RvQ4/3G8=;
 b=iPSCFu3t5/jqIQXk5mH3qs79/FJCnKggv5b5cy3ZKRAyM9FvM0uZb6LxjZ4VC1beNT+Ikh9pMDFamPhsMPCRApO6i3i6gvMA4GyM5ioC+0QMAG3KFMIKBL0TvtK/WLIM/tDljB1nWw9Ao6LyGxIOz8hwMLJ6RYGyJb0a1pbTdPo=
Received: from CO2PR06CA0073.namprd06.prod.outlook.com (2603:10b6:104:3::31)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 12:33:31 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::d1) by CO2PR06CA0073.outlook.office365.com
 (2603:10b6:104:3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 12:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 12:33:30 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 07:33:28 -0500
Message-ID: <d51b5494-66db-69a8-cd34-40d33f4f212b@amd.com>
Date:   Thu, 30 Jun 2022 14:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] irqchip/xilinx: add explicit dependency on OF_ADDRESS
Content-Language: en-US
To:     Jamie Iles <jamie@jamieiles.com>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
References: <20220630111008.3838307-1-jamie@jamieiles.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220630111008.3838307-1-jamie@jamieiles.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8fe78ec-f22d-4434-a2d2-08da5a94bda7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4421:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdyPDijD6rIiwbcQpKSZdtBZ3VLfSTmkTmSFaIHDXVE8HC6y1SorBoDpMWrf7ZT/v2AzUMYCanDZkYkAZ7rFpPO86ismwed5XmUgAGXD6QTfJv1AApo1aqLhgF2yCR6m+PQjpr+6yEf/vY0OD6R3V+cPgLUyaSu2CzcUW1MiJESZIXyhD+AasNe5Zke9+b6n6/+K/6Lz7jtWYF8HGn15DjEUmfuMPs9n1PMa8EQCkgLNH6s5ofvVsOHcHufF/mxG9WM9hnttx1uaxD3v8PC+BvJCUgyE7n0m+hg2xCkfoiH90O5yWFgE/olSkkGLJRmPIu9O4yoo0ZGxzSev/U4AIUQmLBOcY4++S2l5+P40LXZHQmT6w3xD3FGevoModSS4xDkISsl8HvUAU7dAYasGSoQA6/yCqDuhd4DfEWNS83bDkAZaXLH+vlWqOZDDiys2zzxUDloE9CooP1ZD4R1vvB3T/PCc3gFVLYgApT/KGTFtZEhxJFu2FGxmlCp5l7hL4Pv4hppHIgp08x2V5PqJWN4krgrbL0FVNFnQddkFZR22HiD61WjTlwjqHOkUT14v7R1fsjA3H8N+gROHqaOVDQaWguCizzYO82ewV+bqbovElX0WL1LB/CfQs/nVwE+55mzdzBHJ/R2gA3UYWj8KMXpcfASgy0YLYUsVyqfTU54OTmmcFNyToY0pC5yYFUbEE5UdnC4/+FHFUKiAZwKA7Ok8twZlCGPOg9MpvDbRxTUT00TkijBvQCb9B7CJt4uq65Tne9GlD+49hVjMSeFUVdxbaACNY+hVX06IIuH5cP9L8br87fh3tG9NGclcLhV7mxvpnh74w9SMFMX+IeAnBgYzNwXHGSdYurbYp/AhjZtu6Gpm5nRv6IY8ActJHHOE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(40470700004)(44832011)(86362001)(36756003)(31696002)(41300700001)(83380400001)(31686004)(2616005)(40480700001)(2906002)(8676002)(110136005)(70586007)(8936002)(336012)(16576012)(40460700003)(16526019)(82310400005)(81166007)(4326008)(5660300002)(6666004)(53546011)(478600001)(356005)(186003)(26005)(36860700001)(47076005)(426003)(82740400003)(54906003)(316002)(70206006)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 12:33:30.8011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fe78ec-f22d-4434-a2d2-08da5a94bda7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/22 13:10, Jamie Iles wrote:
> Commit b84dc7f0e364 ("irqchip/xilinx: Remove microblaze+zynq
> dependency") relaxed the dependencies on the Xilinx interrupt controller
> to be OF only, but some OF architectures (s390 for example) do not
> support OF_ADDRESS and so a build of the driver will result in undefined
> references to of_iomap/iounmap and friends.
> 

Can you please add here fixed tag?

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>   drivers/irqchip/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 1f23a6be7d88..bbb11cb8b0f7 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -298,7 +298,7 @@ config XTENSA_MX
>   
>   config XILINX_INTC
>   	bool "Xilinx Interrupt Controller IP"
> -	depends on OF
> +	depends on OF_ADDRESS
>   	select IRQ_DOMAIN
>   	help
>   	  Support for the Xilinx Interrupt Controller IP core.

When above added feel free to add my
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
