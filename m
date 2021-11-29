Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90385462405
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhK2WPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:15:06 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:12623
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231574AbhK2WNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:13:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+WLaRn5puUQu9zDuoyr1T0UHTsHDEiEi1dqrXjYPCwl+hkteNdVx4v03oWYm2f/1mWhPgXg7RqfLqlCPyjHiXZnkSWTdoAVX15UCjRL5JX3JPaoQ3zTWvXxE3kP2MmhxwQuiHH8YeIsLo8Z3ajaoHL5rgAP0W89aeptXzwQiJbh2wYZ8bXUHsYnSbZplyRFHQEThTrHLLnBvOfJpZaZj+iTjE9ej1cNlcHZfoVBUDE0uUsR18K/kBqCWkWx4m7tpcR7BJFWoNRhEIrGBaapIeo8xuPciH5VGgxHfQp16fOzIiJy1eEbeyAJFNnNGuG2sAqUp6SbEsYkvSsE9w1klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh3rmQJveyABk1CwbXI4a7pWhkMxW+/DxaOtchXPbro=;
 b=f1uUHdd65O3/uuKozUFvpQqMUcO1BMuzj3P+9sD+70WRwwhPa356Bl+EuHCtJ2rqw2Wd7r1IA2fsevCuVWgPfqq2HOUt8OXxAviARpbX/7l/8u9xBsZ0R6MgKlDCRMfLeIYC4iP2mxck9JxKgy9Xc5DWjZE8umxGU67QRR8TaS8nxqhTUS94SRp0BATPdQgxG3sxKtQgXQ1i0pWVZ5YRwAGJ4WLXFbZEcD+Mc5p9Q4c08gwQkJNiaXjkBH7MEXbcUhPEx0ptxzgsbEacfIrxdPPaC0b7jTOCtFh9+DnOJbQXETo8GpFY8I8vHnv4UCeBIRIAUlH6/yDnkbScd1KiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh3rmQJveyABk1CwbXI4a7pWhkMxW+/DxaOtchXPbro=;
 b=Phis5cYFjOlNDNWyhM7bklzb7gpDSs0ogJvIk6KtHZrx9DAZuqgCX9OG9B7+9UcF7s9cCxVTYDxg/sPV6udzmPHSknUOi8xfsPCpk0/Or4/PxRdRbFviIBBFiuVJ4/lldv3ziI6sU+QxZZVT80sifa2unIHxi2XtpSvj/c0e9dI=
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15)
 by VI1PR10MB3712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 22:09:40 +0000
Received: from VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d15d:7ee0:39c6:4617]) by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d15d:7ee0:39c6:4617%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 22:09:40 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 3/3] regulator: da9121: Add DA914x support
Thread-Topic: [PATCH v3 3/3] regulator: da9121: Add DA914x support
Thread-Index: AQHX4MHBCJqEhCaHZE21MkGyd5Mka6waqScAgABv0iA=
Date:   Mon, 29 Nov 2021 22:09:40 +0000
Message-ID: <VI1PR10MB3167B6C3F6CC438276C555AFEC669@VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
 <31d387d0a364eef9d5ef72f0adf6d213197a4dfb.1637709844.git.Adam.Ward.opensource@diasemi.com>
 <YaTuUS4GwZ4ON7fz@sirena.org.uk>
In-Reply-To: <YaTuUS4GwZ4ON7fz@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e803ec4-f99c-45c3-3fe4-08d9b384f0ec
x-ms-traffictypediagnostic: VI1PR10MB3712:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <VI1PR10MB37127B66E2DCA7C4A1AFD414CB669@VI1PR10MB3712.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPe3wbSf+pQYJEGaiYttfyuuRnXVA8Ztyelen2p8ataPvOmtwAcayrBxSJ0PO/9o6gqtkb9ADgu9pB986Paz2JYgpLL6vEHE4ktyOo1QwCiNcBzRp/zp7M31GKPbqGjQp0OAA44IRidnK5QzBk8BTYgHu37Yr3DigDOi6LPQ0LvBmdX7iY/Tc/uXkcOSA2K9FuUs7VZEQDS7qtNfg4YZdBSbqRq5oBsg0GkUoZTA/k8chzq/FV7deTv97COXyPj8oBVQa90tRNCoPvuutrkOsUZbOq1OkRsA08ECb5zMbZRnMtnKeDZudNqYu7kSPP/relM+xb0yBCR0aDXWF93kE/L1d4fgruR8Dy0T9BAYDqj8+mAOpgBRNmOvDIk6qa5QgkeFZN3PZdrmhSJDT3muEMjyr+0iZE7DRcC1WFK8dEP2mtSMSCHAuPuHhX4ybVtKIydiRuR/gWlv3uhNrv5ojaSXstm+VXi6dW6cYWH3I6uU1hPLeV5LutY42Cb2pKtqgtVRSGCpsSgHw7vKorrH14abZkI0aqVhnVkWApyinrGvSKA0q5r6/IgA7seVFtKzB1w7N9AuAwaMC/D4MD7oILOrDM5c4y/0EwSSayIlpMMvhVFdn1YX4xKrKqNiyFGqyBf3Oi2PSbQ4MG9VYDZydRriPhenOKs2F882XTz1JhRQ9Vnc2WhgygvuZuJOm/IU6aLbLXzRhk3hGmy9N7Qbtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(55236004)(55016003)(6506007)(4326008)(122000001)(8676002)(38100700002)(316002)(2906002)(107886003)(110136005)(54906003)(33656002)(38070700005)(26005)(52536014)(186003)(76116006)(71200400001)(66946007)(5660300002)(558084003)(66446008)(7696005)(66476007)(66556008)(9686003)(86362001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EmbxZzzD722mrxPKV+fmfYBKGSa1fXys/dXH/1np2Pn9kaXDVfoC5aMbie1/?=
 =?us-ascii?Q?ZxIstgdntmqp2O9I3wYzYUHRK/H4NZ1kiNaeOXse7d30S+pukJ2a5t/a4F5C?=
 =?us-ascii?Q?zfdNgzaBguPTYaj5lZA7UVb+L1wFoyWrxbWbqYM4vCOgAB65e1Sck90HWyCK?=
 =?us-ascii?Q?J+pNjWZIxROGgMvUlQ6VIDXVfqYVe5+g+/ybsEzLUBwlJZi38o/yhAnhxSk/?=
 =?us-ascii?Q?l+BAUMgJ3X6GNdG6uhGEzUBypSksQ3E0GjsQ9m+JNngPpihUO49v7YqmOalZ?=
 =?us-ascii?Q?kWzkx4lA8D65retcUDweuUxNnnf4irRJ5LpXudp6BLbJTndrmtPdrcopJQQ9?=
 =?us-ascii?Q?PlrqcgS86LuMjSMSzDDavHbezoa1swUbI7931GWUUQlKqVQVuiENGcxmx6F6?=
 =?us-ascii?Q?fYoohO8ZxMI2DoiInBb+rs8C1e/wSIv6/jsElrL1PWJ+qkQXLatC8QQ2jPJP?=
 =?us-ascii?Q?rKvCB1uV+6D9cjxGprOf9ErZHNsJyKmF2sXMHKvIPP6Jvomu8ReGq6vtXs/V?=
 =?us-ascii?Q?kZfLhmUjoPiKT5Z1Q7NkbtD1yeZWqSv5uKHOdtGQoKwwgLOlmw3thu/xLCbj?=
 =?us-ascii?Q?Qq7NGWrk7Oloz2mw+NvNi3lW3+6DxJNBEDonKOMBen7r5HdL3ZGdK0h3RxN/?=
 =?us-ascii?Q?x6/wLNHJuB0Skf0tFlP4n2DeVtzMHDBTb8OBf2wqZ1fiPWQS3ojAkgr+FIm4?=
 =?us-ascii?Q?/3UV3wL366N5QWLgpqqRneVxJw45V9uu9Z3lHFXx4VYxxJouU6wHs+LSd4ST?=
 =?us-ascii?Q?O/B6BCv0nAacJTM3krl4HDZkSPTr3FPSyfWg6aALpoEjMSHLhWjHWrV+kchQ?=
 =?us-ascii?Q?6BcWQRnKwjCKMj1X3HPHbM8+zUebJRXGTe18I8ACONGp3bUuVPbgd0L4VzNx?=
 =?us-ascii?Q?NQ9llq/R+ZZjOjUlKrUxu3MEal5jxzaKUpkwFg9xq1t1KCUDHhHCPJBi24z2?=
 =?us-ascii?Q?8YAnn0zOmagfaq/v6SDjg8CZenHOGgnNh5kMPHCC0ljyDppu3YiGatr71oFg?=
 =?us-ascii?Q?w4jNHQEBulOZ3kFg1Ivpx+YX4dt8LsbH470Azoce9wpIQpP6dxj7VOvwm5fh?=
 =?us-ascii?Q?KNgweRCU9vEEUJIBc/FAN6V+Kq3HZk9fCRr4HR1eKsX02yDwMnXBfMAuCwZd?=
 =?us-ascii?Q?aC0fLGo3bHbkYcvGLgMjTX6bDu73Q1vboQNBLkfyl3v9n9r0/PK0cNwv79Cm?=
 =?us-ascii?Q?AuP5wM1tKRN6L3ZYKb6fwJ8zHffDhjuOoPvsxhnmSIQPJw0Mb3C6ToWWocWI?=
 =?us-ascii?Q?Kz9yUEO27ANkm9Dmld7YZCrMGUO16TX28paihmE/Tj05CxQHVDyRbkkuGg46?=
 =?us-ascii?Q?Ac1TWnfBPbciLa7wxY+r0YPKojO8ImKQHrmcWszCvn5nHoolmzHzlAR7lSMY?=
 =?us-ascii?Q?zk0MZYR+tBPoul7Bv/Ff9I3Q98ytO0PbaFoNGjqZga2gEYH06RdM3zVGMm1l?=
 =?us-ascii?Q?XxK0aeZZYnx4puVGkoLWTIHm4YoIaVURyMhhgwaSl3CxyuIGTj+pIk1nWdkn?=
 =?us-ascii?Q?5adfeI+ffWWFaYIAqYc72ocPe9ng/HS75aTW2miLzxqn8h7NPzcKpYFYRjXO?=
 =?us-ascii?Q?thYC85EzTvn7vUg7mlr8wPJkEily9o/Fm9EXfnqAtZhSZYcMP/Z1/6E8+3WG?=
 =?us-ascii?Q?x82pA79o6SBfw8IYE99Q6wU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e803ec4-f99c-45c3-3fe4-08d9b384f0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 22:09:40.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejLRBasMeuChuMng9bqbD+gbh/bTdPxywMy8bhqY+np7sr/NKlBVPBh7vKqWoJDJAe7Cad10rZqetbt6lgWEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3712
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tues, Nov 29, 2021 at 15:25, Mark Brown wrote:
> This doesn't build:
Apologies for this
