Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDD4DAC01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354315AbiCPHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354308AbiCPHq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:46:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC760CC3;
        Wed, 16 Mar 2022 00:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjvl2ao0vDZHom6uqPAxNbXxzxAHTKQKyZum1o9QKKqOb7D8o/UNnKN7rBC291Y0JMMEvHNCYOpcRs3mCrhIcceKyuMnjpQIAMY8iyHlPz9FUufdACxMXaNkDuPdyslvabmCTvPCHCrNFWWWTNP2s+1Z3dmthLz8HsqV0B29ONnpCPZH7hwo56VZMDDDDWSO3z0ka/JcHr/RXO9DPffW/SZ8EeCp2sxWo9bIrYUGP7+YuCKO1zNJJAFTIDWxI8rU1jTC5PtJ+iDXOIk3+/igUmlxuCTWvYt/GNO8mvL+DZ00v2EUABUr5ch1fic1Wlk+nqlqD67qXtD+t217U6BesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ythqLgrW2Ul7K76G/bx1DBEEJlvUNQatj2V/KqFPcJM=;
 b=Ka8aVHtccK5BJnOjDo7aAdaWdNV0VHsHfkCBZ7fbbxClXBPDZ0aewL0Bk84Jd608VdV6R3DC5+4P9HySFzX1AYKhnt61bgTobHGsSkeQI7nt/PY+rsjCqyBhXKP04jCPpmRBxp+LrfmZYfiSZeCI6GI4/OuOQz+KGrUe9hY9LXzLmAR1RKYCXTe3I1JXnyN+NnqyYtoUsv+yzKYLEYlz2x5Ct/mJEUDMQ1cbnKknazkIMdRuZpDj9c/s8bJ1FNJp3MjNbcqyGmrEw4qa5OYjUghzajfDwNXQwyrN70uKLROFEK6euRyhcsV8HIwABlyAiSzG91mrFINPlLDcD+z5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ythqLgrW2Ul7K76G/bx1DBEEJlvUNQatj2V/KqFPcJM=;
 b=VBEN/ONoPrYUFNdEXI0K8VnD7NEkBEsCHiHi3cTeQKDH4+0Dywft9hbAIyjCz92mH1QSZBPImHjcanIiCohsNLbX9UH3jxbau64e+/zlNJncCKR4Urd9A6jHftUR2LVlDLSV4c44jGaZlQwyGGxwr+CrMamz16u2/f/MRl1M2UddWS+0yf1oLLdDpqMBRWbQR240s7BthTm+SrL+16G4KnqgUXYx2BMTu3ywp+u6cS1UK5N7SelRXtNAC72yfNSqnef/1nGN+Wq5OKzi2tOGpDtR8ITOaPbYWKqUTj8AlkfTk9QWOdJ47cMQDKJcezxBQF/PCpQhPi+0Z7OTsGHVLA==
Received: from DM5PR21CA0042.namprd21.prod.outlook.com (2603:10b6:3:ed::28) by
 PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 07:45:42 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::95) by DM5PR21CA0042.outlook.office365.com
 (2603:10b6:3:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.6 via Frontend
 Transport; Wed, 16 Mar 2022 07:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 07:45:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 07:45:41 +0000
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 00:45:38 -0700
Message-ID: <e1d484b5-b755-e406-8711-62f3756759f3@nvidia.com>
Date:   Wed, 16 Mar 2022 13:15:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        <kbuild-all@lists.01.org>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>, Thierry Reding <treding@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
 <20211221125117.6545-4-sumitg@nvidia.com>
 <YcNv7xm19sFTlfjW@robh.at.kernel.org>
 <226fd57c-2631-ec7a-fc48-d6547d557681@nvidia.com>
 <CAL_Jsq+=hGG-cMwvM0sKFW=Rwa56=fqS379jL4ZjSyDKOia-RA@mail.gmail.com>
 <YhY1Hhgz/O724oYL@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <YhY1Hhgz/O724oYL@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35bc7e8a-8848-483a-dcb7-08da0720f931
X-MS-TrafficTypeDiagnostic: PH7PR12MB5595:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB55950C26106E767C78BDFD2EB9119@PH7PR12MB5595.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a32jAN7RlzXpocnQN8LMZuykuaV8FzyTgCJ3xODLQ9ZrJqLNgeUQOzZvBLcexOKorGUeC6DQD8xZUxDsM10l7lp3YEM3kcKn9GqQPliprlZ6y7icx2rr6E2C3pPLJiriihZytEUdHxlit6j7fO8NaS+AxuWdRvaI3vhBOH9cTd2EQzZzhzejfa8XvNh2I2xo7qsW0FuKEXUYUFkapHMJ7vOI4QH9pIBqErmR4UqWuP1p7RTQdwXL+ONFyFOeg1jG65FIorCVf/+1aS1YJ57baP+HS8k8XA5Kw+3R3IaBSRfTbfS3kbLIZ18TuepOSTnf9u46Yf8H1lPRBTlIKf7hvnJ5XcIr5BTwjT3T1SCSk+YjjJfZts0BEOfrHq173GuJ005IF1auugD0T2AUYvQ9WJcMYw9yuRCORWMCR9JZlqMdCe0/lxSvvjrvzbpLPAML6EDhJ6mWpSPStyURzIDL3f0VTpJyfqb8yKwarSmKZJW/ObFRyNd3BG0ksmhNVKNQAxeiT1yoKLhxzRaHecb1npUEZW7LnOr2sFpZlpiLWso3MXH4HQDSAj2wUrl5ZkaBdGpW+OWdepZHoc4p9hFXMV9Uj8Q6KX3oHkn9c4VBk54jgyOepg27SVkiENf/lcwi0376zfCYgsM9GYjDP0RVydAMo68DCdKwuxMBCzkPvy6pT8WVTTDKhxozp3H0vmvorz81b3A6CGWyB9QxD4gpECCerItzRhikSM+P9UsYvKRx+Wl35tt7j6DTs3E26YLjdmr/TY8Y78ELN4LgEzQqj1ywdrXYo9zJQ453QNvBcgf1Ks8sRJx7+purQ/km6RRhtZik9m7LlOv1WmuuvzkOtToe9bE7gIg4UBtolMUjseWNOk7AI0F/Xo5RznEA+ft
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(8676002)(16576012)(36756003)(110136005)(2906002)(54906003)(70206006)(70586007)(4326008)(6666004)(5660300002)(8936002)(508600001)(31686004)(356005)(336012)(26005)(81166007)(426003)(186003)(2616005)(16526019)(107886003)(47076005)(86362001)(31696002)(36860700001)(82310400004)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 07:45:42.6082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bc7e8a-8848-483a-dcb7-08da0720f931
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>> Add device-tree binding documentation to represent the axi2apb bridges
>>>>> used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for APB
>>>>> slaves are reported as slave error because APB bas single bit to report
>>>>> error. So, CBB driver needs to further check error status registers of
>>>>> all the axi2apb bridges to find error type.
>>>>>
>>>>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>>>>> Signed-off-by: Thierry Reding<treding@nvidia.com>
>>>>> ---
>>>>>    .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++++++
>>>>>    1 file changed, 40 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..788a13f8aa93
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>>>>> @@ -0,0 +1,40 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id:"http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
>>>>> +$schema:"http://devicetree.org/meta-schemas/core.yaml#"
>>>>> +
>>>>> +title: NVIDIA Tegra194 AXI2APB bridge
>>>>> +
>>>>> +maintainers:
>>>>> +  - Sumit Gupta<sumitg@nvidia.com>
>>>>> +
>>>>> +properties:
>>>>> +  $nodename:
>>>>> +    pattern: "^axi2apb@([0-9a-f]+)$"
>>>>> +
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - nvidia,tegra194-axi2apb
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 6
>>>>> +    description: Physical base address and length of registers for all bridges
>>>>> +
>>>>> +additionalProperties: false
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    axi2apb: axi2apb@2390000 {
>>>> As axi2apb appears to be a bus, then all the child nodes (APB devices)
>>>> should be under this node.
>>> axi2apb is a bridge which coverts an AXI to APB interface and not a bus.
>> A bus and bridge node are pretty much one and the same in DT
>> representation. A PCI host bridge has a PCI bus beneath it for
>> example.
> Sorry for taking so long to reply, this fell through the cracks.
> 
> These aren't really bridges as such. CBB (which we call /bus@0 in DT) is
> a sort of large container for all IP. Within that there are various shim
> layers that connect these "legacy" interfaces to CBB. I suppose you
> could call them bridges, but it's a bit of a stretch. From a software
> point of view there is no observable translation happening. The only
> reason why we need this is for improved error reporting.
> 
> The TRM also doesn't make a distinction between the various bridges. The
> devices are all just mapped into a single address space via the CBB.
> 
> My understanding is that this is also gone in newer chips, so matters
> become a bit simpler there.
> 
> Reorganizing /bus@0 into multiple bridges and busses would be a lot of
> churn and likely confuse people that want to correlate what's in the TRM
> to what's in DT, so I don't think it's worth it.
> 
> For newer chips we may want to keep this in mind so we structure the DT
> more accurately from the beginning, though as I said, things have been
> simplified a bit, so this may not be an issue anymore.
> 
> Thierry

Hi Thierry,
Thank you for answering the concern.

Hi Rob,
Can you please ACK to help queue the patch series for next.

Regards,
Sumit
