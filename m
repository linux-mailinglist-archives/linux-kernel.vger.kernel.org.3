Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21DF532DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiEXPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEXPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:43:26 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392C48B0A2;
        Tue, 24 May 2022 08:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdCgpCpLJiJWGhH5oCnTwHgVlOnZolwV/5B7DhpKobmU2zHPy+l4RRGPeBOj7PtObJaHzbezPGwQVg/LEviUMQeTnny7kAEBhEbLUR+lo1sbqp6fjfhup2v3W+tV9pc7aYJgWKm3KXuzqSn+mupGQGpuoHStWGz9iSyXjCr82juQyn6drpky/pB9F2gQDB/AuJkPZD1EPEVsT5cDhTM/y+l90xe40QR9nmWKBR0kdvCeG4mGxRPFy1q3TbJhFyFd9y8uSisr2ivIqZNOXNp79J9NzftmGW6wiz1URuPD340gZWM5maGilRI4wbnWHql+C8nvBPWlA35v7YMuj5qASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X83geYn3zVYpLi/4GdJ7Bwsmnt9mZs3aF1+9VK0PtNw=;
 b=cX0TcWTgM//O195+wgZFBtLCIp+JoRfns6ZgWuE10AY/0Qwqf9+Wp6eSrhlHXJoU2wK/xIw668ONBZRBX1IKA7kK83dTrJKin5fSRx4QTcVJp+fG6Ew23t7X+Fo0O/WbGWitPfl4XFE4xhbhzbEPyPYJ4PaN0FpH5OgR7wnApwF3PvAz2S/p1BsYzwc4mfQCuwnxd+ABVn2FCrSHGVjlbynP5wkC1TPeuxraMRYOYki/yo60acdPmuA4wmI6woCJVzwgylGrFwpk1dzDRe7hDTNvHtWtSWCILNPT/0P96vDEqDPUhcOH+58K2n2MvgyoUvTCfF9MyPeiVDq86gn6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X83geYn3zVYpLi/4GdJ7Bwsmnt9mZs3aF1+9VK0PtNw=;
 b=oE/uXjTB+g9Zena/psOEtn8tKCTbmwxjyKiIsQi4kEBpDu9YZT+u+FJ23x6nc9qxTJmC0MzjhPODNDydSU3QrbC2rRXGSbuNZhLpZkBF/w4O4ngjutOpsJ+lyaqPPPvZkFpqTlmM8vT4/n+sLtxz1d/trZ6exjTxH6v7vEZZn2g=
Received: from SA9PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:6e::10)
 by PH0PR02MB7269.namprd02.prod.outlook.com (2603:10b6:510:1e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 15:43:23 +0000
Received: from SN1NAM02FT0012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::2e) by SA9PR11CA0005.outlook.office365.com
 (2603:10b6:806:6e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Tue, 24 May 2022 15:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0012.mail.protection.outlook.com (10.97.4.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 15:43:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 08:43:07 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 08:43:07 -0700
Envelope-to: krzysztof.kozlowski@linaro.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.23.123.15] (port=49419)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1ntWgc-000B1n-Tl; Tue, 24 May 2022 08:43:06 -0700
Message-ID: <c7b248f4-9ec1-2ae8-c7e3-55f37592f56e@xilinx.com>
Date:   Tue, 24 May 2022 08:43:06 -0700
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
 <c97d61b0-8a38-5054-d5f1-bc7c5e7bcf61@xilinx.com>
 <1b117e49-28d0-da75-68ee-c2fcef9fc9a9@linaro.org>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <1b117e49-28d0-da75-68ee-c2fcef9fc9a9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b187c3a0-803a-41f6-8009-08da3d9c22c5
X-MS-TrafficTypeDiagnostic: PH0PR02MB7269:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB7269066A7CDD2CBA57E5D631CAD79@PH0PR02MB7269.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcir4UipcloPNaF6E5T+we4JUha3DqEZyaC3yWUNJtqdjcbRX+voBPoLg9OXMvqE4nCXGGM4mewqJZk1D04TYDPu+VBGgMY9CcJ8X18pDT8qu5AYNbfxzVZV8NjL3DFY7B7ZcEARgvXvcMblXX+yqXUQ/mhw0QZQDJacWqzcgxOLgp9OmYP//vhSN2BUtZK3tl//Wq1f5HUQZerqAJzf40o3tpL/r368fPhfVYySbLbxNYAIA1Q4yw/yGfQE64PTqTs4+xN987hUyDX7hqgpGgl1jJjw+gqvnr7YsgzyvziI7rkh89xRvK+qIHEBx4D7/Tg7KaAYTxktEkrg1gyCVTDksaNu/WmoETGe309ECciJaYlx3ZX8/B52qWbcbD1xWcAI59JbGq/ZJY18/qMRckvAm73YXPJjM843c05oDMX6rp0twvOfLhS922OXEdZhePNLpxyhIIrd1WjljYIXwK/FzXXvGnwE1aG0kJwBvXfsYwTV3A7O+iGxmkYNSuaxLx5wBef+2Bme8z0UpZNA/s62GmaRVcyfbOmnhosQzD/rsoMCIcdzZsWNhCbJuzGSyJtlS6ZIFI6krK9Po5TbOXzLniF1kZYumFbNxF5HBfm/jsJ2GFS9qIyonFyWHMCsYVdnLksVybsPX45fcLFFMTznH2Xrli0/9ZC5e96+CbNPaoykWWoh8Czw/vxpZ+CcR+/txQx5A8up4KT08c39tmbGcDYMSMuOzKMEvv5bxOE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(508600001)(2906002)(83380400001)(31696002)(36860700001)(40460700003)(186003)(82310400005)(26005)(70206006)(70586007)(4326008)(8676002)(7636003)(36756003)(2616005)(9786002)(8936002)(356005)(6636002)(47076005)(426003)(5660300002)(53546011)(336012)(31686004)(54906003)(110136005)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:43:23.3126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b187c3a0-803a-41f6-8009-08da3d9c22c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7269
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/22 2:19 AM, Krzysztof Kozlowski wrote:
> On 23/05/2022 23:38, Tanmay Shah wrote:
>> Thanks for reviews Krzysztof. Please find my comments below.
>>
>> On 5/21/22 8:12 AM, Krzysztof Kozlowski wrote:
>>> On 18/05/2022 21:44, Tanmay Shah wrote:
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
>>>> +        items:
>>>> +          - description: mailbox channel to send data to RPU
>>>> +          - description: mailbox channel to receive data from RPU
>>>> +        minItems: 1
>>>> +
>>>> +      mbox-names:
>>>> +        items:
>>>> +          - const: tx
>>>> +          - const: rx
>>>> +        minItems: 1
>>>> +
>>>> +      sram:
>>>> +        $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +        minItems: 1
>>> maxItems instead
>>
>> Here, I am not sure how many maxItems are really needed as TCM bindings
>> are not
>> defined yet. For now, I will just keep maxItems as 8. i.e. 4 OCM banks
>> and 4 TCM
>> banks. However, that can change once bindings are defined.
>> Is that fine?
> Yes, although shrinking might not be allowed once binding is being used.

Ok. we don't expect shrinking if we set 'maxItems: 8'.

Thanks.

>>
>>>> +        description: |
>>>> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
>>>> +          the RPU can execute instructions and access data from, the OCM memory,
>>>> +          the main DDR memory, and other system memories.
>>>> +
>>>> +          The regions should be defined as child nodes of the respective SRAM
>>>> +          node, and should be defined as per the generic bindings in,
>>>> +          Documentation/devicetree/bindings/sram/sram.yaml
>>>> +
>>>> +      memory-region:
>>>> +        description: |
>>>> +          List of phandles to the reserved memory regions associated with the
>>>> +          remoteproc device. This is variable and describes the memories shared with
>>>> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
>>>> +          vrings, ...). This reserved memory region will be allocated on DDR memory.
>>>> +        minItems: 1
>>>> +        items:
>>>> +          - description: region used for RPU firmware image section
>>>> +          - description: vdev buffer
>>>> +          - description: vring0
>>>> +          - description: vring1
>>>> +        additionalItems: true
>>> How did this one appear here? It does not look correct, so why do you
>>> need it?
>>
>> Memory regions listed in items: field here are used for default current
>> OpenAMP demos. However,
>> other demos can be developed by user that can use more number of memory
>> regions.
>> As description says, memory-region can have variable number phandles
>> based on
>> user requirement. So, by additionalItems I just want to notify that user can
>> define more number of regions. We can limit memory-regions with
>> 'maxItems: 8'.
>> In that case, I will add 'maxItems:' field in next revision and even,
>> that can change in future.
> That sounds fine.
>
>> But, User should have flexibility to define more memory regions than
>> what is in list
>> of 'items:' field. I think this is similar to what is defined in
>> ti,k3-r5 bindings.
>>
>> Please let me know your thoughts.
> I see. If schema accepts such combination (listing items + maxItems +
> additionalItems), then it's fine.

Ok great. I will set 'maxItems: 8' in that case in next revision.


With this, I will add 'maxItems: 8' in sram and memory-region properties.

If everything else looks good on schema in this revision, could you 
please also review next (dts) patch in this series?

If that looks good, can I get your 'rb' on that?

so we can reduce scope of reviews for next revisions?


>
> Best regards,
> Krzysztof
