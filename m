Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3018C4C63C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiB1HYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiB1HYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:24:41 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695966AC5;
        Sun, 27 Feb 2022 23:24:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiYT8akoiaH9t+4R9gbC/nQ+uZrYQgDeQfANO4XbaNToSt3IA7t36qX0OK1VnjtGNMpMuPKFfBJrzLd3qw4LXkXDSqyg7jPnhO25VdFwM2D/iY0Xjag14Bey/90uo/WHo54OcigC6nDlGkP/PBM/DCFSxpfk3ZIklTu6qR3+hWXlddD+jAVLpSjl9Lxw+YB9bRgEk2ICeRAyGi+680EN0F6seu1VOEMnU4iitAsKGCaRf9rXEzj84qsBqcwrkfWJI/skil9RiB7DJD6muNWY+NSPB/wKPGbHqOc3AJ+ktqu0LZJlX6Ep3B556Wsl6zS78xmMOteba2YnVXqLftONwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSzdleLiZMFuqwoE6zntyTfFA/cBY+Wn9/YoCH5nQ2Y=;
 b=VJ3l8dIvwyqWi9qfnVPQ3yzr2urRK6AbNnMG3y8Tn+FzgGCHEzdzPDDgag+z1R1fvPSL1C4WEAibC1qluiJ3Jx5wPnMAPuk4FhQG0aKpxhSCFr/40bLyVelt2xxgh2087PmfikDchj81xQJelMm4P8fVuNvOh5L2EE2TDeD2WV3tVG2m7J6JnaCTMDlgDeHFmqrJB0kIOHG7uaoJV8xeZ/c0mRBlGK64ICLBxIb3NhPUU9Aig3/XYFhnaTC8FrUD6PKrzYXrsUGTI6acONNFOJhIi/dica6j93OXaiM2LL31b3bk9hEnKPSToPr136eIFItbMi6b/Qbcyd+wrVx4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSzdleLiZMFuqwoE6zntyTfFA/cBY+Wn9/YoCH5nQ2Y=;
 b=V8Gd48Mus+6m+MGg3S1/tevS/vGn0NqISTMX1VbAYMvFSWg5F5vjcx6g7C5nPCkNPN8iwt4jTjRTmccFYLnbSsyil6C38csdX7laNlRZZe4sAJ1es68ynrhNK99dr/iovbfntIhAtkhx9LkuExIcbnh00kKBiWbY7pcjHhEd0bA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by PAXPR08MB7382.eurprd08.prod.outlook.com (2603:10a6:102:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 07:23:58 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 07:23:58 +0000
Message-ID: <fdacf3eb-7892-c767-ae85-1672f85684dc@wolfvision.net>
Date:   Mon, 28 Feb 2022 08:23:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, jbx6244@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220227153016.950473-1-pgwipeout@gmail.com>
 <20220227153016.950473-6-pgwipeout@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220227153016.950473-6-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c2e95ca-4112-4c64-5850-08d9fa8b4921
X-MS-TrafficTypeDiagnostic: PAXPR08MB7382:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB738276C9DEA690435F48F234F2019@PAXPR08MB7382.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0o5H4Mzn0yIB5lPxpLXHMUe4lnCIk8beYRaHrQeJwNj1Z7Nn2iDo92iadaRJAxS4nSlv3RuWVLgGLuqh3ocmabBrG0L8ZeOFb904Z3IWHPXpOxsi7z6/KUJ7Dm237aQ7KZGdn85upiAXtEaX8iE8MKmXKMhnEibiPdCp3E3gkD8yjBMf6CsA+i0Skbtibje2VhhxS+7ep2dqpq18LGtLVsmNoSbfB7DkrtoABPY0BIlbA2JLAW1l+6tv/QtOdtsBtvOKklXZU+Wl8ccWL/qusUjbx3qZrMnZDviZ/Ql4c5pxLoL2kqpQt2h82vT3w8XG3mXw3StYjkqZlCW9I15W4hhvNT0iSKApRbC2PX9qy5EjRUGxmJhKKL0qw/L347qp0yR8hkUYDz1Vdx51I1HblIrB3oJfwdW6gs0grQB0dmqnlNuOZLgNNkHvDwBNYbSAuTWrJswfmubH1QOF3ZprHSg3KP/Y0PB82izxs1iYzOUukgvne6q4BUY8bhs06aMtFu6a+xI6BO/4tF+Zd/xrxbCFOg46O7NQYuMn1aQcoQN+cthMPEjfX8D3vCmN3bZXtN67QK8UDyUaq1uYXvb+NUVVAHqZ6yorn3U5YK/KzR3EpK0NbIlF5KsBUwtNQhb81IzB9Qb/z35zPTRcbUd+iEQxWe31kchDUQcBVTRYuv5nvUEdo1RXsNb/LJt4Dd47hkVEN7HTmXcPdiadzH5+RYJR73rSaK2AkWh2hr8eN+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(6512007)(31686004)(110136005)(83380400001)(36756003)(2906002)(6486002)(86362001)(316002)(38100700002)(186003)(508600001)(4326008)(53546011)(66476007)(8676002)(66946007)(2616005)(66556008)(44832011)(6506007)(8936002)(5660300002)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXI4Y0tZVEVsTjRkYTZCWXE4WHFrS3F5azd6bFUzeFpuNnlvYnM3aEhMaUxr?=
 =?utf-8?B?cHNqaXFTdzdEdzd1TlJzbFo5ZWxGUHdFZkdidVNiNVlqN0M2ZUVDTm9iUUVC?=
 =?utf-8?B?MW02ekJmZm5wZHNEeTJyUEthNEJQSDZKUmxvUCtnYXhIZlN5R0RidmFZay9K?=
 =?utf-8?B?RTNXMGZFbzFnQ1J3UzJPdnczL2ZSMEFCODlmcVpnWG5HbTZ3T3FHZEZqRzJo?=
 =?utf-8?B?NG81eVBnREJmMk9Zall4bWVIWWs2OXpuRXlDOTRyblZyTVJCc1gzYUFoaTlX?=
 =?utf-8?B?YW12S1dVNHQvVklJdjlWVWo0dEI5a1MycEE4WEVGL3lMQkEvbFVxZlB4UkEy?=
 =?utf-8?B?ekNIcUc5L1pxaUNWVXd5a2tPTWhUbSsyei9ZSEVZWjVuT3RsNytVUnRKejdk?=
 =?utf-8?B?SWZpOE40ZytwZEdrSW94Qzg4NU9IS3MzUG5TUndZUlFtYmg4OVFxLzMveWdW?=
 =?utf-8?B?OFp5OFkwZFZOY2FMZ1hhL3NOVEFmYmlKTjZZZXRialNZZmtqTldNRXVSTWp6?=
 =?utf-8?B?eDYzOWhqdkhXWTRFWmxsa3JSclpGRGEvYkw4OURiR2VJaHF5bjdWdVFFc0l1?=
 =?utf-8?B?S0NjdlNGUWh2N0tGbmJKNERldXJwMEN5TXk4ck5BUTI5akUwWGtQNjVDWno4?=
 =?utf-8?B?WXp0aGp4ZVVXWnZtWWgrYTRFd1p5Z2QzQU5ndmhZUE1VYitLVW5FRWl3NklQ?=
 =?utf-8?B?L3BMZVgzb1ZrZW5qNGlYa2xjUWhTWXNzU2ZmOXdFT1RzcFZsdFl5WnRRL0FR?=
 =?utf-8?B?YkR6eG5OV1MvcUtHYVQwZkJQMSt5VHhNallYZVBhWCsvTjR4V3Jvek0wSzdT?=
 =?utf-8?B?bFhEVlRjaXJDeXppblNCUWF1RXNkbkg3U3hTU3FtOEV1QktMVzEyU3FlSGNq?=
 =?utf-8?B?NTRsWloyYldyL1QvNkxoa2pyRnJXamY5QStUanhaeUJIQVBXZXFnVHFmT1Nj?=
 =?utf-8?B?aXMyaGFpTG1rUGlrK0gxdFl2bFAwVEEwQUpBQ1Y5UjR3MlEwSUVENUtPMmpG?=
 =?utf-8?B?RkNPcSt5SXB4c0ZyWThyQVdKdUFjVCtpOGp1Q3ZreEpacm1EUEQyemNtZVhJ?=
 =?utf-8?B?TzcrMURzZE51RnlHUmt4SlE0TFVORURDNGd6dXphdE94TXJvajFieGRPZnBi?=
 =?utf-8?B?SmRodDRXbjBLemQzWWQ3WHFwNW5tTlJYS0hERkJTS080a2VFM3E1eElKWHdu?=
 =?utf-8?B?TkFnVTJ6bks0dUNWdU52bWFtVkpRSE5xNzBQcW1uYXpYR2VScVZHeWxYZGhh?=
 =?utf-8?B?N2NxSldyTTZOVUMvb2R4SjRWb1dZREo5NUU5TmZxNlFGeTlwYlJDazh1V3Za?=
 =?utf-8?B?OHdDNms0UEpDT3N1SEZ4cTFmc3pqOHlkUTROdWxDZDM1N0dtY2xGaGJ1dE9q?=
 =?utf-8?B?Q2RSQ21HdGpqL29KTVFYVzNCVlNmMGNHNklOTmxYWERDVVJpTVdPRjhXUjNj?=
 =?utf-8?B?dU84S3ArTVUwdzVheFdrYTFmMllUL1B0bHhxVzkxRnlNMW0wQU9sZG40Y0Vt?=
 =?utf-8?B?dklORE1BZEdMTlliSXRReDI2ZmFZT0VEcUtPQkpTd2pJQUhIZFhwOTh0dXdF?=
 =?utf-8?B?RlQ0K1p2OHBIMVRmMERJdnlMaTZ2aWhxcVV4RzZHblZIbDhKbGQ0SUJxcmRm?=
 =?utf-8?B?SjZuLzhiUzVIUTFPb0Fzc3NuK0FDUXRaZDZFd0tPL3FxNHUvcGN4UjVhNm5Y?=
 =?utf-8?B?U2hGYmwrSVhPbDk1d0lnMUsyTUxiREc4dTRZanhhdWoySldLaHc2VlFkWkVP?=
 =?utf-8?B?WFU5VHRKdU5TdjkxMUYwWXRQM3ZyMTdwWHdUdmY4b01XSlpwZXhaQ25IY2Rj?=
 =?utf-8?B?bzJ4ZmNVUXVIdndra0lmUlk5Q1h4WVV2NEJCQ2toTEhVNEdyT1ZvOGFhU2tL?=
 =?utf-8?B?V3E1MVdBdVNicTViOHkzaEZwMnFUNUZBOW1uWEJmWVJHNktLdERIN2dtbmJk?=
 =?utf-8?B?Y2ZWY09HVmRuUzJnVmxYUk4raGRqcy9LWkVSMFRZazZXcmhuNXdGNGM2V2hC?=
 =?utf-8?B?TFEySHJPenAvMnBpNk9PVzZPVUkzZ0twNDFvWllKeVd2TzIvUzNwQzJ1Rlls?=
 =?utf-8?B?Qk1LR2lraDFlL1lLYnk4UXVHaVRhRXRFQzNkbnI0MEhRQ3dreUYzQnIvaTNi?=
 =?utf-8?B?ZDh3U0d1MFhna3g4NUdKdURFUkxIRGdGUkhjK2NsM1k4RzNRQ1VrbG9EeHlh?=
 =?utf-8?B?L1hUdFFMeFo5TGg0ZXRucnU5eGY2dkh4OHRYakovMXdsYk9LK3c2SzJ4eXNM?=
 =?utf-8?B?RDVlb0wyQ0lUSDhjMjI1NnRhOW9aTFRNd25OSDAxaHlJZU9aNFZsNlJNUVlF?=
 =?utf-8?B?R1hzUHU2bi9xOXF4VHJuNHRvL1JZazEzeEIyL3Q1dGV0YjFSaDMzZz09?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2e95ca-4112-4c64-5850-08d9fa8b4921
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 07:23:58.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZqJVNwpNVrVwm+yVs0sBwkuwPp9AHC87syRNa/SZhyY15JLIvrOw5gmD1ugTvTnSv8jtgFG8i1/WaFusbPusj5cGLbC3+kZYTC3NEeBuxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/27/22 16:30, Peter Geis wrote:
> Add the dwc3 device nodes to the rk356x device trees.
> The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
> dwc3 host controller.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3566.dtsi | 11 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 ++++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 35 +++++++++++++++++++++++-
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> index 3839eef5e4f7..0b957068ff89 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> @@ -6,6 +6,10 @@ / {
>  	compatible = "rockchip,rk3566";
>  };
>  
> +&pipegrf {
> +	compatible = "rockchip,rk3566-pipe-grf", "syscon";
> +};
> +
>  &power {
>  	power-domain@RK3568_PD_PIPE {
>  		reg = <RK3568_PD_PIPE>;
> @@ -18,3 +22,10 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> +&usb_host0_xhci {
> +	phys = <&usb2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	extcon = <&usb2phy0>;

I wonder what the correct place for this extcon property is. You defined
it on SoC (RK3566) level, in my patch for the RK3568 EVB1 it is added on
board level. Is this common to all RK356x variants?

Best regards,
Michael

> +	maximum-speed = "high-speed";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 5b0f528d6818..8ba9334f9753 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -99,6 +99,10 @@ opp-1992000000 {
>  	};
>  };
>  
> +&pipegrf {
> +	compatible = "rockchip,rk3568-pipe-grf", "syscon";
> +};
> +
>  &power {
>  	power-domain@RK3568_PD_PIPE {
>  		reg = <RK3568_PD_PIPE>;
> @@ -114,3 +118,8 @@ power-domain@RK3568_PD_PIPE {
>  		#power-domain-cells = <0>;
>  	};
>  };
> +
> +&usb_host0_xhci {
> +	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
> +	phy-names = "usb2-phy", "usb3-phy";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 7cdef800cb3c..072bb9080cd6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -230,6 +230,40 @@ scmi_shmem: sram@0 {
>  		};
>  	};
>  
> +	usb_host0_xhci: usb@fcc00000 {
> +		compatible = "snps,dwc3";
> +		reg = <0x0 0xfcc00000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
> +			 <&cru ACLK_USB3OTG0>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk";
> +		dr_mode = "host";
> +		phy_type = "utmi_wide";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		resets = <&cru SRST_USB3OTG0>;
> +		snps,dis_u2_susphy_quirk;
> +		status = "disabled";
> +	};
> +
> +	usb_host1_xhci: usb@fd000000 {
> +		compatible = "snps,dwc3";
> +		reg = <0x0 0xfd000000 0x0 0x400000>;
> +		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
> +			 <&cru ACLK_USB3OTG1>;
> +		clock-names = "ref_clk", "suspend_clk",
> +			      "bus_clk";
> +		dr_mode = "host";
> +		phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
> +		phy-names = "usb2-phy", "usb3-phy";
> +		phy_type = "utmi_wide";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		resets = <&cru SRST_USB3OTG1>;
> +		snps,dis_u2_susphy_quirk;
> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller@fd400000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
> @@ -297,7 +331,6 @@ pmu_io_domains: io-domains {
>  	};
>  
>  	pipegrf: syscon@fdc50000 {
> -		compatible = "rockchip,rk3568-pipe-grf", "syscon";
>  		reg = <0x0 0xfdc50000 0x0 0x1000>;
>  	};
>  
