Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646C85185F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiECNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiECNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:54:35 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20107.outbound.protection.outlook.com [40.107.2.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91AB18E0A;
        Tue,  3 May 2022 06:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CB6EWPC/jVDZAi8GiBAzXkEzgLlKkEilRmrIi+DlBbZdc0nshxK6zqk0nYMe1XHaxEElGLO+jYa274POP0d1PUSyUaymXYMaImS6aGWAcoxfWP/WiUimfzdSAnaf00TLJqfv+uh/tx9ie1a4a7/meX/1SKfBOHH+fagfQn9msw2Jy0skabBrc0w5lRc1aKHPGhmaJZgC+1+cdH8MsY1ACyO9EsgUyWFkQ3mnbZi+M7lm9Z2KSnz3xHNqVzSHvnlgOx8HEI2NIzmCNpLoEyy5q/jkf0c3d/cK2344b37YRjZxVYdowdVX7qS4LBsoXaHw+1p4gVeNqgZHGBCebiLZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imgIp6CqRGYxGv0Tvyu+vzA+IH5zoRgZjV9Sf6btPa8=;
 b=ia57RSnytn+vCsMY+a+sLiZgn02Euw9RZxNdD9CfoWIF+UghW0TpknIEbJMAe35InSVOfNJl96gTx+IN9CXelNYVvpRj8Tk7wqbsRZc0fksxuMHBvGmgT0O+C4t6CgYGfs0V1Nm861SmjeUG5S95F8xLk48cHORkiF4600Iqj6b32lzfQYidvPOieMRpzhjwgFnfnR9sqCc19a/kqA+j7WVpQl1v8p+PZ9CSz4nmgecJstN+1CLs5DhkTZ8T7kj1RokIOFkM6yx1XaWCn7rl+O9nTeSWd9uH8NbBIL72PijzXI3wGbBMZ3PlKh/I70A4jlET5huMcNGbQBMk51PXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imgIp6CqRGYxGv0Tvyu+vzA+IH5zoRgZjV9Sf6btPa8=;
 b=U7epZsbMBnuaw3H6czeUW3A5CH+Ki3QzKJiH1dxMNd8Jh+q/6HQHyXfYR+OE+MJFtfxgv2iGyV7QCyZKAGa0ZFSRc2bHttO/oORmjry+xg2HS7PqH4nulGcaDP9qXplRIEQ2xFsYcUfTK541FzST9CDUVHwHrPKSQvk0Ielvw+U=
Received: from GVXP190MB1917.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:6c::18)
 by AS4P190MB1807.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Tue, 3 May
 2022 13:50:59 +0000
Received: from GVXP190MB1917.EURP190.PROD.OUTLOOK.COM
 ([fe80::d51:5e16:ae67:ccac]) by GVXP190MB1917.EURP190.PROD.OUTLOOK.COM
 ([fe80::d51:5e16:ae67:ccac%6]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 13:50:59 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Sven Schwermer <sven@svenschwermer.de>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Subject: AW: [PATCH v2 1/2] dt-bindings: leds: Add multi-color
 default-intensities property
Thread-Topic: [PATCH v2 1/2] dt-bindings: leds: Add multi-color
 default-intensities property
Thread-Index: AQHYXuDItnuRkj/QokSwpXQ9iOIt6K0NKZ3w
Date:   Tue, 3 May 2022 13:50:58 +0000
Message-ID: <GVXP190MB19174C638935B1C6717F8AEBD9C09@GVXP190MB1917.EURP190.PROD.OUTLOOK.COM>
References: <20220502204616.GA27288@ucw.cz>
 <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651577132.git.sven.schwermer@disruptive-technologies.com>
In-Reply-To: <364df52a196fa0ae5db07e599995fcf8dfafb43e.1651577132.git.sven.schwermer@disruptive-technologies.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3de7bfb0-0f0d-4e25-6a15-08da2d0bf41f
x-ms-traffictypediagnostic: AS4P190MB1807:EE_
x-microsoft-antispam-prvs: <AS4P190MB18070D989AF087782FBE3328D9C09@AS4P190MB1807.EURP190.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBnW6C4sI+QUfpluEQWVHNDWJ7Ni/pD5B5HI/j6gI/oNvxkxGH6LLOX5UCnNopNOC8ArwFiDBPzINr2DP4DT4AVHITZOIYbX57Anky8+sR0oePWqx7udFXEord7aY1zb8QlYx9uISBfaHt9Yo1CW0y5S9tGgGmYaLQ2n7m09/vol7Se5CJvqn7KVFxR1O89tn9EoF48XSxw2+iYYkFMstUjnA0nVlHWcSMo0ZpU/B9yERo5M5WIMtEjlB6kqjzVMeVAsZD67JDk+p/dupAEQsEyG+/btpDOp6zcMppqZdnMRKEghdHrJze00rRuzp8wTYioZzBV9kZDfFoz5ZCoF7DhbQcPa+h8EvQ6kJ6eOSA7Yy5SnFQ8pJ6wyEBmP/u+qISj+A86BqqspiwGKMEbaycc+nML5+onPRSinbpcdJ/V5rPZvLSxFPai7qKh32Xc1F7B4ZDijbaEdggyZ10RPJv/rh4l7tCZxDjrnyeAd7f6b0KG4tpvISMWF4FtDbtnG28pnfSEGlqk9pZ5zkSyjRT/Hk/nSnRISu26L9xCO7jmdeeJ+2Uh216jaXeyiQku0dOiQ/yTprV7mcrDY5we+IUzFRn91v9Ybh2Qdb8pNsu9z9+HalluFkK3QTdyeI1Fc8N7oGFsL1noq3qOt3gwra6lvCnPZCqetx3pOeR8/hwlqxfxah4W+1tc/+UyqEi8zh3P49SfboqfiICguE+586EwXF8tsxVlpRqPK0/DokDW8use2gr78fk08MpMZ5cx9tT8uvGIrOJaFTmzRkf4qEFiHzhetLDWuVpfVgUUmauA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXP190MB1917.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(346002)(366004)(396003)(39840400004)(136003)(52536014)(6506007)(71200400001)(5660300002)(966005)(55016003)(186003)(38070700005)(8936002)(508600001)(86362001)(64756008)(9686003)(26005)(33656002)(66574015)(2906002)(7696005)(83380400001)(66556008)(76116006)(66446008)(66946007)(66476007)(8676002)(4326008)(122000001)(316002)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I8xL7E/xLibPAJwao3hvr0Z+ix4MrPv6lIFCd3Hgagy5tlSu64tM1VmFy+?=
 =?iso-8859-1?Q?LMjPYIuAcLIF5Hu6lADvLL+Q2ywjc/hmlmBouPU/BN/WaBiJayF79TuMYn?=
 =?iso-8859-1?Q?88/r/QTgr1sZKDP8JUcAun1fyVDGCifEqedTmX+kHgXhW0ijYjp05Xnvvl?=
 =?iso-8859-1?Q?E7FGWFQyVbD4CIlS3SDfyWEFh6WObWXm6F1JLhVA+zOJK3Cz4hpyupnBLv?=
 =?iso-8859-1?Q?U6aXFmj+qq1pDDmmqeJz2589mP68gGonbH7Opr19C3miNpKtftaIsdQKPW?=
 =?iso-8859-1?Q?cyO/MwzQtCQVLw4V0Ifgv7UNB6rLbJWwK6iuu11kDuWjBradKzlLHJWyvN?=
 =?iso-8859-1?Q?pFpv7HWlUBk8ALDHalxEZkOq7IvnEoUysBA1kmrUULajtHoKWVKKjWZPYH?=
 =?iso-8859-1?Q?G7suDfNL2jF3/MQJuzFaweZvxfKFFPOg4ggh8ZagBhD5iIpi2rNVk+VxHc?=
 =?iso-8859-1?Q?GZFs1ueSEHTRfv0tYuCTmSH+01HelQOoMHXXXDEz0o1WEC0JL+OE1OvZG9?=
 =?iso-8859-1?Q?mQ9vYWiW/UhzyaGqh2eFzqeSkRDjURd2DvHDwhci/ybpLsW+3yZQw+wKFZ?=
 =?iso-8859-1?Q?Ddg3n/FqQoy4Zu9cwVUbtLb0C66J/OaISqc0lL8IhVeQCJEQzKvKYpEw2B?=
 =?iso-8859-1?Q?k8aqOT9SUbNmYKjYIsRBT/B2GFvFJtGuPHnNOhf4jaAoLjVN+PvqSKJQij?=
 =?iso-8859-1?Q?ulhyjiwudNZ62fKdh70KfKtkX4qV0YF+mIemWNPQL5cLWUb0E7ni8LD5nl?=
 =?iso-8859-1?Q?wK4TKJqrLPiKQUXfpZx87StvjjKRlfVR3zIswon+iXmMosH7Ck8ymib7ah?=
 =?iso-8859-1?Q?O0/AlLjERkdnl1fP3peu5fhub+Rrg1iQSosCwmsSMwdFyrQH4QKmqblbcO?=
 =?iso-8859-1?Q?NgNOoSjErCHZShBMW8jVeQuyiXRzxHOQEyRu0PVP1KbUi8JP9H5xMFCZGE?=
 =?iso-8859-1?Q?hCwmaSwKORkoXcjmvN+15RgMp3vljQn3hPXBfpAYcjnj6HFwdsNeAofg5/?=
 =?iso-8859-1?Q?lp0rPpeUjn0g8oRFI7O5NQUrTnzJDZ6vp12TlsRbx4PtMh1aUr+cJrqsjZ?=
 =?iso-8859-1?Q?LKyJAxbRHqgQaozEwDAbbS1cwwrIf9z1zoAu+bQXy3wpFixrTH0alEqF8n?=
 =?iso-8859-1?Q?uluhpgs2CAuX7IcbNBRJG3YltMqSRB851GtCIlsizx0eNHPX+/ltgnEnnf?=
 =?iso-8859-1?Q?eYosRSPysDB1e1nqQX+xFwhBgkI/Nm3nmrlXVH6fzZgxT87ZuCLLv8jsy0?=
 =?iso-8859-1?Q?ANWvi+sY7Cl7ZjUodUqCgc/SYQYKeXoF5hfGqtpjUK8eD7YUNZGYYcUwkT?=
 =?iso-8859-1?Q?+A//WLY7H3pJeFtiHt8AErKP07MjpURntH9li6GVVMMH16AYzUalOj07iu?=
 =?iso-8859-1?Q?2HL7yyUeLn64UE2XtEfCsS5F9YN6WIGzjMYamZ1qivdh4xlhggn4TzKxTs?=
 =?iso-8859-1?Q?1UiWnXG4U2KnR/81ossrYPRXDuNYTKx8VEpSlMTkdL6wGpYZ5sr3pPLOJy?=
 =?iso-8859-1?Q?ip5EQiUpeNboaQqD0p110oQ1pGjOOAPUHTQIBn5ZeCOwDewfGvGgESsut7?=
 =?iso-8859-1?Q?fHWGISRVljneXomk8ttFjE6mxvse+2IOvVc6EQfBf1NQ0Nq39bPXJRqzGU?=
 =?iso-8859-1?Q?+Aj2/iQjTumFNvcS3JyXJMJhBLpVlsQoPrOGJ0D9rTrWiuRhzLdmEo18iR?=
 =?iso-8859-1?Q?b38RND5M8fc10y+GmijeT0Z0Q20p/encrRmd0+dkRbcZufR4+dHA61pl0z?=
 =?iso-8859-1?Q?tKcQc6toZowcDU8XAD60/Hn0g1RoV41ISuBAbb5rz9lK11t9mlYlGZNTGT?=
 =?iso-8859-1?Q?di1GPkZ/k3i5yilaPVg+hPF8IjLXZZo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXP190MB1917.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de7bfb0-0f0d-4e25-6a15-08da2d0bf41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 13:50:58.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYcS+i3M+TlflTPqArSmKXut33svJ/keLicXg7zjtni77/tnjtgEC0EL0kyULdVD+zuU18j/9qRMFrgB7Qa4jY/OBH1tzO0NBh11yQtrrxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1807
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sven,

tried this some time ago for the LP50XX
https://lore.kernel.org/all/20210204143726.27977-1-schuchmann@schleissheime=
r.de/

Your solution looks much better.
Could you give an example of how to use it?

My Configuration at this time looks like this:

multi-led@0 {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		reg =3D <0x0>;
		color =3D <LED_COLOR_ID_RGB>;
		function =3D "eee-led-status";

		led-0 {
			color =3D <LED_COLOR_ID_RED>;
		};

		led-1 {
			color =3D <LED_COLOR_ID_GREEN>;
		};

		led-2 {
			color =3D <LED_COLOR_ID_BLUE>;
		};
	};


Where do I put the "default-intensities"?

Regards,

   Sven

> -----Urspr=FCngliche Nachricht-----
> Von: Sven Schwermer <sven@svenschwermer.de>
> Gesendet: Dienstag, 3. Mai 2022 13:27
> An: linux-leds@vger.kernel.org; linux-kernel@vger.kernel.org; pavel@ucw.c=
z;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; dmurphy@ti.com;
> devicetree@vger.kernel.org
> Cc: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> Betreff: [PATCH v2 1/2] dt-bindings: leds: Add multi-color default-intens=
ities property
>=20
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
>=20
> This allows to assign intensity values to the indivisual sub LEDs
> (colors) at driver probe time, i.e. most commonly at kernel boot time.
> This is crucial for setting a specific color early in the boot process.
>=20
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com=
>
> ---
>=20
> Notes:
>     V1->V2: no changes
>=20
>  .../devicetree/bindings/leds/leds-class-multicolor.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor=
.yaml
> b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
> index 37445c68cdef..c483967a847c 100644
> --- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
> @@ -31,6 +31,13 @@ patternProperties:
>            include/linux/leds/common.h.
>          enum: [ 8, 9 ]
>=20
> +      default-intensities:
> +        description: |
> +          This parameter, if present, sets the initial intensities of th=
e
> +          individual colors. This array must have the same length as the
> +          multi-color LED has sub LEDs (colors).
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +
>      $ref: "common.yaml#"
>=20
>      required:
> --
> 2.36.0

