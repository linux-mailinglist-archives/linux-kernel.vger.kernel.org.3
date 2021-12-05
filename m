Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA9468AE3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 13:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhLENAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 08:00:53 -0500
Received: from mail-am6eur05on2053.outbound.protection.outlook.com ([40.107.22.53]:60033
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233917AbhLENAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 08:00:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K451+wNHNtz8V/yual7s4tTLjzvMAHQrnZTG7iw9Vtpda56wRhLIbD+3Owwk6ncuyx8rwLEnQkCPIngikPbtqZWfp5G987trJ8q8w3GhxhATRaFI4QYBNdZsXQShkK3uHDES/LnVfk57GuL8HjNFCjyg+Y6R3TogQgApUkW9ahY7RU+ZzUW6CnlhgBHXM5QefuxFYQGZ/PyRqwuSeoFidrCppyoiR5TXBSyFQSDqdgNbvV7gjnli26m9C23dlLTMp90uLnHt4mW26jOcbRonzLqFPfJxk4j1JdLWLJ43UicOoOLA42tu8izGnLR0YSIwpnqX4Yd6DFEnRp8tv87jVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qoFkDpsVOKNHx3FP8TwS1ArHb2LqVrrtc/FZ9wVr1s=;
 b=kJDCGpU47Z8IbVjFcrdU/2QAq/zx1ToEOZvgGxGVGbOmXI8yInB5FK/83AjGmF32cupATkwGD1+vaUWYPRx10HPOywG69jPh8/avpk/kTi/6I/qrus4qXVac4Dy9HQ454t4VgFYNnEp2UA8UJbRG0GzeEqhXj0TR98sp8eldleSz6lXcGkkld+H8Mk/5m+1HPokIIMmsuV67rh9ungpNs0pERnq9xvr3b6EMZx/hTOjnn/EvVv/WXPUwk5x2/tjwZ78wGmk/sZYNl5q4VM4z1cuQbGzZOQ45o7zj1lfV30aG5IhFx0COiOvjbTUtd+NTw4ZUSzdfS/OC0XqEhdHrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qoFkDpsVOKNHx3FP8TwS1ArHb2LqVrrtc/FZ9wVr1s=;
 b=XArZUSZrby+lFvkOGtImYJW0pOBz9rNyyt5Z1mi5x3iY2r57V4DJPJWnetW3z1P6l1pliKhtcu7myMnNRgZ3NEvg94aErS+iuMV3iMnp01rmLJ8uRVfbzIN2N8RZ/y/uqdhiVXTaQXnb9fVI8zFXTjt5tNPtSsSx6DgeEH7TQbs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8792.eurprd04.prod.outlook.com (2603:10a6:10:2e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Sun, 5 Dec
 2021 12:57:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%8]) with mapi id 15.20.4713.027; Sun, 5 Dec 2021
 12:57:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: question about IRQF_IRQPOLL in clocksource driver
Thread-Topic: question about IRQF_IRQPOLL in clocksource driver
Thread-Index: Adfp10rjYdf8oRrvR36gaWzXsleJ1g==
Date:   Sun, 5 Dec 2021 12:57:22 +0000
Message-ID: <DU0PR04MB9417B10EA8B9CA41CB1E38C3886C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cc3e20f-5de9-46dc-585f-08d9b7eec763
x-ms-traffictypediagnostic: DU2PR04MB8792:
x-microsoft-antispam-prvs: <DU2PR04MB87920C855DECAD45D55B595F886C9@DU2PR04MB8792.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dySgPe4qLCPiM8MWatlzIKWT1g+/loUiWkot3HThKpT+jHwkhc+V+FTapovx/ADMhJ1vPVZQQsImpTxi1g6ui+pXnPgjkFVHSqzwhaVpLYtEYP1ubNKYpluHerBjEmB1VMZwuEHBxjiS+jrgfWPB6D5RUhxZq9o0lcheMGxRjJ/w2aTnUxk19UBVUuzw+5jobUt9obrja1J3diz7tF52EivIhx9ECxLhwpl6N6QqOkNY1B9sHqbm5zsS7vdmRQuk772wl5GYi2/OtLAdGOVd17WzrsLG6eo7ycl7KYi1nPqqnyZB5LkttH5UXMAUhqDa3qqFn2ATmMl6buP6Snyq8jigZPtsP0to0P9nKMwKQCFdUGy+jOU21FDwJJK2xsQBY5i496WBaodtmNp4IdGTCgsbrrHofH1qhv7LF9YxehrKFVelYVUFvQaobi24gywWgWmy7WSnRAurb+wsfeT/yf0LgUS75B0Gu0YWHwYM04rgDlSJv1QFvtFXGRfVeQAu10MwU8ntETTbVj40DSb1/bUgKpg548MOnbSDxXxM5nyECJWfd00HcmyYObgWbW5uj5MPka6RXcARM1cxkms68fpVb4UIyVyKZT2ypbsiq+j5mO1GqSFTUyQoo3d/tGaeMKqjadxf0mx0LmwQ7SolaQ8pzEtHsSkqxrElLQuJBHRneJiqDEOIaJFHkTt0i6klAZBKZgtqe2Qw/FVmOzh1mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(44832011)(508600001)(186003)(4326008)(122000001)(9686003)(83380400001)(26005)(2906002)(8676002)(8936002)(4744005)(71200400001)(38070700005)(7696005)(5660300002)(86362001)(38100700002)(6506007)(64756008)(76116006)(110136005)(316002)(55016003)(66446008)(52536014)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gsr056U+sYg4FOkZmZNVp3ZiH2cj5ueDgHrxcTmXrMsFIFrl4E5QsnjsA8g3?=
 =?us-ascii?Q?AX9YO7WcppKSGfU+QwPzHppMDUUxAWHhHu1auBXBI8NE/pzY74vAXooiwvur?=
 =?us-ascii?Q?q/oOfApZz1hiy1M1z7DrehJPQ8ByY1CkOE6hYwBnSFkhay1159g0S898wxRX?=
 =?us-ascii?Q?fR/zQE+Nta643kJvwdphwmN4h6WLdmBz8Tn0G/3yTxjB553JqkZLrnn8W1MC?=
 =?us-ascii?Q?qZh6aTO9gTvMuhvnsCkgRKHEhJAOeIziF1VEkeJlvTlfQoh0w3aFooS7Z0sl?=
 =?us-ascii?Q?rdRSDzXdaI432Ydgja4skjmycdfjwHF9m8r866Q4KsU/07EKwmof2fJCfkba?=
 =?us-ascii?Q?i83iUjbtV/FZLqTgf7DPIUxN/eJ7wWytX//Og7dksipoI617zfXWhuOVWEbI?=
 =?us-ascii?Q?fXBT+7lFQgGnFVGJFk5j0BaPB2diBr+qSuE+sIfWYQbXAo1re/b+9MwR4Hta?=
 =?us-ascii?Q?40odwL09wApEaZoQ7Fgvj538GVF58lPEaJq9Ek9VUZImDSu/4c4HuksGjt6o?=
 =?us-ascii?Q?YZX2vkM/6wAMtHcNUFaA2ojIdFQn6Cv0KDsWbdSYpoBVgnz1oI0rrHLSpN7j?=
 =?us-ascii?Q?xMS5Jc1bfA2zPdEcn9MTGKIgXg8E05FMk051loWh4cb+U/w9fHVjb59S3ju+?=
 =?us-ascii?Q?tIqAvZMjwKfAYQefH00C+SYQLqT9v7XcJyn6ytmq+K+VtbFeDv4RAxZoadQB?=
 =?us-ascii?Q?WhZ8LYhCt3+hEjZpiPm7RbqNLXmFx45/2Yk9Cm56udm4nbfwliIHiH7WwXoJ?=
 =?us-ascii?Q?UL/f6px/HZoeEOsge6/nNGm/zegMSqSkgN2Yw810JttM93bzuOo3DQQayf6L?=
 =?us-ascii?Q?k74Ao6pOW62WR5gnyvCH+PuBvhoxvghmNVGY6k46N0Pk799iQHLHemHk24ig?=
 =?us-ascii?Q?zvWcHPRfFlnDRkPh2LwothdMYlBLxFezRBuM11SnSp7n/VEhFnl+sQz6BS+L?=
 =?us-ascii?Q?EemJ5xNRnvTJO7hIaUgIblY/9uvQtBL5ENPDv0BQL59pIe1Gsi+/YsP5MLGb?=
 =?us-ascii?Q?UdAepJl/XnnTII8ZuHKXouDDBnSbS8WvmLR92Q9XvDuIiKnql8tbAp+f3kJ7?=
 =?us-ascii?Q?xB2Ui25lLCBNJOdpycgrDdICmboec0GwVeVWpOMooilB4uCSv0FL4P2kHQ+U?=
 =?us-ascii?Q?DlR55dw8GCcNTTPiqmiIWeFEtfYWUc5j4CKiWXMLNvwZ5+up46phAz+y4QJP?=
 =?us-ascii?Q?MjuCIKI0u67zvahyU7kinVJ7TVa8s/EKLg1r3plWyhM0DY0pQbZB6QloHd/s?=
 =?us-ascii?Q?9DS7str9IjhS1TuWKf7WxMOPOqolbEBUI8p0SXhVkjdfZjwGoo9Hd/UwO5ZV?=
 =?us-ascii?Q?ApxHmsndp2Y80OjK6IZNq6XifAkU+tB5U/trc084b+jp15qlHCKTGwBBlXZw?=
 =?us-ascii?Q?PhFlw8E+utBEgxbs8n4bnvolmjazhStGVP//bssdTs9d38FWG4EM6qctSaV7?=
 =?us-ascii?Q?23KsFMTJlZF0Hl8L7QCxeg8Ys69MgUWvBE9ILBDo5WkdN1OSy1jYJ3mCOItu?=
 =?us-ascii?Q?B+PNc+4huPAd9HMz0NLtHOGF8yPXWN6UVxBqmw5eDdTsY4Mu3NF3PjK+RkxD?=
 =?us-ascii?Q?rL26ZiD5iEhUzkRZzqe18kWvq/p+aYF9pUVRdUNwq1Aq9/6uRG8VborukMX0?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc3e20f-5de9-46dc-585f-08d9b7eec763
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2021 12:57:22.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8P90CSvzvDyg2pTxoMRKx2+YUbNnl354fZPRrk5UECgKJFvakb7Wv+6DH/xX6mHYrVwEtbeSOFIL8qHBalY4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I found almost all the drivers under drivers/clocksource/*.c has
IRQF_IRQPOLL flag. I am not very sure what this flag used
for the drivers for ARM platforms.

I think this flag is not needed for ARM platforms, BTW I just
checked NXP i.MX driver. But not very sure, please share
your knowledge if you have time.

Thanks,
Peng.
