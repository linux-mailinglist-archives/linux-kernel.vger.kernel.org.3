Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBCB4BEF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiBVB6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:58:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiBVB6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:58:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502536572;
        Mon, 21 Feb 2022 17:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Em4G8cPsBPSOGLEHZ+mr/EuKHq+3nSrxlvL4ayNunTmZZm0MZChV8592qEwrvREu5Lrpzx2f5dJPAICiEsz9OwRx2BVak5n76WdXKxGD+cmXgkgmNOKVqAbMkXaEVx4/qnLyo30EZm4pG/HdikjGP8n4DAL8pfovIk3jmik+Xk73UMtozN1qCqcFqxeDtItid/fmAAKKZ+gwrj1/naMUMxKaQo81RRHGO5WsolyNeHxPqlC32+xO6ZXOgvZFAMlapVEjLxkJElZVCGuaL1+/VeasUfm2LdKirFuQ3zouARVOIUV6t4I38y3cU8dLes1qIUTxL5RUXpQz0O4ArVzVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucq4nxerr9I2LfkmLLtSZ+X/x9U/t/3BnqQBupnqXPk=;
 b=LaoBB1Rl1LQqIr7s1akliZlLvw285z6mzGfqKfvUHqQI+0ZWx4er0mii4gHKASmcNa90w907P9n92gX4fxd7jqyN36//wY/OHZCRQKAAri458pSf2OBjZUbrpv6PKYqdp95dnGcPhm3FvXixC3//W9Lrlt/wNLL72bnWtDLznMkH43Isp7/+e/6+Feb6GCBw9MunpzU9keQga2Mq59Lx+E11ZcOkx6fIJ+6E7JgFh1jaWoi+OZ/01HaRlzx0bX0x2wIYR7lvlBj+A6BjmFJ1n1YLpbNKzc311pdyb0nEMKQ8bZE+7dT7VFm/NBUrkVOX53zTW4FJ/Mw9sJLfs8VT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucq4nxerr9I2LfkmLLtSZ+X/x9U/t/3BnqQBupnqXPk=;
 b=JukdzIPO+bYdq88ZEJGY1Y1PplbPLWA5ENhOD3MqyT9H0nUeM5z77H8HL7lrIkOI4HZdlTfNaYagkam1TGMybVrZ2SXC3tJOZgWhb3Pli/W3tewmn/ZW35dU3/p+ypGuRY5rdvXrCoqObXGg4ZQFGbHO5keaLhQ0ZIqptUGCSdc=
Received: from SA9PR10CA0007.namprd10.prod.outlook.com (2603:10b6:806:a7::12)
 by CY4PR02MB3160.namprd02.prod.outlook.com (2603:10b6:910:77::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Tue, 22 Feb
 2022 01:58:21 +0000
Received: from SN1NAM02FT0046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::eb) by SA9PR10CA0007.outlook.office365.com
 (2603:10b6:806:a7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 22 Feb 2022 01:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0046.mail.protection.outlook.com (10.97.5.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 22 Feb 2022 01:58:20 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Feb 2022 01:58:19 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Feb 2022 01:58:18 +0000
Envelope-to: michal.simek@xilinx.com,
 ben.levinsky@xilinx.com,
 sergei.korneichuk@xilinx.com,
 arun.balaji.kannan@xilinx.com,
 mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.71.118.67] (port=49662)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nMKRW-0008PN-GL; Tue, 22 Feb 2022 01:58:18 +0000
Message-ID: <f383cd27-9757-7b56-4ebc-1227b28f51f7@xilinx.com>
Date:   Mon, 21 Feb 2022 17:58:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
From:   Tanmay Shah <tanmay.shah@xilinx.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <laurent.pinchart@ideasonboard.com>,
        <ben.levinsky@xilinx.com>, <bill.mills@linaro.org>,
        <sergei.korneichuk@xilinx.com>, <arun.balaji.kannan@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
 <20220210112824.2084724-2-tanmay.shah@xilinx.com>
 <20220214182208.GA101373@p14s>
Content-Language: en-US
In-Reply-To: <20220214182208.GA101373@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4165f59b-0894-4522-1200-08d9f5a6cd44
X-MS-TrafficTypeDiagnostic: CY4PR02MB3160:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB3160F90B5DB55191B21F54D5CA3B9@CY4PR02MB3160.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJggaTUgTfBwEXKLhuUwVBmXWZiPOdc0/Y1Co9VdYPx8hzrhgl5TzLGJt9IH+3XqxynMQDQ7bv3XC2SdtkeZY5eu0VxhDj/kjnMKHft9+yMEvkOrMmDlKCBGdFZJJQy4BYVepW4DkL1hukpFsdVQaOOsy1WKO140Vpom2DSSAFNDZSEVPL39LXaB+/X0hXcqEmYf22RYoOt3w+zI1p+JWboNgg4dYLV9JVI+D1/yW08nqudNvjzqdbkm26xYDXlfpXO8/KqNOduGSitw0cBM/u4zWkboA/LgRMYBHdN0n8NyOAV8vyq3k3ylpjA7+6FGdbNoQqwWGQftQy53DObp1TMoDidaAtYEl+KmIOEmYyofW46naonEk4krb6rbRbX6Np61BTmzwgt5OMbRqE1yl1y7bQHTblFmbuO71Od9fCvkIODq14o6vzbq7Q+jGNBXMl9yVtYg84LZBeBa8CStx3COArTGGO6wxEEtGJpCO93Ye0PV4zHyo5TMYkMmm1wEqWEMONxEoMpaZG5ge3LIUSkh6QgpVtJwjOnU6cHj/gJLTNT0fg1+Ig++RdXcqxlpFRY+z/M9x9N8ONpD6I8LMRzWUqUKGBhrVV+RI9qd421L/bIB5omnIlndT9RiDcDG9pHAzTs6QQEUEh4+n7r7hL9eImiCHZxwmWfUeoD3KhiZ0tKbtLNY9qKKBKoMdkH1AXdtW/y38CKsaxKkN3UXTgXRe/FmaNL0S4NTLhPNASKktP9clLy6l3gn1jE8XxGljSzXadKG2oPnhWuHHw6g2oBwEk0MuEeWtJGXu88ZZM8Iycv3ImVPqWXnnW4IA3VYJnVM+a6YeZEqOQ51ULMqo68v6vGn/DoMr/25P9rTgrw=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch01.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(82310400004)(70206006)(70586007)(83380400001)(8676002)(508600001)(6916009)(316002)(54906003)(336012)(426003)(31696002)(8936002)(9786002)(5660300002)(2616005)(53546011)(2906002)(6666004)(356005)(47076005)(36756003)(40460700003)(26005)(7636003)(186003)(36860700001)(31686004)(44832011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 01:58:20.4146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4165f59b-0894-4522-1200-08d9f5a6cd44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3160
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

Thanks for reviews.

Please find my comments below.

On 2/14/22 10:22 AM, Mathieu Poirier wrote:
> On Thu, Feb 10, 2022 at 03:28:19AM -0800, Tanmay Shah wrote:
>> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem (cluster).
>>
>> Signed-off-by: Tanmay Shah<tanmay.shah@xilinx.com>
>> ---
>>
>> Changes in v3:
>>    - None
>>
>>   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 139 ++++++++++++++++++
>>   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>>   2 files changed, 145 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>> new file mode 100644
>> index 000000000000..d43f0b16ad7f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>> @@ -0,0 +1,139 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx R5F processor subsystem
>> +
>> +maintainers:
>> +  - Ben Levinsky<ben.levinsky@xilinx.com>
>> +  - Tanmay Shah<tanmay.shah@xilinx.com>
>> +
>> +description: |
>> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
>> +  real-time processing based on the Cortex-R5F processor core from ARM.
>> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
>> +  floating-point unit that implements the Arm VFPv3 instruction set.
>> +
>> +properties:
>> +  compatible:
>> +    const: xlnx,zynqmp-r5fss
>> +
>> +  xlnx,cluster-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
>> +      lock-step mode(Both RPU cores execute the same code in lock-step,
>> +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
>> +      core 1 runs normally). The processor does not support dynamic configuration.
>> +      Switching between modes is only permitted immediately after a processor reset.
>> +      If set to  1 then lockstep mode and if 0 then split mode.
>> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  reg:
>> +    items:
>> +      - description: RPU subsystem status and control registers
>> +
>> +patternProperties:
>> +  "^r5f-[a-f0-9]+$":
>> +    type: object
>> +    description: |
>> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
>> +      Each processor includes separate L1 instruction and data caches and
>> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
>> +      memory space is non-cacheable.
>> +
>> +      Each RPU contains one 64KB memory and two 32KB memories that
>> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
>> +      per processor. In lock-step mode, the processor has access to 256KB of
>> +      TCM memory.
>> +
>> +    properties:
>> +      compatible:
>> +        const: xlnx,zynqmp-r5f
>> +
>> +      power-domains:
>> +        description: |
>> +          phandle to a PM domain provider node and an args specifier containing
>> +          the r5f0 and r5f1 node id value.
>> +
>> +      reg:
>> +        items:
>> +          - description: RPU0 and RPU1 control and status registers
>> +
>> +      mboxes:
>> +        items:
>> +          - description: |
>> +              Bi-directional channel to send data to RPU and receive ack from RPU.
>> +              Request and response message buffers are available and each buffer is 32 bytes.
>> +          - description: |
>> +              Bi-directional channel to receive data from RPU and send ack from RPU.
>> +              Request and response message buffers are available and each buffer is 32 bytes.
>> +        minItems: 1
>> +
>> +      mbox-names:
>> +        items:
>> +          - const: tx
>> +          - const: rx
>> +        minItems: 1
>> +
>> +      sram:
>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        minItems: 1
>> +        description: |
>> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
>> +          the RPU can execute instructions and access data from, the OCM memory,
>> +          the main DDR memory, and other system memories.
>> +
>> +          The regions should be defined as child nodes of the respective SRAM
>> +          node, and should be defined as per the generic bindings in,
>> +          Documentation/devicetree/bindings/sram/sram.yaml
>> +
>> +      memory-region:
>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        description: |
>> +          List of phandles to the reserved memory regions associated with the
>> +          remoteproc device. This is variable and describes the memories shared with
>> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
>> +          vrings, ...). This reserved memory region will be allocated on DDR memory.
>> +          See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>>
> Aside from "compatible" and "power-domains", none of the above properties appear
> in the example below, making this patchset harder to review.
>
> I am pretty sure to have commented on this earlier...

In example, I have included only required property nodes.

If you want, I can include other properties as well. However, some of 
the properties needs new bindings for example "sram".

So, I can't include it as I don't know how bindings for them will look like.

In next revision, I can include mboxes, mbox-names and memory-region 
properties. Is that fine?

Also, should I add those nodes in actual device-tree now or later?

For example, mboxes and mbox-names are not needed for driver as of now.

So should I include them in dts now or later when I send rpmsg related 
patches?

> More comments to come later or tomorrow.
>
> Thanks,
> Mathieu
>
>> +    required:
>> +      - compatible
>> +      - power-domains
>> +
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    r5fss: r5fss@ff9a0000 {
>> +        compatible = "xlnx,zynqmp-r5fss";
>> +        xlnx,cluster-mode = <1>;
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        reg = <0xff9a0000 0x228>;
>> +
>> +        r5f-0 {
>> +            compatible = "xlnx,zynqmp-r5f";
>> +            power-domains = <&zynqmp_firmware 0x7>;
>> +        };
>> +
>> +        r5f-1 {
>> +            compatible = "xlnx,zynqmp-r5f";
>> +            power-domains = <&zynqmp_firmware 0x8>;
>> +        };
>> +    };
>> +...
>> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
>> index 0d9a412fd5e0..618024cbb20d 100644
>> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
>> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
>> @@ -6,6 +6,12 @@
>>   #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>>   #define _DT_BINDINGS_ZYNQMP_POWER_H
>>   
>> +#define		PD_RPU_0	7
>> +#define		PD_RPU_1	8
>> +#define		PD_R5_0_ATCM	15
>> +#define		PD_R5_0_BTCM	16
>> +#define		PD_R5_1_ATCM	17
>> +#define		PD_R5_1_BTCM	18
>>   #define		PD_USB_0	22
>>   #define		PD_USB_1	23
>>   #define		PD_TTC_0	24
>> -- 
>> 2.25.1
>>
