Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763C0561697
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiF3JjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiF3JjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:39:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F5C42EDA;
        Thu, 30 Jun 2022 02:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVwS85+A5BfIHxTo9Ue7JagNc6fq9OhK1gDTbyLUDqRw2xQvKu9WlrfrCxkmMmHkD8IBvRK33j36ecBpUT30NEwu+8k9BPL7mXIKt9jYVQZRQwj7WxRe78YZGaMLn/QH3RZnEP3wxE9wtaYFCcpwpYNhb5l+zJKISH/9BskRCciJ1X2Ncsnsfb+omqohqp1R6IwV8ogJ2ehXb3NaMuMPsN3KLJ8IPPsKZH7MsZKev7+PgkGfIDb3EZtmjkQrEYPvt6gpS0rCupz2lt1dmyAJ47lNVDEQ9Vf63AWUjfjIVBsOMkvSzU+VnMAxRwLlOv4qgTis75qCcuW6Se8FWTlGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWU+wN2Zr0hZq1frPZELNJAn/9sYE8NL/nB07HXXBx0=;
 b=H4MEpdH7srUkVJORptutFaJPUiSZEW2ug+EP/ZEWWIz1YH/wg/cl2zTMlhapHpU2UT8hZKrNKLCphf3dsKpgLDM/0CV6I/xtColxZOWBmv96+qaBYWvMKOaMEOJpCvZgUV2dL1RF+8dLG1JBIEmGpb1d2Ri+Ell/CLSnhC9+cF2+Q17JMKub0w6Sbu/b4liGNH8FSUO/bBYGRt8yeFIewCYaRAgB3I5K4A2fsoZ8TDDZHB3pvftjNYf+rTUaql26f+y7DGFMzPhRg1vMfT6MD656iC00ztDu6/wFMqWSd9MarhYaiBd/2i1939d2YRG7lSvjaNKKdqrVBzKPqI/ahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWU+wN2Zr0hZq1frPZELNJAn/9sYE8NL/nB07HXXBx0=;
 b=IDicl/iWhdvx54SpXdRml/QixNbdlb87qOAnt+CeNGvfLm5pKKAebgd1S5g+abKwOzO5n4x53eImhmUoxS3cBn+3uhRXmocQrNxFsJgp4ttxx4S1ZKUXNsNqO17JoA3uzX1xItLnYKMgkfIxDM56yd3uAXLbMsrpXNGBrHu8BKyj+1SGRqOPWDSAlolPZ+XA9n+QB6LEat4rCe2+W8PQ5wrIn82Lsqxp4/1fibmz1JUh8A6d9qCYdXdYezScmhpBK5En1cUmkzo4yY4cx4ClNcLAnWe9mc7b4SxSPgZL+5BjyC5BxGKMoKP0tlggUttvHfIN6B24nyMm9kEqcTgt0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL0PR12MB4706.namprd12.prod.outlook.com (2603:10b6:208:82::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Thu, 30 Jun 2022 09:39:05 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:39:05 +0000
Message-ID: <e2fa90b6-3a12-7d6e-26c0-65f0e1e603a3@nvidia.com>
Date:   Thu, 30 Jun 2022 10:38:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 6/6] arm64: tegra: Enable native timers on Tegra234
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        thierry.reding@gmail.com, spujar@nvidia.com,
        akhilrajeev@nvidia.com, rgumasta@nvidia.com, pshete@nvidia.com,
        vidyas@nvidia.com, mperttunen@nvidia.com, mkumard@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
 <1656527344-28861-7-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1656527344-28861-7-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0449.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96e52cbe-1218-4d67-dc11-08da5a7c5f8d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4706:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85dMHi/uYNk96GU2+Op/Z8MGRXkmk8jSSO3BJzlABGtiq9t5nim9FgkOUXDpB80FOwdS4/DbI9Z9Kxt0F7jYSPwTv0aCrDbq9jgwiGW0+OSLuuI25dTAmOROQzo7V4C/f090TD6z1ubHFbWb00J8o6OuzSYMS6GJ/uW+4eRXuOXx2IWZCIPORIsUzl3LGJzf0jD5rGW16CQXryxmdK6I4p/LMRJNGchp5soBJQ54ZnAvw8YDmAXpWm+Bd9c9xWMQI8zJZunVhxKMrrw54qDiHcbXOoGocOVpL5sb7FWlLz9pdFsi2lHU6PPh6cnnVPvm5rq+lw+vIHdPeuOF2cqttnqJmc/wk3BBkY4h5rHQyvrJrVe4/rL8xGE4nS9l07dgAmggvw4qkiox8dqE6IXNude+MAXIP/2yvHX/M38xFRqgYh5NYP7X4JijPuc2Q9+AUdDw+i2o0Ectpt32vNpQcee7Y9whEnGKJ1nuBy+86LUzFeOqCcXxyOMgKGCNQYLcXQOJCyOqxPrnh6sgazQQKaI0czrZ8tGJfEYU9DbDj5gGDt+PcxC1pV4Uwkv9q0vwuuYwTNVpj9HwVNLIKsu9AlNwRx2EFCTj/Nsa/h+yui1sE3JdkteAaM1h5E276UsdJ0HvbxbgDn5pYPYkjIdCFzbEHblOz/HgRbHBVyGNKMwoDGWV89kSv2b6h+JvxpjGWkxbUam1G/uBqJyb5ego1xr96rR5vWDf8UQymWJhtqRSFFHkT6L5pJ8i0I2/kufoDIl3ziCokDrvMN2SoRhFrUhCzbgeutmqr3WpW03AOjDsW/scVkOBsZVwLN/M6SAr7dam8+v3Cl7YXUn5AAYoGKvQR2wxmKzZ9cZze0fmFfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8676002)(921005)(316002)(36756003)(31686004)(66556008)(66476007)(83380400001)(66946007)(2906002)(31696002)(5660300002)(186003)(6666004)(41300700001)(8936002)(86362001)(38100700002)(6486002)(6512007)(26005)(2616005)(53546011)(478600001)(6506007)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkg1eTBFd3A3a0RNcXlMYmJUcWpxZkNNQTArcllFanJ3Y1pueTBzall4ZjhI?=
 =?utf-8?B?Ty9pbG9ZajhFQW1EaStGMUVlanpTdy8yK0NXUEs0amZrZUszbnIzUFRRTitn?=
 =?utf-8?B?cVRjK3V0UWs5MXc3UERMMS8wSWVQTFQxRUdHcU1rYXRCREFJbVhxYnkyczZB?=
 =?utf-8?B?bTcxNWIvQS91R1hkVEZsTE8rbHR0WDAvUzdHb0U0RDJXSDdidmdoUlFiV0dm?=
 =?utf-8?B?a2sydGgvMHE3ZlpyamoxTnBVNUx5ZytsWnljWGxtTTFnK3M3ODdTemhsMzZs?=
 =?utf-8?B?OUllcFd5S2czSWhxdEJPZDlKeElVOTQrM2RJZkdjVm9LM1h4cnNxblo4NGFo?=
 =?utf-8?B?OU95ZFdsNERjaW1rZUlVem5XSUZwb0dxYXhPUGY5K3RLcDJuT3ZvU01GRWlK?=
 =?utf-8?B?TVQ3ZXI5YUZjMXNaSUNLNjlqMlNwS1ZyK1VKbXZYQ0F2UG41QjNvd2dOKzRh?=
 =?utf-8?B?dnBGSGMrd2FqQkNXQS9zWEQ5Mm90NmNqNHVOWHB4MjdvcmVqL3FPemZMbFh3?=
 =?utf-8?B?WXdrOFQ3RDdjc3d2bmRDUjVwTDlWc1h1eVI1ZWs0VDlkTkN2K1pKd29STmVF?=
 =?utf-8?B?L2JMTE92U1hHNlV5RVd5SExZTVdCa3Vuc01XcW1yRVB4TVptZkFsQTJXMUtT?=
 =?utf-8?B?VXkwRHhmU0dEWHMxUmZZNmFTR1QxdWsvYTdQcEI3YmRuVGpsU2k1ZVQrVmRX?=
 =?utf-8?B?anlSOHBZRVd3THU0MVd5NXdCTTdDUlF1RHNZeUtXL2MyWnZ4UlVzZVRjT0hy?=
 =?utf-8?B?WUwwK1FiU3cvblppK2xHWjE4VGpnNGIxRTlnc0FLWUhJVDFvTmtmQ1grUjM5?=
 =?utf-8?B?ZzBma21RRTVORGZFS3dDUXYrYm5YTlAyZ1VETjd4akY3S1NNS0Z4Nk1KUHF5?=
 =?utf-8?B?NG1jdVBGZUduVEtySjhaZk83VmNBV0N0MlZSbmRWSC9Tc2RjTkVsZFVqNWF1?=
 =?utf-8?B?QWlCZ204MTV4elBtYmRuYTZXbGNCN1FsaHhDUUtrVTdFVk53Y2xrNVdEc1pU?=
 =?utf-8?B?dHF1RWtSUkpDeG9odVZmcU1XRTAzTTNFN0Z6OXMyNWVuR01aYUZma3ROVFY1?=
 =?utf-8?B?YllmYUo3TWtLK3FaQ3BNbUVYU0l1S0c0RGZhVG95UmQyZTgrSjVaZTlPTS93?=
 =?utf-8?B?OS9YcUh5ZHZlTk9vTmpBcFhwcFhKVTVCK3pmdFcvRjQzS25uZFkza0JFUjBi?=
 =?utf-8?B?aEhHK053eVpRVXBtbzZ1ajBzMUQrUkRmVmV1QnVuNXpYT1MwL3Z2S2Zzd0xw?=
 =?utf-8?B?czBlZVJtVFRCTnpHaEFHc3ZtMGhYQlpiaVRteWwyZjZVQTBQZ2hCQUhpTDdU?=
 =?utf-8?B?SWxHUXZGUmgxR0V3R0tLdEozZDVTT3pMYms4bmhkbnZHUXJ0RjZVTERnNEQv?=
 =?utf-8?B?N0NndWhVYXA3a09mQVhITjdiUHpzbDlsVmJrYk1zNHdFS3FuSjJTVTh4Vk9G?=
 =?utf-8?B?ZHBndHlQR1V5M3ZTendoeEJWWjVJcEtpaFFrSnhialBjZkxEVEJ5ajFsOHpm?=
 =?utf-8?B?dGhEblYxR1lTUHhlbjhNLzFLVnhNdVRMZmVodE5ieTRjaXB1N0Z1TUlSOG9m?=
 =?utf-8?B?b20xNWs4VFFGSjBzZmdSTk1vWjVoUEJabnlTUXhza0xPWWZVbGNjOFYyaDVp?=
 =?utf-8?B?VDFvMldMdHlRMTRsSTNEenVwaWZURm9KSWNPN1VQZ0k5TSs1Wm9BQzhLK0Vz?=
 =?utf-8?B?VTVRTVBlMW05RGhTS2F6UytHemxndGh6dWoxdC9IbXVhT1pyY29Ub21RdGFZ?=
 =?utf-8?B?cE9ZNVI3U2grS3piQmYrb2tKR0NmT0szYWNGRHAxTUxrVllPTWlDZFhpazMw?=
 =?utf-8?B?TzUyL0VqVTFqa0tTS1Q3QTE0dlZ0MU9kSnIyK3dWamNlN1k2RW5ueFlJMFN4?=
 =?utf-8?B?cWdjTXpVc0xDTmlsQ1pNMHdHWlgreXNKbEJ6bTFQdjhJSFhCK1dsTHBTR3Z0?=
 =?utf-8?B?ZGlmT0ZFZG4xMGF3ZmM2TmszNUgranZhNU0vU1NQVlRIR2RrKzZHSlRqRG1F?=
 =?utf-8?B?eDFZUUpnSVZoNk5UQXBiL1QxcnEzZVlrdTRTeE9QSmp6aGFQbkt1UVdrbjg2?=
 =?utf-8?B?OVVGK0paMG5tcWVRZFJqRDQ2dGZoOFE1ZWxvd0JWTjUzRExUanU1ZkJiTmdW?=
 =?utf-8?B?d1hMYk9iZnhWL3lWWjRWM0IxTTFDSDdDN2lCVDBHbjNMdjhMRXZUK1o2STVz?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e52cbe-1218-4d67-dc11-08da5a7c5f8d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:39:05.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46jXuW3mb8m79Txu5+/wYTCD4pF3EDGJDs0pehsADuPgoEIpc5/69VuhuKRdd3wS8PUSyUFn8YsOMMw7WX3CkA==
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
> The native timers IP block found on NVIDIA Tegra SoCs implements a
> watchdog timer that can be used to recover from system hangs. Add and
> enable the device tree node on Tegra234.
> 
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index cf611eff7f6b..aa8ceb3c329b 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -519,6 +519,28 @@
>   			status = "okay";
>   		};
>   
> +		timer@2080000 {
> +			compatible = "nvidia,tegra234-timer";
> +			reg = <0x02080000 0x00121000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "okay";
> +		};
> +
>   		gpio: gpio@2200000 {
>   			compatible = "nvidia,tegra234-gpio";
>   			reg-names = "security", "gpio";


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
