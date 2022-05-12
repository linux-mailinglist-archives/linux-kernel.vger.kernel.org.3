Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03427524575
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350204AbiELGOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350185AbiELGOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:14:49 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2116.outbound.protection.outlook.com [40.107.113.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC3512FECD;
        Wed, 11 May 2022 23:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUvaOJzT/wj+7jJmxIUPqgTlGn6F+lSSBhaKiKaXc6Oe0eJu7VAxiqJO83QVX7AN5+R65YHDtXAFntML4+bM8mfcKNutCViHrmd8BN9EYytc59SwgUS8TZ0Y5Jbtbf+oybCUbalALTIdAy/yNmdzIsn+c8eH+bAzclDvX5bsKQQZg54Gh+TsgWl0uewOsYndh2sEt392rF0SWtQNEBtD0S8pJPBK9t6G1fpKT9onwTJrA4zQGCxM2H8xw8biJ93J9OyKe6CUJD/9OK4MPTguC/u+ySk5cXsltdDhY/m6+ru0ze/WVDaYLZ23uhhls484x4GHAmH8SdV62Ef+/kRk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdRyjwkyAOtkR2+QXrbeawkUfZoiJ37238QatM1+jH0=;
 b=SHVvGL1ujmNgMKuGPgeH0Ou+wEg2HXkB4UEosQN6BwzwGH0jLIVccnqFe6p0XOVY2Gk3+XGmeYavRctutCU1lVUdKzx8zZoSKXNQ4GHpFW0wwOvAD9ocpR0tuGLCPJWMqO5zCR4T8PTquyVBC+zqmVwgvoWHPwwcoefTdJQT/h40Krur89RScUp9L6IT/+mGvniOKE/1DPN703tU+gzVAAPJT0KGx1LP5YXYwaEhUDaf/H6yv5of6rDwwxVC+YXJbZUGg+UhRHG8L9LnorN/OCnBTay7PR9C8aISv9ueFj057x/9ASnqy1krrCXpn0aPBv8bswB0gnLEb+voa5xhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdRyjwkyAOtkR2+QXrbeawkUfZoiJ37238QatM1+jH0=;
 b=Ki3b7Tb/tRYcCZaU4+bI+aA3WxxZAEEZ3HNa3Xwnco4RQn6Aq/Gvc5me0O83XAWS57ylsM9b77LDKYYlsL2J1HHsRwCcUaqer2YGY4iJCFtpVVugxPMsO6kQEP6HMcwpCLcOxaqofblBeREq6aXp5bZgJfM+LiVfw9tO2dxHPLs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7482.jpnprd01.prod.outlook.com (2603:1096:400:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 06:14:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 06:14:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
Thread-Topic: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
Thread-Index: AQHYZWV4RlAHbSsx30mhq1gAyZlRva0awo+A
Date:   Thu, 12 May 2022 06:14:44 +0000
Message-ID: <OS0PR01MB5922C1D739765D6308A1167D86CB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90a102b-cd6f-4b25-f27b-08da33deb573
x-ms-traffictypediagnostic: TYCPR01MB7482:EE_
x-microsoft-antispam-prvs: <TYCPR01MB74825281A630A94CAC93CEDC86CB9@TYCPR01MB7482.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cXgXpsDARQl1+VTQziFrB65DWKKA8RMLqAvv7qcrznuONRrbNQchWC9Tf0biFCvzSe0XTvvS/PWyume/hnJwqGGhtMMUfmbaCK0ido+9N/Qnp06Rfep3EAvrVAq2HvAGj+uXf3fbGqtLGo8B8pNDP4q8Jr3qUC+X5W47SmRBipgbQ+QBvsnt6Yw+Yj5xLEvi1LThSRTuDnU5VJe9MXy2QCr62AYAisNGjyrNBmOX7HIkgzDoXrh40qFJstB7TCzvOZL7syKzvGn5AJAbalMDdpjSYthPLTj16FubChsUxahgqDBJDeTd5aRJ8hxdYZezFTqJU3fUlaTS3La4FAkhsLr+sv9qIU7lx+lF6eq4I9dsKTwQJ8mwsushResAcXsFPQhKYrXizD4ABJGW2H/NaitrxwlCIxap1kQvJpEEtDb2MSGoMnjA7NiwfWes8vNe5p+TzXB2TFivlC+9N/IW40MGPkzCXaUZ8tuiX/1CJq0MFtGhS+isYn5rd4N10mD8AfRIykXNl7k9kLycsnXfOGZeX5AQVnMvXJ+0swHNzlpDkCrMKcHTcrCjFZqpJFquSoptl4OCprW6QgNNQFGzHjRkDMmxNQo8DedyOdu7iofd9iOZQ80OtJK8jGhVqjETdRk/7+VPYcY9WuP3TXYG5mowbD7xZBHVrx6AFA/L4AAlKiKskllqRH+IZREh4n1deN0oYR6EKLrSQg0kA1oHqFwKVjLZI0YKERo4CGMpmdQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(66446008)(6506007)(26005)(33656002)(2906002)(66556008)(8676002)(38100700002)(122000001)(921005)(66476007)(76116006)(8936002)(508600001)(66946007)(86362001)(186003)(7416002)(38070700005)(64756008)(55016003)(4326008)(110136005)(54906003)(52536014)(7696005)(5660300002)(71200400001)(83380400001)(107886003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0iVfJ5KDNNRNYXgVjy3Fpfb42lURYLvNy6vTJt07OdE/T0kBA8k1bo1ORpTS?=
 =?us-ascii?Q?KxgebZjriHm0ShlK+XOuymeUzPLlzYROmZw5JDtSwbujJUuBJIcWGnr5OKQm?=
 =?us-ascii?Q?GFaLaLxHkdFA9Xqcc2xi/L7G5iT+R+BuyBF5xA5kMdSouU5TN9MWzwEiE3nb?=
 =?us-ascii?Q?fnDrnyYTN/1XG9m/O+89KzuFwO0arSF46VE/ZZOp9mDKttI1+GqutqE7as74?=
 =?us-ascii?Q?N2flFldImVEwYYebRfrSyQWiddH8WpJ8oH7fD/F1YITi8++HAi/pjwh6a/GG?=
 =?us-ascii?Q?aKIlpfVNovzejKLGNMSc1PCBg2SYf9PZ9NWuwkUxOPuUqURVKMrVO4Y9DAgl?=
 =?us-ascii?Q?5vLfiP9b/HonDoIiq2rQoOeEj1mRSf3/tE0ZMWhWWGP29a5+acuzpfZ4eOde?=
 =?us-ascii?Q?JyAZbj61nHEqmXsGPZ/pAVImSEb/FMVgK0+H7s5h4nBqfDhH1aMi+uU1YlP5?=
 =?us-ascii?Q?cifKtp2K6PJxIudWx2YlHG1ELJHfFBCy0NnEPELO99xjTNVTDVULLiiTphh2?=
 =?us-ascii?Q?Byspxn9Qnwxdm/UWGlrM4hqSG4C9SEq69hZjWCwk960XuFO9vwJe5iM0KCbt?=
 =?us-ascii?Q?e98u6JsQh3zjQfxsr4CiMxf/ZImZqffMiVe4Qu+AZqji3Jp49Omp0jyd0J1/?=
 =?us-ascii?Q?8Rgxgvji1hflzAWL0DpGDC32v2iQy1bgsWtfoZSoCbLBJilQ5zkFnpb7Fo2c?=
 =?us-ascii?Q?j7oJHO1yyLBUcoY00G5kgtxrjrOOWO6GsLvhL0y+R54pDF6rMlxgiVxLJzea?=
 =?us-ascii?Q?71k9EOErVCuyciN9Fz0nZxHD3JyLvkWtk35v7AZ0n2tBgLMOCQytcTC6+ezl?=
 =?us-ascii?Q?GRMit5XS/Uy0SYRFAmPT0FpT3scL9M6PdYBbp4pMc8Bkg2GQhs8aAvuMeRJ3?=
 =?us-ascii?Q?LoeYNfeyM5uIe2ILUA4aqpLpanL3SnnUcf/hL3ZsbhpOnVUB1Ehp6ljGTnSl?=
 =?us-ascii?Q?mHYeF8c2ID7GsjmAjMXK/Wifi1FBH2AdHjoat6mCol4nZ0jXD6P9df9e4nIE?=
 =?us-ascii?Q?TrugYenVvfuTvuw+MlFrxPCtHPOZl+soLoiIEIui9UlhyPprguc2fAMX2+qC?=
 =?us-ascii?Q?ElnVC8ofPNwMCq4ky70w4G6QQ2zfF7wdolY2XvlnwYb9jNtCbbjagG4x85Pi?=
 =?us-ascii?Q?2kvq4/E0XLqs/xjalahXB8l3j6/Rcdk9dmUx18l1VgaH2hTpRYDtnThyJFIb?=
 =?us-ascii?Q?QeLdNPDFjcTFaHh75wBMwy+1w1T7DVt1TX7MG3U/nTRpqGGUqQfty7FrqFGp?=
 =?us-ascii?Q?oZMPzJl7zYdUwUY0XIvkBUoqkYm8F6tplfxO02pP5/7+/iQWKarPJUdySe37?=
 =?us-ascii?Q?oZTWjFh+5+HrxwDQhLlJTDW+ydQ47jyVmxJQwuVBhh8dqd5ntHASX9m3p3qR?=
 =?us-ascii?Q?/z08eBiBFWbXfg16qgsCquLC1/1mRP/UOVndHpj6phoAlDOb7HSPD2leSCI7?=
 =?us-ascii?Q?TSJooZ3/tC8bfXpB5fjYabf0D7CpPAJbCd8VOT67GO5Veu6bZDI8kKapi/9C?=
 =?us-ascii?Q?mdArR8OW8tpQ1ilCFziDVAqlQ5hvqB1EWD2kxA6JxD7gl72dLgB9CTSi/dqu?=
 =?us-ascii?Q?4zNpbh9curNKoCRtquNEKhEs70k9rUOcydsqTvdRRFutX6AzahmOgW7Ymyyq?=
 =?us-ascii?Q?H+ByYcXAuO3eNwABD5Yk3wuLla56pSkuChIBnAFtZOIKR1uqDg3rb4Q2Atdl?=
 =?us-ascii?Q?8jD8A5AHqYFxXq0/qPsl43O1KovHbquU56pe2VZd0c1f17oqD3pFIkCe/Gt4?=
 =?us-ascii?Q?gjxPKj85NStPw8M8SxK25Lj4cljwzCk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90a102b-cd6f-4b25-f27b-08da33deb573
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 06:14:44.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTXte1xR63HwLu9AS6hC6yuaMdFEzoC2++yweAZkORruPz63eE74GblmWmx+Qsf+gzZki0Z2MPtrlFGb6NHCFgu/IYb7g4PNHYn+opAL1FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7482
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

> Subject: [PATCH v3 1/5] dt-bindings: interrupt-controller: Add Renesas
> RZ/G2L Interrupt Controller
>=20
> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-
> controller/renesas,rzg2l-irqc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/renesas,rzg2l-irqc.yaml
> b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-
> irqc.yaml
> new file mode 100644
> index 000000000000..02bfd631e532
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg
> +++ 2l-irqc.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id:
> +
> +title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description: |
> +  IA55 performs various interrupt controls including synchronization
> +for the external
> +  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the
> +built-in peripheral
> +  interrupts output by each IP. And it notifies the interrupt to the GIC
> +    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI
> interrupts
> +    - GPIO pins used as external interrupt input pins, mapped to 32 GIC
> SPI interrupts
> +    - NMI edge select (NMI is not treated as NMI exception and supports
> fall edge and
> +      stand-up edge detection interrupts)
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a07g044-irqc    # RZ/G2L
> +      - const: renesas,rzg2l-irqc
> +
> +  '#interrupt-cells':
> +    description: The first cell should contain interrupt number and the
> second cell
> +                 is used to specify the flag.
> +    const: 2

As DT user will fill interrupt cells only for IRQ case, for GPIOINT case it=
=20
Will be handled in pin controller and pin controller maps to TINT which is=
=20
internal to this driver,

So do we need to explicitly mention it as Interrupt number of IRQ here??

Cheers,
Biju

> +
> +
> +  '#address-cells':
> +    const: 0
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 41
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: clk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - '#address-cells'
> +  - interrupt-controller
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> +
> +    irqc: interrupt-controller@110a0000 {
> +            compatible =3D "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc=
";
> +            reg =3D <0x110a0000 0x10000>;
> +            #interrupt-cells =3D <2>;
> +            #address-cells =3D <0>;
> +            interrupt-controller;
> +            interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks =3D <&cpg CPG_MOD R9A07G044_IA55_CLK>,
> +                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
> +            clock-names =3D "clk", "pclk";
> +            power-domains =3D <&cpg>;
> +            resets =3D <&cpg R9A07G044_IA55_RESETN>;
> +    };
> --
> 2.25.1

