Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D324B706C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiBOPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:02:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiBOPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:02:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840FD1EAEA;
        Tue, 15 Feb 2022 07:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUDUCni3l2B4YLrkUIR5xXWkpqAezZH54Oe43KGtIdYQ/BRiQYrOUulF4bdxuW/BEWxJTJdMFWdBjK41354GbZqOagecSnM74hDzUupXQxAGzBo0qppcpPfmGTqBGgVFTq5zFbmaRzlINFRN4r9whIIxmcnIl4bZTwywwQgjuvb7p/W0qTUycARCBV5QqZL0NxFReVWcAfX4Wiqhs2pHrkfVk1jiPmu3KCSTr7aObYSoOj9efLS9gvdwN/m1VQRcfxsO4AP9f18M7G4iMOzvBl41zIt3kfYOQY3pRX94kNvpe+7FiYYzjIwWYyhTXh7iMg4w+yXdaB0Z99lFWxypSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN9zH5NUB/Yga89NpvXWBEy+j3NC5YB17lnIQ3kWWew=;
 b=fjnFGpg6iLcATF84imYWqJ3M6PlUvHi+A4q+xuAFkNrqI0i2iz8I5VgO/pyycmlehkv1fGCdb2GvGLTk6vttLS1NALeFQLU3wzBtlUbv72XeMW9ThK5KDRQqaYbswCNnBdg4dwBUrj/Lo14qToy5CxSkMMl+3KS6GTeqt0ORgJbsmJS5Ki6v0U1ANsQ9o9/aoiIIHUFz7zV8AhVBF3+WcczEvT2igQV3/BnhYNpCnGNygugdbKqjqJCatGvZA6rHoddWYHZ2+/FYVPiMP22GzvgDUKe/aMrlXrhT+fzLaDaE0qzbqXhegAoAT/PWmC4lHmOZ/wojTxnINJNqcGtSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN9zH5NUB/Yga89NpvXWBEy+j3NC5YB17lnIQ3kWWew=;
 b=ffFwxWL2f31xe5fWsM42ShM5skxnNWH/6bvwbApctKe5vsw9pGOZuJVa+5MpXjegcsmPbpByWGNqytSCjlBByLj6bhy60ir94SFnj3IdH/8Q4jnTKABAYOPHNml6XYQ97V97kWNmQ4rlFrWdjonfbjV16FK0Nn4KkY1xn8TDjc0=
Received: from DM5PR12CA0008.namprd12.prod.outlook.com (2603:10b6:4:1::18) by
 MW4PR02MB7348.namprd02.prod.outlook.com (2603:10b6:303:76::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Tue, 15 Feb 2022 15:02:42 +0000
Received: from DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::9f) by DM5PR12CA0008.outlook.office365.com
 (2603:10b6:4:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Tue, 15 Feb 2022 15:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT016.mail.protection.outlook.com (10.13.4.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 15:02:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 15 Feb 2022 07:02:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 15 Feb 2022 07:02:38 -0800
Envelope-to: seanga2@gmail.com,
 zajec5@gmail.com,
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
Received: from [10.254.241.49] (port=43520)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nJzLi-000EaI-BX; Tue, 15 Feb 2022 07:02:38 -0800
Message-ID: <2def78a6-afbf-7534-358c-9515abf1b68e@xilinx.com>
Date:   Tue, 15 Feb 2022 16:02:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: nvmem: add U-Boot environment variables
 binding
Content-Language: en-US
To:     Sean Anderson <seanga2@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
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
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <6679b98e-f5f0-8608-a36c-c0c41fb5ea6f@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f06017ce-1f0c-4917-4c70-08d9f094372f
X-MS-TrafficTypeDiagnostic: MW4PR02MB7348:EE_
X-Microsoft-Antispam-PRVS: <MW4PR02MB73482FEB1C333B8C5FC9850FC6349@MW4PR02MB7348.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiX35Fch8hae46E6SfWpNHtKvDlU7Ekl2qEVC4NYpPXgF5scdytAk0X4CTct2UkERq4sV2hV+xBCagyeetWSTynec8eCUFV7ByycIAXth5Fa3riCltfD/uBY3xdMIe1zj9LTgBgcz+9Lppl1HIl0nmS7CiIbSOPsKZjcdQZuIeDsLnENaJE43oFmfI6IASQscUHIuJnsPnPk+IQXynch5JcVK0HbqJMzR9KBvJ73Lx2ZZ2Ctpdt9QHIb6aVocVwz/aec2pBozeiaDdsRGswc48hCG5MoOTWKuqsj3uoIH15fjEMGNWdceexjGi2KutF37nmHlIzWJ2y1U33xHW2apelJquewWE8v9Ci+iLtxAmnTo8jIjeC7finSbhq2Y6dayIi9BvaUQyVAEZeK3vEy2AZy0l3o1FR8Kecqn/m4NHJB6Su+3WSwXakw5XWnuFosYohrFcAM8MqukmnwKGtCXdgVALttsSe19SWzyBjotHUPcRlZp6wnqDtoA2s+H+QbafjJbKbghskc7BANoBf6ikjj896CuxRTFcbYzwCRRBX7mgn3NvJeZ4G5wNNCEeKRolZvePdh4tQ7xi5bfDywo6H4kCHlSq+kqTwzsX7WVQwIs5xrabkbBMbvFVpPM1oKVoCrRaivKi4IVdJdbpoDOCSi6/XNW4S9/sKfD+gLCiFaQqmAvzknL2JPYMYUYuh/thmaYW0gTSKgVOIzij/b7FMIjP3GPV7LtQ6is4jOjLdIjXIZmbXEx1I1LDMK24qKiz0JW1xeS5yTHm5GIGiig5q0jHJ2F91YlkEIVMooyAm/QSdEKDz7U9RTFB8ZbwLkqVqZgrh1QSzwuvYSrSJUVDw/k2ezvyaQBQYvCWTS6e4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(9786002)(31696002)(66574015)(8936002)(47076005)(36860700001)(31686004)(5660300002)(7416002)(336012)(83380400001)(426003)(53546011)(40460700003)(6666004)(36756003)(2906002)(508600001)(186003)(110136005)(44832011)(54906003)(70586007)(316002)(2616005)(8676002)(4326008)(966005)(82310400004)(356005)(70206006)(7636003)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:02:42.0371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06017ce-1f0c-4917-4c70-08d9f094372f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7348
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/22 15:57, Sean Anderson wrote:
> On 2/15/22 9:02 AM, Michal Simek wrote:
>>
>>
>> On 2/15/22 14:49, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> U-Boot uses environment variables for storing device setup data on
>>> flash. That data usually needs to be accessed by a bootloader, kernel
>>> and often user-space.
>>>
>>> This binding allows describing environment data location and its format
>>> clearly. In some/many cases it should be cleaner than hardcoding &
>>> duplicating that info in multiple places. Bootloader & kernel can share
>>> DTS and user-space can try reading it too or just have correct data
>>> exposed by a kernel.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 58 +++++++++++++++++++
>>>   MAINTAINERS                                   |  5 ++
>>>   2 files changed, 63 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml 
>>> b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>> new file mode 100644
>>> index 000000000000..a2b3a9b88eb8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>> @@ -0,0 +1,58 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: U-Boot environment variables
>>> +
>>> +description: |
>>> +  U-Boot uses environment variables to store device parameters and
>>> +  configuration. They may be used for booting process, setup or keeping end 
>>> user
>>> +  info.
>>> +
>>> +  Data is stored on flash in a U-Boot specific format (header and NUL separated
>>> +  key-value pairs).
>>> +
>>> +  This binding allows specifying data location and used format.
>>> +
>>> +maintainers:
>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>> +
>>> +allOf:
>>> +  - $ref: nvmem.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: A standalone env data block
>>> +        const: u-boot,env
>>> +      - description: Two redundant blocks with active one flagged
>>> +        const: u-boot,env-redundant-bool
>>> +      - description: Two redundant blocks with active having higher counter
>>> +        const: u-boot,env-redundant-count
>>
>> I am not convinced that this is the best way how to do it. Because in u-boot 
>> implementation you would have to enable MTD partitions to get there.
>> And the whole parsing will take a lot of time.
>>
>> I think the way how I think this can be handled is.
>>
>> # I don't think that discussion with Simon was finished.
>> But for example (chosen or firmware node)
>> chosen {
>>      u-boot {
>>          u-boot,env = <&qspi &part0>;
>>          u-boot,env-redundant = <&qspi &part1>;
>>          #or
>>          u-boot,env = <&qspi 0 40000>;
>>          u-boot,env-redundant = <&qspi 40000 40000>;
> 
> What about when the environment is on top of UBI?

I expect we should list all possible combinations and cover them here.

> 
>>          #or
>>          u-boot,env = <&mmc 0 0 10000>; #device/start/size - raw mode
>>          u-boot,env = <&mmc 0 1>; # device/partition - as file to FS
> 
> For emmc at least you will need another cell for the hardware partition.
> And of course, you can name the environment file whatever you want, so
> that needs to be recorded as well.
> 
> IMO to do this properly you'd need to have a property corresponding to
> each of the major configs in the env menu.

Agree 100%. I just wanted to share how I think this should be done.
At the end we should be able to describe any combination in generic way.

Thanks,
Michal

