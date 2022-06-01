Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB953AE2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiFAUpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiFAUpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:45:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87E625C1E0;
        Wed,  1 Jun 2022 13:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW/GAZvB/j723v2f5jpNjfKlYWDNUGDeHt9ABIxVaGuTXuDWGa3qPY5cv8NUA3OLRe1kFl7ZVgE4KwBAp0TqixsimG9Z8+uL2DKfKFapZ9JPuhFeoq/q5EOwLclkmynfvnS4zDXlQPWQlySAk3bF41yuFi+ijA3YXQqRBzgBPIBaOOzGMLSQfUIf0DxTAsiC9NwdKScQAE7MFXUauFxBsupqvq+mDNc7mqpiRcZ2O92HIv9j8mZ/xFjn4He07R5FOElrl5U9IzUHThrYIB/+m8UjrZcrvb9SxQN0ljpoPVaIfKRz6ghHas441ZX0w1PUrNLoMAoCqhmYcDRmFSKgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYMHewJ8jK4zTilL/A770yRsbfXrhXJqtGfYOs/GncQ=;
 b=GXTUoA6FyZFc8lhnZAY5R58ZRmkQeKoLnHNg8j65zmldujZVH92a07VGg9GI9sdk8LU5cukMkr8Bw173x/PkOM09fHyOsZ86+UxnI++rQmCEpLxsepR3sdIzPxXFYLo7LL66WuPKiIQ6xlqqQZwtTW9xVuqDddo9XEk4wW0L7zfSVprTfFKMkwKP0C82yxH+r3Iz8eTuIL2MKgWQSOP0jeB8fenK/fiWbIBDN42YwENze608W928LzjerJ9dp22eG1qCXIOyKm+0k7KkEQXiKQ6DjthuFtrBihalijoHd9VgirqpO7p5snUBv36erWwMxNHWMYr8xKSDyYEnnU4QxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYMHewJ8jK4zTilL/A770yRsbfXrhXJqtGfYOs/GncQ=;
 b=QUhCQqNHmQDQvNTi3OXC/kj4OD84eHl6/IvbSfTkZ11UZXvn71CTvVFz/TYaSFON7fsNELFDICt8/c/TbSlAgnueBWHKz0wyUnd9FQhBIIGinWMfgjoY9fQ6V2+3jYGbhYVrV3TjOsNDwBa9JrHM1wsfsp0iPwDM8uKgwP+Fbqw=
Received: from SN7P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::10)
 by BYAPR02MB4054.namprd02.prod.outlook.com (2603:10b6:a02:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 19:05:33 +0000
Received: from SN1NAM02FT0007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:123:cafe::f0) by SN7P220CA0005.outlook.office365.com
 (2603:10b6:806:123::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 19:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0007.mail.protection.outlook.com (10.97.5.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 19:05:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Jun 2022 12:05:31 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Jun 2022 12:05:31 -0700
Envelope-to: robh@kernel.org,
 openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.23.123.25] (port=54613)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwTeY-0001e6-55; Wed, 01 Jun 2022 12:05:10 -0700
Message-ID: <d7854ce0-3553-3286-809c-651780fb91e5@xilinx.com>
Date:   Wed, 1 Jun 2022 12:05:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzk+dt@kernel.org>, <michal.simek@xilinx.com>,
        <ben.levinsky@xilinx.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
 <20220531234308.3317795-2-tanmay.shah@xilinx.com>
 <20220601184240.GA188558-robh@kernel.org>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20220601184240.GA188558-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da12169-e786-457d-d7b2-08da4401b3bd
X-MS-TrafficTypeDiagnostic: BYAPR02MB4054:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB40549D32A525310F0D3B8136CADF9@BYAPR02MB4054.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FB+L8iIc3hTEzAkUe5hYgr1l/DLBdp4QSC89MotgtVIA+7HgW+RXb1WSaFo4D8Ml/GsBNt8fKSIR1zPn43svAMr48WmHSdKVZmFns/lsAEb8vdf7YxmqIEvItH9L3UyFSquKSbcMC7uTQzmmJH/ccbviwnZEhxBHMKPcQ5yw+cOPuaNvJ7/cDvL1bhIJKldWibjJoIxPPV8AZH5HKEd42zJrUmJd5NLJQg73ZdNgkTHe08TkfqOntd0RMnpYfVdhUvPxcrN4YhoIZpEyVBT0DoOIyhGPBG8qCHM9ruj3MVq8k6lSwyYYoJyE/4QcAdRAveUKGikSSWLRXtbh/SpUEZYTXJUFX9Z/mnkL2IzirEq9vKGupwrC5U1YEAkREJ40pN0/JWTOHbPcksWQOPCNG9fQP8YiXMsKC9/2DwvkHNam31E999qxybDB55kcjj3LBP+0eOvc3Bfnv0GzZwUfiKla8lm2c95lJDwqIkCEMm9uhHPtSP/iJjg2YlR8mXmUpKsSwOQhznsQ6INOk1O/a6AEHp6i+WGDoQZgwNREsciCe87PVPMU9cgUlG4++D2IBHXwDgcTGEPYmh4eugcecbBiKYpwHQgp8pXCVwvUzmQdc6odSMtu6CIdVFI2bwSrGAsYtbjw168/2ym53kUHZXphBF4uek1NlfwGBobG/ANReQxYcQbco0ubQx5aYSCbUAr52fifHSYiBrlWH32VodukiSN7uxc3j0fhf3n2YW6pY3aUIHZ4xl3gvkRycGnQ4TE4nMaYp6uZ7eTwttQINMwDTCC6Qh76822XdCH3+j2JWI3nt9vjfrRoaZebPS6h7TSsTCBVXLj2vDTbYdV5Vi5XskvgU+cfhZSIENmFy04=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(31686004)(47076005)(2616005)(44832011)(70206006)(83380400001)(31696002)(356005)(8676002)(7636003)(36756003)(4326008)(70586007)(82310400005)(54906003)(2906002)(316002)(6916009)(36860700001)(53546011)(26005)(9786002)(5660300002)(186003)(40460700003)(336012)(426003)(508600001)(966005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 19:05:32.6784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da12169-e786-457d-d7b2-08da4401b3bd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4054
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for reviews. Please find my comments below:

On 6/1/22 11:42 AM, Rob Herring wrote:
> On Tue, May 31, 2022 at 04:43:05PM -0700, Tanmay Shah wrote:
>> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>> (cluster).
>>
>> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>> ---
>>
>> Changes in v6:
>>    - Add maxItems to sram and memory-region property
>>
>> Changes in v5:
>> - Add constraints of the possible values of xlnx,cluster-mode property
>> - fix description of power-domains property for r5 core
>> - Remove reg, address-cells and size-cells properties as it is not required
>> - Fix description of mboxes property
>> - Add description of each memory-region and remove old .txt binding link
>>    reference in the description
>>
>> Changes in v4:
>>    - Add memory-region, mboxes and mbox-names properties in example
>>
>> Changes in v3:
>>    - None
>>
>>
>>   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 129 ++++++++++++++++++
>>   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>>   2 files changed, 135 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>> new file mode 100644
>> index 000000000000..cbff1c201a89
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>> @@ -0,0 +1,129 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx R5F processor subsystem
>> +
>> +maintainers:
>> +  - Ben Levinsky <ben.levinsky@xilinx.com>
>> +  - Tanmay Shah <tanmay.shah@xilinx.com>
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
>> +    enum: [0, 1, 2]
>> +    description: |
>> +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
>> +      lock-step mode(Both RPU cores execute the same code in lock-step,
>> +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
>> +      core 1 runs normally). The processor does not support dynamic configuration.
>> +      Switching between modes is only permitted immediately after a processor reset.
>> +      If set to  1 then lockstep mode and if 0 then split mode.
>> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
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
>> +        description: RPU core PM domain specifier
>> +        maxItems: 1
>> +
>> +      mboxes:
>> +        minItems: 1
>> +        items:
>> +          - description: mailbox channel to send data to RPU
>> +          - description: mailbox channel to receive data from RPU
>> +
>> +      mbox-names:
>> +        minItems: 1
>> +        items:
>> +          - const: tx
>> +          - const: rx
>> +
>> +      sram:
>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        maxItems: 8
> minItems: 1
> maxItems: 8
> items:
>    maxItems: 1

I have posted v7 which adds "minItems: 1".

However, I didn't get items: part. Is it required to have items: now?

Can I add items: part once TCM bindings are posted?

I understand that minItems and maxItems under sram property decides how 
many phandles sram can have.

However, maxItems: 1 under items: field what it describes?

Thanks.

>
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
>> +        description: |
>> +          List of phandles to the reserved memory regions associated with the
>> +          remoteproc device. This is variable and describes the memories shared with
>> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
>> +          vrings, ...). This reserved memory region will be allocated on DDR memory.
>> +        minItems: 1
>> +        maxItems: 8
>> +        items:
>> +          - description: region used for RPU firmware image section
>> +          - description: vdev buffer
>> +          - description: vring0
>> +          - description: vring1
>> +        additionalItems: true
>> +
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
>> +    r5fss: r5fss {
>> +        compatible = "xlnx,zynqmp-r5fss";
>> +        xlnx,cluster-mode = <1>;
>> +
>> +        r5f-0 {
>> +            compatible = "xlnx,zynqmp-r5f";
>> +            power-domains = <&zynqmp_firmware 0x7>;
>> +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
>> +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
>> +            mbox-names = "tx", "rx";
>> +        };
>> +
>> +        r5f-1 {
>> +            compatible = "xlnx,zynqmp-r5f";
>> +            power-domains = <&zynqmp_firmware 0x8>;
>> +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
>> +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
>> +            mbox-names = "tx", "rx";
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
>>
