Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C89540871
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349182AbiFGR6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347513AbiFGRjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:39:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D963586A;
        Tue,  7 Jun 2022 10:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmy6mOPYYf+Gtb/FCcqasVnHpCa2RX/ymTHP5FbznexvKwfDS5ivHJl3SN8u+FAdxRj0oa3xa6KfZzbkcRQfNjw8tB2+JGmcFgmOOW2R0yYNEaXubWAJP8MZCpxcPutRaoTA+7WplXCnYOMR0ZnKBvqPEaU+jPWVKAclRWvSSolmqK0Fsc0MPHyN0+5gmkmRPN9acT375xcV2wA7XCjvgDlN8IlWfOQ/4r6ENTcdiWHIc0NUIM/K81s34AHoOj/SGoei/nngc/I2FomJa39C1Mw4ATBFbFU7f17rCYoqlU/jC7Vp0kp9Bol20fwOiiVdVRYXLrguVW8N8x7qeid7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpeKYTZ7UnKSjTRoAs/0IMlIlrk4G0DiECmMV/uMlTc=;
 b=bNUo8yd+cutws9SowSKdznQSYulAae0nhrLgfy8sRdGb034lyfCQU9jd9CADcEzs4dg5dN/kMoqT6pivE/59K33A+aCgRQ3RW63Jm5NT10n1S6JP3Gw8PYz338dcmiXwli1nv6xsoGmQCMYdsrhC7WRWDScNT3Tiu9MHvpmPNvQKJ10dADNrxDVSQZTMbAG6DLkjfCtdGsX/dBTdH1RugrzGvHZHbw4165sm+Kj/+Houe9rZX4PcodRRRzMVR79r7R7SK9FWBHEVzvzwZJr8WMBs7vsTo+hY2crH0cWp7jgMCsVH1QABWCFix0y8XEY51D+o0N07aCcuGuGBl3cGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpeKYTZ7UnKSjTRoAs/0IMlIlrk4G0DiECmMV/uMlTc=;
 b=pitU8x1YC87JFKE5N54t3YDEJ1Z3okEGZFn+DqIsVhXgmq+1mMNPYN2SzMJAXydMiE9VAFniwbuo3FN3rpmjOlcRJIps656rSF4NPC5RVfzn3yYuELjgAzoSpMKV1JhZeKGe+j4RxT5eyOQxKJovMpA82rFv5TDWpWos7AnxJII=
Received: from SN6PR01CA0034.prod.exchangelabs.com (2603:10b6:805:b6::47) by
 DM6PR02MB5116.namprd02.prod.outlook.com (2603:10b6:5:4f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Tue, 7 Jun 2022 17:32:49 +0000
Received: from SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::8f) by SN6PR01CA0034.outlook.office365.com
 (2603:10b6:805:b6::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 17:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0026.mail.protection.outlook.com (10.97.5.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 17:32:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Jun 2022 10:32:49 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 7 Jun 2022 10:32:49 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [10.23.123.50] (port=63598)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nyd4T-0007JE-39; Tue, 07 Jun 2022 10:32:49 -0700
Message-ID: <9722112e-770f-53dd-4b28-48be696c0d12@xilinx.com>
Date:   Tue, 7 Jun 2022 10:32:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
 <20220602203834.3675160-2-tanmay.shah@xilinx.com>
From:   Tanmay Shah <tanmay.shah@xilinx.com>
In-Reply-To: <20220602203834.3675160-2-tanmay.shah@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eef0a148-d917-4fde-11e9-08da48abbe41
X-MS-TrafficTypeDiagnostic: DM6PR02MB5116:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB5116BCEFE83982121B56FBDACAA59@DM6PR02MB5116.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQvcEqsOxkMpUutE3YUm/AjyH9mR03NwTt5ryXbegeoMxcqIgFUS7OA5A8pdAyJCGd6QimDk8TSnoM38P6hvBoVCczkk8g3t81aTq8UMhuGVIisijszKjNJ/zDaP7xFLcIQ/KKHRhFFtBRrjm8IhRYkNJZeORVj0n37MNz/rU2xmHpqvKvGqbKpx9irzr7htRb5gnoBUzG4g2GYCnACyZZBoNRJ5sDre1UIXc3X2VehHv0jbBUlqnSn7xKYkCgSHYZPDXSwSiVbiT8svO/OBMjW5WepD61oN0JvJTe6gbfRFtBGKMSkBZi1xq+J7McC6y8O3F8kDbITiLvamxjiLgaq1GdpPP8P+1R+c6/LwBfQNYn+wdXBUdypZhDMJhfj2DU65wuYFPVNCyTJrpZvWrMrTu+yteResuWiZ99dz5Xmy2tVDYJQ93PKtz8BMsuV5nR8R16gTKp+wmRI8TeqE+HTl09GHSSFT69SGhyJIgPxliNJneUd0oMInpVjJfLKo8L5J1sA70XRTZZKu5/qXXR7AjX89EAtjH4OiDwUenvaQ5Py6V+MxSYurKlSryq+VcvfV94T7r9wSMe3FYZuS7WVSasuItRGJiCIiKaLhsWS5o2IZee9rPLcK4wthxY1KRMuLj964ph13bjWhFOJOyDU/0b2AsOsGe6LHD95va+2K1vnwADEgdYrFy7BhZyiQlVcZHlg4FDbOtdL5bMfAAXNMszyfq+ZlDlNEsdd9b8BW0dayK23ZCrlK6OYUXlz3r4Vzp8gzJZUgYY3VdEVlFOaSUARLaxILkfI0AQr1/G3RJSXg2GhmpVKrOcvpfujAkV5sGuPZylQZLy0lZ+kti/M9912U7tKLnroQ+IEtZOM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(5660300002)(356005)(316002)(44832011)(9786002)(7636003)(8936002)(53546011)(70586007)(82310400005)(8676002)(70206006)(4326008)(31686004)(2906002)(31696002)(54906003)(36756003)(6636002)(83380400001)(426003)(110136005)(47076005)(186003)(336012)(2616005)(508600001)(36860700001)(966005)(40460700003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:32:49.4108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef0a148-d917-4fde-11e9-08da48abbe41
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5116
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Ping for reviews.

Thanks,

Tanmay

On 6/2/22 1:38 PM, Tanmay Shah wrote:
> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> (cluster).
>
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> ---
>
> Changes in v8:
>    - Add 'items:' for sram property
>
> Changes in v7:
>    - Add minItems in sram property
>
> Changes in v6:
>    - Add maxItems to sram and memory-region property
>
> Changes in v5:
> - Add constraints of the possible values of xlnx,cluster-mode property
> - fix description of power-domains property for r5 core
> - Remove reg, address-cells and size-cells properties as it is not required
> - Fix description of mboxes property
> - Add description of each memory-region and remove old .txt binding link
>    reference in the description
>
> Changes in v4:
>    - Add memory-region, mboxes and mbox-names properties in example
>
> Changes in v3:
>    - None
>
>   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 130 ++++++++++++++++++
>   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>   2 files changed, 138 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> new file mode 100644
> index 000000000000..adfe05ff157a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx R5F processor subsystem
> +
> +maintainers:
> +  - Ben Levinsky <ben.levinsky@xilinx.com>
> +  - Tanmay Shah <tanmay.shah@xilinx.com>
> +
> +description: |
> +  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
> +  real-time processing based on the Cortex-R5F processor core from ARM.
> +  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
> +  floating-point unit that implements the Arm VFPv3 instruction set.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-r5fss
> +
> +  xlnx,cluster-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    description: |
> +      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
> +      lock-step mode(Both RPU cores execute the same code in lock-step,
> +      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
> +      core 1 runs normally). The processor does not support dynamic configuration.
> +      Switching between modes is only permitted immediately after a processor reset.
> +      If set to  1 then lockstep mode and if 0 then split mode.
> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> +
> +patternProperties:
> +  "^r5f-[a-f0-9]+$":
> +    type: object
> +    description: |
> +      The RPU is located in the Low Power Domain of the Processor Subsystem.
> +      Each processor includes separate L1 instruction and data caches and
> +      tightly coupled memories (TCM). System memory is cacheable, but the TCM
> +      memory space is non-cacheable.
> +
> +      Each RPU contains one 64KB memory and two 32KB memories that
> +      are accessed via the TCM A and B port interfaces, for a total of 128KB
> +      per processor. In lock-step mode, the processor has access to 256KB of
> +      TCM memory.
> +
> +    properties:
> +      compatible:
> +        const: xlnx,zynqmp-r5f
> +
> +      power-domains:
> +        description: RPU core PM domain specifier
> +        maxItems: 1
> +
> +      mboxes:
> +        minItems: 1
> +        items:
> +          - description: mailbox channel to send data to RPU
> +          - description: mailbox channel to receive data from RPU
> +
> +      mbox-names:
> +        minItems: 1
> +        items:
> +          - const: tx
> +          - const: rx
> +
> +      sram:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        minItems: 1
> +        maxItems: 8
> +        items:
> +          maxItems: 1
> +        description: |
> +          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
> +          the RPU can execute instructions and access data from, the OCM memory,
> +          the main DDR memory, and other system memories.
> +
> +          The regions should be defined as child nodes of the respective SRAM
> +          node, and should be defined as per the generic bindings in,
> +          Documentation/devicetree/bindings/sram/sram.yaml
> +
> +      memory-region:
> +        description: |
> +          List of phandles to the reserved memory regions associated with the
> +          remoteproc device. This is variable and describes the memories shared with
> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
> +          vrings, ...). This reserved memory region will be allocated on DDR memory.
> +        minItems: 1
> +        maxItems: 8
> +        items:
> +          - description: region used for RPU firmware image section
> +          - description: vdev buffer
> +          - description: vring0
> +          - description: vring1
> +        additionalItems: true
> +
> +    required:
> +      - compatible
> +      - power-domains
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    r5fss: r5fss {
> +        compatible = "xlnx,zynqmp-r5fss";
> +        xlnx,cluster-mode = <1>;
> +
> +        r5f-0 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            power-domains = <&zynqmp_firmware 0x7>;
> +            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +
> +        r5f-1 {
> +            compatible = "xlnx,zynqmp-r5f";
> +            power-domains = <&zynqmp_firmware 0x8>;
> +            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> +            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> +            mbox-names = "tx", "rx";
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
> index 0d9a412fd5e0..618024cbb20d 100644
> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
> @@ -6,6 +6,12 @@
>   #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>   #define _DT_BINDINGS_ZYNQMP_POWER_H
>   
> +#define		PD_RPU_0	7
> +#define		PD_RPU_1	8
> +#define		PD_R5_0_ATCM	15
> +#define		PD_R5_0_BTCM	16
> +#define		PD_R5_1_ATCM	17
> +#define		PD_R5_1_BTCM	18
>   #define		PD_USB_0	22
>   #define		PD_USB_1	23
>   #define		PD_TTC_0	24
