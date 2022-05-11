Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C79523845
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbiEKQNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiEKQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:13:50 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2B34642;
        Wed, 11 May 2022 09:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CW++bgqOrjFiLoxxoVAab7wXVkecML00T4z63zdJmPR+AROSxDutI4/5CvTfoWyeG76HE12noXzmX8FN77klbUdcEvQo4enZkqIhYu85elZRqPkfSh3Tp6RT7ox357/SzXCs2TV6n8D7a9DEqERrUd2YeNqDf4rcaL3pwYB2p9CFXWCBEpK5A4DIRb1oi4aiukkVLE4UNZbpi1FjtDBI9yhw8UWgu5jWbWqhmMi3t3aR4hwi356+N2f2gLTtuylxG7FX4mJITqxpQAKdM0Wyn8PJU6SLDkh+789DWyYSiJlhAo9ivB39P59JK/SWoYaI6PC7gW3snESY1LoyWad4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHy19aq5Ob81XRYHFw9h4B9QkvD+EaFB2m+OVBynI0c=;
 b=E0YdaGpQ+XXvKiVlzXcOEG1GSev7WB1ccEWrQG1BaesVTORXgitLeGa6nR2pm9AXVKBZgD/5hP8eJC5zT+B4PZvYxbEYiA1qeSPPeCYRMBDEZGFx4/XeJtPSHTNwYiZUSwqxH04P7lH0vOXuuL+Xb5mcujV0GVu3qIhH/K4bi+CTppZtSn55IguLpWndX4dZICpQ1+UUXyQVGmRbKfbdewuqfQ73QnG8KiSYw62etBOQKneffzh+g/v+DsnHBy/gjb0ZBuY9nn49utwQWPDoIrr30zL2Ev+YZFhCUvL97H9OacnEvPqLqgKsbXQn6NrrCUzRqn/KdPsFZ3UMgkduRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHy19aq5Ob81XRYHFw9h4B9QkvD+EaFB2m+OVBynI0c=;
 b=LXr3Rffxx9RmOhJZjcGUel5ODEc5IxfkRHLVPx/qSXtv7YpZR/bvXv+s9ywj7arXewVTaV28E8ZKzzYia5GMOEDeP6m0kb5tScdZ1TVSzEu1QR1FLDJExx8OXMyYVN0TSPvzGk9wD/bQfoqUxvXzkzXQBuDcLekv5vv03rHS0w1rU3K9YWhUeBVfaH23R6/XirzLI8aoMXFYHxJ2XqG/J2ojb74oyNwWUdO/VEeubwT7RQnP7ht2ck2Z2IlYEXDmkHy/drcolFPvRkna0Nv6YjzdHZumsXyU6OmwLBu8BxGvOYVimCkA4iQhBrFf7wt895IDJH7cT9jyF+92QdEdBw==
Received: from BN9PR03CA0188.namprd03.prod.outlook.com (2603:10b6:408:f9::13)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 16:13:11 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::7c) by BN9PR03CA0188.outlook.office365.com
 (2603:10b6:408:f9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 16:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 16:13:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 16:12:51 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 09:12:47 -0700
Message-ID: <6d7c27ce-63d0-afac-ae57-5e339586b44f@nvidia.com>
Date:   Wed, 11 May 2022 21:42:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v5 2/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 CBB1.0 binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kbuild-all@lists.01.org>,
        <bbasu@nvidia.com>, <vsethi@nvidia.com>, <jsequeira@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20220506111217.8833-1-sumitg@nvidia.com>
 <20220506111217.8833-3-sumitg@nvidia.com>
 <20220511144631.GA272915-robh@kernel.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20220511144631.GA272915-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b737560f-8e6e-457b-0431-08da336924ba
X-MS-TrafficTypeDiagnostic: DM4PR12MB6109:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6109544EC68CDC54B658A86AB9C89@DM4PR12MB6109.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yw/OBjtm4wiZmyNNIcS/jC8ZOUgTseg5QOVYedetoUWndLiBeQCkO4WcvYT7ucuScLnbk4wCwI4d3EW0wWjn3xs4CYtZXhxhXKEfn1lgd0g+rEGe5620pZJ3EJ9Rj2C787lPk+Ioc9Q99EWq8s7rLFlP8n7taMjxGqGrBrOl1Q0mF0/rSztrnQf7wJIxsy7qG59i8oREbqS0M+t67F1JlQ0EnGF4XGevOzAZJ5bLjKY5O+1iUGX4i2sz12eAtscIA8NA+qV+Kbwwv0qH7WipyxEhgldOLzpw3yDWh2D60DFYshhUy0un1lQz0JLaWr14XyQ4oKcMTYfPo/GujWgtCCw5SAbFjPEnhCTILrsYzu9lnQBcaEGG4WpKnqpwKn/5a7acmXC8edB6GyegVEORvdFpZr+k4n4/hLdr0ja34uX02z4/b7x6FTRYic/Tzr0K1VrWzCRyACbPioM8pv1saxBokdbY6pGIU8kikzs6x90SkWhywaN4jliJ+IHcmdtd8713wA6arroHvBcWhzFeezUyI+uw54wuAiat77jVzjN58ZgRm8f7DRBrMzBwffadgGdy7n0QqOqgX/f1zPnkt40zYgaOTTOcZFg+cnb2jaVMJJpDa2y+a9QaMkjFGKMTilcSqY2d4SJ37FzsUlxej9cXKLMPSiIlTVauii5pryz4IK246dmq2zF2dS/uNxShRZZQyjwNM1v0LWFMxlspE+VY3EgheppuI95Wp29dMqJJoestE9KIbfv25p8wONTxKkEVVa/MV7UxIwFzLp5Ym5oqFB/RiBES4ndO1bfDzyqDvyVjIJkU8MVJCX+pnnG6oALwOXS7XdnWplCmUG6iMTK7G+88V16PIyd1v7S9aklYgl1JxCXvD3feNo54I4Mc
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(36756003)(186003)(107886003)(31686004)(16526019)(356005)(47076005)(426003)(336012)(81166007)(53546011)(83380400001)(8676002)(70206006)(70586007)(4326008)(82310400005)(26005)(31696002)(40460700003)(36860700001)(5660300002)(86362001)(316002)(54906003)(2906002)(8936002)(508600001)(6916009)(16576012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 16:13:10.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b737560f-8e6e-457b-0431-08da336924ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/22 20:16, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, May 06, 2022 at 04:42:10PM +0530, Sumit Gupta wrote:
>> Add device-tree binding documentation to represent the error handling
>> driver for Control Backbone (CBB) version 1.0 used in Tegra194 SOC.
> 
> Bindings are for h/w not drivers.
OK, will change to below ? and send v6.
"Add device-tree binding documentation to represent the Control Backbone 
(CBB) version 1.0 used in Tegra194 SOC."

> 
>> The driver prints debug information about failed transactions due to
>> illegal register accesses on receiving interrupt from CBB.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../arm/tegra/nvidia,tegra194-cbb.yaml        | 93 +++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
>> new file mode 100644
>> index 000000000000..3167f0450298
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
>> @@ -0,0 +1,93 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-cbb.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: NVIDIA Tegra194 CBB 1.0 device tree bindings
> 
> 'device tree bindings' is redundantOK, will change to below ? and send v6.
"title: NVIDIA Tegra194 CBB 1.0 bindings"

> 
>> +
>> +maintainers:
>> +  - Sumit Gupta <sumitg@nvidia.com>
>> +
>> +description: |+
>> +  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
>> +  register configuration space. CBB 1.0 has multiple hierarchical sub-NOCs (Network-on-Chip) and
>> +  connects various initiators and targets using different bridges like AXIP2P, AXI2APB.
>> +
>> +  This driver handles errors due to illegal register accesses reported by the NOCs inside the CBB.
>> +  NOCs reporting errors are cluster NOCs "AON-NOC, SCE-NOC, RCE-NOC, BPMP-NOC, CV-NOC" and "CBB
>> +  Central NOC" which is the main NOC.
>> +
>> +  By default, the access issuing initiator is informed about the error using SError or Data Abort
>> +  exception unless the ERD (Error Response Disable) is enabled/set for that initiator. If the ERD
>> +  is enabled, then SError or Data Abort is masked and the error is reported with interrupt.
>> +
>> +  - For CCPLEX (CPU Complex) initiator, the driver sets ERD bit. So, the errors due to illegal
>> +    accesses from CCPLEX are reported by interrupts. If ERD is not set, then error is reported by
>> +    SError.
>> +  - For other initiators, the ERD is disabled. So, the access issuing initiator is informed about
>> +    the illegal access by Data Abort exception. In addition, an interrupt is also generated to
>> +    CCPLEX. These initiators include all engines using Cortex-R5 (which is ARMv7 CPU cluster) and
>> +    engines like TSEC (Security co-processor), NVDEC (NVIDIA Video Decoder engine) etc which can
>> +    initiate transactions.
>> +
>> +  The driver prints relevant debug information like Error Code, Error Description, Master, Address,
>> +  AXI ID, Cache, Protection, Security Group etc on receiving error notification.
> 
> Please wrap at 80. Longer is allowed, but should still be the exception.
Will do in v6.

> 
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^[a-z]+-noc@[0-9a-f]+$"
>> +
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-cbb-noc
>> +      - nvidia,tegra194-aon-noc
>> +      - nvidia,tegra194-bpmp-noc
>> +      - nvidia,tegra194-rce-noc
>> +      - nvidia,tegra194-sce-noc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description:
>> +      CCPLEX receives secure or nonsecure interrupt depending on error type. A secure interrupt is
>> +      received for SEC(firewall) & SLV errors and a non-secure interrupt is received for TMO & DEC
>> +      errors.
>> +    items:
>> +      - description: non-secure interrupt
>> +      - description: secure interrupt
>> +
>> +  nvidia,axi2apb:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description:
>> +      Specifies the node having all axi2apb bridges which need to be checked for any error logged
>> +      in their status register.
>> +
>> +  nvidia,apbmisc:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description:
>> +      Specifies the apbmisc node which need to be used for reading ERD register.
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - nvidia,axi2apb
>> +  - nvidia,apbmisc
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    cbb-noc@2300000 {
>> +        compatible = "nvidia,tegra194-cbb-noc";
>> +        reg = <0x02300000 0x1000>;
>> +        interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
>> +        nvidia,axi2apb = <&axi2apb>;
>> +        nvidia,apbmisc = <&apbmisc>;
>> +        status = "okay";
> 
> Don't need status in examples.
Ok, will remove in v6.

> 
> 
>> +    };
>> --
>> 2.17.1
>>
>>
