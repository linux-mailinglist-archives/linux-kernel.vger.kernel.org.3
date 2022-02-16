Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644524B8B66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiBPO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:28:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiBPO2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:28:30 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE4D291FA0;
        Wed, 16 Feb 2022 06:28:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlsXuaQqj7wQ4YBMx3oSCr610aquPuJEL1MSO+1YeBzNzRrKUt1EMBP3yYQTK51bqypajSy/1ykWIhUKdgj0Bwnbey5IXbkxYGXT2SFpL8iETVbjy+l7XaX2ryDqZ+HgsKrvQ9Ps03Xx9q54061tx0lxAKLpEDSKN6HtbicdTdGT7agnGdDLdeySXleSEGS+lygEVE3GYZYhM+pmIkUghwaLKiqsz7ShrYFHxr3zCNaf4GqbqWEg+UuMZUDIuJc7vPkgdDKu+LrJxdk+tRJeD4ztcDjfPDniodZGLfoVKj29jTxl/MtdltSPc5woTpyxJT2e4CDVwLoB93TX/Ohu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1kf0aQInvkFxDkoxwF8KcP0HARpMdBUkt3/DZmM9Cs=;
 b=dqjhP3UYWA3G/3CebjsK7urysxnugw522nTZjWU2xr0EJ2sE21ZcvtoRMHyUPzMTL9Guxvqms06+Ls6ioSXjY2k51B4leNOlc4CrjX3wQ6ixwxFYPgKKY7FZwK86fLsdkhfVuW5ewK1W6INNoRQFxLrVhzuzfWVGQVUHACuKSmuEJlUfPd9GpAPy+Mmw1O/jm4tZJ3m2/wO3XZFhHLlKiZPhTrRfHOBHB1Hbl+Y6xMJVbZyAVNvYOeatJC0eiN8vxAY1M5X681+mdftLgiQkHVrVtzr6/Gqk0OSRExw3/1ZKDuLtC7mC+BT+IZCAkJkVs6KilWjUMyO/7dJgJiCVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1kf0aQInvkFxDkoxwF8KcP0HARpMdBUkt3/DZmM9Cs=;
 b=jiqND+7T5Kjntn1oS9aUMixb4Rf+yrrKX+aoQz+f6KlpsvWzDgXHFxifUZoiTyCqAzjq9D7toGhhh6GcI/U42NHDjCkQ5thyuzG1WRKKiQjs2viAGw8mXI3BIV75RArbCgBWZvRNONqzoQgOo1j/6wHaCWjhLFWeJkwT8drxVKM=
Received: from DM3PR12CA0093.namprd12.prod.outlook.com (2603:10b6:0:55::13) by
 BL3PR02MB8148.namprd02.prod.outlook.com (2603:10b6:208:35f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 14:28:11 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::6a) by DM3PR12CA0093.outlook.office365.com
 (2603:10b6:0:55::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 14:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 14:28:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 16 Feb 2022 06:28:10 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 16 Feb 2022 06:28:10 -0800
Envelope-to: zajec5@gmail.com,
 seanga2@gmail.com,
 robh+dt@kernel.org,
 trini@konsulko.com,
 sjg@chromium.org,
 srinivas.kandagatla@linaro.org,
 krzysztof.kozlowski@canonical.com,
 ricardo@foundries.io,
 jorge@foundries.io,
 devicetree@vger.kernel.org,
 u-boot@lists.denx.de,
 linux-kernel@vger.kernel.org,
 rafal@milecki.pl
Received: from [10.254.241.49] (port=59506)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nKLHu-0006fK-HH; Wed, 16 Feb 2022 06:28:10 -0800
Message-ID: <16e788ec-28e4-11be-d1f8-5c5249a87c2d@xilinx.com>
Date:   Wed, 16 Feb 2022 15:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: nvmem: add U-Boot environment variables
 binding
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Sean Anderson <seanga2@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        <devicetree@vger.kernel.org>, <u-boot@lists.denx.de>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220215134925.32691-1-zajec5@gmail.com>
 <193f9354-5e1d-def8-c8ab-fbe88d8d9b8f@xilinx.com>
 <6679b98e-f5f0-8608-a36c-c0c41fb5ea6f@gmail.com>
 <3c690660-7e23-e11b-17b8-496882f3a34e@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <3c690660-7e23-e11b-17b8-496882f3a34e@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 166b31e7-f2c1-4257-667b-08d9f1588f82
X-MS-TrafficTypeDiagnostic: BL3PR02MB8148:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB81486F7BCDC3B9CEE67AC32EC6359@BL3PR02MB8148.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQGIkCzrsivvMwjYSNNx1bfFK/YLqIwIYnRjwmFQzZMLqyEXc8aCuu3OALkIK88D/J2xE3Q+YS/1+wgJygw2zOZg923iPLcZYDsphFamHQsN7UKw9Ni7bND1Q3/N8pt8X6CsZpJFmIdocibg3WUhl/kkhWUlb7lA5FDpj8UigIRT9XZrTnNfz3efPkTVljb3mj4ArByN3u0m3eQsBjsGph0OMWIHqBPxVeWjW+vDdvUXWyF/Ajyv5ax3LyaWZ7I2zZIrsCUmNTwRWFWKSB0iOwCs22qZj8QRjsLs1+CxRdTU7+AOQ2I96lhVWphB/+FMVVVg9eMtMenxlVLwuJ05HtTflGCnbmJmHjXUsYGWEpEZ2zRVXn1hlzC6WyF3SYCQyDNoBfRIGbH6DotyTX8l9UNBZWdMQlQ/FfMC3qpaT/g+Fc1NO6lnMcdmLWSTKl6TWqXNZHADPyLo+OIzA3Ji+dbvCLpXrIj/i40Q5S61yGYE1sEVhyaoEp7lBFg/kIVIdtILsk2Wu2J2OmAjt+RYDgL+4bGLqGVd5gi/PkgAD0iIUnSiYM+1gweGQfkOh4F+MGg07lC6sX3Yv0tJjsvGiNrwwSO+jxqkUur64LxIo/cf2kX10U8i9EpwqluSezxXjhKtYz15uVXAui5xmDjONwehxcRFiFVHEbRbhpcO+adHtBN+I2Et2wFX2rr/x9lAqrfYkH1zeFjvf81xetJBtPYYGSQkrNO0PN+gLtIllGQlkzo/uMWZ3j+0TiiMgbf1KUb7C8GYLSBI4iOmnN25qaW5h0A4HQmNLdWV6+Yn7RNh0Uuvp5b+/5LG5qkkQSNJ1mnvGy+dnoxcOFSwkO8a8DgMiTT91Sri1OsC8fSjYlE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(2906002)(26005)(186003)(31696002)(44832011)(36860700001)(110136005)(316002)(36756003)(40460700003)(54906003)(2616005)(70206006)(8676002)(356005)(4326008)(7636003)(5660300002)(6666004)(7416002)(53546011)(426003)(336012)(47076005)(66574015)(31686004)(9786002)(8936002)(508600001)(82310400004)(83380400001)(966005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 14:28:11.5802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166b31e7-f2c1-4257-667b-08d9f1588f82
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8148
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/22 13:59, Rafał Miłecki wrote:
> On 15.02.2022 15:57, Sean Anderson wrote:
>> On 2/15/22 9:02 AM, Michal Simek wrote:
>>>
>>>
>>> On 2/15/22 14:49, Rafał Miłecki wrote:
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> U-Boot uses environment variables for storing device setup data on
>>>> flash. That data usually needs to be accessed by a bootloader, kernel
>>>> and often user-space.
>>>>
>>>> This binding allows describing environment data location and its format
>>>> clearly. In some/many cases it should be cleaner than hardcoding &
>>>> duplicating that info in multiple places. Bootloader & kernel can share
>>>> DTS and user-space can try reading it too or just have correct data
>>>> exposed by a kernel.
>>>>
>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>> ---
>>>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 58 +++++++++++++++++++
>>>>   MAINTAINERS                                   |  5 ++
>>>>   2 files changed, 63 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml 
>>>> b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>> new file mode 100644
>>>> index 000000000000..a2b3a9b88eb8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>> @@ -0,0 +1,58 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: U-Boot environment variables
>>>> +
>>>> +description: |
>>>> +  U-Boot uses environment variables to store device parameters and
>>>> +  configuration. They may be used for booting process, setup or keeping end 
>>>> user
>>>> +  info.
>>>> +
>>>> +  Data is stored on flash in a U-Boot specific format (header and NUL 
>>>> separated
>>>> +  key-value pairs).
>>>> +
>>>> +  This binding allows specifying data location and used format.
>>>> +
>>>> +maintainers:
>>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>>> +
>>>> +allOf:
>>>> +  - $ref: nvmem.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - description: A standalone env data block
>>>> +        const: u-boot,env
>>>> +      - description: Two redundant blocks with active one flagged
>>>> +        const: u-boot,env-redundant-bool
>>>> +      - description: Two redundant blocks with active having higher counter
>>>> +        const: u-boot,env-redundant-count
>>>
>>> I am not convinced that this is the best way how to do it. Because in u-boot 
>>> implementation you would have to enable MTD partitions to get there.
>>> And the whole parsing will take a lot of time.
>>>
>>> I think the way how I think this can be handled is.
>>>
>>> # I don't think that discussion with Simon was finished.
>>> But for example (chosen or firmware node)
>>> chosen {
>>>      u-boot {
>>>          u-boot,env = <&qspi &part0>;
>>>          u-boot,env-redundant = <&qspi &part1>;
>>>          #or
>>>          u-boot,env = <&qspi 0 40000>;
>>>          u-boot,env-redundant = <&qspi 40000 40000>;
>>
>> What about when the environment is on top of UBI?
> 
> We can always add support for binding UBI volumes in DT. Somethig
> more-or-less like:
> 
> partitions {
>      compatible = "fixed-partitions";
>      #address-cells = <1>;
>      #size-cells = <1>;
> 
>      partition@0 {
>          compatible = "ubi";
>          label = "ubi";
>          reg = <0x0 0x1000000>;
> 
>          env0: partition-0 {
>              volume-name = "env";
>          };
> 
>          env1: partition-1 {
>              volume-id = <10>;
>          };
>      };
> };

If this is something ack by Rob I have no problem with it. But it has to go to 
schema.

M
