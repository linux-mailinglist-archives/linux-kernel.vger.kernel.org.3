Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F5B525E33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378358AbiEMIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378355AbiEMIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:39:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8862685DC;
        Fri, 13 May 2022 01:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4KIY90Qp/1+TwRJb4xblGNyyep9tCxRljmhRnDlCd0ckQ7CpqqYfqoP37ZoeEj44BwFdJouWlyfeGSDHadjwV9sC8giv15r9eQlo1pn5OgQILSZz0UDasNzZNmeIsrOqiBUdbRB6zepekXiqP9aNNvwEay9OkQ45puPpZOKhr66/SPO0Y9HUceE2Cd3RVfBJ8qCq1y95y1KGQUfHBI+u5oC38PjC0SS5sCOf3GDKLVTIy9CwLyiypZzdZYchSt55g1yurlAIwbaYHo4hl+iT65inxdHHCsgO4T6UkFLf55lfkQxhU6NkvcR1KJgMxzTaqUmMaWu2oUu+4dLMrylIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+8i1/ixfk/ZLNM4UupKrBYyLg8vKyoBaaSTu0DuTW8=;
 b=EsfO07lvrJlkpzlYfsxJv6sLVO9wfJBgzfHZ0UaxAQ2rn3hUhlpDp2RrqvRNUe6MmMAnViuJkoDiUyJqTeke/Qro+AaGWPNABWVHLJzdkTg+ZhjKLcFmzGQJuGUEda4qti3S9ccpy8AT5hClOGIeLUkb/g5TP6aHoaxFLHihNv6eFBnVyBhl+pMQcNipat2eMzU3/Zyb0+ZCc5LBluygIAfraHQ9Dk+r5rLrSzWx5IETO/Pc9XfaJVWdXdVcAlGOijj9R4OM3AnQ8QFPyk5mGWlurq7bxlwNsZljb4NpkA59c+QWTCJYWB3XANRsfEIC/6flmp82N39LwiXNv2CwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+8i1/ixfk/ZLNM4UupKrBYyLg8vKyoBaaSTu0DuTW8=;
 b=o4uPR6inXVNOZ8lotoofauCSOFIrAL0UhST3df/E16bq1QjI7bSro5+9eL9TnqDrpGePC19iixYgETubnLe2EzanrKvC+pksUIV7qb/92jPtGSuBQGVXS1N9m1GLDXkbvmf3BspWwcOyIbvLDo5f2gu9i844JQbDZ6G73rJvJKWy51dSsgxjP3PNIiTFBBFK3++1feT3wNoms5T4r1pwf5wTzOyGwM3C5xYTd8OgC2rcZ+Yw7d3+MSDMgByzvHFlCbZsE70FtZCnm7QTsTQN9MwrmQtURH2CqA0wd+vs9PEjFrGRm9vpO81nB3tJuXaUM9E5DL2l2aDM1X7N9FE4jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Fri, 13 May 2022 08:39:36 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 08:39:36 +0000
Message-ID: <6510d8be-38a7-8470-d832-15b948671703@nvidia.com>
Date:   Fri, 13 May 2022 09:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: tegra: Add Tegra234 GPCDMA device tree node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akhil R <akhilrajeev@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220512090052.47840-1-akhilrajeev@nvidia.com>
 <20220512090052.47840-3-akhilrajeev@nvidia.com>
 <36bb53d0-80b3-f79e-a599-6acb98d0c872@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <36bb53d0-80b3-f79e-a599-6acb98d0c872@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01135dba-a66b-4de7-52c0-08da34bc1cb1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24827E51998CB455CE7F8F30D9CA9@BL0PR12MB2482.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZx/M3zZjRJ37/0qVA9ZbFC0fHxBjntMNP3mPi3o/GAd9ZWvRRQrbUF1c2vJn1tAMcDSB4oEfn/5/0LohVtJl/YwKULCxemVJYpYxjrVkN4OmNOh9p1xwZKOcdkWQgItGrRuTt+S/JTUlhYQf2j985U/1qJUoN986TvoI4/gE5Ukif+HXIo8DRe84spSZk3sijy1Qyub48NRtmc/z/vNuNHYXeiMxe6+TfHFkDt7IWUmYKliTjGJaE22gLmrcI2JhY0SceLyqeed3r11ZI3vQpW0I0CQ7dHYmOTEv3j42RN6By6BsO4qdlBdmQI0Ct+GIzpC9qO9pgRk4KUQJqS3eRVcXuEqI7sHOPuRS/c0lSEOmypsnFXFy3DkjJmUTni6bEALehiaGZPMw+ymFiVpcwbub0d2bJLpurrPLy5zvKBazXpZWG/ePIgjCEnR0QKrb7k8GJfsq25R+f1dImTl8IKWli3hS10TfepdsU9NBXqqIhJ2GO5BGHDmore9agEa2ptPUhundRYgQ9fbfUB/brlQPHD4THRnFRRI/gW1ojtR095gVKdpjxhEJijMUInt34wHuQ1JWLVA9Vw/T4UkCfeiOrhLh84KnQCChwYK9btuZhAGPLjUkLGYKRsgT58LoTFwE2AkwSqbqyU6owIFwEtTOMBwtA6SpZ1O77L8HoTD0fq936ZAZZaxGCE5HZh7bEUZ2dG1HUwNBB5hC9/PAFXG1lI6VCja99S4YELtanLAT0ZGUmCqBnfbZm1ORED3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(53546011)(6666004)(55236004)(66476007)(31696002)(86362001)(66946007)(186003)(8676002)(6506007)(508600001)(5660300002)(2616005)(6486002)(2906002)(26005)(36756003)(8936002)(6512007)(316002)(31686004)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJiR0hSdHZ2SERHQW1XUHo4UzhDRHd0L3c0dzJsT1ZhaUFRekRwaktQRWQv?=
 =?utf-8?B?bXQ0ZGorRFZYUEtmVmlKTXVyS0diNFlzYnp5RzVQclN6SFRIcWN4Vm1Gb1Vu?=
 =?utf-8?B?SzRLT1crb3ZVd2RoaUp6aGIra1l3RVRCNlFHQXpkUEFyYmNmeHY5VW9DcjVF?=
 =?utf-8?B?eXQyM3dnU2gwS3RjVGVWekoreXZWUjZrQWxhVDZoMFBrRGdkdjBWZ0FuVE9r?=
 =?utf-8?B?OEh6QUJ6WmRKdU9iY0tmL3NMZnFvNW9HWVBLK1R2cjZUeVpFYUwyTEtaYVh2?=
 =?utf-8?B?V1dYdGJ6c2ljTnF1R2tnWldyNFlqcTludGUvSUNaaUplUGJRQlBmTTk4NVhO?=
 =?utf-8?B?eUl1c2l3dktMd1IyZW03NXdYVkpvU0ppOUc5elZZdzFNTlYvazYyYzFTV3Ra?=
 =?utf-8?B?NGFyUjUrZTZuZm0vZXcwTnZONXlqcFlScDJsQU9tcWVETHJJdmRpb3JuZ3Er?=
 =?utf-8?B?MnRnMHlQY1VlY2xGeFZkR2FVbi9XUkt4WXlmZnBKS0xXRWd4aFZmSU5uR3Fl?=
 =?utf-8?B?YUdaRSsxMEVPaHRlZ1hOTE42V0xQVC9ibjgraHNKblhKdEhRUm4rTW5tQjda?=
 =?utf-8?B?NnBJZUxjL3hHTjJRM01RWHE0eXl1MXpKTFNCMGZNb2lhdk44Q0dKR2pYeXRP?=
 =?utf-8?B?QWtMcWpVOFk5T2JTODVveTZ5TUN1VXRqUVBYdjVGZHhhYmxmcUkvREFrejJ6?=
 =?utf-8?B?a3p1RlNWaVU0RFY2QlR4b0krNXhoNndjbWZUZUZ1ck42NytZRHg3OUY2Vlhq?=
 =?utf-8?B?cEVqdGNtK0dEZy9QeHorSXlYVnlxYVh4dmE3S2YzcnQ3T0pJOGorSHI0ekUz?=
 =?utf-8?B?N0ZNek5WWUgvN3Vrd2czME1rQzF5Q2QvbGkrNjRkb2c0UGoxOTMvZnZobkJG?=
 =?utf-8?B?bis2L21wcWMxSzJzc213N3BhT01jNTdZTXVpTytXWjZ6bGVQWCtucU9jZmJT?=
 =?utf-8?B?dmo5K05tTHE2SnF5T3dHQjVFakpuYWtRRW0wY0JuUVE4YlBLTXpGc0h3aEhz?=
 =?utf-8?B?VGNPekxnVm94R3NXSjZqUVVNYmFPRmFGQU5sZHN3OTBqL2tuVHp1YjNpR1BO?=
 =?utf-8?B?akJTNFBuMWF5eXJBVEVIRUxmSlFROHNwYjdDekNGZkdGZUF5dTJKOHVKaUFp?=
 =?utf-8?B?OWFaOTBoOXBUS0F3MktTbndzemlQa0taU2wrYWZYWG9uMGgrTHdWcVN0RWo0?=
 =?utf-8?B?T29JVU5sR0dwdlVIWmsxbU1DU1YrbGdVMENWSEc5dGZ4ZWpXNTErYVlndFpw?=
 =?utf-8?B?TjdUYTl1SmdIWXlMdkoyMVBBVDlWakR6OW5ldGZJN0lpUFJLUFA2cmZ3U2J5?=
 =?utf-8?B?QTBFclMxRmRsR2RoVk1EZTIrUVNRd1kxcXhsTCtjaVdBdnJiRTYrVGFOWTk2?=
 =?utf-8?B?bFFucFFMVTdaeEZTaEhBN29Fbnh3cFFUTUVwYzh4Q00xc2UzMFNjWWx2Tm1i?=
 =?utf-8?B?SENGcUdlWWx4L0o3b2UvRk12aGJmeWNrOWtJRGRPSmkzYTB0MzZzbnllNW10?=
 =?utf-8?B?bE12QmlWditNeU0vQ0kvTFRQeWIzT0N1RDlHbU9NWW4yWm4xSVhuYmVQcWIv?=
 =?utf-8?B?RW1nU1E0MVJHbmxoY3FnekRrZkcydGhHZEJnZ3NNeGdFZXdpdi9HTFZ0Z1hT?=
 =?utf-8?B?bmY4ZUxGbnM3ek9PZjFvWVhOeDNWb3hoVTRuM3hMZVJUaFlCTDNlUXFjcmMz?=
 =?utf-8?B?ek1XN2R5VVZJaWhneGEwUkQwcEszZVNEL3VycEpkTGVsbDkvZHVQMXRvcVJZ?=
 =?utf-8?B?a0M5eHFWL244bUQ3SkVHa2JhYXJrRG9VRGdlNE9mZUhpWFdwZ2lCcWdQVG9i?=
 =?utf-8?B?WlhrZ0VTS0dzV1ptUXBvQ2xxUHovWkJOYXNGekFLaUszWmRnVXFraUtpTnBo?=
 =?utf-8?B?bjJIZXN1SVBoQ1EvOEFCS1RlK0ljY2Z1emlLNmxlL0NKSUNRZUloZ1BObG0z?=
 =?utf-8?B?VTI3aFNWakZ1VTNnWmRFTlY4TkJNclRsZ3prK2FBZjNQYXZOTVh6dkUwK0Vo?=
 =?utf-8?B?dkFiT0kvcUNaRGNNek1La1BGRFloQXBmQ2hsNVIreXJDRDRIc3JYa2JDOUlm?=
 =?utf-8?B?SjZkdElSY0xDWHplc2haS2JRMVZzOTB2cTZ6bGVBQnIvVEtpRTBzbjd5ME0z?=
 =?utf-8?B?MnVwWmtlMTdUSk5uOHZTbjZ1QWRqcm41OE03OXEvL0g2RnJ5UHlOUEJML1NI?=
 =?utf-8?B?RERUaEtiR0RoalFiUE9UckUxeTAxQ0pxdHlLSmhxZENWN1p0a29FbzV4cFdX?=
 =?utf-8?B?OVgvVXpkWG5MTzU5djlhYnpDKysvR1Vpb0E5aytlVjJSQjlWQzV4Z3BkUnNM?=
 =?utf-8?B?TVVJMTF1aFlJVTJhcU1ralRnbDJkcUJTc0d6NGcvU0tZYktGMnBrd0w4T3Zj?=
 =?utf-8?Q?oNOF2z6laiSwQtNU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01135dba-a66b-4de7-52c0-08da34bc1cb1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:39:36.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxthHYztII4NtZfIzaoWyiJh2bk9BJ/3fDoqy2nQ4Qhjd6hy8MyWvxnCmLxkmGBv2aGluco3DWmcNvh2FnjE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/05/2022 09:32, Krzysztof Kozlowski wrote:
> On 12/05/2022 11:00, Akhil R wrote:
>> Add device tree nodes for Tegra234 GPCDMA
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 43 ++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> index cb3af539e477..860c3cc68cea 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> @@ -21,6 +21,49 @@
>>   
>>   		ranges = <0x0 0x0 0x0 0x40000000>;
>>   
>> +		gpcdma: dma-controller@2600000 {
>> +			compatible = "nvidia,tegra194-gpcdma",
>> +				      "nvidia,tegra186-gpcdma";
>> +			reg = <0x2600000 0x210000>;
>> +			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
>> +			reset-names = "gpcdma";
>> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
>> +			dma-coherent;
>> +			status = "okay";
> 
> okay is by default for new nodes.

Just so I know, is it recommended then to drop the status in this case 
or is it OK to leave as is?

Jon

-- 
nvpublic
