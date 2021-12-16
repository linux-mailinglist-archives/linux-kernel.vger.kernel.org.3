Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3DA477BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbhLPSfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:35:38 -0500
Received: from mail-bn1nam07on2067.outbound.protection.outlook.com ([40.107.212.67]:17345
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236224AbhLPSfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:35:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/DcRUrxf51VEIDNMOOs3q+/cX02h/VcKrdqIT9IS6iW503/YsJ9omd28Y5F5O47mLxH4p+SDZI8LsQ4RpBqdPk6qdmDs4X5oussACKsaSlrfNGibfzvFiwvL/PNb001VnxcePWmNKe8JoN0ENuwQCzrL5Vw7He4yxL/a+c5Nx8D4VebS6IohLmjSUROgo8sEWsjxskvzAPX0eApTHVri79sYCiMhi8egZQLtAeWEVJBOI3SRpFLn/xgjlmVuQTdw4rlLX9uUJhmWLkptoonebUetolJvqCYoNayXQcZ2WLkyCvyYZY6bu+BCbaYyPj6FFosu8IHxrmaDgtU4mRh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ioh+ZGeDvml7dfF639VSHaGfYMPPY73XGsHdDAf8tU=;
 b=kaX3fRxBdOHcdb49bm1l7HWZSLQZ2BMIuHFNFzmyQJI6av/vsv0fH9soWztBtI3iDLS7zER6H0z331OsoCSThpMN15DkoBm7mHYGJ+XVBAkB0CS3TOw7gAonc3yfDBLGif6HnVF73D1o1QPmPynXkPHTErkHt+VICBfMKSKbupQrntfE7ZZn+dOQ6wlTDPFY1XVvo32CFRnMdg5MsTZ+/i00SRpI5zYQOqW2YwmaPh28i8Ks5Mapt9uhj/n4UtUNHU56ntj15wkURZopllF2l0cI7MfOyi4SKdvUfTdL7raR6rcje6kJStjT0dv3pcSmMgH+MXdIScG9AvWRF1N4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ioh+ZGeDvml7dfF639VSHaGfYMPPY73XGsHdDAf8tU=;
 b=sirZIp0aFcVuZt+rRw1n5mp3KWB+pa+bTC1EF4NV6uC+Bhw0pQ1tE7iurfgxCN4DoEDV4Y4aN58/gxpi+nrzZdvJF/CJfuUzmVeXiOyaK8sfbjPcQmf4T83HIQbXce2Mbgj2YI5b2IhLf4ZPrtSqvH4nUWMglLUBXtZJ/ridfJrkNzKwRXMOYeoyGGRM17IA4uIAOuAeR7jHarbFjz1Erfj/ih201jKop2CchzEusZygvLne99ub2evJCsIw8xmS8VYxxdMWNzxFEqZTeau//2sGEds9kKb47rmr4SGaeJNvqSuqI+bIgfrXrPkouDMTjUzgWTTLdECSghPDR+comg==
Received: from DM3PR11CA0003.namprd11.prod.outlook.com (2603:10b6:0:54::13) by
 BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 18:35:34 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::83) by DM3PR11CA0003.outlook.office365.com
 (2603:10b6:0:54::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Thu, 16 Dec 2021 18:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 18:35:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 18:35:06 +0000
Received: from [10.41.21.79] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 16 Dec 2021
 10:35:03 -0800
Subject: Re: [Patch Resend v1 5/8] dt-bindings: arm: tegra: Add NVIDIA
 Tegra234 CBB2.0 binding
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
 <20211209172206.17778-6-sumitg@nvidia.com> <YbsjZDc8tt3fMUQt@orome>
 <321bfcdf-2aa3-0d0a-2096-972b5cf0297a@nvidia.com> <YbtrkcMMwjipgkZf@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <daedf282-2c58-c78c-c527-d237c5f83853@nvidia.com>
Date:   Fri, 17 Dec 2021 00:05:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbtrkcMMwjipgkZf@orome>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a5a6c1c-2fe9-4551-5a7a-08d9c0c2d844
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2980638386104F48A8E9B69DB9779@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?Windows-1252?Q?9/586tBK8GQzwtnjIS4Ib/OnhfwDu3n72P6zOuaN8MkDcsFs0qDJvVL0?=
 =?Windows-1252?Q?gTiM8j0blVA89whNj188bkP4CjbjQu2Mx0JPOlpz8rhCRJXiplnh76gT?=
 =?Windows-1252?Q?9fNkiZf1cUW7ECPKwN/Uro8chYYNn7CTaJ4XslNnLGmRdK2g13f3AATE?=
 =?Windows-1252?Q?yWUsmRy146b36GU1itkPVIfRRmJHPLHB4OB9laP661OwbJny3XQURV+T?=
 =?Windows-1252?Q?za44YDB5TZYMfSDMkqtorpTw1aqfq7mdB4VSDybZwegEJks46fJuI3iX?=
 =?Windows-1252?Q?zA8uBM9gBo37RW/jPQFfUoz0Sjdwy5wF+RJs3mQPxGn97IDswqW4iXNU?=
 =?Windows-1252?Q?6PVQV1wH0Zm60pzRt/VbNue3iANrn6SaHSQg/1Hyu6tPG/5j1dEqKfYr?=
 =?Windows-1252?Q?wfdkt9I8uo9G9ZCy8ocv9a6l8mF8ShNJ8DOjkGLPfpgyrPBWSp1YGqni?=
 =?Windows-1252?Q?mZXfyM6x8xN6IGaiSLj9l/uomud6nP+lvtxnPG9Tq6grVQXnz9uZSiDL?=
 =?Windows-1252?Q?fNYeuHfQck+xAPCmUmgaCRm4fOK1Huam4CeFK74n80kl2j2Vdt5xsm/W?=
 =?Windows-1252?Q?9lXi8xWSpepll4drUH0klRAFqQ7q2PwdVDf727SX6ODvCTCNmp60v2YN?=
 =?Windows-1252?Q?AJNmtqiDxtB8hOn/7FESCBqjmbV6p9iKmsI6iYCisBEF2VeRQPsYAx5J?=
 =?Windows-1252?Q?tLdPO/JQiClfQG/VZ/BH8SorFe/jDa1Q70ZFcAx4GP/chdQvwiGg0niJ?=
 =?Windows-1252?Q?wzdz1eX82ZRfHz8vtGTgC+RHGLcAEPXeCDD42VLhoAd1afGJ10Vn+kun?=
 =?Windows-1252?Q?E9UB5z6hSfLK6/Ekz6OYP7wWukDsgEuw7yzTr22w5aOx0PXS1k5+WwSZ?=
 =?Windows-1252?Q?hwqjuc+TmB/DwoyvQWL3Fu+W2oZiE0fcsSaNjFgPHIKI4GcHqLNsSi4U?=
 =?Windows-1252?Q?8ybf3dKuATTrWStKRYUo+nrEN6tRFvGuBIkAYOiL4/wJRA92el1hvTR8?=
 =?Windows-1252?Q?qPc/uK/Fit2cEw0gcpRWDSRzr2u6syrSvsI9zHFChYqXq1cTRaA=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(426003)(336012)(81166007)(36756003)(5660300002)(16576012)(2906002)(70206006)(31696002)(31686004)(8936002)(2616005)(356005)(47076005)(107886003)(83380400001)(40460700001)(16526019)(70586007)(26005)(508600001)(86362001)(82310400004)(36860700001)(34020700004)(4326008)(6916009)(54906003)(186003)(316002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 18:35:33.2855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5a6c1c-2fe9-4551-5a7a-08d9c0c2d844
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> On Thu, Dec 09, 2021 at 10:52:03PM +0530, Sumit Gupta wrote:
>>>> Add device-tree binding documentation to represent CBB2.0 (Control
>>>> Backbone) error handling driver. The driver prints debug information
>>>> about failed transaction on receiving interrupt from CBB2.0.
>>>>
>>>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>>>> ---
>>>>    .../arm/tegra/nvidia,tegra234-cbb.yaml        | 80 +++++++++++++++++++
>>>>    1 file changed, 80 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>>>> new file mode 100644
>>>> index 000000000000..ad8177255e6c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>>>> @@ -0,0 +1,80 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +
>>>> +$id:"http://devicetree.org/schemas/arm/tegra/tegra23_cbb.yaml#"
>>>> +$schema:"http://devicetree.org/meta-schemas/core.yaml#"
>>>> +
>>>> +title: NVIDIA Tegra CBB2.0 Error handling driver device tree bindings
>>>> +
>>>> +maintainers:
>>>> +  - Sumit Gupta<sumitg@nvidia.com>
>>>> +
>>>> +description: |+
>>>> +  Control Backbone (CBB) comprises of the physical path from an
>>>> +  initiator to a target's register configuration space.
>>>> +  CBB2.0 consists of multiple sub-blocks connected to each other
>>>> +  to create a topology.
>>>> +  Tegra234 SOC has different fabrics based on CBB2.0 architecture
>>>> +  which include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI
>>>> +  and "CBB central fabric".
>>>> +
>>>> +  In CBB2.0, each initiator which can issue transactions connects to
>>>> +  a Root Master Node (MN) before it connects to any other element of
>>>> +  the fabric. Each Root MN contains a Error Monitor (EM) which detects
>>>> +  and logs error. Interrupts from various EM blocks are collated by
>>>> +  Error Notifier (EN) which is per fabric and presents a single
>>>> +  interrupt from fabric to the SOC interrupt controller.
>>>> +
>>>> +  The driver handles errors from CBB due to illegal register accesses
>>>> +  and prints debug information about failed transaction on receiving
>>>> +  the interrupt from EN. Debug information includes Error Code, Error
>>>> +  Description, MasterID, Fabric, SlaveID, Address, Cache, Protection,
>>>> +  Security Group etc on receiving error notification.
>>>> +
>>>> +  If the Error Response Disable (ERD) is set/enabled for an initiator,
>>>> +  then SError or Data abort exception error response is masked and an
>>>> +  interrupt is used for reporting errors due to illegal accesses from
>>>> +  that initiator. The value returned on read failures is '0xFFFFFFFF'
>>>> +  for compatibility with PCIE.
>>>> +
>>>> +properties:
>>>> +  $nodename:
>>>> +    pattern: "^[a-f]+-en@[0-9a-f]+$"
>>>> +
>>>> +  compatible:
>>>> +    enum:
>>>> +      - nvidia,tegra234-aon-fabric
>>>> +      - nvidia,tegra234-bpmp-fabric
>>>> +      - nvidia,tegra234-cbb-fabric
>>>> +      - nvidia,tegra234-dce-fabric
>>>> +      - nvidia,tegra234-rce-fabric
>>>> +      - nvidia,tegra234-sce-fabric
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +    items:
>>>> +      - description: secure interrupt from error notifier.
>>>> +
>>>> +  nvidia,err-notifier-base:
>>>> +    description: address of error notifier inside a fabric.
>>>> +
>>>> +  nvidia,off-mask-erd:
>>>> +    description: offset of register having ERD bit.
>>> I was wondering about these two properties. Do we really need them? I
>>> see that they are set on a per-SoC basic and they only differ between
>>> the various fabrics. If they don't need to be configured on a per-board
>>> basis, then I don't think we need to specify these explicitly. Instead I
>>> think we could derive them from the compatible string
>> The CBB 2.0 based fabric's error handling driver remains same across
>> different SOC's and their variants. Only these fields change.
>> e.g: "off-mask-erd" value is different for T23x SOC variants.
>> "err-notifier-base" also changed multiple times during simulator stage.
>> So, keeping them in DT to avoid changing the driver code for different
>> variants of an SOC and to change them during bring up stages with DT change
>> only.
> For different SoC variants I would expect this to be implied by a new
> compatible string. A hypothetical Tegra235 SoC that is largely the same
> as Tegra234 but required slight changes in these values would also get a
> different set of compatible strings. So the fabrics in that case would
> be called:
> 
> 	- nvidia,tegra235-aon-fabric
> 	- nvidia,tegra235-bpmp-fabric
> 	- nvidia,tegra235-cbb-fabric
> 	...
> 
> and then that new value can be derived from that new compatible string.
> In general we only want to provide data in device tree if it can't be
> implied from the compatible string. Most of the time that's only for
> things that are somehow dependent on the board design. Data that is
> fixed for a given SoC can be derived from the compatible string.
> 
Ok. Will move them from DT to driver and send v2 tomorrow.

> Thierry
> 
