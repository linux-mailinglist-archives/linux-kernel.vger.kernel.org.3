Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31925AF836
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIFXDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIFXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:03:07 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E20832F1;
        Tue,  6 Sep 2022 16:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvaqr/6X6SObIie6bpD/xYM8L6ca935vwUCXkrtHoJBYpo4UOk8O4xqyhRL9Fqoi8UDDeFnpDGmO4h+vUT4/V6Ez3qag6N7Yc2IXX2VySEoEwWXOFq4JO5SkBRSkDU+P4QxfqUubtcZ4C8fDqiPkMVger51aIUsdXbncZOfB4VAy8YpJTiMRPvz+IYexqv5SXHxB9KvUS/6gltHeuyNtMQgrpCOMcsP7lxjiaewJkg1Gw2FkC4iIKrCtZERQbJVlYWg5D0f1/QlaLOvfU/vtALEsdFLgFrFfJSw6yEmL8kghZ4yeSkjF0VSyK6O2OvGEmtGxCarx0rsvslM3LZU4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WxPuD2GIey32QF1UEmeeLPQTrnyVw7Sbeq6revEmEU=;
 b=DvVrKeNttz+gCODJhNfz1oU31rL98zWXMiZu/T6hFS+UAQBmSMTd40AiJLZdqtKTL27LSKCDnfB8PLm8vN6BAZGqOol+249HXBVo03PXOhynxGcYw1Ashwx76xIRA6fIeeHF2CB+IkrMlEgQWzd/xUtbQLSTcwmGIbnUmJbUKuWYJ+jc7BqOrD1+d+cnpJbqtRT4V8zbQkuvzqYMl9R/6LbKOudQ+oOzLMPszuPL9Mx8Ja5B5dyOVJzipvO9sqKgqvH/cY6Tct14uVxtg+6vWvLgs+YJaN8BBBjZoCkU80wWVYwm0Pi+N/zoiFt3rLXnngv5CKGb7SEKAfzYD+iJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WxPuD2GIey32QF1UEmeeLPQTrnyVw7Sbeq6revEmEU=;
 b=izs6Pha1CYwtnNr5Ks2QRS44WE6zrDHQCjtjERKXZT6ylN/9/dSdqso6XiBQy5z2NtgKSKcDW9JuvRthLzFjE+3nEyiL+nGz8PniYhmt2S5RnC16D0rum8USAGS5oRClm1MayOSlKSSj26Sr0ZMegMSCEbvT98VD8tNlqcafsDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 23:03:04 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 23:03:04 +0000
Message-ID: <88cd4242-828f-93a4-2adc-1f893ebf037e@amd.com>
Date:   Tue, 6 Sep 2022 16:02:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v9 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem
 bindings
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@amd.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-2-tanmay.shah@amd.com>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220708013955.2340449-2-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::8) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdb43487-59be-4155-28d2-08da905bf428
X-MS-TrafficTypeDiagnostic: CH0PR12MB5154:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gza2z2iXDBL9a6SMajm335IoLduHjCO8pBlNdqMHjD6aen9qrLN6zXisVvy3mb1Kle8gNx2YiPFWuam/dpD0ytUA6ORc3gyk6ueUo0s8RP72tYtEkyTdyT41I76v9Y/ALJM7zWBEiR83zx3biPjy7/2Z884C8u3TrThR4wKPCMUNFPJ7JoQKLY4XVKWs1l2ibQM8NnFtRVLiGmZd4TS1DtJD7Y9C5mJhghzpYi94kU34xjw+uXHmFs5DlqgrJ/Jp50Vtjd0gC72/jjDZYHXUzw1DgE/RHXcR9a7xI2VXr6GkwkmY7KR5o9kP1WJqB5rctQm4s52WAQ4sqxwxiFURIAvZldjxAtPwCW+/y5faZIi5TIEhVdRiIeYb/iB6GlSFj3cSv+B8IbCOWy/VkwyjdlBntRot3mfbMOjlyfeljj7sD54WgENaBZvheG66/LSko3LIAmukr/9CMp/1yWGfXzmQtcUK/2qVjrb/IFPfoI2MqfLGFaRpJaxEUDWZdErdwPe8Q0ZyZzCul0yXKUj4jV6rfLyZfRmR+DUesb1Wpgq4MGR3ojG9wV99IVa5UVRs1AnJ8f61j4EDxb+3D2du0bmMtxPv70w4cs8I9zdqZ5eZ9411h2JCfGDPwo//YMnV1ZxybAJJT9GvVEX6xeRmOxECOUQujhC3iyPurp+MkzFw0AIqa7IllsTBgsbt+ZAKqiCwVsod08QL7tKXw6gc8x6QVoyaMndHKH9Sjld5Gou1ME4J/t71M1i/DxO3dJAS5zB6ekPoMZwwHVUWVsz0GikJIr7v7nSEeUdMUKH+tP3FYEl9/jL/WsQmRldBhJXcNOB9hefzXxcWX2vziWZX4D8aLtQYKNaTTx20b/Mu3m0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(66946007)(66556008)(4326008)(36756003)(8676002)(66476007)(38100700002)(31686004)(31696002)(2616005)(83380400001)(26005)(6512007)(6486002)(53546011)(6506007)(41300700001)(6666004)(966005)(2906002)(316002)(6636002)(478600001)(186003)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNsK2k5N2dVOERjN3dFUWtqYnozWkg0QXhNV25EQkl2Z0pNcThOZzR4ZjUx?=
 =?utf-8?B?YXpwRC9mbUVrcTk1R1AvS3ErbjFocm55Z0VQaDBtdGkwTFJMcFlVN1hTV0RS?=
 =?utf-8?B?K2JTWXJWQVFobVV3V3RBeno4T1JYNHE0TnVUa2U1NVJTT0FmVDRMNWhMSXpr?=
 =?utf-8?B?OUN1YTE5TlRCOFIrK3ZSUXU4cmtteVdnYmZHUlo1dUY3RWJIRTQxQjRuNVBm?=
 =?utf-8?B?UFZFTERtODNuNmtod1phUjBRY1l6WEFjQmk4aWRORlpHdTYzenlOcS81TE1Y?=
 =?utf-8?B?QUR0Y21xRlFlSkZheGkwZFR3dEtlbUVWVW9TOXVuSWl0QjdGUXlQVHhiTTZC?=
 =?utf-8?B?TDYzZm5IUzZEQVUwYmd1OCtCdmo3WlFFZFVzYjlwQ0FyVmR4aTc5NzNjY1dG?=
 =?utf-8?B?K0VUSVZqazFzZjljbXdIWTJ4MEVsODMxZFhCL3VKSHZ0bllWcGhtb0piNHhU?=
 =?utf-8?B?MHNXWmtGL1MxemwvTCs2dGRGSG4zck8xZ1R6bldFdWQzTHBVSE1PL3Y5V3R6?=
 =?utf-8?B?elpaenVmSVdETUxTMlZib2Z1Y2V0VmNyOXZiaUxOb3NPdElrWGFvcjhXOHRK?=
 =?utf-8?B?RnVyMWRYY2lKQkNicnBxU2ZFUmwrQmNyaGxaUlRWd2ltZkNGYzAvL1NPTFo4?=
 =?utf-8?B?cytldHFrdHhaZlhlREExN3NINzJ2b2VhZk1MeWlteVBhZWFMOXFUdHhGZEhQ?=
 =?utf-8?B?TlIrTEQrZG41MWVCWmdBUnF5cThObC9Gcm1CZWJqTU03aUZVamc5OHR1NUNR?=
 =?utf-8?B?dTJIOXIrWm5ONTRYVW9zWjl1R29pM2trQUlISXNuS1lhdnBMUDV4VTR2cUZx?=
 =?utf-8?B?WndkWitZdXhrdWZNOHFDWFdsRkZ6bXB5RklqWVNGNXgzMnExSXVmL2lJam5J?=
 =?utf-8?B?a0NwZkxGaUpXNWhnTXBaOTY2UjFEb01ZK21SSktTMTBnNitlWUYxZkpHZjV2?=
 =?utf-8?B?U1BXaGdyY1NzVDAwV3hiY1VZTG53ek9UZElFTk9GeVRvTjZRZDNUNjQzUm9Q?=
 =?utf-8?B?ODJkQllsN05VOTdkTDY3MCtkYkwydnNvSDdwcEpsbUNKNy9sbmdieVJ1SjJh?=
 =?utf-8?B?UHpDdUtGWFBGTEdla2podDVpdVJDbFV4dlNKUnd3ZUhMcFJ3RGlwNHRqZ3RI?=
 =?utf-8?B?QXppTk5NL0NwUC9ia1gyQUVudHNVNWlXbEo0eXZNUGZYYWlaeldydHpBYU1N?=
 =?utf-8?B?WUJSUWZTbmxoMXRGQzZxL3RHODVjNVp4MS9MeEp3TXdUQ3ZOak10MzdvRnpP?=
 =?utf-8?B?aWhRUU91Yms1RmdPdlBYNytKUkRUOE5ObDFIQjVuSjc2S2k5YmRBMzNKUnRH?=
 =?utf-8?B?ZXh4MkRqN3djeFZQczNYdlNuYTBaYys1MlRrZGRicDlKWWtseDhaQzZDNE80?=
 =?utf-8?B?d1dhN2h0eUdEOEJtK0JNdld4L2s5Qk5WRHpXVG9wMkRKRlhSaDdIZUFVOExz?=
 =?utf-8?B?VlNSNm9CTDVDVlBqbzhtcTRzUzVDMVVVRC9NNnRTQU81aE0vbFZuamE4NWVE?=
 =?utf-8?B?RFlLMDY0Z3ZlT3JxOHNaSmRuVm5rbXgvREM3Qkd4b25uVFZ2NG0xUjRVSkpm?=
 =?utf-8?B?ZCtKVi9tTVY1eSs2Mis0OFBPRnRmUzJ0WkQ1TEk2UTE5UDRBZW9qTm1wS1hw?=
 =?utf-8?B?bU5hODRtWjhNNnJzSStNTitoQm1SOWwyNTQxblVXV1ViUGpaVnZPYjlKMVA3?=
 =?utf-8?B?K1hLMDRHVzU2Z04rYVd5endYcGZlQ0lCNXFqc2c1Vm1nTzZaRmwvNy9lc3JY?=
 =?utf-8?B?MDRRTFJ0MFMvMGIzeFR3OWZ3eHkwT3k0TW1QOWIrakw0WWovZXlEd3BTM29y?=
 =?utf-8?B?cHd3THJ5ME5VM0cwMldTQjhJNHI5QUJhSGpUeEhxRlBzN1EveWVVRnVIVE9H?=
 =?utf-8?B?N0tqL0QrUXg5d2xiSVVzTU5hRXJqOWIyS202S2FKaVduZHVrRVBDeFBmMGs5?=
 =?utf-8?B?T3ZETkxFVmNOWEFOcllkZEE5Z1NQSklleTlmRTNzMitaNVg0K2NNSG5DRC93?=
 =?utf-8?B?MkwzMHpxVUhVYzF1dVVpaGRLVmloR0kwZUhlalRaS0MvaENmeGFaVGFKWFdn?=
 =?utf-8?B?UlpoK0V6dnl3T2hUNjNQQ25aTE1jVHdpRjRYbElxekpIZVQ1ZUpibUFINVBx?=
 =?utf-8?Q?KfW1blebnCFP2m6AAhh7Dagal?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb43487-59be-4155-28d2-08da905bf428
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 23:03:04.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRDnmCxKSS1eHhHMslwE3kMBCSB7XzGI+giVssoxDX7To9nJFhZ/RI4XUK33INiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers,

I have received reviews on driver patch (6/6) of this series.

Just following up on reviews of bindings patch.

I am not sure why it shows as pending reviews here: 
https://patchwork.ozlabs.org/project/devicetree-bindings/list/?page=2

If anything is missing, I can fix in next revision along with other fixes.

Thanks.


On 7/7/22 6:39 PM, Tanmay Shah wrote:
> From: Tanmay Shah <tanmay.shah@xilinx.com>
>
> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> (cluster).
>
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>
> Changes in v9:
>    - remove power-domains property description
>    - fix nitpicks in description of other properties
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
>   .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 135 ++++++++++++++++++
>   include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>   2 files changed, 141 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> new file mode 100644
> index 000000000000..56b4dd1d5088
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
> @@ -0,0 +1,135 @@
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
> +      The RPU MPCore can operate in split mode (Dual-processor performance), Safety
> +      lock-step mode(Both RPU cores execute the same code in lock-step,
> +      clock-for-clock) or Single CPU mode (RPU core 0 is held in reset while
> +      core 1 runs normally). The processor does not support dynamic configuration.
> +      Switching between modes is only permitted immediately after a processor reset.
> +      If set to  1 then lockstep mode and if 0 then split mode.
> +      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
> +      In summary,
> +      0: split mode
> +      1: lockstep mode (default)
> +      2: single cpu mode
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
> +          the RPU can execute instructions and access data from the OCM memory,
> +          the main DDR memory, and other system memories.
> +
> +          The regions should be defined as child nodes of the respective SRAM
> +          node, and should be defined as per the generic bindings in
> +          Documentation/devicetree/bindings/sram/sram.yaml
> +
> +      memory-region:
> +        description: |
> +          List of phandles to the reserved memory regions associated with the
> +          remoteproc device. This is variable and describes the memories shared with
> +          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
> +          vrings, ...). This reserved memory region will be allocated in DDR memory.
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
