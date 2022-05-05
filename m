Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538BB51C5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382651AbiEERXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEERXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:23:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36195D1B1;
        Thu,  5 May 2022 10:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZygHdaD9ZTP6+Y2IR9HljttEgpPKboiDfxURfAWW+jXkncGaCOiBvKA/YsYS9TGcbh7jP22veQ6Iyr7Ag1ErR3LL+PHGAyciNjFZhHzVMLW3aiowzoO0CZvDQghKB6kB4fWd+PsXQkJ5n2uYJpUY8T1YzYHCgV0NpcyPJi6VZ46IDECb6ntyDDO21WjW/LdpFRzG166fHJj/l39fTzQUU77ju7HrF9sT5LBYxCbY7WPjATnLk9pGyZLvm/vnV3niRNCNPjj9bU7caUAYdXo7v+C4ovmLP92RohzGzS/oGdUsKabSL/3hhcWioTJ9E94ByVGrZIuomXy0MBtZOiSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMIlU0xFWgYkx96XySq/kQjOGlmu76Z7GP4nivMZBdA=;
 b=U+zsnLtgSs2ULTiGgMr2KXAWkEfwCVLL7JlwMN/F39eyvz8S+egJNS6ZrayeOiWO1jZWMeWQqdWB6EWEgIkt/QQORXJyB9ag5HmMPtXbzEw3E4Zo1Y6J2Y+BpjjkOQAxVYxRNmU2xOLcnBVxiIB+kULcXJd8ytMH0m2pVxYpRlF+pRG+NOjFHQFm98JpeBIJFK0CPFZnNfRTazaHVaAO+kW6HUEk6htLMJc3i7+uFuqcs9YUNeITaM3zT3GBqQY50vwmvr/viQngEe+G+N514opjVEmSdU44Ysju6X733kAbiefpmzgh7dtuvoL2HSXmiAQ5rO9ywlnsJYrXbrjocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMIlU0xFWgYkx96XySq/kQjOGlmu76Z7GP4nivMZBdA=;
 b=IqOz4TbjN/d2gkE4bvA3f4/7kDm0IBXQ0Ff3XHTBrcgKAq6SyDUksg7GK8d5soixgkUDdvrU3w0hJyQCduI43w1+TObAQePaNDpldp33o1o3iWf4HBV+F1QWWkwbAi8auDTNZDlQzX2irysEIsYdZR2QZHI3uQa/Qxg5dmaKwI9rskNLBpJE0KRjIeJ6C4aCsoTCkNJACLxL6EFPZMoQyYgT+/oy/ePFR46+w4zmgTHGlTPis06wUL53+XX8exj/Oq7RwJLRZkmh/2UDyiu2c9GzBcvALT0hZjpntMFz6Z0LdFXhfC+psYE9t7YpjTcPtVqfnT8GdPUL9YbW/ddmoQ==
Received: from BN9PR03CA0273.namprd03.prod.outlook.com (2603:10b6:408:f5::8)
 by BN8PR12MB3473.namprd12.prod.outlook.com (2603:10b6:408:65::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 17:19:52 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::ad) by BN9PR03CA0273.outlook.office365.com
 (2603:10b6:408:f5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 17:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:19:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 5 May
 2022 17:19:51 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 10:19:47 -0700
Message-ID: <b34d3443-d4fe-25ce-2d45-40a428951440@nvidia.com>
Date:   Thu, 5 May 2022 22:49:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
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
 <YhY1Hhgz/O724oYL@orome> <e1d484b5-b755-e406-8711-62f3756759f3@nvidia.com>
 <2713db35-927b-c3de-20ba-fb9c613c9291@nvidia.com>
 <YnPZUFgZHJ9mFe0D@robh.at.kernel.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <YnPZUFgZHJ9mFe0D@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18074135-b41a-4696-b5fd-08da2ebb7789
X-MS-TrafficTypeDiagnostic: BN8PR12MB3473:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3473AA000FA7F4B724228777B9C29@BN8PR12MB3473.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87IkkBbzBT/8Deu4nnrn0unun7drqsrGgzEFVxmtetAQVmpvE93/vCmV4KKs3r26aBbyS+5MvAMX+6ifVOfU2jMM9TbP5LCKAzD9sA4krFEZM5GkrUJBh6Jf64slTFMlq8aXPYhecjqUDbalrVH2/0MAkpSf8zjWBuCXZFdDLuiIKCI5AkzvtRFAnBdGKROhD7WSPN04PHNidWlLXta8mjhh9rjw9L9R7kjG9chM9bbtO8HlFX744QZxe+iSiosY3olOvZ5l4wMaGOAZIh8AuzIJk+h/1RrrJDeswV34d84Wi6oOEmlrnubWJct/XjC/LztIinkd2JJUXFq4Vvo0ZLBQTRGk3Ob86siVbGakJcehrJptvPekqFkvR1ttRo2Q6nAZiweAizEOshLEz8KodXqowzsmsibaASIw6Ju7tI/MLK+h6O7SUeqmdS6YY9+qt4CACR8K0AV46ogIqE34cTPOCl6IfOquzKCvus3thIsAEOCA1DHqPOUCR03rsdYxVqzlFtP38jAQ2cd6ts+j7nYrA5+Ck2hFAPcXDsRkU5ONh5u/9851cxsrDYkjYLXj4g7TKJJQ1m+sAQyIWTsboi3r8HCnelzAYehhIsdc3rR5+rzapY0ueI56285nKjXYRQul3ywDuIkNn6TlfPTI3EK7zBn9ckpLIG3RwKIxfqROSkhlffc+4Jc7askp08+dEagCFwP9P5xYpp+9B3A6GySALNbocYtOJPp+nwXUhAfh9cv/yJ9rM0IDdIdD3DK61raSNRNkyp/2I8JFPdkGaHktTpyCupqPiHfQeCIRPSLLH1wz1RuI4UMjJElygXT/tcYp8HQM58Tce7HxWkuTsgah2ekFXT1wQJwLMUEGXBaoY1zdiuYehZcGjwFoAUI7
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(16576012)(316002)(36860700001)(8676002)(4326008)(70586007)(70206006)(508600001)(31686004)(54906003)(6916009)(36756003)(5660300002)(53546011)(2906002)(426003)(47076005)(186003)(16526019)(336012)(26005)(40460700003)(107886003)(356005)(86362001)(82310400005)(31696002)(81166007)(2616005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:19:52.3903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18074135-b41a-4696-b5fd-08da2ebb7789
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3473
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/22 19:34, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Apr 07, 2022 at 11:54:16AM +0530, Sumit Gupta wrote:
>>
>>>
>>>>>>>> Add device-tree binding documentation to represent
>>>>>>>> the axi2apb bridges
>>>>>>>> used by Control Backbone (CBB) 1.0 in Tegra194 SOC.
>>>>>>>> All errors for APB
>>>>>>>> slaves are reported as slave error because APB bas
>>>>>>>> single bit to report
>>>>>>>> error. So, CBB driver needs to further check error
>>>>>>>> status registers of
>>>>>>>> all the axi2apb bridges to find error type.
>>>>>>>>
>>>>>>>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>>>>>>>> Signed-off-by: Thierry Reding<treding@nvidia.com>
>>>>>>>> ---
>>>>>>>>     .../arm/tegra/nvidia,tegra194-axi2apb.yaml    |
>>>>>>>> 40 +++++++++++++++++++
>>>>>>>>     1 file changed, 40 insertions(+)
>>>>>>>>     create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>>>>>>>>
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>>>>>>>>
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..788a13f8aa93
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
>>>>>>>>
>>>>>>>> @@ -0,0 +1,40 @@
>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>> +%YAML 1.2
>>>>>>>> +---
>>>>>>>> +$id:"http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
>>>>>>>>
>>>>>>>> +$schema:"http://devicetree.org/meta-schemas/core.yaml#"
>>>>>>>> +
>>>>>>>> +title: NVIDIA Tegra194 AXI2APB bridge
>>>>>>>> +
>>>>>>>> +maintainers:
>>>>>>>> +  - Sumit Gupta<sumitg@nvidia.com>
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  $nodename:
>>>>>>>> +    pattern: "^axi2apb@([0-9a-f]+)$"
>>>>>>>> +
>>>>>>>> +  compatible:
>>>>>>>> +    enum:
>>>>>>>> +      - nvidia,tegra194-axi2apb
>>>>>>>> +
>>>>>>>> +  reg:
>>>>>>>> +    maxItems: 6
>>>>>>>> +    description: Physical base address and length
>>>>>>>> of registers for all bridges
>>>>>>>> +
>>>>>>>> +additionalProperties: false
>>>>>>>> +
>>>>>>>> +required:
>>>>>>>> +  - compatible
>>>>>>>> +  - reg
>>>>>>>> +
>>>>>>>> +examples:
>>>>>>>> +  - |
>>>>>>>> +    axi2apb: axi2apb@2390000 {
>>>>>>> As axi2apb appears to be a bus, then all the child nodes (APB devices)
>>>>>>> should be under this node.
>>>>>> axi2apb is a bridge which coverts an AXI to APB interface
>>>>>> and not a bus.
>>>>> A bus and bridge node are pretty much one and the same in DT
>>>>> representation. A PCI host bridge has a PCI bus beneath it for
>>>>> example.
>>>> Sorry for taking so long to reply, this fell through the cracks.
>>>>
>>>> These aren't really bridges as such. CBB (which we call /bus@0 in DT) is
>>>> a sort of large container for all IP. Within that there are various shim
>>>> layers that connect these "legacy" interfaces to CBB. I suppose you
>>>> could call them bridges, but it's a bit of a stretch. From a software
>>>> point of view there is no observable translation happening. The only
>>>> reason why we need this is for improved error reporting.
>>>>
>>>> The TRM also doesn't make a distinction between the various bridges. The
>>>> devices are all just mapped into a single address space via the CBB.
>>>>
>>>> My understanding is that this is also gone in newer chips, so matters
>>>> become a bit simpler there.
>>>>
>>>> Reorganizing /bus@0 into multiple bridges and busses would be a lot of
>>>> churn and likely confuse people that want to correlate what's in the TRM
>>>> to what's in DT, so I don't think it's worth it.
>>>>
>>>> For newer chips we may want to keep this in mind so we structure the DT
>>>> more accurately from the beginning, though as I said, things have been
>>>> simplified a bit, so this may not be an issue anymore.
>>>>
>>>> Thierry
>>>
>>> Hi Thierry,
>>> Thank you for answering the concern.
>>>
>>> Hi Rob,
>>> Can you please ACK to help queue the patch series for next.
>>>
>>> Regards,
>>> Sumit
>>
>> Ping.
> 
> No one is going to apply a 4 month old patch. For starters, the DT
> meta-schema evolves and this could now have errors. Please resend.
>
Sent v4 with rebased patches on linux-next.

Regards,
Sumit
