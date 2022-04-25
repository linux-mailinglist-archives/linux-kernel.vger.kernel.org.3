Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78450E200
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbiDYNip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiDYNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:38:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE86BE11;
        Mon, 25 Apr 2022 06:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgROMAGUp2oe/gaJgb7HIn9pUPYaBM9LlTO3dkrxeovC67YcgEJVb4rVCzdsROpEXnioueTdPVQw0JcJZrMs2QwIQEO7Sx+u8hJ8Cws9iold1sk1H9ABH3PUNL3Lel1j9ibNfLJEdbCqQvOxTn48ws1P8Zi2/sOdiIGHoIAO0iMflGQ5ggeDxn0bl4X3jmCgwBQtwHh+omoy5eOrWYoZo3PASqH5qQunbJQ9brl4hWXlhcEJRQZ9zm3t2oVz0MoGytP/U23o5MqXnKMvu4WiwOaQd8zfnyaVUe7E56u9dOK7SxxzzC26iJl1tIE1u6zNLjAWE9zwPhryToakCv3M1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNjk/sJVMNDyNAtuusAVsTQao7AN3oXbaKGGRULsYZU=;
 b=Reyp/Hn9fqvHd5e/Lfyl7Kw/flk7T0/h3jKYfFAdd+bxS4q7bb0SDWHQ+P78czC1bSQDoHiC9NgNZ59zTzrgCVfmceTy8DbX8Dnt3nOB2kVldPujaGjmb/LJ64E9F6YOWyzXBgStU17ZtCOQBQA9FZuSXkSlGm1JIdPEluWptNzCKcMb1RQBOtiD48PpQ8gBOCwGuIrfwsV+e93QNsaLpSJ/yMMPxrenFWboT4EzEyWb0gVtiVU7PIJtrdQG8BvhGdHNqEVBhucdUWbjyNd3X2HGBg/8WHIAL4Lb+EM/nVPMHyaxyS+MO3FxWRuKB4/4065uTqvsIxLtEK8C0WKCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNjk/sJVMNDyNAtuusAVsTQao7AN3oXbaKGGRULsYZU=;
 b=MT36qu+VKzw3lhp7+Dg9xePnKuXLcGg08C830ZtDeBYcHY88vrbLlts0kv2d8YnzqbWOLbhk9xCiSXD8hnL+owwaTm0pXNJL/2K3kXr/kZjLUxUHDUHMz0hg8FDEknLbNS4YlSSzMG9B3BTymASEOiTxsoaPLAa4oX1bsPY6ubE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AS8PR08MB6453.eurprd08.prod.outlook.com (2603:10a6:20b:31b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 13:35:19 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 13:35:19 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 3/3] arm64: dts: rockchip: enable usb hub on the radxa rock3 model a
Date:   Mon, 25 Apr 2022 15:35:02 +0200
Message-Id: <20220425133502.405512-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425133502.405512-1-michael.riesch@wolfvision.net>
References: <20220425133502.405512-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a87497a4-5bca-4503-62b9-08da26c070a0
X-MS-TrafficTypeDiagnostic: AS8PR08MB6453:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB645306A3AED48AE31BDB1F9EF2F89@AS8PR08MB6453.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDVuIaILeGV3lojyAgJ9lFQrBep+g/63zvpXdP/LQWAAHmEWO1tpPWWOIwztx4+6GpjOqN6ir4iNZ1zrUHHQUr6WL3mx+2bFOZAHwbraM1MADokQ5WJ7mrAboBKEgw820INFxcP40e+OOphJvVnCey6F4Gabgf3cveyJJqAVrZy7QZyYetYzmxERaz9jYy+uXpue/7CzUcM/ibML8diuInZteqbwmzCpCFr8P+PJ0biQNPXxPmAj0ryyXev4r9xUHoF3oktGXsl9AenSN09anWxw9/tbRkjWpt5vBNmj/wwypVsio2XVkasW5lesyejRyT7wfJKiWzecATbVuH1mp3GDly0jdnekh8pkaSMvM4ReOuY17cG64kyegO2sI+li8m0A9YgbWZPqNe81wquZkCQJP1cBmef28yYubtfA/bCeIMVz1/TbO0hdv/83uGaINYIc5ZYkjRFakIoSTpAKTbc2LY427sUk1jl2en3XFntIvBec8xexT7FXEWZDkJyIhoxvWmBz6AhvSBz2o+MGFXNL4aogrPMaJFZYwgWwYNzrdiRjK3BVbwxI0JgolRCWKEeYsbeFDW946BQd5mliSbG9k898vxQ3ILBILE3/DNtJfISzxozUWNdJURPAJnN17SueDBxaUAVhHYZQlua+2PD2/YJh5HvbMNIkxhj5dekKt7tokHrkfV1wULlVUHr0wxnHX5f8kuej6Og7At/2yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(366004)(376002)(136003)(39840400004)(316002)(2906002)(54906003)(508600001)(186003)(44832011)(6666004)(52116002)(36756003)(6512007)(66556008)(66946007)(7416002)(66476007)(5660300002)(6486002)(86362001)(8936002)(4326008)(8676002)(1076003)(6506007)(2616005)(38100700002)(129723003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vfp+rkTC6o67guAd+lAFI+QoIEQoF9wTAgQ+rtR1tytaKbJ3eJISQkB7MS31?=
 =?us-ascii?Q?UYFARapsnCAhVMlfGJFwgXKZkwx5ED0S54SlEszVtd79Vr8lvEUHXIVV34kW?=
 =?us-ascii?Q?b5vVwmTXZ7xktqve1yfC41juKypYw43fZKv6R9ubD6bXAr+VMPwttqGg8gog?=
 =?us-ascii?Q?IoFOqp1zHESfl5iXH8/ckBYBWZc1lt4kNRYkWzanrWlpt07FPdvjQFQFlqLD?=
 =?us-ascii?Q?HN2KBygaLhgvwm2uSRvBhIHJ6bw+3UVNWI3pJ8hzUQ4zYNTrAPvwn0oAG7rv?=
 =?us-ascii?Q?HMqOBZ4tKMAc0wZZLUyc4Yy3Zu4ddjLEXDeUsVVL+zOPkZwb3AQ9IpJDsMXl?=
 =?us-ascii?Q?2AMhXkf/1HoXMl3GJLJOBIo1j1QesDZyklYPrJWDbP6ZYBQNQi3pxKxWyY6V?=
 =?us-ascii?Q?RmO/8RBDqBHtdWCrBHWVXKKYsE0Fr4yCQ3qnkKYGtBrPjCgyz8rmIe/cKOep?=
 =?us-ascii?Q?4er0zLPVM6aG8a5l3pOw04U5Z9mJ9Ak2B8BVKGxyD7VP0tdd0m450kC3yuYT?=
 =?us-ascii?Q?J8RfM9xZ2/bCgvA8psqKsO/fwinRlvJhE8nXjUocYyKukyITjMUN673qCjXg?=
 =?us-ascii?Q?OhzORnQ6BL2cDA3msyTbaRPF6mvawA9ZbMDL/LRBvB2YvNAfRQmsGxHN8/ar?=
 =?us-ascii?Q?AXixP7KHN3rbtjJiT01kMhCdCR43vPUNQ/bxpFVSBZ5yWiHfYgkp0AkdAMiu?=
 =?us-ascii?Q?8LR/fEe4P4slSpQy02vfY+4ZAAbNRMdLEqTpg8BBd1hsEEONSUXhz1HKzYo5?=
 =?us-ascii?Q?S5hvruXW7TuqI5cK96KZyakEDFN956VXEmn3sGteoNLHOjpXKP9QS9fyRK7l?=
 =?us-ascii?Q?0kVIBrq5LE5ZbWJQ1PoPTZfku2xb3nRW/JlW3ZdczV18L6y/oTDcyaJZ5ytC?=
 =?us-ascii?Q?C2b/t+bkTmGa46guJPVkrF/CAvs748bo0f5LRPN1ztMhmxQikJ7L8CkOaPSI?=
 =?us-ascii?Q?AODhbRnr5CEp2mPwVw3jdFzo4ZtJLdNVjrtAdJo3f934mW0DhALFA+OoK0xh?=
 =?us-ascii?Q?F3ToH4TuqbtaP5ZW/+CjxWm/YgzIzH0pQUq0INud6fmToDjv3Heq2YqtX4BY?=
 =?us-ascii?Q?b4gExiLCgmN5BpLUonqKUKDdsX0DB3lOERCmztGetwUB9J3nmSdCwLW5n89/?=
 =?us-ascii?Q?YoMFpLFDWx8rOTpgIwMlyrqqvD9iw960ehmu6HKvAHVdV7aoY3Uf386Lyymr?=
 =?us-ascii?Q?K7ZokXLiUkXXW3JJXFBmgrudcc8j8GprxqWUB3xacYeQvznVDQoKyX+uTHTs?=
 =?us-ascii?Q?X44YViAslTNSmvV18gOkcZACX6PdNnGs84L28bOWUFrt+DIr8PubzocuMOGF?=
 =?us-ascii?Q?Vs4xDviDJYLXXqZmc1Un/V7B8LsX+NfbhaipqaZBBdaEx+GsGW2WydTxVo9P?=
 =?us-ascii?Q?QZBKtbFvh9AkIkK1CDovYrmjaqxmdFEWkllAVa8yb3arO8bTfRKHaKliiRs5?=
 =?us-ascii?Q?84X6dY614uRrhHgnNAnqo2A7XWxjtTlHq8Gnv9HPLq90XRn4sr48amR4UhQj?=
 =?us-ascii?Q?pYWmd6KXynppLamg0p7sKRXO4o64kQy6jadtSAXzdbV3mdxeRvHcOUCW+4Rt?=
 =?us-ascii?Q?tV6j2TjAaboGn0ferm6U/q9jfShIY3qMWZPx4E2gk48xVtgOmmo4/ame65PL?=
 =?us-ascii?Q?be863xVTIwAxefnRwtr7G6od/AsGp9WKbTQrQsYnzkTsrs7NkC+6z2stbd/j?=
 =?us-ascii?Q?DafTZLWcQ1duw0LwcPF0YGVJnUk1JoIaeHjeffGGwBWbip6YFBUkMJtGzkTm?=
 =?us-ascii?Q?20qKUI1uylW1F2FQTAaZRDiFFswCKq5/Sj+/RsuonIgh7fOXuvjKvXi/g71H?=
X-MS-Exchange-AntiSpam-MessageData-1: TvQGQ/EY+qtjII6cgc9bQoTtMlUoRbgPgx1AQ2zXC4O3VL6JPkm2LSPW
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a87497a4-5bca-4503-62b9-08da26c070a0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 13:35:19.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvYhs+eiM7Dobsf8oh5PfQMnNmn9g/dAZwQD2Faoaqb2owixK3yVLqvZ6h1hx5s8vt7TsP9e3+ueOPyEcuY1JpfGrEekV0ATiWJbfQu0EY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One USB 2.0 host port on the Radxa ROCK3 Model A is connected to the
SoC via a hub. Introduce a voltage regulator to enable this USB hub.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index d7e2bc96fde7..75bc2824764f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -97,6 +97,17 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_usb_hub: vcc5v0-usb-hub {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_hub_en>;
+		regulator-name = "vcc5v0_usb_hub";
+		regulator-always-on;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc5v0_usb_otg: vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -436,6 +447,9 @@ usb {
 		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		vcc5v0_usb_hub_en: vcc5v0_usb_hub_en {
+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
2.30.2

