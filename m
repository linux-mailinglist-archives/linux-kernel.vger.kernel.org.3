Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876F9466357
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346567AbhLBMSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:18:23 -0500
Received: from mail-eopbgr20068.outbound.protection.outlook.com ([40.107.2.68]:29057
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231324AbhLBMSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:18:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjoEun6pl49hhueE/j0JWqachLQIfOduk7/9S/RUweZQ6ean4DQenNKPhsmBYBoZjpUhkRRQWYK6kyaFF3LgN/soOJaR3b/pAipEjwr3ViZGvF4twgfz/ZyXr6GAU4JzkN2vKtbWgu5qsL3d+6BabNLSQNn6toQTBB8jqThKtSq5k80BzcaK7mAukUj6phbgexdW8jz181XBqNfvPfZ7h+OqbQIm7gdowh2SPKW/98xBSFAOeqJq/LyCNFTtcw/ttIMlKhBZaM0WfjlgoPpFwoEfbxCmZY1umNUudKuuyIJDBuyuC5lLEFe+YlLMt+PpUj1ovc3/VyKA3e4G7ok03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqSrJmIwrPBMrUojbo6DlUKWajhKlUZwWm7SJtJlIhs=;
 b=EANj+FI539YvW+OACAs0m+Kw9k/SEeoIWeLcGEN0sRiteqFVpmAZHCIvsQ4fS4U8wuGO83rzQh2tx/5aei5vurLre7nk3Ep674g0y6Z78u+R7ipc9W5Y2ym/XmuBy9g3RhIBC04sOpYtxGZDcN4Nk2O3ii+DqsA01uiqUAlv0Xxn0AIEkUqfpIyRpH/WBN9M2XvxbE72yW8XdbHu7Ea7/Xp3XU5dIHaPh+vTxsejNvI99Hx88XL99qqjDkm+cQ6u0RXWB6rlcLYhasU6powhGBfmUiNUGZ8+fJbxKAauU01MM70qEn9IRq16e+N8jLkcUHrzkCSklXw3yjgPE3p6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqSrJmIwrPBMrUojbo6DlUKWajhKlUZwWm7SJtJlIhs=;
 b=OMvrxtgR2NOJmxGRq/1yOVnp01pbw0fucKzLfauzP7Vx5VXYiwe/JUoTWnL6dHN4qioM6kYzlO0xVQlEGK40yhyPMVlpu5SrDbR43MTFq8QaIYXneu2zyUnR2X3YWrte5A0lOpR8vHV1IUttleiHkq7HQkwCwItQFvJytQc3t8s=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB2875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 12:14:53 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 12:14:53 +0000
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
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/4] mfd: da9062: make register CONFIG_I writable
Thread-Topic: [PATCH v4 1/4] mfd: da9062: make register CONFIG_I writable
Thread-Index: AQHX51+R4WUgkg6q5UakwiU2i7uVDawfHQOg
Date:   Thu, 2 Dec 2021 12:14:53 +0000
Message-ID: <DB9PR10MB4652545A72718458D544E2F080699@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
In-Reply-To: <20211202093230.3951996-1-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69bfd39b-bcf1-46bb-aa67-08d9b58d58f9
x-ms-traffictypediagnostic: DB8PR10MB2875:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB8PR10MB28750B13ABD84A2A77910496A7699@DB8PR10MB2875.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:183;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LSu82zHcavANss+UAXzpuHP0bMsLLMCF/pZg2mGQIcIc1G1Xq80iv1le/4POT5ZAYDDOAg+mj0hDrwNneauP3RO2yK+k4AFUjwSwaTuxQJY7PCrdF5EKNuLeGmttfWOsuLkM83q0X3etCyWRxNOKjioLky0TpA462vcuaLpvUJei3AwnXJiS6A0wAB4Monj1D7cHWP3kFMSUorRimNHIpLRbj0ILc29TBIXaKwH6pHD5CIo37MGVj7OirUFylUNuLNg+9mg8rADAduDJAXWdLGKMg9zxJPjxSU742SZm79+nUUtuPschrUkgu4T5BL8SPBeV71M86jwBcQ/57D3BERgUvmAuhB5Yv4Jrn0pRU2fKCCoJbZbnX2JH3aA9D79X2xn3J9YyoQJ+4DIH7NHQd6Nsd/ilFeVc09nOOgyIFbcjovNdecH/SEpr3TF8qi1DsEW8tfTbIHn1UH0bb2denXAJV/DbAILLNXazk/GNTgqf5+INdpYCgrpXIFG7oqPDaJ8CXxOKePS3bHiL+UOf5UA4tqMwteehHwN5ZHJziXrnx+ude1rzOKfK+xmYfrn6P9w3uNlUzJlgbdaGaC77kp5Al2yAGqVBys8ohgi3mV1pn3+UHX7Y7DON403fz6Pj42qQwInz74r8FF3D24XJUjFyaAP6w6brDGZCBj/VvV92ESfa9oo6zG7feryCEYkv+IX+lHWJB1UK8+URx6tTIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(508600001)(9686003)(53546011)(316002)(8936002)(186003)(64756008)(33656002)(54906003)(76116006)(66476007)(38070700005)(110136005)(66556008)(6506007)(38100700002)(66446008)(66946007)(122000001)(558084003)(7416002)(4326008)(7696005)(2906002)(71200400001)(86362001)(8676002)(55016003)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NpJfpG1g8VclbojsbYnTZHh04SC7tEZdJpMuYda7bf9C2YfME2ov/ULnhPnb?=
 =?us-ascii?Q?DO+jHygbDO+ZsuEQGaZXJQuS+OQ4KlRO4xh0/0ZozCmq2ndIPG8sKVen8kRz?=
 =?us-ascii?Q?GRj5jUsRE4aa9BuIm1RwV6CBkUEdR83NeHsALn3efhunU93t1gZ7r0/7BwOG?=
 =?us-ascii?Q?PU98bx2br5xQQAb34cJCBmp+Km+ffixzme/EGeuM4GlPvBf5AVg5pgA7sZQo?=
 =?us-ascii?Q?Tr0xq7KMukNDTl23k3xmavAbSYJHyOqnRPvnfTBL4j+LjXxHFP0PgHj605Z9?=
 =?us-ascii?Q?VvSrnR62pCxKRHr2VaiMA2y9wRdgR8omj8Jcdc69ZFVVtC7j1B6LnaceA7wD?=
 =?us-ascii?Q?H6M3P3r+YRp73z6vi56fEcS8c0tLxhqV9gXFnKx8zYqTA77YO9lknmHgFKp8?=
 =?us-ascii?Q?hTGTYHOiZibTxMRtOUV/wBFRPrLfmOACQ+w5jqPdPEAexDgJt8ojM1JFixos?=
 =?us-ascii?Q?+1ZbMLweIr2kJzKcwsbIvSKEv+KA5dkn39lctxn0IO5j2VeaTFF5V4rr7eOX?=
 =?us-ascii?Q?jVzi69KThndQFq5G0A4qJ6FWqp10Uidh9VGz3M9I6bOiW8KEhcQplQG6Kyrm?=
 =?us-ascii?Q?xBgwsarjTenYaHFqz3kGbzTSq8wID3sJPf4MLmQf+BYP+GVLvx3OVL4kTfyW?=
 =?us-ascii?Q?OEYbHAo8EfTm2GSOwvfdlTp/ua1kL1vEauwGFEG7/L7PmEvIKe4fDIFyyh9H?=
 =?us-ascii?Q?DakhFkUTmtqChrs2U/mudaIIRIvL08t267c0Mb62OmRaul5Y1Cs18+BPLFpB?=
 =?us-ascii?Q?hyI3Kvz9gikabQ05CZEVPuS/4mQM8OSNx/+j3nSZ2VIvrirJ0A+GRT7+1yS7?=
 =?us-ascii?Q?gRYOWLZxc55LuPZLSaTeF/rpzsoMl8ZY83SZfnU6n+xSrRU5/minADV67qFN?=
 =?us-ascii?Q?VfhZ4LEGZRylGtKr1NRyE/7F7TD5mPBK9sMUPMvP16KmtLBxbG0DLV8aiUZa?=
 =?us-ascii?Q?0cDfVWdIlc4YLjo2BTgS3IInBzRqWyufrdlcP4h9XeuGuEfz4BZS4+IMP3Ql?=
 =?us-ascii?Q?0Gnau7WnS/ztOBq2W5TdL2Wrvz1h/m83bdkSP2LEDwtK97nSW1+CH4f2Olng?=
 =?us-ascii?Q?zEKhgM6TdOA91Nsrce3vCjJdt/iszZHHNkIaqTTTtpAz9EL/udo4HW1h6Ox3?=
 =?us-ascii?Q?dLwn1a3ZeZEh0NOZgK/O1um5GP2wsp3O0hquyo4PXvXpUI0+vFyrsk8h7CS6?=
 =?us-ascii?Q?79cUsjKVZzzAWfCbogkg35sFpPZzktqQUEaX0spnvJ2UHYMKhbIqIhqZsXIl?=
 =?us-ascii?Q?0fQNV9q3TX6ZcF2ocTfcTupcjUV9tTLkYxKF3DlA3IXwLtWTjaosNIibz+0K?=
 =?us-ascii?Q?Si+tnoA+hYX11GkbxlENch7TXGvtn5NMT5GAnC9ZMqUzJMQQDcckN0kfB4mJ?=
 =?us-ascii?Q?ps5QKit2E77O5M8rJ1mv14PHv15aO7kXx/x19ZqzJfyYZ2j9OkPaPdvY68SC?=
 =?us-ascii?Q?80CYBsILbyM1Y3OvzQ+OZPtAhxnfvtwuuYtubCO+/F2i0PNG2lciA9wmsiFO?=
 =?us-ascii?Q?wHJU1nVIs8PSiXj3pzm55dKmsRvGx5NA0x+wFFgOF5HWlgpU43bfMclf3Ol6?=
 =?us-ascii?Q?NaLZuLKlQ96E9lem3ZYh8HDIgZlBsyNuOpWRjAJr6jiqEwmuYy3RmUa/8nKp?=
 =?us-ascii?Q?VlymeZoIUWAFsPZ9wDqpAwk8kAH2CWLimpFcMglq2M+EK+rOcmJ4iEDmBO5U?=
 =?us-ascii?Q?3j3Klw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bfd39b-bcf1-46bb-aa67-08d9b58d58f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 12:14:53.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABW8MrfBjuw/6ZfQcjO6auDLQzUb6x/3ZEWR8dnY58K7dbITIwrrjSb2GGh1RgIpNbOHGBNZYGR5rIvZu8NoQsFxooh/+cY7rqVkqlsD0hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2875
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 December 2021 09:32, Andrej Picej wrote:

> From: Stefan Christ <s.christ@phytec.de>
>=20
> Make the config register CONFIG_I writable to change the watchdog mode.
>=20
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
