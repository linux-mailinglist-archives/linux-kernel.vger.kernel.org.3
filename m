Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B444946A1B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbhLFQuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:50:21 -0500
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:43329
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242793AbhLFQuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:50:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScWme5dzhs/sCLP+VNK9DR9m4pKAcGwGZfgtaWkq+KwJUu1sfK7NxhxtX4sx5vH/mpFCuUiybAstVaLnPjd8/FUL5fulJIaS5vJC+3qsxc/Ql3NJizOYggefvARk3DOGSfTv1jTpVRmgQ0GtBOQ1oV6GbJU9Ga6IFyaNTzWDY6IoqswuOGSC+nt+pJHO6IAH0lUqGVabuf70cO+w6tXCSu59Pm2HQURNysdnLFffXCy4Qg/wkDefx+qpE038WTPdOYs6QmzApaZzYF5ikTBwSquIVhNZtkTj0lsEHgFQTLyuD7xF/jBIODb1RgHZTrxbD6J9SsR7yztv+f/ZjR1cWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhaVZACpmBx9rgnCwVOH3wSPKqPHlS6AXLx1MYDmv7s=;
 b=YWmObJwTzBFtjm3wB2T+kwAL6txYmcblQsdjZM/TB48FMEBA9nuBXW6SNURxz2+MsVSC2ZLhafgYc4MZOGgxXGRP0VboNG1v/Vo0OQxc/SD0QDrmQzgtOagzlGE3Lgab80BSh1F/bbnuAFnvo2TjbqejVfXRg0obh/0L6no0RgIlNLyPdWOVEtiehYIpEI/DIuCFlOpLyA85O0J25PW0uEAYLaNNM1AeKv++dICzYlzDiTl+p8C/S/Kz5RO/PL3j6KBjBMexFB0M7Fml7tJIJXqU90V29+krWNIFFCtLF89lfK6Q6Wz1RA6ricRQwbOCt0P3Z2lU9V/6LwJNm8moIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhaVZACpmBx9rgnCwVOH3wSPKqPHlS6AXLx1MYDmv7s=;
 b=PUD0b3KuAY/ha8cOZP4Bt2kY/mPQ1UhS7Ktl+oabhwqcMrexyOuXGU0aKbut9AVOxzv6oLZ2mdekccYqxE2fQQWhx2aOvP5l9YN+D836Ts9PT6E5Fq5Dwi7gJDtyDV3g1JmuQM3WggcD0EthccCUCLai+CpmorxEkv6PMBrwzFY=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB2905.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 16:46:28 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 16:46:28 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH v5 1/5] mfd: da9062: make register CONFIG_I writable
Thread-Topic: [PATCH v5 1/5] mfd: da9062: make register CONFIG_I writable
Thread-Index: AQHX6m0sOxzGhIFJw0ykibdS1Aiua6wlrA1A
Date:   Mon, 6 Dec 2021 16:46:27 +0000
Message-ID: <DB9PR10MB4652F10355222D5DD1A65E50806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211206064732.280375-1-andrej.picej@norik.com>
In-Reply-To: <20211206064732.280375-1-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11272bc0-2a5c-4c09-9784-08d9b8d7f2c7
x-ms-traffictypediagnostic: DB8PR10MB2905:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB8PR10MB290513AC6BB7CE2F4BC4E26BA76D9@DB8PR10MB2905.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTWMwFjyNYalcU8RBxQidWoQiLyM7BuVHrxUX6eoi6pq+pswyjJ2pmhAcS1xpal8u22SysOCMsYmFmshdlB9mii2i7izUZeJok0fse5gaCCdpJfLEWMx/DWVcHStoGY9JzZVuB88EHlmx9WhmmHEStgLUk5ZUlJCJg55vGi+nnxln6WXiiQnpU553hjFneMND4wxAKML7cadGQRK07CfbhlA8ofLPXZtDIAi+wA8s0UQNNic4fot5dMp43iBSx4EbhiU3ZsLpG9CO1Lc7jXj0UBbceyK7a1cja1EcbfOakBVJp8M8zgO/mFm3AA25xwrVEAQirACQ8MgFldJQLjYMxRAUTJt4Tiu5MpXPdIkUcI/4hIU9I3HVAz/j37Qmzlkd3daLOAljvYm7t/Ho7fy0dwRd7ZgSEEWM/OfsFcEzxu9LUSjRqcCLsmYoH8vLMVcD8CLCg0idsU5M0Uq40NBS0EFPLEH5x2PZSL9p0MJp82AIDy2KZOV+aYyu/rVatKJaWiyysvxuIvebWR+JnMglWaUhJafp4vrfDCbCVJK42DK6nMCa7feEWx56IksOKeZvJXlMZtu25JMtfwMQNT3ZUW4pBxukPOCaMwsyZjDbhpEsGCs8Un1aSfxrpFyAhItiC+/rtvImjOhwUlL7LcgYmTzeSjgfQRO4XKOnIynZ7E5CMt5EWipAf2an0SJpQk2QWvjI6jkxs4k+TRfoSOOUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(52536014)(4326008)(38100700002)(38070700005)(122000001)(66946007)(64756008)(66476007)(66446008)(86362001)(66556008)(71200400001)(33656002)(76116006)(8936002)(9686003)(186003)(7696005)(7416002)(8676002)(508600001)(5660300002)(316002)(110136005)(54906003)(55236004)(26005)(53546011)(6506007)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bfNYBMC/aM2D+rNs1Zpgql42WcegUvvrEn8PlZoMogw8Wrv+y/ZZ+6TaEqCc?=
 =?us-ascii?Q?95JTSYfqaqFXkDg+74YtolSqATu3aSYjjWDifqtZAF460YRxSwKxARycDoGZ?=
 =?us-ascii?Q?QwokyEKM1W0plbx/hsoJF71hbHAvirAhGyVi5fxmQg0ve66joCB6NKf4FE+s?=
 =?us-ascii?Q?W+XWaxWBsV/N4m4VCq/1nUbnOWO9Cli247y98qfIqxPSfFxPi0xsu36Ss452?=
 =?us-ascii?Q?54l7oMdOHuaRch8ZaXri+iqlBJ+Q0RNz9PyvMQPvOZY4txSwX0wXrKy26rLi?=
 =?us-ascii?Q?xuo+NGkMwPZjMRqV8aMNMCK0Jwk6LVz8IbmPdmHlOGzB0q8rRgz8lL7j11mu?=
 =?us-ascii?Q?vB7Zj8Y8Piad/IgQk3gZhaYJ4ryMiCEOh/xPayTsTGPkDFvHOWQsNLaictMk?=
 =?us-ascii?Q?CgbNQZp0m9nWXoWLL41AvX9jvAfOSaVS/HFLClS4rlWrz4JCDjndFSCeSliT?=
 =?us-ascii?Q?nRr5+O4mzs/uG98DPn45sGaLGYu9RR9c5fKo3saNTC0Ix7WTdylT4bVKn1AF?=
 =?us-ascii?Q?lT9Z8iqFvNMNgMw/soVBMaOwjmKi/ay901E/6rFAqCHYOAugLPCXHhm5lKaU?=
 =?us-ascii?Q?bKoLa0Nrfd1DmWkQAAV7tZUfjT5LJJe8cjk3Swc9XbGZBRIDyYfHDVv6lHWd?=
 =?us-ascii?Q?l0BSvq49MB12Xqecy5OPUCRdr8UaF0SfwPTTJpaq9Upykzq+CiHeo1eACiGd?=
 =?us-ascii?Q?6YYZWXgcGkhrqN+WLYqJEPOPFrgwEpG2hMoLdyaS9Eb0nNUn5kTb31N8gsXq?=
 =?us-ascii?Q?GjNUPYEFI+UCJH46Y7s+1vSIT1636t4JdN39OucSwf7dpS4XCIXS8Hx2xTRf?=
 =?us-ascii?Q?+AFdKyGqgxvxnIPl66O+OLYb5r1qjNolwaOEdxCzvU58fS9jPBmqlijX1+a1?=
 =?us-ascii?Q?MUcT8aymF9a4kHp6x71O72T/n6yVWmwVe1Cw9IHgzrUTAeH6A+wpRxZR5eka?=
 =?us-ascii?Q?X1hG7eilxRU0FInIZxfgwJlo/C550Vj/K8/yVymHRkrLoM/fJlfU9OKp46Ci?=
 =?us-ascii?Q?p1Lm2g3LTTjLYVisxmw01CeWlxG2JAeDp7S9PO3NTfVz5KDNWFGF/1E7OPHZ?=
 =?us-ascii?Q?ebOjljPO0kyov4MeK6dzKLuBVIzXU4TtuwSboRSHhgm+uaGO7d93eLiZTqyK?=
 =?us-ascii?Q?68HBvn+F5xsRXVidU+BehFY3EIW87VDuVENN3xuHuuWGDHE1ZpTeAkR9XQ0+?=
 =?us-ascii?Q?N+DCz5mpGaQvKWxTG6Ta496CZ9695TTxVEjWcH/qvSg4m4OWfXJOHlsRtJXm?=
 =?us-ascii?Q?kr5M+EB1HxwiD1zJIormL56RvN12iXrS/lq6jatN1yEQ8CNs25NjUlOe1wCZ?=
 =?us-ascii?Q?ytOo1HxlBGBh3e4epU9yz1d/EdqU4FnPKfJH2jZfbaXoB6/UWbqTki+WdvNk?=
 =?us-ascii?Q?I7/ftwTzS8v3NAlfTXWRd56aH70hn5+doY9kxp4BjJJgVicfHx1DtpjuO/Wq?=
 =?us-ascii?Q?hMjIKgs+GTde70M/l5MAWzSqylmeri/bIhTSXRzXKKWsH8cWaoEvMuT0w3rU?=
 =?us-ascii?Q?mHZEqnjT80XYc9uKEFIZIR5VZcYFlN9lQ4hNIXIpGdjVSEoBlkpBKWsk6L9y?=
 =?us-ascii?Q?vZXAWLxctXzg8GEin2qi2vwDwwF9EjRW8s9R1QEVmoMB6WmgVJCgfh8raVcM?=
 =?us-ascii?Q?3B2tUZxqFTnHvLcSBeKQCqEhMsL4lMPy4DMZxsRfD3nRMaPzhwb4Ac4sImtI?=
 =?us-ascii?Q?MsNPbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 11272bc0-2a5c-4c09-9784-08d9b8d7f2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 16:46:27.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6QuUVfjzPyWQzbAf/sb0xjGJwSwh1DFn2Qrw8tm6k7SOCgt/SlXYLyGMtaSYSTov16u2U6ZDD24Jjn03P7S5PGJrew90Jp7B2rC4xb2Bio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2905
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 December 2021 06:47, Andrej Picej wrote:

> From: Stefan Christ <s.christ@phytec.de>
>=20
> Make the config register CONFIG_I writable to change the watchdog mode.
>=20
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

I've already provided 'Reviewed-by' tags for the other patches in this set.=
 In
the future you can add any received tags on to patch re-submissions where
nothing has changed since last review.

Anyway, thanks for the work on this, and for the patch set:

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
