Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140F653AAB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355986AbiFAQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242784AbiFAQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:06:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C1CCD2;
        Wed,  1 Jun 2022 09:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbP+Njxa9SE8qRD4lhKqMiL582cupzI+m+ZurcTvWhirTyPrAopayW6O7FVH+DuHdYrAZH4Yfdtn+8NJWKVF3I+4oug3O2sempfWPSaL1lfzP7mL7x8h7AZ5CjYi8FmjdEVDvotuYnpcRiLc5EUiLQzO1bm4xqfKneqDOybb7TclO3cuZAXl6wBQO3F+U2y7piy3p1T6V5lSgdJ/SpQqD8YWgetpu1vP5WzjYksm83M9USmQqXbQ7w6UzdwlLM57YQbVlJOUYRH7CboBO2lzIVsCh2/NT6/I8hAlulCESAPKpV3vPsTXZLN65teAPJgt9c35OMUNPwT33W9JeYnl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUE+3PZrMyvJ+xsE62IBw781u7lN/oyCTXEL7JOthgg=;
 b=C1Q10oW9EK3pOzXNNqkrlVHObQQ3uCbwvGdbUd0ky+A6cMTBuD9GmzJe0bcqOmHZhNL4LnxRDT/zDjhyyYaLWtKW4FfHfzO/bEW05Ie1W9S1drNiP9EjGkwJ8oTqAuLQOoFzAAj86MQAoc77FQ8H6DVf/6NaGXyy21xzN+gipcmJe3aU36s9rl3U5t+qQTS0lQ3avglwGUWK8/YJum5lblXXKDijzOvW2+Y/ew7IK3kWVjdicAhOPpShrCTC1QcAaWw114Pjln2tYILpeXHeVMsYSJ1fKK0Uc43wX6R8Xl7y05j9kv9p+1xM14YAn1l/8XMPBuC1jXQG6YWtHzTJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUE+3PZrMyvJ+xsE62IBw781u7lN/oyCTXEL7JOthgg=;
 b=BnmK/qclYnZ7MsfmnwseYuXBc++2W4F7/5uMBaRP6f9ZsuJhHMPUykOj8kJe4ygV6fF+kkX/1Wht+S75YW5lpCrC78pHQ2FTcFCYAbWn67qbNixnpOtn9zEqehzbQj8qCIZA5S5xlwhtZ/PqKwvGP1/Rn/NrO9JGOd7Zt79m0aw=
Received: from SN7PR04CA0078.namprd04.prod.outlook.com (2603:10b6:806:121::23)
 by SN6PR02MB4093.namprd02.prod.outlook.com (2603:10b6:805:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Wed, 1 Jun
 2022 16:06:43 +0000
Received: from SN1NAM02FT0016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:121:cafe::26) by SN7PR04CA0078.outlook.office365.com
 (2603:10b6:806:121::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 16:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0016.mail.protection.outlook.com (10.97.4.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 16:06:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Jun 2022 09:06:40 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Jun 2022 09:06:40 -0700
Envelope-to: krzysztof.kozlowski@linaro.org,
 openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.23.123.25] (port=53259)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwQro-0005JZ-K4; Wed, 01 Jun 2022 09:06:40 -0700
Message-ID: <c3a77a93-681b-e88c-6b0c-00f64d2181e7@xilinx.com>
Date:   Wed, 1 Jun 2022 09:06:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
From:   <tanmay.shah@xilinx.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
 <20220531234308.3317795-2-tanmay.shah@xilinx.com>
 <44053e7d-71fd-2012-dc7f-5641536c1f2c@linaro.org>
In-Reply-To: <44053e7d-71fd-2012-dc7f-5641536c1f2c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a1717bc-220b-45a2-7623-08da43e8b88d
X-MS-TrafficTypeDiagnostic: SN6PR02MB4093:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB409340536721B1AD4A79C4A8CADF9@SN6PR02MB4093.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkM4fpW8473sERjGAt6gkRv1me6AAhWOHQBb/vfqZ9hQAnted9LRWpZWkKCARTZDiIVf6ESqlXg8ElTzuT3Dtidw13BnM+GqZIab1ghUJFMbkg49GJsmpxXbGNmxz0N/G/UnD7NANRRYXNTmhO/W+cQj2I9tWqQge0wQ/Q2o8rEf9tyKepczNdsvcMCa/wFXUm8z+RSRDna1EfdCcwkBzJUC0SGeKrbXDsa/kEwrqRZIKkkPZI2r2QhCl5y2kWtdzfPTRXwAqLLu4+lDOHdXrD7VbSzExGUFFSU08S4GBNx4Gh/bs1+xBAFFP+ZJW6OAN9KFFDgeVhjsOjM286JAEMLoVvJDQK0yMhp01woR4i4BSLvwsllWdYE/Vs4Zne97aSF78Xl/bZVg7cjf0eBi0olJS1mgaLapz05DkrTy428fyS9mx6Rf+P70pwjn3HzAkL/yoomKzB4tZKmlXFWOQWB9ROMdgAYYiW5pNqXxf7h0ZOL62oUU7hr3KqKck5fIGjbE5GEyXgiOWalbZMF3ocaoBsKKfmKdTVZGv6Qk/iHhCBtmktxqHueSvIl0qtLyEui9I0Cmy7zHNNq7F5ZXfWIB4XKWsWxL+0JxuJIHd0Qw2OAZVJu53Wfed67wruvYB3nPhgcGnNJamKA9P66YQtPChMXErJ7Ulqkyh2YqdaYXn97xAvcFFBkEKcWdGsOJe8SUdaD8JeGo3zDU/UQJn8BZBKEjQiODVsj8ZYhQ/lsog0qN5BuDPGMVyUy7qRG3zVSbytXNLTtNmGmeUGr0JewTxnbaWRQQVASiEqFjgF5UI2MtfQXIQe3HeN1+5kRR0IBupGDnL4c0CxHVJrx0jlV8IE0ve63oDFPqkwmTGd8DagptPvGiDkSBgO0TRFzJl50aqfNonVLiSECetxSsqvpB3T1dBA7nRtlzNAhi8x0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(70586007)(508600001)(2906002)(8676002)(2876002)(186003)(336012)(426003)(47076005)(5660300002)(70206006)(8936002)(7416002)(31696002)(53546011)(9786002)(36756003)(83380400001)(40460700003)(26005)(31686004)(82310400005)(36860700001)(110136005)(966005)(316002)(7636003)(921005)(356005)(50156003)(2101003)(83996005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:06:43.3317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1717bc-220b-45a2-7623-08da43e8b88d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4093
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/22 5:22 AM, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 01/06/2022 01:43, Tanmay Shah wrote:
> > Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> > Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> > (cluster).
> >
> > Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> > ---
> >
> > Changes in v6:
> >    - Add maxItems to sram and memory-region property
> >
> > Changes in v5:
> > - Add constraints of the possible values of xlnx,cluster-mode property
> > - fix description of power-domains property for r5 core
> > - Remove reg, address-cells and size-cells properties as it is not required
> > - Fix description of mboxes property
> > - Add description of each memory-region and remove old .txt binding link
> >    reference in the description
> >
> > Changes in v4:
> >    - Add memory-region, mboxes and mbox-names properties in example
> >
> > Changes in v3:
> >    - None
> >
> >
> >   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 129 ++++++++++++++++++
> >   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
> >   2 files changed, 135 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > new file mode 100644
> > index 000000000000..cbff1c201a89
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> > @@ -0,0 +1,129 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx R5F processor subsystem
> > +
> > +maintainers:
> > +  - Ben Levinsky <ben.levinsky@xilinx.com>
> > +  - Tanmay Shah <tanmay.shah@xilinx.com>
> > +
> > +description: |
> > +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> > +  real-time processing based on the Cortex-R5F processor core from ARM.
> > +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> > +  floating-point unit that implements the Arm VFPv3 instruction set.
> > +
> > +properties:
> > +  compatible:
> > +    const: xlnx,zynqmp-r5fss
> > +
> > +  xlnx,cluster-mode:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    description: |
> > +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
> > +      lock-step mode(Both RPU cores execute the same code in lock-step,
> > +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
> > +      core 1 runs normally). The processor does not support dynamic configuration.
> > +      Switching between modes is only permitted immediately after a processor reset.
> > +      If set to  1 then lockstep mode and if 0 then split mode.
> > +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> > +
> > +patternProperties:
> > +  "^r5f-[a-f0-9]+$":
> > +    type: object
> > +    description: |
> > +      The RPU is located in the Low Power Domain of the Processor Subsystem.
> > +      Each processor includes separate L1 instruction and data caches and
> > +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
> > +      memory space is non-cacheable.
> > +
> > +      Each RPU contains one 64KB memory and two 32KB memories that
> > +      are accessed via the TCM A and B port interfaces, for a total of 128KB
> > +      per processor. In lock-step mode, the processor has access to 256KB of
> > +      TCM memory.
> > +
> > +    properties:
> > +      compatible:
> > +        const: xlnx,zynqmp-r5f
> > +
> > +      power-domains:
> > +        description: RPU core PM domain specifier
> > +        maxItems: 1
> > +
> > +      mboxes:
> > +        minItems: 1
> > +        items:
> > +          - description: mailbox channel to send data to RPU
> > +          - description: mailbox channel to receive data from RPU
> > +
> > +      mbox-names:
> > +        minItems: 1
> > +        items:
> > +          - const: tx
> > +          - const: rx
> > +
> > +      sram:
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > +        maxItems: 8
> 
> Without minItems, this means maxItems=minItems and previously you had
> here "minItems:1", so is it really what you want?
> 

Ok. I misunderstood previous comment here in that case. I thought minIterms will be
1 by default. But, it is not that way. I will fix this in next revision.        

Thanks.

> Anyway rest looks good to me.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
