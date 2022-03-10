Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789044D42CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbiCJIql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiCJIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:46:37 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539E4818A9;
        Thu, 10 Mar 2022 00:45:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhbrlXEOikJYBUhOI1HP04X5OvbAf9ekuDvL5AbKrI3/tq74nZ+X1AcJBXmDDdz9cdpicxekG2MbRTIkgRfy9MVPsC7mT9h4Ec8tUGm4SPtx00Snf0A6/Z0g1dfYvm3643QKoVDtkzZlhVhaCTXrgBYy9JKhkLJBMRggfew3IGlGHEjfzHw2FAwHe8gpgVrK7tNeMd8YsQ0/rYKKLk7iq+qJxZdmSbhNvm7B0h/2DdmZm+LfCMFcKUhJq8oPfyj2M04tFTFySwFytDB7M0o/VNdR7ldUisVLl69tJrvSjbn6Aoq6+DkYRdit5WJ380FKPGMvWMR4uir+dOoFY+DB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2pOusGBRcyQr04jAoQ0wKSV14qwT11IGNGvl1WChYQ=;
 b=V1xxj0JcWP44m3guM2hi9oXuc7KtMPEs2boOI92qj34qr6gzpXUaNk5Vf7m4tHIOb2ZyZBIKx1HcWN5R/5fIWLneLblBp7qXYfMOL3cju+PwAsLArNn3B0miLtgGXOnSWMtglP0yIlvhET3NhiJNcVZa1Ttq0DW8gcFxRgYDP3BKYIME4yHNvfjffPELUcMWCzlewvRan8mvD/mmPy1hoaFQQF+PTmA9xG/0ZJtw0JnPH4Qfw5MyFkRiej6wLhZzZS1b1kR+ArdreQlBmFsRmTBbBxksIol4u4zkFl/VZh9kC8VEeYVXIR7MKfzqYgj42qR6ezAf7jc5FJtHxkkcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2pOusGBRcyQr04jAoQ0wKSV14qwT11IGNGvl1WChYQ=;
 b=SGqUrITblaKSeF3UyHefAfaqiCWaAncI23ypbaoRH8+1jjFgEBZBdOUVBk3RB2ZUG8S/TCfig9SM1xr5OzhzJU231EK08Lsrz0DemRpqnsL+KtxmpsnGvNgaz/IrHaticF7xjWlpbjOjdZz0yhivHmlv3oww+Nprnp8j+mEtbbg=
Received: from SN4PR0201CA0043.namprd02.prod.outlook.com
 (2603:10b6:803:2e::29) by BL3PR02MB7908.namprd02.prod.outlook.com
 (2603:10b6:208:353::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 08:45:33 +0000
Received: from SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::7) by SN4PR0201CA0043.outlook.office365.com
 (2603:10b6:803:2e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Thu, 10 Mar 2022 08:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0023.mail.protection.outlook.com (10.97.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 08:45:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Mar 2022 00:45:31 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Mar 2022 00:45:31 -0800
Envelope-to: robh@kernel.org,
 zajec5@gmail.com,
 trini@konsulko.com,
 sjg@chromium.org,
 srinivas.kandagatla@linaro.org,
 krzysztof.kozlowski@canonical.com,
 ricardo@foundries.io,
 jorge@foundries.io,
 seanga2@gmail.com,
 devicetree@vger.kernel.org,
 u-boot@lists.denx.de,
 linux-kernel@vger.kernel.org,
 rafal@milecki.pl
Received: from [10.254.241.50] (port=52888)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nSEQN-0008b5-9M; Thu, 10 Mar 2022 00:45:31 -0800
Message-ID: <9e340aaf-8d26-24fb-7097-9bcce63ea07e@xilinx.com>
Date:   Thu, 10 Mar 2022 09:45:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>,
        <devicetree@vger.kernel.org>, <u-boot@lists.denx.de>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220228131250.16943-1-zajec5@gmail.com>
 <578e243d-2273-add3-898c-959888c2a155@xilinx.com>
 <20220309154041.GA3202199@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220309154041.GA3202199@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b4d4bcb-08c2-433d-048f-08da027256b2
X-MS-TrafficTypeDiagnostic: BL3PR02MB7908:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB7908303140A522DE3F6C5D0AC60B9@BL3PR02MB7908.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pE0ev1jGBE+WBHB/fhm+fdBSY0n0/yJvX0yVbW3H7ob2gm5trNNUTvIZOp1VC0pYggMl/M2AbXs288qbrjm8jj6GfRk3ukzFcYryOW8pi0qUARNv5PxpAlZyXwQik4tDLoMT4+4H5ePwc6HgCfGD5H4kiScngnXKMmsuqRkJkmL2Gl+ihbVBtQmj9g0Yi314sPua/VCrvAqetPDqSfPL/NI0XGmBeDHVcCvYBi+cqb2RIeoxvA9yA94aeepZTtH9GUhXgPbiCvoy7mHQvf7Xv9xNJZdRROga60UHYa2NZJB6dtu3VuXxrtFPafC6KpsgH3yfOtznhEIFsD58ounSL2xGt+qKzcCclZVtFzMoC6/ZL6u4UlCWNHoWCka5HdIyvSj74LuJC7BXf8r3G6f49JAVAbVnPFTNYONR1XINKwSO7tR9h1QYsiXTP7JBNfACsH6ld+Y9jso+2oQ6dErS3PgGrVQqE2VP0Cr+eUJszqwn//LV4pCbY+2j3OnBbcFQOJYHfRk6p8OZZT330JNnVLlM8b8jvncUbD85Bgb8iRXpjGCPXnKFzYYvlD77VLbDvJVee1WxYYwHGtVwNE+32k9ZsT0w2iyocwVGoKxM3uwh2kNIx7A5oi+v6ZP/hV1fc2CpYp+jn705RDkf0zLRgO7wVCOZsI/oiPbu1LCwZePvLlYcjx3oC/1dSpL/sMhfBUe9o6xguDQy0W8IeOlilv3PVk4B29SJOjr5O7gXsjFCc3pxzlRQccVgYN46fpICu6wyry/WcoOIiQNfjEt0D1neY3jXvfhh2gna+48Z9BY/ui1nwGrpjSiJxsLshD8En1gA4tIp4eNmwELgtkx96jCQyGYMjQexU9EDFk8LzI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(36756003)(336012)(66574015)(70206006)(356005)(31686004)(426003)(4326008)(53546011)(9786002)(7636003)(5660300002)(7416002)(6666004)(44832011)(186003)(2616005)(26005)(8676002)(70586007)(8936002)(36860700001)(110136005)(508600001)(316002)(966005)(54906003)(83380400001)(82310400004)(31696002)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:45:32.9599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4d4bcb-08c2-433d-048f-08da027256b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7908
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/22 16:40, Rob Herring wrote:
> On Wed, Mar 09, 2022 at 02:42:43PM +0100, Michal Simek wrote:
>>
>>
>> On 2/28/22 14:12, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> U-Boot uses environment variables for storing device setup data. It
>>> usually needs to be accessed by a bootloader, kernel and often
>>> user-space.
>>>
>>> This binding allows describing environment data located in a raw flash
>>> partition. It's treated as NVMEM device and can be reused later for
>>> other storage devices.
>>>
>>> Using DT should be cleaner than hardcoding & duplicating such info in
>>> multiple places. Bootloader & kernel can share DTS and user-space can
>>> try reading it too or just have correct data exposed by a kernel.
>>>
>>> A custom "compatible" string allows system to automatically load
>>> relevant NVMEM driver but phandle can be also used for reading raw
>>> location.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>> V2: Update descriptions to don't make this binding MTD (flash partition)
>>>       specific. Mention multiple possible storage ways.
>>> V3: Drop
>>>       allOf:
>>>         - $ref: nvmem.yaml#
>>>       as we don't use anything rom the nvmem.yaml. Thanks Rob.
>>> ---
>>>    .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
>>>    MAINTAINERS                                   |  5 ++
>>>    2 files changed, 67 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>> new file mode 100644
>>> index 000000000000..e70b2a60cb9a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>> @@ -0,0 +1,62 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: U-Boot environment variables
>>> +
>>> +description: |
>>> +  U-Boot uses environment variables to store device parameters and
>>> +  configuration. They may be used for booting process, setup or keeping end user
>>> +  info.
>>> +
>>> +  Data is stored using U-Boot specific formats (variant specific header and NUL
>>> +  separated key-value pairs).
>>> +
>>> +  Environment data can be stored on various storage entities, e.g.:
>>> +  1. Raw flash partition
>>> +  2. UBI volume
>>> +
>>> +  This binding allows marking storage device (as containing env data) and
>>> +  specifying used format.
>>> +
>>> +  Right now only flash partition case is covered but it may be extended to e.g.
>>> +  UBI volumes in the future.
>>> +
>>> +maintainers:
>>> +  - Rafał Miłecki <rafal@milecki.pl>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: A standalone env data block
>>> +        const: u-boot,env
>>> +      - description: Two redundant blocks with active one flagged
>>> +        const: u-boot,env-redundant-bool
>>> +      - description: Two redundant blocks with active having higher counter
>>> +        const: u-boot,env-redundant-count
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    partitions {
>>> +        compatible = "fixed-partitions";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        partition@0 {
>>> +            reg = <0x0 0x40000>;
>>> +            label = "u-boot";
>>> +            read-only;
>>> +        };
>>> +
>>> +        env: partition@40000 {
>>> +            compatible = "u-boot,env";
>>> +            reg = <0x40000 0x10000>;
>>> +        };
>>> +    };
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index db8052bc1d26..24fc181a7e6c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -19958,6 +19958,11 @@ W:	http://linuxtv.org
>>>    T:	git git://linuxtv.org/media_tree.git
>>>    F:	drivers/media/pci/tw686x/
>>> +U-BOOT ENVIRONMENT VARIABLES
>>> +M:	Rafał Miłecki <rafal@milecki.pl>
>>> +S:	Maintained
>>> +F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
>>> +
>>>    UACCE ACCELERATOR FRAMEWORK
>>>    M:	Zhangfei Gao <zhangfei.gao@linaro.org>
>>>    M:	Zhou Wang <wangzhou1@hisilicon.com>
>>
>> I think that parsing these partitions is quite sw intensive process and I
>> can't still see the value to have compatible string here.
> 
> It's always good to know what a node represents.

Also agree but isn't it enough to use proper label for it?

> 
>> I would prefer to have just any link from u-boot node to partition instead.
> 
> That's a separate issue and having 'compatible' in no way disallows
> that.

Agree on this one.

Thanks,
Michal
