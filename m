Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD456166D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiF3JeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiF3Jd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:33:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C73EF21;
        Thu, 30 Jun 2022 02:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLSDy7/czhsUJ+7W0JXd4L2WK/qTGm7YlIS+gzORadN5RAKixwvQz/3rSWTn5bzHRZbJwzarWjsBPy2kTb3t/ilGlcA+zJxOGdoTImu2EM3ByVdz19u3OLiw+Us07WUKL6f2jActHd+GLHu35tfYP1YpzbqESaWs/rsa3Ux0dB5E8K+3HWK6plcUu79vPZns3b3HwPHbdOtDkd59C3AGWnkzEIzNhuS73seEr7fvKfez8Y58oLNAwEarmAI4/KmPWZaUAqHqsItcBb3zvWTG8vF5WfiDObrQE0b944nABf3Vd6U0JXlQtZjLj/eg/wt36wLlGHp1qjfRTEQW8Csq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsl6b/PWwOhRsS65A8ZY8teTkJs0tS/scjs2aVlhq/k=;
 b=LhEMKVQBVRFXSqcjHgF+Cakm3EwOx8eS6leP+ohkLAcmdFe0J2Ep5t1Acz1mwBF/+DK1Tp0u2VXgtvUKOYLUV0S/baFoXaocj84uEDn5nFrldrgY9xCGcKwZ7eI9JIWSTYRUhNoOaVzpYnR1uBQ4S1WMWdjBb5BIhirQScQt24wCB3cs2iDOnoFg5m65C/Z6GMnSHjKivkE7wvGnAkAEz534rcEx/GTrxN6M6/zP0ZPWR/7ngEB4ofnW0VKqfdmXe72Ng1tIJRNshxfQzcTHJSVVmjORVUy2eAf2dtWcI6Zih1v25iDTo2Iqc0xd3YLuE+75LMLYZXdS5tSGOwX/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsl6b/PWwOhRsS65A8ZY8teTkJs0tS/scjs2aVlhq/k=;
 b=IryUkb/hLUqWf3YYkunD83c6Iw6Fup1ff132LmsSZzlzy9XPfxhgcCOmhmRtTwCCKdZ9ItenrQB9IMfXw+g1P0duBoQ8L3IQ5BolbJjCX543OHurK93p2eJGWfd+4YtzCKWL09uG7/Msg7nSJaSDzpIxrmZv2DJQ5PDOhiEN0YeQOhv9Yhz8DDCB9ShUav+e//2dVyP3PGGs6xGEofaC3otxCk4tKRBCrYtcWRSl7MQ0skhVwWRJ0a2ghN6TzeY7XwyBs7+gFFT6uZhCPMTpxqcEhBsmVb/203bAdRq/6TXOjnkR/5/uy0krG6e5LQ+WFD0WF2bi9whzUsjVnlnKpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 09:33:56 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:33:56 +0000
Message-ID: <17e4590b-a3c1-6d45-4dab-f06537f46396@nvidia.com>
Date:   Thu, 30 Jun 2022 10:33:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/6] dt-bindings: timer: Add Tegra186 & Tegra234 Timer
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        thierry.reding@gmail.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-2-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1656527344-28861-2-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0381.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab4ca8cc-f917-4e1a-f0e4-08da5a7ba707
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3dYSjNENlJRbHEwZytIS2lBNVRWb3RXNy93WVdSVkppSVlGYnFxd2RlOVlB?=
 =?utf-8?B?aGRaaTBuQmNIbVcyK0dVMkF4dnIwcml6VWZTNzJlcE5zb1pmbDF3ZVV2S2x4?=
 =?utf-8?B?MlM0VjVJVkhPYUhsNTZuZm5MbG12UXBsSUpIZTAzQ0Z3b1h3bDMwUXJWb1Vt?=
 =?utf-8?B?anJlZzNTVjgvMElTOVFOVlVMbDIrNUhnODJMb2wyMDc5N0ZLWmdydWU4VkVs?=
 =?utf-8?B?cXR0ZGlyaGpKcWgwREFSV3ZkdWdRVDdrSjZGYXlCeGx0VEl6TWorNGwrci9m?=
 =?utf-8?B?SG12Mk9vSmlORDNYRDFoNWdwUExXVUY1MEtxYXc4eUxCaXZzSEpsQjFOKzdm?=
 =?utf-8?B?Ukl0YnVkQlAxWi9GSjlsTGprOUIyUENJV1hxQzhjdjVhV3RVVFRxVFNwL3g2?=
 =?utf-8?B?U1c5amdiclNUSStkMXBqTzFJdHlFUk5zZ2YydlVJa1YxaVRybVVjalBUVlAw?=
 =?utf-8?B?QU1lWGNrckN3NVZ4WmQ2a2RtM20yRm56QmRjM0VENE54eHhZUmIvMWRrbGJC?=
 =?utf-8?B?Z3hYZmpUblhrY1lkMEhuZ2Z4dDZnamQ1T2oyMm13OFh5Yi81RzlINEVLdFlZ?=
 =?utf-8?B?WUpMaGRmcGRFbnZwZXd5dWowU3dEZU5sallFSUJpTnh2KzlIc1dxMXV4NnBN?=
 =?utf-8?B?bXhLb1h6bTJJN2Vmcmo0WlJmZXFBd1ltQThCbWhydXJmdUhMWGhwcXA2cFRi?=
 =?utf-8?B?VmVCRHk1Z09wVWFHSkZ1SkdEZ2xaZ3pxa0VHdytlNlJicWh1Z3AzVUNKajRE?=
 =?utf-8?B?aE84NzVYcWhDeGgvYlB1aTFtMFZ2Z0RaT0l0MGdOOTA4UFROa3B6ZUNDS2s1?=
 =?utf-8?B?eWxjeEtVdlFZcTRlLzUzbUo3R1RSRzQ3dEpCV09FZnRsTDd4ampIWFkwZXVW?=
 =?utf-8?B?UkJUWjM1dEdxSTBsNXFBQUJCUXpBSStrY2tBL2kyNWpqY1I1RFMzN2M5T0xP?=
 =?utf-8?B?aDM1REVCQ3NuL25SZEVwYlR6RmdVd3FmMmtObFpreWNpM25jUzBWRFRUWlF5?=
 =?utf-8?B?WHhtSlRyRCtHblBoU2ExUFhkaWFsMi81RzEzL2lBQUNmYXJ4d0pJNytHNHRw?=
 =?utf-8?B?em5hUU54MjlpMTlYemRacU5oYVFLZ0VuSFJ5WFI0M2w0dHVpbks5UXA5QXUy?=
 =?utf-8?B?WHQxZlpQeVJEYURCdzk0R3dQdFRpVlRNYko2TFhtSVRqZHUySmM5MDJieVc1?=
 =?utf-8?B?MGJmakY5WHdIbi9zZHR5SW9iNmtCd0UxTUhXam1DV2tBcm9hR2x5WUdmK3Fx?=
 =?utf-8?B?YlQ4TFlGcTA2SGdSSVZQcGg0eFRqYmd0b3pSOGQ4Smh3YXJ5dEZ5RVVnbkdM?=
 =?utf-8?Q?htkG+ZtZDAoxM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(66946007)(186003)(316002)(6666004)(8676002)(66556008)(6506007)(86362001)(36756003)(31696002)(5660300002)(53546011)(6512007)(26005)(2616005)(8936002)(55236004)(31686004)(2906002)(66476007)(921005)(41300700001)(478600001)(6486002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkh6K0RZZlZMRk5pQ3Z1bWJwOGhJUkdFTW9Sdys5L0tJV09HVmRuNFNmRy9s?=
 =?utf-8?B?NXdhcGV0UFhJWEpvWUJlK0wwVUZsa2x5RVR1bndaM0tjVmJXVFFDV0Faelpp?=
 =?utf-8?B?WG1vTDBJUENoSkZUUmpXeElVQjhkSnd2SnZLSnBMREc1SW93RUd3OWJHUVJB?=
 =?utf-8?B?aDk0eS9mcW9TZ1I3dU43TktZdVFGdnRxR1pEbFdHZTJQeFJ3aC82OTgxbUxP?=
 =?utf-8?B?SVdaTEkzSzFYVXVacVBsWUN4M25hZDZMZnltUzg1N3NOaC93UXhxWlc2d1Z4?=
 =?utf-8?B?MVRIRnV4Unp1M3gycEs0Mjk1aUdJR3JCNlo5L2NVMStjWkVBbWFkMmNRN1NN?=
 =?utf-8?B?RThzNnVOZEtEYU9HK0RpNGFORDYwQnBKVzRDQmRwNmhwZFNuMnhYNjNrblFQ?=
 =?utf-8?B?Snh0Szdwb0ZNYjI4ZnRNeDdUNGFRU1kvNm5tS1BhS01vUGRKZFV5anJRTmNX?=
 =?utf-8?B?NklCaEtDNElQRytFR05LUnR0VGxrTlFnbGRNRk1qRzk3bTdPL3hGakpYM04w?=
 =?utf-8?B?ZnQ2M3Q0MFhRbVBvZWU0SmgrSWlwbW4vazJpMjhOMitUK1JYVUFDbGZXRk1k?=
 =?utf-8?B?STFQS3U3T1hGN3lJNW1uWTNZSnVpVjJCM0ttbGppanVFN2M3cDh5d0lZelJ1?=
 =?utf-8?B?d2NtckJpYWZLNlljRFNHa1FPWk9ScFZmOGlkV3BnV21RSHdJM3d1L0VQbEV6?=
 =?utf-8?B?YzdtQ1dGOU5LdW10VWFUNFNxeFhydFVHTHVDc25tVitqQ3p3dmQzS29mb3Q2?=
 =?utf-8?B?UDY4U25IeU1QcUtka3dIbFhxQTI0TnVVN3NGWUdzTzZ0OVVRMmk1VVFTeElE?=
 =?utf-8?B?anZ1eFQ0dGwwMGpsd2hvVXQ0bUprWGFjVXoxd09mUkdBWkRPUTVMRUx4RVA1?=
 =?utf-8?B?NUJuVmRJdng0ZEljdDZSanA2dnhnVjBDV0UrSnZ3cktRNzZuY1VNWE13eXBN?=
 =?utf-8?B?KzV5anR0UmNjKzVDZ2FXbTdmNlpTalpmcG1uVTh5czFqWnVZK3hOd1pvMkJS?=
 =?utf-8?B?NEdBZHZRMWxXQ1NrTG95cnV1akFVNG9zcDBxb1ZDaFk5eXpGU0ZQb3VUUlFZ?=
 =?utf-8?B?cWlydzhSYWhFbnZLNUtUK3g2WG9sb0RFbTl5MndOSHI2MUtaVXJuQUdDOVR4?=
 =?utf-8?B?S2RscTdseDY3WXhyVUt6Uml5d3hXY2k4ZGl5Vyt4YkpJMllrS20xRjUzeW4x?=
 =?utf-8?B?MkRJV2JLVE5HQnF6eDlETzJWVVB2M2VuQ1QwRGtLT21tSFZQcGl3Q2tWWFBN?=
 =?utf-8?B?OWc2aWtYemRZd3RUb2hjUlZjUGF0MTZjRnJUZ0RZbm90NG00dHZXOTVBQitW?=
 =?utf-8?B?OEUxT1AvL01iaVpSYmM1V1pFS1k3RmNlVS91R3pTSm9WaklST0JQMUx1TFNj?=
 =?utf-8?B?S214MjUvOUdDbUNta055cDk4RkdLZ0NBaGVDdW92NEJFQi90Y2VkZldQbTB2?=
 =?utf-8?B?NU9NQ1ZYL3FJekNmVVZ3aktxMk1KdlVBaTFONXVEdHc2RVJpdzl0TmxNdnUv?=
 =?utf-8?B?bzExS3FLOXhsMGFEVWdyM0tDQU9laTR4YzUvZ25oa0s2TVVSelgyYmFDcS9P?=
 =?utf-8?B?dlFvdThkakIzczgxeXp3ckR5dXNwVlN1SGtmUGdEWlY3N1hSeStoanBydnBH?=
 =?utf-8?B?RmFMVHNLWWl1TEFidDMrS216M2VQVzc5SThkdUtqalZIT1JJTGtua3Y0WUtN?=
 =?utf-8?B?WVpHSWpWMjkvK0o5b2toQzB6TkNOaUFpY3RPbWpRTUNaMlZ1Yk9LTVBXejFO?=
 =?utf-8?B?SFRwZHArVTgrZTdCaTd2ZUJXaW04MHV1ZTcvb1RxK2tIT1N0MlpCSWgxdklT?=
 =?utf-8?B?REx4Skc3eWpLLzZOTzZCNkF2L2F6KzFqVVoxV2FGU2xOelNGeDVXbW01Sysr?=
 =?utf-8?B?dVRrQStSaDd5WWYxcWM1VktmUDludlVXTEIvUXp4bmY5ZlVld2QvOG9XWHgx?=
 =?utf-8?B?VWplU1NVUmlveDVJY3pWYXhMTVdkaXU3NkhURUQxc0oyUGY3cVlYQm93Ull5?=
 =?utf-8?B?YWI3cnZPa0NHZVQxSlowTUF4QzY0M21RRUVoYnJNTmwwUCs4VjNrVzVjdmUx?=
 =?utf-8?B?L1JCL0FXTFNKWWM5ZnlOS2pDekhtSWE1RFZaaVhVa1E1eVZzd1FPRmw4alNG?=
 =?utf-8?Q?5oB/ymEoAeCySevhA+Mi8TGVr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4ca8cc-f917-4e1a-f0e4-08da5a7ba707
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:33:55.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03MM5Hw9STbotpD4hOp4zKkzZE1EISHg6xer00bfWw7i9tLLU576+o8HInUIxveY0WQn8HER4RT+K7qU4D7duA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2022 19:28, Kartik wrote:
> The Tegra186 timer provides ten 29-bit timer counters and one 32-bit
> timestamp counter. The Tegra234 timer provides sixteen 29-bit timer
> counters and one 32-bit timestamp counter. Each NV timer selects its
> timing reference signal from the 1 MHz reference generated by USEC,
> TSC or either clk_m or OSC. Each TMR can be programmed to generate
> one-shot, periodic, or watchdog interrupts.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>   .../bindings/timer/nvidia,tegra186-timer.yaml | 111 ++++++++++++++++++
>   1 file changed, 111 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
> new file mode 100644
> index 000000000000..5dc091532cd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra186 timer
> +
> +maintainers:
> +  - Thierry Reding <treding@nvidia.com>
> +
> +description: >
> +  The Tegra timer provides 29-bit timer counters and a 32-bit timestamp
> +  counter. Each NV timer selects its timing reference signal from the 1 MHz
> +  reference generated by USEC, TSC or either clk_m or OSC. Each TMR can be
> +  programmed to generate one-shot, periodic, or watchdog interrupts.
> +
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra186-timer
> +        description: >
> +          The Tegra186 timer provides ten 29-bit timer counters.
> +      - const: nvidia,tegra234-timer
> +        description: >
> +          The Tegra234 timer provides sixteen 29-bit timer counters.
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra186-timer
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 10
> +          description: >
> +            A list of 10 interrupts; one per each timer channels 0 through 9.
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra234-timer
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 16
> +          description: >
> +            A list of 16 interrupts; one per each timer channels 0 through 15.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    timer@3010000 {
> +        compatible = "nvidia,tegra186-timer";
> +        reg = <0x03010000 0x000e0000>;
> +        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    timer@2080000 {
> +        compatible = "nvidia,tegra234-timer";
> +        reg = <0x02080000 0x00121000>;
> +        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +    };


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon
-- 
nvpublic
