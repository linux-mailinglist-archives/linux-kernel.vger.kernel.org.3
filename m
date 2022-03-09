Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B14D2B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiCIJBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiCIJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:01:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C8C8FB9;
        Wed,  9 Mar 2022 01:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtaeEoXetyorWNraKMzrxVYYio+YD7mzDrFJ+7blmMPK8rdEeTj+SLcj192UxjTd7p/H92p/Ncnapj5GkgFG+XQ1c8SyHjyeijG1mjkODFG46cXSqfekXiVc7OKbwv68udfrapSfGEdl+pm/ZVV6wOLZzlX86w34vIa6lw9HWXmkvLh7jJHJDKSyGtdMJ5xkzr5AJzEXhwZMWphoF+dve5q0mXof9Mln2kxpJBNMxCYoBhLMzSF0do6iLlOzI1rMGwzrHTQUjMZfnBNsj/r6ld0ui6EcaU2xZZevLwpc6f6dETGNiivg7rD50YvhA+NgBF8Ezv0ovLa1e6Vsvq8gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGuACBj1Hv8jAwaMK/3QGEiw44hDPfSRbRJsHan+/vk=;
 b=H0HF6pn6JvJpwc4lssEjL3fmJkfNduSRbc11VPyhe+IFQLdb+BhW7ewkPiHrcUoC0GuKdQC4QXyCd/RSY9XzCE3r8mA8s4CnxrlEh+lgDa0fLCb28GQRgMfnYXtxXGrd3hdLUH0SjcdXeq6J9VcvXU1PIOEa+fCEZj058LJa39MSZJhBirQTx7WefYVZfWCFyw3i9uje8JP8mSUPAT6MXvVJLuwSMKKnsRXCmi/c2WY2zetpFAYj4jAbfBw28fBKvUA8wePxJKJ8NLGBC7mAEoSdsaqSSCRQh+uttpz5px6j/tO+kr2D05e3n749JpZtuhcRs7msPy44QD4hx41i7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGuACBj1Hv8jAwaMK/3QGEiw44hDPfSRbRJsHan+/vk=;
 b=RR7qDkpH8dDWk4PQCA22zyOKmEjMLDozKW2EFvthF9GFdHMGaI+ZBPjjzWQR7S6KWf9Qy8FThI9C32Qv86W8KrBEwYP0vkyBgVZ3d5zSxvhMqv69yNY/sb+HD/OFB7rWgnGbVn8igpeJqIVXO/ISCFwTK99KcHtsiAInYVUYt10GhiCQYeyDpXEU4j8b0MDY9M2mAB/qYbf0nmKHQ/bibbVcZQJJByTr9ni6yTB73Cd9HYP15T8G7mFzU+B3a6aAs/2EaWOJpEczOHkW+f+s21ulhSy6pLS9CzUB88U6TN0Y96PeyQrSZWFkFHzf4hXi+iqv/J8olHU82T16vnE/QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:00:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:00:32 +0000
Message-ID: <695e2818-d924-a535-1b27-58c4de4a8452@nvidia.com>
Date:   Wed, 9 Mar 2022 09:00:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] arm64: tegra: Add QSPI controllers on Tegra234
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, ashishsingha@nvidia.com
Cc:     skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
References: <20220308183026.66394-1-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220308183026.66394-1-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ab241a-ac53-45a7-5381-08da01ab4420
X-MS-TrafficTypeDiagnostic: MN2PR12MB4093:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4093445A1F27270882E94340D90A9@MN2PR12MB4093.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk+abTVZH7XGDBvVLV479pgydCw/PC6w4D7TW9IU8cp9YXWl2rDBpZKVchXb0ddLtsBsSYx/0sAps1O96iw0n10ZT9kD27G9YAMBml31F4gG8BtNBKVmkj2xkfUt9kn231J0tQRY836JS7Y2wSw0o2YOlB3Qm7j0kCeQZUYriTeW6MJGyP0U7N199SJAAtzsPlg6GbVOhpFB1Mjs03GkmJ7CLozgFzIMvJTIyTy3cDp8Ci8e+YIaW0n9MwPpagsg6yEhVJQpvM5S619WEBJFpRItY5cpifI2rNhKyarfUakzyoPeiDPj6fI+1EldTUsf+d71TBhbi1qLawrH137QpLMnxkzRWDTGFktagYKx3uVT0IsQLoVscX3ApxWRbARbrWGobA37Gbvr+YwN5BZ8obnGS3mCtyDtOIm7TzmelaRVDVrrTBwNJ8uAQZy9AzT12ldkn/zFr/GEyNyTVALHDv9r1LWqSOZSFOv6h0KXWTGF/q7+NsGbxYOFhWYErYHyr9Uk579bfZTPZleXBUqXbcJwKNXT5ZVJ7B/zpkTxptlZQonnJbG2RxXGkNgAlM5uW0HC8ih56uTmVYM5vu5dX4tqShrUyeU5YJdG0wd8ArckwGCUzuc/d5pPFXrfT0UuCJm3tj1syzEhM9/cPmttEyQRkImfliTS2f+graj+1qu42jnzjBM598Be1hfchdck5gcSiVPL3lFhsT63J6Gr7hU8Qe7cA2UAf7ft67lK6gkq9jkYIFrMbFvB7elgJEeA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6636002)(86362001)(38100700002)(83380400001)(66946007)(31696002)(186003)(66556008)(2616005)(66476007)(4326008)(8676002)(316002)(36756003)(2906002)(8936002)(5660300002)(6666004)(6506007)(53546011)(6512007)(508600001)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJwRXhORjZ3Mk1EQm9WZVl3aGRRZXZSNlY3TERvUUpyNzV6dURZcWJrUURR?=
 =?utf-8?B?NzNkQnM3TmZBT2hZbjVEWFFVL2FpVjhBV3R2ZGhPRlBBWE01aDlVYWZTblIr?=
 =?utf-8?B?aUNPVU5iRDlKSzdsT21WTnZNS0ZQbmJMRlZSVkkyTVJUZEdTYVVQOG0rRUVm?=
 =?utf-8?B?V2tENnFCUWh2YlJVNTA3NVFDcThiQ1hvRlFuZjdHZ1ZyUVRFTmlPcnYxY095?=
 =?utf-8?B?eG52MURlYlhUd1lMb2VxTVJDT2I4cVpxUW5HUlZqU2EvTnlCWlA5YXAwWkpr?=
 =?utf-8?B?MFFSU2laOGw4UGpRSFdJVlNyaklsMkJ0d2dwVkowT280ZElPWkNzdE0wZ2t1?=
 =?utf-8?B?dkdBTGZITDMzTXg4RDZFUTZ2SmJzYWtOQXFabjZlVFFpYkRZaXE4S0J4L0Zn?=
 =?utf-8?B?bFVCeVQzbFp6OG9lWklRQWZsMmhVM2d5L0pNZVJER2JPSWVHVytKdUJwb1l1?=
 =?utf-8?B?NitGa0RIcHVqNGkxVUNRSnlvNEVJVnZtV21yL3FwcXVUS255djlXOEZUaHNB?=
 =?utf-8?B?WnlKZnRTQXBtczR6bGZxYjczMEpOQ1Y0c3kyajRXNC9aNlJDUlBXUXBveFpE?=
 =?utf-8?B?enp6ajdjU0RzMEc3dVJnMVdha1hjR1hvUGs3TzZtaXVXRmo4WlhJQkRpWFBM?=
 =?utf-8?B?TS85dk95dlFRRmhlZGdKU3VWVncvN1FhOTZ4SGtyTHFhM3hnTjVTbk44WFRN?=
 =?utf-8?B?bCt4dEFaOW5pQmxDS1ZCSkZCZ3E5dDh3SmdncHM4ZzQ5VlZobWtROGV3MHdv?=
 =?utf-8?B?NUhjK1Nsb1FkL05kMytrY21GWVNna2tCVUhnOXFKcVAxY0ZYSUxyazhtWHVr?=
 =?utf-8?B?azZTd09FbSt0djNtbmlQZlExR0g4bVlwVjBlUndPSDlQcUR0c2ZEaUs5NExz?=
 =?utf-8?B?dHRlZHhqNC8vNmhzamU2YjV3b1RFQTd2bmgrVVp4cTVDaDYwQ2hlb3hZRERY?=
 =?utf-8?B?eCtQQUxoVysrKzdzcVdRNjU0OWZ1MkpCY3N4U05EVkZlYTFUam16R2FZaGdD?=
 =?utf-8?B?ckFZVm9tRVY4cTcyYk9pcXczUUwrVmlqcUtTSTZvbFN0RDNuaWdyRXFhQ3pp?=
 =?utf-8?B?V1cwTFNjUlV3TWt5clFHNFNrRS96UjM2cElDbzZLSlFyN2hpN0VOK01LelFT?=
 =?utf-8?B?SDFzQkZLNEFKVElHYTdEK2Y4UkpQVFlqcHcyZTVWSWZ3Smd2WmQ3dEdlM0ND?=
 =?utf-8?B?WXBUWnJMN2lqMnNxRUZwakNVRUpMc2tGWWZlbktDUEl0SHc0VFNPRFJoMFJs?=
 =?utf-8?B?Z1pqL09pZEIxWmdDSThKZE4rWGtRV1d3WVdyM3RJT3I4TWRpMnFBQUJrTGNt?=
 =?utf-8?B?NCtwOHU2NGFUeWs4NG1NankxTEUreGJJdFFpMnJSNkRyazVNWXpXZk1xNzQ3?=
 =?utf-8?B?dzVKZ1RmdmYwRStHaVgwK25OdVlXVDFvRXYvSjB6dUpNdEoyVi9QY3dPZ2ZQ?=
 =?utf-8?B?Kys0RXFQbXc0OTBoMzc2SE92R1NvbHlQNnhnTXVReGtidlVnZE1PN0Y4RVFP?=
 =?utf-8?B?WDloT2M1dnF5dFN0K2tqaktpcjNBblppUXhwVFN2NHF6Mk9NU00xQTlJZmdl?=
 =?utf-8?B?VlE2Skw2WjQvQ1d0SVNhdFJTdzY0UjZPSjZhT2J2WE96YjJId2syMGtCNFNa?=
 =?utf-8?B?cWdhOGhrNUJHV3ZtNHg3b0dYTUpIQUl1UUc0QkgwR3ZoMytBdFNoUDIwNTll?=
 =?utf-8?B?QTVUMjJXcjJ4U0YwenFKYjV1R01BVm92b0w2TDJ4ajdjOHdTN0ZCR0RSZFQ5?=
 =?utf-8?B?cGlRcWpyYXIxQlUyYzM2UkI3SG9vMTY4UUdGZEo2RXloeXdJMFdUZW15VDhs?=
 =?utf-8?B?ZGxldkU3TVR4M2tRSGNzSG9ZdHp2RW1IbW1jcUI2R0xOeFg4aUhtSndVT2Z6?=
 =?utf-8?B?TUpuV01uNmdpb3U2OTlJazYzaW1JVHFTQjkycktoNWZJbmhTdi9ZUGlsd1oy?=
 =?utf-8?B?MFQ4WnZBeDlTTWpXLzYzaEh6clJKQzBmZlQybTlkYjNQS1B3ZEJTV3JFejln?=
 =?utf-8?B?QkFWaHEvWVQ2eWhoaThsY0ZZTTdwb1BzYm5NZGdBbGczY1NCbUVOOGpVRG9s?=
 =?utf-8?B?SThucXFBQ1RUTVExdWhqWW9XQjRqVXM4NDUvYk1XK1ExcExCZnZXRkRwM1RV?=
 =?utf-8?B?NjBlSS9GZDZxZmlJZ0R5MDBONlZMVythUW51V0ZGaEFOSHVTdENmbE1SNjJK?=
 =?utf-8?B?SGdZUXlCVjFuc0RRZ2RDc2RKbFlWNFVNWmc2T3JycmV1aE1GMTdCRVpzY1FI?=
 =?utf-8?Q?N/dR6cDLbn1LPikqrDdWPWqqC0B670L0FkwPhE7Baw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ab241a-ac53-45a7-5381-08da01ab4420
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 09:00:32.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1SaYG8Rbc/LeXUrz9YudympAstyf8IecTSeyJZr3xLhAM0EtiQ2cBQGIPCN2niA34zTy5yOAx2kfwb9UXffWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/03/2022 18:30, Krishna Yarlagadda wrote:
> From: Ashish Singhal <ashishsingha@nvidia.com>
> 
> This adds the QSPI controllers on the Tegra234 SoC and populates the
> SPI NOR flash device for the Jetson AGX Orin platform.
> 
> Signed-off-by: Ashish Singhal <ashishsingha@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
> v4:
> sort definitions in include and dt files
> 
>   .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 12 ++++++++
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 28 +++++++++++++++++++
>   include/dt-bindings/clock/tegra234-clock.h    |  8 ++++++
>   include/dt-bindings/reset/tegra234-reset.h    |  2 ++
>   4 files changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> index d95a542c0bca..798de9226ba5 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
> @@ -7,6 +7,18 @@
>   	compatible = "nvidia,p3701-0000", "nvidia,tegra234";
>   
>   	bus@0 {
> +		spi@3270000 {
> +			status = "okay";
> +
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <102000000>;
> +				spi-tx-bus-width = <4>;
> +				spi-rx-bus-width = <4>;
> +			};
> +		};
> +
>   		mmc@3460000 {
>   			status = "okay";
>   			bus-width = <8>;
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index aaace605bdaa..448512af7dea 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -654,6 +654,20 @@
>   			reset-names = "i2c";
>   		};
>   
> +		spi@3270000 {
> +			compatible = "nvidia,tegra234-qspi";
> +			reg = <0x3270000 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
> +				 <&bpmp TEGRA234_CLK_QSPI0_PM>;
> +			clock-names = "qspi", "qspi_out";
> +			resets = <&bpmp TEGRA234_RESET_QSPI0>;
> +			reset-names = "qspi";
> +			status = "disabled";
> +		};
> +
>   		pwm1: pwm@3280000 {
>   			compatible = "nvidia,tegra194-pwm",
>   				     "nvidia,tegra186-pwm";
> @@ -666,6 +680,20 @@
>   			#pwm-cells = <2>;
>   		};
>   
> +		spi@3300000 {
> +			compatible = "nvidia,tegra234-qspi";
> +			reg = <0x3300000 0x1000>;
> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
> +				 <&bpmp TEGRA234_CLK_QSPI1_PM>;
> +			clock-names = "qspi", "qspi_out";
> +			resets = <&bpmp TEGRA234_RESET_QSPI1>;
> +			reset-names = "qspi";
> +			status = "disabled";
> +		};
> +
>   		mmc@3460000 {
>   			compatible = "nvidia,tegra234-sdhci", "nvidia,tegra186-sdhci";
>   			reg = <0x03460000 0x20000>;
> diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
> index 8cae969e8cba..bd4c3086a2da 100644
> --- a/include/dt-bindings/clock/tegra234-clock.h
> +++ b/include/dt-bindings/clock/tegra234-clock.h
> @@ -140,6 +140,14 @@
>   #define TEGRA234_CLK_PEX2_C9_CORE		173U
>   /** @brief output of gate CLK_ENB_PEX2_CORE_10 */
>   #define TEGRA234_CLK_PEX2_C10_CORE		187U
> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_QSPI0 switch divider output */
> +#define TEGRA234_CLK_QSPI0_2X_PM		192U
> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_QSPI1 switch divider output */
> +#define TEGRA234_CLK_QSPI1_2X_PM		193U
> +/** @brief output of the divider QSPI_CLK_DIV2_SEL in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI0 */
> +#define TEGRA234_CLK_QSPI0_PM			194U
> +/** @brief output of the divider QSPI_CLK_DIV2_SEL in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI1 */
> +#define TEGRA234_CLK_QSPI1_PM			195U
>   /** @brief CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC_LEGACY_TM switch divider output */
>   #define TEGRA234_CLK_SDMMC_LEGACY_TM		219U
>   /** @brief output of gate CLK_ENB_PEX0_CORE_0 */
> diff --git a/include/dt-bindings/reset/tegra234-reset.h b/include/dt-bindings/reset/tegra234-reset.h
> index 1362cd5e03f0..547ca3b60caa 100644
> --- a/include/dt-bindings/reset/tegra234-reset.h
> +++ b/include/dt-bindings/reset/tegra234-reset.h
> @@ -40,6 +40,8 @@
>   #define TEGRA234_RESET_PWM6			73U
>   #define TEGRA234_RESET_PWM7			74U
>   #define TEGRA234_RESET_PWM8			75U
> +#define TEGRA234_RESET_QSPI0			76U
> +#define TEGRA234_RESET_QSPI1			77U
>   #define TEGRA234_RESET_SDMMC4			85U
>   #define TEGRA234_RESET_UARTA			100U
>   #define TEGRA234_RESET_PEX0_CORE_0		116U


Thanks! This looks good to me. You already have my signed-off but ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
