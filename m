Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DEC4F75F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbiDGG0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiDGG00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:26:26 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2383E1F6865;
        Wed,  6 Apr 2022 23:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RruoSiMT6Ddm9nsTdeCxci/ofhDnjD4Veppt6qmZl7iX8nvf9E631ascD6K837XGXlLZeGlAWITNBV43n8RBmds7Q9pD2lRldaUqYjuK56d8DJqcAcpi+8JDcj982uI4EbGtrukZK5jAW1ZTRbdZkoBHDrEchTdkM5XKfqepGB2zj+Wln7rjU3A+8Z0rlsx5Z3CvegDiGLwWKFP7gpC6O0MnHZJJBu4CK8Fi3JvMGwtH2MF5Br+QF2wt5eSot08XLZAC8aK8FIQltZuPhnEP3RJXV5/sMI+eGwpUnrr8PFIwCy9QORLXMeAplpaq4efVvH/fYgYRrQ3NqJ1O2t/3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUrLqvG3KVidhzyqRBKsU5mvwUhfUkGRFkYeXSJLwQk=;
 b=D9AOwNCrcD9a62xPQC6yn/3UA4BTfxYMIT3+NnsL5oOaixFfDmQZq//8Zo5B91EubmJlsmdjNzceDfG5ImCa1vJ1PtekeAHBcSAW15Bxgz2UvX5HYUT/Ce06Fy5hBP+8sAXbanfmcyzKBdVAK0aoOFhe0Q+3a9kLg+YIVl6KBWniNlCHQheR1zUTGmcJtrbZRB4wgwCe9TA1adhT+a/bd2PoVLoC77tWd+e9iCYp9q5Zwg4nohFuZTOuRbD/aDXG+njxIHwxaEixVJ2bISe0GYyguydBjcpvgW+4bDsSGvXf2VFUAxMRqUo1iPFmyNUevPSpiLrtaD/5zJ7BIXinjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUrLqvG3KVidhzyqRBKsU5mvwUhfUkGRFkYeXSJLwQk=;
 b=pIU1OjjcwDJOMFmfBzcwZ2yP1qf1WnbvChViEcKCakDQ/oCIuNb1VLRRKnFgUzVBSiSLfrr6kx+EFUDvz3sX0Gjunx4covzzgsY+VwrqtvanuZ7KeT0uGxhs21MdYu9AMVC0Kelh9LUF4RXb0m97u5zf+Pua8oFpUZeOtq3suAhn/BiFBBdsmBsqskzEg+Dm96FHgB7qzOnhyTteGOlB9U7GEvhwXmCLC2IjB16PlsQR7aEAnOBoGNyCkzIiV+jh7YHFKroSXZop+xf7Pa8IZ2aYNjI422vs+SQOe4GUd4ymUzk+q+JvbNsLI2jOARza+VfOoqvBkqXiJmLosOYdkw==
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 DM6PR12MB3626.namprd12.prod.outlook.com (2603:10b6:5:11f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.22; Thu, 7 Apr 2022 06:24:25 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::b1) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Thu, 7 Apr 2022 06:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 06:24:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Apr
 2022 06:24:23 +0000
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 23:24:19 -0700
Message-ID: <2713db35-927b-c3de-20ba-fb9c613c9291@nvidia.com>
Date:   Thu, 7 Apr 2022 11:54:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
 <YhY1Hhgz/O724oYL@orome> <e1d484b5-b755-e406-8711-62f3756759f3@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <e1d484b5-b755-e406-8711-62f3756759f3@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68f14d72-93bc-4b50-4c16-08da185f4311
X-MS-TrafficTypeDiagnostic: DM6PR12MB3626:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3626F150622449457B5CD7B8B9E69@DM6PR12MB3626.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQRX9GrheTdA/W+rhsHDPV5JhKAt9wynkmAuYi63J1A/2UZUFvN92bJlwisnd6V7bUi9phkAayOPn6C4+NkIcc2Sey6BYa62mFGQ364PBIScoObBmqbhgdFMNoaSmutVLJ5EAiNpjhF2J4wFlA0vgD3qgjwdgfnuB8uWcdB52MoKYUZyQWVqrmpNNH1qr6dCb76CoTT22BvNYeGTAkuVa22Qm6gQ9DGmTEWhoJuv/oPxlwGyFONYs6j/ZDPWsoKyo61cYSQkW8fG/A7pApWKX/EFL3gnkoFPuHL6CjpEUXA1hs06n2S6bFyA1oG+pUFO32iuB2c2vn5FuNaI7AdZJOOg63tF0URR6zx9kCozoumRr88J584lqHf7z9SetLIi5oYW3TkXwT6KqkqoZpH0W1nL9NjebONh7uFgc7gN4OHhhU03borYbft23F0uG5txJ+jiyp5pFD9qnGPUaYnaKnp1meeKXSyIKGXCA6XuGONHzAy6sJ/5+VhIXMnPHdl4jrgKStRdVoO6ZOxVY1/tJH2DNv3jWHhEQllSu9/TOc/HL0nHsLCnRUhjRUFGmCY+UzgwwyzTIvbH/5dlEiAbNOgpcMnvlr+RLWnFnn/sEXaFL8XvOVS2ibMb5hS2gZOn/98VqABC7R9QdTa1GmdOHB0J1FC+KWbXSgfAcpjXGCWwcJ3m4KmP5I/sgTzRgyQt5wxmnagNIzhfVIAApsNaOinzrL/ePk3F1tUx8vmE3qvGFR2qDX0QwwjWIEOYtAZPfxdD7KFjbFfPPYAiTOaX0BV7d3jUODDj4xlXjwuxLyDgUbaH6fSGfvGSk9RcxPpPXRWTgEZYchu7fUl+U19MNoad2CoXpauVs25QS6l94UZu0jESF1XYSnJZt22VC9V3
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(186003)(16526019)(336012)(26005)(5660300002)(82310400005)(426003)(316002)(36756003)(40460700003)(31686004)(31696002)(8936002)(16576012)(36860700001)(8676002)(4326008)(70586007)(70206006)(2616005)(107886003)(356005)(47076005)(54906003)(6666004)(110136005)(508600001)(86362001)(81166007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 06:24:25.1263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f14d72-93bc-4b50-4c16-08da185f4311
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3626
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>>>>>> Add device-tree binding documentation to represent the axi2apb 
>>>>>> bridges
>>>>>> used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for 
>>>>>> APB
>>>>>> slaves are reported as slave error because APB bas single bit to 
>>>>>> report
>>>>>> error. So, CBB driver needs to further check error status 
>>>>>> registers of
>>>>>> all the axi2apb bridges to find error type.
>>>>>>
>>>>>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>>>>>> Signed-off-by: Thierry Reding<treding@nvidia.com>
>>>>>> ---
>>>>>>    .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 
>>>>>> +++++++++++++++++++
>>>>>>    1 file changed, 40 insertions(+)
>>>>>>    create mode 100644 
>>>>>> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml 
>>>>>>
>>>>>>
>>>>>> diff --git 
>>>>>> a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml 
>>>>>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml 
>>>>>>
>>>>>> new file mode 100644
>>>>>> index 000000000000..788a13f8aa93
>>>>>> --- /dev/null
>>>>>> +++ 
>>>>>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml 
>>>>>>
>>>>>> @@ -0,0 +1,40 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id:"http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#" 
>>>>>>
>>>>>> +$schema:"http://devicetree.org/meta-schemas/core.yaml#"
>>>>>> +
>>>>>> +title: NVIDIA Tegra194 AXI2APB bridge
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Sumit Gupta<sumitg@nvidia.com>
>>>>>> +
>>>>>> +properties:
>>>>>> +  $nodename:
>>>>>> +    pattern: "^axi2apb@([0-9a-f]+)$"
>>>>>> +
>>>>>> +  compatible:
>>>>>> +    enum:
>>>>>> +      - nvidia,tegra194-axi2apb
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 6
>>>>>> +    description: Physical base address and length of registers 
>>>>>> for all bridges
>>>>>> +
>>>>>> +additionalProperties: false
>>>>>> +
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>> +
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    axi2apb: axi2apb@2390000 {
>>>>> As axi2apb appears to be a bus, then all the child nodes (APB devices)
>>>>> should be under this node.
>>>> axi2apb is a bridge which coverts an AXI to APB interface and not a 
>>>> bus.
>>> A bus and bridge node are pretty much one and the same in DT
>>> representation. A PCI host bridge has a PCI bus beneath it for
>>> example.
>> Sorry for taking so long to reply, this fell through the cracks.
>>
>> These aren't really bridges as such. CBB (which we call /bus@0 in DT) is
>> a sort of large container for all IP. Within that there are various shim
>> layers that connect these "legacy" interfaces to CBB. I suppose you
>> could call them bridges, but it's a bit of a stretch. From a software
>> point of view there is no observable translation happening. The only
>> reason why we need this is for improved error reporting.
>>
>> The TRM also doesn't make a distinction between the various bridges. The
>> devices are all just mapped into a single address space via the CBB.
>>
>> My understanding is that this is also gone in newer chips, so matters
>> become a bit simpler there.
>>
>> Reorganizing /bus@0 into multiple bridges and busses would be a lot of
>> churn and likely confuse people that want to correlate what's in the TRM
>> to what's in DT, so I don't think it's worth it.
>>
>> For newer chips we may want to keep this in mind so we structure the DT
>> more accurately from the beginning, though as I said, things have been
>> simplified a bit, so this may not be an issue anymore.
>>
>> Thierry
> 
> Hi Thierry,
> Thank you for answering the concern.
> 
> Hi Rob,
> Can you please ACK to help queue the patch series for next.
> 
> Regards,
> Sumit

Ping.

Regards,
Sumit
