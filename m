Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8B57D9A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiGVEeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGVEeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:34:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2112.outbound.protection.outlook.com [40.107.113.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B0087C3F;
        Thu, 21 Jul 2022 21:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQqGk3MBAcMjTjKR8b5t+bFs3jEs3KoXyIMAaS3fVfwn8+1MbtqQuPO/CIJMSezSXvgge2wATgnWA3ZwUmKB/gPhiJt9JH4bw2L1+ppfKUsO35OPku8hVS486vqcJrkTt4Ol0vXG2TJTUNyTtKlpkf5Qi8tlTui3Mw7teRR8vsSUE8t3VhiRR28RkUAKo6Cx5M35ZiK9+jL3miGHSB2o/YaFBCpZGaGPZuuZRPC87LoGnqzoFQU2/fBa4eqTgxy/TfTUGy7eJO3Z1iXP23xj8X5ySNdAJC0M/ZnmnBq7j5vCTikN4X4BDmGxTSikLycOCE8tY4QM6kbrqtij8+tOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFKb2NfMrEZMhf2k6N2irVl0w+aISId9tHtRIPU0N0g=;
 b=U3kM30fv0sVIHuyHQ1kS42ob4aRkMqqdckmtQkYup9Z6HoV7//uJAnY+/JgCmDemU7msE3arsJJrtYHXvJ6zwfdynU+zeXX1GBXwV5gAnsbDgcQP3+EzKU1cG22ZyYrJj85IW74rwlvKGLk/lyxM24ivJFrs+ScxbZ7angI+EUBiHCDtMTgtO+jidXV2ke9cREbr3ABa25jPrdmo9umbaKXEsEM5ZfhpDvRle5A/CXRuQnAerGhstVatinUQMy4cCcDMR+wKn2Do9E4Uv3birpGBa7nFsv59mVm9yGdjLuGyug4ICcCoq07CD1SsfkrTQQ7gmX0PMZtdohmideUoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFKb2NfMrEZMhf2k6N2irVl0w+aISId9tHtRIPU0N0g=;
 b=AhaC2LxO4a6lvcaeNm4YakdEwa0NBdrpV/feYjLRVWmZ7ozjAmJnhfeVSCWPrhAApbWhW8C5vqULYeYozsS0ElGFB7N4bDE2qzp34nZWn7ZQ1rlq+QwYDgQw3MyyCOulHCvwtNHPWUhtVpR5rkt38act8OOnxJfpp+Llf11RGrI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB4704.jpnprd01.prod.outlook.com (2603:1096:404:12e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 04:33:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 04:33:59 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
 for IRQ0-7
Thread-Topic: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
 for IRQ0-7
Thread-Index: AQHYnSLw4B/TXXVBfUe5YSpaYWjp862JzChA
Date:   Fri, 22 Jul 2022 04:33:59 +0000
Message-ID: <OS0PR01MB5922D6EC478AE231A06E94B586909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220721165701.17888-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220721165701.17888-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d71c7fa6-0fb0-4bf1-7021-08da6b9b65cf
x-ms-traffictypediagnostic: TYAPR01MB4704:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/1rGzQq784lrqjFH2T40HXX7TPr4L0I2grQ0/TwHmpO5j/0tTCZLeIawgaGkA7bbjEEvYSfGFvhcp4Fk4j1GipJktY41gMwtD9+sNTdy27Hu72tZWmgTVtsYjXsmIZeN6A1jRIM8GMl7afPNAzqEtgfzEHDXQmqy6uC3ZIVpKQOndkAohISVeI34LCC/Gl5bq14QVjYhEtbiQx2ENgOs6BqXbiClrAXG7TS5m+kh/lf+NJWFDFoYK0SwlBMU3vqNNyDFxrqaJS76z4vnSUkJMuzbgETvZQTCJgItLJCsVRyqYZMULFO4tIOJnPlKfHrACY336RqSVsicBeg8i6keFBdHp4LbfqK9cuLxFmKdQjFnjTyVPJjiab1pHcHmHv8hZlPsNhH+5LT3MWCOc8WZWsAMHWwoKx9W4opfJU/lC3L+F4cWi1Z+R0KK10mSu9rRJJVsyVjeGNnAWyJQ8Pf5xYu75TO1w/d7dOYYIrsNyt4qy9riT3yqDTLW3zV6XDiJ7VVyPngD4gvf5nRlJjskD5jIanyvSeJQ1Lx8Q0Zv0l42asY1SfoKSJL9NdivfvyPQVRez0OJ2CLtTgvXFAJ6kGLzW0shLFw2dODTg8ONOaFQ7PCxbXSk4ZluFPXY/1GP/rh1LwYPkZk2K0g0jbClGjLUUzZJvzVw8KAWG7doIENHbmlZnheSjwC8Xpy2tyCaB0RV8XDCVxEDDaMPkArNpu8pVfsykEgSdR5LUBXmlIR49AYgkaNLUen7IzFYLKiVj8mM97Bd0HzeqkhvFaFWy1zaw5aMKmp169/Kcp1ZfYx380LKouWISueUEnxF3Mt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8936002)(52536014)(9686003)(38070700005)(316002)(2906002)(26005)(5660300002)(54906003)(110136005)(107886003)(86362001)(6506007)(76116006)(186003)(4326008)(83380400001)(8676002)(64756008)(66446008)(38100700002)(7696005)(55016003)(33656002)(71200400001)(41300700001)(122000001)(66556008)(66476007)(478600001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VKSkDSNg9hAh/dQouCEEF2snUX45N6vVXRS+A4mCG1Z6KSdBDgRfZXhREMUg?=
 =?us-ascii?Q?dtpfNEnLvdgQooG1SZk34dedpAk4kk9MNbszgRExM5EOGyazKI1TltPi37hf?=
 =?us-ascii?Q?kEidq4KEynbkwPi+d2V+i1Ko04TZccf9JHedsojs/inDSKjgoV/QmOh5DWOb?=
 =?us-ascii?Q?vokO5wIRpW6TamNvtkIKrX3tEdGMPfD21PFMdduN+WyzYaxG6RE9bByW8D0M?=
 =?us-ascii?Q?7t0xxL9Dh1RgKwQ+BR07pfG4HhWcl/oHSX5UsqnxnTdsftSVzWlwPxeXEKcz?=
 =?us-ascii?Q?iku4G/ORYRCBHFM9hg/ckz7eka8XCKOFxIMDeH+xdKctw6FnS5eJO18bRhGN?=
 =?us-ascii?Q?pN0CMXMpfaJKGhWP+zTch42+HJGVj3CMCk1iax4zGu7SLay6gC6j0m9i7Te6?=
 =?us-ascii?Q?dH91YFeytQ3EC5tM9XX3JKj9Od1dUHGXAotuA5iaCJIW+t2mnz0RpYQLVwb8?=
 =?us-ascii?Q?+GUaQGoOfmPjSG42cD48Sz5N1xH7eVCACBAjDPx2JEqgWrkndHZqpVR4SG4m?=
 =?us-ascii?Q?Bu4safPnM+6buU5Jkou39C9VZlKWa8cn3SUVzhGqjk5t4D7SVMZLTBOvHcoi?=
 =?us-ascii?Q?W6X19GhPFpM1xos1u14HzmHshHNDjAzy1d5Ta4ED5thnx3RHAsnvft6CliCX?=
 =?us-ascii?Q?bJQiDdd2nCX512+4I2obiRLZScJmO1t0zrHk9HJbOYjNvmn5/I4Ul8WmD3ZY?=
 =?us-ascii?Q?JU2wzg/W9uEI5dHANo4qBjGRo6PFMEks1NhWydz9EWw7PwHz5DmE/H3yyKmJ?=
 =?us-ascii?Q?5zYWm9eHGIonZ/DCdJ/QpxQWsG1HKegN6KsuNEvPUAkOFVeFZEa1TNgwE1hI?=
 =?us-ascii?Q?nhWkCqRBLPEl089DQ3ipjK6Bu7ZSDCjrzVYmHbT92kp4dUzgqhSdVk8dRkSS?=
 =?us-ascii?Q?wmpnE3qjMyPQ25m12IVIYt9VnSRMKtIl6zmM6Z7s5Bwcn53WmP0oTZbiCiOK?=
 =?us-ascii?Q?DFBgcPLezXWkcOZHiJhfH03C2Yh8CIoDHbsvKZGPhyDkQFnMVhuYJ4lijBZ1?=
 =?us-ascii?Q?0C42vi3DSgbfvfL4x2RiRln90+8uSP91Mi6RmiMsQwUl5chbGu9IB5JxxlMJ?=
 =?us-ascii?Q?Gakyki6MbEFlLsn5k21E/MGMjP2za1sIWKrfdr/wZ1EhejFpBUVjgtqNs6+B?=
 =?us-ascii?Q?7uDrbtogeAhmHYlPJpk4/pxu+cGIJz+GIRDzks80Z71fj/nLIjp3KKfiGqzZ?=
 =?us-ascii?Q?V4OlzDx6uaxefQ7NztvD19VTMPYpB3uIg5FgDjXhC6sMkgrEZZzI4X3zw2O7?=
 =?us-ascii?Q?iH3aKHuwRCuonKYr1V580H20e6hWdw8lf5o+MXgDuNStIb+AG4FZ5Z+ovnTi?=
 =?us-ascii?Q?bbSQchiEpJYtm9hkP3UpbGbZ9VIWs2axJW6uPzwSQ8NyA0iJqqJG+yxk0ZUB?=
 =?us-ascii?Q?vj368qZxcu1RdFBWdc4O5AyfREaCw4kFLpxT4a+MnIoDWmC3NQuaZckRoR+K?=
 =?us-ascii?Q?Ja53Cu2rWG+Qs4awXwo+FxfYBHxhlBqf2T9HETdyn7BDmUsBp3iKb+WkUxDR?=
 =?us-ascii?Q?DYUVh7PaP0l41ZxsoZ6lgrb7a1jkpg94Ppta5nYNARdMwaaiEZewj33RnqK5?=
 =?us-ascii?Q?/0M23lYrNt9CpD4KkyfIHlt1L9n5IfRbbAPFmB8t1VKvKfWccPhN6W6SQqXc?=
 =?us-ascii?Q?dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71c7fa6-0fb0-4bf1-7021-08da6b9b65cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 04:33:59.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc/cejOtwv0vRE7XYbbzoGGDFxpMwihN3QX4Vt16opLzXVePApjNdKSoIRMhGL9u6q5ZI0f8zWjCt2mk8d1d6uzSDsxQqAuLbaGJ/9+h3us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4704
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for the patch.

> Subject: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros
> for IRQ0-7
>=20
> Add macros for IRQ0-7 which map to SPI1-8 so that it can be used in
> dts/i.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * New patch
> ---
>  include/dt-bindings/pinctrl/rzg2l-pinctrl.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h b/include/dt-
> bindings/pinctrl/rzg2l-pinctrl.h
> index c78ed5e5efb7..6aae2ac206d6 100644
> --- a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
> +++ b/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
> @@ -20,4 +20,14 @@
>  /* Convert a port and pin label to its global pin index */
>  #define RZG2L_GPIO(port, pin)	((port) * RZG2L_PINS_PER_PORT +
> (pin))
>=20
> +/* IRQ0-7 map to SPI1-8 */
> +#define RZG2L_IRQ0	1
> +#define RZG2L_IRQ1	2
> +#define RZG2L_IRQ2	3
> +#define RZG2L_IRQ3	4
> +#define RZG2L_IRQ4	5
> +#define RZG2L_IRQ5	6
> +#define RZG2L_IRQ6	7
> +#define RZG2L_IRQ7	8
> +

Not sure, may be these macros to be moved to [1]?? as it is nothing to do
with rzg2l-pinctrl.

[1]
include/dt-bindings/interrupt-controller/irqc-rzg2l.h

and binding update to use these macros.

Cheers,
Biju

>  #endif /* __DT_BINDINGS_RZG2L_PINCTRL_H */
> --
> 2.25.1

