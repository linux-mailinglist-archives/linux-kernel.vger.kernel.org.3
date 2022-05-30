Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77C85373DE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 06:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiE3EVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 00:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE3EVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 00:21:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97634D6A;
        Sun, 29 May 2022 21:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiCKHTUKFnnwAIVYOQw+He+UbdZAUBdIQLl2sO/R+lv/j2teKCxGZ1iZ8Dlx0hOOFy0yB1l/BX4dPIJ5IG2hhjPLiqv3qaUmx5+XDF05OW8fstLEEsQRT1cf1qY3JnbSBhOJA7BKHAQ7Z5Iwpw7Od+s9c8CflgVHxgxeP2HgUC2xh+UdRRQOkwEjsniJo1myemdjAco/TGPiOvE4f8hdbBmlCpt7HmNgk7/kQ3JlzhLUwKa5ANNGiKrfK95G9hQcS8yCQE8OQnFuI8PAk1quT6khxuCISOsHGdHd0gmXNYRVw4dZVpEnXpLqNIER0xjRPLIVoYu5EnEEgm8ny44BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wkrd07pPWiZzZSgysgoHk846bqc97tOaL64bpOzQBI=;
 b=HNdFRAzrXeq6Q/kX2x5cVMtmbu7l3U2C53lhfcbeU++rwvKDki15ApfBwlQQanSC6mKIGUZKfngCeEk2QdWLNk/ybmteQ6j2SNtPX4t8r/DYvvr01VTZzAQwulhJi07oC9q7pY+xiFPoInKx6X3jEoKhUjhEBt0i9fenCzilbWcuZsmeenIYq9KZnJ/MYp+PWN+xhseQ3gmHjVZPnYrwWj+zMUXe6LHBOvrpPsSAQiv7y417Fe7tyEXHe3pua3yux9NU+Ur1eifTbElVYjDvMhuVyMPGA4X3Z0ZNyDwTODZomMogsrQwQ1i/flLUupnqRYQaXQdvQ4VmlGXQKMRi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wkrd07pPWiZzZSgysgoHk846bqc97tOaL64bpOzQBI=;
 b=gZTmxyMZ420MDMgmTK9sdX1AYhWiyPSZxT+8imb7GwHTZQBQxDqKLhGDrfwc/UIOzvqohOLw77jXcKXu17EilrJy9S1NG+zeaH6d2H4wprt6efHudpASUUM9+DI4vl/Eo8tXcPRiuHRua+d93zw6eCCVsnbx07EdD0v+WqARtgd/9wZQj3va4a+0/QwaJH/YCU7bL4E9Sgt9grRdE31ZMnuUeKtFGvZTv3E1g+5uhm1cEaxYdNfhw/b5q1nWMwRtAH0me/6rETfymdlANI43zwuiUuS1v/sMns1UpgYA0rQ9xz+SNg748lXpmx0HiNB2rUE0L38CrHHI/VMPP0YQuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Mon, 30 May
 2022 04:21:34 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::16b:eff7:847b:19e7%10]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 04:21:33 +0000
Message-ID: <df57de4e-770d-7331-89e5-a2404fb42f96@nvidia.com>
Date:   Mon, 30 May 2022 09:51:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/6] ASoC: tegra: Add binding doc for OPE module
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
 <1653647172-2569-2-git-send-email-spujar@nvidia.com>
 <149fbcfe-b62c-63a9-6c38-100d493788c3@linaro.org>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <149fbcfe-b62c-63a9-6c38-100d493788c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f42b4293-e55b-4c6f-1d28-08da41f3e10e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121C04C36F6ED672C313E6BA7DD9@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGYMhSA9a4cYJxX+DCz43MX3jvN6n+rsmO6ms3R0rjjWBtlRQzCaUdVUGBuQ+3/qmewrOLt3Q0yM28laFTWp+hA5cZsZ1P3XGmR5lHJAEeSSC+BZbGAaefAGDPteU0fgROCIXKjXVdX5Unxpj+9LgKzYlE20mCaf4WhCNejy99oMF/zSaXPY1ISyO4YgGtqDtGdrEN8rz0Rx37PCPi5aLkCOFWk18zd4RaUT01EsQBC6cT0jfzOtPbt2B933hpJo6e2BjBjwJQsuXgaojPgJ61HYsr2M5eOwBgf1NCUVCOOAD7iTnjUp820DRFwIwImbfhSRAnk4KNNP7tfAuydxXkp/IAlzKDiSHfsGXtXKzKHYGrXGluWKIqUOE35yuGfHRNIdk4DfL67IwaBfOOMEPYSg8zOlSl1SNrscJIoiHV+x07yD08WsSDIJoX2d6jxD/fchYulyOysg5LgWYQrwJmz0uzCNWulKqXFU5Sd2GEHZb0L7/NpL9vIkeisupQEl/CQNOAhbXiFJ5LHyWBfSEp5CY4IZ2E6/B8UaB1QwNiogdNtQ0AAKFGbqaEg9dP9RuRqxPv/1OIglx8WdRBNQ2v1YtCPsyTk+JrMHaQ1SopSUcVxdRBBYaQoOkWnOd7pUp7qRoaFQj7vrQ2aKB9uQ34WWU7/+kqz9jCHmRkx4m/DY1iyGsVT7WteDjO63S5E8n3VNFFE3zXdMlqyUgknCrR7bUSye7dWwGVYw6YBnAKenWd82AnGn7wI7ffXDSbFhFoBTiKiZb+KWXzUzt6LQ9jnaj+BhCVbosCiJHYrptG/Gd5rQUnzI24mgvjkhZxL9+gFU+pbCYqYz1IhIaS7ODPlYOe5FPTSg7Aq4sUdKM7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(66476007)(31686004)(66946007)(66556008)(31696002)(2906002)(186003)(8936002)(38100700002)(2616005)(4326008)(8676002)(26005)(6506007)(86362001)(55236004)(53546011)(6666004)(6512007)(508600001)(966005)(7416002)(316002)(5660300002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTF5aDJlL2NWbllPdTBuOXpCNitnM2lUbTZKSXo2YmEvaUhvSnN1VzNxWXVw?=
 =?utf-8?B?R0hUWEdlR2c3aU1oSkhJTmxrTk1YNVd1dTNZYnI3cFU4TEo5MTRzK0VjZUcx?=
 =?utf-8?B?Yzh5anpvRjcxQnZ2ZlBQMjNZeFc3L2h6UHVnbTJtTEFNZ1VQajdSRjBNdTFN?=
 =?utf-8?B?bko2SHRNeTdaSWVUQ3FXWW41TXRDVlZxeUZqN2QwSUs1TGZENThaSjhoL3hV?=
 =?utf-8?B?QjNJYTlYY3hBbW5JVWhOeFNoZi9ETFloUk1HR3lGdE85dk5iOHZKalhmK2tS?=
 =?utf-8?B?akxEaFJ2d2FJanI2bTQ1L2Z3SjlCbmV3MzY3OU9tYW90OFQ4WmFZNzJDT003?=
 =?utf-8?B?OVRpSjhIQjY5MGZSNGJjMFNUajRWV0V2Q1Q5WCtpRlFTQ29OS2k5NkF3NExG?=
 =?utf-8?B?aStpZ1hmK0YyQWh6UFMwaHBvazNHWGVTTVUzeitmdUsvQmp4WVRmL1ZEZVAy?=
 =?utf-8?B?UzJXV3FwVDIyYUF6ajVLdy81M1MyVCtqVzI5SXBnRlIzQldablNaSGhZZlVm?=
 =?utf-8?B?SXd0UXdrc3BXM0VBMjB2Ykp3YXZ3UFdtejdDQlREOW1BdkpLNU0zWi9QVisw?=
 =?utf-8?B?ZFdpckFqOHovWktWRW0xWTFZVDBQZ29kS0wvY0lDZWhXVzhiVFNJZUVZdkN6?=
 =?utf-8?B?TTVGdEd3RjZUd05oWVRRTVk0K05hNDd4K0pMTE5ZK3NYZGdiS3Y4RWtHc2ZR?=
 =?utf-8?B?VjRxQzc4UGJoY1RKUUs4VDF5eENLT3JPOHFKRDN0UnpPcnErNzNtdGFqOTV4?=
 =?utf-8?B?NlBVeTVFWG1EY0drK0tURVlobGNhdnhzN0MxZCtoK1ZxZHc2RkZsY1F0Z0FF?=
 =?utf-8?B?blhIWERTa3QyZ2N3bE1xcHlSaUwxMkdjdThWTTlnZkVsVVRKY1ZLa05tY0Q3?=
 =?utf-8?B?MGRRNUFWeTh2aUZvWFcycWp5N25CS0NOTG43YTBnbW1qdGxwa1JENDZtWWdK?=
 =?utf-8?B?dWI0b2NmNXVZcS9HcVl6a3hYZWFNbHNmbXpiN1hYL1VlVHphWEhhZEdwdkls?=
 =?utf-8?B?eGpFN0ZnMU00KzBzQWFvQlZETTVHcEpHTmczelA2MmJrWG9jOHhHeTJtc0tU?=
 =?utf-8?B?Z3ZDeVJCMHRxQnBxb1FOUURNNUZyemVIaTFMbTJDMWEwUVVLSlY1RXFPMnlF?=
 =?utf-8?B?d0xaY2VVRUtDcUVvdGd3ajN2ZC9CRDFhK2J2cmY1dUtiZURYZ3hhdjJxMC9P?=
 =?utf-8?B?MUpBemFmRnJYWXRMbjhDZDZ0VmNGelZLZ2huYWwrSlNoaWlJbjlxdm5CNTl6?=
 =?utf-8?B?eEtqUUxxN3U5YzZRbEp3VkY0OHdvd0ZxcjdtRTRmTzQyZmh3dlU2UE1NU3Np?=
 =?utf-8?B?QzJoTGxPOGtQNnVGbWhCRi9xTDFaaFo4N2MrTWF5b3dzdXRaclFvU2ZvMWxi?=
 =?utf-8?B?cXRTUVRob3NDa2dQOUI4bGpPdFd0NHNvcGJUaHErRmFWdGd2V2MwUUdCVEFz?=
 =?utf-8?B?czhPVWlCU3U3Q2JNaDRCUE15VzEwL3ovMklCenhOQ0UzR005ZjROb3V5eiti?=
 =?utf-8?B?emtzVHZReTdYZTNNUXZhTzltSDZ1SHN0K09aMFFzZXVlczEyMVU4UFJsMFUw?=
 =?utf-8?B?aTlUdWFxQWx3LzIvcVNtMmNTb1g0YU9Hd2pkN2dMWHhwd3ZRYytYdWtseExt?=
 =?utf-8?B?UE1nM2NhK1dXYm41QmVyS0RQd1YxakRuMCs0aUV5aGdyUFFJNER0VmZ2R2tx?=
 =?utf-8?B?K011UEtFcGcyNjJQeTV5encwUk5VQ1pja3lZcUdiQ1NmQTV6RC9PWHdiaHlB?=
 =?utf-8?B?NGgxR1lDc1RuYW83TXhtUlQycVJYNTVtRmJwREVpUWtBOEMrTE9pVGpYVXh5?=
 =?utf-8?B?SS9CdkhYMkJxV3IyVzI2OVR0TzVIKzJiTFhnNHB2R0UxQ1ZFRGxkT2d4Tzhm?=
 =?utf-8?B?cG83M0dTbVM1TEVSYU9HbUV0azNMMDZBVzYyTHhvN3IvVis2TjJXeFlTY21u?=
 =?utf-8?B?T1h6WEtnb1FIalV1QVdOZmtxaUJUalV0cVF5K2VpaVI0N0t2WEhqSWc5a2Uz?=
 =?utf-8?B?QTdFMHYwR0FiQmFzNWNCM3hNWDFmQngxdExBQ2UwMUlzV0dFdnBpQkJJL0ZS?=
 =?utf-8?B?M05mc1dwK25xaFp6MFIzTUo3SCt6WUlxOFk2bzhKcXBHUS9XVjBSbW5QU0hy?=
 =?utf-8?B?VVZDbW1YSEZXeTZmSks5bnhBM2ZuVFVmZ0kyVTl1a0JxY1QySyswZVBsR3NF?=
 =?utf-8?B?RlhJMG1WN2s4NW1PTzRDQUJkQjUwWHkrTi9Dd1ZyMUR5SXM1cU1pcytoMGg0?=
 =?utf-8?B?VzRqcTNWbW9jVGs1ckZ3V3BMSmNMeVZYYUtxOUh1TkVldXpMVkJQc2FsalRT?=
 =?utf-8?B?YW42c0tHT0Y1a0VQTzJwOGl5eVlNVFV4V1N0R3ZkMEs3UUdOZVE2QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42b4293-e55b-4c6f-1d28-08da41f3e10e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 04:21:33.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzGyBEmeeafNDlOaawmm4NrWTU7v1e+1ts/4nIjdcI6MiYrTEWLkKAlov98ZnPNODMzyA9kKQTAVf8urjF2eXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29-05-2022 19:39, Krzysztof Kozlowski wrote:
> On 27/05/2022 12:26, Sameer Pujar wrote:
>> This patch adds YAML schema for DT bindings of Output Processing
>> Engine (OPE) module. It consists of Parametric Equalizer (PEQ)
>> and Multi Band Dynamic Range Compressor (MBDRC) sub blocks and
>> binding doc for these blocks are added as well. The OPE will be
>> registered as an ASoC component and can be plugged into an audio
>> path as per need via ALSA mixer controls. The DT bindings are
>> applicable on Tegra210 and later SoCs where OPE module is present.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   .../bindings/sound/nvidia,tegra210-ahub.yaml       |  4 +
>>   .../bindings/sound/nvidia,tegra210-mbdrc.yaml      | 47 ++++++++++++
>>   .../bindings/sound/nvidia,tegra210-ope.yaml        | 87 ++++++++++++++++++++++
>>   .../bindings/sound/nvidia,tegra210-peq.yaml        | 48 ++++++++++++
>>   4 files changed, 186 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
>>   create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
>> index 6df6f85..47b6e71 100644
>> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
>> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
>> @@ -110,6 +110,10 @@ patternProperties:
>>       type: object
>>       $ref: nvidia,tegra186-asrc.yaml#
>>
>> +  '^processing-engine@[0-9a-f]+$':
>> +    type: object
>> +    $ref: nvidia,tegra210-ope.yaml#
>> +
>>   required:
>>     - compatible
>>     - reg
>> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
>> new file mode 100644
>> index 0000000..0d55328
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/nvidia,tegra210-mbdrc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Tegra210 MBDRC Device Tree Bindings
> Previous comments - s/Device Tree Bindings//
>   -  still applies. Please do not ignore it.

I did not ignore this. There was a comment from Mark on this earlier (v1) and I did not see further reply from you. I thought you were OK with the way it is. So if you are saying acronym part is OK and just to remove "Device Tree Bindings" I can send a v3 for this.

