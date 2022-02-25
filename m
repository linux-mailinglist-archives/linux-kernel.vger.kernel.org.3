Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22A4C4456
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbiBYMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbiBYMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:10:07 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13279223212;
        Fri, 25 Feb 2022 04:09:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBoVmfrN7MK1K80ztuDQ0NaBZphZi1QDy8OGB0tvPo8MthYd0RK9uLw1292rQFHi/LyamLboAmvsoviBFQ5hCDXygJV2L2j6wzdgCt2kU0V3cQyn5chMhf+B6g3WQUpplkAxt0ZTIcaasLuJpk+xG8U6OGfUklfWZkhSoCj/De1xQ0xKUXChi1Wr3/GQsSGOaQ6oxnCtdgCKsuUIaBgbt1nzXAAj3MQbjCPSkRUR7YwtlgtNo2nb/eGGm4+7F8ANuMVdZfL+yY3iRZiHi4UyWAVwOOM8gNpALcqn9zEGKHdphQdLUgc8Cnhji40ZXKwI7YtqcDlWim7j8zGNEHJoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1j4bxuE2RTGQ+wresA8g4IhHA3itnMYP/lj77u4h/4=;
 b=nmRyLCtKHAqSh+O6HUWQf87ihFIdEQgdOfoVaqFg3lPYDg045xaQ6HF/VGGj+xh4DGh1bmTCugve0mX4lOdyMKxmUqRNcDeGHZQ9W8OPa/RZQ1mb0Pbe0oYR5yPiuCT1fo8AN81E1G2Xmw6Pat/cRkzF/Q++xitiolcwWcSvRftZlH2322/F9/MSdLoUtNb7QILtb9WfYfYkiDyd3FJ/cWiFso5pAf9VdnVbVBw8qOfqTvjPqhv/AfVKfhJZbV+hp84QU+5ecYA98ujdEc1NLSOOiKmsaMN4BUzVxZpYN1XFRxBiRTgC9qrjWJ9So2/6AfnqX2+//UEs5rUi0/1tHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1j4bxuE2RTGQ+wresA8g4IhHA3itnMYP/lj77u4h/4=;
 b=U9E1s/OZ0CgYYF1fHf7Ckf1WcNUQWGSahszB0FYBx59gPSsvIT/w02BZsaHtnNYJ1j4DEROFKAlUkTx2n7L5qnhSf0MnSZp5VGP1sDnmR0v2CfByNhMQr3A8wy26ePeVQoTd2nfiuvkTdsazevfVvX7gEG3xouf5YmeXn50dRKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 12:09:32 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::144c:129e:befa:2602]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::144c:129e:befa:2602%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 12:09:32 +0000
Date:   Fri, 25 Feb 2022 14:09:30 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: add hdmi phy 27m clock
Message-ID: <YhjG+mWuZEUjtcG2@abelvesa>
References: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
 <20220225090002.2497057-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225090002.2497057-2-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR0601CA0035.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::45) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d580812b-18d1-4362-aa28-08d9f857ae57
X-MS-TrafficTypeDiagnostic: AM7PR04MB6872:EE_
X-Microsoft-Antispam-PRVS: <AM7PR04MB687247EA6FBEB2CA54A30D87F63E9@AM7PR04MB6872.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5q3EodHoJNAMDQN3JIVIDk3iRpcaGrz4nyVB6O4l9Bah41ChBbvdUZb2k/56JTElYV23ju9TBrDFmtWhGIH8Bu3yGNzeoOVbKwA40MbZmgrXkbGCbpA9gd6EFtLtii4kFavdGLpeTVb9PqxqjUqdFtSlE/B8+QMfXAewYrgiui22mT2cziQEXxAZrz1utNtfsexJnHK6TwdWUQMIefnTDRrJ4airmtms6yTDJyNTVj7Fa/etyGbzZiXtvs5z0jxbd09Rp96ptQisRmpSvCKtwjEZ0PvxQfihusy7J3TxHEk186C9bZ8IVqZzlp4K9IHmKZ/zIk3WVigBjwgz7T2JKE75xj4//IcegzZG/Jllb/HY0Eva/yT8lySLXut3IdbQlgDhoHGK/kLO1/MtFIwheTqirmHKhtnBUf2gFowk+4h71UfF1HxJKtx0CgIhNdeS8A1VlLH7Bsy5AHkJCXNPOxywiGCPtejIjLhskybEcwrbjgn0RxRTbLK6OL8ksljjnlnuZ2+Yprwb1XUt9LJBP7VD7++qfYQjeFD0B492i2b1vgtdZa+FlPOeMJiimvrXhzF8O0FDruw3MoReKPVYf3UC99LN/8NuFY0vdBGbG5ZziSsbGKaBNrk0lNeEIKGZd//SxelVFhM2WLQx2d5sZVZJ26yuWA9ynYJuAtc9ENqEIx4eGantTIB2Ld/5fffJxln29aq4rG5brzJzqtC8PxCnTe+jNzn2sLkIMt4YIS627lhLIB7xXQ7ygHLSsHD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8936002)(316002)(86362001)(52116002)(6506007)(53546011)(9686003)(6512007)(2906002)(83380400001)(66476007)(33716001)(7416002)(186003)(4744005)(4326008)(5660300002)(26005)(44832011)(66946007)(66556008)(8676002)(6862004)(508600001)(38100700002)(38350700002)(6486002)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YfSF6SP83VjDT14pCcYdjutC8czZU0pLa7thIoXa3sEU5/Ak1CD0c0+7Xhi6?=
 =?us-ascii?Q?/rGC0WeIei3HJouhm3SwX75wWzaL8gCBWi31hUh/QFgVLojdarNUMZMvTXxg?=
 =?us-ascii?Q?LiIy6Hav0WQKaM8mxjw3dqapj99KY7HbRg/E7F5MY1z0J8hldATC+3BfXs0f?=
 =?us-ascii?Q?QT5Mo3cIWipP1Zuv0mrfhrH4Z1bg2W03dGw4avfK+6c2tB9sxa0lqnqUGwS0?=
 =?us-ascii?Q?HJupcL0bXYBCZnwkF0jbR4lcqQyKGhdroQ+9+UZfvOwA94PHlWx0ubDatAhv?=
 =?us-ascii?Q?o7xqw7plOE2uTcKWeNhsbdV04qm5Cbw2r6UcUrAyfM4/hahkE9Se3g3v2kNB?=
 =?us-ascii?Q?2RWkf6mfhnos16LO7G0a8CVAauFvA6utvDcokIGKnfY9bJPlLc2noK9BEToz?=
 =?us-ascii?Q?ISDUy0XsRx7o5GgpuS4kIpojVeursVSaSofnYOQlrKCdou+QJOITAGm2Q76E?=
 =?us-ascii?Q?BOp2C4phmOd94eGOQLokOuruV5Mk6u1jIB+q5nXYRi7UKmgntptgP9S4xUw4?=
 =?us-ascii?Q?Cnjeu4z/+dn0yuVZBxH9Y1TdKRNRCpop2ioLPpVBUrS4gUyMrSpWANUoziy4?=
 =?us-ascii?Q?i2v08qYXUEEFxetdnejm/ueEGMTjNA0tvgG+rsvF7msBs8q87xzcTj0Mqne+?=
 =?us-ascii?Q?+iGReH8nIOk0MzOD5HIzebHtcETE9Jfe1ZTVmZZ6/Ikz6lO7AvVEVRJ84rgB?=
 =?us-ascii?Q?8j2chTlcpYLUTxtJSor1YrAm2exBx7R+1/19wrLTnJx8e8JiMjxGE/Kyf0Hf?=
 =?us-ascii?Q?LZVImMSq51Ex7otK/1vmHs6eFZwIW7oGzYzGCqNJ5ZcnB/9rJ7c/1IWIE4e1?=
 =?us-ascii?Q?TFr3JFsvbhATZRVObH88SWw6lf/KEcSPkQ62RnOb8l0HTnU7DpOKd2p7M/bL?=
 =?us-ascii?Q?TKR+ljiaj4EglpA5+fOQrzJrsNCJaRRmO8o8tYqkZZ/HtUWu4aKrIUQWTQXW?=
 =?us-ascii?Q?5AlnRTUKk+ojqyHISM2Ph5PTK7CK00zg7AVAcfQ8u6oUsdEQIzH+U0nc6q2W?=
 =?us-ascii?Q?94t1+iuQ7amR+TqIw41Lhnu9/4sSpBp6CqDQAoeJrJk9P/Qox8cYi7I/zpuw?=
 =?us-ascii?Q?ChV23t0fDezkAWZOMu7hSSvdAXT24xff1137wpBSCkneNrEgB67E+k5IVqm8?=
 =?us-ascii?Q?bfU/m/4/yMxGY3ZAg1NgRAZN5cz9H0igSg+anEnLw4+Ik5EzGxhxKAVM8Qen?=
 =?us-ascii?Q?J6ctPH5AbFJecEKiv6ZfH8nFiPQFQIYh0eRy1IXb6xjoynXKu93npTHmsa+6?=
 =?us-ascii?Q?wXEPiVbrtgHm7ClePS0+PcTWwOWZ49gvmDJdq6aAJufm81opyzmrHfAmyznQ?=
 =?us-ascii?Q?qEFPcnpy5LTLinAB0VgIOwostBemEHkjfi02mY4srA3//9e0YgzesAwLNLC8?=
 =?us-ascii?Q?hf6Fg7dI1gKude3rZoENWqJ9kNMGhHuJtl3fdJXj3j+ippkVCnDXVBvwMXRO?=
 =?us-ascii?Q?VfDUk7/y6vZVTmwJMhT4ZNkSRxkCcCf5w3ofdkIOEyJls6lTOfHKpUWzih7h?=
 =?us-ascii?Q?sD7rXuDQMQXj7WWJPsbOFe30hmU4NApg5IfDBIhW4WyiPoEoRxqnzGD+0L+s?=
 =?us-ascii?Q?0H5uci6HiB0i/GHAdbnxQd5nPL9uYKmB50qjKAQhjTERTAfnJ/Dw7LrkQaTj?=
 =?us-ascii?Q?OAmH+Pd3LhaYJtDX7drTl1k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d580812b-18d1-4362-aa28-08d9f857ae57
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 12:09:32.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGbrQn5uAF1tY5ctZ2cktH9IX4THcETHgzOLeEUn+GxpKI7N18gUV2axdwEuXz/eZEM9DW+zcTfJ4GNTdlJhMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-25 17:00:01, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MQ PLL support hdmi phy 27m as pll reference clock,
> so add a fixed clock for it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 5b3e849f554d..1eca2b431467 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -63,6 +63,13 @@ osc_27m: clock-osc-27m {
>  		clock-output-names = "osc_27m";
>  	};
>  
> +	hdmi_phy_27m: clock-hdmi-phy-27m {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <27000000>;
> +		clock-output-names = "hdmi_phy_27m";
> +	};
> +
>  	clk_ext1: clock-ext1 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> -- 
> 2.25.1
>
