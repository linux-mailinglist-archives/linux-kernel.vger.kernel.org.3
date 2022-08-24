Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2759F576
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiHXIlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiHXIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:41:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70205474F6;
        Wed, 24 Aug 2022 01:41:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT+UlIfbQ5r9yM2DywaKdqwAkqPqYdqAV/IoWkLp68sH//xt6pqm4bA62RJEVuUN4DFmTnYE8uDJS2wDhfs9aMt06t7aOn/mxnVGL3k+vFXme2oS0X8Fm/ywjcEJNQQ05IJ9szp0Cls/phRp5ouLFNvv/SdcRm6VJ/kIIExbhL3gEOKwjYVMIyUlYQVMT7YY+5NqTDXkFWpV9NIpMHjliw45OGzTKp36Y98PbniCfUrrNIgPmexEi8nnZhKNrdSyBkxFdsioqsxH/8UeNcEVnGzpy1iiKIFqnT6MHWstowm1Y6gyAhcB7JQwD7399YxPIGHPCOg6tV2zyprDIVNMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbgVyP+VoceeUjriSLdYGUdDr85mQM2kFdkjqyqRpus=;
 b=N8p1LpWJvRyM5urvgYeD2EnfzlSJwIGgc2Dge6GQtXHXTtGmdZXqtSIXlqcQfVA3aHJi1zgj/HWIEw+OfDJ/EV78VOQCbyjvXitN33OSqysx72F3J4QJ2467T3fD1/p3SEuJ2rq0MITXGbaiEs7cRD90uKMblRe6LRfP8lOQDAgRfsuNLGaJtfklpBG5LmyN46uNgcs0IFv2D0TTHZ1zJ52+rGI2M/xRzoG8Fo0KpVOZiTCIUmNf/kd53NiZLeC0iQbxRkjhpVstc36CSzEyQshNa1yQtnUMmrt6WZFfTGX1Ktj8vmSGtyOFZUveJs0c+pemPe1NU4QnNd4YTfK+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbgVyP+VoceeUjriSLdYGUdDr85mQM2kFdkjqyqRpus=;
 b=O88skmQBQQuRidCfpkmI9Pv85twh2vL9QAzceMVtZlgxV3BJOllxcDfrR1un+DqClC8NBKCgcU3ntkgx6LBzYoJ0X9dD+XPKUrdB+BcmrSxTyZAwe6H+fwsxAwtXvrfaPs58PGxM27hgLZNlaXbuASdYlMll8h4YMY/Yul1zabE=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM8PR04MB7377.eurprd04.prod.outlook.com (2603:10a6:20b:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 08:40:59 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 08:40:59 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
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
Thread-Index: AQHYsSoBdxZHPlON40a5XuD6jrx4qK2xDxMAgAmF+ACAAAMHAIAAZZiAgAEFDYCAADtTgIAAMAWAgAEz8ACAABu1AIAABLbQ
Date:   Wed, 24 Aug 2022 08:40:58 +0000
Message-ID: <AM6PR04MB6053D8E0A9AD24757095BFB5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
 <20220816043643.26569-3-alice.guo@oss.nxp.com>
 <20220816062330.z2fvurteg337krw2@pengutronix.de>
 <AM6PR04MB60537292F559EC012F0EB510E2719@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220822080010.ecdphpm3i26cco5f@pengutronix.de>
 <20220822140347.GA4087281@roeck-us.net>
 <AM6PR04MB6053E26CB59410EBCC2C93AEE2709@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220823091027.ezyxkn64asajvjom@pengutronix.de>
 <20220823120219.GA203169@roeck-us.net>
 <AM6PR04MB60535EC5B774004AF996BDA5E2739@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20220824080338.humjny4fabhmx3z7@pengutronix.de>
In-Reply-To: <20220824080338.humjny4fabhmx3z7@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3cdb317-300b-4489-d339-08da85ac5e80
x-ms-traffictypediagnostic: AM8PR04MB7377:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWyMUbV1E2jKUiV9VOkzboaT4IKYEhKNrkuR9hf2J+nu2h3EjfqOKS8vNq0dK7ETqcQWF6Yu6Fpar/deI/fjpUImwhl0BnaNobGus2nrx/7T+WEGQnvhiHZtrZXItOClaUM6c6PS7MNqjxmoTmkSgCZ8qbn46CC0Pk48TaEBdF3qvWP1UuNLq673uRm6YUDcJGYVjQyUObiCr/PymydUlxotcktnq+laUo0v5l/XCG0z3hgUptJx0gavlG7NIJx21/l7oQALLTN1O28qWqp/Zj/d8G3dF3ZoaSAdA3soYXmlH7Ifpwr1mDjqBKUFijXZCXzDK2ylNTG5b1ho3aMHqCMJ31MpgTyXaBDkX5Q74ezkEVpHxacCLovmIW1mOSIG8vY49WG6sYfdHcIN0ZDEBorElXQWTsHxdiyFiPP31/vHL5aTazMFUD4hOfch7cCPnOXsGnADDXnFeeuvFk7F2PjAJIVw0Swao97x7lAt+pfslBYP351Y3Jjdd2YYtpU20xDBDpM0P3CmBr278UGD4yCGTmLnHT3Y3565pHQ/0oLCS8Ow1VUWbUM5vzhNVknFy6/YR77wdU50pELDZ+UqMqeZ7SToXfqlMDF0o5eKSnKEI5CTBg/lQ7bdYdEzYs+vBsB3tLksd0jlhOHFOM55TdpYuF9jNevcnqHPyyOWwPcBAOH2T14Wik5QNaWksqmtHu+fn5dydav9IqhsAji9d3ETnqd6VcY1XxK6awotH4y7xmdv0B4gZq77QNt79Kt4a3vCPooWUyDRJ7D4R8bQJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(186003)(71200400001)(38070700005)(41300700001)(66476007)(64756008)(8676002)(4326008)(66446008)(66946007)(76116006)(66556008)(478600001)(7696005)(6506007)(86362001)(316002)(26005)(9686003)(53546011)(54906003)(110136005)(38100700002)(2906002)(122000001)(8936002)(55016003)(5660300002)(52536014)(33656002)(83380400001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xpx1N5UYBDgNi/sShDCe/zWFXrQE7PbS70hwhOmUJisSEi8QxtkmMp2GjuNT?=
 =?us-ascii?Q?eWyU+ngCZdF5ZySWebStD6s3zfHBy1g/WkbliQhySTi4L4fPHeBIG/Lf3flv?=
 =?us-ascii?Q?xwzrRDso/GOMCxL2SyHxs10A4Gcx46A1BDcNESG0Xrofr7GejVzborOhZ0QC?=
 =?us-ascii?Q?6RjgIze4BDind6sfjZvVeoKIOKxqsKBpthD6ksVvXhOACJfIsmREpC5OkanI?=
 =?us-ascii?Q?Uc5bNv+D0boG+OIkzBLxAeceveQ/7vXH4Ulb2KI8z3fhleRK92tCMlh99nKx?=
 =?us-ascii?Q?eJNo7alGua8YwnicIO9UcHn3c6+Fxve9or34dkxtn6I/8/oDv7U2R5PNqpbh?=
 =?us-ascii?Q?0TfNSvRJuXUevGJrwyORIjeOpa0F+Zjm9qRIqmciHUQ72ipXJzDsdlJiGPVs?=
 =?us-ascii?Q?StTm/JwV31aaOjipXkrda8ehw75ZT1i2a1OzsaRMRuHqYZFvQqpM4s8TdfGG?=
 =?us-ascii?Q?nd3wu5NCveo1P45N8o+aVOexSTa8hTIgsry9kJMkUjQf07Tku7EOtpzPCocT?=
 =?us-ascii?Q?zJ/siP4u0837bVdhkTOvvz8JwpqMdbvns/eAZDduzVWSsv0vBySPW6LHQkCF?=
 =?us-ascii?Q?BUUCxkWJ4GkZ0xX3t+Ge4Gofg8HViCxj2qAhZmZ5lrkQ8mJfn+U1LxsLaSa7?=
 =?us-ascii?Q?Pky+F/Kq97u5AHAU+sAULL8FaiufPGMqAFdDuyn95fhqHOa7JS5B6JNzRS50?=
 =?us-ascii?Q?YaHPyQeRF+CQTTKFXHKrneZcm9/pwHLKPSGZwEC6lzpHYjeqOEQfZXkem/vJ?=
 =?us-ascii?Q?g2lLp5SOTXp7hJFU+UgEfP+lgSFiDRkgb2LoN/wUDtwBSrOf/PTJ8/gqEkW5?=
 =?us-ascii?Q?xQRamNHgUB/rIhl3iERO/GBSrxAVc7zkrdb92Qah0TMqQqM9w450+PRRS6O/?=
 =?us-ascii?Q?tpMuQlTk2yVDJgwiddIbgAV54jp4LS7VxT5WGDes3fkxipt8K7U+lvq7n+oN?=
 =?us-ascii?Q?wGccIJqQK2NypaRV3bs45uFFnp5VPSi7kyX/JhAiNokdy36sEsr8N/sMiG0o?=
 =?us-ascii?Q?3qeU5yFGjjZhxwTDw2M6tONsz3FCmJvd2ptdaX/rECR1KqVcOFMZ2HYoVdXH?=
 =?us-ascii?Q?TZ/B7WBejG1zdDTLCldohru9K2/aTzrlbj9ricFUnsU0lcPcHiixlkDD+Mej?=
 =?us-ascii?Q?GuauPxUZ07zgbgi3vGYEU+t2rJBkXpE85CPQWu5ApQ9qNR7/vBbXTOIZudLD?=
 =?us-ascii?Q?MyhB9bjYiaKgiokkJXhwSIeAvi36NpsxgBG4ZLjSe+UWKB5piH7PjEpYqFWj?=
 =?us-ascii?Q?4yZT3JJ8OejzBtKouby5tpP3ExkI9lg0nf1m6tMvtVwW0FPpj0WTaTFIqXwp?=
 =?us-ascii?Q?81S0CDb5GsZZWf1nGSd7N1wauSemkd8MDDEV3f3N7PUTLhlFAhdiL401C21C?=
 =?us-ascii?Q?JFmkSSFhAq8F83WrNa4IUYKsUm/3H9D9uNSnW2BQc2VHhxEOZ/leDuhWwPeH?=
 =?us-ascii?Q?8In6tYOzpMFUOovbnwaZnwgyMWo+3jRcEonTRL8Sop4HrRR7+hLke6YmACvb?=
 =?us-ascii?Q?zx3cH5PfWqJJJ5xmbxkR7V/KM+OxMMkT41rQiXPchTP8iFAw2HZVOBsSW4Te?=
 =?us-ascii?Q?mgivTOPV1nFr0uWd/wVoE7nRcu1EjsgLRbbOAX4e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cdb317-300b-4489-d339-08da85ac5e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 08:40:59.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkrUgaszz3XhGPmE5zqp8YCu8n7E9w3v6vrqANfoUmDHHIGFeBVWdsWR2asbmL+VOEmP8eObiSq7SZoyCu5r4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7377
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
> Sent: Wednesday, August 24, 2022 4:04 PM
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
> Hi Alice,
>=20
> On 22-08-24, Alice Guo (OSS) wrote:
>=20
> ...
>=20
> > > > > Hi Guenter and Marco,
> > > > >
> > > > > 1. did you see any issues?
> > > > > This WDOG Timer first appeared in i.MX7ULP, no one report issues
> > > > > probably because few people use i.MX7ULP. This issue was found
> > > > > when we did a stress test on it. When we reconfigure the WDOG
> > > > > Timer, there is a certain probability that it reset. The reason
> > > > > for the error is that when WDOG_CS[CMD32EN] is 0, the unlock
> > > > > sequence is two 16-bit writes (0xC520, 0xD928) to the CNT
> > > > > register within 16 bus clocks, and improper unlock sequence cause=
s the
> WDOG to reset.
> > > > > Adding mb() is to guarantee that two 16-bit writes are finished
> > > > > within 16
> > > bus clocks.
> > > >
> > > > After this explanation the whole imx7ulp_wdt_init() seems a bit
> > > > buggy because writel_relaxed() as well as writel() are 32bit access
> functions.
> > > > So the very first thing to do is to enable the 32-bit mode.
> > > >
> > > Agreed. This is much better than having extra code to deal with both
> > > 16-bit and 32-bit access.
> > >
> > > > Also this is a explanation worth to be added to the commit message
> > > > ;)
> > > >
> > >
> > > Definitely. Also, the use of mb(), if it should indeed be needed,
> > > would have to be explained in a code comment.
> > >
> > > Thanks,
> > > Guenter
> >
> > Hi Marco and Guenter,
> >
> > Thank you for your comments. I plan to enable support for 32-bit
> > unlock command write words in bootloader. In this way, there is no
> > need to distinguish whether the unlock command is a 32-bit command or
> > a 16-bit command in driver.
>=20
> Please don't move this into the bootloader, enabling it within the init s=
eq. is
> just fine. If you move it into the bootloader then you can't ensure that =
the bit is
> set since there are plenty of bootloaders out there.
>=20
> As I said, just drop the "16bit" unlock sequence from the init function b=
ecause
> the unlock is handled just fine in all the watchdog_ops.
>=20
> Regards,
>   Marco

Hi Marco,

Sorry, I did not tell you that all watchdog control bits, timeout value, an=
d window value cannot be set until the watchdog is unlocked. Support for 32=
-bit unlock command write words in enabled in imx7ulp_wdt_init now.

Best Regards,
Alice Guo



