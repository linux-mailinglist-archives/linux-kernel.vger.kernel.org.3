Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B35A0B12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiHYII3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiHYIIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:08:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E89A286F;
        Thu, 25 Aug 2022 01:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CO1N6G9MXga3+f9mxCuRlIPcAhlT2WyeZPeOWwqNKCvNk6kY1QzUzvlmcTLemYSDN3KpoxW8PJKn4OK0Gn3gkp9Ym8vVxjYdgx4SNRkjSxzp9rVsL4WaO6JtflNtiinANNXhG6zDG6PYzXK2ICGn0SJRC4OwoC0rXBcazdFllM3DrOPv0WemNf3WpR0f8+G/FCiXWlL5HX/xUZY29JFJMESX3P2ans1VCQub9pj8ZmHZpL5Wmw4BXq7lDueUpuimAF8YRaAjYuOxXH2tgO24RqCticWToDPg8cewVPj5/3lJoUXUQCiPVEpSj+J1tnPPnlNbDeUBK8092qNM9NMNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSZoSNtu/ZnbXnASzxibB2FNN7dc+ABalTeM5geuk10=;
 b=RoIGAe/NRuEQbPZPYTfT96cZZoP05IPbNy2EvAvwJ87ix2eG+cVsMlFct42Xvotux1JTjWhihWStJAqZDrzLr5/aVUN7En/IqEm/18cGTGZlhP5DtnOnbajczAQj44VuzGhEqB6/Zh5Hje0Boy/0aIIFe9Lp9FQf4ZGfH1rStmtfv/8Flnta5Uwkyw/pLimbPNEchIDkyD6PPsD14o4iyVG1kPwG3zO5Il92uea5keqKill3l5mV4N3CF2H9EjSx+aTwWmd59EaOVZWx7/r24Vi4NbcVozo2N3DNA6Puyowo5UjNf5/xQA+3df/1hSHjN8hIygYfZ4dSzT+SN59p7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSZoSNtu/ZnbXnASzxibB2FNN7dc+ABalTeM5geuk10=;
 b=lqrYKb+AM2yWQwOp3SCJ9Id/Vj4zUNyLLiniGSJ7O8cvpeCjRaw1GGR4UN9u9SDg9JrHxOYlVYfPwDFrIOBaUftJv+qIAPtnnvTcGdPm3LbopTGB2r+c/ClGAzAA9/PE++vF1qTpUKTjZnR29iqtAK6exuAGdM6aZ1vKQYLrpqE=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:08:15 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:08:15 +0000
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
Thread-Index: AQHYsSoBdxZHPlON40a5XuD6jrx4qK2xDxMAgAmF+ACAAAMHAIAAZZiAgAEFDYCAADtTgIAAMAWAgAEz8ACAABu1AIAACm4AgAAHGQCAABCiAIABbHAAgAACppA=
Date:   Thu, 25 Aug 2022 08:08:15 +0000
Message-ID: <AM6PR04MB605318CED02AEA616D820D83E2729@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
 <20220822140347.GA4087281@roeck-us.net>
 <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823091027.ezyxkn64asajvjom@pengutronix.de>
 <20220823120219.GA203169@roeck-us.net>
 <AM6PR04MB60535EC5B774004AF996BDA5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824080338.humjny4fabhmx3z7@pengutronix.de>
 <AM6PR04MB6053D8E0A9AD24757095BFB5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824090622.ubbuf4doyul7d42r@pengutronix.de>
 <AM6PR04MB605317170101019C75BA9290E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220825075016.rhwvlfl6xv2ibro3@pengutronix.de>
In-Reply-To: <20220825075016.rhwvlfl6xv2ibro3@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ba5b0da-7394-40f0-7d04-08da8670f673
x-ms-traffictypediagnostic: AM6PR04MB4293:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8EQMtqEMEBgiD1MRbQTehaLoUq3lBu0AHX5TRcdy0PR61Mja/mUIglXjanugBS49cDuAY0us8BAvFPZucqf6f+LIU0RCamw4Vq8XQ5en6pFygenfC5l+yYTiTTHx/nI3qSMAleeL156svi1YW2ZBxpNnRTnu3SzW5F1RiGk/apNMcR83YsOJts2bxIg7HKWhzX7MGkr60dwaJaFMVGU8n+4q+TtYUp4Ouq3hU0eLmOtLBTDhi8/1VcsjfSwBAqYd3vcIVzKhHjhOtHUhe0nPMbNbDf/bYESgM/og5DXtZzPUHbhZkB2VKUL55GkcoKxs/3Mr64fVSZXE2qvwFjQ5ctm0IHOJQgsTehaxUsgb2toFjVV9LYNoqD2bmVanvogIYHf7THKAbZF0jesv4M0MMZhd4CAnsmCJbh38jePrTMHC3V/NPLP/vyvoKEfhVtNFAl9+NkZoS9ku6LuvkMW2eKRl1ZnkRYJXX6HYVtY1/+Gn9pduUfd3GpEYw4TFn1CvaIVMoXsOyitHbdAf+IH8gJGv1jVFn/hTKwFeEZZKW6NeCiGSPBO7LLmnGi3sJz2ozFZkU//VZl8Lo5tG6QtMk73f1tY9vMTQf1fjWsFRsCfX6IVYCOCgSPXp6MWF1vgVtoTpRq3C+tShWF97jmdVoIBREGidMA5sysiXQ2bnjTxYvLRuHff95+X+R0vd55ORKTe2stXV+XFJrgg2NuhYz6dGrcMQvuTs7bcLMHSi/QyfHc8yXfvosx0XgNRE64lfTuAJCegaSsNm6Ld94d5STg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(55016003)(6506007)(2906002)(41300700001)(86362001)(53546011)(122000001)(7696005)(71200400001)(38100700002)(316002)(6916009)(54906003)(64756008)(66556008)(66476007)(66446008)(5660300002)(76116006)(66946007)(4326008)(8676002)(478600001)(38070700005)(8936002)(52536014)(33656002)(83380400001)(9686003)(186003)(7416002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Jx9IAotEQXMZ9SlE+YTWFmVMhT4Kim89PVD2MAVN/9XC0f0c08huHefNjIt?=
 =?us-ascii?Q?GKfEESIqopXbvH3vD1sBiQu28cjL7f3BC5yYVkJlam8uJRGLciF+i//JcL+L?=
 =?us-ascii?Q?fVi6pMtwthjS0zV68E7qM9N15wvYduOsRX8h4nJsE5VPuLZXqzoaYVqfjfkP?=
 =?us-ascii?Q?GxJ74rubvSDOqLAldAoSgtDiqXo7x0DLp7e/SvtktdgwFf8REFcnEtghXSBE?=
 =?us-ascii?Q?w4/3X3bKHkJp4OZKvM/H0cRPLnNzpfsGtl49Ubh751fBE1aR7AG/zCZJaRkV?=
 =?us-ascii?Q?HguDToclyv4NyXro38aO5HemG1x5GIGy9I5st6HmhS+lb5wVZ8HUswYYhJra?=
 =?us-ascii?Q?IKJk+XkX6sZDgMUZKrmv2O5UCnHWwpAhgrab4Dy5TusdkqabzTahfetaiTZ0?=
 =?us-ascii?Q?09H1wRLDl0zhqCZpxiNU7MSKq0EoDaMUH/yGkbQhL92nNRLRm9RJWR0GSRg6?=
 =?us-ascii?Q?VwIk57U1uUGrbQea+j3aHYy7zRthfUfFKr7QTjzBRLZca6eZo+ovGBQbeqWA?=
 =?us-ascii?Q?YlNA3g0trNgknWWpHNxVE9kBa04Tk35CE8xS6xGFwnhFp/AgWdZGrlfI+Dsy?=
 =?us-ascii?Q?grdOpkr4/I8qO7Jl5omHmt/hgvxvAeg/L8jgiqKiPPMQIFt9mMYaTWkT1rcn?=
 =?us-ascii?Q?6m9g2N7LZTm0ZRETK5IAIJptCbEucIVcdk1YBcVl8onlCRauRX0vDldNFquJ?=
 =?us-ascii?Q?DueAqPbpLoanGhnbtfo4HlYVRzx2YdXX1QusmtezaQ5b9UMGG1TXECfIWVPC?=
 =?us-ascii?Q?vPqmxNuYdFB2fH8HGtcqJXsBCy+Z0CLw9GCGMgZkWBELu+vYLlTwvTf5GtVO?=
 =?us-ascii?Q?4YcVuxFlNqFJqhuBkDrqUUHDIT+ORt49EhOjdazNK28cjz98TryMZ721czYb?=
 =?us-ascii?Q?OSwXfjxR55duaXRV3JQkUTN/aU2XARv1/LjICFQFSuNGWadtt64Cyqvmef8y?=
 =?us-ascii?Q?fmSB/wYpKymvqMah2gim9n9lY58UH7qytQgdUK/DI4bLlbwcQZUBe4XHJtKn?=
 =?us-ascii?Q?o2QoXt0YgRm96H/3tK2w+1/QBQOv/+DYb+R8ZQGOKbnAzvLDnp24U2pAnJPr?=
 =?us-ascii?Q?pGrxbiF/L+t7KX93VQnKoaGsxsGknAJlLxjp6kzSKSE2+bRgVd5ZG5WsCX5H?=
 =?us-ascii?Q?7L6wHFEYxGIPYSGxd9uJ9czLypRrbQu/3bWYL9rGbIdVAwtBoMtE3EN6kUgv?=
 =?us-ascii?Q?VBHyzU7h1Azf/1gaW2+xVKk3U+qFr55hvr+w8akPEJ/u15eQbHCLiAK2XgiF?=
 =?us-ascii?Q?3Z3EamyZ1JaqkTqGJfHyPKtDyPCxCeH5gbGGBXDfd3/OWII1n9pKkq3ckwi9?=
 =?us-ascii?Q?u24qmLMIE7v5xDcpDgaPztm42jNXj3kjSVPygheAGWZD0uCWBSWiy1TRB185?=
 =?us-ascii?Q?aH+FH5vdwIZKDYeZrtdFAQJxEjxjZ4TqSl+sFKNwyAfBFltyjQCILyR+a7Z3?=
 =?us-ascii?Q?+1m3ENHSbi0nEBN/XxyGt+OArVeGVO56bUGcrq1JZmPyrFbJK8r7EFFOrqnw?=
 =?us-ascii?Q?Gg3jOIiFgRQ9dC729DC1QFl7xVvvQCOMC/XQShdCy9GNOR70kyH8qUJ/WASV?=
 =?us-ascii?Q?OOr2IaYzkt7pc3iFACnbpg+YHMVvkGZ7Zg5pJVRZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba5b0da-7394-40f0-7d04-08da8670f673
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:08:15.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCyMtrgXSpQ0yC/sK7qlAyIzuK0Qc8NjQqlLgjVFCm1brzLMNcF1vELqsGE4A/FJSrPkk0OptDrDxswl2p2dpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Marco Felsch <m.felsch@pengutronix.de>
> Sent: Thursday, August 25, 2022 3:50 PM
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
> On 22-08-24, Alice Guo (OSS) wrote:
> >
> > > -----Original Message-----
> > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > Sent: Wednesday, August 24, 2022 5:06 PM
> > > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>; wim@linux-watchdog.org;
> > > shawnguo@kernel.org; s.hauer@pengutronix.de; festevam@gmail.com;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel@pengutronix.de;
> > > linux-watchdog@vger.kernel.org
> > > Subject: Re: [PATCH 2/7] watchdog: imx7ulp: Add explict memory
> > > barrier for unlock sequence
> > >
> > > Hi Alice,
> > >
> > > On 22-08-24, Alice Guo (OSS) wrote:
> > > > > -----Original Message-----
> > > > > From: Marco Felsch <m.felsch@pengutronix.de>
> > > > > Sent: Wednesday, August 24, 2022 4:04 PM
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
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > Hi Guenter and Marco,
> > > > > > > > >
> > > > > > > > > 1. did you see any issues?
> > > > > > > > > This WDOG Timer first appeared in i.MX7ULP, no one
> > > > > > > > > report issues probably because few people use i.MX7ULP.
> > > > > > > > > This issue was found when we did a stress test on it.
> > > > > > > > > When we reconfigure the WDOG Timer, there is a certain
> > > > > > > > > probability that it reset. The reason for the error is
> > > > > > > > > that when WDOG_CS[CMD32EN] is 0, the unlock sequence is
> > > > > > > > > two 16-bit writes (0xC520, 0xD928) to the CNT register
> > > > > > > > > within 16 bus clocks, and improper unlock sequence
> > > > > > > > > causes the
> > > > > WDOG to reset.
> > > > > > > > > Adding mb() is to guarantee that two 16-bit writes are
> > > > > > > > > finished within 16
> > > > > > > bus clocks.
> > > > > > > >
> > > > > > > > After this explanation the whole imx7ulp_wdt_init() seems
> > > > > > > > a bit buggy because writel_relaxed() as well as writel()
> > > > > > > > are 32bit access
> > > > > functions.
> > > > > > > > So the very first thing to do is to enable the 32-bit mode.
> > > > > > > >
> > > > > > > Agreed. This is much better than having extra code to deal
> > > > > > > with both 16-bit and 32-bit access.
> > > > > > >
> > > > > > > > Also this is a explanation worth to be added to the commit
> > > > > > > > message
> > > > > > > > ;)
> > > > > > > >
> > > > > > >
> > > > > > > Definitely. Also, the use of mb(), if it should indeed be
> > > > > > > needed, would have to be explained in a code comment.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Guenter
> > > > > >
> > > > > > Hi Marco and Guenter,
> > > > > >
> > > > > > Thank you for your comments. I plan to enable support for
> > > > > > 32-bit unlock command write words in bootloader. In this way,
> > > > > > there is no need to distinguish whether the unlock command is
> > > > > > a 32-bit command or a 16-bit command in driver.
> > > > >
> > > > > Please don't move this into the bootloader, enabling it within
> > > > > the init seq. is just fine. If you move it into the bootloader
> > > > > then you can't ensure that the bit is set since there are plenty
> > > > > of bootloaders out
> > > there.
> > > > >
> > > > > As I said, just drop the "16bit" unlock sequence from the init
> > > > > function because the unlock is handled just fine in all the
> watchdog_ops.
> > > > >
> > > > > Regards,
> > > > >   Marco
> > > >
> > > > Hi Marco,
> > > >
> > > > Sorry, I did not tell you that all watchdog control bits, timeout
> > > > value, and window value cannot be set until the watchdog is unlocke=
d.
> > >
> > > You don't have to according the RM:
> > > 8<------------------------------------------------------------------
> > > ----
> > > 59.5.2 Disable Watchdog after Reset
> > >
> > > All of watchdog registers are unlocked by reset. Therefore, unlock
> > > sequence is unnecessary, but it needs to write all of watchdog
> > > registers to make the new configuration take effect. The code
> > > snippet below shows an example of disabling watchdog after reset.
> > > 8<------------------------------------------------------------------
> > > ----
> > >
> > > also the RM tells us:
> > > 8<------------------------------------------------------------------
> > > ----
> > > 59.4.3.1 Configuring the Watchdog Once
> > >
> > > The new configuration takes effect only after all registers except
> > > CNT are written after reset. Otherwise, the WDOG uses the reset
> > > values by default. If window mode is not used (CS[WIN] is 0),
> > > writing to WIN is not required to make the new configuration take eff=
ect.
> > > 8<------------------------------------------------------------------
> > > ----
> > >
> > > > Support for 32-bit unlock command write words in enabled in
> > > > imx7ulp_wdt_init now.
> > >
> > > So.. after reading the IMX7ULP RM, which was not my intention, I
> > > found out that most of the WDOG_CS regiter bits are write-once bits.
> > > This means if you didn't set it within the bootloader you still in ca=
se
> "59.4.3.1".
> > >
> > > So the imx7ulp_wdt_init() function just needs to check if the
> > > WDOG_CS_UPDATE bit was set. If it is not the case, then you need to
> > > write the WDOG_CS register as currently done. If the bit is set,
> > > than you need know that the bootloader did the job for you and you
> > > can exit
> > > imx7ulp_wdt_init() early. In both cases the unlock is not required.
> > >
> > > Can you please check/test if this is working for you?
> > >
> > > Regards,
> > >   Marco
> > >
> >
> > Hi Marco,
> >
> > Rom code has already configured the WDOG once, so we cannot use "
> > Configuring the Watchdog Once".
>=20
> What? How does the ROM code configure the WDOG? Also this would be
> worth a comment within the code. Also still assume that this "16bit unloc=
k"
> seq.
> is useless since you writing 32bit anyway.
>=20
> Regards,
>   Marco

Hi Marco,

The ROM code of i.MX7ULP configures the WDOG to support 16-bit unlock comma=
nd. I plan to add a comment to explain it in code, and keep "mb(); writel_r=
elaxed; writel_relaxed; mb()" unchanged.

Best Regards,
Alice Guo








