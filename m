Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03635A0D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbiHYKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbiHYKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:11:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F7201B4;
        Thu, 25 Aug 2022 03:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZSf9/VARAljYpwDJelGB3MNYGXdAbaHZFxsmd3nm1citKnb8vm3U5UdB88OjAtL8W4Cb+RL8Yg1nnp2/atg5XuFNsLfTbTJBe1FPpBmKNC0kTPFRGrKB3aD5LVkOKbqkJoS3IASAj2JAA/tfYSrTiqjtH+Vp7Lz5cuC5LgDBP/q0+Sr2JUtdn7MDWB66gDAMILwvIKjKYER4EpJENuMGbI9113oBK1Eib7gdGJrdXhFV9zHlEsEZcsEoPXJK8mdrZhTHq0Awgc1DdAGNLd61YyzsE4C/TpAJcIypRN0z0NE/bYZFbaKvlC/8CfCt9xCL0mS+t5BOnkxYW8h07qA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0dOv8ofVukC1vLuq95gG9WHkmQTMMOGoqLMW6MS8gM=;
 b=BpEdDJLtfjXdxhglheE/Pmn0ky+MSuFz2VwK234w3no+MC33Pq6vWWoANO4Ze+muY69LAGa8M4zaS2yi4D5xpSE/EjcQGjawPsNONHj+vlxbscmRIFle5fwXO88p+ex6yEHxLbAQOv85+mMiqeF3k7rrVcoVL58PnuIHsBY11udZUBIX1GWnFuuto09UVwgMOuljL0GpuT7xbjD9mjUNzP6h1T86WJd0mV6WpNC8s4hQMLqsVFy4dHMbqCfEUWCOW6EsyWVKG6tZzEO9by5ixoQwDUXCOuuYcS8H2o/I4toVQ3vLNeRCU8AwxnussmHkjKB+ymFItxdv4aXBgEz9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0dOv8ofVukC1vLuq95gG9WHkmQTMMOGoqLMW6MS8gM=;
 b=I5vlW/dL84dGiPKumMu1g1tFsIoZK8Yt5jdCkQwxu7FHzLU0HN9/dJ8He4uAxhECRyaoUCXc09Ov1Jw8Y0EInI/t5UfMWLsxSkulkRd/gbgVTS3Nn+P6Zr7pkQSVSAOw2BEVhzFPEAEtOTLU8dn22gH41TfuQ58OhzKU9pHp8Ao=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DBBPR04MB6092.eurprd04.prod.outlook.com (2603:10a6:10:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 10:11:04 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 10:11:04 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Thread-Topic: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Thread-Index: AQHYsSoBdxZHPlON40a5XuD6jrx4qK2xDxMAgAmF+ACAAAMHAIAAZZiAgAEFDYCAADtTgIAAMAWAgAEz8ACAABu1AIAACm4AgAAHGQCAABCiAIABbHAAgAAFBoCAAA70AIAABnIQ
Date:   Thu, 25 Aug 2022 10:11:03 +0000
Message-ID: <AM6PR04MB60534851E3F8AC7C429762B0E2729@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823091027.ezyxkn64asajvjom@pengutronix.de>
 <20220823120219.GA203169@roeck-us.net>
 <AM6PR04MB60535EC5B774004AF996BDA5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824080338.humjny4fabhmx3z7@pengutronix.de>
 <AM6PR04MB6053D8E0A9AD24757095BFB5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824090622.ubbuf4doyul7d42r@pengutronix.de>
 <AM6PR04MB605317170101019C75BA9290E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220825075016.rhwvlfl6xv2ibro3@pengutronix.de>
 <AM6PR04MB605318CED02AEA616D820D83E2729@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220825090146.62qsg4ve4j62k76f@pengutronix.de>
In-Reply-To: <20220825090146.62qsg4ve4j62k76f@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 246a0528-45e6-4d68-45f1-08da86821e68
x-ms-traffictypediagnostic: DBBPR04MB6092:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bom+R5Id/g+uvxb5yrM1qO78pVi9egkyJ4fRAVB28N924lIS1BZrU8/xH3ZumqAXCSOBC344HmvsBkrdHbQAYZwGcWeUpidR/4fgm0tpHgGkHuaUKomXJKBHzJ93nBH0JRJ/5Gaasf2t4myiswORUwko2zxSc1eyNN+Dn3jTf2EchzpUuBJFaGIcx2WoWtdW2du3rBwXZRoLPJxLEXcesqEDK3PSjBndF5c9DtLWPAvUulI7c/+fD0BY9DovIvXnc6StjH/atZek7zQA9JWuTuDQ+1SjeWXWLrUCDosJW0oeiSR9Woi/7TexeJ7AHvuieczboyYg+bm1nI5HcLEmGQ4lLz7rR5QWdA6Impvs9CeQ8gZBRAY27mqKr4vE4WztJIG9H+0y1TP8OUpTy3TdZoXgY6niML3tiUnKaAZf5Ca0ECgLR8oEFlgSFPQVOlb0r/7sXvJ+7LUXX4/AEylLxL4bd12/YQKC7xgcuK3D3mZ8ty6TEX5oYzInU9tY4KdHwJbYOmjgixBVL0zc8rdy0Jr5D6hVmtoc7GnaJTqFANfWwmjCBRNNxXW/JV4EqAttx90frCnoC7aouhTsoAayYP/SNcMgZpAm5aO3CGCrnjfySeURdaSjoMEGV4yt5ZAi9NahrcA8B6WqikD68T/XLfp2M8MI4iCcs7XHydgKjOleTw5MYIyBpYyCPCuRBHLxhCfbvV77eMmhRwCojeHNKol8FzSbHgJV6ipJgjE9YLp1uCGMDO3jFB68jLVyPB8+791THk2huHSnapY2Ygz+9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(38070700005)(2906002)(83380400001)(52536014)(316002)(8936002)(6916009)(26005)(5660300002)(71200400001)(186003)(478600001)(55016003)(66556008)(122000001)(38100700002)(7416002)(54906003)(66446008)(41300700001)(66946007)(76116006)(64756008)(8676002)(9686003)(66476007)(6506007)(4326008)(53546011)(33656002)(86362001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CvDh04XF5TW/ip2wZW7Gud/chsxEtolWmf1Qslf6Dhl0COclL4n1YBOV/6jq?=
 =?us-ascii?Q?IkrbttAhx0xaheDZwzbK1JJTFX6lkMPcvfW/fDL4Xu0aTufkLhDgn5k4FhUd?=
 =?us-ascii?Q?/eKSnwRRPoRTNLj+skIHpGmqisNwZRflsxxx4L9j5aKlmQ2023p6Qh1+dvgE?=
 =?us-ascii?Q?Li5+KGuP1wirUPlOiDwbtDmnMR9NlVNme04B1qT1tnAZBTiSJ7XwDVu9xTEy?=
 =?us-ascii?Q?NMwARdfQRFknqu6/Inkzog/0rs/NXq1wSXG966KSLBc2FFDnm+kLlzGUIw9+?=
 =?us-ascii?Q?y0l6EGtpqXVI/8XAJYP667W+OOmAuQD4NuoiofNtobdiwarDSRGuaJbmI+ye?=
 =?us-ascii?Q?SG54Gl+gi84vLOjLiyVKob1f5OVKzfOWvB0Gk1dGQ3i56zygJKQ1f1E/dPcA?=
 =?us-ascii?Q?Rk8/1S+OBPJ5lTPGdHMEu/qcBYKGGi91Sdn1R7AcCmmtA8wJj9Xp/ZuFaqe5?=
 =?us-ascii?Q?ceh8kcPLa0fY/5HzHsnRz9oFmAgH8ZYcTqtJrpCfVuyu7y5CZA7fF4G7xaJ3?=
 =?us-ascii?Q?9vcKHLq+8gtB8UJ7KcfJ+ruPtG9AS9ndulf2MtohQjy66v7q6kijXcpd+6yY?=
 =?us-ascii?Q?owNqkMprfcJnt/BCGTKDlmLnt3lbqHKBx1/PJ9XbTRm5JTcKwPR02SH6JaTE?=
 =?us-ascii?Q?ARjUwTqB+UsqBuS9SI3Op3Ohe+CeElKb/X7i7/hgKuvMkM2jSZZvQ2ZWCpla?=
 =?us-ascii?Q?JykTmaxaHTHkxaiFGX6Pysje10IWDC4HS97eWz+UXX1KSLb3g/CLMngxpW5m?=
 =?us-ascii?Q?+Kwz1FVHlF+1qQ0mX5IR3VkTbdZpxDWHRcCxn8dLghKdgMK8t85xXW5qBuFy?=
 =?us-ascii?Q?gANL7Lei1dkRS5HJdxkzlR5ioqGMDAH1aldqCu5X07Axv6pAyQHBEXmtcuYi?=
 =?us-ascii?Q?JeH9/Nhvw1kel82avthEX72kTaMOarN7WxH7uDMbc2Vv13o/TKZDTBbgSApE?=
 =?us-ascii?Q?zcQFBN3iFplLFbTGmMrfrUfzkL7JVpp9EFTgNy0M/EOmmHeWboRfWI377UW+?=
 =?us-ascii?Q?hcB8Z+bIn2srz+BV20bo0VC7gvy5QHWIEzPiDYAZmfWd3bA4QBljnlexv808?=
 =?us-ascii?Q?NnkfEB+LBQAyxTs3YUlOYjKdZ8ixOGmzSGT4L7Rp9ENSFIzTot1HlcI5nSGg?=
 =?us-ascii?Q?BpV3PDUzOv7yMXBoWlI6NSutXLD4zNi2kKgjukWpOUcSFTH2EEKn74dm9g3/?=
 =?us-ascii?Q?/EtXRnLMkkW8lwDujNJ1yVCL17vt+9BIOLpJFcM3cme7jDrCM05pTfwnO29Z?=
 =?us-ascii?Q?aYpd1IqUkA7UMx2t8rHbtLF3icY7tEa5QR2/o2dBihU62uw4sgicVIkqDuPA?=
 =?us-ascii?Q?Jh6+xP+vcne/BXIU0GxXcP+9x+VJQffFr/me4ot9cgWhP5UqbYyfhcNsSfiJ?=
 =?us-ascii?Q?gsTwRezVNzVGcykTU8nDfBijWKOJKpf9PE5C7W+CLe9cPsTe/YyocpTD9fjl?=
 =?us-ascii?Q?SETYDYn5DknQOehMta2HWe9evT7txOKYEvO839ljp3vGonximTmx/it/PK9E?=
 =?us-ascii?Q?vty8br82lktl/IyoVHuZGQCrga5QPAYCDYKI1w3S+adtuyT1nYo4m2yyx7pC?=
 =?us-ascii?Q?WOfBDAIYYuwFoHSZWp763NKpk6RDo3ZkmW53/jvU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246a0528-45e6-4d68-45f1-08da86821e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 10:11:03.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1bjajDaaJA4deYYN1tIHWNuygGEF1FMXh1rTf7GAUfieEippCG2CqIt/jehP4t8yfChZK5rB1XdtH+0/XcSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Thursday, August 25, 2022 5:02 PM
> To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> linux-watchdog@vger.kernel.org
> Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory barrier fo=
r
> unlock sequence
>=20
> On 22-08-25, Alice Guo (OSS) wrote:
> >
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > Sent: Thursday, August 25, 2022 3:50 PM
> > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > linux-watchdog@vger.kernel.org
> > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > barrier for unlock sequence
> > >
> > > On 22-08-24, Alice Guo (OSS) wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > > Sent: Wednesday, August 24, 2022 5:06 PM
> > > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > > Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> > > > > shawnguo@kernel.org; s.hauer@pengutronix.de;
> festevam@gmail.com;
> > > > > linux-arm-kernel@lists.infradead.org;
> > > > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > > > kernel@pengutronix.de; linux-watchdog@vger.kernel.org
> > > > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > > > barrier for unlock sequence
> > > > >
> > > > > Hi Alice,
> > > > >
> > > > > On 22-08-24, Alice Guo (OSS) wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > > Sent: Wednesday, August 24, 2022 4:04 PM
> > > > > > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > > > > > Cc: Guenter Roeck <linux@roeck-us.net>;
> > > > > > > wim@linux-watchdog.org; shawnguo@kernel.org;
> > > > > > > s.hauer@pengutronix.de;
> > > festevam@gmail.com;
> > > > > > > linux-arm-kernel@lists.infradead.org;
> > > > > > > linux-kernel@vger.kernel.org; dl-linux-imx
> > > > > > > <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > > > > > linux-watchdog@vger.kernel.org
> > > > > > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict
> > > > > > > memory barrier for unlock sequence
> > > > > > >
> > > > > > > Hi Alice,
> > > > > > >
> > > > > > > On 22-08-24, Alice Guo (OSS) wrote:
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > > > Hi Guenter and Marco,
> > > > > > > > > > >
> > > > > > > > > > > 1. did you see any issues?
> > > > > > > > > > > This WDOG Timer first appeared in i.MX7ULP, no one
> > > > > > > > > > > report issues probably because few people use i.MX7UL=
P.
> > > > > > > > > > > This issue was found when we did a stress test on it.
> > > > > > > > > > > When we reconfigure the WDOG Timer, there is a
> > > > > > > > > > > certain probability that it reset. The reason for
> > > > > > > > > > > the error is that when WDOG_CS[CMD32EN] is 0, the
> > > > > > > > > > > unlock sequence is two 16-bit writes (0xC520,
> > > > > > > > > > > 0xD928) to the CNT register within 16 bus clocks,
> > > > > > > > > > > and improper unlock sequence causes the
> > > > > > > WDOG to reset.
> > > > > > > > > > > Adding mb() is to guarantee that two 16-bit writes
> > > > > > > > > > > are finished within 16
> > > > > > > > > bus clocks.
> > > > > > > > > >
> > > > > > > > > > After this explanation the whole imx7ulp_wdt_init()
> > > > > > > > > > seems a bit buggy because writel_relaxed() as well as
> > > > > > > > > > writel() are 32bit access
> > > > > > > functions.
> > > > > > > > > > So the very first thing to do is to enable the 32-bit m=
ode.
> > > > > > > > > >
> > > > > > > > > Agreed. This is much better than having extra code to
> > > > > > > > > deal with both 16-bit and 32-bit access.
> > > > > > > > >
> > > > > > > > > > Also this is a explanation worth to be added to the
> > > > > > > > > > commit message
> > > > > > > > > > ;)
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Definitely. Also, the use of mb(), if it should indeed
> > > > > > > > > be needed, would have to be explained in a code comment.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Guenter
> > > > > > > >
> > > > > > > > Hi Marco and Guenter,
> > > > > > > >
> > > > > > > > Thank you for your comments. I plan to enable support for
> > > > > > > > 32-bit unlock command write words in bootloader. In this
> > > > > > > > way, there is no need to distinguish whether the unlock
> > > > > > > > command is a 32-bit command or a 16-bit command in driver.
> > > > > > >
> > > > > > > Please don't move this into the bootloader, enabling it
> > > > > > > within the init seq. is just fine. If you move it into the
> > > > > > > bootloader then you can't ensure that the bit is set since
> > > > > > > there are plenty of bootloaders out
> > > > > there.
> > > > > > >
> > > > > > > As I said, just drop the "16bit" unlock sequence from the
> > > > > > > init function because the unlock is handled just fine in all
> > > > > > > the
> > > watchdog_ops.
> > > > > > >
> > > > > > > Regards,
> > > > > > >   Marco
> > > > > >
> > > > > > Hi Marco,
> > > > > >
> > > > > > Sorry, I did not tell you that all watchdog control bits,
> > > > > > timeout value, and window value cannot be set until the watchdo=
g is
> unlocked.
> > > > >
> > > > > You don't have to according the RM:
> > > > > 8<--------------------------------------------------------------
> > > > > ----
> > > > > ----
> > > > > 59.5.2 Disable Watchdog after Reset
> > > > >
> > > > > All of watchdog registers are unlocked by reset. Therefore,
> > > > > unlock sequence is unnecessary, but it needs to write all of
> > > > > watchdog registers to make the new configuration take effect.
> > > > > The code snippet below shows an example of disabling watchdog aft=
er
> reset.
> > > > > 8<--------------------------------------------------------------
> > > > > ----
> > > > > ----
> > > > >
> > > > > also the RM tells us:
> > > > > 8<--------------------------------------------------------------
> > > > > ----
> > > > > ----
> > > > > 59.4.3.1 Configuring the Watchdog Once
> > > > >
> > > > > The new configuration takes effect only after all registers
> > > > > except CNT are written after reset. Otherwise, the WDOG uses the
> > > > > reset values by default. If window mode is not used (CS[WIN] is
> > > > > 0), writing to WIN is not required to make the new configuration =
take
> effect.
> > > > > 8<--------------------------------------------------------------
> > > > > ----
> > > > > ----
> > > > >
> > > > > > Support for 32-bit unlock command write words in enabled in
> > > > > > imx7ulp_wdt_init now.
> > > > >
> > > > > So.. after reading the IMX7ULP RM, which was not my intention, I
> > > > > found out that most of the WDOG_CS regiter bits are write-once bi=
ts.
> > > > > This means if you didn't set it within the bootloader you still
> > > > > in case
> > > "59.4.3.1".
> > > > >
> > > > > So the imx7ulp_wdt_init() function just needs to check if the
> > > > > WDOG_CS_UPDATE bit was set. If it is not the case, then you need
> > > > > to write the WDOG_CS register as currently done. If the bit is
> > > > > set, than you need know that the bootloader did the job for you
> > > > > and you can exit
> > > > > imx7ulp_wdt_init() early. In both cases the unlock is not require=
d.
> > > > >
> > > > > Can you please check/test if this is working for you?
> > > > >
> > > > > Regards,
> > > > >   Marco
> > > > >
> > > >
> > > > Hi Marco,
> > > >
> > > > Rom code has already configured the WDOG once, so we cannot use "
> > > > Configuring the Watchdog Once".
> > >
> > > What? How does the ROM code configure the WDOG? Also this would be
> > > worth a comment within the code. Also still assume that this "16bit
> unlock"
> > > seq.
> > > is useless since you writing 32bit anyway.
> > >
> > > Regards,
> > >   Marco
> >
> > Hi Marco,
> >
> > The ROM code of i.MX7ULP configures the WDOG to support 16-bit unlock
> > command. I plan to add a comment to explain it in code, and keep
> > "mb(); writel_relaxed; writel_relaxed; mb()" unchanged.
>=20
> As said, the writel_relaxed() is also 32bit writes. Please just use the c=
orrect APIs
> for the stuff you wanna do. In your case, if you want 16bit access functi=
ons you
> need to use writew() function and you can drop the mb(). But after readin=
g the
> RM again, I think you can go with writel() since 32bit writes are okay, b=
ut you
> need to pass the two 16bit unlock commands. For that you just need to ens=
ure
> that the timing is correct, as noted in the RM.
>=20
> Also I read that the WDOG1 is only programmed in serial downloader mode t=
o
> reset the device if no activity was found on the serial/usb bus. Also thi=
s only
> happen if the fuse for it was burned, but the RM says also:
> "The watchdog is enabled by default after reset.". Can you please read th=
e
> Watchdog status register and post it here?
>=20
> Also after after reading the RM I found the ULK bit "This read-only bit i=
ndicates
> whether WDOG is unlocked or not." If this bit is 0 the device is locked a=
nd we
> need a unlock command else we can just write the config to the device. Th=
e
> unlock command can than be: two writel() commands which are adding the
> barriers for free.
>=20
> Regards,
>   Marco

Hi Marco,

1. Two 16-bit writes(0xC520, 0xD928) to the CNT register must be finished w=
ithin 16 bus clocks.
The CNT register is still a 32-bit register, so it is right to use writel_r=
elaxed().

2. After test, we found that memory barriers cannot be added between two 16=
-bit writes.
writel() cannot be used.

3. Software must make updates within 128 bus clocks after unlocking and bef=
ore WDOG closing unlock window.
The ULK bit cannot be used to indicate that WDOG can be configured.

Best Regards,
Alice Guo
