Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2872652384C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbiEKQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbiEKQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:14:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C492F6D189;
        Wed, 11 May 2022 09:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAwRKWk49OmpOVnwkvCXA6VQZ2gYNnH/uzfUfb5/KivE0YAxb6QjppnIvQtGzcDxF5pLWjTLI2nitGFlc78KaGyVtMOc6We5UwYe3bSUu4NIwn9DnktdhFP/Ha3uet4V8H7iCG9IzO4reJv0NmNyE/Lt/x6KD7azKhOTb+5OAcz1pwsV5J/0K2WXuKOg8u6LgdqlD/UC6PxsIXZ+jEzn3HaH9ZNmC7a4GdlPpwXMALweCy7WHK7xcBA+fabYEyl8WjGoj2GN2qEFtodE2SpNjUrqHQsRtC9WshGVu6gEsZSoksXjuHvWXPXBnOBFBqsu4tJBAO8YeKx5ZygOvFBWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFZukxCIAW4qMAGTgTmIXWuebvTnMPz96C5cqBwccXQ=;
 b=nIoWaIlrw0x+38vR0WdUbSYw8fsBb8PqiVFUlbRCSn4J5YvJ3alxV/RtPmvOjUANSEhdGYdmqo9S1Phx90uIQ23++IfxgxAn7DIcoLwLSUNceVRSCAKcdj69GHz3y2JQ8xhKVIMlMvlZ2VSiRm6zZNShHcizBznGi5y7uvIzquF5hMeB/SD9EjSOzAsTjNXLGqUtDAZzugj8p6cGeRpR1prMPx5MeEEFlKgSY5xU3jgckdCvJeId6KbSAh8A0fyBNtLcKs5Xt5S2Azv0xpjVxHGD51J+jdyD+ARIzDomri+ZfLnjLfjxyF4ibzWMFW2P2Mf1uBp5oC5IRsOMVxdwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFZukxCIAW4qMAGTgTmIXWuebvTnMPz96C5cqBwccXQ=;
 b=mJnG9LJvmNc9yD5kWfrAcN5UWeHxeNAunueq4HLuNk1Z9WVbAiZrm1IrG2VAseSH9cH4502NLGmmWVQ6Hv3szG2q5k98gtcbSxDISSjMgTX0f0QeTIVTeyaUKDBA+9yebx9/3vEft1VAjPcmqO/Xk7x7NRtIUy8r5EP9/HgGMEL1jnPq/aBYMC8iDY2MvcixLqr9vLIf1MCFqjrxHS9b4OcURGkp+ayOcGZSs83SeTx2vUqKiCKAxZaHJT7u1SOSMzkUbNiAxEv2HPoGThKAwhUPuuft8wfWZw8s1t38RNFexIfkqH43pzCHu6D9wykFfEwraGlzOPMMH6bO0SYsVA==
Received: from BN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:ee::35)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 16:14:51 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::a1) by BN0PR04CA0030.outlook.office365.com
 (2603:10b6:408:ee::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 16:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 16:14:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 16:14:38 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 09:14:35 -0700
Message-ID: <1079d4df-153d-62f1-1e6c-0af86345b83a@nvidia.com>
Date:   Wed, 11 May 2022 21:44:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v5 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234
 CBB2.0 binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kbuild-all@lists.01.org>,
        <bbasu@nvidia.com>, <vsethi@nvidia.com>, <jsequeira@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20220506111217.8833-1-sumitg@nvidia.com>
 <20220506111217.8833-7-sumitg@nvidia.com>
 <20220511144958.GA286838-robh@kernel.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20220511144958.GA286838-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10871679-41ff-4ec6-3520-08da3369604e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5344:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53449E253E2390CD22B8D557B9C89@DM4PR12MB5344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3tM9uyvBN1lec9MenTXA6aOhtsigrbPt9gHWzz1bWKvdusm5LPOeHb4VmUkxQ5qhuR+6xnmr/ErJAcUOTh8p9JkMgMyVwQO5I0nuaejwjNwURMUTzbUcDi+sbhfa0SN8W6wFXG7IBeGVJncJq6nO+Wb05m+L8Oibz0H+SSs+zXn4jGYNqSPGrBrwyTAeFad5m8YB6rSPvfdOotoYsxOMRP6G/WieZXuQLkR4gjC2nczRDyDPIj+9uYvJTi+KiOh2b9saViFbEvxFEBDKI82bbbqDNvg9PdqO+9SohlBTxZuN6TKtEhGdYtd0lbRYvJBEfXO8YbAdK6DF99U6vJnkgHdeZkEYpqmUVRc/ugIOP+GQFUG51zE0sqOA9oK9fJtmlHAESS4Pz2FUDPN0QT+VmyNSxP5HGBKrKbWrA+j/6wGzbcv5Wjqlt/xugvasUs7zEYCPZ3sPHCDT0YL5FZHyWlVOuKv2Ov4jJi1Qase1fCgBPDMU1h1ZPyQ2nCk3/ajoe6GkzHmm/CmRBnJxx5cjigGQBTQ8CgECgiGq2W7nuh1Bd/0pjA7t+4faMEy5Ekzo7QsB8P9hqyxNYGbZ9yCSMD7tgTmHVfIHYyNfA6vMPggp31Ld9lK1Lu+GCSh9cSQSZ9kkdArGFbp8ZvZOzKsa9l2bX80w7PKkWahuRPqM1TlLFqSlIg7nDwDmGQsjJPmW2ccry2lj+3orLcGfc1j4ZVgDhtuk2CuBFM0fOQBRTkCxRqAHMAn+iIrTFNrhmKbrehcYiwq7Chm/irez9C4ty/RHSG6iX9l4+V85vRZA2qlul5RV2hNqwpbmOFB50FdpGGi1QuFZGWih+kHf0S1+Xhga5yhzrdzyOJB7V9w4iAUZbiDDg9gLgnFUgfy33k7
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(8936002)(5660300002)(86362001)(186003)(36860700001)(16526019)(316002)(26005)(81166007)(53546011)(356005)(16576012)(107886003)(31696002)(54906003)(2616005)(6916009)(70586007)(36756003)(70206006)(40460700003)(2906002)(8676002)(82310400005)(4326008)(83380400001)(336012)(31686004)(426003)(47076005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 16:14:50.4636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10871679-41ff-4ec6-3520-08da3369604e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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



On 11/05/22 20:19, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, May 06, 2022 at 04:42:14PM +0530, Sumit Gupta wrote:
>> Add device-tree binding documentation to represent CBB2.0 (Control
>> Backbone) error handling driver. The driver prints debug information
>> about failed transaction on receiving interrupt from CBB2.0.
> 
> Same issues in this one that I won't repeat...
Will send v6 with the changes.

> 
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../arm/tegra/nvidia,tegra234-cbb.yaml        | 70 +++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>> new file mode 100644
>> index 000000000000..fa4383be19d8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: NVIDIA Tegra CBB 2.0 Error handling driver device tree bindings
>> +
>> +maintainers:
>> +  - Sumit Gupta <sumitg@nvidia.com>
>> +
>> +description: |+
>> +  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
>> +  register configuration space. CBB 2.0 consists of multiple sub-blocks connected to each other
>> +  to create a topology. The Tegra234 SoC has different fabrics based on CBB2.0 architecture which
>> +  include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI and "CBB central fabric".
>> +
>> +  In CBB 2.0, each initiator which can issue transactions connects to a Root Master Node (MN)
>> +  before it connects to any other element of the fabric. Each Root MN contains a Error Monitor
>> +  (EM) which detects and logs error. Interrupts from various EM blocks are collated by Error
>> +  Notifier (EN) which is per fabric and presents a single interrupt from fabric to the SoC
>> +  interrupt controller.
>> +
>> +  The driver handles errors from CBB due to illegal register accesses and prints debug information
>> +  about failed transaction on receiving the interrupt from EN. Debug information includes Error
>> +  Code, Error Description, MasterID, Fabric, SlaveID, Address, Cache, Protection, Security Group
>> +  etc on receiving error notification.
>> +
>> +  If the Error Response Disable (ERD) is set/enabled for an initiator, then SError or Data abort
>> +  exception error response is masked and an interrupt is used for reporting errors due to illegal
>> +  accesses from that initiator. The value returned on read failures is '0xFFFFFFFF' for
>> +  compatibility with PCIE.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^[a-z]+-fabric@[0-9a-f]+$"
>> +
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra234-aon-fabric
>> +      - nvidia,tegra234-bpmp-fabric
>> +      - nvidia,tegra234-cbb-fabric
>> +      - nvidia,tegra234-dce-fabric
>> +      - nvidia,tegra234-rce-fabric
>> +      - nvidia,tegra234-sce-fabric
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: secure interrupt from error notifier
>> +
>> +additionalProperties: true
> 
> True is only allowed for common bindings included in other bindings.
Ok, will mark as false.

> 
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    cbb-fabric@1300000 {
>> +      compatible = "nvidia,tegra234-cbb-fabric";
>> +      reg = <0x13a00000 0x400000>;
>> +      interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
>> +      status = "okay";
>> +    };
>> --
>> 2.17.1
>>
>>
