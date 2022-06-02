Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF753BC1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiFBQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiFBQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:09:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B39D1D5026;
        Thu,  2 Jun 2022 09:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwboKhLlKTcnlU+xq0VTWG6w0p3/1SLQOtuOafuSpIFKmp5P4zfa6AzsN7Y2tLwdySjKRwf0gViS+obhjwFa4lTavOGnKLGTL6jsFwNHYXJA4NjsNjR4pJJwUhoZSkHnoxt83a32qvpaf8tvgk9gMxq0E8+/Z8tKqyl7v0BaKdrNXNTpdbnTf2mLCxA/Nm2XwX9TK42nKk+ibK73dmpneIvRk3/Cyg337gYa+ZdfEB+u2R8YEfXK89Jq96yPKgtOnkTedEvCilwc0iE36JvxRkNps9JbFbqECrVmOE5OEinCqh/J47RVqeSjfGAaRZmmJrpFWi1ZuH62It5g5yR9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXQMK0I9E8uaestoNZ2+xJWnw9PpUVueOwWLWbYSKRQ=;
 b=bOdW91s3RL350lEJuxL4QCsCsLnGN+y3QwgXyOiqAoWIdqW7o3qAZkfAGnhb3O+c8feOrf8ZxpmDr4PLXWq4zzEhkhMD/azUtuaqetdFsLStvP8tHJnfo/0mFpQsBOVxOcIOzT+40oC0wZPnBTRWBmieUwNCmB1f9ocFEclWDaJuHmEXT1DoCu1bzz56A6eC5Qq7RZymbzm8wo+UgEONsHUe4bvwHqx2V2QNf8lMYpEpCTenO3O9EmEdEYO34ggq2+leH3fLnY2sJBIFNvhWCKDMzO7ECL6ZW6aAG+/cBXDVP/s83Mz3fSmjRFij2Rroh9q2EKR4WTfIxXeYxHMF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXQMK0I9E8uaestoNZ2+xJWnw9PpUVueOwWLWbYSKRQ=;
 b=nGE/U+CHpMpKBkxLDEX0Wbu03dwYhiX1inT2Y2ZFMVv2BUdQNP/KUuJc2LbiHK+1MNu4MPST3a4wzKcqp5wmTJ9qwPM/42peX8q+J5CzHeyxsXODlfbCwb20pahuFlAf2bfvKIOHDi3C1Xz/92tPlImome/SL3oAruPVc+FE2ms=
Received: from DS7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::16) by
 CY4PR02MB2327.namprd02.prod.outlook.com (2603:10b6:903:e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 2 Jun 2022 16:09:01 +0000
Received: from DM3NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::73) by DS7P222CA0020.outlook.office365.com
 (2603:10b6:8:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 16:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT022.mail.protection.outlook.com (10.13.5.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 16:09:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Jun 2022 09:08:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Jun 2022 09:08:48 -0700
Envelope-to: robh@kernel.org,
 openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.23.120.222] (port=62864)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwnNQ-0006u2-Hw; Thu, 02 Jun 2022 09:08:48 -0700
Message-ID: <6b87b48e-d030-9942-6204-bd5d645faf49@xilinx.com>
Date:   Thu, 2 Jun 2022 09:08:47 -0700
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
 <d7854ce0-3553-3286-809c-651780fb91e5@xilinx.com>
 <20220602151409.GA2333778-robh@kernel.org>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20220602151409.GA2333778-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c50f37-848a-4886-7763-08da44b234ec
X-MS-TrafficTypeDiagnostic: CY4PR02MB2327:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB2327CB3DDA450C4B7C3B4D2CCADE9@CY4PR02MB2327.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ja4+qOiCmNtMgYjqOxMMEyBlTx7dikw4yLl8O7tC5Gj0TmLkYChlBBYL82eTPx8GHO1W7+aioiTrPsM7jtkRA2/g+i1n4eQGuN7Wfz74PBV56GdqY1uDp/wxIC+0ti11jOjhr+J8t/l6Nz+i3L8fAV7sqewlCi40b+2HBvzD/gbts2FeL9OxmJAbN+yHuH0TCWB65HKJHJrHBhpTcJKfGjFqTPs3gG7j4VAYRw16EfOTRNMrGn1LDIeq/MDv8Kv8LgR2xH7ECHZ/kwQspzNrLSZQZ1qV0Prk5NgQi4zrnRfwt1BNo6vMEWWu52pF0BnRFBpTD0v7c6vAGa+6LV+UbRP7AjNohxtgPvNaHLEGFIiyktB4/0W4q/2sMruRzF+6SNTGgTZ3Ms6H914b7RPrCzGuIfcyce89Twa3xLacVV+tmdam/I7u7pAX0sUAIInc2fkG9oOCOFc4FfFz+pOmkOHap0ootgfGoq/5R9jJaIOFkvxKtmDLgTR/lbAMS8VQdiKCLINY+zB6KenrtdCHygv1y6WfHdYy5APNXodny5dLkNQnUnH5e/SMeXbH8m7y0qRVkHUf7qND3t1bJyhqiYskupXrSKOgt+AXJ9z+nGbmHarSXhafnb4w+wxBRSWLnafWFJsPlC1OTSP9AlM2N5Q/9ZW+Mba4c/8z10tcTr3YuEomXHp+dd5/FmrzS4xT5iKlclHuo9BMSXW6zVKSYO7MhYeSSuaAKq5Refh6kc2J6i3pUiSa/Jl4trgF3RKAOWIm7ofz7L642GCgxmNRhN0G2f38UIX2aEU0zVeGpj2tTYcV9KPMqxWSWTdSLfpIu+u2aaIyq52Xv1WXo+mBdpcBwms9BF8bsnVPzMHaPw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(26005)(36860700001)(508600001)(4326008)(5660300002)(2616005)(53546011)(966005)(2906002)(44832011)(40460700003)(426003)(47076005)(336012)(31686004)(186003)(31696002)(6916009)(70206006)(8676002)(356005)(9786002)(8936002)(82310400005)(70586007)(36756003)(7636003)(316002)(54906003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:09:00.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c50f37-848a-4886-7763-08da44b234ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2327
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/22 8:14 AM, Rob Herring wrote:
> On Wed, Jun 01, 2022 at 12:05:09PM -0700, Tanmay Shah wrote:
>> Hi Rob,
>>
>> Thanks for reviews. Please find my comments below:
>>
>> On 6/1/22 11:42 AM, Rob Herring wrote:
>>> On Tue, May 31, 2022 at 04:43:05PM -0700, Tanmay Shah wrote:
>>>> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>>>> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>>>> (cluster).
>>>>
>>>> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>>>> ---
>>>>
>>>> Changes in v6:
>>>>     - Add maxItems to sram and memory-region property
>>>>
>>>> Changes in v5:
>>>> - Add constraints of the possible values of xlnx,cluster-mode property
>>>> - fix description of power-domains property for r5 core
>>>> - Remove reg, address-cells and size-cells properties as it is not required
>>>> - Fix description of mboxes property
>>>> - Add description of each memory-region and remove old .txt binding link
>>>>     reference in the description
>>>>
>>>> Changes in v4:
>>>>     - Add memory-region, mboxes and mbox-names properties in example
>>>>
>>>> Changes in v3:
>>>>     - None
>>>>
>>>>
>>>>    .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 129 ++++++++++++++++++
>>>>    include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>>>>    2 files changed, 135 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>>> new file mode 100644
>>>> index 000000000000..cbff1c201a89
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>>> @@ -0,0 +1,129 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Xilinx R5F processor subsystem
>>>> +
>>>> +maintainers:
>>>> +  - Ben Levinsky <ben.levinsky@xilinx.com>
>>>> +  - Tanmay Shah <tanmay.shah@xilinx.com>
>>>> +
>>>> +description: |
>>>> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
>>>> +  real-time processing based on the Cortex-R5F processor core from ARM.
>>>> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
>>>> +  floating-point unit that implements the Arm VFPv3 instruction set.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: xlnx,zynqmp-r5fss
>>>> +
>>>> +  xlnx,cluster-mode:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [0, 1, 2]
>>>> +    description: |
>>>> +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
>>>> +      lock-step mode(Both RPU cores execute the same code in lock-step,
>>>> +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
>>>> +      core 1 runs normally). The processor does not support dynamic configuration.
>>>> +      Switching between modes is only permitted immediately after a processor reset.
>>>> +      If set to  1 then lockstep mode and if 0 then split mode.
>>>> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
>>>> +
>>>> +patternProperties:
>>>> +  "^r5f-[a-f0-9]+$":
>>>> +    type: object
>>>> +    description: |
>>>> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
>>>> +      Each processor includes separate L1 instruction and data caches and
>>>> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
>>>> +      memory space is non-cacheable.
>>>> +
>>>> +      Each RPU contains one 64KB memory and two 32KB memories that
>>>> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
>>>> +      per processor. In lock-step mode, the processor has access to 256KB of
>>>> +      TCM memory.
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        const: xlnx,zynqmp-r5f
>>>> +
>>>> +      power-domains:
>>>> +        description: RPU core PM domain specifier
>>>> +        maxItems: 1
>>>> +
>>>> +      mboxes:
>>>> +        minItems: 1
>>>> +        items:
>>>> +          - description: mailbox channel to send data to RPU
>>>> +          - description: mailbox channel to receive data from RPU
>>>> +
>>>> +      mbox-names:
>>>> +        minItems: 1
>>>> +        items:
>>>> +          - const: tx
>>>> +          - const: rx
>>>> +
>>>> +      sram:
>>>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +        maxItems: 8
>>> minItems: 1
>>> maxItems: 8
>>> items:
>>>     maxItems: 1
>> I have posted v7 which adds "minItems: 1".
>>
>> However, I didn't get items: part. Is it required to have items: now?
> Yes.
>> Can I add items: part once TCM bindings are posted?
> No.
>
>> I understand that minItems and maxItems under sram property decides how many
>> phandles sram can have.
>>
>> However, maxItems: 1 under items: field what it describes?
> 'phandle-array' is really a matrix type because we can have phandles
> plus argument cells. So you have to define each of the 1-8 entries is a
> single phandle cell (and no arg cells).

Thanks for explanation. I will send new revision as suggested.

>
> Rob
