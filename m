Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0A94DD651
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiCRIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiCRIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:40:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1951126F90;
        Fri, 18 Mar 2022 01:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHhoDMsgVinZJljrRIgXJonAx9x/qvWmFiihsxL3ezhG+5XCEo9zetbgm7kQ/BARAQwIydPuQQNzph1p46jWZ4kGoKefrOJN7IDhDgIojasxw3J43t7Ai+cnjBD/D57bCBSVNpf886cSVTUnzSSGFLomFkBiNKMQxJP2/0by6V6OO0c4apBGGV/NYCwxOJyqydA6mGrF+tJiymuxiARaQxBxccChK4T7tAzLhdvabNeTVEn27sZFn2hNpKEMZDHG8Rsa+Wlxx6xLqEqPSjVOPZ9sYjDCsg17nJTlkqef07P6XCa5fNHC57yLU0+egyDPOlwo1o2zxRAC+wBRKsThiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxsEuN9q3+aMhkWfKF1oUFcYAKL+YiAiMsFKEOXQRbw=;
 b=ScPSCzfC2ZnNwPgNnFna2D4+qFWPDHuRwbCzFpll4PRwzIWhFidffSsIC+wa+SOBbhRd/DCMArgaoM5p63iTIY5jcVxeI5iyO+uyMXVOTK7ws9IJH32hNTYnI0QPshEeH4mbUNKozfxJ60k/lbpRJMG1MRBibEzWbKywYKW0YCK+2IxFTOiTRqPWIN1c6aXbGFJhA8d/V0qY+yfE0uEElqhWXZEl09WycDIbtbPN7A9BRPnGE0bNIVhym+wmeM9ujSixub7uCinNfHU0xOKNCfZRQMHC4YQ6mLpW1CNP11sHn8ZqxnF/thPNaxXY0qiQLCOrApy3+EnPEZ0hboLb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxsEuN9q3+aMhkWfKF1oUFcYAKL+YiAiMsFKEOXQRbw=;
 b=Pst9MQenZQ8CeBvtzW41Po5iuBwsLsnJK+XLCYOoC7ce2hBzH9iPe+RKP8fapcENpxP705VLKYnUqoh24LF+h1cs98LGJmFaO2XXR9EGHjPmXJW6y6QSk/3Q+IZi7S5D1TEwwkuHwBl3INCBWH76CindnYHYiLemzMFjvesSyAP2p2CzpAE6SjL84nB6T8C2SqL5bGVL7ZtMRoiUIAn/oO8u7adUkcuJhUSD9EgZUAlXMs6KXIm9Mr2vppZpsW5LTwBCFFUSByVQmfvNgA8MrtYNmM4husFt0zwJ3lEvu4zmL3678GLR27KcdXaHKWnKtfR2MTWKUd68nnxFd8Y4DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Fri, 18 Mar 2022 08:39:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::88c:baca:7f34:fba7%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:39:38 +0000
Message-ID: <30bb04fe-4fed-04bc-6f99-158ac09d6bb8@nvidia.com>
Date:   Fri, 18 Mar 2022 08:39:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch v1 2/3] arm64: tegra: add node for tegra234 cpufreq
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        treding@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
References: <20220316135831.900-1-sumitg@nvidia.com>
 <20220316135831.900-3-sumitg@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220316135831.900-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR05CA0024.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::29) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5196b13b-a450-4d55-3d96-08da08bad699
X-MS-TrafficTypeDiagnostic: CH2PR12MB4182:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4182A0EB28E5427924D143DAD9139@CH2PR12MB4182.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNMSiuup8z/VUF/2vNwoGWA/lJLz1FidwWVH8AL6cXO0VEsMa4Sfg0tR0ckKEAWLeu5hTsAOQ/JPNmyWeILgU4KZflHmy+r3hKhbAnBFuFS/zuubE6DGoM0/ttiDgz9/HTpxBIaAHia7E0pvuuljGSapmgH7tveKF3N+/n7IOP84RljB8heWiWKndipTRNtZTf5cflpF3fjIPIsz9Ppsk7+eGVy/AUNizQxY2hHQqVo3vRNARHoRu3rpC0YHaZ8Fti6h3gkJjCVc5fq8yy6U+lc/twiO23Bkutdouo5ejxts4DHyQGXeohf+/VAGHYdIw25U0C+lbi6OulTHnAXlUUEGubeQndIjjOuj4LD8nefi7rRbChMfNxHNkZP74L1vTsv9cq8qbBRZC1FnPHaBt4wZgWwjHxZJQcFD5zixm29B0K7fNUm7BYrF5Dn+RI+CMVVfD1xE6ikxrgHmEgRSziYMp7f+BSsFPK3vEBa8yBUCQ7FjvSNrx/h64KQpxT1Av4EXu6ncV7kxxpeGdkzgW2J51G8mwpLJ4DBNCwu7AH2FNIkWeioqm4J3s5gZhXSr0ZQlmcWXCVgsz+cFYqVPH9hKaPMvyxJWck7+mWcKVJlR2s8UBzyg3LCpC9PM2iEPBZT9KSN+WMW4d3gQlSgIG1y523q2CzhGlCH/qoF8kuwtqFfpwsVeBMcgzvl9PGLY2nG/N6s5VBstpZbqz+5prvk77Drjv15OVmwBi/U/sxMpQfIRqOx0dB7umOJN8igu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(316002)(8676002)(86362001)(66476007)(66556008)(31696002)(66946007)(2616005)(6666004)(6512007)(6506007)(36756003)(53546011)(55236004)(26005)(186003)(5660300002)(83380400001)(107886003)(921005)(6486002)(4326008)(508600001)(31686004)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdqTndtWFlyMzljRXZHQXhBTEZNaERMNnYwNi8zV1dkUVk0cWVvV2JPNUYv?=
 =?utf-8?B?M1JEQUNqOUNiQ3J4UCtrV3BUVjNoNTNDK1ZkcEtpN0M3Z05IeEpOaUN6NHUw?=
 =?utf-8?B?TWY5RzdCOVczNUxqSURwNkZpQmdoa2kya2hUSWIrSmsyODRLOEFqTFhFT3l4?=
 =?utf-8?B?cG5WTzA2Z29RK3UrV3NydE1BYmFFVmVWYXE3YUh4ZTczaVhwUm9ubzA2UUZI?=
 =?utf-8?B?RWtrV3M3SjFJaExQZWFQcjU4MUN1U1dpUkNPRmRUaitTVTJIR3puUWVMeEhF?=
 =?utf-8?B?ZFlOY2x1SkdoZzVabnlPdURtTVRWNytjSGQvMWNOMS95ZUttdTg4OU9ncUdQ?=
 =?utf-8?B?S3lwb21hUTR1WE9ZWGFzQlEyd1h4SFRONEgwMm55Ky9heUJvOWlRelNFTmJR?=
 =?utf-8?B?MXJZemhuWWhCMWsrak0yUm00Y01iaXQzMVRkSGlza0x4cEZyTHJ0M0JnbG5a?=
 =?utf-8?B?Ui8wQmNndVNIRjJSM2gvY3g4d2xnUm5wQmhmWDB4eFd2M09OamJTd011d2RF?=
 =?utf-8?B?TTA1MlJHenc3aENFZzMzRmpJdmExQnhveGpkdERaVVVrbUN3K3pNczZBSkNr?=
 =?utf-8?B?WDZraHE0SFF4eTZtK1FjM0ZIZHU5eUdkNTErNmVBZlV2Mmd5Z1ZUTmo2UERG?=
 =?utf-8?B?YWJVVCtubnExdlJLV0E1MExYbzNJSTNTYURuMExrYUk2NVdoTTVMOW9xOWRY?=
 =?utf-8?B?QURIUW1WbFRNMGpEbzFhMkpsWC8xeHB1ZVdBNlZVMk1XeFdnbkZlK2dDQmFF?=
 =?utf-8?B?bU56TFZsRXZGL0hqZklQZGh0cmpOd0xWUndhalhxV05VUVdGb0JPUDRkdWRS?=
 =?utf-8?B?d2ZLNGVvUTNTbm56SFlhbTF0Tk1adGt1UU8zOVJFRmg2Y2FuSDN3M2pEdXBE?=
 =?utf-8?B?WEZFNnBScEJaUXlSTWdwR2hKdWwvNW83TDFMWk1reUFDWk83VmpFcGJua0Iy?=
 =?utf-8?B?TTlLZzZ6Nk1DQXk2UlIzL3o5MUVrS3RzUHF1TU0rNEpCR3FNRlBxMVZNZEQv?=
 =?utf-8?B?QlB2UW9lOUE1Rk13MnhQZFpkMkNHT0ZpZVI2NGZFN0FXMmw4ZUhxUkwzKytl?=
 =?utf-8?B?UUN6aThFL3FrdnJmUHdKcXlyWGdidTFCRU1Eb3lBQTBkQzNSek94ekJGbmJ4?=
 =?utf-8?B?anU2NnJvMTJsaDZ3bnlIazlMbHlsTXkzcm9kVlUweHYxRjBTcmRwS3U3N2pq?=
 =?utf-8?B?YjFRT0VYS2tnU2ZCWHRoWVhjM1FjbUpad2hCcEhQZXNwaHliNXhYMnk5Z2dH?=
 =?utf-8?B?KzJwRTJ6dVdaSndlSS9wZitySDl5K2R0SWkvRlpwaWVVL1BuQk9HcU5aNDVz?=
 =?utf-8?B?ZjBjUC92R0hZWGUva0NTV2k3Tm9ScmJUL29pQUdZR05jL1BTdDJETjR5UFN5?=
 =?utf-8?B?QW1sYVZGZEJxQVg3blR1cWZzU2hNcFk2K3A2NVpNM2NUL2F6bURnOVBRN1F4?=
 =?utf-8?B?OWR6THYzNzV5R3FRZmJUTmpVelBTS3FFV2h3TDJ4S2pGZDgyL3NNUFdOVURa?=
 =?utf-8?B?L2Y3K3Y3Z0pSakJ0NUJjWFdoRXFQT2NnTW1sSk12WFpjcEpSelRiU3dwRmUw?=
 =?utf-8?B?L3piV1JXOEdRRnpGb1hmNDFTQzhNOE0yVURmQW5keVJtVDVwcHhKT3lXSmlz?=
 =?utf-8?B?TWVGTHVaSE85OW9kTGNmTGl1ZGpBSDFxTC9TYllxbXZKYklUZGlVNldFRjJs?=
 =?utf-8?B?dndoeUM4N2dLMVhlZFpzckYvQy9HUkNBdXc3UVhHVjdqRWtYemVFVnpLVWJF?=
 =?utf-8?B?YXcya1dHdnNZa050Sld2R1NnYzNIU20zekZJU1NUZkE1Vk5EK0pEL2o2R0RF?=
 =?utf-8?B?bGgrdkhOdTBSelEvZ3pneVR5WEticktxcERRWjRjYmY2WnB6b3pOQitaanBI?=
 =?utf-8?B?VmlMRkhzNHJqbVVTbzA0MGdPVm5yV2ZKLzRIQ2ZiZzFZU2ZTWE5Ea3p4eC9r?=
 =?utf-8?B?MjBxMTE4TU1Wa3ZONWs3bTAxeWt4d3AzcTNIS1hRbUZTeUd0a1p5REM4Nmpi?=
 =?utf-8?B?a0htN3QzVXRRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5196b13b-a450-4d55-3d96-08da08bad699
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:39:38.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xX0i+QAd4iGJffqI/jwT/67mMu50aRJJ9fbOceLVsWAhaglH/q1Pw6kdo6rBNmv8R3WYoQoIBuLKq32eIF/vTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/03/2022 13:58, Sumit Gupta wrote:
> Adding cclpex node to represent Tegra234 cpufreq.
> Tegra234 uses some of the CRAB (Control Register Access Bus)
> registers for cpu frequency requests. These registers are
> memory mapped to CCPLEX_MMCRAB_ARM region. In this node, mapping
> the range of MMCRAB registers required only for cpu frequency info.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index aaace605bdaa..610207f3f967 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -1258,6 +1258,13 @@
>   		};
>   	};
>   
> +	ccplex@e000000 {
> +		compatible = "nvidia,tegra234-ccplex-cluster";
> +		reg = <0x0 0x0e000000 0x0 0x5ffff>;
> +		nvidia,bpmp = <&bpmp>;
> +		status = "okay";
> +	};
> +
>   	sram@40000000 {
>   		compatible = "nvidia,tegra234-sysram", "mmio-sram";
>   		reg = <0x0 0x40000000 0x0 0x80000>;


We need to add this compatible string to a DT binding doc somewhere.

Cheers
Jon

-- 
nvpublic
