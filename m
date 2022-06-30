Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB56562620
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiF3Wcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiF3Wcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:32:33 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91657219;
        Thu, 30 Jun 2022 15:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmSeV9dhHc/LoilfayBAyhd2rIkCieV565oxb4bjDajwXkTtFaO2FEfCBFdqqMABN6LK/8xtDfbL+8B51c8zNhSRHXT3/0lAbUKXxkRm34vefHBOptZETdf7OjBRyPGtllH0+UsEDjXLvCMFGI3Do+oR3v9b+KllsQy3cjkuAeqaTXHsbojKpOMr28WvTwKvghyWQBxZm7hSTdmDIHUCCWkWTJi7wnfo129FK5iQdqD2wlaxIzglw+A97SOefpJOsCmuWOzGx2HKa+we0v7k0NbQ0g0KPyFFXbe1QHTNjUGXkWh3KX/P6kx6Z4K0MZrCSKxynT4AneAbAv6ggVot+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlktDT8Xwqqrlm5IlXWyHunjUfL81yfo19MXBg096N0=;
 b=jlF73/ZAk6NfqjmFagHcmelmAA78Dv8SPb6Y5jjseZiM+s97zVc2t/bFWzGPfYDMaqOKR4/+SUcneeHAp+UK3aT7BcnQfWASE+Qs5/GQmBfy12FmzXqxNtGqlGK/Chitk9MqycObH01O6tJb9CDrtzn0rctZkGNcsO73ipIzylRvWKjv0TabLnZbcQIPy57hA+ImlXkJbxYRqQDT5VxdWJgDfLLee2FZRr3pNLsOk06gIouiFMPzX6tIGwHjxJb+CDCIzo9d8X/BZTubuGc2l1izrJumJfSUJ2l+ZJGPrtYp7wpaTyFqxBX3t7x0JI+S4OAngcTJ33xtcbVMac5tfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlktDT8Xwqqrlm5IlXWyHunjUfL81yfo19MXBg096N0=;
 b=R0QoqI9lmTKrVXuoqje2n7nr+PeFb5EV1aZM5/0B/BQ3qdvsDOVl7TbIc6ZvC49E8y0bp6FpracdfkryJlLIcTuPXGnol6Uix2UvmnWfsEq1CIijsGbBh2Na7RfAFAAOr5FlX+WLHF+oBLHyxOWPMMaSy0/SUy/TwwQZvZln97WVsFzUTZdKmW8hbMxtihcb53TZGIQ9sgIsiJi71MShH0swa+4sQS+2RgdrEJiHinmt/KoCaApPhk4FfrA6NYd/BYHVGmdQCrr1u2PKFJLvaqyYghX7WZvGGR/qHcp5p+tpZIff2YjjsLVsPXa9yMWHOOkn7LlnV2MJZ/4eE+9piw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB8PR03MB5884.eurprd03.prod.outlook.com (2603:10a6:10:e3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 22:32:29 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 22:32:29 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4 2/4] arm64: dts: layerscape: Add SFP binding for TA 2.1 devices
Date:   Thu, 30 Jun 2022 18:32:05 -0400
Message-Id: <20220630223207.1687329-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220630223207.1687329-1-sean.anderson@seco.com>
References: <20220630223207.1687329-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e05531dc-b692-4457-aaee-08da5ae86abb
X-MS-TrafficTypeDiagnostic: DB8PR03MB5884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+Na+PuAKdN6DW+3ZdphRVHDMQYL+ITo9b7gr4jLBf9a7eIlSBdE9lHaSYerpxAmLNj57QZsRje7XiFWOdjrsY2aOiHgRKPA3oJ6BwZRdKlugsuvKHQU2VJIpVHMwOKv5Q5WOIbDVFDmFPlm/GO/JMD1mepsaNbRO0C5KGuySlewDPMYCGLZ/j3JPU7w8FMVMTCi9hvBVqzrjBLucyWgKyjdQRyRHFXfT4Ik8lVyMYrQ4ADBp3Dweazle1Tu4PZpbKA1t1sakFN/t2rnScdCEK1VR9slk30tgxClm48BCquv4JmZwVHWKfBvXKMVCFCVe+mg9GIN4ReWxlwnwu+WmfL0yWV9FuAR2UsThSASXpQ0Q1+PD0MK0rghdNBiXjdK/rzfEqePrH8OiZPCIUkPFyUt3bdHBZqAU72Vb8j0aSnjbGYQ8YBqAOqOXvXsPnAi/cYPi8AdMncjuPVnsPTPrNweptW1bGT7oaJ73NW4I3sjPzWWhvkaTyHwUytoYdImaMGcWWQfzLCQE8hfmziXNmYS9posj0ufzYnqQzwNfk7uhzO/QK03AXAjetFYkvmdoDPTnhhNF4XAxeGMlKy/PLBtdd3iW/cPFuMVdmu5rJ4WVrQ2YCrjgtfzwbPx7fCdWJBsLwNKzdkR9e2t6Kuq2JTO6TDT4P7rALzbcRmyOTkAq9PZljxie2Ro2eXyp59WKjGQl2HZoO53REFZx63QR6vkNziHjqQKTr7SqAfkdhwkcedCtKSPeMmcaNQvp/Ww+zM5UJ7JPMkz++6rI4EyqJbgPlKZRLEXdfO4nER0PLud6Vzc1EdIlocNMXtxZdw6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(366004)(376002)(396003)(346002)(107886003)(38100700002)(66476007)(52116002)(316002)(86362001)(1076003)(8676002)(6666004)(4326008)(6506007)(26005)(5660300002)(6486002)(38350700002)(66556008)(44832011)(478600001)(66946007)(2616005)(2906002)(41300700001)(36756003)(54906003)(8936002)(186003)(83380400001)(6512007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtKQBYN8R+NzXQWqbIZaPVibGZdsguzMOs/AOQyAgvd4VWr83vYVXfC3Fc3k?=
 =?us-ascii?Q?3CWOashGZpeOFrZsyHWwDqtAWfU503to2iqZI8bhGZKHUBWMAnRNzuK18PTo?=
 =?us-ascii?Q?tTTwEM67YNYjsuGsCJ6oPvlMdEbj4Gbo3dYMN1dWNO+pfhd+CVKrnva15/wy?=
 =?us-ascii?Q?w4E0tfZsjygwtiFVnZAnoUttLbmSCGljLHGZwLSV1B9IlgXXFfi498BXLQ8z?=
 =?us-ascii?Q?MbGVtat5kHnWEENIOb5qCtGAZf04ki5CuA9fa1AWuvx7oBL4We1y8dJvA6tO?=
 =?us-ascii?Q?kE7q3fvyevM8U1jz+22wCbSwoAzzdsFfDlyhxoFR9kX/WEkluGIKODIv/1wr?=
 =?us-ascii?Q?dJ1kO9zj+RVyBWQQgToZz5NaRilXObB3VnZ3dpM45EV+awtA0ZcipZQzaDud?=
 =?us-ascii?Q?C/Dh6Be9ASXTnvdkdu/TdmDeFhWksmYInyQEMod69pKyOONS7XxJewTPK1Z8?=
 =?us-ascii?Q?zQaV6tkaMoxdJ+MeXkA+2Dg6lEbSy36EJqAryNydb8m3pkt8qgKjzlkZmC6/?=
 =?us-ascii?Q?J/+zG+ZrCPdM7qoI7O+0+yJtG8c18ecr6zj0hNmtELyFRsJgHYiQ8BnJnmMp?=
 =?us-ascii?Q?ds7KPaMXa0jLs0jEQWn5rXHvh87KWNdetWXOjsfIHEEPLX1sEiMUC9jj8biB?=
 =?us-ascii?Q?++EsCCZpgAzuF7+su02Dsv1WCMJlWefjROh7x174HWmEdtSt8KgvCTDjweA/?=
 =?us-ascii?Q?ZJHrn7f1spCOp060csI6f6V5VMsa3FRbwfwiVGAXbv7yPTfq4aXt/MrPoxXh?=
 =?us-ascii?Q?Xr4CIKqn039ED0TLTinvK1voL7gQpbJjuvgdewS8A8inqX+RN0bri8QrqsXj?=
 =?us-ascii?Q?4nQcc/fFOXhtBoWzkJNp/aYpTeO9J2aYDmYstgH3Q770TrKPF9pyV0hRH1Wb?=
 =?us-ascii?Q?DxlGXvs/Gf/tBm7Ywf2+5hFXEwgioCTNuy7x9p7iGr1IbjTRPISW7WtSbPex?=
 =?us-ascii?Q?ItlzHcOaStsSNy0MLWwiRiQhnqFe5+FHLSsP11vqUJw+DiXVA65/OKSv07yF?=
 =?us-ascii?Q?Ed6Ta6XXmIlaICq0pBS+QPGwuatuXlpWIFmmbcQ8sBRa2XlgUCEzqLANDe+P?=
 =?us-ascii?Q?LJfCVmOqB9e2Qfx2XxtGK/tczz0ijseI512bMvbgVcngLiF3xYXcQCxgAQOt?=
 =?us-ascii?Q?lWrHP0GwSGaBHgNGMrS4VkubTGobYBRwmNsUei3aKVIUtOR2ww8WHRmIqyCa?=
 =?us-ascii?Q?IUWLAy7qeBHo7dj4OJdAIQBiIimTYY0gswKnnEIkAfykbm6h6FMStFaDoraV?=
 =?us-ascii?Q?Ac1S3hBFWWzeCFV51OCUo0RADYWx3WNKV2vYuoEUDtvrz9ALOegqC652lL/z?=
 =?us-ascii?Q?z1jWfYdvkIcQmi/HTNHrBhQ7TKaP4tYYoETZmEFPltoa+vpDZAqD8Cyrcf1s?=
 =?us-ascii?Q?SCUSSZvT8CZ9WQ5h53a6Hx5Jl6URBH6RFl0Mbl3rygGjQ9PfqxwWj0xpFb+L?=
 =?us-ascii?Q?ht5uxJtpJPyuyjsJT0LdxYlKhpqS+FaLAsiDmyM1OQCNPf1xDI7GGFBDo06Z?=
 =?us-ascii?Q?WjmfoBpHMXd/O3jztNEUdjjVlczHl7iwsQD7Eo03UMA3V6PTymCECe46YugY?=
 =?us-ascii?Q?08urRBljmX+K+iY89mBbbbjzgx87s1pFMF/t9ygjPG2kZdhJ9vhroYuz0vAL?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05531dc-b692-4457-aaee-08da5ae86abb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:32:29.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra289mnkc/A+pBK/NhqcMfjT8HFcjEtZ1qZ+5TzXQfoBRj0P8VTvOXMp8LSC9iR8g1HHAHE6x4hBk5fE2tyUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an appropriate SFP binding for Trust Architecture 2.1 devices.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v4:
- Split off 32-bit changes into their own patch

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 50a72cda4727..47ce525e0a72 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -271,6 +271,14 @@ rtic_d: rtic-d@60 {
 			};
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		sec_mon: sec_mon@1e90000 {
 			compatible = "fsl,sec-v5.4-mon", "fsl,sec-v5.0-mon",
 				     "fsl,sec-v4.0-mon";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 21200cbf7161..57b87aea390a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -383,6 +383,14 @@ sec_jr3: jr@40000 {
 			};
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1043a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 0085e83adf65..4fd71f6212c5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -413,6 +413,14 @@ bportals: bman-portals@508000000 {
 			ranges = <0x0 0x5 0x08000000 0x8000000>;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1021a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		dcfg: dcfg@1ee0000 {
 			compatible = "fsl,ls1046a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x1000>;
-- 
2.35.1.1320.gc452695387.dirty

