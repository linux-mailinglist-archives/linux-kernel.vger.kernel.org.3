Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDE14D1277
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbiCHImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345054AbiCHImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:42:12 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351553FBEB;
        Tue,  8 Mar 2022 00:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6dZZPs5Iaxu8tezEMsnLoKAG0CLmoQ5ZXJNI2wkqG5idibQxQ5Ip/0SL+kJJmBt2vew8sCWA9GVldmHdgOY/clMkXtlCHazSvgl5zZjAtj0oNQb8XFWbzxM/iWdh71p9KqJDuyqpyV7uEZsJtd3sADHSniMjcyG0T2vbtqzxN1IGpVI+fwZTaAb1PiYE71KznvfiV7uxHs57GDN7DA/RDl/78LavGAivKeU8+gpSOd/gHnr8un0O684RhYzMJz0mD4PzleGg0J69rtJlCrnxTLecC44iaeKmWWrjO4qSS2SMxdnMmJUGQ2YxvEgcLcXE5ZE1UfFoHO1LOMslkGNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsd/2nx0b55KUkOp+CPS5Jeb41m6DPVbeM6F4pC3kV4=;
 b=VksS/PAXvuaqpY+Al9ARfIXlujFfBJvk3/DmJ20RPL62YAHMz0e5LDPEzkXRRPEFfJfVhiPLLbUdydMNpsUofPOCL5QxmQIbhcCdh4zg54K5CUEAbX0NpMa72TcG0Qlz9JYf9CzwRAufRQsXkDVHIJY3ZKUUgcC6roGhRnMP16iwEoX7f7qoNC4ilP13UttPPbqzISNZY9UNgwZlp0doMZmSm4A50emn6ZOojLqlR7XzE45nz8pQdrcGluYOaokBy49vmg035vdy6zISA4FZmGk548lvVjwx1qak2kwyPqsHo2JZeSgliu8CCN629NvXcByhbfRmY8MPBPsSz3IdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsd/2nx0b55KUkOp+CPS5Jeb41m6DPVbeM6F4pC3kV4=;
 b=IdONKveYL2e3TeJh4FkAvnOEO0pkThK2IMbOjL/BGiuEQ0MBkr7z7Oz4LfJRm+78CWWIqOChZdkAR8H1mfzasffazLECkI6FaRorO586KEjfCUSatRKdN3ELbneU8UrZwELeIUx75R/Q+GndVW9E3kjMO68QIv5QQ0xXkIgXqd9ZfONCj0sB9sSJgdrT4Q56uGF8/Y1HhaLAfEXXxl5o6JR27PwbGei9TXCyxJ6XVGJzHx2rdeIYQDTsZWDBDFNYpKQQFII7xb0plVMWyFUDPDxxlJ65/UtRazwi1Ff2kgJiOZ3V/2lEC664sTvBfy491sBjDdyI61bW1GDMdbjOxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB5559.namprd12.prod.outlook.com (2603:10b6:a03:1d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 08:41:03 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::fd75:b9cc:faca:22fd%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 08:41:03 +0000
Message-ID: <d4dba149-f634-4b9c-ce3b-6a96de6afef4@nvidia.com>
Date:   Tue, 8 Mar 2022 08:40:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/3] arm64: tegra: Add QSPI controllers on Tegra234
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, ashishsingha@nvidia.com
Cc:     skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
References: <20220307165519.38380-1-kyarlagadda@nvidia.com>
 <20220307165519.38380-4-kyarlagadda@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220307165519.38380-4-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13796000-a884-46ec-ab00-08da00df60cc
X-MS-TrafficTypeDiagnostic: BY5PR12MB5559:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB555980D2AB482BBC2EC24646D9099@BY5PR12MB5559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/rr29gsF+tf1qtXoJlj1vcAlwLH9JS3XsDqZe0/pSaTKfyG32IFtimr75Oitia4YAUn35zcsH8vyuRKD5CAAM1XearhbB9wg66b2w9zWj80T8MUZqOQ5WrAP51opg6jW/csl3TidEouVuewHEZ3ufVZPuy/meABLD1AkzQV7zqoFn0eU+iZE/3DMjdtFpqr8kH+fQ6dNPKYKLSS4M4ETke5NE66+R/ciAcNmF5Wy6B8conrRI4CyX7To28EYQ3ar4QxcXhvYq5M2pq9JUtNCmgTRG7AkqtQfluRQxMdBEokSRh5P3OUbFFLejCMCIbHBr9vC7S6t5EVjp88Td5cpXfVeCq42gKSaQn3tk7wNoSBL+GHNUTTjoKXHuZC9y/V84c+uXa+OQjJoBHsVZWOlZgU//QBMdqNZOxyaRQhNmJoNo4q15v76/7vCuYC6VXJpJuYJttxPU0ATk/O4ihzRKQ9Qxp0RNDs9Q1qWNjlleT6BtCkYHI6oKqz1RhNUbf7Nz97qiASnsV4SSgMmEqYyK9gxnvqTsoL76azJAcWEEqmT3dhTSXklpx/RZMwWdq6ixSGsHezIMpNy3q3RNUoCpO8Eu4gKWrvniy0fhIYrpOQCEF+6lkoGKKVSBaXwsrNKwFThG5gkOlBt3/DKal13C5woRiN0Fm0Gvi5i1PNT1HQKIKnN1omGFXjLnUAtqWKBy8lbjQUb75SzAsXKHVDHpoBRszoPSgUDVFPW/HwlzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(508600001)(316002)(6506007)(86362001)(6486002)(2616005)(6666004)(36756003)(186003)(83380400001)(31686004)(6512007)(53546011)(66556008)(4326008)(66946007)(38100700002)(66476007)(8676002)(2906002)(8936002)(5660300002)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERVaW5RbGlWSGNtYUt3QldaL0R4ajJJeXZDMThjM3ZSS0FxRVNzOUJJL1Fy?=
 =?utf-8?B?ZmtzQ3lrT2UybmNnaE5GR3c1bkMwTnBlYkdnYm0zRy80aVhFWWZlbGJwL0pE?=
 =?utf-8?B?STdka3JZcFVUWlp2RHMwN2cwWnU4YjRVVVZ1cVJ4a3JSVUVPRGFPS1Q3UzRS?=
 =?utf-8?B?ZE54TklPa0FnSVp5QjRjNHdpbS94T1YvUEY4d2JTZHZMazhYV2NaU2Rkc0FF?=
 =?utf-8?B?bFJhV3E4Qng4bm5HNysrVzF6TE5jNmZBRXVIeWV6S21rRkxhejZGS2lJRFcx?=
 =?utf-8?B?WERPRDFQd3BFVFFVWGVPQmxiSGxTTDJUUHhqWjRpN3J0TDFoQmthUko4L0g3?=
 =?utf-8?B?YlpEN1R6aWNydzBuSHU4YWd4dTBuSEtibm53U0Vab2g3WFh0MkNGb0VwaE5a?=
 =?utf-8?B?bytkMGdXaVlMMnVXRUV6UUxXYXFGV0E1U2F2T3lqazg1ZnlXcU9JY1NTTXVV?=
 =?utf-8?B?VUw5eGdCR3lxNTdhVXVpVmlydnpmVmpiU3F5Nk9yTmhTOVZiT25PSm5Sd0Ft?=
 =?utf-8?B?Vk5yUVF4dG9qM0owd3NPdjBQdHMyUTJRQWNxSGdMWTRlUW0yNEdiWDdVNjNL?=
 =?utf-8?B?QU05NjkxaWlZK1Y2YjhySk1lK3YzU1lwaVd4Yk41T3NRVURqYWdYcUhyNGVY?=
 =?utf-8?B?MGdpL0QwVzJ6UXUzRFlkYVdDb1d5cU1WcUFzOTdhNDZTRkYxYkhjU3VlbWd2?=
 =?utf-8?B?UEZCSW9CRDZaQ0dxVFQ1M2JBZE4vczk5ak9WN011Q2lxUTNqZkVZYVIzZGI4?=
 =?utf-8?B?cysrYTN2YkcvNWp2SXVhRU5NVDR2Qyt1bXJ3RkRCdGlaWXd5VVd5S21La1BY?=
 =?utf-8?B?U0Q2aGlSekNTWVpmbXIveWxjdEpYeitqM3NXVzQvOHprNncxWkwxVHRjZHVh?=
 =?utf-8?B?WjRwaVJQM01wY09kUmh0dTJCNk9BR1FCNnFWYnJHWk5reDBCUzlrUytDSVlk?=
 =?utf-8?B?VXZ3NXhjU2JXTFc2bEJ5d2VSd1UydnQ1aHlXa3NOSGR2S1MyYTdzTzNEeWR6?=
 =?utf-8?B?dVJLSWNUVjdEUFR1bjBxR01ZQlJRWTlLZnd0dGw4aERBanE1SUNKMWlZQTR0?=
 =?utf-8?B?Q2FpQk9jU3dDbHNkbUNsdmVJMjAzTjBpeGVPWHJtQ3pzdDVFRFYwWVlUbnBK?=
 =?utf-8?B?TWlOenBkbkRERVNUQlpLa3Yyd0tlRENIc3RvMzRzQXk1UDg2alF6S0J5MHRk?=
 =?utf-8?B?ZHZqdGRKWjloQzVGVE5DY0wvMy9XbEJWUSs1MjR1Unk4Q3ZEakNZWVh0VUdF?=
 =?utf-8?B?ODlFYXFWdldjenNOenJzU044VWNKL0c1SG9VZGRNTnhjNUE4SlVPMzdxVkVN?=
 =?utf-8?B?NE9aOVNOYUpCMW5VRW5OVWhDMWhiaUtTSVdYMDRMU2RHakVnMHM1QjNTQlUv?=
 =?utf-8?B?V1Bmc21QUjJYblU4aGFIaDdTRlhaVlcrM05aeVpWM0dJd3lJREVFQ0VpYXUr?=
 =?utf-8?B?RXl0YTlIK05JQW9RN3U5dGhTNGFUMmkyYnlYWlUySThBenNpOGhzWUZvK0Yy?=
 =?utf-8?B?QlozQ011bGZoUXM0Y0Nic1NjM083ODc0WjV2VG05SkN4dDRjclc2U1p6anNS?=
 =?utf-8?B?Qmt6cTl1M2JVQ3lwbklZMVVKSk5tUFFJWGN1WTF2ZFVuUG5QWnVFdmYrMUc2?=
 =?utf-8?B?dDBaM203aGIzQ3pDR0VhK0ZXb29ocUdOcVEvWEx0TW5KYksrRFV5V1VnQ0Vt?=
 =?utf-8?B?dHN2eUpwTC9hTm9hSVZVRnlXOUtiaGg2WENRZHhlZkM4MnVXK1l5WEZ2ZjJC?=
 =?utf-8?B?UUFVaVdNbnFzRzhaN3M1MzIvdzJkYzVLMzMzYzF3U2laZFF1YmFRVldxRXJK?=
 =?utf-8?B?SG1WaFdndDNNMllKem1PRHkzZ0FaUHFxYlpQajFxTUtrYlRiOTNod2JqbzFa?=
 =?utf-8?B?Sk9NQVVnRUEzVitIQTZxa1lZdS9uRUJEUk1uM2ZFUE8wc3pBT0JIQ3JFbXRS?=
 =?utf-8?B?TVBzbCtDSHppUG9wNFNsZFhLL05RUTd4TVZTNTc0MnhtZ2UxUllPVmZLbVVy?=
 =?utf-8?B?WE92N2JPUjkzVzhMcnVzdnV1VllXZVE5ajg0TjVQUEV4Y3kzeGVXL05MTVQw?=
 =?utf-8?B?Sm1zdElNQWlUeGJJSzMvYUppaUVlTUd2SElzY0V1cXdOVDdkSCtKb0ZzTEpa?=
 =?utf-8?B?RlNNMW52QlhqbXBJcmhKb3pmbnhCVW5xakpYanYyVTdkOVZpbnlLYlh0ZmlT?=
 =?utf-8?B?L0lwYmpKYnY2bzNhbWg2aWxrL2hSMVdlU2JTcGR0SC9vR2lNcGEwNzIxNzRo?=
 =?utf-8?Q?oM/Di2QTigT0Z1mA6U5+Ha+tN7gmkYkE5BWtSBku6U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13796000-a884-46ec-ab00-08da00df60cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 08:41:03.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b4j3/nuGo+Wf86GDDO71aqmixMDmXb1agVVvNY+px63QGNaOWZNdUBFqh+vvFX4iF4/4C5+8TQprNwphHbpnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5559
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


On 07/03/2022 16:55, Krishna Yarlagadda wrote:
> From: Ashish Singhal <ashishsingha@nvidia.com>
> 
> This adds the QSPI controllers on the Tegra234 SoC and populates the
> SPI NOR flash device for the Jetson AGX Orin platform.
> 
> Signed-off-by: Ashish Singhal <ashishsingha@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
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
> index aaace605bdaa..bd82b324703f 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -666,6 +666,34 @@
>   			#pwm-cells = <2>;
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

Please sort these according to address. The above should be before the 
pwm@3280000

> +
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
> index 1362cd5e03f0..1652d8d9e106 100644
> --- a/include/dt-bindings/reset/tegra234-reset.h
> +++ b/include/dt-bindings/reset/tegra234-reset.h
> @@ -41,6 +41,8 @@
>   #define TEGRA234_RESET_PWM7			74U
>   #define TEGRA234_RESET_PWM8			75U
>   #define TEGRA234_RESET_SDMMC4			85U
> +#define TEGRA234_RESET_QSPI0			76U
> +#define TEGRA234_RESET_QSPI1			77U

Please sort according to value


>   #define TEGRA234_RESET_UARTA			100U
>   #define TEGRA234_RESET_PEX0_CORE_0		116U
>   #define TEGRA234_RESET_PEX0_CORE_1		117U

-- 
nvpublic
