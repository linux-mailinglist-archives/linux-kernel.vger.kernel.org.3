Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA884E4992
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiCVXOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiCVXOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:14:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D43B60CC3;
        Tue, 22 Mar 2022 16:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGdIFHWT/sVqdN5qH5Dylzd7eVfKNqzPQL7/45MyiDjwLee+aBZ388NoXPw+3kUfIAm/VfUkUyRct2jWMmg9oyiQcqiC1EJTE5gp5+pezPpIAhjba8gjuh9I7cVYmUFuFlxbIuQ1kH/C5++9QGa23angwzIc6OzOo5CUYt6sfqsq1qmo1Xg8xYUwFKeRDZCyEq+0LKpYo05lr/+DQmOacyPmOiJHf17kxtHrEEx3/cdxnQje1g7pErqS/hLFvapF96t1+i3Jh7vL1ntI4biDapiL55pfZyfPudHzQMDftg4dNTUpZ4aXapb2q0luwBSmrkFD4keXZJzQeEpHi9Gvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak5+xcbd0zW2AhhK3YKAT/i/bg+wB2MamXFZWieui+k=;
 b=GEup6EtfKQLRBI+D1WcVCqwgkdiakBfBdezuZKj0l84nl5D3V16JeJTWPWtPuFJnvKEi9ZFRT9CikmLEengY5X8P5/9EVwOFQ9ONDEVrCx1pUvzCPWxOYzq8Atw46rWkzm0X6NmOl0c21O3LxDWQhrDNw9l7f9coKWprvC6yopTY3O6TJxSItqZid5Dr0F/Vaq+XSyA2ay2sE7c+bzcZI4ppJwCbfcC/G7DJnIV6JzNM1FWVCUrsUBs5o0M1PSSc2/y1GQDcSbyhjeT5BTSUiIQoJVYzU24WE+MX9UrZF/uwQpnUfNRkjrnb6BkRfCvEQNlSdfIXH2MhU7GBvMakTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak5+xcbd0zW2AhhK3YKAT/i/bg+wB2MamXFZWieui+k=;
 b=lpwm2WyX8sM5uLKXhdZCd6Gq9LUPy0vAmY1yOrfI2pLvbP+W7A4WexuzLbpeD1gMJJJzbYRRtjBdE7hCNz3zRQRPUMPThY7mX8+5eHxP/Ac3N930dtzFT4FkR4kML9xAGha2jVxrF//qu6qRedjfntmQ1ao+u6iSYqc2FKpB00Y18hV97uGzoSWrHUDQuNwqvJ4sDWXjcFXIxGs/ilQFkx/TDVNjCJUN5tg4V5Z45MLgtjND212S6Bf3Xx8lgakYRIzLBSo7Y3mkGuWrIkTXNn9fjVm/Kk/4sRZcEfT3j43E7fjqeTYL1Qlp+awpkV5UC3FmsTRYj6BDvO24EE25tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Tue, 22 Mar
 2022 23:12:46 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::8940:4e31:b98a:c02b%5]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 23:12:46 +0000
Message-ID: <60f09bc9-2399-29aa-123e-db48c1aa77a7@nvidia.com>
Date:   Tue, 22 Mar 2022 16:10:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 04/11] dt-bindings: Add HTE bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     smangipudi@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220201222630.21246-1-dipenp@nvidia.com>
 <20220201222630.21246-5-dipenp@nvidia.com>
 <Yf24nR9drkBAnYA5@robh.at.kernel.org>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <Yf24nR9drkBAnYA5@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::21) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b058da33-1f4b-4315-56df-08da0c59790b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4842:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB484225E44C6268426431ADDEAE179@DM6PR12MB4842.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPzNRs63L8DrQEq2gHJh5v6nslsKHPYGO2cztniKeDv/KknoRSK74tyzkfzXdPzcfFV+o+CBEVMIpgmuGvBT4uMgp8CsRf9WoAEwIkIPQTxMwZ2sekMk5hp3EStWTOsMEpnlQ8dSjVLwIauLE4Ix5xW398iI5b0fVN9bXOHipWi60EpgK+cBSSJ6ZNKfow3MLxnFSRfGKIQnrmKDencGiKEFAASSz5BotB581k4sYG8HBw/Zp4k3PzQVH6B6tVNptKB9x1tBKDLVwVkFx8dW+/5IknyLAxsXsKdOLnHdZ6Ve+2Xi6BwQgiXw9SmJ4T02NRtoiAyj2zNuuXWof8KcWV9tD30owWphFuCOAGpVrTxM1ikZIavAi/6E8n6VWEfABUx2qlZvRm2GhaDFiCkA9JG+wmCvol7CKaN+iljx+qb4+uJcCdbW30TvABqcq9wG4SCPYQMA1VWcl3Xx3M9QuCPQ87Eqea31ayn8CGQXT0mQjyJZxRAYDWEzAfww0FHulXVgFbvYvCZbLmxmJ9oMT38H1eqOmWr6OahOjA8szQyd3JakVWMLx0ynpDxu9YknlBquT5c0y4GG7abL3bXZtDF4otDx1kbSA1T2GtZkpYdW1WG4YUVRBLAhiPkBS/mAaO8tzc3k0/xWdcy+66i1LPpn8bT2n6rmgbN7WBuXou7/c3xd/rtNNqZueLJNfGGJa9B4ntLKjarOnWDzGFo8NLDyk6+JMP8OwzYBwt92TavorPkciLnvo713rWm818wOhfoFrA3S04tYzgOnnaQM3la1y/2S7pCfAQ0U6YpRrGVqEGIfebme6yfWmGH4BQVEJ2/uqE/tslimTGZJQheSO2Nffj052R3YgmZRk7Fy6KY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(38100700002)(186003)(86362001)(31696002)(2616005)(6506007)(6512007)(53546011)(7416002)(6666004)(2906002)(83380400001)(5660300002)(508600001)(6916009)(316002)(966005)(4326008)(8676002)(6486002)(31686004)(66556008)(8936002)(36756003)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0VNUlozQWlBamJSWVMvaHBlN0djYkVZK0U4TWEyb1lrNmtIeW5QQ2VKZ3Bn?=
 =?utf-8?B?QllHS1V4VjlvSkh2aWoxWmVrYjhralU1UUhKMDAyck9wZmIzS2pqUXhURU1R?=
 =?utf-8?B?YlE2QUxSZnQxd3Jtd1JNUTh5dGJKREdSZDZBQzhZZ0hzMktUeitrU3lvUHIz?=
 =?utf-8?B?elQ1bkF0a3Y0RUI2RDFCK2FlS3ZHSGxNMUR1akZrWDRxeW9NOGpDVXlNT0dW?=
 =?utf-8?B?TFZ0a3BFVVhkSlJwWEZ6eWFTUlNUbkZBNXJRaUlkc285YllEczNJRlBleFRz?=
 =?utf-8?B?dElBM1EvRkdxdTBSTmFCbVJPb0JwcHI2UzhicTNmMTE4REVVWjI4K2dOSmZB?=
 =?utf-8?B?Y3VmMkg5ZFVXVTdNVXpqSnUrbWdqN0hHYWRYSkt4bkRSVGVMbW1tbHpGK2ln?=
 =?utf-8?B?QTQ4eXN3V2NURVF0S3R0NXcxWGRZOExzSFNlUnJmN2lxZUxWeldweDlYa3BS?=
 =?utf-8?B?R2xlUmVuOXJEd2d5RURsTTNOMm9FWHg1N0ZFTW1HRkpQWHhFWFVXZm5Xbk03?=
 =?utf-8?B?UEl2Mng5czJFS3lyQUQ0N1JIRXFtZldlcC9zR3V1c1VvQ3pUN1p2bGxVck9j?=
 =?utf-8?B?VTQ0bEhFTTJKYVh2aXFOVG9HK1ZyNk05ZVFXc2hIZ01paDhPVEwxVXNZb2p0?=
 =?utf-8?B?YlZsVHBISFdJSUhIcjB1SGxDNnRqUXlJMzNKV3VKQ2lmdHFlN2JmSEU2eW5S?=
 =?utf-8?B?VUpwMUhRdHJLYVk4cUJCSWc5VC9KTEVySGVGNE55eTJmbHoxRUlEMXBnVkha?=
 =?utf-8?B?S3ltWVZRbk0rMis2K1VkSHVEc1B5KzZZMUdsMlF0TXhlK05HeW4yaXFZbWdB?=
 =?utf-8?B?QkxFanFLNFhrNE9mSTA3bTlZRHRsUlExOW11VXVLTWo0VzRCYStRTjJvazk4?=
 =?utf-8?B?cFp2YS84UUludlRZOXNJSzRuSVl4OHcyNFYvZ2VTN2pFeE5PblljZXc5Slpt?=
 =?utf-8?B?Zk5leG5lMi9GazU3K3FNNURjcU1OcnkzQUQ5U1o3SlJPQkZKbTJHL2M3djV3?=
 =?utf-8?B?enhGQnF0eW0xbWxQTzFucGNXL216bytEUUYyK054UXV0Zzkwd0VPa3FEa2g5?=
 =?utf-8?B?Mm91b1U2UVNKMjk0WmovNzB4bUJWTnlXbHNmTHZLd21ETWt3cUtpTnk5OXZq?=
 =?utf-8?B?YWttTlZoa0IwajczV0NOTzA4RHQwRlBRS1BvVzlTTHdWaUhXZEp5ZXpSYmlj?=
 =?utf-8?B?UWI4VkFFbXV6M1NOYjBqSHhkS3Bhd0pTZldoZWdtWm5CNWt0K2ZGSG4wczFM?=
 =?utf-8?B?NCt2dituQlgxMUljQkJYTHVkWkk2NjRIc1lLZGpKOWZuQlljT0tGRStXZGl0?=
 =?utf-8?B?YVIzWnQ5TWMxQnUrcUYwU2hQdmZ2ekRSWlptWUI1UDlNR3dnb0JnV2syWDV0?=
 =?utf-8?B?L2IzTVJFNFB4TERGZWFxUVdLei9oK3hTV0J5ZWZSNWFWeXBzd0l5UmloUmlk?=
 =?utf-8?B?Y2NmQlZmZzNqeW5IYmh2T2wyZWVpTzlQRW1MMnM3Y3c2dFhrT0RycmlKNi8y?=
 =?utf-8?B?Y1pxT3BxeC9aK1Q5SUhNRFdmaEJtWWgvbk54NnQ2UVVJK29xcUpNSWxicDd5?=
 =?utf-8?B?TjY5VDFnOU9OTmxxeTk4czRUdmsvWUg4QTY2V2xubkVWeS9uZU83NXI3dEJy?=
 =?utf-8?B?dlkvZFR5M1NKTnpOYm5OYjlzeFhWMWR6L3UyN2hxTkJwRnFoNDBNSWtSeGFF?=
 =?utf-8?B?Z0RGTzMxQndsWWM5MFQyUFJvekpNTVB5T0prMHVPeUNYbGc5aTFpNEhlTDg1?=
 =?utf-8?B?SnB2RmVNZkNURUQ4dGE1dTZqTUZmQVFIbGxLbXB0cXBlbjZjUnZvWlJ2Mnhi?=
 =?utf-8?B?WmY5bURNK0VNbnI4SmY3cDFneXU5OHhhU3ZJN004MzdrY3k5QXJBRXNvT2cy?=
 =?utf-8?B?NnRNTFE0bWsrWTZXbXRwRU5QY2l5YXNrajRPY0c1emxRNk1EdzhJZW9kZmRU?=
 =?utf-8?Q?y3aFdvRjaQ/zdbzt6BsKGMf60SY62mmg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b058da33-1f4b-4315-56df-08da0c59790b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 23:12:45.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +F8xBeQIgt9lGXRzJsqxBteMy8mcrwNYmrk5urXbeyYXtVosmxgoPDORFG+o5r31G28OtgQX8lyDd9Bv9Aio7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I will implement your review comments in next patch. Thanks for the review.

On 2/4/22 3:37 PM, Rob Herring wrote:
> On Tue, Feb 01, 2022 at 02:26:23PM -0800, Dipen Patel wrote:
>> Introduces HTE devicetree binding details for the HTE subsystem. It
>> includes examples for the consumers, binding details for the providers
>> and specific binding details for the Tegra194 based HTE providers.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  .../hte/hardware-timestamps-common.yaml       | 29 +++++++
>>  .../devicetree/bindings/hte/hte-consumer.yaml | 44 ++++++++++
>>  .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
>>  3 files changed, 155 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>>  create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
>>  create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>> new file mode 100644
>> index 000000000000..ee6f94890695
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
>> @@ -0,0 +1,29 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hardware timestamp providers
>> +
>> +maintainers:
>> +  - Dipen Patel <dipenp@nvidia.com>
>> +
>> +description: |
>> +  Some devices/SoCs have hardware time stamping engines which can use hardware
>> +  means to timestamp entity in realtime. The entity could be anything from
>> +  GPIOs, IRQs, Bus and so on. The hardware timestamp engine (HTE) present
>> +  itself as a provider with the bindings described in this document.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^hardware-timestamp(@.*|-[0-9a-f])?$"
>> +
>> +  "#hardware-timestamp-cells":
>> +    description:
>> +      Number of cells in a HTE specifier.
>> +
>> +required:
>> +  - "#hardware-timestamp-cells"
>> +
>> +additionalProperties: true
>> diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
>> new file mode 100644
>> index 000000000000..bb1232b31455
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: GPL-2.0
> dual license
>
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: HTE Consumer Device Tree Bindings
>> +
>> +maintainers:
>> +  - Dipen Patel <dipenp@nvidia.com>
> select: true
>
> Or this is never applied.
>
>> +
>> +description: |
>> +  HTE properties should be named "hardware-timestamps". The exact meaning of
>> +  each hardware-timestamps property must be documented in the device tree
>> +  binding for each device. An optional property "hardware-timestamp-names" may
>> +  contain a list of strings to label each of the HTE devices listed in the
>> +  "hardware-timestamps" property.
>> +
>> +properties:
>> +  hardware-timestamps:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      The list of HTE provider phandle. The provider must document the number
>> +      of cell that must be passed in this property along with phandle.
>> +
>> +  hardware-timestamp-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description:
>> +      An optional string property.
>> +
>> +required:
>> +  - hardware-timestamps
> And drop this or it will then fail everywhere.
>
>> +
>> +dependencies:
>> +  hardware-timestamp-names: [ hardware-timestamps ]
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    hte_irq_consumer {
>> +              hardware-timestamps = <&tegra_hte_lic 0x19>;
>> +              hardware-timestamp-names = "hte-irq";
>> +    };
>> diff --git a/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
>> new file mode 100644
>> index 000000000000..c7d2acdb862e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: GPL-2.0
> Dual license.
>
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Tegra194 on chip generic hardware timestamping engine (HTE)
>> +
>> +maintainers:
>> +  - Dipen Patel <dipenp@nvidia.com>
>> +
>> +description: |
> Don't need '|' if no formatting.
>
>> +  Tegra194 SoC has multiple generic hardware timestamping engines (GTE) which
>> +  can monitor subset of GPIO and on chip IRQ lines for the state change, upon
>> +  detection it will record timestamp (taken from system counter) in its
>> +  internal hardware FIFO. It has a bitmap array arranged in 32bit slices where
>> +  each bit represent signal/line to enable or disable for the hardware
>> +  timestamping.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra194-gte-aon
>> +      - nvidia,tegra194-gte-lic
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  nvidia,int-threshold:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      HTE device generates its interrupt based on this u32 FIFO threshold
>> +      value. The recommended value is 1.
>> +    minimum: 1
>> +    maximum: 256
>> +
>> +  nvidia,slices:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      HTE lines are arranged in 32 bit slice where each bit represents different
>> +      line/signal that it can enable/configure for the timestamp. It is u32
>> +      property and depends on the HTE instance in the chip. The value 3 is for
>> +      GPIO GTE and 11 for IRQ GTE.
>> +    enum: [3, 11]
>> +
>> +  '#hardware-timestamp-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - nvidia,slices
>> +  - "#hardware-timestamp-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    tegra_hte_aon: hardware-timestamp@c1e0000 {
>> +              compatible = "nvidia,tegra194-gte-aon";
>> +              reg = <0xc1e0000 0x10000>;
>> +              interrupts = <0 13 0x4>;
>> +              nvidia,int-threshold = <1>;
>> +              nvidia,slices = <3>;
>> +              #hardware-timestamp-cells = <1>;
>> +    };
>> +
>> +  - |
>> +    tegra_hte_lic: hardware-timestamp@3aa0000 {
>> +              compatible = "nvidia,tegra194-gte-lic";
>> +              reg = <0x3aa0000 0x10000>;
>> +              interrupts = <0 11 0x4>;
>> +              nvidia,int-threshold = <1>;
>> +              nvidia,slices = <11>;
>> +              #hardware-timestamp-cells = <1>;
>> +    };
>> +
>> +...
>> -- 
>> 2.17.1
>>
>>
