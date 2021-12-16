Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D123C477554
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhLPPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:06:21 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:12192
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238266AbhLPPGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:06:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjKSlmZ4DJ4CNUmQp2CCoscNt5l6zcqnosYcrCvKPT/zTYajrWdHvOKQT/ZtPlKn+rKAtxfkpO9PuvAwQqLo4FNXXpajsR+S5xsw+bn3oyWcVKd+xAXN35MDz6dTOmqM143qVzpJSEeIkHqH+lQ7JRuHwY0knZsFCpcRpdzGAMhO5L3EDcSzhuV8En+Ao8ONjqQdYx9ANEIdeaXC2eVa+TUzky/rrpsp+ShklVQszJR7d8wvW6Y4qaz3a1otcGIV2HGD3WOFbwaGA5Otvu6M/jJVs9ObWPPmT3KG5NZI5btVBwxJcFkalGP/XZo4AmiYMXqICT32Q+3cAEdrjBxBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFSpQwwBV2wjr5W0W7J5VLdbsYUUIoXVVrPKTiAQSUU=;
 b=MbWWYd+nKyA4Nh35iTqrvNdoakoVjYNfvmHsUeqpafXng2VMKVK6Uo1K59ajkPYf/WdQHulhmrGcxRUs9mZJsfCEndFQR/WINypPwA4wZ71AEX7+g/S9uPO4JAIwSYLgCsGKoE/AegP13UNYjdIjB2v0qaGfMtG/buo0g2c3DnvuxGEIaIPn/9tpTwOeBuBJF76QWuzYMGp7tgzfWIJjThOt3AzhYznjz9Zhf3tX+uLa5Pg8wNSkaylqO5vbbegw7w3tUcf9duxqGyANh3UPxSWzBjx0op5KGkkJtNG1IX2gTuu8PIM6j8/dsrxf4elHelvS1xDSheQC6pPv3HoGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFSpQwwBV2wjr5W0W7J5VLdbsYUUIoXVVrPKTiAQSUU=;
 b=lGjX7D8/A5c6UdJbhmArXaU6AfYspaJvCW5fy8o+2QhmzWyOA2wjx6HCDuz+aNZGHvlwsCCf60hBA3EdUF+XUznBCOKf3pCxSEUnPIRgmCXkHJ0gv6Rxp8b4pXrQi9UgJvEtW0ap04BtMU/y5zA/A3nQ9cJV30NcgO+RHogTMIggzstUlKU9mMjWqeFQFt2/H/gt2Y3UFXy20uQ+IgZ0UtGQbvs6mYmhp1FXNMJAFiFd1RRidbcTXVsjaMNFCsoLhK7oZbFXztZzha72vPowu2p02TptJrLp08gJNkWV8m5S2XmXICJm6TrS4Mz1nDO/H15lALlcr74x3LcKd5e+0g==
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 15:06:17 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::af) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 15:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 15:06:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 15:06:16 +0000
Received: from [10.41.21.79] (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 16 Dec 2021
 07:06:13 -0800
Subject: Re: [Patch Resend v1 5/8] dt-bindings: arm: tegra: Add NVIDIA
 Tegra234 CBB2.0 binding
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
 <20211209172206.17778-6-sumitg@nvidia.com> <YbsjZDc8tt3fMUQt@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <321bfcdf-2aa3-0d0a-2096-972b5cf0297a@nvidia.com>
Date:   Thu, 16 Dec 2021 20:36:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbsjZDc8tt3fMUQt@orome>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf29675-ea49-4b1d-db50-08d9c0a59c82
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3211966623FE5A815C2E0A3EB9779@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?Windows-1252?Q?lqA2MieAmzljUSdyWvfboOMfJsRFdpBTQbzg8qBkaYBj706eac2Jhtxd?=
 =?Windows-1252?Q?eWsFLUPwwhqtg7M9o8V3JLup6qST30IGOqJBSnOC/dPiahkIcrQloGmj?=
 =?Windows-1252?Q?0/FarRa2zMjkfAlpwHUNX+AYHiaH+Rs3J3OlQ/Zwloobit3SOnEXKCk+?=
 =?Windows-1252?Q?Mb2xkxEo0xC/pM4nXHmtht1ei2eJMcqoJ84gL1IIjI6z+XhGyRbEdEx7?=
 =?Windows-1252?Q?6CPCnB/m44Smo36v1bdeKKcm5hm36otPAYaiNQCy/aGw8Lxjgmgk6S1C?=
 =?Windows-1252?Q?ZEsFXvftrruf+Hr5oBwfiQS6GFGm30xcpoEDpeILa7/2u1BWvfufNFOL?=
 =?Windows-1252?Q?3Vc67UB08V4YGNOtVwh0CoamKx5PHJEUTA+nsZ8TH2WYuoIjTOk1uxPT?=
 =?Windows-1252?Q?XNh8q+TdoNWgTYakLtE16dfgqDX4bPlVQgpEcsJEH5Axs6xswYeQ7Fff?=
 =?Windows-1252?Q?Cc1/Nm84PU1w2SSzW74ViQ5JdDD7ysbkiayJpzogGFhnP/pqFbp3uUeg?=
 =?Windows-1252?Q?XlRIiI4+yIyZEEx6E2uagsCTFq+Mnzsxd6EFy6EdNYnNZyvfB2twY+EC?=
 =?Windows-1252?Q?kJrHEtUCj536uLyEEKrGtXWQijdyey5MwXf5dzlH2EPeESq3RAQRJ+7r?=
 =?Windows-1252?Q?RpTdV8oYF+NigFiw/mL5a1CUl/BQvbgfs8PZPWeHRKvAkfnlxIdWABNS?=
 =?Windows-1252?Q?JmzgPsovHYl0y1FiD8Ec08a5zZ9ohEEpHAnUEElqoFyNgG/2I80draty?=
 =?Windows-1252?Q?HNP27hAoqLN0QE1/VYnK/rR9IlAkkiODaB9GxOOYLWE5u/3DbHN+fvgq?=
 =?Windows-1252?Q?UKVxAeB51+I6+r6lrwh5J9R6v0PQuYu1Td2NcPIwdXFrP54vLfXC0ICE?=
 =?Windows-1252?Q?Rh2DV0FxxbUaYoEt9XfupEPeqoGV1fUNnq2NgZ1oDNpf/rMer36HXbmf?=
 =?Windows-1252?Q?/JHSmtQxkAA6WOB3y74N0XaSMN374AAQo/HC2OzuTKYBGB2HF5K8i277?=
 =?Windows-1252?Q?gzm4r11eutpSnTSji2F3b6IoNHf0q0kT6gse15duenKdRI2UTKE=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(26005)(426003)(70586007)(107886003)(2616005)(16576012)(316002)(2906002)(34020700004)(36756003)(86362001)(5660300002)(336012)(16526019)(186003)(31686004)(40460700001)(6916009)(83380400001)(8936002)(36860700001)(54906003)(8676002)(4326008)(31696002)(82310400004)(356005)(70206006)(47076005)(81166007)(508600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 15:06:17.6188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf29675-ea49-4b1d-db50-08d9c0a59c82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

> On Thu, Dec 09, 2021 at 10:52:03PM +0530, Sumit Gupta wrote:
>> Add device-tree binding documentation to represent CBB2.0 (Control
>> Backbone) error handling driver. The driver prints debug information
>> about failed transaction on receiving interrupt from CBB2.0.
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   .../arm/tegra/nvidia,tegra234-cbb.yaml        | 80 +++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>> new file mode 100644
>> index 000000000000..ad8177255e6c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id:"http://devicetree.org/schemas/arm/tegra/tegra23_cbb.yaml#"
>> +$schema:"http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: NVIDIA Tegra CBB2.0 Error handling driver device tree bindings
>> +
>> +maintainers:
>> +  - Sumit Gupta<sumitg@nvidia.com>
>> +
>> +description: |+
>> +  Control Backbone (CBB) comprises of the physical path from an
>> +  initiator to a target's register configuration space.
>> +  CBB2.0 consists of multiple sub-blocks connected to each other
>> +  to create a topology.
>> +  Tegra234 SOC has different fabrics based on CBB2.0 architecture
>> +  which include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI
>> +  and "CBB central fabric".
>> +
>> +  In CBB2.0, each initiator which can issue transactions connects to
>> +  a Root Master Node (MN) before it connects to any other element of
>> +  the fabric. Each Root MN contains a Error Monitor (EM) which detects
>> +  and logs error. Interrupts from various EM blocks are collated by
>> +  Error Notifier (EN) which is per fabric and presents a single
>> +  interrupt from fabric to the SOC interrupt controller.
>> +
>> +  The driver handles errors from CBB due to illegal register accesses
>> +  and prints debug information about failed transaction on receiving
>> +  the interrupt from EN. Debug information includes Error Code, Error
>> +  Description, MasterID, Fabric, SlaveID, Address, Cache, Protection,
>> +  Security Group etc on receiving error notification.
>> +
>> +  If the Error Response Disable (ERD) is set/enabled for an initiator,
>> +  then SError or Data abort exception error response is masked and an
>> +  interrupt is used for reporting errors due to illegal accesses from
>> +  that initiator. The value returned on read failures is '0xFFFFFFFF'
>> +  for compatibility with PCIE.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^[a-f]+-en@[0-9a-f]+$"
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
>> +    maxItems: 1
>> +    items:
>> +      - description: secure interrupt from error notifier.
>> +
>> +  nvidia,err-notifier-base:
>> +    description: address of error notifier inside a fabric.
>> +
>> +  nvidia,off-mask-erd:
>> +    description: offset of register having ERD bit.
> I was wondering about these two properties. Do we really need them? I
> see that they are set on a per-SoC basic and they only differ between
> the various fabrics. If they don't need to be configured on a per-board
> basis, then I don't think we need to specify these explicitly. Instead I
> think we could derive them from the compatible string
The CBB 2.0 based fabric's error handling driver remains same across 
different SOC's and their variants. Only these fields change.
e.g: "off-mask-erd" value is different for T23x SOC variants.
"err-notifier-base" also changed multiple times during simulator stage.
So, keeping them in DT to avoid changing the driver code for different 
variants of an SOC and to change them during bring up stages with DT 
change only.

> 
> Thierry
> 
