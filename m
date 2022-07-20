Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB157B2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbiGTI0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbiGTI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:26:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4201467CAF;
        Wed, 20 Jul 2022 01:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3C8t4XeoN/0VkdGf27geeF5Z+lDt7ksmzGoD+RB1TUIoYR3e6bSU+DLeRbp4lVXxCs2Kg5M91nCdgXd85TdYR0cXJOEKOYTavT+bEYRvNKg5v5ww9ud+6fZOM4O84UXMjD8cofVEUejzxbYGUlGsMesGGWEqHf3+Ivd/Mwkh+OsT2QkldrnRFSYxy7hluDwIyDb24ErttnGcbXbAx98RBhQEFMcqxKKcvXGgB7V5rs+JwCqveDCoDXgJBC+aGlfrhb4RJDP1tmUauMGjy7kCH6mTZE7tR3yRxfA7erKXGrUMqVpML8LwjAjUmFsm0SIliP05WG8B/rq0wnkJMSqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xBCNcW2WzPcFBhr8fpAT6bi8jfXH9rZ3ePkWdO3lWY=;
 b=M/82lowmDk9hFohFuyEMxmstjWwOT3vgfKLEJFSuizBGXUuavEsyaKstfSvSEQxa3w47vRjXQ0jkg6MFCDFRHTd1zw8/X5s2ul5HQ9XLqz1TWVqhfzqRX0PlXZSTTZR18bOeYnxYEw0Xo61idmS5d3JNgVft9lzzFPCFrTUer0ywYFjWz88XUpP9UIEf5z464OKcZNCtMHh/wi0mq8puw8XmUtpX26zhPD+wJmpyop05wYKgZUbVJQnkC7J40CBL9e3YtOl+GzPAwWXJT+OyhBAf9NaQARUaScAvZIReHGyjY8Sjrvjo+WWoboBQ6JRf9QwcXzY/t3UGT/8A1As5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xBCNcW2WzPcFBhr8fpAT6bi8jfXH9rZ3ePkWdO3lWY=;
 b=Fm8r61vaOewcIH4P02VCnK7BW6oxVwQJul2WerQyeF9FuWqlO9jzOOgLAeHA2IkhQTIK+mK0yhlgd4dUZWtOvaQnoAIxRKRzDlm9W43vP4VRXW+haLyYggai7ibCwbKPyR22MqIly1iTzITaYOHIRaB9Tae87JV/pj5mIXkzty4=
Received: from BN0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:e7::24)
 by CY4PR12MB1350.namprd12.prod.outlook.com (2603:10b6:903:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 20 Jul
 2022 08:26:48 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::96) by BN0PR03CA0049.outlook.office365.com
 (2603:10b6:408:e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Wed, 20 Jul 2022 08:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 08:26:47 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 03:26:42 -0500
Message-ID: <f45fccec-4496-19af-0e14-bd626e14c7bd@amd.com>
Date:   Wed, 20 Jul 2022 10:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Appana Durga Kedareswara rao" <appana.durga.kedareswara.rao@amd.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <appanad@amd.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-4-appana.durga.kedareswara.rao@amd.com>
 <77e8433f-6cb8-eb32-63d5-414a92d3b874@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <77e8433f-6cb8-eb32-63d5-414a92d3b874@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee66ade0-5782-475f-2022-08da6a2996aa
X-MS-TrafficTypeDiagnostic: CY4PR12MB1350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyxqfYnI/9TOaA2cMdqsR7dcRBW/GNaAjV2XuVRBqBrD112BIkLYltmwGA0b4aYkxi85LDeTGBXieeUP3nerHyEsahEzpRiG6I3hYCOzz34lCpse7lkTvpAOXqZ+LaloWv5uo16XFeD08DXjnFPDsVcEBrgxW6ETo52YUpiyv7VB+B/g3HzgcA9X47hDDSDYzCPfkICBrK3WnxgEhrRIMTR+qg5uQti1S+1lBsF+kdoAZW2q2pOotT54gpgaDY8/8uSv6eDMBaU4PUVpjgBQhr2SuIfCZR+AyRw2Uf9l6IrX3/4xSwtw/IxuqSrxqjF5c4VH+at0SEXq1OPOf6iFFepMtlLtxBIGjA7io3dtLcjEsVmOZqKIcWck4MHL5MG6AVY/U1lNsIznpfNDsYaRScEhGHhARppTHVqmJW7rvfSon2QGbmUdNXlW3N7yKzGX/FX2GKNdXaJQNvWFfJIrFSoqHHcd4ILGwQ31tcFWiAUVCYDNZ4bjbGjm2fQX2KbuQTayKRH58BDjL2n3EQFBEK2NBvVTPlW3r/PM4wIqTuWxFrZQRxyk9PuJ0fLR9GIiNCvMRmkvmck1AUivwMiK1cSm9eZUh8+3aSbDPR9WAyD05iW4cFbi4cNrJGVRSwMSmHgxwwiskZ0K21GwUBA5tzWPKSZqxdY63sTxB/sJ+0T3BV3C66lmESLQtCX633a2b2CKS1SWNjLLGOCtLITp6cJfJQujS87mPD2SdGsapjqcX49TuiLHLYDp1DSuBz6UChMeZnIrdLDLoFtFr730C0Fkt/JmsOI8qlscCEzsz+gl46J3LbOH1fX8xNva1xwr1a4Efy+5aRcDvaYAdl4l6nyWqiUOE/CJQ6MgMdAGm/yXsHJlU0Qh/EZOGj8DWT0Z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(40470700004)(46966006)(36840700001)(4326008)(110136005)(53546011)(2616005)(26005)(478600001)(41300700001)(2906002)(54906003)(40480700001)(82310400005)(8676002)(316002)(5660300002)(44832011)(16576012)(82740400003)(36860700001)(83380400001)(356005)(36756003)(86362001)(31686004)(8936002)(81166007)(47076005)(107886003)(426003)(16526019)(40460700003)(186003)(336012)(70206006)(31696002)(70586007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 08:26:47.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee66ade0-5782-475f-2022-08da6a2996aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 08:15, Krzysztof Kozlowski wrote:
> On 20/07/2022 08:00, Appana Durga Kedareswara rao wrote:
>> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>
>> The Triple Modular Redundancy(TMR) Inject core provides functional fault
>> injection by changing selected MicroBlaze instructions, which provides the
>> possibility to verify that the TMR subsystem error detection and fault
>> recovery logic is working properly.
>>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> 
> Keep only one SoB.

nit: First of all it is from xilinx.com that's why xilinx.com should be the first.

Just for my understanding about guidance here.
Code was developed by Xilinx before acquisition with AMD. And because it was 
picked from vendor tree origin xilinx.com was there to keep origin author there. 
And upstreaming is done by new company. I can't see nothing wrong on keeping 
both emails there but that's why my opinion. Definitely not a problem to remove 
one of them but wanted to make sure that we do it properly for all our submissions.

Thanks,
Michal
