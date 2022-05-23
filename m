Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C987531E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiEWVjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiEWVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:38:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523559B86;
        Mon, 23 May 2022 14:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRj8QecCgXO4syaYKZOHdQDvFquvuXDmvVt381+QxJo8wQht0Z9HyEGY6TOJ51jXBFGQIoLmgYpkH+QJgUxLRRRDnBqTUaApjUg/FVzmWAgPW1gLrYy7fobQjOOsQ3u/M9QP10PWJOYXHfHvJOHRh8n1rfIi4ti1AnbH77xLIQm/54y8KdvSU/4JfAki1HsOgh43oWmg16/lw5f1EMHKDYdOd+F2g4UZ/Cb4O3CjBn7uEuEDCQLE8aZIjRBaQQORICutteLeMOFzg9yE/VEA9xF4w5W8M1rrcmmT2ziaO7mVQ7mDXZQkmfDGU92BOsWxOnwFc+nOCGYbtt2jTPec4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5UVLM8tZldxUlqWVdD2KthykgcRWrNk755ULfqJt6E=;
 b=n0sTvnKBqSqJ//V/XogVIyj7uzkyPvISSqZ7QbeLog98Z3Cpx2hjmNvK0kUD53cvdzmSh/M/S/jjLdTmZEjmbAnAodEyyZ4ASJp8Owu7gtRGqy3nuTKiejYy7ZHT2su5tDTLPt4JEOBe9kGfIU3829AcpENKZfKr9Ehbd7ejBelkAp+NC28Ym3XNfGwfUsCr0mJFxaBM9dYuv3iQe2/s+VXaVvXDyC05WHclYEbfG6b+yW0p8voZ8K8tRIzbBqzPPvsQkpeo68xc2XjsMDmG3FScSoPChrRQhgDNkUY8Yzc2psuHVMzp2ULAuzB62z/NN+1zA89qEn/+MVKi2CD6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5UVLM8tZldxUlqWVdD2KthykgcRWrNk755ULfqJt6E=;
 b=aWRcD8bfc/YlUt0JsfzeZ0PBM123rWlCBx+FZ/kWFfD5xG76P5ApLww12/F7o7TezzFnidbJGB2dZS+vubeO4ZlkI8xbwby9dlwrBKAHXYGMVEQSGHWcLST65qXjAWHl2A2+vQ0Ig6CG9UcdjvGv/twWeUjSBo/QJuzs6u1lKkE=
Received: from DS7PR03CA0255.namprd03.prod.outlook.com (2603:10b6:5:3b3::20)
 by DM8PR02MB8102.namprd02.prod.outlook.com (2603:10b6:8:1b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 21:38:55 +0000
Received: from DM3NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::b3) by DS7PR03CA0255.outlook.office365.com
 (2603:10b6:5:3b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17 via Frontend
 Transport; Mon, 23 May 2022 21:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT049.mail.protection.outlook.com (10.13.5.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 21:38:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 May 2022 14:38:54 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 May 2022 14:38:54 -0700
Envelope-to: krzysztof.kozlowski@linaro.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.23.123.15] (port=65144)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1ntFlO-00016H-CC; Mon, 23 May 2022 14:38:54 -0700
Message-ID: <c97d61b0-8a38-5054-d5f1-bc7c5e7bcf61@xilinx.com>
Date:   Mon, 23 May 2022 14:38:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
 <20220518194426.3784095-2-tanmay.shah@xilinx.com>
 <45fea4a1-387f-9684-a90b-58b695b54172@linaro.org>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <45fea4a1-387f-9684-a90b-58b695b54172@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a836c669-0c8f-49c5-9e95-08da3d04a30a
X-MS-TrafficTypeDiagnostic: DM8PR02MB8102:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB8102DE3C89776D805B3CBCF9CAD49@DM8PR02MB8102.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ep3ZkoJOb66fIr0/bTWiH6AVRw3LZgPxgL+w6vDgocghcfsyCI5/VVbOp8Ck8fyHCaSo/m05uxXfLNX91VFi7CjK7wIucJAch61djy4OXFk9vRlejxPzigyXidTxJ9MVRqLHVdcJKK3SIzGfF1lrzglgJ/RhkKSzIpGFmDcloA/QgshiPN9amlgt7uqjUJzPCyd2JmN3WqSxfa9aq09f3heRRz2ktHHVogSyK39JGIsT1Lp6R0kD0N/kQjURu6vNDPRlgP46dtuFlBV40VoHI7Rqm0DPd8uckXXZE2FwOsEcJiSkodno5NPAnvyvqzZ5pte234a3hpFMyGhcQAPFT8Ts4EJH/4mAz4lJ1s15eBok0jaLMGgjF1Yt8rTTqDVoji4WX+j6iHZD1WuxT+PftIztrQlxIjaVqwZqvBAdYe2ZVuKjVwQWSOQzV9bCDie7SzkduGUVNc3z0WlrzZSyZo/SdO0eRAc1yy7nKmCf/Rva/EmkawoLkTeROxwj9tYeReciZrC/k/tmrZ7vnj/OVIijPxE5d1xriSPl+wNsZmdYD3zi+awPowBao2aVfvy9rrfA5AoLz/MqYo9zIHQTYo64kdV/E+0WH6v1UK2KL6TEx2ourgYU6R5QNXk/pa5CJZKCxcoRd8exzcHVSgFkSLQlTdMHz7WmjN89W3FkmkQxW1zBnTPl3Bpf0Hl5q/npF+sdZ/XQ4ChAmEMCoDDoeKUtijHzbxXSC1GI23g5yv4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(83380400001)(2906002)(70206006)(70586007)(36860700001)(186003)(2616005)(47076005)(426003)(31686004)(4326008)(26005)(40460700003)(8676002)(36756003)(8936002)(82310400005)(5660300002)(54906003)(7636003)(31696002)(6636002)(44832011)(53546011)(110136005)(356005)(316002)(9786002)(508600001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 21:38:54.9954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a836c669-0c8f-49c5-9e95-08da3d04a30a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8102
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviews Krzysztof. Please find my comments below.

On 5/21/22 8:12 AM, Krzysztof Kozlowski wrote:
> On 18/05/2022 21:44, Tanmay Shah wrote:
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
>> +        items:
>> +          - description: mailbox channel to send data to RPU
>> +          - description: mailbox channel to receive data from RPU
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
> maxItems instead


Here, I am not sure how many maxItems are really needed as TCM bindings 
are not
defined yet. For now, I will just keep maxItems as 8. i.e. 4 OCM banks 
and 4 TCM
banks. However, that can change once bindings are defined.
Is that fine?


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
>> +        items:
>> +          - description: region used for RPU firmware image section
>> +          - description: vdev buffer
>> +          - description: vring0
>> +          - description: vring1
>> +        additionalItems: true
> How did this one appear here? It does not look correct, so why do you
> need it?


Memory regions listed in items: field here are used for default current 
OpenAMP demos. However,
other demos can be developed by user that can use more number of memory 
regions.
As description says, memory-region can have variable number phandles 
based on
user requirement. So, by additionalItems I just want to notify that user can
define more number of regions. We can limit memory-regions with 
'maxItems: 8'.
In that case, I will add 'maxItems:' field in next revision and even, 
that can change in future.
But, User should have flexibility to define more memory regions than 
what is in list
of 'items:' field. I think this is similar to what is defined in 
ti,k3-r5 bindings.

Please let me know your thoughts.


>> +
>> +    required:
>> +      - compatible
>> +      - power-domains
>> +
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +\
> Best regards,
> Krzysztof
