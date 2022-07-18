Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11327578641
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiGRP0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiGRP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:26:13 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10054.outbound.protection.outlook.com [40.107.1.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B309286FF;
        Mon, 18 Jul 2022 08:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjbEAXPsqQjct6oxrMCTE7fBCwVok8Ez2IQ819cYeVR+yg6fJR6sc1tfsnSG1AXSWffvRvWxXRgmyM5hX1+qN3iH9oCpS2ZUA+DcQ5PYjuCB5u7kWBs9y+ceIC+dfONKqcN0YrRxmzubtOTp2/jwUgna/+ju+oOCuCQK4Gb5d+DJFhoboMNwcp7P2fcDCmHN8q39uvww4poqVt9efBv+hqIw6ygsqufMYlwBcgf2oy+/sToUDGiPglUb9VS/wNFtyn9hhSqbv7/c7r4IcGoTTHtc/bkZObgoVHwnNT7x6j7Bt8dGpVrifHptFAGRCqU7hXZ5aD+Osg+m3FedEj2g2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQKomleZUBT+9E4S+SkXPM0sogqVqudfKLWX665OiF8=;
 b=LV7tGvXealuct9nt6VoJ8SrhDSnVuPkDdCiy16oiDkD6S9Jn58F+bcTkeA7G4mA8la9NaKTueEkwo5ECIYAJOfYFZRX6aUuC7cl3Gp1ImGn4uGmOuKuU1Y1rdh7QEK0Ak/OzFfW12pThuzzuTU/CTtYixXFXyl3broXRU4D4FdmpuKypD9Sm+fAQR3MS259UNxV3vSj2YG82vYUmX3xs/j7QPMgRwMW2K1PE9MYUUUh6c3NfgeP/AxI15wUY9YCMn1O70oyuXIg7cGRM6SJ0OEryJU2vR83jT1SzdYwvenyXeVa+ukRBGrkohp4mZ5iX2lZ93OprA/qHySNyoR0Ssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQKomleZUBT+9E4S+SkXPM0sogqVqudfKLWX665OiF8=;
 b=QxxJ8U0Dg6GlgRIbzzegtN9TmPZp/0kaXGxvelGoGqB1IqTPs0WeiJx8VqV4Al13ZrRFH6/5xybwFjA24BLr/wNeU2JMB9uwKnrjy1y8qqVXUGn1ux3Ggrm+f2CTUNBUdq201Kitw5Li5PDO/sKA/5oAdGMrdzCN8MpmeCluZKrJT/EpGgs5Ln1D0RfNW00/OGFAVzn1KMucSPFocTR191PW9NJBBUOypX2USms5yxePLhmRnew2FX5xeMVgbYVS40sQ/enQXyljl1kNOT7WP4jSUgaPVn4lHb8vBefzPnQj6aev9I7BqZjwEgYRFfs1zuYE5H0K0mcE+iOEDtJYhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM6PR03MB4406.eurprd03.prod.outlook.com (2603:10a6:20b:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 15:26:07 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 15:26:07 +0000
Subject: Re: [PATCH] arm64: dts: zynqmp: update clock property to xilinx and
 dwc3 cores
To:     Piyush Mehta <piyush.mehta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        michal.simek@amd.com, robert.hancock@calian.com,
        gregkh@linuxfoundation.org, david@ixit.cz
Cc:     m.tretter@pengutronix.de, davem@davemloft.net,
        srinivas.neeli@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, git@amd.com, Piyush Mehta <piyush.mehta@xilinx.com>
References: <20220718143439.25425-1-piyush.mehta@amd.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <62aa7190-2512-5a71-c6b0-6b869bfed2a8@seco.com>
Date:   Mon, 18 Jul 2022 11:26:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220718143439.25425-1-piyush.mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:610:33::23) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 360c2d43-a514-466d-da2c-08da68d1d5ab
X-MS-TrafficTypeDiagnostic: AM6PR03MB4406:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQziaSnAJimwEudXreJhNZndmb+pPM1HoUW40iSUOkSV81+y21p5sxqZz3BqN+ejcef2E50e675v1jxGH5qigJIR8VdxD6s63ZGeeMuKpUR1Cx8cC4oHkQDNAjWeB4S8xlPqLi3vnAhu65yxv14hLYu+zENgIYQmcBVUrBu8+JI6oC39P14ASyxmYtwLSmfzRvI9HYoq6TdHXdP6BlDIhon5kb9l56YjoQljxTLb4RHGNzA+6LQfAybMLNk5UCJSjI9y5DwC5Zn2BoZZOOW28QUAnxmdUYx6MUyuP9ovrAaD1JHnoRzqc52onaYRMhYHQ+ZNmq/sJXoKPA0Z+33DgvDCp0Vy4SH3PXJqk5EvAqG+Sil9Pfh32Q8hL5fG3PqIPeGnnPz913jh76Vul1kytCPaRF11GdnASLEAnyIKcWJHPt2Ogz+96rrVTPOthLgEmzu8inDCHMqM/m5RH2R4JHYcM89i7ZDPMZa/V4Mb9hOiE0lQA/AeMxY/8DR6WrmOgG7AyKeYyFFrHF4XMNgEh9mY2cJixpbcuX/L66zWRv3k5TDzG9694jPuDSBx8c/VPYc+zefNnCIJxzyOdWv/Lk8xwZersd4GoRhgjZjYJiVUD99SO4aZS0AVP++g+Z30T27ww8Gu1Y0reJL/ugq7wU/IUN73wRG1UC5KGbjgmL1prF0w8d/LH9Yzfkneg3pvu83Fi4e7KY1Ft86c4HJD/ep4zpNG+xADz4gby07Tjj+YlhjoHbpgOEeEQlU4ERtb3Kp4ohEk2cYQdyybq8iQtXiqb3oNgksM2CDqx7kB9dVh5Iss+LCKeKkF+Sb9EdPXu6RMPYZP4W7qqKv/nkavNydvZg/i+j7aMRbMvG2SPKuYBvASKQkubW728yyDvgk0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(346002)(396003)(366004)(376002)(136003)(8936002)(5660300002)(31686004)(44832011)(8676002)(2906002)(7416002)(15650500001)(86362001)(31696002)(4326008)(316002)(36756003)(66556008)(6512007)(52116002)(38100700002)(53546011)(26005)(6506007)(41300700001)(6486002)(6666004)(2616005)(186003)(478600001)(83380400001)(66476007)(66946007)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVPV1hycTlKUXh2ZDVhcEZCRTBjbHZMN0ZYV0dqUkM2UEFsYkJxTnlUaEY3?=
 =?utf-8?B?SWRCTlFJQ2FUa0h4bWFnR3Noazdqd2JKcG9sN0oydEo5YnQ0ZjMrdS9GWE5V?=
 =?utf-8?B?SWkxVmhQTHFYK3JSb1lmbVJEQy9mbStYRjJuSXZrbU1HRHN3RjBsV09ickYr?=
 =?utf-8?B?ZHhFeDFDUk5sQkY2WTFDRERnbVppQzkvTzZBVGxZUUtKcHdSUFJJK0IxMmNT?=
 =?utf-8?B?NlBNMHpLVWp1NXFnM2VwVzBrZmpUR2JkL0orbEhIRy96UVF1b3MzZ3dCaGt3?=
 =?utf-8?B?ZWFVMmVuR3ptQWZoU0NkVzNsbTJYU1lqbjlHc25lVE5vNnlxcW5pc1N1WXcr?=
 =?utf-8?B?MWhHK05VY2F0ZndQZnJLVE9WNVByNjlFYVJZa25YNm5HZWdnTk4rWGh0K091?=
 =?utf-8?B?VENKYTdhcldDSXlyNDBPa3BkcTE2aTU5alVpYTNZdDRVM0xiYlI3aDdOdDJ3?=
 =?utf-8?B?UDlxTFhjRHdIWldpc0dkYUR6ZlBMekpMOHlxSzZoWmlFd1dDcW9NTjdOMTVK?=
 =?utf-8?B?bDI4WlJ0WFRRQU5hbnVZbDc2cUxJdTY4cmtBRkV1d0xTUkdQNS9vK1JXVStC?=
 =?utf-8?B?aTRMQ1pyaTZidURqV0R5NFlyR1pTQ2c1NENWeW9iMHVEaENJZ2VmT2NZb0VN?=
 =?utf-8?B?Z0o2L1dBYUQ5UllYbzNnMTVpSWhqTGdIY2dYUGUzQnJYcEJTN3dUdzlxanlT?=
 =?utf-8?B?dDU4Q1JZckZRNWI3bGh0VWxQUEI5bDlFQVZzdXplUlZVVmEyWThlMkNnSU1w?=
 =?utf-8?B?RVRWbHk3YWpMMWFiSkl5dTdJWEtCZ2VTUzhUY3VlUE5qY2FocitKdUVxQjZJ?=
 =?utf-8?B?T0xHaEFKT3k5eGQvYlVhbVlqT0VnOHFTWStXNGExekpZVWswNm5GQW5MVisx?=
 =?utf-8?B?S1Jnb2lLajRKV2tHZ29KbmhKUXRnUmZlMHFQcWlmVDFEQ1BPU051RHZXNnRY?=
 =?utf-8?B?aXVJS1dCdzhRUkFEL0kwQTRPdWl1bllhZ0lxNHZra3oxSVo4WHpRZVhteDdv?=
 =?utf-8?B?VHN1TUpVTS91RFVRSjJhMVR5eHVselV2eXBVTGx3REJlRGZBYkIwM2dEQnlt?=
 =?utf-8?B?bnhWZllwa1lFSFBZaHhWL2I4d0tCRlFtMW1vOGRKbXVKbGpiMWJXMEJTVGVW?=
 =?utf-8?B?VlQraUtsME56ekU4U3owTlV2S2V2KzFlNGkrL0dxZE03a216UWNzZDhSSmZV?=
 =?utf-8?B?M2JsYnN1VTBUWU9aY3ZwczdtOXRtdzJmbGNKUnR0Z3RERy9raU1YdGRaSkxq?=
 =?utf-8?B?eHRBMEd0ZUxrSERySkNNSW5MRjRBSHc2Y0ptRldOZWhLbExFNm05YysrZm9Z?=
 =?utf-8?B?OXdHWDZMWnJweDFoUVZxNGJFOGpsSUFtbG1WQjVYeHE5MVluckFoOVlUTmxs?=
 =?utf-8?B?TGF4c0s3c25kL25YMU5DOXdpOWlqUlM3ZGJ6U0x4MXFOUmRpME5rUFJ1ajF6?=
 =?utf-8?B?b0dpVGtOY2FyZWkyUjJjQ1FLdFZKMFFzbFNkSldDNS9ZT2QwVGs3NE9UUlVo?=
 =?utf-8?B?NnRja3hNWkhFYjF1anZXYnRZQjQvNFhwUHhISDZkbWJhSDhsSzVQOWx3eHhN?=
 =?utf-8?B?ZWtDM0xBU000ai92Y0NkL1NmMWZFbU9vVGlISU5zUkc3ZG1KMFlzNHBUM3Nn?=
 =?utf-8?B?dnozcUhRQ0lrNHNMN1daVVZmaTYwcCt5aDZJVHZpMldacEE0MVFxUG5iLyt0?=
 =?utf-8?B?ZFpxOEpJSTQycm9KbzR0ZW5jbVhhMU9JMlVPcEVIRVhGdXJhZGpJNEE2YzRJ?=
 =?utf-8?B?ejNDUXVoMDNDUmpsY1k5MDBBbzNXbmtRWHRsMVBXSS9WMkcxYitGUUliRGpr?=
 =?utf-8?B?Q1E2SG15cGpVUmE1VVpQNDZVYUI5eVFrRytJdnZFVEJsRmhDLzZXTHlmOHc4?=
 =?utf-8?B?eGMxRkZhWk9FbXJscUlOR09kVTlzQVZSMUxZVW1YSXJOZVdTb0cyQWxQNzlM?=
 =?utf-8?B?d2RnMVZBb0tQaWxPWTZZaTZsc08xb0lzRUJXQjBLOFFEbFA3U3p5ekY4NGVB?=
 =?utf-8?B?UFlrVldISm1BWHEvcWZVV3AyWEE5RnBWMDJHTDQ5YmN5ZUNtam4xYUt6YTJ4?=
 =?utf-8?B?RVZmNlJxZHZLMDY1azFjK0QyZ2lvUlFnUURMb0ZHTi9HN2FZSXNjLytrNFBm?=
 =?utf-8?B?R0lmVFkyQmpVQ0tHRGV3STNoUmU2UVovcVlFekk2aWMyZUo2bTgwSGdjMUxp?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c2d43-a514-466d-da2c-08da68d1d5ab
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 15:26:07.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZCbqstkjZ0q81xv/NuPYDHeBcN88aNnDtb9pbYZR0bAFM3YmuGNeP72luPCDLPlTnmJSPVOL6qnvTZd0/k3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 10:34 AM, Piyush Mehta wrote:
> This patch updates reference clocks, for the both dwc3 (dwc3_0 and dwc3_1)
> and xilinx-cores (usb0 and usb1).
> 
> Added ref_clk 'ref' property for GUCTL_REFCLKPER and GFLADJ_REFCLK_FLADJ
> calculation. This property configure correct value for SOF/ITP counter
> and period of ref_clk.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>

Pick one :)

> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 14 ++++++++++++--
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi         |  6 ++++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 8493dd7d5f1f..cd63b6afb3d1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -223,12 +223,22 @@ &uart1 {
>         clocks = <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
>  };
> 
> -&dwc3_0 {
> +&usb0 {
>         clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
> +       assigned-clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;

Shouldn't there be an associated assigned-clock-parents/assigned-clock-rates?

>  };
> 
> -&dwc3_1 {
> +&dwc3_0 {
> +       clocks = <&zynqmp_clk USB3_DUAL_REF>;
> +};
> +
> +&usb1 {
>         clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
> +       assigned-clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
> +};
> +
> +&dwc3_1 {
> +       clocks = <&zynqmp_clk USB3_DUAL_REF>;
>  };
>  &watchdog0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index c715a18368c2..2b3e3e57380f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -808,6 +808,7 @@ usb0: usb@ff9d0000 {
>                         #size-cells = <2>;
>                         status = "disabled";
>                         compatible = "xlnx,zynqmp-dwc3";
> +                       clock-names = "bus_early", "ref";
>                         reg = <0x0 0xff9d0000 0x0 0x100>;
>                         power-domains = <&zynqmp_firmware PD_USB_0>;
>                         resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
> @@ -818,11 +819,11 @@ usb0: usb@ff9d0000 {
> 
>                         dwc3_0: usb@fe200000 {
>                                 compatible = "snps,dwc3";
> +                               clock-names = "ref";
>                                 reg = <0x0 0xfe200000 0x0 0x40000>;
>                                 interrupt-parent = <&gic>;
>                                 interrupt-names = "dwc_usb3", "otg";
>                                 interrupts = <0 65 4>, <0 69 4>;
> -                               clock-names = "bus_early", "ref";
>                                 iommus = <&smmu 0x860>;
>                                 snps,quirk-frame-length-adjustment = <0x20>;
>                                 /* dma-coherent; */
> @@ -834,6 +835,7 @@ usb1: usb@ff9e0000 {
>                         #size-cells = <2>;
>                         status = "disabled";
>                         compatible = "xlnx,zynqmp-dwc3";
> +                       clock-names = "bus_early", "ref";
>                         reg = <0x0 0xff9e0000 0x0 0x100>;
>                         power-domains = <&zynqmp_firmware PD_USB_1>;
>                         resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
> @@ -844,11 +846,11 @@ usb1: usb@ff9e0000 {
> 
>                         dwc3_1: usb@fe300000 {
>                                 compatible = "snps,dwc3";
> +                               clock-names = "ref";

Please place this in the same place as the previous property

>                                 reg = <0x0 0xfe300000 0x0 0x40000>;
>                                 interrupt-parent = <&gic>;
>                                 interrupt-names = "dwc_usb3", "otg";
>                                 interrupts = <0 70 4>, <0 74 4>;
> -                               clock-names = "bus_early", "ref";
>                                 iommus = <&smmu 0x861>;
>                                 snps,quirk-frame-length-adjustment = <0x20>;
>                                 /* dma-coherent; */
> --
> 2.25.1
> 

So the "combined" patch is something like

 &usb0 {
+       clock-names = "bus_early", "ref";
+       assigned-clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
 };

 &dwc3_0 {
-       clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
-       clock-names = "bus_early", "ref";
+       clocks = <&zynqmp_clk USB3_DUAL_REF>;
+       clock-names = "ref";
 };

For comparison, the "combined" patch for d8b1c3d0d700 ("arm64: dts: zynqmp:
Move USB clocks to dwc3 node") was

 &usb0 {
-       clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
-       clock-names = "bus_early", "ref";
 };

 &dwc3_0 {
+       clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
+       clock-names = "bus_early", "ref";
 };

So this appears to be a partial revert of that commit (or at the very least
a bugfix). However, I'm not sure what you're trying to accomplish. Your commit
message doesn't make sense to me, since the "ref" clock is already present.

--Sean
