Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDD851E4AF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445737AbiEGGuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444371AbiEGGuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:50:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E035A2D4;
        Fri,  6 May 2022 23:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjQTdsU1kZQf/7eS/UZYK7aVJN88rIiXzMv9v21xwtJCjCt59L6/oUF7aAAM/NFD+yZDjx7XEvSzqHsdTTF8gKLIrbgXak5OIi9+TXeLl/S1gmK4d29+1clRwmPrOPxViQOVQBio1WqnSL0nR+DvNyx6UYZk5VPDwLBLu6dxTjj+dEvfrx2tCADQRMkq8zRfuBmcVizRIgZSp/HIszhkm4DQBP+zXoaI4oAqUaMXTS6ElLCqPkYZtvvhuGiXCV8BlkLdGu+PyMKgR1+KbhnblkABpggk84apZ3pOy3vpo/r7F02Nqt+TMobfcU1MBayFMxKJ4DIZo4D2azeYGUwliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ffDtCAWESjqhzjMY9KPWsLSLxga7ZOym/fJePA8ScQ=;
 b=RuywuuContgDc0enTaAfrENWE7HApUfMz9V+dWTU6HqAnNQgEDZT7H2zIghqV3VdQoIFC/vaZYwVH0u6bOpj8t1aHRi415Ye2n93uWaNrg7vqrD3a2BTWY/ic73Y10enDKzYnM8CcfafQ1IrccL+x0FndqSYngWjwhs29NNS2QglCMz07cRq7HKeXNulYqY7Zk9SONIPuufDngXcaBaPhadakB9thzJgJ1bau9r64JmqFy29nIvurcG0GyIZ9oL+ZjlFmZdpLQUJ7x6SUiNgCpo1lPPUaQGdlo8RXmTR5jn9CCtX7riGiw5iAshe8YP6uc6mTS0TnAHVzt2AQblN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ffDtCAWESjqhzjMY9KPWsLSLxga7ZOym/fJePA8ScQ=;
 b=dUxQcespy+L20+GooEAS3V0N7Hb9GX8SPRmJ1oShzvyiWa1XAj0RII9mZdNy28ADMIOcnHnLRzuKExg0USMZvAqZqcnwYKl8HtpzIFlLrTqSWYUnxk6WuAB+N/su+bz4AuEcjn7NijPXirodtC60dfLs93gnG4aSia1E9GvjNKs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2527.eurprd04.prod.outlook.com (2603:10a6:800:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:46:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Sat, 7 May 2022
 06:46:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 1/3] arm64: dts: freescale: Add i.MX93 dtsi support
Thread-Topic: [PATCH V2 1/3] arm64: dts: freescale: Add i.MX93 dtsi support
Thread-Index: AQHYXulJXLH702QE2Uen3kTORawBGq0P+roAgAMDZFA=
Date:   Sat, 7 May 2022 06:46:16 +0000
Message-ID: <DU0PR04MB94174452A46F14A5C0C1813F88C49@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
 <20220503122951.4147636-2-peng.fan@oss.nxp.com>
 <20220505084404.GF14615@dragon>
In-Reply-To: <20220505084404.GF14615@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5547f9fa-fc02-4d7f-8b73-08da2ff5490f
x-ms-traffictypediagnostic: VI1PR0401MB2527:EE_
x-microsoft-antispam-prvs: <VI1PR0401MB25273FF48C8B47BE95095A6088C49@VI1PR0401MB2527.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ee3rdIgUDj9Df3XXdt0HLFHnoCr6q0RXjr55tWZlvyPEOD99Hy+f+lwSF6B8z6Oilt8uqeI22xNsRFQflvCtAGpqxrL0thiICnEA6TW3zjXibvHjH0NJA/XBTApUhuLaAh5A8qBG5eZHVghhIM01VDudoks3OCYe4J4w7rCyHPJCq/2izhvZ+7iHHmf80S2+aOcj9GGC2EatAHB+gPtv8xHVsgtVoQUSBTnt3lXchyJSn9b/kdHgm/mAxOAegKl3SL6+5r0cxz/kC3nPENGZZAY3e6DIbXiG4DOIWfX5hbysX7p8CQkLSRT/JmvAi/Jrd5/sGdG4sOUrfgjc/6jf0OxOtFFluoliaehDSLFnagEhYgn3W6bYrUVnVyEZQxeX5cCl3QhCLkkjiIFz7JbobvdqD8vAFVM4pJv3K3HOhYdVYBiL5i8hqy8bzyFqeDg31Tx+v6sImFDPtmFEfyrlVlesgCZcXhmGOjqam8ghdvxzK0yN3XuaxWORvcdgDZmhw2jdEh8ZEBzA5UeW5NupuFw1vbOxfqg4lxCFEJ9MYWg3vOIyjQ5EvvO/y2qZ9oZ6bWNsjC4nQah0Buw/jXugSFW+VMPUM1vLSoHkFCk/FXCaz3+uPIs0APb4s4o2ZUnVZek7ldbztzMOwh7SXspvVSs4q7pLaNF0x1dXPRjPlBI2LlriG3YG1HwdeQEtPSIGiHIbtrmFduHRswjv+ZQVTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(122000001)(2906002)(55016003)(52536014)(110136005)(30864003)(54906003)(44832011)(508600001)(38070700005)(316002)(83380400001)(8936002)(5660300002)(66556008)(66946007)(66476007)(66446008)(64756008)(8676002)(4326008)(86362001)(76116006)(186003)(38100700002)(9686003)(26005)(7696005)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r0s5XsVsP4dqvzbvj3uaHEmEwSa5DAXt+lYbIkTbF9E9eQZLBiPykgRW6hyU?=
 =?us-ascii?Q?6pp5i2OyjXnr18yUrqzptvk5SMZyb90iqM18MnqxNgJ4bkmc0Z0Q7RPFdqnh?=
 =?us-ascii?Q?O0jx2+7bG4Im2+VHqA6FmgHJ6pkEHe9qS8N5nkKx3lJioc6jXEotmCaLifHf?=
 =?us-ascii?Q?VVsufceFkVq0b8me2yxGu5/dc3QVETKjGLNs5AwC5C9w6nQFgsKfhpckBP6b?=
 =?us-ascii?Q?En163+eSLpURTykgKaFl6NveVtYOIbtEHglQywGwy3Tx+UxcqoQMRHBC8qM0?=
 =?us-ascii?Q?mc47kcyh8UFTk+jlEdffI3NuxeutsHaLa4TX3u4qAEe14OktKEsVslBkjNtm?=
 =?us-ascii?Q?MbWT/l8tlJ46y4O2FY46VkO/YIvFCz+Hcg3Q7D4nmXQVeL/uUa492boQW67b?=
 =?us-ascii?Q?z3WcenGwEwiz20IkDf0QlHy2+sGCI11awhtUTwJvjT9cOssZgo/h4DuGWOtk?=
 =?us-ascii?Q?iSpvETxEziArmECiGPTZybpG+ZGhaalU5TzhBJhfckR4N7Xg/x3Sepb7smRg?=
 =?us-ascii?Q?BAKLTb5+CrafgBkXX8UGUvzGcxy6bKx4KToM1qpBLqunpYe0bZjoVZIDRLhp?=
 =?us-ascii?Q?SOvOFjrOGjzpVgu0pcm+2NaZ4hfwyjS7Nrht8Ph1ftSAEw6eYGzbvuusGTYJ?=
 =?us-ascii?Q?go3H6lYS1PQ2N8KYrLxSoE2FC5TdWkYkLFd6NVAcXsqyzU1egJYuK/EiedxD?=
 =?us-ascii?Q?pnjiJs1TVSaee4kHHiibH2eMFQ7+MZqJ8CkmIwejsSdU9vOqCOQ6xIefbkQj?=
 =?us-ascii?Q?2WsfZMDF0GuzTvUcBN0V75HBEEAUZegkwFcDm+C3hlFILPaTu9iuDZmMWBSV?=
 =?us-ascii?Q?oaVBwRg3uZSYmcZt14ymFwgB8mwfdWRIcMajV9TAWliGJ6CFvX3LRD43fWsy?=
 =?us-ascii?Q?t9MQR/KUm8ZwIWJ9PAxXzPDShPfPjWixVAPUbIsjyZQig3pvoNsu3wfp6Wde?=
 =?us-ascii?Q?Ob2+HGQmVQZPHW0VLOPRG4HJCCuZNt6r72Bem61v3+v5UQO5gPzeSZ2ofO5w?=
 =?us-ascii?Q?XSJWikLeGoDyR1qlDh6M0HEzaXOH8ZrAfVxliEmzsnIX4k9qxi5H9FEpJWkq?=
 =?us-ascii?Q?78R4hE8TpWABhnT7MqR1FgXcUESHyrftAnxB1Yd+QYveZL0qGRByN8qHxGlZ?=
 =?us-ascii?Q?xfCfXSQ08HrMJs/+m5WXMbvV35ZNGRIHsUew+OZx4YnwxqytdPPl0hcYAOCz?=
 =?us-ascii?Q?AwZ9Hh0UpHZuNB4TrU+o6cjzk4o9ezNGjOOEt5kwVsWDRpKRg9yerB3EiYgb?=
 =?us-ascii?Q?59WIdEFQyVcIic6iwW45bI6UzMcjVLfoXAa5QAbjQNU8xU0n5RD4VKyCvn7l?=
 =?us-ascii?Q?jQaeW4UNd8edv8goO4E+j2pKsTXUYAqs8Qu8IPAuuuDpSI6qksoqG5jpGG6n?=
 =?us-ascii?Q?J3etGNpR+Oss7oDcWAl5qdaA2u71bBRwrGuZ0mlIrYkRPxcBhVSJAXd12KId?=
 =?us-ascii?Q?KokuoT1fdOBQOdZ6W6i+ZK3pPif7xU+1GLbcY4aYP2ryLuKQzPksSfLd1WUJ?=
 =?us-ascii?Q?6fjWpDp4FvZ1EYRaLR92oLG/obHmRYECw4OPxoMWp5B2MsPBwvyhfOEARiM/?=
 =?us-ascii?Q?ubJ8GfzhHzADpfQ0jAGzWCo1Q1HQ2nMM/kqYnO4gbMq9nBz+WuXzlenzGsHO?=
 =?us-ascii?Q?0xDrjSjFW4izPBfbPBmaNNEMHOW/JcOyXlEeOc7y4eCTfEx7/aF012KZ51oW?=
 =?us-ascii?Q?gm+PaJ9SjVLqCQoCwgYRFtDNeR18oay+6bBJzDsKMFgEKG9ZR86bday8GOe7?=
 =?us-ascii?Q?Wi45Hw0ZEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5547f9fa-fc02-4d7f-8b73-08da2ff5490f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 06:46:16.5438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rt1+2vGN185okoA3coKcH9nOIOYCwDurFrFo5skvcsW9H8vm9m0rS6TMxWrQgLsnTSBuDLlZ8acuxBHklaIwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 1/3] arm64: dts: freescale: Add i.MX93 dtsi suppor=
t
>=20
> On Tue, May 03, 2022 at 08:29:49PM +0800, Peng Fan (OSS) wrote:
> ...
> > diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> > b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > new file mode 100644
> > index 000000000000..ae8daffe3492
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> > @@ -0,0 +1,337 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2022 NXP
> > + */
> > +
> > +#include <dt-bindings/clock/imx93-clock.h> #include
> > +<dt-bindings/gpio/gpio.h> #include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +#include "imx93-pinfunc.h"
> > +
> > +/ {
> > +	interrupt-parent =3D <&gic>;
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	aliases {
> > +		mmc0 =3D &usdhc1;
> > +		mmc1 =3D &usdhc2;
> > +		mmc2 =3D &usdhc3;
> > +		serial0 =3D &lpuart1;
> > +		serial1 =3D &lpuart2;
> > +		serial2 =3D &lpuart3;
> > +		serial3 =3D &lpuart4;
> > +		serial4 =3D &lpuart5;
> > +		serial5 =3D &lpuart6;
> > +		serial6 =3D &lpuart7;
> > +		serial7 =3D &lpuart8;
> > +	};
> > +
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		A55_0: cpu@0 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a55";
> > +			reg =3D <0x0>;
> > +			enable-method =3D "psci";
> > +			#cooling-cells =3D <2>;
> > +		};
> > +
> > +		A55_1: cpu@100 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a55";
> > +			reg =3D <0x100>;
> > +			enable-method =3D "psci";
> > +			#cooling-cells =3D <2>;
> > +		};
> > +
> > +	};
> > +
> > +	osc_32k: clock-osc-32k {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <32768>;
> > +		clock-output-names =3D "osc_32k";
> > +	};
> > +
> > +	osc_24m: clock-osc-24m {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <24000000>;
> > +		clock-output-names =3D "osc_24m";
> > +	};
> > +
> > +	clk_ext1: clock-ext1 {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <133000000>;
> > +		clock-output-names =3D "clk_ext1";
> > +	};
> > +
> > +	psci {
> > +		compatible =3D "arm,psci-1.0";
> > +		method =3D "smc";
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) |
> IRQ_TYPE_LEVEL_LOW)>;
> > +		clock-frequency =3D <24000000>;
> > +		arm,no-tick-in-suspend;
> > +		interrupt-parent =3D <&gic>;
> > +	};
> > +
> > +	gic: interrupt-controller@48000000 {
> > +		compatible =3D "arm,gic-v3";
> > +		reg =3D <0 0x48000000 0 0x10000>,
> > +		      <0 0x48040000 0 0xc0000>;
> > +		#interrupt-cells =3D <3>;
> > +		interrupt-controller;
> > +		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-parent =3D <&gic>;
> > +	};
> > +
> > +	soc@0 {
>=20
> Why do we need unit-address '@0' here?

I follow other i.MX dtsi, imx8m[q/m/n/q] all has it.

>=20
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		ranges =3D <0x0 0x0 0x0 0x80000000>,
> > +			 <0x28000000 0x0 0x28000000 0x10000000>;
> > +
> > +		aips1: bus@44000000 {
> > +			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			reg =3D <0x44000000 0x800000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges;
> > +
> > +			mu1: mailbox@44230000 {
> > +				compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> > +				reg =3D <0x44230000 0x10000>;
> > +				interrupts =3D <GIC_SPI 22
> IRQ_TYPE_LEVEL_HIGH>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			system_counter: timer@44290000 {
> > +				compatible =3D "nxp,sysctr-timer";
> > +				reg =3D <0x44290000 0x30000>;
> > +				interrupts =3D <GIC_SPI 74
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&osc_24m>;
> > +				clock-names =3D "per";
> > +			};
> > +
> > +			lpuart1: serial@44380000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x44380000 0x1000>;
> > +				interrupts =3D <GIC_SPI 19
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART1_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart2: serial@44390000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x44390000 0x1000>;
> > +				interrupts =3D <GIC_SPI 20
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART2_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "okay";
>=20
> We only use "okay" status to flip "disabled" device at board level.

Sure.

>=20
> > +			};
> > +
> > +			iomuxc: pinctrl@443c0000 {
> > +				compatible =3D "fsl,imx93-iomuxc";
> > +				reg =3D <0x443c0000 0x10000>;
> > +			};
> > +
> > +			clk: clock-controller@44450000 {
> > +				compatible =3D "fsl,imx93-ccm";
> > +				reg =3D <0x44450000 0x10000>;
> > +				#clock-cells =3D <1>;
> > +				clocks =3D <&osc_32k>, <&osc_24m>,
> <&clk_ext1>;
> > +				clock-names =3D "osc_32k", "osc_24m",
> "clk_ext1";
> > +				status =3D "okay";
> > +			};
> > +
> > +			anatop: anatop@44480000 {
> > +				compatible =3D "fsl,imx93-anatop", "syscon";
> > +				reg =3D <0x44480000 0x10000>;
> > +			};
> > +		};
> > +
> > +		aips2: bus@42000000 {
> > +			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			reg =3D <0x42000000 0x800000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges;
> > +
> > +			mu2: mailbox@42440000 {
> > +				compatible =3D "fsl,imx93-mu", "fsl,imx8ulp-mu";
> > +				reg =3D <0x42440000 0x10000>;
> > +				interrupts =3D <GIC_SPI 24
> IRQ_TYPE_LEVEL_HIGH>;
> > +				#mbox-cells =3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart3: serial@42570000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x42570000 0x1000>;
> > +				interrupts =3D <GIC_SPI 68
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART3_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart4: serial@42580000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x42580000 0x1000>;
> > +				interrupts =3D <GIC_SPI 69
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART4_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "okay";
> > +			};
> > +
> > +			lpuart5: serial@42590000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x42590000 0x1000>;
> > +				interrupts =3D <GIC_SPI 70
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART5_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart6: serial@425a0000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x425a0000 0x1000>;
> > +				interrupts =3D <GIC_SPI 71
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART6_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart7: serial@42690000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x42690000 0x1000>;
> > +				interrupts =3D <GIC_SPI 210
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART7_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +
> > +			lpuart8: serial@426a0000 {
> > +				compatible =3D "fsl,imx93-lpuart", "fsl,imx7ulp-
> lpuart";
> > +				reg =3D <0x426a0000 0x1000>;
> > +				interrupts =3D <GIC_SPI 211
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_LPUART8_GATE>;
> > +				clock-names =3D "ipg";
> > +				status =3D "disabled";
> > +			};
> > +		};
> > +
> > +		aips3: bus@42800000 {
> > +			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			reg =3D <0x42800000 0x800000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges;
> > +
> > +			usdhc1: mmc@42850000 {
> > +				compatible =3D "fsl,imx93-usdhc", "fsl,imx8mm-
> usdhc";
> > +				reg =3D <0x42850000 0x10000>;
> > +				interrupts =3D <GIC_SPI 86
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_DUMMY>,
> > +					 <&clk IMX93_CLK_DUMMY>,
> > +					 <&clk IMX93_CLK_USDHC1_GATE>;
> > +				clock-names =3D "ipg", "ahb", "per";
> > +				bus-width =3D <8>;
> > +				fsl,tuning-start-tap =3D <20>;
> > +				fsl,tuning-step=3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			usdhc2: mmc@42860000 {
> > +				compatible =3D "fsl,imx93-usdhc", "fsl,imx8mm-
> usdhc";
> > +				reg =3D <0x42860000 0x10000>;
> > +				interrupts =3D <GIC_SPI 87
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_DUMMY>,
> > +					 <&clk IMX93_CLK_DUMMY>,
> > +					 <&clk IMX93_CLK_USDHC2_GATE>;
> > +				clock-names =3D "ipg", "ahb", "per";
> > +				bus-width =3D <4>;
> > +				fsl,tuning-start-tap =3D <20>;
> > +				fsl,tuning-step=3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +
> > +			usdhc3: mmc@428b0000 {
> > +				compatible =3D "fsl,imx93-usdhc", "fsl,imx8mm-
> usdhc";
> > +				reg =3D <0x428b0000 0x10000>;
> > +				interrupts =3D <GIC_SPI 205
> IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks =3D <&clk IMX93_CLK_DUMMY>,
> > +					 <&clk IMX93_CLK_DUMMY>,
> > +					 <&clk IMX93_CLK_USDHC3_GATE>;
> > +				clock-names =3D "ipg", "ahb", "per";
> > +				bus-width =3D <4>;
> > +				fsl,tuning-start-tap =3D <20>;
> > +				fsl,tuning-step=3D <2>;
> > +				status =3D "disabled";
> > +			};
> > +		};
> > +
> > +		gpio2: gpio@43810000 {
> > +			compatible =3D "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> > +			reg =3D <0x43810080 0x1000>, <0x43810040 0x40>;
>=20
> 'make W=3D1 dtbs' gives the following warnings.
>=20
> ../arch/arm64/boot/dts/freescale/imx93.dtsi:289.24-299.5: Warning
> (simple_bus_reg): /soc@0/gpio@43810000: simple-bus unit address format
> error, expected "43810080"
> ../arch/arm64/boot/dts/freescale/imx93.dtsi:301.24-311.5: Warning
> (simple_bus_reg): /soc@0/gpio@43820000: simple-bus unit address format
> error, expected "43820080"
> ../arch/arm64/boot/dts/freescale/imx93.dtsi:313.24-323.5: Warning
> (simple_bus_reg): /soc@0/gpio@43830000: simple-bus unit address format
> error, expected "43830080"
> ../arch/arm64/boot/dts/freescale/imx93.dtsi:325.24-335.5: Warning
> (simple_bus_reg): /soc@0/gpio@47400000: simple-bus unit address format
> error, expected "47400080"

Fix in V3.

>=20
> Shawn
>=20
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			gpio-ranges =3D <&iomuxc 0 32 32>;
> > +		};
> > +
> > +		gpio3: gpio@43820000 {
> > +			compatible =3D "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> > +			reg =3D <0x43820080 0x1000>, <0x43820040 0x40>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			gpio-ranges =3D <&iomuxc 0 64 32>;
> > +		};
> > +
> > +		gpio4: gpio@43830000 {
> > +			compatible =3D "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> > +			reg =3D <0x43830080 0x1000>, <0x43830040 0x40>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			gpio-ranges =3D <&iomuxc 0 96 32>;
> > +		};
> > +
> > +		gpio1: gpio@47400000 {
> > +			compatible =3D "fsl,imx93-gpio", "fsl,imx7ulp-gpio";
> > +			reg =3D <0x47400080 0x1000>, <0x47400040 0x40>;
> > +			gpio-controller;
> > +			#gpio-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <2>;
> > +			gpio-ranges =3D <&iomuxc 0 0 32>;
> > +		};
> > +	};
> > +};
> > --
> > 2.25.1
> >
