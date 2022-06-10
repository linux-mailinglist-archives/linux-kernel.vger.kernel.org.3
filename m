Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10331546A36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbiFJQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFJQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:17:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B39F19006;
        Fri, 10 Jun 2022 09:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf87ffSpovYTr6cb9CBj3lrxXkvYYGWu6636ulITG8t+rhgdiXl1X59ig7c0J9bcxFmoR8zdg4q6hcBc9VGK0OHzydMjOWX/bG0/SkFm5BtmzizRi06z4vmauitCN9KGiyVxBP8b3QRnbvS7qlUGtKEGZGxCyPMitxCPzl7aov+rIrnnnfcE5rjwUU7eoV0V3GrONdhUdp0Bh+34vBuGJ4tqM7hGGlmGyiK8MLhJuwq/zHN7VjtbrXIOw+caziEWhjDm+p0LrX/EyB6zH21ashy7RsAPFQVCtcnGIV0vJDiC56MxgAPUVSydQgvXCO41bcMedO6wC8wkhoyMvjyRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/0AOYXkFleQgIYFNysS/DrOD7RWiMwsjYoI2xSul48=;
 b=enRrXZCLMF68NkwnERqUPNtmxvpMB7vza30nPKq+uE1/czIjm4ECOc5E2s3ipVVzpv5Ms8+iZ1Evn2Q9eVLXZWVuOLlKFA1J7xj4X/UtGGto9AgeOp8nhL+b8atYV5PYpx5UqepKKvoORCvJoiUVqI7NuFR0kHCA483Xg2a6odefZuBkF7ivW6/GppSUuOza+6l7T9atscb7kkbcbyHEByofS/Xh1GNj86Z27sX5QvYJ4WVAqYjIVLnsNZ8qkxfGdUn0/gyipymh9zYoy1D4B7EHfU21YgGadeyCG10TNW3rox05RR4Mwk3nPX1rEqNtg6bo2WKoWAxQOWOGsx7z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/0AOYXkFleQgIYFNysS/DrOD7RWiMwsjYoI2xSul48=;
 b=Wp22rGp15sWtjzksOugCII1I8GPLT18BAENpv9axfze8wujv/PIKQMNqlUtMYVRKs/kYX6Eg6/EQdGpMumgmDuoLFtvCrqjYFYB5Ol+bqV9vJbXwrrzayCOo/8ndnI5OjL2vqKxm+zIxgshE7UsVc6Q08k6IP4qsMPJqyB7oTKA=
Received: from SN7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::14)
 by MWHPR02MB2542.namprd02.prod.outlook.com (2603:10b6:300:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 16:17:37 +0000
Received: from SN1NAM02FT0038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:123:cafe::55) by SN7P220CA0009.outlook.office365.com
 (2603:10b6:806:123::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 16:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0038.mail.protection.outlook.com (10.97.5.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 16:17:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Jun 2022 09:17:32 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 10 Jun 2022 09:17:32 -0700
Envelope-to: robh@kernel.org,
 peter@korsgaard.com,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [10.23.123.85] (port=54243)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nzhKG-000Dfg-BT; Fri, 10 Jun 2022 09:17:32 -0700
Message-ID: <21ecaa2a-7675-86fe-3838-472c74bc5890@xilinx.com>
Date:   Fri, 10 Jun 2022 09:17:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzk+dt@kernel.org>, <michal.simek@xilinx.com>,
        <ben.levinsky@xilinx.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-2-tanmay.shah@xilinx.com>
 <87tu921ck6.fsf@dell.be.48ers.dk> <20220609174108.GB3996953-robh@kernel.org>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20220609174108.GB3996953-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bb77887-53cc-4cbe-b569-08da4afcbbf3
X-MS-TrafficTypeDiagnostic: MWHPR02MB2542:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB2542B85C6DC9D9A61DA3FDEACAA69@MWHPR02MB2542.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQhtld/BhhVdAlmloVNKQqzh9RRGN5ufs9dnp/X5eUtS4gnsPCx/keUgPllk1TRUKt3VaBIdy35fh6f6CMG5S8IyYeu7sCw/WaAwg61cJftta1mJwlmlXHSthjNiEOJTRWvfSiXJicxboPjjM2VyvXYcXlWaNb/OSW755DC89hOvDzFU1CVsftyVfas57wsePl/JWYuFYrjKJOAmIGSmYu1FeKyU1ZL1uV8l2wopNL+kvtE0fZkyV3z8LFP+1PdYaPzkoOyjD6vlwQ8HGJQazOHTrmxOfXyqvYBWRFW43WAWvU26+4bfaAwq+OA0b0e8AiJO4BqE6EzDJEc7LY60rpwFJMW7B72QRPAp35Y2tJa2bLAd5y0b6s5GJGCl9IJM9qgV+TQKFgJKUGyRoeoRX+B93KaHHTGgI8l0+6bl1fBGoafxqDB6jHYebQHu04h6++NLipHAZjEWf5AHMHfgTBa8YpF8sw5xqnAvwSS7dcB3w2N7ro+wR8k76SZ+WY9IP+K7I6BuQviQJFQ5fL5MWG4L7jgGw97/FYb8wLw/i63iUwP3fc6sqKazagjDzMyEgiL1E1rBAAzKJVU/LDWvDTZThtMHRC8KVm92bslwQU19ZPzkGT/nvf6Z8EKPgw7xvtWMAYBR/Gdqdqyu9T73Lg9FGvOBRovo+I4yIfCV/m31Kekf741ukV5pf8dG6rollhmktTNgzgNBE/rL4zpyT79zB692HIuTSXMl1EgErBs1+A3FegAn3u8znoFEEmcZ5MozN3CsZKIep1zV3dirx4snUpTy8fAmFtQ2rZ7a/yJOtj667in5ZLmBvf5pG/VRv+T4A0bAxDOJmmmosUniBXuoleBTSeUwaLbLk7PCen8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(966005)(356005)(5660300002)(186003)(9786002)(7416002)(36860700001)(31696002)(53546011)(83380400001)(8936002)(508600001)(4326008)(8676002)(70586007)(70206006)(82310400005)(40460700003)(26005)(44832011)(336012)(47076005)(36756003)(31686004)(110136005)(426003)(54906003)(7636003)(316002)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:17:37.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb77887-53cc-4cbe-b569-08da4afcbbf3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2542
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Rob,

Thanks for reviews. Please find my comments below.


On 6/9/22 10:41 AM, Rob Herring wrote:
> On Fri, Jun 03, 2022 at 08:33:13AM +0200, Peter Korsgaard wrote:
>>>>>>> "Tanmay" == Tanmay Shah <tanmay.shah@xilinx.com> writes:
>> Hi,
>>
>>   > Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
>>   > Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
>>   > (cluster).
>>
>>   > Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
>>   > ---
>>
>>   > Changes in v8:
>>   >   - Add 'items:' for sram property
>>
>>   > Changes in v7:
>>   >   - Add minItems in sram property
>>
>>   > Changes in v6:
>>   >   - Add maxItems to sram and memory-region property
>>
>>   > Changes in v5:
>>   > - Add constraints of the possible values of xlnx,cluster-mode property
>>   > - fix description of power-domains property for r5 core
>>   > - Remove reg, address-cells and size-cells properties as it is not required
>>   > - Fix description of mboxes property
>>   > - Add description of each memory-region and remove old .txt binding link
>>   >   reference in the description
>>
>>   > Changes in v4:
>>   >   - Add memory-region, mboxes and mbox-names properties in example
>>
>>   > Changes in v3:
>>   >   - None
>>
>>   >  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 130 ++++++++++++++++++
>>   >  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>>   >  2 files changed, 138 insertions(+)
>>   >  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>
>>   > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>   > new file mode 100644
>>   > index 000000000000..adfe05ff157a
>>   > --- /dev/null
>>   > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>>   > @@ -0,0 +1,132 @@
>>   > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>   > +%YAML 1.2
>>   > +---
>>   > +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
>>   > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>   > +
>>   > +title: Xilinx R5F processor subsystem
>>   > +
>>   > +maintainers:
>>   > +  - Ben Levinsky <ben.levinsky@xilinx.com>
>>   > +  - Tanmay Shah <tanmay.shah@xilinx.com>
>>   > +
>>   > +description: |
>>   > +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
>>   > +  real-time processing based on the Cortex-R5F processor core from ARM.
>>   > +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
>>   > +  floating-point unit that implements the Arm VFPv3 instruction set.
>>   > +
>>   > +properties:
>>   > +  compatible:
>>   > +    const: xlnx,zynqmp-r5fss
>>   > +
>>   > +  xlnx,cluster-mode:
>>   > +    $ref: /schemas/types.yaml#/definitions/uint32
>>   > +    enum: [0, 1, 2]
>>
>> A textual mode ("dual", "lock-step", "single") would be more readable.
>>
>>
>>   > +    description: |
>>   > +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
>>
>> space missing before "(Dual-processor"
>>
>>
>>   > +      lock-step mode(Both RPU cores execute the same code in lock-step,
>>   > +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
>>
>> "can be" sounds a bit weak, perhaps "is"
>>
>>
>>   > +      core 1 runs normally). The processor does not support dynamic configuration.
>>   > +      Switching between modes is only permitted immediately after a processor reset.
>>   > +      If set to  1 then lockstep mode and if 0 then split mode.
>>   > +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
>>
>> This looks a bit confusing. If you decide to stick to the numerical
>> modes, then at least list them in numerical order, E.G.:
>>
>>   0: split
>>   1: lockstep
>>   2: single

I think the description is fine. for readability I can just add 
numerical order as above.


> The bigger issue has been multiple Cortex-R5 bindings all doing their
> own thing for this feature which is not vendor specific (except TI has
> their own extra mode or something). How TCMs are described is the
> other issue. I've just stopped caring because no one listens.
Values used for cluster-mode property for xlnx platform is same as ti's 
cluster mode property.

0: split, 1: lockstep and 2: single-cpu mode. It is matching with 
ti,k3-r5 bindings.

However, default value for some of the ti platforms are different.

xlnx platforms have single-cpu mode as well.

It will take some time to design system-dt spec for TCM.

So, for now I use hard-code values of TCM from driver.

TCM bindings for linux will be posted once system-dt spec is accepted.

Meanwhile we would like to upstream rest of the bindings and driver.


>
>>> +
>>   > +patternProperties:
>>   > +  "^r5f-[a-f0-9]+$":
>>   > +    type: object
>>   > +    description: |
>>   > +      The RPU is located in the Low Power Domain of the Processor Subsystem.
>>   > +      Each processor includes separate L1 instruction and data caches and
>>   > +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
>>   > +      memory space is non-cacheable.
>>   > +
>>   > +      Each RPU contains one 64KB memory and two 32KB memories that
>>   > +      are accessed via the TCM A and B port interfaces, for a total of 128KB
>>   > +      per processor. In lock-step mode, the processor has access to 256KB of
>>   > +      TCM memory.
>>   > +
>>   > +    properties:
>>   > +      compatible:
>>   > +        const: xlnx,zynqmp-r5f
>>   > +
>>   > +      power-domains:
>>   > +        description: RPU core PM domain specifier
>>   > +        maxItems: 1
>>
>> A bit more detail would be good, E.G. something like arm/cpus.yaml does:
>>
>>        List of phandles and PM domain specifiers, as defined by bindings of the
>>        PM domain provider (see also ../power_domain.txt).
>>
>> And the phandle-array ref.
> Both suggestions are wrong. We don't need common properties re-described
> by every user. They already have a type definition too, so we don't need
> to repeat phandle-array ref either.
>
> The existing description is not needed either as it doesn't provide any
> information specific to this binding. You only need to describe each
> entry when there is more than 1 entry because we need to know what each
> entry is and the order.

I will remove current description as well.

Thanks.

>
>>> +
>>   > +      mboxes:
>>   > +        minItems: 1
>>   > +        items:
>>   > +          - description: mailbox channel to send data to RPU
>>   > +          - description: mailbox channel to receive data from RPU
>>   > +
>>   > +      mbox-names:
>>   > +        minItems: 1
>>   > +        items:
>>   > +          - const: tx
>>   > +          - const: rx
>>
>> And here as well for mailbox/mailbox.txt
> Nope!
>
>>
>>   > +
>>   > +      sram:
>>   > +        $ref: /schemas/types.yaml#/definitions/phandle-array
>>   > +        minItems: 1
>>   > +        maxItems: 8
>>   > +        items:
>>   > +          maxItems: 1
>>   > +        description: |
>>   > +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
>>   > +          the RPU can execute instructions and access data from, the OCM memory,
>>   > +          the main DDR memory, and other system memories.
>>
>> Drop the comma after "from"
>>
>>
>>   > +
>>   > +          The regions should be defined as child nodes of the respective SRAM
>>   > +          node, and should be defined as per the generic bindings in,
>>
>> Drop the comma after "in"
>>
>>
>>   > +          Documentation/devicetree/bindings/sram/sram.yaml
>>   > +
>>   > +      memory-region:
>>   > +        description: |
>>   > +          List of phandles to the reserved memory regions associated with the
>>   > +          remoteproc device. This is variable and describes the memories shared with
>>   > +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
>>   > +          vrings, ...). This reserved memory region will be allocated on DDR memory.
>>
>> s/on DDR/in DDR/
>>
>>   > +        minItems: 1
>>   > +        maxItems: 8
>>   > +        items:
>>   > +          - description: region used for RPU firmware image section
>>   > +          - description: vdev buffer
>>   > +          - description: vring0
>>   > +          - description: vring1
>>   > +        additionalItems: true
>>   > +
>>   > +    required:
>>   > +      - compatible
>>   > +      - power-domains
>>   > +
>>   > +    unevaluatedProperties: false
>>   > +
>>   > +required:
>>   > +  - compatible
>>   > +
>>   > +additionalProperties: false
>>   > +
>>   > +examples:
>>   > +  - |
>>   > +    r5fss: r5fss {
>>   > +        compatible = "xlnx,zynqmp-r5fss";
>>   > +        xlnx,cluster-mode = <1>;
>>   > +
>>   > +        r5f-0 {
>>   > +            compatible = "xlnx,zynqmp-r5f";
>>   > +            power-domains = <&zynqmp_firmware 0x7>;
>>   > +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
>>   > +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
>>   > +            mbox-names = "tx", "rx";
>>   > +        };
>>   > +
>>   > +        r5f-1 {
>>   > +            compatible = "xlnx,zynqmp-r5f";
>>   > +            power-domains = <&zynqmp_firmware 0x8>;
>>   > +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
>>   > +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
>>   > +            mbox-names = "tx", "rx";
>>   > +        };
>>   > +    };
>>   > +...
>>   > diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
>>   > index 0d9a412fd5e0..618024cbb20d 100644
>>   > --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
>>   > +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
>>   > @@ -6,6 +6,12 @@
>>   >  #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>>   >  #define _DT_BINDINGS_ZYNQMP_POWER_H
>>   
>>   > +#define		PD_RPU_0	7
>>   > +#define		PD_RPU_1	8
>>   > +#define		PD_R5_0_ATCM	15
>>   > +#define		PD_R5_0_BTCM	16
>>   > +#define		PD_R5_1_ATCM	17
>>   > +#define		PD_R5_1_BTCM	18
>>   >  #define		PD_USB_0	22
>>   >  #define		PD_USB_1	23
>>   >  #define		PD_TTC_0	24
>>   > --
>>
>>   > 2.25.1
>>
>>
>> -- 
>> Bye, Peter Korsgaard
>>
