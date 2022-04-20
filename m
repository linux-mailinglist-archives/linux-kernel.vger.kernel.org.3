Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3E508905
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376460AbiDTNSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347381AbiDTNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:17:59 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D86251;
        Wed, 20 Apr 2022 06:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5zPNPyTnoesvlEmM6bFeKXmRuKpOd3EcvrR4iq27ozEzdLiXC53wojbLYV1EHeTOVKsB6gcy9IRRzsLt/pO0HxU0mVf/sfmQQyyxPiMseUFuryTyLRLp8qJD9jRYbIMbgnAsWP8iShcV+mrAUNjpdjC1tTQ0n04TEVb7u/D4DkixzJ1ekFb05GV2a4Vm7Aji2s3lTZpLg6FPrwf7Zns8/nvVJCXI71d2lwiL7D4gIvFN24YA3LiO7dOz8aXGZ/kqh61dOnYcPkYSg4MN4Asu6bPmK0GuIkeF20ab0zYb76LYXLpYJvH/0vvm2U2xMY6A01DPznyKB4yDxqLiqkCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1onWfq4sOwQhls3l/I2R7puwWFOXLhwg/ZURYFBvBY=;
 b=aJlGgC7RihpLcy2HGkn5nlJin976rcJaJvYgjRI8LaZWQpzAlbSJS3ODM2sfC8nMyU4M3qY88Yx+R59RJnLiECsQDok8eEtUnQMmL8PC68MPgD1GCkvNQOJWb+jdD8A5EHIYibCVNf6/8m+J/FQ0Z8P9ekskGp7FAK4dlGQ2CFJ4VR+e3GnrTtr5INLdVLTzXKwoIlrSuFEHQ1IvSfNjLnZL9dcxFprnZR4xw+CJUT3G7CM8/fWJzLfqmjf/R6cptjWa2elWoqKezp/ApWoAirw/Dd/9mW1EcgS874RnMwpjEm62TKoUl8lNHE1zWchX9PUlul50j68xT7tHsRk4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1onWfq4sOwQhls3l/I2R7puwWFOXLhwg/ZURYFBvBY=;
 b=r5FmvYqhPTUv2gJlrrJSNemGuKhSgUJPxumRaAU8wOgtxifY2ob+15l4KDNMMSRnusaVH5wyaGj3+zYpX75Zzq9cITJxuA45tFzqNQbWeD7dAaOAM2MWtLR9kICFkUF+0EKzt2Kpk5RNGuryRdkIQb7WHy3xnjLOb6QHOhQUPudSyhlM3b137Eek6AtWK/tsqDVvFgN/U6rB2Fb+8iz04VQfLe3iIOd+nnZtpliihC9AUNsJ4e8UiDqY1+4p9XkyxKhNDIU2U3eEXMzMXcXN4fMPQoNzg/AcM690yYu+1WJCr2bUkgRUDRkGqv1ZAQbmmd3kVAKSzS3YV5J+KAq/Zg==
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by SN6PR12MB4749.namprd12.prod.outlook.com (2603:10b6:805:e8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 13:15:11 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::21) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 13:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 13:15:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Apr
 2022 13:15:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Apr
 2022 06:15:02 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 20 Apr 2022 06:14:58 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <robh@kernel.org>
CC:     <akhilrajeev@nvidia.com>, <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kkartik@nvidia.com>, <krzk+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <mkumard@nvidia.com>, <mperttunen@nvidia.com>, <pshete@nvidia.com>,
        <rgumasta@nvidia.com>, <spujar@nvidia.com>, <tglx@linutronix.de>,
        <thierry.reding@gmail.com>, <vidyas@nvidia.com>
Subject: Re: [PATCH 1/6] dt-bindings: timer: Add Tegra186 & Tegra234 Timer
Date:   Wed, 20 Apr 2022 18:44:57 +0530
Message-ID: <1650460497-26715-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YlhmAQsZVU92OZ3W@robh.at.kernel.org>
References: <YlhmAQsZVU92OZ3W@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97cdfc88-0bf4-4e4f-be7a-08da22cfcb58
X-MS-TrafficTypeDiagnostic: SN6PR12MB4749:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4749D931D28FEA22E3396F07CDF59@SN6PR12MB4749.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LiuTF4KInAaLIzYomJCXAQS4ImHL/+TRxiKaRMbuixFYHK5buq+I0mLzhU9/qWqhrLYRb3y10bGgeDV/aDfDDYhq9NKK1oyyr+O6UVFiK0FxCoupYe6KpwFpaOAu1WDAG95RObhoCUpPu7nFQdF5KwpvCRt1QciPoMIXHnuyciiSCzCXTrgkb6AmNAjarsorcTSajL6RhzHoUaJ39jV7qMVB3GYh1iGwUGfj69g1G4UeIb394elJpEnznNuigapHFDhOoX5ieCqwxhaNFExxgb/C/8XK+THiTt7fY8C1hL4xUT3dCtcLDzlchLsaBvx1H4PO2WQeXj7P231yI8ZfIn+22kmvuGNllL8gd9sY0VdoUHKKiJjPV9V6+SwYCEdKEclsPow65E+FQPWdEyTXLwSiaEqY1g8D/829nvLN/qyqqu18uGpprCiZHPkqYOGuwajuO8ny4LoM88x28e9v5gUkfbTcbPo8UONWOlUVd7rPSxoeTl2VUSMxI6ErYvzSWouFxIyZlzsAOtWLt+C6eWMLhr+Bmy1nw4DhLmh6OvRY+Golsq8vQZhP53OgGSmaOplPeFhDWpetd4GlFNcWOrMDQwDIiXzKsPcL6qP8o4QGeDtRiq8RWpF0Vd8tZ+rXIrv8af0qGNB8HHblmr0Pew9BL0gquUsbPv8zyUaVx53TUVmMqE3IvWzTNYPqR1Dyl5TxIH8/kM23HgpzT4/QI5xqsEy1f6ZTPUziBzFcWO1SDVOXs1DKwDsb3jpXrGtwlCkQWw9IVlt7reYxTeZIkdUS9BJkSLnuOonUjhZSM7zHd14E6BsJO8RYEL7hM0XabT0hLhpmGHc56wLd6i/c5A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(8676002)(70586007)(86362001)(70206006)(83380400001)(40460700003)(8936002)(5660300002)(82310400005)(7696005)(186003)(4326008)(107886003)(426003)(81166007)(356005)(2906002)(2616005)(47076005)(508600001)(26005)(36756003)(6916009)(53546011)(336012)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 13:15:09.0105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cdfc88-0bf4-4e4f-be7a-08da22cfcb58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4749
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 18:20, Rob Herring wrote:
>> timestamp counter. The Tegra234 timer provides sixteen 29-bit timer
>> counters and one 32-bit timestamp counter. Each NV timer selects its
>> timing reference signal from the 1 MHz reference generated by USEC,
>> TSC or either clk_m or OSC. Each TMR can be programmed to generate
>> one-shot, periodic, or watchdog interrupts.
>> 
>> Signed-off-by: Kartik <kkartik@nvidia.com>
>
>Full name please.

This is my legal name.

>
>> ---
>>  .../bindings/timer/nvidia,tegra186-timer.yaml | 116 ++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
>> new file mode 100644
>> index 000000000000..7841a68d19f3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
>> @@ -0,0 +1,116 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: NVIDIA Tegra186 timer
>> +
>> +maintainers:
>> +  - Thierry Reding <treding@nvidia.com>
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nvidia,tegra186-timer
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          # Either a single combined interrupt or up to 14 individual interrupts
>
>This can be part of 'description'

I will include this in the description in v2.

>
>> +          minItems: 1
>> +          maxItems: 10
>> +          description: >
>> +            A list of 10 interrupts; one per each timer channels 0 through 9.
>
>Is it 10 or 14? I'm confused.

My bad, it is 10.

>
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: nvidia,tegra234-timer
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          # Either a single combined interrupt or up to 16 individual interrupts
>> +          minItems: 1
>> +          maxItems: 16
>> +          description: >
>> +            A list of 16 interrupts; one per each timer channels 0 through 15.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: nvidia,tegra186-timer
>> +        description: >
>> +          The Tegra186 timer provides ten 29-bit timer counters and one 32-bit
>> +          timestamp counter. Each NV timer selects its timing reference signal
>> +          from the 1 MHz reference generated by USEC, TSC or either clk_m or
>> +          OSC. Each TMR can be programmed to generate one-shot, periodic, or
>> +          watchdog interrupts.
>> +      - const: nvidia,tegra234-timer
>> +        description: >
>> +          The Tegra234 timer provides sixteen 29-bit timer counters and one 32-bit
>> +          timestamp counter. Each NV timer selects its timing reference signal
>> +          from the 1 MHz reference generated by USEC, TSC or either clk_m or
>> +          OSC. Each TMR can be programmed to generate one-shot, periodic, or
>> +          watchdog interrupts.
>
>Move all this description to top-level description leaving out the exact 
>number of counters (as the schema defines that).
>

Do you mean it to be this way?

title: NVIDIA Tegra186 timer

maintainers:
  - Thierry Reding <treding@nvidia.com>

description: >
  The Tegra timer provides 29-bit timer counters and a 32-bit timestamp
  counter. Each NV timer selects its timing reference signal from the 1 MHz
  reference generated by USEC, TSC or either clk_m or OSC. Each TMR can be
  programmed to generate one-shot, periodic, or watchdog interrupts.


properties:
  compatible:
    oneOf:
      - const: nvidia,tegra186-timer
        description: >
          The Tegra186 timer provides ten 29-bit timer counters.
      - const: nvidia,tegra234-timer
        description: >
          The Tegra234 timer provides sixteen 29-bit timer counters.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    timer@3010000 {
>> +        compatible = "nvidia,tegra186-timer";
>> +        reg = <0x03010000 0x000e0000>;
>> +        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +        status = "disabled";
>
>Drop status.
>

I will remove this in v2.

>> +    };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    timer@2080000 {
>> +        compatible = "nvidia,tegra234-timer";
>> +        reg = <0x02080000 0x00121000>;
>> +        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>> +        status = "disabled";
>> +    };
>> -- 
>> 2.17.1
>> 
>> 
