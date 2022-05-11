Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA2522FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiEKJyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiEKJyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:54:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C09010275B;
        Wed, 11 May 2022 02:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY1Oyjon2RrfIONAL/pIfZW1KNWrur/md0eGTFE7DydcdHz/VG839a2n+gV9+unzLG1IbTTMoUUiWP3aOZ8efxeMiwmGFzhdyS5RXH48U+bHc7Sc1U7DcmLI6cfJkEgkWRgNuN1sJMvK98CgByrrePsvo8yeuIbJKZ48E4I+fVBg/1juhYTZ9RT2hoOnCIr3/dZiqmV+5NAia7pxzPNynMbu1o5tmbTyy38FZymP4ftyqhtVY/xTq/YWalCS8hIcpv3hRFSSQZpyU7vQQETdIt9OA9YrDAmQje9oyVUcmExXsXH2E0YagwzhRf/Vmd+8uLtJKVdlyqckf6Y8HHDBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8y9YP2w7BePWcH3s/f0f8TTUw0gEr3sFACqAzHo8to=;
 b=AUPXVAg8sjcwOYuVHVz74ZL4tYJ0tNkn0QXdJlqiACM8qOyzywtZK2QOBzgACW5lV4wFBnute5HDGWFUtrH3iOwLJFXFs4jvHAZPUWGZhzLlYprjRbJvI76sqyCOP//f1WTanJfBE6S+pql40hoe6ds8t1cKuPjZpEDU0PTJBAly3p8CFe5P7j8o1ZIr1fYvQiV9ne63j/5QJX6hjf0ai4v4lqHiFeCWByuYhU/E9y/Bm9o0z4Kf5LgApZP62StTNP0/DIMbrCX6Gy0TTpwzhcOYlBV1a3J+wHyCmFWvvzks6g4ke3U1ekYAevW5lLL2ZzVElykIRJITyFjPISmS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8y9YP2w7BePWcH3s/f0f8TTUw0gEr3sFACqAzHo8to=;
 b=kgdrR3K9bPJwI8rgzfk0ElUvEwER/QN9hZjQD8fjVLnki4tJCDfCXHI9mAf2PN6CY8iWlCWnH5G5E0XTWC+4W3WzO8yn1mH/15XEtliUoEeNm/heZlVwECwXlmN7+EH+udi7+2TNSXlWxqd60e6Hrei6n+1tvpWjsbsh8eCSLto=
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com (2603:1096:400:de::11)
 by OS3PR01MB6501.jpnprd01.prod.outlook.com (2603:1096:604:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 09:53:49 +0000
Received: from TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244]) by TYYPR01MB7086.jpnprd01.prod.outlook.com
 ([fe80::e180:5c8b:8ddf:7244%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:53:49 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Return -EINVAL for pins
 which have input disabled
Thread-Topic: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Return -EINVAL for pins
 which have input disabled
Thread-Index: AQHYZRs+TNNDYMcliUW9ygiW370dxK0Zb0qw
Date:   Wed, 11 May 2022 09:53:48 +0000
Message-ID: <TYYPR01MB708627DC4E80CA2D30679936F5C89@TYYPR01MB7086.jpnprd01.prod.outlook.com>
References: <20220511094057.3151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511094057.3151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18119851-2aae-487d-b237-08da333425b3
x-ms-traffictypediagnostic: OS3PR01MB6501:EE_
x-microsoft-antispam-prvs: <OS3PR01MB6501F48AD64571EDF8063903F5C89@OS3PR01MB6501.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RG76xy4CxYcDSWKn4gtZVxfaybyaRFzdNoiCa41YYkJ5PgppubrpX3sH+qfmmyqFInGoJRSemIBR34w85dGm8F3DU9g2thJ/i6212x206ahAnLZ7z20zuQWmj6B94KLRpqqYTQdZVwQ5JIE+r8AeCqcKm3SVrvpEpYSVtO22aSpaxwpW597Ha6xEI5b3zoSh4oRVr4t8cMJD+YV7HKod35KufddqCud6WpbfzE8uHc5ew4M2p4HcYfS3mTPIk7bT9yM90PTG+xR92krSKsX7oD2siIhCdiZGH+PCJaXeaR2xOKGSfgzFoFoinMAkRQ2Rza5O/XJTWVFdkigXF/wosvrrk0HUIM4jaaBTs9Al+sfsdbVN7hAhk7WrgoWMelU3zlxr3QNats3t9k5TByjixkm/XDawANSWv2/qvX7XtckSasQCdNae1HsdDnZt/O7XI6Qi5NYwRA/s75tMHm497YcL22VoPwLi0swq5gIduzPB8biiJm76EZbUSUUriKcWWMxAasERzofFLSnJd9E7JnVzAW7FGp3vnRJghRyQYvv/zkeQ9heuBkKy0fh+nzNlRLU9jkBjHwqpRIq866hloGAvkUyer7iq9WrY5mO89APMSCn26dku2UsbhBsG+2ax+M78ON73p8GvP6dwfK5FWiIWhA4A3x1Mb+CJ5oXLeY8Q2b4v/zFtIYIow9KSURjhNS+cPs8c1fPVwktFjz3ZoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7086.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(71200400001)(6506007)(7696005)(86362001)(53546011)(38100700002)(38070700005)(64756008)(66476007)(66946007)(76116006)(66556008)(54906003)(316002)(110136005)(66446008)(8676002)(4326008)(107886003)(5660300002)(122000001)(2906002)(83380400001)(508600001)(44832011)(55016003)(9686003)(33656002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xSKq3cCdaSjJ14C0ynZq430aAnTZxJIfMHnsKI1ALMrIbABJi7paCsNCycXY?=
 =?us-ascii?Q?N+PvdqpnZimhJ2DwP88JpBshath79y3jMKFaJk+Qo88qAXpMbnfpkwtSG7tg?=
 =?us-ascii?Q?Ae8oizUC9PetA1dAA6Y/S2CM1qtV9kgbuIqeJBYFGaqT2OQe10rfEh4DWDPt?=
 =?us-ascii?Q?nLyGJ6XdyOJtAADbJi95RAL6iPiv8ZvGaGVbRFB0r3KW5yrxIeJgjhI1sINe?=
 =?us-ascii?Q?cplZ1brn9lE4FxYpQyjCEffQL6JFqBt+Rqc/8Rhp/70AVlz6XASqib0vD42i?=
 =?us-ascii?Q?YN5pfv1Zk6mSm6z7qaZqzPxgBRQYCV/mqvYluWDFEqFbVOr+g1svwveUu8ep?=
 =?us-ascii?Q?O1dQ94IeZKMZSJCleMWvdV/f4Ca+sbmKMH8tyMU24QEBFcWGSuszJfqAuvtq?=
 =?us-ascii?Q?X1Rj7mudYgskIU2Gmkmcij/txc8uA4dzRS5YCurr78aL1jIGBtPWiKgqA2Lu?=
 =?us-ascii?Q?fOpA1tZ5kf2g1aPY9kKs5Z9yOzhRRtjkmRV0Cq2Fn4FjHgPV8NFz9v2qTGWR?=
 =?us-ascii?Q?zzT2+XCMeQ3+f/H50X3bsuNmfBQP4NYpPvCSK1o/f5eIT9KtLOjkAzFht5ps?=
 =?us-ascii?Q?uMiyICblisWDL1pPVq8DVUY8m+mOtdsu08sA0Pj8PYs4f31bELr3DN3BHcjH?=
 =?us-ascii?Q?LPiUbUZ+aPk8vB2bdajeXoEI/KzABwAUC42pgsZkcfnKG4MU8UOXDbUfLRRG?=
 =?us-ascii?Q?QIBADeoJwM+0Nt4H1RYug+kdCKSF2Aqu/r4Q3dL9mScYscmVK1YzpyuYVAkz?=
 =?us-ascii?Q?Bcu+dNczw3t9XGIeT6u0cAPlwNnhHnPPfOzQNXTKavu5AVGVb3BrRTscV+0j?=
 =?us-ascii?Q?bLSK92iSgAJ3U5YoLR0fbinYXf0gZ1tjCq9jt7pYH3upoxa8d+j54AsHx8uH?=
 =?us-ascii?Q?9g3bcgKe/Mm5dRquI4sDq+UMAV19DIlXNUZlRygaqTYH1nLpqClp08A9thpk?=
 =?us-ascii?Q?BS1Pe7uSeFirxWmThbJptwmPk4VGUpRtVqxMctu5beQXv451imohXs3k/epB?=
 =?us-ascii?Q?MDz/FZzEFXyP2vOnK0QL3z//dqNL7LBNKGQgafFd8vk92VYO671pwhPgLmdE?=
 =?us-ascii?Q?o1M2zC7qXmg4HfIrQm7y1DMfsUZC2Z/7yWgLEOublx+YVGCuYy4AQlxO7wJP?=
 =?us-ascii?Q?JsqxeYU2X3EW7zF81t7HBn2wGY62t6d1xn1BSM/ifPhS8J8vEFm+Pz227dzH?=
 =?us-ascii?Q?jzM5YZtzgeIRNNvotX2AbHY7GME6Dv5KY74dnGzn3KUiluhBRwKHnKo595UJ?=
 =?us-ascii?Q?UqQINeoE8SGKQtbhzarJCulYxN/wj0dhCzL1AGEx2PV5Ig0GU35EYcC2Wq1t?=
 =?us-ascii?Q?mfjoYYRpRLMr8dSmlIlpjs7JLPT1YYstQ9anOte82DUZZ3qrmCV9VanzmMDt?=
 =?us-ascii?Q?euJga/DKJpxghJdsrOygDYiz6c0vuMYvGoVKYO+PrTzjVrPS/PBMufpfjAiB?=
 =?us-ascii?Q?Mo+UwlFZsEB/sCA4EFXobZo4q1o0/aODLVmLguHrlbugVcGolXJaVB5VToQo?=
 =?us-ascii?Q?UbbHYPJVdqFS6PzZgXktDrLWx0uleB1/OE3SRDGhoMusK8SvoMlPn2pY3oIi?=
 =?us-ascii?Q?y24P5OcUi3CpppcKqgroBYi6gp1ZKagtnlmF5vzCufcs5yfoHedzMmUWxyS7?=
 =?us-ascii?Q?mRMZQngZegGVIoFuTpt7wW5Fs0A6m2/EZd0j4gJ6R47nMolJml8/eTbig44c?=
 =?us-ascii?Q?tHnyYXPM0Iqj77INfXe5/jSOQ/f054obpRbG7PKZfOc963KTy1lSBmz6U0De?=
 =?us-ascii?Q?9X5IAL1WESj+MgJ26a4xOpNQwELhY70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7086.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18119851-2aae-487d-b237-08da333425b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 09:53:49.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kr7/pDFlDa8gJirmlT1/cNfVgoOEs1OIoMvOTBk1D+XiRltx8rm/GTOb1fY0ndbDDqjWId3Qpwn9h8QZ/Q8UpwvBNaugpk0jrqKdRCRLfnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On 11 May 2022 10:41 Lad Prabhakar wrote:
> Pin status reported by pinconf-pins file always reported pin status as
> "input enabled" even for pins which had input disabled. Fix this by
> returning -EINVAL for the pins which have input disabled.
>=20
> Fixes: c4c4637eb57f2 ("pinctrl: renesas: Add RZ/G2L pin and gpio
> controller driver")
> Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Phil Edworthy <phil.edworthy@renesas.com>

> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index af2c739cdbaa..a63535ea47f5 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -527,6 +527,8 @@ static int rzg2l_pinctrl_pinconf_get(struct
> pinctrl_dev *pctldev,
>  		if (!(cfg & PIN_CFG_IEN))
>  			return -EINVAL;
>  		arg =3D rzg2l_read_pin_config(pctrl, IEN(port_offset), bit,
> IEN_MASK);
> +		if (!arg)
> +			return -EINVAL;
>  		break;
>=20
>  	case PIN_CONFIG_POWER_SOURCE: {
> --
> 2.25.1

Thanks
Phil
