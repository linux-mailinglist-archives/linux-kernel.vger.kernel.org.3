Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF64F688A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiDFSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbiDFSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:00:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5040403DF;
        Wed,  6 Apr 2022 09:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnWhRbbfEv7DjBxDQIMiYWq49DrS2pBivRTQvakFg7TnIdaU3zLSc17/kBKEsELFSodt3/UdzJFN1Yi0s0kkavYk/Qzew8K0rb97GyLSg7AThx8joB8nn4Q+bx5Yrdq7qZNWPYNfP1qCFeDqqC0v8CTkPbTr4GcE49sBuooxUYE7rgSsjLZfqXUaEUkCJBNwOn0w19d3F4QGsRzSNuQGu99c9HjH94a9J2HL+CtZkTB7kj67NKe1kStEZt28DfDPlqiNoJ/1S+odTUq/cAvzZ5Y3swzRmb6+S5XHYLBA7IKlz8MlS/I83phwq9nwpaiib+55ZUKC99D6LEQJo1/QvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkt0gO2L/C5Y2YKTU1aH/k3mxdgQmSaSyf9P6VhUQyI=;
 b=XDFGCv0heH9J56xkosAjOh+2DGpjkWNwd1VBEFH54gkPkY2uJ6ALDNDYlzWueKeVlKn63T/dfDvuJC7VwUer0gFHImlkMXr7y1FQlTkszmEOAbgD1wT59F97R/wCPiKoQzmoqOEhzNjAGaxP9bOyWX5gYOoTF+7LbAyR2ZDogVSxP2xr3Hw2vVAZUMb3IGjlfkPEg6lS6eKKHCPBM+/OZ065gOL4VTTRcP0yMIhsJz+rUME1ao/eKp0dtsGqgO8arWedYqjzuTM36Fa59aecGMjIb0z02OFkiot9NFbDfnTnNqOPGULaU65RQU1ijI3LAIGxN8/Q0DE0QL4Gh/QzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkt0gO2L/C5Y2YKTU1aH/k3mxdgQmSaSyf9P6VhUQyI=;
 b=bZXNTdijkiJ4gV3EnTOys1xQJjGNOyoGyGAB3VJogUK88fvXXY77zb/3OwSNEbBvdBss5yjYFDUq9FYdie9WNR+HYgpvCh46ap13M47b3s1gfRCyNKAqz9OO2YhkU7usfmwSJAzPuwoWF7Bra6aGAB6/rzBvBpcWSSpCxtwtrzqJU4bqlrvJy9MCSzIBAdDFK2wcuFrg2D9IVqilVO2B3v5a7swYr9p/60RscJ/coSu7/XO0nNuTuz3MTas4qLiREfeuGIl1OW1EImUrxIGqbGg4EICYpDkccbc1j0QQG5B/mH/uFy+iofMfSgSD5mBbKBb78n1SQlnASxc51t+H+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 16:16:16 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::10ef:dc56:bb21:76f6%4]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 16:16:16 +0000
Message-ID: <279acd03-b2fd-3bbb-8c74-e7255f4df352@nvidia.com>
Date:   Wed, 6 Apr 2022 17:16:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: tegra: Update PWM fan node name
Content-Language: en-US
To:     Thierry Reding <treding@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220406152655.264074-1-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220406152655.264074-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 552c017c-be46-4172-8191-08da17e8c6da
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43353A0607F7356D749250A4D9E79@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ldz2eFkwRc0MrciqZ2SXnsFFvUgczoMsdCLzJ5JyU60Yw0q/BAXeS8W7CTOvdJ36d8G1n0nAUJ4nFBML8cj8Ix+MlmTtlpp0t+CS573B/n+T9lrKIegcfAXncLvCOmwhPZ4mh/2ccllsbqhQSC7E/5Hqzj51+Le76M7dvqfximN3g2lxGOGV8W9vaeqqimfZgVFqyf8y627bxtiIrkvsxuhymBmC4Gkw2jwbMhpyu6zXUyMZWE3+Zv5zgniMutpW7mryO8N/BkwAopPrld97rZQFqmpDFr+H3o4tSOx+0kZ+2uiyhn10/YXV+D0/28tEKNBRY6pvWX1iF3Kq/QG+cE1Ye3kFll+CVXw0C1KgRK4AK+DIIxmbkfIccefe0kmPt3OE+0UheukiexLTWsGysdmECG+nIKYDQGzrWAG3N9+5ZuuPHx6LX5CYosSwi4Jyz7Dnl4GRe9nAq3MamVhC3TNthQxZdVWqUJTFO1T5ytPr0/mnS25O7lnaIG/4+0DqeyDbEL7yqfJcnvqjNh89Y6q/lwzDz6XTozcOS8nmrQvLzVPu+F6a0yP0s9AeVxQVv0mPHiW9+n5tw25SX1+HSpbu8LXzSFMnFJk+fuahCgJ8ouRqxTb55e8rSvQd8JJmpsWy1hToZ86RKmgE8IesmxHLdQOncGibmNn37qYy3QjdPmX0MpuUbZkwV49eKPiQ3ba6xSGiCkaeb6pppmA92ABm/cZPJ+KVmMd9i0sluEw4ie4IfSgiTz5w7xmva+u9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(316002)(66476007)(66556008)(86362001)(4326008)(31696002)(66946007)(6666004)(8676002)(186003)(6512007)(6506007)(55236004)(53546011)(2616005)(26005)(508600001)(83380400001)(6486002)(38100700002)(8936002)(5660300002)(15650500001)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk1WVFBSNHZIOUJmc2tNcDdmUDBIM2pnb29EWkpvRzRtbVk0RlAxQ1FMdDd2?=
 =?utf-8?B?R01yOE9lbFdxRWk5UWRoUUx3aFN5R3ZQeE1vQU1hK2xPc0ZadkNST1JLZ2JU?=
 =?utf-8?B?d3FoMFRUUlhHZ2ZIN2FSS2U5VHhtQUVXelNBeFNTTkdZZjVkeFZEM293dkds?=
 =?utf-8?B?WVBKTUxXS092UHU1cFF1d1FDc2FLdU9GWmdYbWkxUURBNUxzWHRjYWw2M1hh?=
 =?utf-8?B?UkVhUkF3MkZhZnE2azg5bUpZamhEWXVlaTJJQnU4dXB3WFJhWFlYNXhqM3cr?=
 =?utf-8?B?MGZxQjZTOXAzUnMyWTczWkNaUTJyUzRURHdJTmhMcFVJQ2RLTVdyZDNob3lE?=
 =?utf-8?B?Wk9sTExhOFFHclJXdkl6Q3ZBSFdybVZWWUZvRXorN0pDSzlSSWVKZnBhZjA4?=
 =?utf-8?B?cGVzalJWSHRidFBvYjlOcUN0YzdvK0I1OE93L0gvVGdKN0NmOTNWVVArWDFO?=
 =?utf-8?B?dFRiQnJjK01kUzJzNzd4SXBnbE9BZlFWK1BLMGxDWW1ENTg2OG0rcjN6d3U5?=
 =?utf-8?B?VVZPZkpIVnd4M0NRZkZBT3hic2NnVUN6blVsNnNzUHJSUUpJYXMwUEtZaVBT?=
 =?utf-8?B?Sm43T3FwbE4zcGNIVEJ4NEZ2dGttOTZFeDlDUnk0QjliaWsvUk9CelFFVGhW?=
 =?utf-8?B?b1QxcmRBSzltenlQcmpnWFZaeWlXazRwQ2RUOUo5OENHQlVpazQ3RGFLTjlY?=
 =?utf-8?B?RW1BMVBNYjVRVjI0RXBycGgvWVhpVXRaY05iUXRJK01qSnRhSWdyU0N4ak5O?=
 =?utf-8?B?WUJIemhyNUVEV3N3L2VxT3doMVBobEFDc1YyS2wyS3dtckRtblBHYVA5RHJS?=
 =?utf-8?B?NkR6enV2WS9QejZzVUNTTys3b3ArbzdHRlM2S2ZQcGNtUUtzUVdxOEQ5M2JV?=
 =?utf-8?B?NHFMWi84ei9jblMwU3UwbGlrRkZRSU5HNkRJaWpiVmdoYkp6SXJvVkhFWndM?=
 =?utf-8?B?NVhybjZtY1FTejl5T0l6MG5xTXFUNGlGMkVPcmFHQjlmZFZmZENMcUVnM0hG?=
 =?utf-8?B?My9zNWRqdXV3Nk5FdHYvRXRLMzVZM2lYZndaL1RUQlEwaTJlVDFGOGhpWjA0?=
 =?utf-8?B?aThXdUZpMGZ1MUdGa1hzZTVUZzFDbEZpMlZpdkR1NmFVdXVsY0NwZm5aNXdr?=
 =?utf-8?B?a1luakZBMFdIakJlMEFNSll1UXBEZHMwWlVWL0l1MmZWVnBBakZxYjdOYisr?=
 =?utf-8?B?RkRwb3VoQXRjL0VzeUV6bDFJcCswazRtZlRJajJzclJzcE1IdW0xYTZvWHJu?=
 =?utf-8?B?QmNzMHVQS2RSaEVJaW04ekxRSUg4TGJSb0p0RmpnMnFjNEx2NU52bjJITExr?=
 =?utf-8?B?ZWY3MldCeHJjMUJYaHZIbUhFMnJ1cGs5NWJTVzd2djNwNHpqSFhock8yRFBq?=
 =?utf-8?B?VGVhYThid0dabHlwSnV5MzI4bEVUWG52V1lBNUdqRHpaSmx4OWtucWZud1BP?=
 =?utf-8?B?RDZSdVd2cTJFODBPUzRhRFRkMlc5RGRtblFkZHpnV0QxRVJ2My9tZjZ5Tkdl?=
 =?utf-8?B?QktqVWo0YWVQdHRMRm5kREdHNVcweHEydDErakoxUTdkUllqclJ6OUtoaWZ6?=
 =?utf-8?B?M2FwOW5MajBLenJTa2dGWUhHLzY1SGVpRndYdlFBcU0xOFNkaUd5Y3RPTDlT?=
 =?utf-8?B?K29Ed0Ryakthd0s1NmRxazJEaGZlZ2c0QlNTUEdIVGxRSWcxZmRpMmRnc2Ev?=
 =?utf-8?B?RURtd3EwRDBYUWVWWGR2aEZCNzdIMmd5VjE0L3VCc0JDYnc3dkJhYkkreDk2?=
 =?utf-8?B?M2dDeklLb2JyM3ZxWm5DMTV3dFlnTUhqWTIxRlF6NStiWi9oNTFVYjFUYTk0?=
 =?utf-8?B?bldGWmp4ZE5iY255Z04rSUxqSnpCREh0MXZ0WGtSa2tRblNhNFNiVUNMVGlJ?=
 =?utf-8?B?Zy9LZjlYMDVYQWhuUFN6blcxRHBlZnc4QjBTRXJPQ1ozMC9DRlNRZEtXdWpU?=
 =?utf-8?B?b3ZZaW1rVlA2YW91S1hzSzZuVVBaeCtrSHhrUjZXRVB5VEdzNjhUUXlGNEpF?=
 =?utf-8?B?M1JjTmZlU0RISWt6SU85SHdCZUFSV3ptNUpkVmpJTTZwaXU0OEtXcUNkTE5C?=
 =?utf-8?B?MU1QUDg2YjVBUEdBV0htVXNOOVhmRXlrdUdBTDN5ZEFxR1FhSkIvTHR5RTE3?=
 =?utf-8?B?UGlNU2M3Um1qNis4SEo4a3dQd0huVXpKcWI5dXZrNWtFQTI2US8rYmZacGpC?=
 =?utf-8?B?eFpHKyswcHVZYUk0MUt1c3RXQXlDRG5oSVZzMmZ6SWE4bDJjQWwrVFo1Ry96?=
 =?utf-8?B?ZVVGTFFNeU5XVy9tWlQ0bWhsQVVzaW9pTmoyOGhQZjJOemZxUHI0SzVyMFpS?=
 =?utf-8?B?RHdRbDJ1bzJoUFJBeDJHMzB1aTg0SEt6QURIVVdmRVFNTUZXMmhpVHAyTWRN?=
 =?utf-8?Q?9yWrAmmbfZ+XqtwY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552c017c-be46-4172-8191-08da17e8c6da
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 16:16:16.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go7VjyNjhLdvFQE8cXMpZgAR41BeBo0yGcURdRZOfPBoaFyGG9AbVHPwyiTrGd1yiUVk8ClzR02yQ8DRFQLizQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding linux-tegra ...

On 06/04/2022 16:26, Jon Hunter wrote:
> According to the device-tree binding document for PWM fans [0], the
> PWM fan node name should be 'pwm-fan'. Update the PWM fan node name to
> align with this.
> 
> [0] Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts | 2 +-
>   arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts            | 2 +-
>   arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi           | 2 +-
>   arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts            | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
> index 4631504c3c7a..7e9aad9ff177 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
> @@ -349,7 +349,7 @@ gpu@17000000 {
>   		status = "okay";
>   	};
>   
> -	fan: fan {
> +	fan: pwm-fan {
>   		compatible = "pwm-fan";
>   		pwms = <&pwm4 0 45334>;
>   
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index 2478ece9e67c..27d28626bf5b 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -1989,7 +1989,7 @@ pcie-ep@141a0000 {
>   			    "p2u-5", "p2u-6", "p2u-7";
>   	};
>   
> -	fan: fan {
> +	fan: pwm-fan {
>   		compatible = "pwm-fan";
>   		pwms = <&pwm4 0 45334>;
>   
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
> index 32ce7904f44f..8033be098f34 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
> @@ -1993,7 +1993,7 @@ pcie-ep@141a0000 {
>   			    "p2u-5", "p2u-6", "p2u-7";
>   	};
>   
> -	fan: fan {
> +	fan: pwm-fan {
>   		compatible = "pwm-fan";
>   		pwms = <&pwm6 0 45334>;
>   
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
> index 72c2dc3c14ea..746bd52ea3f7 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
> @@ -1657,7 +1657,7 @@ cpu-sleep {
>   		};
>   	};
>   
> -	fan: fan {
> +	fan: pwm-fan {
>   		compatible = "pwm-fan";
>   		pwms = <&pwm 3 45334>;
>   

-- 
nvpublic
