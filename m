Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73CC477D87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhLPU0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:26:17 -0500
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:58604
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235744AbhLPU0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:26:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1O0iZEPOTczHYgRiBqYLs0EXygMUE5EOMFXPcdY8NM51gNKPNvrCvlGojmNVX+nkISGdkNzPnz0DXF74MtJBPNrC7tUsASU9uwHJnmekJnLFiVt6h3eYMc7D2vm5FjCjJUSD3f7UEvfXQtt+sC3MbX3PY/TYFTi4CKug10DbU9slioiDQ+R0UvPz/W7QNTacJaMa10er9iTrdK6g0x0+QhhGJ/WoOtyG3yH6tz48bAUDjyBMzE3oNROIuUioQt8qmhIFFmTNMTLwUCR5JVNJNi0mjKx7LZMXP48Mphd/aGhWjQPuw24KT9g6oF+esL92AQthqhH1EC92YKPpSWkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxxk8GjLnUGYyzq1YmKe+qRAYMVHb6crk3onWScw4as=;
 b=XEuMhZmjG7w7mmlYS6Uj4dubgKPIsUv+76nBvvPncsBBx++3f5XSZ6Qi930saHZilEZanafijNLoc7zD2tHI28f3S0JHlVS19aXpsV6/Pf6TBoMo0XFi0PjIaxpBhp/45IxkrQLcDGGVpqMsVX+7X+JchPlTpOBLhuz3svE1INb1zWH5bNIfEuCCpW+cYj2AlbZuuCxuyoG9MGbsZTEgznfu4N6V8DFXIppoDGG60h5rkwqSaQmbjzFa55dp3kxiwa6/Cp0SMG5wOQF6I6xML9b7RPllrT0rbrQqHKMyrMLaVbEfG5PdRhx9J3Yu3LJ4Fjlctggzse4TvVYoWo7wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxxk8GjLnUGYyzq1YmKe+qRAYMVHb6crk3onWScw4as=;
 b=D38AoxmOxfXBro3VXfVot7N788x63sJIjkw5Dq55a+D0vbmOFr3jYGetBp1RMDFDAuoeq3wZW7DsVfYj/8/PgEUAqgGqTSFtAQ93ZC0o4nJsqMnDgoSCS5kSZSSsJSp7PCxUfbThVIBkyAOvMI08I2tiBqNuIez3YHIANkm84wA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 20:26:11 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 20:26:11 +0000
Date:   Thu, 16 Dec 2021 22:26:09 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/7] arm64: defconfig: enable drivers for TQ
 TQMa8MxML-MBa8Mx
Message-ID: <Ybug4acjSvCG+XxA@ryzen>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
 <20211201072949.53947-4-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201072949.53947-4-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: VI1PR06CA0120.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::49) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b1f340-4936-4598-9c46-08d9c0d24cd2
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB53449E3C7205E444D5091B50F6779@VI1PR04MB5344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsW1PFCYnOp24SyinKXmbIB1AvTmg98cRC4MpXpJt87lqccFvBlHthd791fP+b3yDhc5j6M1sO4hsxuSrbTPrO/S2xtrbEj0YF1YYqn2gcFY4uRfJzjPsPJciwjjkgu8Gc12xLgGWM3ftG25lizBQdWFqOV+WK2Q3xDvsX7Wy03U2/56hDQmQqcSh5EhOYlBVLrLOx0PmYHQQMAucZ63Y5uZBupn/j/tGeKmtoVEAVSWqg47BS5qH+FiiEJJyDkj1DwEVcXD+7CRIxoNeANdDIPjmgba8TzBa4jBCnFOBMVkdIMVg94fyr/fSWmwMNhgXdQE/OoTaQfG66peBS4SWiZZ3n3triv8cnzDcv9yaTXsK2y/P+QtFS/KHSGJ4PdkLhyYyUE94nANlAM3NHfpIJUGfN0CNvxHmfIAkoQfmzQwAyMhijSjiXCZs8sQSTLQlv8hrhUzofScdxIg8KGZsa3RL6AU5vZaVyuW2lc7aRK4oRbsS4rxcbqLrBwKJIE+2T834zsrFqXJ7/1LaEZ0TPFZJk8G0WK56Bb8SHKaQSC255eRLLmp0e7DirKkGR/NC6v1zInh8yn7lpEk4KK8+UtPC71EDehFM97Om+886kC3fEPHPPx3ehjKysoYeI18SnHyn2k0Vm6Mn0mxNM4dLElhA+0Yz7vgg3ED2LN9O/oj8FNCm3vV3A8/v+qT0aLCbpcjs0DJFILWxyRTQLioMrJHdbq9TJ0crVzNo9i3cbzgX0gFtcanq/0Q2IdRA/ggJN7FIrGBctpKcRAidMQbuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(66946007)(44832011)(6916009)(53546011)(6506007)(38100700002)(186003)(508600001)(2906002)(38350700002)(54906003)(33716001)(26005)(66476007)(66556008)(8936002)(86362001)(7416002)(6512007)(9686003)(5660300002)(52116002)(316002)(6486002)(4326008)(8676002)(95444003)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8ur6TalOEe/eO94nX+kT1yLdb2FxRffyjeDUhJeD9GG4031Ob3D2+39bd+W?=
 =?us-ascii?Q?AeiRlfW20zXbUNxYQM76CGU8SOgetUnXWuzTV02kGRvvqvs+U6eqxxsPDqPH?=
 =?us-ascii?Q?kenvzeoL7ahreq0uvhRgHNm6EaOAaXSFBFY3cQ/0OSDyMq60T3sO6FshTX/x?=
 =?us-ascii?Q?2UVZDP8hC1gjAMg7dt6dQs57eAPUKH8bYpkclaQx1uPaZiTBWLOCnhE0GVEr?=
 =?us-ascii?Q?wkFlMtBeao5Jft0WM2rpAUz6tLJrPJ7k5DLRCnONlZiVZJgBnE8KgADUf2LN?=
 =?us-ascii?Q?z4BLxnvkR4rH3hUv7wiunAQqppqFRQnd7gN05lR1ChaY2QOCOQFXKaZTOcds?=
 =?us-ascii?Q?IMbYP+QSW3fVCQk3t24TG7PAPli7PJ9mTMEqeEwI5W08LB3YdhP6JiixxuWP?=
 =?us-ascii?Q?DdReZXLRLecTlxe+H13o+IucH0Gb9bTTZBifMJJMKAMg8BcJ78rrFw2CHWpU?=
 =?us-ascii?Q?DJAC/Dh2b7JcdP6oPEYhPB7yXnFe/tWVDifkyMNKDRkPlKPYOxjpDTczI0/V?=
 =?us-ascii?Q?RhgNe0dCEoJvcp+PCZ6hmGg6qNmhvwg0WyP7I5Rf8rdDfTC6oio/Tql7Vv8E?=
 =?us-ascii?Q?9emfUAw4E/BBK/acN0sKcwITzN1ipH51XhamWEA3hpN0N3PwPbMGe2VO0KWK?=
 =?us-ascii?Q?jT9+l+01DfilTKpREsMIX6fGEWUphJ5J7i7hU8wlacmVYICmqYeRz3+I2Unj?=
 =?us-ascii?Q?LI3HbhMPTKVVgNderlyli3HN4o2NL5Rvg6KhWNce3obgQVqRhFveEh/TquEe?=
 =?us-ascii?Q?Wc9mAQXz+/uGG70DiEcT0KCqMvgIWo7v7kgmdM9gnxbnpTK6ngzIz2b9CSli?=
 =?us-ascii?Q?/g1dC0YG3ZmqoABijAguPeBkMFE48nF9/7v/GcWtiRYwwBIocZpM180wdkvb?=
 =?us-ascii?Q?TdzH7Vg1sLkHL9+YWTyGHDceWsd2JC1EsU4J9GmDv3iGqIh0HU7mXB9v8X0z?=
 =?us-ascii?Q?h3aG8IkxcOzRDzsp61O4tRfQIH6lQK5XIGwoV2huqms3iKkHG2NkHg2LDykT?=
 =?us-ascii?Q?7vTyvr1EIsFAsTk9WnAwXu5EgFDKp2ynlc/OtJr9GWJoXs8rJboJNgI07v9z?=
 =?us-ascii?Q?Ery4s6R8juqniq8RPzL5mrMyssebovHkS3sKV0k5tBHKHq8guqcOXFkkDZZW?=
 =?us-ascii?Q?Xro4h8AoE0q4QM8Iks3IdNeXz8xcVKHQcuxJN9y059hylrIMoT7zcHCIdbTN?=
 =?us-ascii?Q?ZJHqrQYy7nLAqGje3VxtWgCbfdzqCYX7G8qHl1faPdCKSUFiD7URmnNy/9la?=
 =?us-ascii?Q?xHDXKuC2pfdLSpm8Zz23gfiHH5+ByQ4rlHUHGu3qMJ7DrGhWiVsJQ1icB6D3?=
 =?us-ascii?Q?FzhRvmW0qhZQtBlX71YiJLPmoqvajK5hAcfB9uqed3UxwLxFDbrbWYHZZjgP?=
 =?us-ascii?Q?mijUYIP7j/eEUKZODG1R7mYdsv2H8jSvzzLJQMry6KSmRqR7OH7HCvLkNZ7a?=
 =?us-ascii?Q?hnIq55qvUkENQq38NJsYKg5p8PwDhfWP4i8H1jtFiSRuBsSd+hq/LPgWhiGz?=
 =?us-ascii?Q?gDYjR1kDB0x+gJwzs/TfPWn4MwSqTlDsyj1Y4HvxI8RppN8Au4fP3vzFDz4w?=
 =?us-ascii?Q?eKsBfnkaLQSNc4jdCLZ66we75CkQ/7ydP37+MsiLOYZhWWQ5iKGJPvRFeVZm?=
 =?us-ascii?Q?DfNMpBONRIdCJU1NSAIXdKc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b1f340-4936-4598-9c46-08d9c0d24cd2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:26:11.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hY2aatR3dgAHfYamMN6AiH4wNglRMCLKU2Wd1pVi6aTpag7ZT5IhsI1rajDYwFxbGmPm3pfyt8vLWxrg18sjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-12-01 08:29:44, Alexander Stein wrote:
> With the device tree in place, enable missing drivers as modules, if
> possible. PHY driver needs built-in for interrupt support.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v3:
> * None
> 
> Changes in v2:
> * Add interconnect driver for imx8mm and imx8mn
> 
>  arch/arm64/configs/defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0da6a944d5cd..44ce56dd2638 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -363,6 +363,7 @@ CONFIG_MICROSEMI_PHY=y
>  CONFIG_AT803X_PHY=y
>  CONFIG_REALTEK_PHY=y
>  CONFIG_ROCKCHIP_PHY=y
> +CONFIG_DP83867_PHY=y
>  CONFIG_VITESSE_PHY=y
>  CONFIG_USB_PEGASUS=m
>  CONFIG_USB_RTL8150=m
> @@ -397,6 +398,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
>  CONFIG_INPUT_MISC=y
>  CONFIG_INPUT_PM8941_PWRKEY=y
>  CONFIG_INPUT_PM8XXX_VIBRATOR=m
> +CONFIG_INPUT_PWM_BEEPER=m
>  CONFIG_INPUT_PWM_VIBRA=m
>  CONFIG_INPUT_HISI_POWERKEY=y
>  # CONFIG_SERIO_SERPORT is not set
> @@ -556,6 +558,7 @@ CONFIG_BATTERY_MAX17042=m
>  CONFIG_CHARGER_BQ25890=m
>  CONFIG_CHARGER_BQ25980=m
>  CONFIG_SENSORS_ARM_SCPI=y
> +CONFIG_SENSORS_JC42=m
>  CONFIG_SENSORS_LM90=m
>  CONFIG_SENSORS_PWM_FAN=m
>  CONFIG_SENSORS_RASPBERRYPI_HWMON=m
> @@ -793,6 +796,7 @@ CONFIG_SND_SOC_RT5659=m
>  CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
>  CONFIG_SND_SOC_SIMPLE_MUX=m
>  CONFIG_SND_SOC_TAS571X=m
> +CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
>  CONFIG_SND_SOC_WCD934X=m
>  CONFIG_SND_SOC_WM8904=m
>  CONFIG_SND_SOC_WM8960=m
> @@ -908,6 +912,7 @@ CONFIG_RTC_DRV_DS1307=m
>  CONFIG_RTC_DRV_HYM8563=m
>  CONFIG_RTC_DRV_MAX77686=y
>  CONFIG_RTC_DRV_RK808=m
> +CONFIG_RTC_DRV_PCF85063=m
>  CONFIG_RTC_DRV_PCF85363=m
>  CONFIG_RTC_DRV_M41T80=m
>  CONFIG_RTC_DRV_RX8581=m
> @@ -1175,6 +1180,8 @@ CONFIG_SLIM_QCOM_NGD_CTRL=m
>  CONFIG_MUX_MMIO=y
>  CONFIG_INTERCONNECT=y
>  CONFIG_INTERCONNECT_IMX=m
> +CONFIG_INTERCONNECT_IMX8MM=m
> +CONFIG_INTERCONNECT_IMX8MN=m

Nope. The interconnect doesn't work without imx8m-ddrc
and imx-bus devfreq drivers. Those drivers do not work
yet. 

So please drop the interconnect configs for now.


>  CONFIG_INTERCONNECT_IMX8MQ=m
>  CONFIG_INTERCONNECT_QCOM=y
>  CONFIG_INTERCONNECT_QCOM_MSM8916=m
> -- 
> 2.25.1
>
