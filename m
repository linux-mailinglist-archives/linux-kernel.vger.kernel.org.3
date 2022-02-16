Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4984B8B61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiBPOYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:24:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiBPOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:24:48 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7E27F2AD;
        Wed, 16 Feb 2022 06:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4OvUmGymHyplHTBv9hF34WYTwxZJsi7BpDQBFjcmkWMoKDrUcThZhKnWDFgLJsIQd1yMEEP123+u4/JPKNuiXYDC0wq2J+AwFECrCmXxAmQauSbV8rLTxTcg5ZTVVgDdl4coUpy8iyCxJsqvt9/0ChEucpQfxTmPR3Myt4+LdRW3+tNfEPp4LbZk6ueNsex+pjMJtre2+WN1F0cgk+JPJkuBJ0U3SIUoIWk2t8sOl+ij2baH22XxiJ91hoX8JdQ70xw+EmwJ+023Cl9HkgblbcRPESNv5+sJvS7YurPsc/KQT+VQJgnYe3JCTsdBI/TkaWmdX0df1OIUW84q/TnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28h0wk8PDDzvjcCN/us+fBNcLyCPCMnzStWnUoSx3a0=;
 b=HWTpFSPtJgz3zmF9cD3TrxfgQgNNpoeEzVqd19yUFRqQ4bRmRXk9Dv0eiHpzlPp2XP1PmwqP2Qx6xmHJgytE0cWXBI66agiSvYG+JBxc1/lUoeenmkLvQfQwEBiHpw5rxwACr9mSwUSJg0BY/hInCPjt757DH2Zbe8uANKcybyAiq0QJ8SefBXGYC5GH4N6wVHBr7dgVHCs8xlICV9UgMJPvwxiMU9TbqpBVkBO4oS3BfnCi+hJLgMkK3fSDFBugouAZw6XhK7X43uMHgVXN9Jdkh+d5BhA1bgmVUoKPdlJ8mcD0cSi53xf4OK1XU52VJoi+cAQ9zii6/Iqaiy5O2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28h0wk8PDDzvjcCN/us+fBNcLyCPCMnzStWnUoSx3a0=;
 b=Fgoyn/RfONhqIdpURpnXtuG+bmI2lfSx0KUO0HkVqSdyApjpKtrI9tTDoAOQsYnz1Z9F+9rFXljl3BNhYOZ+WcDV41BDL0bm4+S+8mxC54dN4eoCjjwh8hgZBsY6Hh0l0yx57yXs/00DPN/PGQ+V/BYhxxMYBBmxfax/MtWGcl4=
Received: from DM5PR07CA0059.namprd07.prod.outlook.com (2603:10b6:4:ad::24) by
 CO6PR02MB7699.namprd02.prod.outlook.com (2603:10b6:303:a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Wed, 16 Feb 2022 14:24:33 +0000
Received: from DM3NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::71) by DM5PR07CA0059.outlook.office365.com
 (2603:10b6:4:ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Wed, 16 Feb 2022 14:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT039.mail.protection.outlook.com (10.13.5.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 14:24:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 16 Feb 2022 06:24:31 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 16 Feb 2022 06:24:31 -0800
Envelope-to: zajec5@gmail.com,
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
Received: from [10.254.241.49] (port=59198)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nKLEN-0005LY-Bx; Wed, 16 Feb 2022 06:24:31 -0800
Message-ID: <e312dca4-0187-d3fb-505e-2b370ea7cb93@xilinx.com>
Date:   Wed, 16 Feb 2022 15:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: nvmem: add U-Boot environment variables
 binding
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
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
 <a3230dfd-f04d-a6b1-a2cf-87fd3621c295@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <a3230dfd-f04d-a6b1-a2cf-87fd3621c295@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a72579-e021-4f9d-6f84-08d9f1580d63
X-MS-TrafficTypeDiagnostic: CO6PR02MB7699:EE_
X-Microsoft-Antispam-PRVS: <CO6PR02MB76991FA30D9815919803DB0EC6359@CO6PR02MB7699.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T45JSgwN2uWvqVrFtBUSbIsvIX7jSxTS/eHjr6I/TE53iMmiArnAiJyKJlWDaDbk+5kTzLuNJpMbZ9DxlhRvBwtqzIj6YANWAaQHiwaGZzaMSAftJLqFbT0l/OzlT5P0AYkmOYcOgw2ToxxqOH7u2fbt+oD45iZ1D/lDIizsP8G9LHeq/YE1sJ3nMlR3ZKcY9EVbsUlR2jJYq9ojDtxffIVR13+BD26htUGBg3FZq1EZ3oyuyM1QRLmh07ibI2Wj/IbbRzoqOB0N6v1w8/Ew4hP4pzyqhGeEJ/3g8MpRA7x9qKCCHDMuWIn0dhNibIOeUD7MwCcJEoAS37ci6zWDl5pPWs9vRSzIunMV9sZJCLfTRIpiC0Hm5aJgr/AO7XWj8VUN4l7AZoNfNcqCEUXLE3g60kBeyJTkjytqVq5f2OAvWBY4Mu5ip0Pk61pRudyT5Jz3ICbznOozviMesEPhxlKJ9qT2ecNH7iZ9hC91EPHJW7BgzSfBxqWoyZv77AHgTPPB9dtWH+m0DtMd4ToYyksWUMMMF+ryE0zhc7cO+rTYZSKWZBurhj3Z8r6eA5vqtpysHETDIdbf3VLelvNiEGZ45LV3GDBX03QunprMntPeELmSdw4C8iucrT0I1+l42lthfF8SDRhhN7SVFuQFn35AtWbNeWyhlzCaSRCmSUjm9XBcCMIfwhCoFESXAz6BK7EOAZaOWioFKbYLa2Wm1vad9qloZin1J0uK9VJOWODZ0VyNyVqyh5ZqIj5eCh3FIjZl6MsMAAcpB6pFGdVOkvg1T757KOSL/Ph67E3z1oO6vvHvywrMHy1VtSOj/svo9d2fTiGzSOtyM+AxPNNAOZV6MIdLsW0cpolmNxf1Yto=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(4326008)(47076005)(8676002)(44832011)(8936002)(9786002)(2616005)(70206006)(7636003)(356005)(82310400004)(110136005)(508600001)(54906003)(70586007)(31696002)(31686004)(6666004)(83380400001)(40460700003)(26005)(186003)(2906002)(426003)(53546011)(336012)(966005)(66574015)(7416002)(5660300002)(36756003)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 14:24:33.2734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a72579-e021-4f9d-6f84-08d9f1580d63
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7699
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/22 13:54, Rafał Miłecki wrote:
> On 15.02.2022 15:02, Michal Simek wrote:
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
> 
> We'll need to find some consensus considering all points:
> 1. DT objectives
> 2. U-Boot needs
> 3. Linux needs
> 
> DT should mainly describe hardware / platform without focusing on a
> single implementation details. If U-Boot env data is indeed stored in a
> flash block (or blocks) / UBI volume, its binding should be just that.
> 
> If U-Boot requires MTD to parse proposed binding and it can't be
> afforded at the same time - maybe it can come with different
> implementation?

I am ok to even say if you want to use this description you should have some 
options enabled.

> 
> 
>> I think the way how I think this can be handled is.
> 
> One minor note: I don't think you can have one "standard" format and one
> "redundant" format. If env data is stored in two places - both use the
> redundant format.

What you have below is fine for me. I am just saying that it should be pretty 
much generic and description should be able to cover all configurations.

Another thing what came to my mind was that with the same description should be 
possible to describe for u-boot for example where boot scripts are placed in 
qspi which can be different based on spi size.

> 
> 
>> # I don't think that discussion with Simon was finished.
>> But for example (chosen or firmware node)
>> chosen {
>>      u-boot {
>>          u-boot,env = <&qspi &part0>;
>>          u-boot,env-redundant = <&qspi &part1>;
> 
> 1. Using &qspi seems reundant here, you can get parent flash device by
>     walking DT.

correct but on the other hand code should be able to do it in a easy way. If 
this is easy to implement just remove it.

> 2. Using "chosen" seems to be a /shortcut/ for getting env data
>     location, I don't see any direct conflict with using "compatible"
>     string as proposed in my binding.

If compatible string should be added there then you need to maintain it.
Also if this is purely based on compatible string only then you need to parse 
all nodes to find out where it is.
Having fixed location in any node will give you this information without need to 
parse a lot of data via DT.
And not sure when exactly in u-boot this is needed that you would have to avoid 
to use u-boot,pre-reloc flags to get to it.

> 
> 
>>          #or
>>          u-boot,env = <&qspi 0 40000>;
>>          u-boot,env-redundant = <&qspi 40000 40000>;
> 
> Here you moved code describing partition from "partitions" into "chosen"
> which seems incorrect to me. We already have bindings for partitions and
> they should be children of flash node.

For flashes yes. For SD/EMMC/SATA?

> 
> 
>>          #or
>>          u-boot,env = <&mmc 0 0 10000>; #device/start/size - raw mode
>>          u-boot,env = <&mmc 0 1>; # device/partition - as file to FS
>>          #etc.
>>      };
>> };
>>
>>
>> &qspi {
>>      flash {
>>          partitions {
>>              compatible = "fixed-partitions";
>>              #address-cells = <1>;
>>              #size-cells = <1>;
>>
>>              part0: partition@0 {
>>                  label = "u-boot-env";
>>                  reg = <0x0 0x40000>;
>>              };
>>
>>              part1: partition@40000 {
>>                  label = "u-boot-env-redundant";
>>                  reg = <0x40000 0x10000>;
>>              };
>>      };
>> };
> 
> So my summary for this would be:
> 1. Let's use partitions for placing env data partition binding
> 2. Let's add minimal U-Boot setup into "chosen" if needed
> 
> Please consider this:
> 
> chosen {
>      u-boot {
>          u-boot,env = <&env0>, <&env1>;

I am fine with this description. But you need to come up with description for 
SDs where it can be filesystem based or RAW. And you don't have partition 
description as you have for spis, nand, nors, eeproms.

>      };
> };
> 
> &qspi {
>      flash {
>          partitions {
>          compatible = "fixed-partitions";
>          #address-cells = <1>;
>          #size-cells = <1>;
> 
>          env0: partition@0 {
>              label = "u-boot-env";
>              reg = <0x0 0x40000>;
>          };
> 
>          env1: partition@40000 {
>              label = "u-boot-env-redundant";
>              reg = <0x40000 0x10000>;
>          };
>      };
> };
> 
> If you still need to access flash content directly, you can pretty
> easily calculate offset from &env0 and &env1 nodes.

No doubt about it. But then you are forcing everybody to define partition 
definition. I am fine with it but hopefully it won't be problem for others.

I am just trying to get to the point that dt binding which we are going to use 
will be universal across SOCs and we can use the same description for other 
purpose. Environment is one of them, another can be boot script 
addresses/location, A/B update location, etc.

Thanks,
Michal
