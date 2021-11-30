Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0184630F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhK3K1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:27:05 -0500
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:45409
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbhK3K1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:27:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esIP2KV8y4rv8hnL5Ftk9mWG5vmkV6XIhe5VHTI8eExQ4UgbdUTrtYDsRYwayI5qgSCl9HXTO46Vl5qz8sdQzyosfQxYyMhrAZwgVWJe1S2AvzPhCdvNQLv8gLK374zRZ/SnI1zrkcWznJIjN9oyVOjoDMAq0tWtweMff676UR2ZJwB5/nwI2wY3YttuJpMAcl0mgr5C8jSfbDErG10462LmL3m0mdKvG1Ocfmm3DfJTo/hEVLi/vdDR273vGkkIlw51S1h3qodFlICdZxiBWsAJpnLndPIxD661RS/XZ3KjDfd9HYDANhFipy5kzqJmZRzu8pFXRragv/TKCSwDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnbwTVOVhE5W1TEc6l1zmme6aExLNXbUWXSiKH41bx0=;
 b=kJ2PDzgutjlJck/V4IAJqNpf8WUkgaLOM3zvJWgVlpYxzGxh9q5rEVl75ppDh3v/L5nM/wmGV3V6hJ6Kb/CMpQBXN/MgHoatVfBgCq2CvF4pJV0ZdeaCsAqAS6xFtLefpF5PlctozcG0+JZI8QohPfF8WZcTH217t+C3Y065Yr7ISLYbDdghPyTPs3hlVXNuLsIkcWQ9Hq+3UF/W6RYPVwRpCf9w0B0HnMLkC+ci4/MTmUzNnV3epRSkH+/I9Ug5cECUvvgX3hibc++zlWqoI4hnqfCQq6LqMnoZ6WCK6Wlp76NDt8hjLaHcuCsIavxlpD0GWmPotGxwW+3rg3xALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnbwTVOVhE5W1TEc6l1zmme6aExLNXbUWXSiKH41bx0=;
 b=r5ouEJhN4+TbBBMiSa0pnokj0jfJ0RWYy9g5gmqd2PKpw5fEljKKpci8pCjYhxzOZYovWCsxLK9WSewc6J8a8C+SAC9DjNXuC5Gwm6fXPmofq1knPZaNhdfvUD7SFxa2/hlxSMRtTWFUKRLW0JzrjPtM4X+VxQDtMlTIEnjMKIU=
Received: from SA0PR11CA0078.namprd11.prod.outlook.com (2603:10b6:806:d2::23)
 by DM5PR02MB3734.namprd02.prod.outlook.com (2603:10b6:4:b7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:23:43 +0000
Received: from SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::4f) by SA0PR11CA0078.outlook.office365.com
 (2603:10b6:806:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 10:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0021.mail.protection.outlook.com (10.97.5.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 10:23:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 02:23:41 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 02:23:41 -0800
Envelope-to: git@xilinx.com,
 robh@kernel.org,
 gregkh@linuxfoundation.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.254.241.49] (port=34458)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ms0IX-000Ghp-9s; Tue, 30 Nov 2021 02:23:41 -0800
Message-ID: <34c82598-68c9-26e2-6ba6-683b81ec5ccd@xilinx.com>
Date:   Tue, 30 Nov 2021 11:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 1/2] dt-bindings: usb: misc: Add binding for Microchip
 usb2244 Controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>
CC:     <gregkh@linuxfoundation.org>, <mka@chromium.org>,
        <ravisadineni@chromium.org>, <stern@rowland.harvard.edu>,
        <alcooperx@gmail.com>, <michal.simek@xilinx.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sgoud@xilinx.com>
References: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
 <20211122062834.1812005-2-piyush.mehta@xilinx.com>
 <YaWIafw+XB8tknpJ@robh.at.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YaWIafw+XB8tknpJ@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a644f4b-4a54-4565-85db-08d9b3eb7c14
X-MS-TrafficTypeDiagnostic: DM5PR02MB3734:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3734E7808044CFBCD4E61B13C6679@DM5PR02MB3734.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ue9UwEiFmvMvTzdFIpSEsAtl1aj4MSxu3/R/gxPLdILPjlgPh+YdeD/5RZwAdwCo0ihL+fBlxsWB25zXEwoaw6YE5L5lQI9RyRUEDxZFWnZWTTsnrhBvHlhjvG813AR3M3hG2TpMGcMJpYyZP/pdMs+NKy1mTmxw8YKXBRa/fkj72EcNO7PiJdx0qiYzlAKTtdniAEtteeteKCNRU1hQKCQ8Z+YrjYC2A15FjVPFHwDFGxK6UUuZkcFX91LzfKaTJfIEG2I20hgN2Z0VRwoTIZnQdmwYF6yx/x9ot4osVpPId3vYCMFkheuZAdQFhTQjN/sJzLpLE2Z4Tbs0U0RNAzvwSj7AFq8wYluAKjTffXLeFSYwqVp0oYaL1IWCjML+q8/1HLTgIW0tH0oDMtYmjCZnVUGZxN6oRJqeNCW1p0r1cJkDj6rWCseQ3zmZpqtp6WjwazViVPk7R67ApQ8PGEWl199BdXNAobq3RLWB/yXyfAQqjNdwjefCkXcKU8n7T7i409Yexh8VnXrZHsDhzmpXkhGQ4MxIQfGG4wd7+San6cXg8PNTdW0U8l3XaisHlSlntdDc80le5xof+RjcTcil8CoB99rdmAyBCit8YL0nEARrEuzTceV5Kw+KKebN4ujuLxBHyuqw/av/jr5503IJdJLA5f+1/zB1o0Z5F/7B+zfEfEdCKmDOFaCPf8t8qsscJhNtsWYYJZ1gfVUTnhzYqstRmF4cTByB8w0YmO8ZuBGbyJ/nBeQrJd3G5yQV0sveRZujYUY6v1F2pdbdbT5bNITk6/N7qP7dVYpZxInMkjyft5Glg2W/VlWlg2xxzVuGAqIyMYLAZIz7ie0V2o1mAOUirX4LqGfVzHpojXDaCoUGpSCd10uRbG7ZB+W
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(107886003)(6636002)(44832011)(82310400004)(7636003)(508600001)(356005)(4326008)(47076005)(966005)(186003)(2616005)(26005)(426003)(5660300002)(70586007)(83380400001)(2906002)(36756003)(54906003)(31696002)(336012)(110136005)(36860700001)(70206006)(8936002)(316002)(53546011)(9786002)(6666004)(8676002)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:23:42.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a644f4b-4a54-4565-85db-08d9b3eb7c14
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3734
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/21 03:11, Rob Herring wrote:
> On Mon, Nov 22, 2021 at 11:58:33AM +0530, Piyush Mehta wrote:
>> Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controllers
>> provides an ultra-fast interface between a USB host controller and flash
>> media cards.
>>
>> Add dt-bindings documentation for Microchip's usb2244 Controller.
>> USB224x is a USB 2.0 compliant ultra fast USB 2.0 multi-format,
>> SD/MMC, and MS Flash Media Controllers.
>>
>> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
>> ---
>> Changes for V2:
>> - Update reset polarity, make reset ACTIVE LOW in the dt-binding document.
>> - Added usbsd node under the usb controller (usb0) node.
>> - Remove Warning: decoded text below may be mangled, UTF-8 assumed.
>>
>> Review comments:
>> Link: https://lore.kernel.org/lkml/CAL_JsqKu6vr3iCz1G7MtK6gyqAvn4s4mpuLOwPzJDEmyZeROig@mail.gmail.com/
>> ---
>>   .../devicetree/bindings/usb/microchip,usb2244.yaml | 47 ++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
>> new file mode 100644
>> index 0000000..1854313
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/usb/microchip,usb2244.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Bindings for the Microchip USB2244 Ultra Fast USB-SD Controller
>> +
>> +description:
>> +  Microchip USB224x is a USB 2.0 compliant, Hi-Speed bulk only mass
>> +  storage class peripheral controller intended for reading and writing
>> +  to popular flash media from the xDPicture Card, Memory Stick (MS),
>> +  Secure Digital (SD), and MultiMediaCard (MMC) families.
>> +
>> +  USB224x is a flash media card reader solution fully compliant with the
>> +  USB 2.0 specification.
>> +
>> +maintainers:
>> +  - Piyush Mehta <piyush.mehta@xilinx.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: microchip,usb2244
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      The phandle and specifier for the GPIO that controls the RESET line of
>> +      flash media controller.
>> +
>> +required:
>> +  - compatible
>> +  - reset-gpios
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    usb0 {
>> +        usbsd {
>> +            compatible = "microchip,usb2244";
>> +            reset-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
>> +        };
> 
> This is not how the USB device binding works. See usb-device.yaml.
> 

Is this fine?

device@1 {
     compatible = "usb424,2240";
     reg = <1>;
     reset-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
};

If yes, this means that we should use usb driver instead of platform driver.

Thanks,
Michal
