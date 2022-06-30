Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BF556168B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiF3JjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiF3Ji6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:38:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA32140E4;
        Thu, 30 Jun 2022 02:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcmdgqWi00315788LMPJNC9BLnO+2UBT9YyaqwQKp1Q8RE3AiYTZst/pCdbj1gJx9DX6xR+QqaJ62hwVxeaF8o61e/jUluiLzfJlyJ4BZ3ZLDt2MBBF5Hlmw157FZOBUF0uP5DGHwqF9Od/vT5TmuBDvTCQc7FTt8T3S/SZoOyOEo2NxZ40eB99GFCgGDNwiRGrVaiW0ixB1KyvM1BLYVBlN2qJ/0bPENbTuxJodzEPb8OeaFtvJ33TdGBWQnhbB/rMr3SXRPJHkqPB10/PiXE9o82rN9esu778H3+Add+eOTMIMkmGhNFmLamVr+GSbTSkyD4eOhzPbgM+hdmkuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfbC6xFGvF/AtlmpthFOYs5lYHWOln5GUEDzapotuXw=;
 b=BYcO4EAJ0ira2WRwuNLkey7K/u5npt29IrCOyhulV1DoUIrFK1D/6NQDW23eC9BN+aTWQoaikQprXCiUidyvy2iM1HXh8DrvCSMhUGJGNqKaqdmw+RQW2UOdzwod56gjUOjyfY765I/kGQ6kP7hR++X4yLLgSs+6DtDvuGCBclNEz3UoOpiqZSjaD/FWMOpCs0hTe1ij8ixVOSUPOU6VmbKPy125oZVry89t/oj/Ear3a4pEnh5FEkftndZKDbpuiEUYnlBThRnF3zO367x4FI71jkFjptwT4aNYY5zmyNGl3z7TFqMuTgsvRs0jq4qF1apLiDdenksgUlZNBNXIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfbC6xFGvF/AtlmpthFOYs5lYHWOln5GUEDzapotuXw=;
 b=LHgKN3NWCpEPI5CXY6MvIVsUxAgUdoVjAWfmIE248PR4E9u60/uwEjG8IVSez4PnV5vyRg5sN6GhSaP7N9+m8RPLR6HIoWJx6wId6nRp99jR01GCw1Qe2emcBS6p7YAe/ZQtrX5ChVncgjCI0QpbxY9danugKlNtx3ThWE1x98dvUbaZiWTNL/GGdoPRWKTFFcJZyMLB/lfobjKNlx1UqdJOVtW13XTTxUcAwlLg0nJOUi4WTmE3qKyjMV0qvCuxqLEcKJqjNFSo8TjiZahVSZvs972OWGbcisrhjyVTLtuB/45bF3S7UAgiRLhVx+XaqPTHOHxxjHmg1Jg+RP2qZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Thu, 30 Jun 2022 09:38:54 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:38:54 +0000
Message-ID: <d0b68f0f-935e-3248-c60d-929705e4bc23@nvidia.com>
Date:   Thu, 30 Jun 2022 10:38:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/6] arm64: tegra: Enable native timers on Tegra194
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        thierry.reding@gmail.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-6-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1656527344-28861-6-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0444.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39668a20-150d-47b7-57de-08da5a7c58dd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmcwK1R+PGWoO+50sg8C9w5zOuyaxTe2khYHxGhs+i9nc3KFIN7gcTvHQ05O6sdXU+VujFS0SjA4sS6dYaPrk8yollufstNpDwpuMG9UsPWGsh9EP88L7s+/o+9bdUR6yDI/k/Gjah+R5LWchPmxuSvWsyoOEIQtNtje2MHW0n+f8t2x+Ygo1TiQi/g4+FriI8PL2/o3Tc5oOGhzAd4ZwO0XRWFGwNvUNaf8x76t5KpZsZqiw6ckz9B9G+wZMhK3CLNZOOAyQkvVINSPt1m+uFdOWkGlGBPZ6QxrHIp254wBv/cC10jRedQ8NEJM6c506E1C1DFXcj+KL2jHzpsTcccAQNHf5X/xATogdP0OfVtM+gjGu8h6FnNLNmdGKGZHtbN8vdUHuitER1QUpBu3TAyhf/ROE37suM4ffnI7G8DzAURF8cWO41wtKnDmsrHyRsafywHQpfli2n359bAmSz/HT01d/FIOc6CF030yVT/uFJbjLZkzeYiknKkVTnKevVYnh8dc5J3PY1VdVRDPY7dFIMnQpLfc0FpfBS335bS0oVXLcN/LbeNKOywrkgpkr+4jJdvPssR5Iy2JRJ61VO35Yk4CaIyGDi+6VhiO49i2phXilCP7j0P2HNe9HGgELKIjEtFux0CPpJM1Db3CkjJ76bqXP0OhHQQtEQfQ4zhJQbOj37VBEKMfajKf9bJhaVBgNUEXCpIs0DxKKJmkUHvgicNKRjpwht4WZtVTOmeefI0gr4Pm0z114ZKvV8s019jC+3cKKIPfnm77AoDxhA1/bLgekSn46Q3v1lKt+OCfeQO8B9snvU9CAw1vQ6UzzJUCIzIS4fgFOP8wB5T7w+KHDm/SiAEThNiYwN+ljrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8676002)(921005)(316002)(36756003)(31686004)(66556008)(66476007)(83380400001)(66946007)(2906002)(31696002)(5660300002)(186003)(6666004)(41300700001)(8936002)(86362001)(38100700002)(6486002)(6512007)(26005)(2616005)(53546011)(478600001)(6506007)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpKL2N0cFJhYnpycUU5OHVCOTlkTVZQOFNlckJzT2d0MjhmcmtHcytxcWQ2?=
 =?utf-8?B?eGwzTGt3R0RyS3ZDUjJJOHF2Nloyd0poczJDT2pvVjJqYmVrMU15WmpHZDRC?=
 =?utf-8?B?cTlpeDh5dmFLVUlCa25KUy9Ia215dTd4U3hUWktvODhCMnM0eVFOaXBDTlh1?=
 =?utf-8?B?TXptK1ZRU3dmc3IrQzRzQzE0Z2tXV1BrVXB6UjBxUUx3bkZJUnNKTVlxT0dC?=
 =?utf-8?B?ZWxtMTFPZFhNb3U2eGV4N3RmWXdFVVE4MWVxYXdIQVYwREdSUEFjVWNJL1Iy?=
 =?utf-8?B?Uk5mU2Vaa1FVQmxxRjNtT0JEdnlicUhwUExCdXpqams4ck5CU29NK25sdFJH?=
 =?utf-8?B?UUtETTBDNjVnc1BGb04zc25qSHgxRG9sMk8vOFltbUYwVjNYNkd4WUJ4Vkdk?=
 =?utf-8?B?eVBaREtHWDlRRjN6U1VUM2lKejNqWHJBelpEcFBoSVJHKzlqMzY1dllZSXdn?=
 =?utf-8?B?cXBOODdXeis4VzRrd1A3Ymd2NHhUbjNSZUZqTHBzTUlFaVg0WDJrenpRMmFE?=
 =?utf-8?B?NjdjVVJveWlEOXFLbC9aUDJTcE5aWlRhYURCa0szcnl6QUEyTDdrT3NtaVoz?=
 =?utf-8?B?dmMvcWs1ZFNmQW5penh2T21iNitNTElZV0tqZ1VGTUxDdDg5QzRvZ3dCNHVI?=
 =?utf-8?B?OTRMT3VINytkK0lPSXN4QnVRUGJxcmV5U28ydTBqMGJHSUpnTG5uUWFIMmYw?=
 =?utf-8?B?Tm1FUnVhVlZJejFZcFc0Nk5QcUtYMnlnQklIUmI5QjJSTG9WMGdnSzZRVVph?=
 =?utf-8?B?Z0NzMFo5dnk3eTVIemFkMkk1dkErbm9EbktBMHhNWVBFT2dITE5wZkUyamh6?=
 =?utf-8?B?Si9jc052anBBYjJiZk5wanZuV05PZWdGV3JQOGdwUWFTZHhVNnNBcURUTHQz?=
 =?utf-8?B?dkNFUmZMZU9TSzFWckVuN3kyNlNBdVhLdTY5TEV5dlFEazlRN0ZLYVVCbG90?=
 =?utf-8?B?ckF0MFIyRWJQd3lqV1FTUUZtWDBFb0xXU3R2a3hicHdxb2owL3ZUazZUbjZH?=
 =?utf-8?B?Nk1mbzR6dVA0b2paTXNYdmJVVnRVaDVqdDNDWEpoMTA3anNiTDNnRnlxRnQy?=
 =?utf-8?B?Vmpub3ZZaHlWWGR6V2x6TzhBT2hWWTdpZFpnZ3Vkb1hBa1BvOUQxYkxMMDI2?=
 =?utf-8?B?bk9mNytQWjJFRlJQdDB3QzdMYjMxQXlaNmtpYm9RWkVmNGxhOTZlZVJtMWZU?=
 =?utf-8?B?QUJTemRJL3dheE4vTU5GVkl3ZDRCNklrWWhZTzhMdlZNa24xZUYvcXhUTENK?=
 =?utf-8?B?ZHpjc0p1Tld6M2ppeCtXWGVOVEcweWxOb29MUlhnMjJYSENKNWF5d1FyVGQ2?=
 =?utf-8?B?aUpzSnU0cEYrZ1NUdEtmdHJMZzY1NzVjanprOEZjZDg0TEFEOTRNMWIrV0tU?=
 =?utf-8?B?VlNuMHZHVmVINzFENzc5SXpqRGE0YXhvNmVOSXBHUG90bElYS0xrT2k2UWU3?=
 =?utf-8?B?clZLWThMY2RZSlhNdDhtRVVad0VPNzV0SFI5eVJETTQ3K3Z4QVhUbnRtMWZW?=
 =?utf-8?B?UlAyOW9nVHJBOUx4eDhtd1hMQmhXRHVEVk9zVkdvWFJpSTgvWHRieExzdTYw?=
 =?utf-8?B?SE9PMFhCLzZrZHV0eCtaRTlCM2JJbGFiOU9vY1hieGVrL0hWemcrQ01Mdjdx?=
 =?utf-8?B?encyRmNkUmo2alFpT24xRmM4aTRnNkhMOVEyV3FVdDJsaFNvaWtXN0tMdXoz?=
 =?utf-8?B?S2tLdFFyeGxVS3VvMS8wcktwZTdxZ2RzWWJvUndtaEU3NHBncU90UVdCT0pp?=
 =?utf-8?B?TDBCeXpidk9VRXRPdUZLVkdyekdqRGI2NEh0VVNoN2xRM0VJcVlFTklHTk5v?=
 =?utf-8?B?QXNCajl3d1o5Z2xVMnBMYU40TVJtY0U2bHhObGo1SzRPajVVTDdLWUhVeGFn?=
 =?utf-8?B?RWN0M1NHUjRjclRMYXFHWFlZVXVDa0xjZ2MzK2psdzEzYUN0aUJnSE9iZlh5?=
 =?utf-8?B?WjhySEQ5bUNrUnJyVTJCQ1p4bmVlY0lDS2pGYlNzZFlFdzlhbnNJYTcrTUdw?=
 =?utf-8?B?OUdLMkd2enVNNnMxYXVGQ2tGT2xxSHo4bkN0Z0h6ZDVrSTNOVUx3bytLSFBv?=
 =?utf-8?B?cTMwV2lET2Z6ZFdqMDQ5eXQxYWh3RHRLQmRpME9XZmZBOEVaajRROEo2cVh4?=
 =?utf-8?B?Y24rcElYM0piSFZWNkhBclA5RksyUnVhdDFmbFl4c0M4SXZTREgzQzdHdnZS?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39668a20-150d-47b7-57de-08da5a7c58dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:38:54.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F46LKG7IEaYpPFSPJWVldmjuHz909FCez47ojR3Cj5jMu1CkRj36pz2kbc5nB9+9Ap/pJ2LihPu9XdV9f35RMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4706
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


On 29/06/2022 19:29, Kartik wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The native timers IP block found on NVIDIA Tegra SoCs implements a
> watchdog timer that can be used to recover from system hangs. Add and
> enable the device tree node on Tegra194.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 9566c6388ed9..4b37aec69448 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -698,6 +698,22 @@
>   			};
>   		};
>   
> +		timer@3010000 {
> +			compatible = "nvidia,tegra186-timer";
> +			reg = <0x03010000 0x000e0000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "okay";
> +		};
> +
>   		uarta: serial@3100000 {
>   			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
>   			reg = <0x03100000 0x40>;


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
