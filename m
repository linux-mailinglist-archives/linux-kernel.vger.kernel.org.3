Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E7580F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiGZJLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGZJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:11:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342019C30;
        Tue, 26 Jul 2022 02:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8QzE/NqoqMLtoyglgmLuVT5Y8cNaUBBPqzxAMiUjfS64M6aoexpre6U6YcVepaBoFrsamuFu/LW2UWtNUT2yIO1ii1zpvgqg0qOfNv2kam174MGqh1A2MpaOhp5AWWbaPXxaGZJairzK2qYxWApYHR/U4lE1m+k6w+GzG74fDZeE+WVFk7BIl1KYPhz5Z38T75KUCKgRADoHXeO+fWsyu00A7JODFVuQMYTysyEbLY6ZEa4+SyF70ji4KEE7ZnzsWhac7+pyW0SjSeHNS26pxITmeKm1W794fqm9JywieGRUGrmgGLac3Q7hPi1HRZ8sygdxj7Ab8kr/ldLYr6lvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtgfsU1ARQ2UU5ayMhhxccnKvaY7SgHxEPFVAdq0FWc=;
 b=XB16NDk5iWcUxjD2oGnKrDqldgDE2R2ZX0F2YGvUPgandu1DCr57WfO1X5+Br5yhrQKA9JVMuWwyOk4VnFGUtI5tRe98mNiyeUhgVWExwIi3exFaSuBC6qxpD/PTeutpauPgPW+DCvzApE4KejS8+xDJ+8MWRW/8s90qg1l0PQthFvPe3VPeav04UkN6PqDrKdq0COwpG0heObIn5QReFTDhJDA+Lipcfv5p65wn52t/PIWYb4ItPsYQxBjE2r4EGhkfXVZeMBMTLsfskJdQyHiLH2Lp2cbIDYBCWotdEmK0MspqKqnedKx0pWNQTlSid5RJ1Gv7L28E4TEcFlr2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtgfsU1ARQ2UU5ayMhhxccnKvaY7SgHxEPFVAdq0FWc=;
 b=QNIZAP5cSazyKEDL7nq7svLtpVawm4+2GQNlGMPn9KtFrqbbuC8Xd1FjiqBjc/J8f2bYk67qci7EArdN0WdUUifMZ4hppqw0l7qIjABeJICmnNtae5N2kOYCmPADNhqqoNJh+qsWKNLSNOkmTc2EXhoFjvDwDR9VNlT7fTjIYYg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 09:11:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 09:11:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
Thread-Topic: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
Thread-Index: AQHYnnhx6HQy9b/Z1UqXbelGtR85J62Ph3EAgADa6cA=
Date:   Tue, 26 Jul 2022 09:11:47 +0000
Message-ID: <DU0PR04MB9417D5C57D14F1CBA4E5F06888949@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
 <20220725200740.GA2610621-robh@kernel.org>
In-Reply-To: <20220725200740.GA2610621-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e2602cc-8f92-4fad-71e2-08da6ee6de29
x-ms-traffictypediagnostic: DB9PR04MB8347:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6SqosQgVDPxKZt6BzOkgEdrTB34lIDejkW4boXMErIJyA8OrdHvU8A4clHDgSJ4ScyRe1CIzQpFuOyL0IEnERkffCGcM+L76Y3ZoOWpMD0R957e2UYmtiOY0FUkDGH1sVE3AHOTpfnkpeFN0rVkbQfoKWb8/WL3JhgFpWWeEsEjIXyf7RTpPpraL8mFiGJTq2a6YxWzGx6kkLaKvM0KdyFPqWJ5lMn7mnuque63CM9ZydszqQ76gbyt5dLdOXFkN5mNcVpNAdwhH6i2h1UulG6aRgywEfDQakGv0CAoUobcEPm3FFEOn1Qynh5dEukx5W4PHH4RoxYWcw8TzpgAQIeRSyGYy7ZyAJvlBu6HJ1/TuRKQBcsabUx3mV+PNmnqDIQu6WlyVeGSiQBQsT0SM4NYPIku0d0N8AEQWdznp0E8mu1xNA7xcmPWslEBFbV2dgjAV1hJ4/jPYQk8hOhJiigz87bQBSb2Fw7xJGpCoWSm5RTd3KYR9z/65ZUj5dTH+icg6IDctu9lQ1UyuL9qmchCpDy1IQiQlx7iNvFf7a7SxaCaEXj8w05OQ9xUHRLlcvX94u/78BK6SnPf/SdOBoj3b7K3RXHIRCfz9GYElAxsLtiGvfPP6Occ2jVwRdzWslispBwTzDedbei2qMyarK8WB1JGNCaBk3TZh0vakTV8kIDeBjM6vu2Rq3z4Uc3iwEN6sQBCfrCNpc93FxhcSH1Z4eVUUHpJKWLPuzpbme9lCrklwq3mNAUkJl4qi6Fsbs8uMXgj+/IZ0aIlxthN76Wx7T3AtfR1nK4ZwBCZFSbaFX9CVq48bmwFTWFyEtj/4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(44832011)(52536014)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(8936002)(38100700002)(86362001)(54906003)(33656002)(110136005)(7416002)(5660300002)(186003)(55016003)(71200400001)(83380400001)(316002)(4744005)(122000001)(26005)(478600001)(9686003)(38070700005)(6506007)(7696005)(41300700001)(2906002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z6BQ/nW+MrTerCKmpCKfdIX7KEiraRLT0h/dl7F+NHQkZRIEA5n1mIlqN+NV?=
 =?us-ascii?Q?QRSBRGh5bOEBAJJaHvQVvQLH1kDBg/Ah7T9iJOrGFcx3xjvrcLO5XPfLRyxn?=
 =?us-ascii?Q?UWVZ++xnoQtu1I6ZVl7gu8UoCdwVmKfNQxtSYyRafdcqF9U7aN7WO86e4+Ir?=
 =?us-ascii?Q?m9JyXUpi0te1n0DN2gpYeaodKNa0TpplJSv51XVbKIRX+cNULj7pamm0z6TH?=
 =?us-ascii?Q?ZRgu4PMLouT9C13Sjuh0Lg5MgXulrF6w0rKioARHypwTK6s5ETNXyuNstvFP?=
 =?us-ascii?Q?CsZK+nZX/MK7X9xrPDNB5yQfnQggWkdM4fOe8HklFNKwU57xSJaAs4P1sQvP?=
 =?us-ascii?Q?rNW7HmDZTWnBS58b0IbNcpRoBvImhAcg+RqSETVX+0unJTbgAzVxjGsrgV0K?=
 =?us-ascii?Q?tViRxjGPaRo7n86cz2u/o5divcnylOGOjT7ebhHRt5mHklFN2rCy3Mf3iZwm?=
 =?us-ascii?Q?i6GYMShdFm/VEabmoG5hW8/QNHvr4a67NekpEwkPaB7BfVxs8ZPo8nOPP7Ll?=
 =?us-ascii?Q?8Dh2XZKkxOgTmEemhW7xixPwJ3SlaH5wcS5Pjsa8zjXPVuq5/wwAaXwk2sSS?=
 =?us-ascii?Q?jpdqDa5NR01BHCM1nKTIMf1FC+BLiYUJqJvqERHxT5Ie/aKlbUXE/GNkMgxc?=
 =?us-ascii?Q?DdcgySu3XcJ6DiC5NgTC+R6UA0C9EHhd/gx7X9lW/9PZucAEFncRIMwLS/jc?=
 =?us-ascii?Q?0Dvk/Y9+7A7HiEAF6GD4hBfdZBvs7sJbJZNWAIbWBFY46V6l03WWffxT78bT?=
 =?us-ascii?Q?vHWtWi7flKCNBQ9KtKE7jJfNsUHrXmgCHv+ffOdRmApWae2u+t7lKvmRQiFl?=
 =?us-ascii?Q?50ObSoKsHLQB9IHEvSt3HEtcMQPMesOQ8Z2yzwnJzL50lL1TtAHKIVTDa13C?=
 =?us-ascii?Q?thTYvKZA/h0JY1tn3s005jXUjgP3dXp4G1K1/cxXNAr57J69pLWStuJxL/U7?=
 =?us-ascii?Q?UdVtN3V4D1sWT1xnXJfvrtCnawnrYgKFvdy8MFW8yaKJOSy6o69+tVE1ONIp?=
 =?us-ascii?Q?+gyegwTbnpH83WvBhaLQ909SESBOxQsAqbwZflq0cwXmOA25C9S5TqNJ4wzm?=
 =?us-ascii?Q?NwNrpzVNESx0dmQ4efwgFKYyaOSfkqDzqqMvJYCgHRs4FEO/Ff56bDvOgHvD?=
 =?us-ascii?Q?epy0u1v2loonOT5z0IozY0KKyyBCT0k+eQdl79qvBuA/oXJHLrhIKL49xis4?=
 =?us-ascii?Q?Vurlexp1/xaZTweByqProo7dtI1BpsTY6sr4MF+7lh+p3DmBK4dHmso1Wcbz?=
 =?us-ascii?Q?yuDpRy0fVzIg9g4GReZFgOto6LgR9kt7DEyqOj5VBqv9pzYxFi31R+sEN2mN?=
 =?us-ascii?Q?5GaSgf8oWKnXTpixxPZqcho9FM73xzGTFntGnzOWNdPdiZu5wDJiwDsZ3s3x?=
 =?us-ascii?Q?1LDVvcptRsL0hBtEGDP+zaDJqYP2qBhoBFqond5vNu1upJ1PB5Hc5ONtWAvh?=
 =?us-ascii?Q?YmS61UwDIied32+XXz9ncx6iF4vR69V/NigMrhm3PVCoxxPsPobieKGLgYTy?=
 =?us-ascii?Q?Q1srluWsSyn11u4aupjl0KYCubtJWRE2YYzwW4wIka3mYtSdnAjBukcWuKuI?=
 =?us-ascii?Q?JJvAqSJmjCKPyaJfjQY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2602cc-8f92-4fad-71e2-08da6ee6de29
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:11:47.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUz3GNLCu4XJjn7QjX69+iTtf3Dl3tE5tgcgi4KEtymOILC/SSEEyQDW1hCdgvlxElqS81SuF4P0lgW9HtqkAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
>=20
> On Sat, Jul 23, 2022 at 05:43:26PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There are many warnings when do dtbs_check: fsl,pins are too long, so
> > add minItems to address that.
>=20
> A single cell is not valid though, right?
>=20
> This particular property is problematic because each entry depending on t=
he
> platform has different number of cells (5, 6, etc.). A single cell (minIt=
ems: 1)
> is not valid though, right?
>=20
> There's a fix in dtschema min branch which should fix the warnings.
> Unfortunately, it just strips any bounds checking.
Just fetch dtschema and rerun, no warning anymore.
Regards,
Peng.
>=20
> Rob
