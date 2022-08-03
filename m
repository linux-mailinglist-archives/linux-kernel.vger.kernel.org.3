Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073495889E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbiHCJwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiHCJwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:52:22 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50069.outbound.protection.outlook.com [40.107.5.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15905A2F7;
        Wed,  3 Aug 2022 02:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqYl+d7RL29o6d0IGqtV28ExVqJmH4Y0tiVTiTKNl9fvmsKrFZ498VYJ10d2AxABU27Q7cmXAffJoH4OtdRcGG3ZOmWO5rPpwaPhrXQm6D/nocJWm4LYEX7qSXUHjGzazzAzWglbRu4w3i3HrdM49nv9cht3oQbFiUL8LqUoajbpZO0422pdp2ZJu2upHTlkVwYR2Yll309Pezye41TVCJsvP4IPg6UbdHzzIzjIuW7JCS037tEq8ptjcMRcyusf7+2BFlCtosZvWBdG2ml8E2t1IoI1a4cf1RIvwFkizSsQLkMNxdtNiRvC3VcsSHZl3tZncRdbtot+XMZl7hlBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a/sx7f3vTNtUDw7N6gMGrSh4I3BAb3BV33W4m8HhmA=;
 b=MmWWmzV4hifEM0bRuggkmpAt5XQA+9m48NEc4OrIrYbANU9o4GCExvCejp1n5vif0T5XoIHAQ8moKQH1pyrw91iYcUvK6ZZ9w1wQOLhuCrEpojpMVyB7iTr+P8xdkeYB2WQ0kJ81vxkqw0B6g64oOZ/KYA9H0eu4a2eF15YXv+3bnhVSqi+5EDfBcimGK6mVP6rX61VqMgcAWiptUWFOBcWuJoFOlFEb4nzkkcWRdFHIAFOn3cK4mV7Cm6B3OK+0mtvj3mmL406oeHHlkzZjJheuxLDV9LQkbAGRUxZLFBwoFgrIR/sYxUikLOQAmaMJSMO80ybqEj3/vGdmbNJcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a/sx7f3vTNtUDw7N6gMGrSh4I3BAb3BV33W4m8HhmA=;
 b=o+5icGM4p6PrrPu2m57OPGw29xKyQXZZhBcz4701Ph3tu+Pff6kEEATOZhtnRFav9Dc45BnSdrU+zz2SJMKdpbG8Ms4hl9zOt0LAgBiFZ5dOC8k6Cmr1nT9si9GIGlu2YAm9kNTh91HQ40bpGV7vQp2kIYQ0GjAMtBC/hQWEY4o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6945.eurprd04.prod.outlook.com (2603:10a6:208:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 09:51:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:51:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] arm64: dts: imx93: clk update
Thread-Topic: [PATCH 0/2] arm64: dts: imx93: clk update
Thread-Index: AQHYpx5WBQqWIZwTcECbPYrfzyS4L62c7w4A
Date:   Wed, 3 Aug 2022 09:51:51 +0000
Message-ID: <DU0PR04MB9417AAEE24D03B7ECA412342889C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220803095103.3883035-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220803095103.3883035-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a1babb3-b14b-4748-9bd8-08da7535ca1e
x-ms-traffictypediagnostic: AM0PR04MB6945:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvgsoIMUpHOK2eCJIgAKs/5wU36123QWgV5IrEHexOR7917BKCuuv7mPAm6JiybyWBVmo8HZN74vLh1bOFczcx7qnDykoKyVQuaa4lDybBMWIc55MyQeKRr+TlzN7BOA/2zcxKayNvTQqFRaNM8lGEO1Zr/niXEwXAhsvGDwLcuTWbYMIR/x6Xa/5Z97LgtVofJMsLJfMGPbiiiQ8kdwKd9ZnCqPcYZaSoSU1TbzSmM1bElZ3QLa9GY0QvWLemowZNGRqKWv3dH82RilRDSfSbbpBWx/5JcsR2kJLcwg0uY2zeLkkWKdFBznumDWkUbG/Tha/9kakkARPsktCHD/C3DNqFk7bVK8daIFUkjP2EhUB36QnyjKB5mp8jm4zZod1ohONnZyB4vx5isO448czSL/S0Eq5BhS2cabOcVzaAMSQ1gg1de/p7CAp9p3jXPwTDXqQKt2wx3WUN1//3LKcwrLdp6aXEL4WjRpIeULQ+go2hyK4X9BXitVI+tWcNpwhXpSCObzYCtc9duaixGcRIXk8rXk8Dx7BUx7mJwwp/mrMTrS9tqqHx6yrvV2zIVzFEjGzmqPuZ/cLKA5QunRFLHHzuEsGkHkGfC7w3LcULCJCRKrk/rLnyheFXVv2ewMFoPGJ3vu77TA/dfLrWsMfAe7ybZjyR9xDWucy5xLhAKl1YIFGgVhBIs5VLTMZzui1rMLOeueK15syzKGKODE3s+SvJaNaXuAmPf3m2KFo7Qqfz4wDQTdYZW1wROCdh3/YCq8UH+GReHYUTHoMLEJJ0nQQW86knV68X8FX0tS4epXEpwTsovSuSLm7Sdnwiaf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(38100700002)(122000001)(6506007)(7696005)(33656002)(66446008)(76116006)(44832011)(66556008)(4326008)(64756008)(38070700005)(66946007)(8676002)(66476007)(9686003)(26005)(4744005)(83380400001)(41300700001)(86362001)(54906003)(52536014)(2906002)(478600001)(110136005)(15650500001)(8936002)(186003)(5660300002)(55016003)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Re6Y1j4TkQEIR4ufwAwnXadv00LK5sVtLkAu038uKt7TKnmrr5xzFyMe60xI?=
 =?us-ascii?Q?AUhA72z5JeYT6JT9Y9oIEreySnzvf/0kdi4ZCKHZkR4vn4sXoYkEZ38BP1rb?=
 =?us-ascii?Q?VgqKDJToyNMg86UPUySk7hZ74RMPUG2F7D2FaFRQVUBd+y4bPrZbAauxwhnQ?=
 =?us-ascii?Q?oX7NcMB1P0FGfbYiG5p4JRfKqgklnYZbNmH1XSOnuYrBpUTGkbs+3G7urR9G?=
 =?us-ascii?Q?XH9r+5xrpdtsV9sx16XvFOdEMkDw4LyuWC93hv+eMTRw+SGaPqHHnVLxn+Tb?=
 =?us-ascii?Q?gHd4cVXlCONrkf14XmEnoCVIBCYok2isfRU05/LQN78wKc8LqovtFLN/ZE/Q?=
 =?us-ascii?Q?ZpmKaWzrmVSCrYVkLfw+fq/HWUCox3uDUjKEK/P3v+4tFGbAQD48TdErEbys?=
 =?us-ascii?Q?mJtGyKnMijP4g8Z72tpHQ4j6u+z53pcp4JnO1T8dlzugldDP7UYH8Gf3bwOX?=
 =?us-ascii?Q?4yFI+vMFIezEXBCdtfSQme6G8w3A5zJYWuksOnGBBkBVFl91zUcHlHws2tmE?=
 =?us-ascii?Q?6aHTes64Vl1vDY9k82kAzyd7C8JHIub+dTEHGUSvaa/FLt47iSvcWA027WLm?=
 =?us-ascii?Q?zVq4g9VS8wwU1qOC9bNZ7K8O8C+0WGU4HNgQUipI9rqn3PkXb7zZO4cwCxqX?=
 =?us-ascii?Q?DF8zVFtsQWlLDm94qlpo9Xw7FosN11LI1n+KCwXtajMMYxRQ8PEqeCMaSjyN?=
 =?us-ascii?Q?JwnIRahTi9LBK9u4AN/8pafeX+XC+hvaHtEBFrWRxgDXd2nBfgrnxKiZdeu7?=
 =?us-ascii?Q?SwFzth5jvaqDPZEuLTdqKSepffdFUQWBEbo19UT80PM3yoadzZ5D58vLAIjt?=
 =?us-ascii?Q?k4YcVZwpY+22wBwnjAozk0wDK+qh21524Ali0u+QPuIrHi8oRanyTlln2hlx?=
 =?us-ascii?Q?TOo+wojs4ui3Chlhz6OfQgPGkSlnrk3YdbA4HbFXc5bp0pAxS82seb7a5fVG?=
 =?us-ascii?Q?MNh51nQrBJY66BCl9GR/0sfcydhB5CFkP2g8jYFt58S6HUL1b7/qHZBc0udv?=
 =?us-ascii?Q?Lwijxwza7Hh5LJUSZf68Z8tTLJDc5jCwTdJXtNquveEwiRQyk50TISbpGl9f?=
 =?us-ascii?Q?oZljVJWexJrcLCJcbmxxU5wDEwMTbfrNxzPab/cZh4p6F41aLok3wSNVZv2y?=
 =?us-ascii?Q?vCcE5YUuSBUK4mXxQ0xUgF/Ix4PGzKxJ2oAUM7umWInmETbSc67YObbzYoL9?=
 =?us-ascii?Q?ONFyBhwulJrRhT+PodF7YyFA0i81Wxvusz3C6wkFahoyaDWQ3JRIEkEElNzD?=
 =?us-ascii?Q?FVV10PND1ZPjrwKOMaOtn5fIeUihjdrufb4GV9F3GrwQY2JHK2DwmSu6ZYMJ?=
 =?us-ascii?Q?7U31fSkDp55tqDaH1gkLNnpYceoql55yjmMA8erk+/X9HQ0ePcNBGHemK1xe?=
 =?us-ascii?Q?ys3z6Yku55gMjd3HqnvlfCffpjRPEyAL4EbytBrEDL9DLx/3zfNav3Gl2onU?=
 =?us-ascii?Q?KE0osA7Ic0ndPq/eH1C+0mfEfGpExFuyla3gSfvQdB2xOTaROycCH8P6Ftf8?=
 =?us-ascii?Q?hSDjsTfdqiXm7Z5xqMLFileQuTg527nU+E+GgOqF5ZuFJgPfyXVPoHa7pHha?=
 =?us-ascii?Q?Y2tstxtiFAoVQBZSIiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1babb3-b14b-4748-9bd8-08da7535ca1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 09:51:51.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+7z+ifSUFId1YQZq+e8+nE+hZwJgv7LDylV0InqJMap/bkwsxHzXw3Qm7VK1lnyUpTSt5wsEHlwzVmIWe2xwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/2] arm64: dts: imx93: clk update

Please ignore this version, push button too early.

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Correct sdhc clk
> Add gpio clk
>=20
> Haibo Chen (1):
>   arm64: dts: imx93: assign the correct ipg/ahb clock for usdhc
>=20
> Peng Fan (1):
>   arm64: dts: imx93: add gpio clk
>=20
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 27 ++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>=20
> --
> 2.25.1

